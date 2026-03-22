SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Database: `mind_bridge`
--

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('student','peer','supervisor') NOT NULL,
  `specialization` varchar(100) DEFAULT NULL,  --- [Added for frontend]. Doctors/Peers have titles like "Child Psychologist" or "Family Therapist". Without this column, we cannot dynamically display their roles on the schedule cards.
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table `users`
INSERT INTO `users` (`user_id`, `name`, `email`, `password`, `role`, `specialization`, `created_at`) VALUES
(1, 'Sadia Islam', 'sadia@test.com', '123456', 'student', NULL, '2026-03-07 15:40:34'),
(2, 'Shanjida Hossain', 'shanjida@peer.com', '123456', 'peer', 'Psychotherapist', '2026-03-07 15:40:34'),
(3, 'Dr. Ali', 'ali@admin.com', '123456', 'supervisor', 'Psychiatrist', '2026-03-07 15:40:34');
(4, 'Rahim Ahmed', 'rahim@student.com', 'pass123', 'student', '2026-03-07 15:41:41'),
(5, 'Ayesha Khan', 'ayesha@student.com', 'pass123', 'student', '2026-03-07 15:41:41'),
(6, 'Tanvir Hasan', 'tanvir@peer.com', 'pass123', 'peer', '2026-03-07 15:41:41'),
(7, 'Nusrat Jahan', 'nusrat@peer.com', 'pass123', 'peer', '2026-03-07 15:41:41'),
(8, 'Dr. Karim', 'karim@admin.com', 'pass123', 'supervisor', '2026-03-07 15:41:41'),
(9, 'Fahad Ahmed', 'fahad@student.com', 'pass123', 'student', '2026-03-07 15:50:01'),
(10, 'Ilma Khan', 'ilma@student.com', 'pass123', 'student', '2026-03-07 15:50:01'),
(11, 'Fahim Islam', 'fahim@student.com', 'pass123', 'student', '2026-03-07 15:50:01'),
(12, 'Nadia Rahman', 'nadia@student.com', 'pass123', 'student', '2026-03-07 15:50:01'),
(13, 'Imran Hossain', 'imran@student.com', 'pass123', 'student', '2026-03-07 15:50:01'),
(14, 'Sara Akter', 'sara@student.com', 'pass123', 'student', '2026-03-07 15:50:01'),
(15, 'Adib Hasan', 'adib@peer.com', 'pass123', 'peer', '2026-03-07 15:50:01'),
(16, 'Sumaiya Islam', 'sumaiya@peer.com', 'pass123', 'peer', '2026-03-07 15:50:01'),
(17, 'Mahin Chowdhury', 'mahin@peer.com', 'pass123', 'peer', '2026-03-07 15:50:01'),
(18, 'Sadia Kabir', 'sadia@peer.com', 'pass123', 'peer', '2026-03-07 15:50:01'),
(19, 'Dr Nabil', 'nabil@admin.com', 'pass123', 'supervisor', '2026-03-07 15:50:01'),
(20, 'Dr Farhana', 'farhana@admin.com', 'pass123', 'supervisor', '2026-03-07 15:50:01');

-- --------------------------------------------------------

--
-- Table structure for table `alerts`
--

