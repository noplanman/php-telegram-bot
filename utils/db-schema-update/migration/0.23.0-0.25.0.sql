# Disable Foreign Keys Check
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = '';

# Deleted Tables

# Changed Tables

-- changed table `chats`

ALTER TABLE `chats`
  CHANGE COLUMN `type` `type` enum('private','group','supergroup','channel') NOT NULL COMMENT 'chat type private, group, supergroup or channel' AFTER `id`,
  ADD COLUMN `old_id` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Unique chat identifieri this is filled when a chat is converted to a superchat' AFTER `updated_at`;

-- changed table `messages`

ALTER TABLE `messages`
  DROP PRIMARY KEY,
  DROP INDEX `message_id`,
  CHANGE COLUMN `message_id` `message_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Unique message identifier' FIRST,
  CHANGE COLUMN `chat_id` `chat_id` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Chat identifier.' AFTER `user_id`,
  CHANGE COLUMN `date` `date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Date the message was sent in timestamp format' AFTER `chat_id`,
  CHANGE COLUMN `forward_from` `forward_from` bigint(20) NOT NULL DEFAULT '0' COMMENT 'User id. For forwarded messages, sender of the original message' AFTER `date`,
  CHANGE COLUMN `forward_date` `forward_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'For forwarded messages, date the original message was sent in Unix time' AFTER `forward_from`,
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
  CHANGE COLUMN `new_chat_participant` `new_chat_participant` bigint(20) NOT NULL DEFAULT '0' COMMENT 'User id. A new member was added to the group, information about them (this member may be bot itself)' AFTER `location`,
  CHANGE COLUMN `left_chat_participant` `left_chat_participant` bigint(20) NOT NULL DEFAULT '0' COMMENT 'User id. A member was removed from the group, information about them (this member may be bot itself)' AFTER `new_chat_participant`,
  CHANGE COLUMN `new_chat_title` `new_chat_title` char(255) DEFAULT '' COMMENT 'A group title was changed to this value' AFTER `left_chat_participant`,
  CHANGE COLUMN `new_chat_photo` `new_chat_photo` text COMMENT 'Array of PhotoSize objects. A group photo was change to this value' AFTER `new_chat_title`,
  CHANGE COLUMN `delete_chat_photo` `delete_chat_photo` tinyint(1) DEFAULT '0' COMMENT 'Informs that the group photo was deleted' AFTER `new_chat_photo`,
  CHANGE COLUMN `group_chat_created` `group_chat_created` tinyint(1) DEFAULT '0' COMMENT 'Informs that the group has been created' AFTER `delete_chat_photo`,
  ADD COLUMN `supergroup_chat_created` tinyint(1) DEFAULT '0' COMMENT 'Informs that the supergroup has been created' AFTER `group_chat_created`,
  ADD COLUMN `channel_chat_created` tinyint(1) DEFAULT '0' COMMENT 'Informs that the channel chat has been created' AFTER `supergroup_chat_created`,
  ADD COLUMN `migrate_from_chat_id` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Migrate from chat identifier.' AFTER `channel_chat_created`,
  ADD COLUMN `migrate_to_chat_id` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Migrate to chat identifier.' AFTER `migrate_from_chat_id`,
  CHANGE COLUMN `update_id` `update_id` bigint(20) unsigned DEFAULT NULL COMMENT 'The update''s unique identifier.' AFTER `migrate_to_chat_id`,
  ADD PRIMARY KEY (`message_id`),
  ADD KEY `chat_id` (`chat_id`);

# New Tables

# Disable Foreign Keys Check
SET FOREIGN_KEY_CHECKS = 1;
