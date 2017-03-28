# Disable Foreign Keys Check
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = '';

# Deleted Tables

# Changed Tables

-- changed table `messages`

ALTER TABLE `messages`
  CHANGE COLUMN `chat_id` `chat_id` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Chat identifier.' AFTER `date`,
  CHANGE COLUMN `forward_from` `forward_from` bigint(20) NOT NULL DEFAULT '0' COMMENT 'User id. For forwarded messages, sender of the original message' AFTER `chat_id`,
  CHANGE COLUMN `forward_date` `forward_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'For forwarded messages, date the original message was sent in Unix time' AFTER `forward_from`,
  CHANGE COLUMN `audio` `audio` text COMMENT 'Audio object. Message is an audio file, information about the file' AFTER `text`,
  CHANGE COLUMN `document` `document` text COMMENT 'Document object. Message is a general file, information about the file' AFTER `audio`,
  CHANGE COLUMN `photo` `photo` text COMMENT 'Array of PhotoSize objects. Message is a photo, available sizes of the photo' AFTER `document`,
  CHANGE COLUMN `sticker` `sticker` text COMMENT 'Sticker object. Message is a sticker, information about the sticker' AFTER `photo`,
  CHANGE COLUMN `video` `video` text COMMENT 'Video object. Message is a video, information about the video' AFTER `sticker`,
  ADD COLUMN `voice` text COMMENT 'Voice Object. Message is a Voice, information about the Voice' AFTER `video`,
  ADD COLUMN `caption` longtext COMMENT 'For message with caption, the actual UTF-8 text of the caption' AFTER `voice`,
  CHANGE COLUMN `contact` `contact` text COMMENT 'Contact object. Message is a shared contact, information about the contact' AFTER `caption`,
  CHANGE COLUMN `location` `location` text COMMENT 'Location object. Message is a shared location, information about the location' AFTER `contact`,
  CHANGE COLUMN `new_chat_participant` `new_chat_participant` bigint(20) NOT NULL DEFAULT '0' COMMENT 'User id. A new member was added to the group, information about them (this member may be bot itself)' AFTER `location`,
  CHANGE COLUMN `left_chat_participant` `left_chat_participant` bigint(20) NOT NULL DEFAULT '0' COMMENT 'User id. A member was removed from the group, information about them (this member may be bot itself)' AFTER `new_chat_participant`,
  CHANGE COLUMN `new_chat_photo` `new_chat_photo` text COMMENT 'Array of PhotoSize objects. A group photo was change to this value' AFTER `new_chat_title`;

# New Tables

# Disable Foreign Keys Check
SET FOREIGN_KEY_CHECKS = 1;
