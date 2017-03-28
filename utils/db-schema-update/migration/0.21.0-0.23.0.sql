# Disable Foreign Keys Check
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = '';

# Deleted Tables

# Changed Tables

-- changed table `chats`

ALTER TABLE `chats`
  CHANGE COLUMN `type` `type` char(10) DEFAULT '' COMMENT 'chat type private group, supergroup or channel' AFTER `id`;

# New Tables

# Disable Foreign Keys Check
SET FOREIGN_KEY_CHECKS = 1;
