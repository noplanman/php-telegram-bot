# Disable Foreign Keys Check
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = '';

# Deleted Tables

# Changed Tables

-- changed table `chosen_inline_query`

ALTER TABLE `chosen_inline_query`
  ADD COLUMN `location` char(255) DEFAULT NULL COMMENT 'Location object, senders''s location.' AFTER `user_id`,
  ADD COLUMN `inline_message_id` char(255) DEFAULT NULL COMMENT 'Identifier of the message sent via the bot in inline mode, that originated the query' AFTER `location`,
  CHANGE COLUMN `query` `query` char(255) NOT NULL DEFAULT '' COMMENT 'Text of the query' AFTER `inline_message_id`,
  CHANGE COLUMN `created_at` `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation' AFTER `query`;

-- changed table `inline_query`

ALTER TABLE `inline_query`
  ADD COLUMN `location` char(255) DEFAULT NULL COMMENT 'Location of the sender' AFTER `user_id`,
  CHANGE COLUMN `query` `query` char(255) NOT NULL DEFAULT '' COMMENT 'Text of the query' AFTER `location`,
  CHANGE COLUMN `offset` `offset` char(255) NOT NULL DEFAULT '' COMMENT 'Offset of the result' AFTER `query`,
  CHANGE COLUMN `created_at` `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation' AFTER `offset`;

-- changed table `message`

ALTER TABLE `message`
  DROP FOREIGN KEY `message_ibfk_6`,
  DROP FOREIGN KEY `message_ibfk_7`;

ALTER TABLE `message`
  DROP INDEX `left_chat_participant`,
  DROP INDEX `new_chat_participant`,
  DROP COLUMN `new_chat_participant`,
  DROP COLUMN `left_chat_participant`,
  ADD COLUMN `entities` text COMMENT 'For text messages, special entities like usernames, URLs, bot commands, etc. that appear in the text' AFTER `text`,
  CHANGE COLUMN `audio` `audio` text COMMENT 'Audio object. Message is an audio file, information about the file' AFTER `entities`,
  CHANGE COLUMN `document` `document` text COMMENT 'Document object. Message is a general file, information about the file' AFTER `audio`,
  CHANGE COLUMN `photo` `photo` text COMMENT 'Array of PhotoSize objects. Message is a photo, available sizes of the photo' AFTER `document`,
  CHANGE COLUMN `sticker` `sticker` text COMMENT 'Sticker object. Message is a sticker, information about the sticker' AFTER `photo`,
  CHANGE COLUMN `video` `video` text COMMENT 'Video object. Message is a video, information about the video' AFTER `sticker`,
  CHANGE COLUMN `voice` `voice` text COMMENT 'Voice Object. Message is a Voice, information about the Voice' AFTER `video`,
  CHANGE COLUMN `caption` `caption` text COMMENT 'For message with caption, the actual UTF-8 text of the caption' AFTER `voice`,
  CHANGE COLUMN `contact` `contact` text COMMENT 'Contact object. Message is a shared contact, information about the contact' AFTER `caption`,
  CHANGE COLUMN `location` `location` text COMMENT 'Location object. Message is a shared location, information about the location' AFTER `contact`,
  ADD COLUMN `venue` text COMMENT 'Venue object. Message is a Venue, information about the Venue' AFTER `location`,
  ADD COLUMN `new_chat_member` bigint(20) DEFAULT NULL COMMENT 'User id. A new member was added to the group, information about them (this member may be bot itself)' AFTER `venue`,
  ADD COLUMN `left_chat_member` bigint(20) DEFAULT NULL COMMENT 'User id. A member was removed from the group, information about them (this member may be bot itself)' AFTER `new_chat_member`,
  CHANGE COLUMN `new_chat_title` `new_chat_title` char(255) DEFAULT NULL COMMENT 'A group title was changed to this value' AFTER `left_chat_member`,
  CHANGE COLUMN `new_chat_photo` `new_chat_photo` text COMMENT 'Array of PhotoSize objects. A group photo was change to this value' AFTER `new_chat_title`,
  CHANGE COLUMN `delete_chat_photo` `delete_chat_photo` tinyint(1) DEFAULT '0' COMMENT 'Informs that the group photo was deleted' AFTER `new_chat_photo`,
  CHANGE COLUMN `group_chat_created` `group_chat_created` tinyint(1) DEFAULT '0' COMMENT 'Informs that the group has been created' AFTER `delete_chat_photo`,
  CHANGE COLUMN `supergroup_chat_created` `supergroup_chat_created` tinyint(1) DEFAULT '0' COMMENT 'Informs that the supergroup has been created' AFTER `group_chat_created`,
  CHANGE COLUMN `channel_chat_created` `channel_chat_created` tinyint(1) DEFAULT '0' COMMENT 'Informs that the channel chat has been created' AFTER `supergroup_chat_created`,
  CHANGE COLUMN `migrate_from_chat_id` `migrate_from_chat_id` bigint(20) DEFAULT NULL COMMENT 'Migrate from chat identifier.' AFTER `channel_chat_created`,
  CHANGE COLUMN `migrate_to_chat_id` `migrate_to_chat_id` bigint(20) DEFAULT NULL COMMENT 'Migrate to chat identifier.' AFTER `migrate_from_chat_id`,
  ADD COLUMN `pinned_message` text COMMENT 'Pinned message, Message object.' AFTER `migrate_to_chat_id`,
  ADD KEY `left_chat_member` (`left_chat_member`),
  ADD KEY `new_chat_member` (`new_chat_member`),
  ADD CONSTRAINT `message_ibfk_6` FOREIGN KEY (`new_chat_member`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `message_ibfk_7` FOREIGN KEY (`left_chat_member`) REFERENCES `user` (`id`);

-- changed table `telegram_update`

ALTER TABLE `telegram_update`
  CHANGE COLUMN `inline_query_id` `inline_query_id` bigint(20) unsigned DEFAULT NULL COMMENT 'The inline query unique identifier.' AFTER `message_id`,
  ADD COLUMN `callback_query_id` bigint(20) unsigned DEFAULT NULL COMMENT 'The callback query unique identifier.' AFTER `chosen_inline_query_id`,
  ADD KEY `callback_query_id` (`callback_query_id`),
  ADD CONSTRAINT `telegram_update_ibfk_4` FOREIGN KEY (`callback_query_id`) REFERENCES `callback_query` (`id`);

# New Tables

-- new table `callback_query`

CREATE TABLE `callback_query` (
  `id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Unique identifier for this query.',
  `user_id` bigint(20) DEFAULT NULL COMMENT 'Sender',
  `message` text COMMENT 'Message',
  `inline_message_id` char(255) DEFAULT NULL COMMENT 'Identifier of the message sent via the bot in inline mode, that originated the query',
  `data` char(255) NOT NULL DEFAULT '' COMMENT 'Data associated with the callback button.',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `callback_query_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Disable Foreign Keys Check
SET FOREIGN_KEY_CHECKS = 1;
