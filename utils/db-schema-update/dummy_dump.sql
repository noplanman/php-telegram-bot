
INSERT INTO `chats` (`id`, `title`, `created_at`, `updated_at`) VALUES
(1, 'title', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 'title2', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

INSERT INTO `users` (`id`, `first_name`, `last_name`, `username`, `created_at`, `updated_at`) VALUES
(1, 'first', 'last', 'username', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 'first2', 'last2', 'username2', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

INSERT INTO `messages` (`update_id`, `message_id`, `user_id`, `date`, `chat_id`, `forward_from`, `forward_date`, `reply_to_message`, `text`, `audio`, `document`, `photo`, `sticker`, `video`, `contact`, `location`, `new_chat_participant`, `left_chat_participant`, `new_chat_title`, `new_chat_photo`, `delete_chat_photo`, `group_chat_created`) VALUES
(1, 1, 1, '0000-00-00 00:00:00', 1, '', 0, NULL, 'text', '', '', '', '', '', '', '', NULL, NULL, '', '', 0, 0),
(2, 2, 2, '0000-00-00 00:00:00', 2, '', 0, NULL, 'text2', '', '', '', '', '', '', '', NULL, NULL, '', '', 0, 0);

INSERT INTO `users_chats` (`user_id`, `chat_id`) VALUES
(1, 1),
(2, 2);
