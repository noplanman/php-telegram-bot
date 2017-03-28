# Disable Foreign Keys Check
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = '';

# Deleted Tables

# Changed Tables

# New Tables

-- new table `conversation`

CREATE TABLE `conversation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Row unique id',
  `user_id` bigint(20) DEFAULT NULL COMMENT 'User id',
  `chat_id` bigint(20) DEFAULT NULL COMMENT 'Telegram chat_id can be a the user id or the chat id ',
  `status` enum('active','cancelled','stopped') NOT NULL DEFAULT 'active' COMMENT 'active conversation is active, cancelled conversation has been truncated before end, stopped conversation has end',
  `command` varchar(160) DEFAULT '' COMMENT 'Default Command to execute',
  `notes` varchar(1000) DEFAULT 'NULL' COMMENT 'Data stored from command',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `chat_id` (`chat_id`),
  KEY `status` (`status`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `conversation_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `conversation_ibfk_2` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Disable Foreign Keys Check
SET FOREIGN_KEY_CHECKS = 1;
