# Disable Foreign Keys Check
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = '';

# Deleted Tables

# Changed Tables

-- changed table `chats`

ALTER TABLE `chats`
  ADD COLUMN `type` char(10) DEFAULT '' COMMENT 'chat type private groupe or channel' AFTER `id`,
  CHANGE COLUMN `title` `title` char(255) DEFAULT '' COMMENT 'chat title null if case of single chat with the bot' AFTER `type`,
  CHANGE COLUMN `created_at` `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Entry date creation' AFTER `title`,
  CHANGE COLUMN `updated_at` `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Entry date update' AFTER `created_at`;

# New Tables

# Disable Foreign Keys Check
SET FOREIGN_KEY_CHECKS = 1;
