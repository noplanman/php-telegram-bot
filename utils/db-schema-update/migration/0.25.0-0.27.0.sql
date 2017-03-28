# Disable Foreign Keys Check
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = '';

# Rename Tables

RENAME TABLE `chats` TO `chat`;
RENAME TABLE `messages` TO `message`;
RENAME TABLE `users` TO `user`;
RENAME TABLE `users_chats` TO `user_chat`;

# Deleted Tables

# Changed Tables

-- changed table `chat`

ALTER TABLE `chat`
  CHANGE COLUMN `created_at` `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation' AFTER `title`,
  CHANGE COLUMN `updated_at` `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date update' AFTER `created_at`,
  CHANGE COLUMN `old_id` `old_id` bigint(20) DEFAULT NULL COMMENT 'Unique chat identifieri this is filled when a chat is converted to a superchat' AFTER `updated_at`;

-- changed table `message`

ALTER TABLE `message`
  DROP PRIMARY KEY,
  DROP COLUMN `message_id`,
  DROP COLUMN `update_id`,
  ADD COLUMN `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique message identifier' FIRST,
  ADD PRIMARY KEY (`id`);

ALTER TABLE `message`
  CHANGE COLUMN `user_id` `user_id` bigint(20) DEFAULT NULL COMMENT 'User identifier' AFTER `id`,
  CHANGE COLUMN `chat_id` `chat_id` bigint(20) DEFAULT NULL COMMENT 'Chat identifier.' AFTER `user_id`,
  CHANGE COLUMN `date` `date` timestamp NULL DEFAULT NULL COMMENT 'Date the message was sent in timestamp format' AFTER `chat_id`,
  CHANGE COLUMN `forward_from` `forward_from` bigint(20) DEFAULT NULL COMMENT 'User id. For forwarded messages, sender of the original message' AFTER `date`,
  CHANGE COLUMN `forward_date` `forward_date` timestamp NULL DEFAULT NULL COMMENT 'For forwarded messages, date the original message was sent in Unix time' AFTER `forward_from`,
  CHANGE COLUMN `reply_to_message` `reply_to_message` bigint(20) unsigned DEFAULT NULL COMMENT 'Message is a reply to another message.' AFTER `forward_date`,
  CHANGE COLUMN `text` `text` text COMMENT 'For text messages, the actual UTF-8 text of the message max message length 4096 char utf8' AFTER `reply_to_message`,
  CHANGE COLUMN `audio` `audio` text COMMENT 'Audio object. Message is an audio file, information about the file' AFTER `text`,
  CHANGE COLUMN `document` `document` text COMMENT 'Document object. Message is a general file, information about the file' AFTER `audio`,
  CHANGE COLUMN `photo` `photo` text COMMENT 'Array of PhotoSize objects. Message is a photo, available sizes of the photo' AFTER `document`,
  CHANGE COLUMN `sticker` `sticker` text COMMENT 'Sticker object. Message is a sticker, information about the sticker' AFTER `photo`,
  CHANGE COLUMN `video` `video` text COMMENT 'Video object. Message is a video, information about the video' AFTER `sticker`,
  CHANGE COLUMN `voice` `voice` text COMMENT 'Voice Object. Message is a Voice, information about the Voice' AFTER `video`,
  CHANGE COLUMN `caption` `caption` text COMMENT 'For message with caption, the actual UTF-8 text of the caption' AFTER `voice`,
  CHANGE COLUMN `contact` `contact` text COMMENT 'Contact object. Message is a shared contact, information about the contact' AFTER `caption`,
  CHANGE COLUMN `location` `location` text COMMENT 'Location object. Message is a shared location, information about the location' AFTER `contact`,
  CHANGE COLUMN `new_chat_participant` `new_chat_participant` bigint(20) DEFAULT NULL COMMENT 'User id. A new member was added to the group, information about them (this member may be bot itself)' AFTER `location`,
  CHANGE COLUMN `left_chat_participant` `left_chat_participant` bigint(20) DEFAULT NULL COMMENT 'User id. A member was removed from the group, information about them (this member may be bot itself)' AFTER `new_chat_participant`,
  CHANGE COLUMN `new_chat_title` `new_chat_title` char(255) DEFAULT NULL COMMENT 'A group title was changed to this value' AFTER `left_chat_participant`,
  CHANGE COLUMN `new_chat_photo` `new_chat_photo` text COMMENT 'Array of PhotoSize objects. A group photo was change to this value' AFTER `new_chat_title`,
  CHANGE COLUMN `delete_chat_photo` `delete_chat_photo` tinyint(1) DEFAULT '0' COMMENT 'Informs that the group photo was deleted' AFTER `new_chat_photo`,
  CHANGE COLUMN `group_chat_created` `group_chat_created` tinyint(1) DEFAULT '0' COMMENT 'Informs that the group has been created' AFTER `delete_chat_photo`,
  CHANGE COLUMN `supergroup_chat_created` `supergroup_chat_created` tinyint(1) DEFAULT '0' COMMENT 'Informs that the supergroup has been created' AFTER `group_chat_created`,
  CHANGE COLUMN `channel_chat_created` `channel_chat_created` tinyint(1) DEFAULT '0' COMMENT 'Informs that the channel chat has been created' AFTER `supergroup_chat_created`,
  CHANGE COLUMN `migrate_from_chat_id` `migrate_from_chat_id` bigint(20) DEFAULT NULL COMMENT 'Migrate from chat identifier.' AFTER `channel_chat_created`,
  CHANGE COLUMN `migrate_to_chat_id` `migrate_to_chat_id` bigint(20) DEFAULT NULL COMMENT 'Migrate to chat identifier.' AFTER `migrate_from_chat_id`,
  ADD KEY `forward_from` (`forward_from`),
  ADD KEY `left_chat_participant` (`left_chat_participant`),
  ADD KEY `migrate_from_chat_id` (`migrate_from_chat_id`),
  ADD KEY `migrate_to_chat_id` (`migrate_to_chat_id`),
  ADD KEY `new_chat_participant` (`new_chat_participant`),
  ADD KEY `reply_to_message` (`reply_to_message`),
  ADD CONSTRAINT `message_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `message_ibfk_2` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`),
  ADD CONSTRAINT `message_ibfk_3` FOREIGN KEY (`forward_from`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `message_ibfk_4` FOREIGN KEY (`reply_to_message`) REFERENCES `message` (`id`),
  ADD CONSTRAINT `message_ibfk_5` FOREIGN KEY (`forward_from`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `message_ibfk_6` FOREIGN KEY (`new_chat_participant`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `message_ibfk_7` FOREIGN KEY (`left_chat_participant`) REFERENCES `user` (`id`);

-- changed table `user`

ALTER TABLE `user`
  CHANGE COLUMN `last_name` `last_name` char(255) DEFAULT NULL COMMENT 'User last name' AFTER `first_name`,
  CHANGE COLUMN `username` `username` char(255) DEFAULT NULL COMMENT 'User username' AFTER `last_name`,
  CHANGE COLUMN `created_at` `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation' AFTER `username`,
  CHANGE COLUMN `updated_at` `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date update' AFTER `created_at`;

# New Tables

-- new table `chosen_inline_query`

CREATE TABLE `chosen_inline_query` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for chosen query.',
  `result_id` char(255) NOT NULL DEFAULT '' COMMENT 'Id of the chosen result',
  `user_id` bigint(20) DEFAULT NULL COMMENT 'Sender',
  `query` char(255) NOT NULL DEFAULT '' COMMENT 'Text of the query',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `chosen_inline_query_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- new table `inline_query`

