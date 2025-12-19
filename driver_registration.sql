-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 19, 2025 at 08:33 PM
-- Server version: 10.11.10-MariaDB-log
-- PHP Version: 8.3.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `yoyomiles1234`
--

-- --------------------------------------------------------

--
-- Table structure for table `driver_registration`
--

CREATE TABLE `driver_registration` (
  `id` int(10) UNSIGNED NOT NULL,
  `platform_type` tinyint(1) DEFAULT NULL,
  `vehicle_type` varchar(50) DEFAULT NULL,
  `vehicle_name` varchar(100) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `profile_photo` varchar(255) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `personal_information_status` tinyint(1) DEFAULT NULL COMMENT '0 = Pending, 1 = Submitted, 2 = Approved, 3 = Rejected',
  `personal_information_reject_reason` text DEFAULT NULL,
  `driver_licence_status` tinyint(1) DEFAULT NULL COMMENT '0 = Pending, 1 = Submitted, 2 = Approved, 3 = Rejected',
  `driver_licence_reject_reason` text DEFAULT NULL,
  `driver_licence_front` varchar(255) DEFAULT NULL,
  `driver_licence_back` varchar(255) DEFAULT NULL,
  `driver_licence_number` varchar(50) DEFAULT NULL,
  `licence_validity_date` date DEFAULT NULL,
  `aadhaar_pan_status` tinyint(1) DEFAULT NULL COMMENT '0 = Pending, 1 = Submitted, 2 = Approved, 3 = Rejected',
  `aadhaar_pan_reject_reason` text DEFAULT NULL,
  `aadhaar_front` varchar(255) DEFAULT NULL,
  `aadhaar_back` varchar(255) DEFAULT NULL,
  `aadhaar_number` varchar(20) DEFAULT NULL,
  `pan_card_front` varchar(255) DEFAULT NULL,
  `pan_card_back` varchar(255) DEFAULT NULL,
  `pan_card_number` varchar(20) DEFAULT NULL,
  `required_certificates_status` tinyint(1) DEFAULT NULL COMMENT '0 = Pending, 1 = Submitted, 2 = Approved, 3 = Rejected',
  `required_certificates_reject_reason` text DEFAULT NULL,
  `fitness_certificate` varchar(255) DEFAULT NULL,
  `pollution_certificate` varchar(255) DEFAULT NULL,
  `insurance_certificate` varchar(255) DEFAULT NULL,
  `police_certificate` varchar(255) DEFAULT NULL,
  `vehicle_info_status` tinyint(1) DEFAULT NULL COMMENT '0 = Pending, 1 = Submitted, 2 = Approved, 3 = Rejected',
  `vehicle_info_reject_reason` text DEFAULT NULL,
  `vehicle_photo` varchar(255) DEFAULT NULL,
  `vehicle_brand` varchar(100) DEFAULT NULL,
  `vehicle_model` varchar(100) DEFAULT NULL,
  `vehicle_color` varchar(50) DEFAULT NULL,
  `vehicle_plate_number` varchar(50) DEFAULT NULL,
  `vehicle_production_year` year(4) DEFAULT NULL,
  `vehicle_documents_status` tinyint(1) DEFAULT NULL COMMENT '0 = Pending, 1 = Submitted, 2 = Approved, 3 = Rejected',
  `vehicle_documents_reject_reason` text DEFAULT NULL,
  `vehicle_permit_part_a` varchar(255) DEFAULT NULL,
  `vehicle_permit_part_b` varchar(255) DEFAULT NULL,
  `vehicle_registration_front` varchar(255) DEFAULT NULL,
  `vehicle_registration_back` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `device_id` varchar(100) NOT NULL,
  `fcm_token` longtext NOT NULL,
  `current_longitude` varchar(100) DEFAULT NULL,
  `current_latitude` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `driver_registration`
--

INSERT INTO `driver_registration` (`id`, `platform_type`, `vehicle_type`, `vehicle_name`, `mobile`, `profile_photo`, `first_name`, `last_name`, `date_of_birth`, `personal_information_status`, `personal_information_reject_reason`, `driver_licence_status`, `driver_licence_reject_reason`, `driver_licence_front`, `driver_licence_back`, `driver_licence_number`, `licence_validity_date`, `aadhaar_pan_status`, `aadhaar_pan_reject_reason`, `aadhaar_front`, `aadhaar_back`, `aadhaar_number`, `pan_card_front`, `pan_card_back`, `pan_card_number`, `required_certificates_status`, `required_certificates_reject_reason`, `fitness_certificate`, `pollution_certificate`, `insurance_certificate`, `police_certificate`, `vehicle_info_status`, `vehicle_info_reject_reason`, `vehicle_photo`, `vehicle_brand`, `vehicle_model`, `vehicle_color`, `vehicle_plate_number`, `vehicle_production_year`, `vehicle_documents_status`, `vehicle_documents_reject_reason`, `vehicle_permit_part_a`, `vehicle_permit_part_b`, `vehicle_registration_front`, `vehicle_registration_back`, `created_at`, `updated_at`, `device_id`, `fcm_token`, `current_longitude`, `current_latitude`) VALUES
(1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, NULL),
(2, 2, '1', 'abc', '8423953286', 'DriverDocuments/1766132304105.png', 'ramu sharma', 'aaaaaaaaa', '2001-08-30', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-19 08:18:24', '', '', NULL, NULL),
(3, 2, '1', 'abc', '8853502244', 'DriverDocuments/1766143303636.png', 'ramu sharma', 'aaaaaaaaa', '2001-08-30', 1, NULL, 1, NULL, 'DriverDocuments/1766139012699.jpg', 'DriverDocuments/1766139012700.png', 'cgfhbjklm', '2001-08-30', 1, NULL, 'DriverDocuments/1766139326055.png', 'DriverDocuments/1766139326965.jpg', '496137593369', 'DriverDocuments/1766139326980.png', 'DriverDocuments/1766139326981.png', '121hagshs', 1, NULL, 'DriverDocuments/1766139739001.png', 'DriverDocuments/1766139739126.png', 'DriverDocuments/1766139739255.png', 'DriverDocuments/1766139739260.png', 1, NULL, 'DriverDocuments/1766140554533.png', 'hero', '2025', 'red', '55665', '2025', 1, NULL, 'DriverDocuments/1766140796006.png', 'DriverDocuments/1766140796107.png', 'DriverDocuments/1766140796199.png', NULL, '2025-12-19 09:59:16', '2025-12-19 11:38:38', 'ABC123XYZ', 'token123', '80.946166', '26.846693'),
(4, NULL, NULL, NULL, '8423953289', 'DriverDocuments/1766140161954.jpg', 'ramu sharma', 'aaaaaaaaa', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-19 10:29:22', NULL, '', '', NULL, NULL),
(5, NULL, NULL, NULL, '8423953286', 'DriverDocuments/1766140945613.png', 'ramu sharma', 'aaaaaaaaa', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-19 10:42:25', NULL, '', '', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `driver_registration`
--
ALTER TABLE `driver_registration`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `driver_registration`
--
ALTER TABLE `driver_registration`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
