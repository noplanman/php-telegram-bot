# Disable Foreign Keys Check
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = '';

# Deleted Tables

# Changed Tables

-- changed table `callback_query`

ALTER TABLE `callback_query`
  DROP COLUMN `message`,
  ADD COLUMN `chat_id` bigint(20) DEFAULT NULL COMMENT 'Unique chat identifier' AFTER `user_id`,
  ADD COLUMN `message_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Unique message identifier' AFTER `chat_id`,
  CHANGE COLUMN `inline_message_id` `inline_message_id` char(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL COMMENT 'Identifier of the message sent via the bot in inline mode, that originated the query' AFTER `message_id`,
  CHANGE COLUMN `data` `data` char(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '' COMMENT 'Data associated with the callback button' AFTER `inline_message_id`,
  CHANGE COLUMN `created_at` `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation' AFTER `data`,
  ADD KEY `chat_id` (`chat_id`),
  ADD KEY `chat_id_2` (`chat_id`,`message_id`),
  ADD KEY `message_id` (`message_id`);

# New Tables

# Disable Foreign Keys Check
SET FOREIGN_KEY_CHECKS = 1;
