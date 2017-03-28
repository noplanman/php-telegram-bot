# Disable Foreign Keys Check
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = '';

# Deleted Tables

# Changed Tables

-- changed table `chat`

ALTER TABLE `chat`
  ADD COLUMN `username` char(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL COMMENT 'Username, for private chats, supergroups and channels if available' AFTER `title`,
  ADD COLUMN `all_members_are_administrators` tinyint(1) DEFAULT '0' COMMENT 'True if a all members of this group are admins' AFTER `username`,
  CHANGE COLUMN `created_at` `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation' AFTER `all_members_are_administrators`,
  CHANGE COLUMN `updated_at` `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date update' AFTER `created_at`,
  CHANGE COLUMN `old_id` `old_id` bigint(20) DEFAULT NULL COMMENT 'Unique chat identifier, this is filled when a group is converted to a supergroup' AFTER `updated_at`;

-- changed table `message`

ALTER TABLE `message`
  ADD COLUMN `forward_from_message_id` bigint(20) DEFAULT NULL COMMENT 'Unique chat identifier of the original message in the channel' AFTER `forward_from_chat`,
  CHANGE COLUMN `forward_date` `forward_date` timestamp NULL DEFAULT NULL COMMENT 'date the original message was sent in timestamp format' AFTER `forward_from_message_id`,
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
  CHANGE COLUMN `group_chat_created` `group_chat_created` tinyint(1) DEFAULT '0' COMMENT 'Informs that the group has been created' AFTER `delete_chat_photo`,
  CHANGE COLUMN `supergroup_chat_created` `supergroup_chat_created` tinyint(1) DEFAULT '0' COMMENT 'Informs that the supergroup has been created' AFTER `group_chat_created`,
  CHANGE COLUMN `channel_chat_created` `channel_chat_created` tinyint(1) DEFAULT '0' COMMENT 'Informs that the channel chat has been created' AFTER `supergroup_chat_created`,
  CHANGE COLUMN `migrate_to_chat_id` `migrate_to_chat_id` bigint(20) DEFAULT NULL COMMENT 'Migrate to chat identifier. The group has been migrated to a supergroup with the specified identifie' AFTER `channel_chat_created`,
  CHANGE COLUMN `migrate_from_chat_id` `migrate_from_chat_id` bigint(20) DEFAULT NULL COMMENT 'Migrate from chat identifier. The supergroup has been migrated from a group with the specified identifier' AFTER `migrate_to_chat_id`,
  CHANGE COLUMN `pinned_message` `pinned_message` text COLLATE utf8mb4_unicode_520_ci COMMENT 'Message object. Specified message was pinned' AFTER `migrate_from_chat_id`;

# New Tables

# Disable Foreign Keys Check
SET FOREIGN_KEY_CHECKS = 1;
