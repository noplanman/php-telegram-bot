#!/usr/bin/env bash

# Requires:
# - jq (https://github.com/stedolan/jq/)
# - php-mysql-diff (https://github.com/camcima/php-mysql-diff)
#   $ composer global require camcima/php-mysql-diff
#   # Then, make sure you have ~/.composer/vendor/bin in your PATH, and you're good to go:
#   $ export PATH="$PATH:$HOME/.composer/vendor/bin"
#
# For DB connection, export these environment variables (with your credentials):
# $ export TG_DB_HOST="127.0.0.1"
# $ export TG_DB_NAME="tmp"       # Note, this MUST be a temporary DB, as it will get dropped!
# $ export TG_DB_USER="root"
# $ export TG_DB_PASS="root"

_required_commands() {
    for CMD in ${1}; do
        if ! which "${CMD}" >/dev/null 2>&1; then
            echo "❌  Command '${CMD}' not found! (check requirements)"
            exit 1
        fi
    done
}
_required_commands "mysql mysqldump php-mysql-diff jq"


if [ -z "${TG_DB_HOST}" ] || [ -z "${TG_DB_NAME}" ] || [ -z "${TG_DB_USER}" ]; then
    echo "❌  Couldn't find MySQL database connection details."
    exit 1
fi

if ! mysql -h "${TG_DB_HOST}" -u "${TG_DB_USER}" -p"${TG_DB_PASS}" -e "exit" 2>/dev/null; then
    echo "❌  Couldn't connect to MySQL database."
    exit 1
fi

# Load all tags from github.
VERSIONS="$(curl "https://api.github.com/repos/akalongman/php-telegram-bot/tags?per_page=100" 2>/dev/null | jq -r '[reverse [].name]|join(" ")')"

# Ignore versions before 0.16.0, which can be disregarded for upgrades.
IGNORE_BEFORE="0.16.0"

# Remember the last identical version, to prevent potentially duplicate migrations.
LAST=""

# Set up required folders.
mkdir -p structure diff export migration

for THIS in ${VERSIONS}; do
  if [ "${IGNORE_BEFORE}" ] && [[ "${THIS}" != "${IGNORE_BEFORE}" ]]; then
    continue
  fi
  unset IGNORE_BEFORE

  if [[ "${LAST}" == "" ]]; then
    LAST="${THIS}"
  fi

  # Fetch structure.sql for current version, if not fetched yet.
  if [ ! -f "structure/${THIS}.sql" ]; then
    URL="https://raw.githubusercontent.com/akalongman/php-telegram-bot/${THIS}/structure.sql"
    if [[ "200" != "$(curl -s -I -w "%{http_code}" -o /dev/null "${URL}")" ]]; then
      continue
    fi
    echo "$(curl "${URL}" 2>/dev/null | sed "s/\\\\'/''/g")" > "structure/${THIS}.sql"
  fi

  # Skip any version that produces errors.
  if ! mysql -h "${TG_DB_HOST}" -u "${TG_DB_USER}" -p"${TG_DB_PASS}" -e "drop database if exists ${TG_DB_NAME}; create database ${TG_DB_NAME}; use ${TG_DB_NAME}; source structure/${THIS}.sql;" 2>/dev/null; then
    echo "❌  Failed to load SQL for version ${THIS}"
    continue
  fi

  if ! mysqldump -h "${TG_DB_HOST}" -u "${TG_DB_USER}" -p"${TG_DB_PASS}" --no-create-db --no-data --compact --databases "${TG_DB_NAME}" 2>/dev/null > "export/${THIS}.sql"; then
    echo "❌  Failed to dump SQL for version ${THIS}"
    continue
  fi

    # Skip the first run.
  if [[ "${LAST}" == "${THIS}" ]]; then
    continue
  fi

  THIS_FILE="export/${THIS}.sql"
  LAST_FILE="export/${LAST}.sql"

  DIFF="$(diff "${LAST_FILE}" "${THIS_FILE}")"
  if [[ "${DIFF}" != "" ]]; then
    echo "${LAST} -> ${THIS}"
    echo "${DIFF}" > "diff/${LAST}-${THIS}.diff"

    S="✅"
    if ! php-mysql-diff migrate -o "migration/${LAST}-${THIS}.sql" "${LAST_FILE}" "${THIS_FILE}" &>/dev/null; then
      S="❌"
    fi

    tput cuu 1 && tput el
    echo "$S  ${LAST} -> ${THIS}"

    LAST="${THIS}"
  fi
done
