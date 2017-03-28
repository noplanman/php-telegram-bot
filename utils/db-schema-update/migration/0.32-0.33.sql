# Disable Foreign Keys Check
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = '';

# Rename Tables

RENAME TABLE `chosen_inline_query` TO `chosen_inline_result`;

# Deleted Tables

# Changed Tables

-- changed table `callback_query`

ALTER TABLE `callback_query`
  CHANGE COLUMN `id` `id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Unique identifier for this query' FIRST,
  CHANGE COLUMN `user_id` `user_id` bigint(20) DEFAULT NULL COMMENT 'Unique user identifier' AFTER `id`,
  CHANGE COLUMN `message` `message` text COLLATE utf8mb4_unicode_520_ci COMMENT 'Message with the callback button that originated the query' AFTER `user_id`,
  CHANGE COLUMN `inline_message_id` `inline_message_id` char(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL COMMENT 'Identifier of the message sent via the bot in inline mode, that originated the query' AFTER `message`,
  CHANGE COLUMN `data` `data` char(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '' COMMENT 'Data associated with the callback button' AFTER `inline_message_id`;

-- changed table `chat`

ALTER TABLE `chat`
  CHANGE COLUMN `type` `type` enum('private','group','supergroup','channel') COLLATE utf8mb4_unicode_520_ci NOT NULL COMMENT 'Chat type, either private, group, supergroup or channel' AFTER `id`,
  CHANGE COLUMN `title` `title` char(255) COLLATE utf8mb4_unicode_520_ci DEFAULT '' COMMENT 'Chat (group) title, is null if chat type is private' AFTER `type`,
  CHANGE COLUMN `old_id` `old_id` bigint(20) DEFAULT NULL COMMENT 'Unique chat identifier, this is filled when a group is converted to a supergroup' AFTER `updated_at`;

-- changed table `chosen_inline_result`

ALTER TABLE `chosen_inline_result`
  CHANGE COLUMN `id` `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for this entry' FIRST,
  CHANGE COLUMN `result_id` `result_id` char(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '' COMMENT 'Identifier for this result' AFTER `id`,
  CHANGE COLUMN `user_id` `user_id` bigint(20) DEFAULT NULL COMMENT 'Unique user identifier' AFTER `result_id`,
  CHANGE COLUMN `location` `location` char(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL COMMENT 'Location object, user''s location' AFTER `user_id`,
  CHANGE COLUMN `inline_message_id` `inline_message_id` char(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL COMMENT 'Identifier of the sent inline message' AFTER `location`,
  CHANGE COLUMN `query` `query` text COLLATE utf8mb4_unicode_520_ci NOT NULL COMMENT 'The query that was used to obtain the result' AFTER `inline_message_id`;

-- changed table `conversation`

ALTER TABLE `conversation`
  CHANGE COLUMN `id` `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for this entry' FIRST,
  CHANGE COLUMN `user_id` `user_id` bigint(20) DEFAULT NULL COMMENT 'Unique user identifier' AFTER `id`,
  CHANGE COLUMN `chat_id` `chat_id` bigint(20) DEFAULT NULL COMMENT 'Unique user or chat identifier' AFTER `user_id`,
  CHANGE COLUMN `status` `status` enum('active','cancelled','stopped') COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'active' COMMENT 'Conversation state' AFTER `chat_id`,
  CHANGE COLUMN `command` `command` varchar(160) COLLATE utf8mb4_unicode_520_ci DEFAULT '' COMMENT 'Default command to execute' AFTER `status`,
  CHANGE COLUMN `notes` `notes` varchar(1000) COLLATE utf8mb4_unicode_520_ci DEFAULT 'NULL' COMMENT 'Data stored from command' AFTER `command`;

-- changed table `inline_query`

ALTER TABLE `inline_query`
  CHANGE COLUMN `id` `id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Unique identifier for this query' FIRST,
  CHANGE COLUMN `user_id` `user_id` bigint(20) DEFAULT NULL COMMENT 'Unique user identifier' AFTER `id`,
  CHANGE COLUMN `location` `location` char(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL COMMENT 'Location of the user' AFTER `user_id`,
  CHANGE COLUMN `query` `query` text COLLATE utf8mb4_unicode_520_ci NOT NULL COMMENT 'Text of the query' AFTER `location`,
  CHANGE COLUMN `offset` `offset` char(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL COMMENT 'Offset of the result' AFTER `query`;

-- changed table `message`

ALTER TABLE `message`
  CHANGE COLUMN `chat_id` `chat_id` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Unique chat identifier' FIRST,
  CHANGE COLUMN `user_id` `user_id` bigint(20) DEFAULT NULL COMMENT 'Unique user identifier' AFTER `id`,
  CHANGE COLUMN `forward_from` `forward_from` bigint(20) DEFAULT NULL COMMENT 'Unique user identifier, sender of the original message' AFTER `date`,
  CHANGE COLUMN `forward_from_chat` `forward_from_chat` bigint(20) DEFAULT NULL COMMENT 'Unique chat identifier, chat the original message belongs to' AFTER `forward_from`,
  CHANGE COLUMN `forward_date` `forward_date` timestamp NULL DEFAULT NULL COMMENT 'date the original message was sent in timestamp format' AFTER `forward_from_chat`,
  CHANGE COLUMN `reply_to_chat` `reply_to_chat` bigint(20) DEFAULT NULL COMMENT 'Unique chat identifier' AFTER `forward_date`,
  CHANGE COLUMN `reply_to_message` `reply_to_message` bigint(20) unsigned DEFAULT NULL COMMENT 'Message that this message is reply to' AFTER `reply_to_chat`,
  CHANGE COLUMN `text` `text` text COLLATE utf8mb4_unicode_520_ci COMMENT 'For text messages, the actual UTF-8 text of the message max message length 4096 char utf8mb4' AFTER `reply_to_message`,
  CHANGE COLUMN `entities` `entities` text COLLATE utf8mb4_unicode_520_ci COMMENT 'For text messages, special entities like usernames, URLs, bot commands, etc. that appear in the text' AFTER `text`,
  CHANGE COLUMN `audio` `audio` text COLLATE utf8mb4_unicode_520_ci COMMENT 'Audio object. Message is an audio file, information about the file' AFTER `entities`,
  CHANGE COLUMN `document` `document` text COLLATE utf8mb4_unicode_520_ci COMMENT 'Document object. Message is a general file, information about the file' AFTER `audio`,
  CHANGE COLUMN `photo` `photo` text COLLATE utf8mb4_unicode_520_ci COMMENT 'Array of PhotoSize objects. Message is a photo, available sizes of the photo' AFTER `document`,
  CHANGE COLUMN `sticker` `sticker` text COLLATE utf8mb4_unicode_520_ci COMMENT 'Sticker object. Message is a sticker, information about the sticker' AFTER `photo`,
  CHANGE COLUMN `video` `video` text COLLATE utf8mb4_unicode_520_ci COMMENT 'Video object. Message is a video, information about the video' AFTER `sticker`,
  CHANGE COLUMN `voice` `voice` text COLLATE utf8mb4_unicode_520_ci COMMENT 'Voice Object. Message is a Voice, information about the Voice' AFTER `video`,
  CHANGE COLUMN `contact` `contact` text COLLATE utf8mb4_unicode_520_ci COMMENT 'Contact object. Message is a shared contact, information about the contact' AFTER `voice`,
  CHANGE COLUMN `location` `location` text COLLATE utf8mb4_unicode_520_ci COMMENT 'Location object. Message is a shared location, information about the location' AFTER `contact`,
  CHANGE COLUMN `venue` `venue` text COLLATE utf8mb4_unicode_520_ci COMMENT 'Venue object. Message is a Venue, information about the Venue' AFTER `location`,
  CHANGE COLUMN `caption` `caption` text COLLATE utf8mb4_unicode_520_ci COMMENT 'For message with caption, the actual UTF-8 text of the caption' AFTER `venue`,
  CHANGE COLUMN `new_chat_member` `new_chat_member` bigint(20) DEFAULT NULL COMMENT 'Unique user identifier, a new member was added to the group, information about them (this member may be bot itself)' AFTER `caption`,
  CHANGE COLUMN `left_chat_member` `left_chat_member` bigint(20) DEFAULT NULL COMMENT 'Unique user identifier, a member was removed from the group, information about them (this member may be bot itself)' AFTER `new_chat_member`,
  CHANGE COLUMN `new_chat_title` `new_chat_title` char(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL COMMENT 'A chat title was changed to this value' AFTER `left_chat_member`,
  CHANGE COLUMN `new_chat_photo` `new_chat_photo` text COLLATE utf8mb4_unicode_520_ci COMMENT 'Array of PhotoSize objects. A chat photo was change to this value' AFTER `new_chat_title`,
  CHANGE COLUMN `delete_chat_photo` `delete_chat_photo` tinyint(1) DEFAULT '0' COMMENT 'Informs that the chat photo was deleted' AFTER `new_chat_photo`,
  CHANGE COLUMN `migrate_to_chat_id` `migrate_to_chat_id` bigint(20) DEFAULT NULL COMMENT 'Migrate to chat identifier. The group has been migrated to a supergroup with the specified identifie' AFTER `channel_chat_created`,
  CHANGE COLUMN `migrate_from_chat_id` `migrate_from_chat_id` bigint(20) DEFAULT NULL COMMENT 'Migrate from chat identifier. The supergroup has been migrated from a group with the specified identifier' AFTER `migrate_to_chat_id`,
  CHANGE COLUMN `pinned_message` `pinned_message` text COLLATE utf8mb4_unicode_520_ci COMMENT 'Message object. Specified message was pinned' AFTER `migrate_from_chat_id`;

-- changed table `telegram_update`

ALTER TABLE `telegram_update`
  DROP FOREIGN KEY `telegram_update_ibfk_3`;

ALTER TABLE `telegram_update`
  CHANGE COLUMN `id` `id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Update''s unique identifier' FIRST,
  CHANGE COLUMN `chat_id` `chat_id` bigint(20) DEFAULT NULL COMMENT 'Unique chat identifier' AFTER `id`,
  CHANGE COLUMN `inline_query_id` `inline_query_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Unique inline query identifier' AFTER `message_id`,
  CHANGE COLUMN `chosen_inline_query_id` `chosen_inline_result_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Local chosen inline result identifier' AFTER `inline_query_id`,
  CHANGE COLUMN `callback_query_id` `callback_query_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Unique callback query identifier' AFTER `chosen_inline_result_id`,
  ADD COLUMN `edited_message_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Local edited message identifier' AFTER `callback_query_id`,
  ADD KEY `edited_message_id` (`edited_message_id`),
  ADD CONSTRAINT `telegram_update_ibfk_5` FOREIGN KEY (`edited_message_id`) REFERENCES `edited_message` (`id`);

-- changed table `user`

ALTER TABLE `user`
  DROP INDEX `username`,
  CHANGE COLUMN `first_name` `first_name` char(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '' COMMENT 'User''s first name' AFTER `id`,
  CHANGE COLUMN `last_name` `last_name` char(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL COMMENT 'User''s last name' AFTER `first_name`,
  CHANGE COLUMN `username` `username` char(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL COMMENT 'User''s username' AFTER `last_name`,
  ADD KEY `username` (`username`(191));

-- changed table `user_chat`

ALTER TABLE `user_chat`
  ;

# New Tables

-- new table `botan_shortener`

CREATE TABLE `botan_shortener` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for this entry',
  `user_id` bigint(20) DEFAULT NULL COMMENT 'Unique user identifier',
  `url` text COLLATE utf8mb4_unicode_520_ci NOT NULL COMMENT 'Original URL',
  `short_url` char(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '' COMMENT 'Shortened URL',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `botan_shortener_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- new table `edited_message`

CREATE TABLE `edited_message` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for this entry',
  `chat_id` bigint(20) DEFAULT NULL COMMENT 'Unique chat identifier',
  `message_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Unique message identifier',
  `user_id` bigint(20) DEFAULT NULL COMMENT 'Unique user identifier',
  `edit_date` timestamp NULL DEFAULT NULL COMMENT 'Date the message was edited in timestamp format',
  `text` text COLLATE utf8mb4_unicode_520_ci COMMENT 'For text messages, the actual UTF-8 text of the message max message length 4096 char utf8',
  `entities` text COLLATE utf8mb4_unicode_520_ci COMMENT 'For text messages, special entities like usernames, URLs, bot commands, etc. that appear in the text',
  `caption` text COLLATE utf8mb4_unicode_520_ci COMMENT 'For message with caption, the actual UTF-8 text of the caption',
  PRIMARY KEY (`id`),
  KEY `chat_id` (`chat_id`),
  KEY `chat_id_2` (`chat_id`,`message_id`),
  KEY `message_id` (`message_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `edited_message_ibfk_1` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`),
  CONSTRAINT `edited_message_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

# Disable Foreign Keys Check
SET FOREIGN_KEY_CHECKS = 1;
