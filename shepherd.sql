-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Sep 30, 2026 at 01:08 PM
-- Server version: 10.11.19-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shepherd`
--

-- --------------------------------------------------------

--
-- Table structure for table `coordinators`
--

CREATE TABLE `coordinators` (
  `faculty_id` varchar(30) NOT NULL,
  `coordinator_name` varchar(150) NOT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `group_members`
--

CREATE TABLE `group_members` (
  `group_id` int(10) UNSIGNED NOT NULL,
  `regno` varchar(30) NOT NULL,
  `is_leader` tinyint(1) NOT NULL DEFAULT 0,
  `joined_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shepherd_groups`
--

CREATE TABLE `shepherd_groups` (
  `group_id` int(10) UNSIGNED NOT NULL,
  `group_name` varchar(150) NOT NULL,
  `orientation_date` date DEFAULT NULL,
  `one_day_visit` date DEFAULT NULL,
  `camp_date` date DEFAULT NULL,
  `total_hours` decimal(6,2) NOT NULL DEFAULT 0.00,
  `completed_hours` decimal(6,2) NOT NULL DEFAULT 0.00,
  `faculty_id` varchar(30) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `regno` varchar(30) NOT NULL,
  `stud_name` varchar(150) NOT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `dept` varchar(100) NOT NULL,
  `year` varchar(20) NOT NULL,
  `section` varchar(20) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `visit_bills`
--

CREATE TABLE `visit_bills` (
  `bill_id` int(10) UNSIGNED NOT NULL,
  `visit_id` int(10) UNSIGNED NOT NULL,
  `bill_proof_path` varchar(500) DEFAULT NULL,
  `bill_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `bill_status` varchar(20) NOT NULL DEFAULT 'pending',
  `transaction_id` varchar(150) DEFAULT NULL,
  `transaction_date` date DEFAULT NULL,
  `verified_by` varchar(30) DEFAULT NULL,
  `verified_at` datetime DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `visit_plans`
--