CREATE TABLE `alerts` (
  `alert_id` int(11) NOT NULL,
  `report_id` int(11) DEFAULT NULL,
  `alert_type` varchar(50) DEFAULT NULL,
  
  --- [ADDED FOR FRONTEND]: Added `status` column.
  --- Why? Supervisors need a way to mark an alert as "Resolved" or "Reviewed" 
  --- so their dashboard doesn't stay permanently cluttered with old alerts.
  `status` enum('unread','acknowledged','resolved') DEFAULT 'unread',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table `alerts`
INSERT INTO `alerts` (`alert_id`, `report_id`, `alert_type`, `status`, `created_at`) VALUES
(1, 2, 'High Risk Mental Health Alert', 'unread', '2026-03-07 15:45:18');

-- --------------------------------------------------------

--
-- Table structure for table `reports`
-- (Kept exactly as teammate designed it. Perfect structure for anonymous/open reporting.)
--

CREATE TABLE `reports` (
  `report_id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `report_type` enum('anonymous','open') DEFAULT NULL,
  `description` text DEFAULT NULL,
  `risk_level` enum('low','medium','high') DEFAULT NULL,
  `status` enum('pending','active','closed') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
-- (Kept exactly as teammate designed it)
--

CREATE TABLE `sessions` (
  `session_id` int(11) NOT NULL,
  `report_id` int(11) DEFAULT NULL,
  `peer_id` int(11) DEFAULT NULL,
  `session_date` datetime DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `status` enum('scheduled','completed','cancelled') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--- [ADDED FOR FRONTEND]: NEW TABLE `messages`
--- Why? The project proposal mentions "peer support", and we built a full `chat.html` UI. 
--- We need this table to store the actual chat history between students and peer supporters, 
--- including a flag to hide the student's name if they toggle "Anonymous Mode".

CREATE TABLE `messages` (
  `message_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `message_text` text NOT NULL,
  `is_anonymous` tinyint(1) DEFAULT 0,
  `sent_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--- [ADDED FOR FRONTEND]: NEW TABLE `resources`
--- Why? The proposal states students can "access resources." `resources.html` has 
--- a grid of articles, videos, and exercises. This table allows supervisors to dynamically 
--- add new mental health guides instead of them being hardcoded into the HTML.

CREATE TABLE `resources` (
  `resource_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `resource_type` enum('article','video','exercise','guide') NOT NULL,
  `duration_minutes` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--- [ADDED FOR FRONTEND]: NEW TABLE `emotional_tracking`
--- Why? In `index.html`, we have a beautiful bar chart for "Emotional State" and "Progress Tracking".
--- We need a database table to store the student's daily/weekly emotional check-in scores so the chart can render real data.

CREATE TABLE `emotional_tracking` (
  `tracking_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `emotional_score` int(11) NOT NULL,
  `recorded_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- Indexes for dumped tables
-- --------------------------------------------------------

ALTER TABLE `alerts`
  ADD PRIMARY KEY (`alert_id`),
  ADD KEY `report_id` (`report_id`);

ALTER TABLE `reports`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `student_id` (`student_id`);

ALTER TABLE `sessions`
  ADD PRIMARY KEY (`session_id`),
  ADD KEY `report_id` (`report_id`),
  ADD KEY `peer_id` (`peer_id`);

ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--- Indexes for new tables
ALTER TABLE `messages`
  ADD PRIMARY KEY (`message_id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `receiver_id` (`receiver_id`);

ALTER TABLE `resources`
  ADD PRIMARY KEY (`resource_id`);

ALTER TABLE `emotional_tracking`
  ADD PRIMARY KEY (`tracking_id`),
  ADD KEY `student_id` (`student_id`);

-- --------------------------------------------------------
-- AUTO_INCREMENT for dumped tables
-- --------------------------------------------------------

ALTER TABLE `alerts` MODIFY `alert_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
ALTER TABLE `reports` MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
ALTER TABLE `sessions` MODIFY `session_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;
ALTER TABLE `users` MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--- AUTO_INCREMENT for new tables
ALTER TABLE `messages` MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `resources` MODIFY `resource_id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `emotional_tracking` MODIFY `tracking_id` int(11) NOT NULL AUTO_INCREMENT;

-- --------------------------------------------------------
-- Constraints for dumped tables
-- --------------------------------------------------------

ALTER TABLE `alerts`
  ADD CONSTRAINT `alerts_ibfk_1` FOREIGN KEY (`report_id`) REFERENCES `reports` (`report_id`);

ALTER TABLE `reports`
  ADD CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `sessions`
  ADD CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`report_id`) REFERENCES `reports` (`report_id`),
  ADD CONSTRAINT `sessions_ibfk_2` FOREIGN KEY (`peer_id`) REFERENCES `users` (`user_id`);

--- Constraints for new tables
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `emotional_tracking`
  ADD CONSTRAINT `emotional_tracking_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `users` (`user_id`);

COMMIT;