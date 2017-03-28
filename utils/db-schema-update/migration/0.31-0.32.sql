# Disable Foreign Keys Check
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = '';

# Deleted Tables

# Changed Tables

-- changed table `message`

ALTER TABLE `message`
  DROP FOREIGN KEY `message_ibfk_5`,
  DROP FOREIGN KEY `message_ibfk_6`,
  DROP FOREIGN KEY `message_ibfk_7`;

ALTER TABLE `message`
  ADD COLUMN `forward_from_chat` bigint(20) DEFAULT NULL COMMENT 'Chat id. For forwarded messages from channel' AFTER `forward_from`,
  CHANGE COLUMN `forward_date` `forward_date` timestamp NULL DEFAULT NULL COMMENT 'For forwarded messages, date the original message was sent in Unix time' AFTER `forward_from_chat`,
  CHANGE COLUMN `reply_to_chat` `reply_to_chat` bigint(20) DEFAULT NULL COMMENT 'Chat identifier.' AFTER `forward_date`,
  CHANGE COLUMN `reply_to_message` `reply_to_message` bigint(20) unsigned DEFAULT NULL COMMENT 'Message is a reply to another message.' AFTER `reply_to_chat`,
  CHANGE COLUMN `text` `text` text COMMENT 'For text messages, the actual UTF-8 text of the message max message length 4096 char utf8' AFTER `reply_to_message`,
  CHANGE COLUMN `entities` `entities` text COMMENT 'For text messages, special entities like usernames, URLs, bot commands, etc. that appear in the text' AFTER `text`,
  CHANGE COLUMN `audio` `audio` text COMMENT 'Audio object. Message is an audio file, information about the file' AFTER `entities`,
  CHANGE COLUMN `document` `document` text COMMENT 'Document object. Message is a general file, information about the file' AFTER `audio`,
  CHANGE COLUMN `photo` `photo` text COMMENT 'Array of PhotoSize objects. Message is a photo, available sizes of the photo' AFTER `document`,
  CHANGE COLUMN `sticker` `sticker` text COMMENT 'Sticker object. Message is a sticker, information about the sticker' AFTER `photo`,
  CHANGE COLUMN `video` `video` text COMMENT 'Video object. Message is a video, information about the video' AFTER `sticker`,
  CHANGE COLUMN `voice` `voice` text COMMENT 'Voice Object. Message is a Voice, information about the Voice' AFTER `video`,
  CHANGE COLUMN `caption` `caption` text COMMENT 'For message with caption, the actual UTF-8 text of the caption' AFTER `voice`,
  CHANGE COLUMN `contact` `contact` text COMMENT 'Contact object. Message is a shared contact, information about the contact' AFTER `caption`,
  CHANGE COLUMN `location` `location` text COMMENT 'Location object. Message is a shared location, information about the location' AFTER `contact`,
  CHANGE COLUMN `venue` `venue` text COMMENT 'Venue object. Message is a Venue, information about the Venue' AFTER `location`,
  CHANGE COLUMN `new_chat_member` `new_chat_member` bigint(20) DEFAULT NULL COMMENT 'User id. A new member was added to the group, information about them (this member may be bot itself)' AFTER `venue`,
  CHANGE COLUMN `left_chat_member` `left_chat_member` bigint(20) DEFAULT NULL COMMENT 'User id. A member was removed from the group, information about them (this member may be bot itself)' AFTER `new_chat_member`,
  CHANGE COLUMN `new_chat_title` `new_chat_title` char(255) DEFAULT NULL COMMENT 'A group title was changed to this value' AFTER `left_chat_member`,
  CHANGE COLUMN `new_chat_photo` `new_chat_photo` text COMMENT 'Array of PhotoSize objects. A group photo was change to this value' AFTER `new_chat_title`,
  CHANGE COLUMN `delete_chat_photo` `delete_chat_photo` tinyint(1) DEFAULT '0' COMMENT 'Informs that the group photo was deleted' AFTER `new_chat_photo`,
  CHANGE COLUMN `group_chat_created` `group_chat_created` tinyint(1) DEFAULT '0' COMMENT 'Informs that the group has been created' AFTER `delete_chat_photo`,
  CHANGE COLUMN `supergroup_chat_created` `supergroup_chat_created` tinyint(1) DEFAULT '0' COMMENT 'Informs that the supergroup has been created' AFTER `group_chat_created`,
  CHANGE COLUMN `channel_chat_created` `channel_chat_created` tinyint(1) DEFAULT '0' COMMENT 'Informs that the channel chat has been created' AFTER `supergroup_chat_created`,
  CHANGE COLUMN `migrate_from_chat_id` `migrate_from_chat_id` bigint(20) DEFAULT NULL COMMENT 'Migrate from chat identifier.' AFTER `channel_chat_created`,
  CHANGE COLUMN `migrate_to_chat_id` `migrate_to_chat_id` bigint(20) DEFAULT NULL COMMENT 'Migrate to chat identifier.' AFTER `migrate_from_chat_id`,
  CHANGE COLUMN `pinned_message` `pinned_message` text COMMENT 'Pinned message, Message object.' AFTER `migrate_to_chat_id`,
  ADD KEY `forward_from_chat` (`forward_from_chat`),
  ADD CONSTRAINT `message_ibfk_6` FOREIGN KEY (`forward_from`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `message_ibfk_7` FOREIGN KEY (`new_chat_member`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `message_ibfk_4` FOREIGN KEY (`forward_from_chat`) REFERENCES `chat` (`id`),
  ADD CONSTRAINT `message_ibfk_8` FOREIGN KEY (`left_chat_member`) REFERENCES `user` (`id`);

# New Tables

# Disable Foreign Keys Check
SET FOREIGN_KEY_CHECKS = 1;
