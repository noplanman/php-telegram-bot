# Disable Foreign Keys Check
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = '';

# Deleted Tables

# Changed Tables

-- changed table `conversation`

ALTER TABLE `conversation`
  CHANGE COLUMN `notes` `notes` text COLLATE utf8mb4_unicode_520_ci COMMENT 'Data stored from command' AFTER `command`;

# New Tables

# Disable Foreign Keys Check
SET FOREIGN_KEY_CHECKS = 1;