CREATE TABLE `inline_query` (
  `id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Unique identifier for this query.',
  `user_id` bigint(20) DEFAULT NULL COMMENT 'Sender',
  `query` char(255) NOT NULL DEFAULT '' COMMENT 'Text of the query',
  `offset` char(255) NOT NULL DEFAULT '' COMMENT 'Offset of the result',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `inline_query_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- new table `telegram_update`

CREATE TABLE `telegram_update` (
  `id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'The update''s unique identifier.',
  `message_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Unique message identifier',
  `inline_query_id` bigint(20) unsigned DEFAULT NULL COMMENT 'The query unique identifier.',
  `chosen_inline_query_id` bigint(20) unsigned DEFAULT NULL COMMENT 'The chosen query unique identifier.',
  PRIMARY KEY (`id`),
  KEY `chosen_inline_query_id` (`chosen_inline_query_id`),
  KEY `inline_query_id` (`inline_query_id`),
  KEY `message_id` (`message_id`),
  CONSTRAINT `telegram_update_ibfk_1` FOREIGN KEY (`message_id`) REFERENCES `message` (`id`),
  CONSTRAINT `telegram_update_ibfk_2` FOREIGN KEY (`inline_query_id`) REFERENCES `inline_query` (`id`),
  CONSTRAINT `telegram_update_ibfk_3` FOREIGN KEY (`chosen_inline_query_id`) REFERENCES `chosen_inline_query` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Disable Foreign Keys Check
SET FOREIGN_KEY_CHECKS = 1;