CREATE TABLE `visit_plans` (
  `visit_id` int(10) UNSIGNED NOT NULL,
  `group_id` int(10) UNSIGNED NOT NULL,
  `faculty_id` varchar(30) NOT NULL,
  `date_of_visit` date NOT NULL,
  `objective` text NOT NULL,
  `plan` text NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'pending',
  `remarks` text DEFAULT NULL,
  `allocated_hours` decimal(6,2) NOT NULL DEFAULT 0.00,
  `created_by` varchar(30) NOT NULL,
  `approved_by` varchar(30) DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `verified_by` varchar(30) DEFAULT NULL,
  `verified_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `visit_proofs`
--

CREATE TABLE `visit_proofs` (
  `proof_id` int(10) UNSIGNED NOT NULL,
  `visit_id` int(10) UNSIGNED NOT NULL,
  `proof_type` varchar(30) NOT NULL DEFAULT 'visit',
  `image_path` varchar(500) NOT NULL,
  `uploaded_by` varchar(30) NOT NULL,
  `uploaded_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `visit_submissions`
--

CREATE TABLE `visit_submissions` (
  `submission_id` int(10) UNSIGNED NOT NULL,
  `visit_id` int(10) UNSIGNED NOT NULL,
  `submitted_by` varchar(30) NOT NULL,
  `submitted_at` datetime NOT NULL DEFAULT current_timestamp(),
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `coordinators`
--
ALTER TABLE `coordinators`
  ADD PRIMARY KEY (`faculty_id`);

--
-- Indexes for table `group_members`
--
ALTER TABLE `group_members`
  ADD PRIMARY KEY (`group_id`,`regno`),
  ADD KEY `idx_group_members_regno` (`regno`);

--
-- Indexes for table `shepherd_groups`
--
ALTER TABLE `shepherd_groups`
  ADD PRIMARY KEY (`group_id`),
  ADD KEY `idx_groups_faculty` (`faculty_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`regno`);

--
-- Indexes for table `visit_bills`
--
ALTER TABLE `visit_bills`
  ADD PRIMARY KEY (`bill_id`),
  ADD UNIQUE KEY `uq_bill_visit` (`visit_id`),
  ADD KEY `idx_bill_status` (`bill_status`),
  ADD KEY `idx_bill_verified_by` (`verified_by`);

--
-- Indexes for table `visit_plans`
--
ALTER TABLE `visit_plans`
  ADD PRIMARY KEY (`visit_id`),
  ADD KEY `idx_visit_group` (`group_id`),
  ADD KEY `idx_visit_faculty` (`faculty_id`),
  ADD KEY `idx_visit_status` (`status`),
  ADD KEY `idx_visit_date` (`date_of_visit`),
  ADD KEY `idx_visit_created_by` (`created_by`),
  ADD KEY `fk_visit_approved_by` (`approved_by`),
  ADD KEY `fk_visit_verified_by` (`verified_by`);

--
-- Indexes for table `visit_proofs`
--
ALTER TABLE `visit_proofs`
  ADD PRIMARY KEY (`proof_id`),
  ADD KEY `idx_proofs_visit` (`visit_id`),
  ADD KEY `idx_proofs_uploaded_by` (`uploaded_by`);

--
-- Indexes for table `visit_submissions`
--
ALTER TABLE `visit_submissions`
  ADD PRIMARY KEY (`submission_id`),
  ADD UNIQUE KEY `uq_submission_visit` (`visit_id`),
  ADD KEY `idx_submission_student` (`submitted_by`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `shepherd_groups`
--
ALTER TABLE `shepherd_groups`
  MODIFY `group_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `visit_bills`
--
ALTER TABLE `visit_bills`
  MODIFY `bill_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `visit_plans`
--
ALTER TABLE `visit_plans`
  MODIFY `visit_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `visit_proofs`
--
ALTER TABLE `visit_proofs`
  MODIFY `proof_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `visit_submissions`
--
ALTER TABLE `visit_submissions`
  MODIFY `submission_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `group_members`
--
ALTER TABLE `group_members`
  ADD CONSTRAINT `fk_group_members_group` FOREIGN KEY (`group_id`) REFERENCES `shepherd_groups` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_group_members_student` FOREIGN KEY (`regno`) REFERENCES `students` (`regno`) ON UPDATE CASCADE;

--
-- Constraints for table `shepherd_groups`
--
ALTER TABLE `shepherd_groups`
  ADD CONSTRAINT `fk_groups_coordinator` FOREIGN KEY (`faculty_id`) REFERENCES `coordinators` (`faculty_id`) ON UPDATE CASCADE;

--
-- Constraints for table `visit_bills`
--
ALTER TABLE `visit_bills`
  ADD CONSTRAINT `fk_bill_verified_by` FOREIGN KEY (`verified_by`) REFERENCES `coordinators` (`faculty_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_bill_visit` FOREIGN KEY (`visit_id`) REFERENCES `visit_plans` (`visit_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `visit_plans`
--
ALTER TABLE `visit_plans`
  ADD CONSTRAINT `fk_visit_approved_by` FOREIGN KEY (`approved_by`) REFERENCES `coordinators` (`faculty_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_visit_created_by` FOREIGN KEY (`created_by`) REFERENCES `students` (`regno`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_visit_faculty` FOREIGN KEY (`faculty_id`) REFERENCES `coordinators` (`faculty_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_visit_group` FOREIGN KEY (`group_id`) REFERENCES `shepherd_groups` (`group_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_visit_verified_by` FOREIGN KEY (`verified_by`) REFERENCES `coordinators` (`faculty_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `visit_proofs`
--
ALTER TABLE `visit_proofs`
  ADD CONSTRAINT `fk_proof_student` FOREIGN KEY (`uploaded_by`) REFERENCES `students` (`regno`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_proof_visit` FOREIGN KEY (`visit_id`) REFERENCES `visit_plans` (`visit_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `visit_submissions`
--
ALTER TABLE `visit_submissions`
  ADD CONSTRAINT `fk_submission_student` FOREIGN KEY (`submitted_by`) REFERENCES `students` (`regno`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_submission_visit` FOREIGN KEY (`visit_id`) REFERENCES `visit_plans` (`visit_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
