# Disable Foreign Keys Check
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = '';

# Deleted Tables

# Changed Tables

-- changed table `chat`

ALTER TABLE `chat`
  ADD KEY `old_id` (`old_id`);

-- changed table `conversation`

ALTER TABLE `conversation`
  CHANGE COLUMN `created_at` `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation' AFTER `notes`,
  CHANGE COLUMN `updated_at` `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date update' AFTER `created_at`;

-- changed table `telegram_update`

ALTER TABLE `telegram_update`
  DROP FOREIGN KEY `telegram_update_ibfk_1`,
  DROP INDEX `message_id`,
  ADD COLUMN `chat_id` bigint(20) DEFAULT NULL COMMENT 'Chat identifier.' AFTER `id`,
  CHANGE COLUMN `message_id` `message_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Unique message identifier' AFTER `chat_id`,
  CHANGE COLUMN `inline_query_id` `inline_query_id` bigint(20) unsigned DEFAULT NULL COMMENT 'The query unique identifier.' AFTER `message_id`,
  CHANGE COLUMN `chosen_inline_query_id` `chosen_inline_query_id` bigint(20) unsigned DEFAULT NULL COMMENT 'The chosen query unique identifier.' AFTER `inline_query_id`,
  ADD KEY `message_id` (`chat_id`,`message_id`);

-- changed table `message`

ALTER TABLE `message`
  DROP PRIMARY KEY,
  DROP FOREIGN KEY `message_ibfk_4`,
  DROP INDEX `chat_id`,
  CHANGE COLUMN `chat_id` `chat_id` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Chat identifier.' FIRST,
  CHANGE COLUMN `id` `id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Unique message identifier' AFTER `chat_id`,
  CHANGE COLUMN `user_id` `user_id` bigint(20) DEFAULT NULL COMMENT 'User identifier' AFTER `id`,
  CHANGE COLUMN `date` `date` timestamp NULL DEFAULT NULL COMMENT 'Date the message was sent in timestamp format' AFTER `user_id`,
  CHANGE COLUMN `forward_from` `forward_from` bigint(20) DEFAULT NULL COMMENT 'User id. For forwarded messages, sender of the original message' AFTER `date`,
  CHANGE COLUMN `forward_date` `forward_date` timestamp NULL DEFAULT NULL COMMENT 'For forwarded messages, date the original message was sent in Unix time' AFTER `forward_from`,
  ADD COLUMN `reply_to_chat` bigint(20) DEFAULT NULL COMMENT 'Chat identifier.' AFTER `forward_date`,
  CHANGE COLUMN `reply_to_message` `reply_to_message` bigint(20) unsigned DEFAULT NULL COMMENT 'Message is a reply to another message.' AFTER `reply_to_chat`,
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
  ADD PRIMARY KEY (`chat_id`,`id`),
  ADD KEY `reply_to_chat` (`reply_to_chat`),
  ADD KEY `reply_to_chat_2` (`reply_to_chat`,`reply_to_message`);

# New Tables

# Disable Foreign Keys Check
SET FOREIGN_KEY_CHECKS = 1;
