-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 13, 2026 at 02:19 PM
-- Server version: 5.7.44-log
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rainbow12345`
--

-- --------------------------------------------------------

--
-- Table structure for table `adminuser`
--

CREATE TABLE `adminuser` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(100) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `session_version` int(11) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `adminuser`
--

INSERT INTO `adminuser` (`id`, `name`, `email`, `password`, `image`, `created_at`, `session_version`) VALUES
(1, 'Admin User', 'admin@gmail.com', '12345678', 'profileImage/1768905819611.png', '2025-12-04 05:00:20', 6);

-- --------------------------------------------------------

--
-- Table structure for table `bank_details`
--

CREATE TABLE `bank_details` (
  `id` int(30) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `account_number` varchar(30) DEFAULT NULL,
  `account_holder_name` varchar(60) DEFAULT NULL,
  `ifsc_code` varchar(30) DEFAULT NULL,
  `re_account_number` varchar(30) DEFAULT NULL,
  `bank_name` varchar(100) DEFAULT NULL,
  `datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `type` tinyint(4) NOT NULL COMMENT '1 serviceman\r\n2 driver',
  `status` tinyint(4) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bank_details`
--

INSERT INTO `bank_details` (`id`, `user_id`, `account_number`, `account_holder_name`, `ifsc_code`, `re_account_number`, `bank_name`, `datetime`, `updated_at`, `type`, `status`) VALUES
(39, 1, '976494318464', 'Tanisha Sharma ', 'SBI9967', '976494318464', 'SBI', '2025-11-21 12:57:19', '2025-11-21 12:57:19', 0, 1),
(51, 1, '896332589963', 'Priya Singh', 'CNRB0001740', '896332589963', 'Canara Bank', '2026-01-24 04:08:46', '2026-01-24 04:08:46', 1, 1),
(46, 10, '965632692962', 'Tanisha Sharma ', 'CAIN0123456', '965632692962', 'canara', '2025-12-22 07:56:41', '2025-12-22 07:56:41', 2, 1),
(48, 84, '585755855555', 'harsh', 'SBIN0000129', '585755855555', 'sbi', '2026-01-23 05:10:45', '2026-01-23 05:10:45', 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `bank_details_update_requests`
--

CREATE TABLE `bank_details_update_requests` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` tinyint(4) NOT NULL COMMENT '1=serviceman, 2=driver',
  `bank_name` varchar(150) NOT NULL,
  `account_number` varchar(20) NOT NULL,
  `re_account_number` varchar(20) NOT NULL,
  `account_holder_name` varchar(150) NOT NULL,
  `ifsc_code` varchar(20) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0=pending, 1=approved, 2=rejected',
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `reject_reason` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bank_details_update_requests`
--

INSERT INTO `bank_details_update_requests` (`id`, `user_id`, `type`, `bank_name`, `account_number`, `re_account_number`, `account_holder_name`, `ifsc_code`, `status`, `created_at`, `updated_at`, `reject_reason`) VALUES
(3, 12, 1, 'Chhitani kushingar', '123456789012', '123456789012', 'Shyamu Sharma', 'HDFC0004444', 1, '2025-12-13 05:23:54', '2025-12-13 06:36:46', 'ASzdcghj'),
(4, 12, 1, 'HDFC Bank', '123456789012', '123456789012', 'Ramu Sharma', 'HDFC0001234', 2, '2025-12-13 06:12:39', '2025-12-13 12:18:59', 'sdxfghj'),
(5, 1, 1, 'Canara Bank', '963256325635', '963256325635', 'Swati', 'CANN0123456', 1, '2025-12-13 06:39:19', '2025-12-13 12:57:15', NULL),
(6, 12, 1, 'Chhitani kushingar', '123456789012', '123456789012', 'Shyamu Sharma', 'HDFC0004444', 0, '2025-12-13 07:23:51', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `brand`
--

CREATE TABLE `brand` (
  `id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `status` tinyint(4) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `brand`
--

INSERT INTO `brand` (`id`, `vehicle_id`, `name`, `status`, `created_at`) VALUES
(1, 1, 'Bajaj Auto', 1, '2025-12-30 04:33:20'),
(2, 1, 'TVS Motor', 1, '2025-12-30 04:33:20'),
(3, 2, 'Maruti Suzuki', 1, '2025-12-30 04:33:32'),
(4, 2, 'Hyundai', 1, '2025-12-30 04:33:32'),
(5, 3, 'Honda', 1, '2025-12-30 04:33:47'),
(6, 3, 'Bajaj', 1, '2025-12-30 04:33:47'),
(8, 4, 'Honda City', 1, '2025-12-30 11:29:59'),
(9, 4, 'Hyundai Verna', 1, '2026-01-23 11:18:10'),
(10, 5, 'Hyundai', 1, '2026-01-23 11:32:25'),
(11, 5, 'Tata Motors', 1, '2026-01-23 11:33:17'),
(12, 2, 'DZIRE', 1, '2026-01-27 13:20:26'),
(13, 2, 'WAGON R', 1, '2026-01-27 13:22:18'),
(14, 3, 'TVS', 1, '2026-02-24 13:10:21'),
(15, 3, 'HERO', 1, '2026-03-06 16:17:13');

-- --------------------------------------------------------

--
-- Table structure for table `cab_cancel_reasons`
--

CREATE TABLE `cab_cancel_reasons` (
  `id` int(11) NOT NULL,
  `type` tinyint(4) NOT NULL COMMENT '1=user, 2=driver',
  `reason_title` varchar(255) NOT NULL,
  `status` tinyint(4) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cab_cancel_reasons`
--

INSERT INTO `cab_cancel_reasons` (`id`, `type`, `reason_title`, `status`, `created_at`) VALUES
(1, 1, 'Driver is taking too long', 1, '2026-01-05 06:05:40'),
(2, 1, 'Changed my mind', 1, '2026-01-05 06:05:40'),
(3, 1, 'Found another ride', 1, '2026-01-05 06:05:40'),
(4, 1, 'Wrong pickup location', 1, '2026-01-05 06:05:40'),
(5, 1, 'Price is too high', 1, '2026-01-05 06:05:40'),
(6, 1, 'Driver not responding', 1, '2026-01-05 06:05:40'),
(7, 1, 'Emergency situation', 1, '2026-01-05 06:05:40'),
(8, 2, 'User not responding', 1, '2026-01-05 06:07:50'),
(9, 2, 'User did not come to pickup point', 1, '2026-01-05 06:07:50'),
(10, 2, 'Vehicle issue', 1, '2026-01-05 06:07:50'),
(11, 2, 'Wrong pickup location', 1, '2026-01-05 06:07:50'),
(12, 2, 'Trip distance too short', 1, '2026-01-05 06:07:50'),
(13, 2, 'Payment issue', 1, '2026-01-05 06:07:50'),
(14, 2, 'Emergency situation', 1, '2026-01-05 06:07:50');

-- --------------------------------------------------------

--
-- Table structure for table `cab_orders`
--

CREATE TABLE `cab_orders` (
  `id` bigint(20) NOT NULL,
  `order_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0=waiting,\r\n1=accepted_by_user,\r\n2=driver_arrived_at_pickup,\r\n3=otp_verified_ride_started,\r\n4=reached destination,\r\n5=pay done,\r\n6=Cancelled by User,\r\n7=Cancelled by Driver,\r\n8=cancelled_by_system',
  `wallet_apply` tinyint(4) DEFAULT NULL COMMENT '0 not apply \r\n1 apply ',
  `driver_id` bigint(20) DEFAULT NULL,
  `pay_mode` tinyint(4) NOT NULL DEFAULT '0' COMMENT '	1 = online 2 = offline 3 = wallet',
  `amount_after_wallet` decimal(10,2) NOT NULL DEFAULT '0.00',
  `final_amount` decimal(10,2) DEFAULT '0.00',
  `matched_driver_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `ignored_drivers_id` json DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  `vehicle_id` bigint(20) NOT NULL,
  `vehicle_name` varchar(100) NOT NULL,
  `brand_id` bigint(20) DEFAULT NULL,
  `brand_name` varchar(100) DEFAULT NULL,
  `model_id` bigint(20) DEFAULT NULL,
  `model_name` varchar(100) DEFAULT NULL,
  `pickup_location` varchar(255) DEFAULT NULL,
  `pickup_latitude` decimal(10,7) NOT NULL,
  `pickup_longitude` decimal(10,7) NOT NULL,
  `drop_location` varchar(255) DEFAULT NULL,
  `drop_latitude` decimal(10,7) NOT NULL,
  `drop_longitude` decimal(10,7) NOT NULL,
  `distance_km` decimal(6,2) NOT NULL DEFAULT '0.00',
  `estimated_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `accepted_offer_id` bigint(20) DEFAULT NULL,
  `cancel_reason` varchar(255) DEFAULT NULL,
  `order_type` tinyint(4) DEFAULT NULL COMMENT '1 = now , 2 letter',
  `schedule_time` timestamp NULL DEFAULT NULL,
  `payment_status` tinyint(4) DEFAULT '0' COMMENT '0 = pending,\r\n1 = success',
  `coupon_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_comment` varchar(255) DEFAULT NULL,
  `over_limit_passenger` int(11) DEFAULT '0',
  `profile_photo` varchar(100) DEFAULT NULL,
  `vehicle_color` varchar(100) DEFAULT NULL,
  `driver_name` varchar(100) DEFAULT NULL,
  `vehicle_plate_number` varchar(100) DEFAULT NULL,
  `contact_number` bigint(12) DEFAULT NULL,
  `orderOtp` int(8) DEFAULT NULL,
  `rating` double DEFAULT NULL,
  `user_name` varchar(100) DEFAULT NULL,
  `user_mobile` bigint(12) DEFAULT NULL,
  `order_rating` tinyint(4) DEFAULT NULL,
  `cancel_by_admin` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cab_orders`
--

INSERT INTO `cab_orders` (`id`, `order_status`, `wallet_apply`, `driver_id`, `pay_mode`, `amount_after_wallet`, `final_amount`, `matched_driver_id`, `ignored_drivers_id`, `user_id`, `vehicle_id`, `vehicle_name`, `brand_id`, `brand_name`, `model_id`, `model_name`, `pickup_location`, `pickup_latitude`, `pickup_longitude`, `drop_location`, `drop_latitude`, `drop_longitude`, `distance_km`, `estimated_amount`, `accepted_offer_id`, `cancel_reason`, `order_type`, `schedule_time`, `payment_status`, `coupon_id`, `created_at`, `updated_at`, `user_comment`, `over_limit_passenger`, `profile_photo`, `vehicle_color`, `driver_name`, `vehicle_plate_number`, `contact_number`, `orderOtp`, `rating`, `user_name`, `user_mobile`, `order_rating`, `cancel_by_admin`) VALUES
(311, 5, 0, NULL, 2, 0.00, 0.00, '[20,77,87]', NULL, 3, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435801, 80.9405671, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-06 15:04:05', '2026-02-19 06:23:21', '', 0, NULL, NULL, NULL, NULL, NULL, 5840, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(312, 8, 0, NULL, 2, 0.00, 0.00, '[20,77,87]', NULL, 3, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435801, 80.9405671, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-06 15:05:17', '2026-02-06 15:05:35', '', 0, NULL, NULL, NULL, NULL, NULL, 4748, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(313, 9, 0, NULL, 2, 0.00, 0.00, '[20,77,87]', NULL, 3, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435801, 80.9405671, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-06 15:08:25', '2026-02-21 20:30:44', '', 0, NULL, NULL, NULL, NULL, NULL, 7533, NULL, 'pankaj ji', 9876543210, NULL, 1),
(314, 9, 0, NULL, 2, 0.00, 0.00, '[19,20,77,87]', NULL, 3, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435801, 80.9405671, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-06 15:09:55', '2026-02-21 20:30:35', '', 0, NULL, NULL, NULL, NULL, NULL, 4668, NULL, 'pankaj ji', 9876543210, NULL, 1),
(315, 8, 0, NULL, 2, 0.00, 0.00, '[19,20,77,87]', NULL, 3, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435801, 80.9405671, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-06 15:10:33', '2026-02-06 15:10:53', '', 0, NULL, NULL, NULL, NULL, NULL, 9638, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(316, 5, 0, NULL, 2, 0.00, 0.00, '[20,77,87]', '[19]', 3, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435801, 80.9405671, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-06 15:11:42', '2026-02-21 20:31:20', '', 0, NULL, NULL, NULL, NULL, NULL, 2470, NULL, 'pankaj ji', 9876543210, NULL, 1),
(317, 8, 0, NULL, 1, 0.00, 0.00, '[78,88]', '[93]', 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822941, 80.9317755, 'Alambagh, Lucknow, Uttar Pradesh, India', 26.8127442, 80.9012798, 30.71, 522.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-06 15:12:30', '2026-02-06 15:13:05', '', 0, NULL, NULL, NULL, NULL, NULL, 6249, NULL, 'aman', 7705827321, NULL, NULL),
(318, 8, 0, NULL, 2, 0.00, 0.00, '[20,77,87]', '[19]', 3, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435801, 80.9405671, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-06 15:19:16', '2026-02-06 15:19:43', '', 0, NULL, NULL, NULL, NULL, NULL, 1211, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(319, 8, 0, NULL, 2, 0.00, 0.00, '[20,77,87]', '[19]', 3, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435801, 80.9405671, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-06 15:19:52', '2026-02-06 15:20:47', '', 0, NULL, NULL, NULL, NULL, NULL, 5693, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(322, 8, 0, NULL, 2, 0.00, 0.00, '[19,20,77,87]', NULL, 3, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435725, 80.9405596, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 94.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-06 15:27:45', '2026-02-06 15:27:58', '', 0, NULL, NULL, NULL, NULL, NULL, 1998, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(335, 8, 0, NULL, 2, 0.00, 0.00, '[20,77,87]', '[19]', 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435710, 80.9405609, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 13.36, 94.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-07 10:59:23', '2026-02-07 11:01:12', '', 0, NULL, NULL, NULL, NULL, NULL, 3903, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(337, 8, 0, NULL, 2, 0.00, 0.00, '[20,77,87]', '[19]', 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435710, 80.9405609, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 13.36, 94.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-07 11:08:08', '2026-02-07 11:09:26', '', 0, NULL, NULL, NULL, NULL, NULL, 2813, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(338, 8, 0, NULL, 2, 0.00, 0.00, '[20,77,87]', '[19]', 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435710, 80.9405609, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 13.36, 94.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-07 11:09:29', '2026-02-07 11:10:16', '', 0, NULL, NULL, NULL, NULL, NULL, 4646, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(339, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 17, 2, 'Mini', 4, 'Hyundai', 7, 'i10', '195/1, New Delhi, Delhi, 110055', 28.6408559, 77.2077038, 'Lucknow, Uttar Pradesh, India', 26.8466937, 80.9461660, 533.29, 263.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-07 11:10:11', '2026-02-07 11:10:15', '', 0, NULL, NULL, NULL, NULL, NULL, 7656, NULL, 'aman', 7705827321, NULL, NULL),
(340, 8, 0, NULL, 2, 0.00, 0.00, '[20,77,87]', '[19]', 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435710, 80.9405609, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 13.36, 94.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-07 11:13:42', '2026-02-07 11:16:36', '', 0, NULL, NULL, NULL, NULL, NULL, 4669, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(341, 5, 0, NULL, 2, 0.00, 0.00, '[20,77,87]', '[19]', 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435710, 80.9405609, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 13.36, 94.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-07 11:16:43', '2026-02-26 03:59:57', '', 0, NULL, NULL, NULL, NULL, NULL, 4484, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(342, 8, 0, NULL, 2, 0.00, 0.00, '[20,77,87]', '[19]', 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435710, 80.9405609, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 13.36, 94.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-07 11:18:24', '2026-02-07 11:18:52', '', 0, NULL, NULL, NULL, NULL, NULL, 9090, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(343, 8, 0, NULL, 2, 0.00, 0.00, '[20,77,87]', '[19]', 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435710, 80.9405609, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 13.36, 94.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-07 11:18:54', '2026-02-07 11:19:10', '', 0, NULL, NULL, NULL, NULL, NULL, 5092, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(344, 8, 0, NULL, 2, 0.00, 0.00, '[20,77,87]', '[19]', 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435710, 80.9405609, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 13.36, 94.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-07 11:20:21', '2026-02-07 11:20:41', '', 0, NULL, NULL, NULL, NULL, NULL, 2031, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(345, 8, 0, NULL, 2, 0.00, 0.00, '[20,77,87]', '[19]', 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435710, 80.9405609, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 13.36, 94.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-07 11:20:45', '2026-02-07 11:22:50', '', 0, NULL, NULL, NULL, NULL, NULL, 8809, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(347, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87]', NULL, 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435751, 80.9405712, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-07 12:36:20', '2026-02-07 12:36:47', '', 0, NULL, NULL, NULL, NULL, NULL, 1951, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(353, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,87]', '[19]', 4, 3, 'Bike', 6, 'Bajaj', 11, 'Pulsar 150', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435758, 80.9405642, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-09 13:42:54', '2026-02-09 13:43:10', '', 0, NULL, NULL, NULL, NULL, NULL, 4111, NULL, 'Ramu ', 8423953286, NULL, NULL),
(354, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,87]', '[19]', 4, 3, 'Bike', 6, 'Bajaj', 11, 'Pulsar 150', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435758, 80.9405642, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-09 13:43:12', '2026-02-09 13:43:36', '', 0, NULL, NULL, NULL, NULL, NULL, 8233, NULL, 'Ramu ', 8423953286, NULL, NULL),
(355, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,87]', '[19]', 4, 3, 'Bike', 6, 'Bajaj', 11, 'Pulsar 150', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435758, 80.9405642, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-09 13:46:56', '2026-02-09 13:47:13', '', 0, NULL, NULL, NULL, NULL, NULL, 8154, NULL, 'Ramu ', 8423953286, NULL, NULL),
(356, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,87]', '[19]', 4, 3, 'Bike', 6, 'Bajaj', 11, 'Pulsar 150', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435758, 80.9405642, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-09 13:49:31', '2026-02-09 13:49:45', '', 0, NULL, NULL, NULL, NULL, NULL, 8513, NULL, 'Ramu ', 8423953286, NULL, NULL),
(357, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,87]', '[19]', 4, 3, 'Bike', 6, 'Bajaj', 11, 'Pulsar 150', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435758, 80.9405642, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-09 13:52:04', '2026-02-09 13:52:16', '', 0, NULL, NULL, NULL, NULL, NULL, 5647, NULL, 'Ramu ', 8423953286, NULL, NULL),
(358, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87]', NULL, 4, 3, 'Bike', 6, 'Bajaj', 11, 'Pulsar 150', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435758, 80.9405642, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-09 13:55:48', '2026-02-09 13:55:56', '', 0, NULL, NULL, NULL, NULL, NULL, 7145, NULL, 'Ramu ', 8423953286, NULL, NULL),
(359, 8, 0, NULL, 1, 0.00, 0.00, '[20,77]', '[87]', 4, 3, 'Bike', 6, 'Bajaj', 11, 'Pulsar 150', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435758, 80.9405642, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-09 13:57:11', '2026-02-09 13:59:34', '', 0, NULL, NULL, NULL, NULL, NULL, 4989, NULL, 'Ramu ', 8423953286, NULL, NULL),
(361, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,87]', '[19]', 4, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435681, 80.9405741, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-09 14:54:25', '2026-02-09 14:54:36', '', 0, NULL, NULL, NULL, NULL, NULL, 6783, NULL, 'Ramu ', 8423953286, NULL, NULL),
(362, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,87]', '[19]', 4, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435681, 80.9405741, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-09 15:04:35', '2026-02-09 15:04:59', '', 0, NULL, NULL, NULL, NULL, NULL, 8370, NULL, 'Ramu ', 8423953286, NULL, NULL),
(363, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,87]', '[19]', 4, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435681, 80.9405741, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-09 15:05:02', '2026-02-09 15:05:30', '', 0, NULL, NULL, NULL, NULL, NULL, 9295, NULL, 'Ramu ', 8423953286, NULL, NULL),
(364, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,87]', NULL, 4, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435681, 80.9405741, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-09 15:05:58', '2026-02-09 15:06:06', '', 0, NULL, NULL, NULL, NULL, NULL, 4414, NULL, 'Ramu ', 8423953286, NULL, NULL),
(365, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,87]', '[19]', 4, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435673, 80.9405741, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-09 15:37:55', '2026-02-09 15:38:20', '', 0, NULL, NULL, NULL, NULL, NULL, 1676, NULL, 'Ramu ', 8423953286, NULL, NULL),
(368, 8, 0, NULL, 1, 0.00, 0.00, '[78,88]', NULL, 17, 2, 'Mini', 12, 'DZIRE', 5, 'Dzire', 'Vistar Yojna, AKTU CDRI Rd, Naya Khera, Jankipuram, Lucknow, Mirzapur, Uttar Pradesh 226031, India', 26.9442409, 80.9401147, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 78.60, 1236.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-09 19:51:26', '2026-02-09 19:52:31', '', 0, NULL, NULL, NULL, NULL, NULL, 5269, NULL, 'aman', 7705827321, NULL, NULL),
(370, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWJG+6HP, Bargadi Magath, Uttar Pradesh, 226201', 26.9805286, 80.9264764, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.18, 1227.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-09 22:37:53', '2026-02-09 22:38:42', '', 0, NULL, NULL, NULL, NULL, NULL, 1101, NULL, 'aman', 7705827321, NULL, NULL),
(372, 8, 0, NULL, 1, 0.00, 0.00, '[78,88]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 'Barabanki, Uttar Pradesh, India', 26.9268042, 81.1833809, 21.31, 362.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-10 09:30:48', '2026-02-10 09:31:40', '', 0, NULL, NULL, NULL, NULL, NULL, 1547, NULL, 'aman', 7705827321, NULL, NULL),
(373, 6, 0, NULL, 1, 0.00, 0.00, '[78,88,93]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 'Barabanki, Uttar Pradesh, India', 26.9268042, 81.1833809, 21.31, 362.00, NULL, '', 1, NULL, 0, NULL, '2026-02-10 09:31:42', '2026-02-10 09:32:02', '', 0, NULL, NULL, NULL, NULL, NULL, 5731, NULL, 'aman', 7705827321, NULL, NULL),
(377, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93]', NULL, 20, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'Alambagh, Lucknow, Uttar Pradesh, India', 26.8127442, 80.9012798, 'Khargapur, Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8434346, 81.0224849, 15.82, 269.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-10 09:44:22', '2026-02-10 09:44:52', '', 0, NULL, NULL, NULL, NULL, NULL, 1971, NULL, 'aman', 8303204543, NULL, NULL),
(378, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93]', NULL, 20, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'Alambagh, Lucknow, Uttar Pradesh, India', 26.8127442, 80.9012798, 'Khargapur, Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8434346, 81.0224849, 15.82, 269.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-10 09:44:55', '2026-02-10 09:46:14', '', 0, NULL, NULL, NULL, NULL, NULL, 5436, NULL, 'aman', 8303204543, NULL, NULL),
(379, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93]', NULL, 20, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'Alambagh, Lucknow, Uttar Pradesh, India', 26.8127442, 80.9012798, 'Khargapur, Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8434346, 81.0224849, 15.82, 269.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-10 09:46:18', '2026-02-10 09:46:31', '', 0, NULL, NULL, NULL, NULL, NULL, 8341, NULL, 'aman', 8303204543, NULL, NULL),
(381, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93]', NULL, 20, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823317, 80.9316652, 'VW3H+77Q, Kaiser Bagh, Lucknow, Uttar Pradesh 226018, India', 26.8532129, 80.9282270, 16.97, 269.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-10 09:47:59', '2026-02-10 09:48:40', '', 0, NULL, NULL, NULL, NULL, NULL, 3831, NULL, 'aman', 8303204543, NULL, NULL),
(385, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,87]', NULL, 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435686, 80.9405728, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-10 10:15:09', '2026-02-10 10:15:37', '', 0, NULL, NULL, NULL, NULL, NULL, 6399, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(389, 8, 0, NULL, 2, 0.00, 0.00, '[20,77,87]', '[19]', 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9436867, 80.9405467, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 101.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-10 10:19:58', '2026-02-10 10:20:13', '', 0, NULL, NULL, NULL, NULL, NULL, 3098, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(392, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93]', NULL, 20, 2, 'Mini', 4, 'Hyundai', 17, 'Hyundai Venue', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822273, 80.9317057, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.68, 313.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-10 10:28:57', '2026-02-10 10:29:46', '', 0, NULL, NULL, NULL, NULL, NULL, 6962, NULL, 'aman', 8303204543, NULL, NULL),
(393, 6, 0, NULL, 1, 0.00, 0.00, '[78,88,93]', NULL, 20, 2, 'Mini', 4, 'Hyundai', 17, 'Hyundai Venue', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822273, 80.9317057, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.68, 313.00, NULL, '', 1, NULL, 0, NULL, '2026-02-10 10:29:52', '2026-02-10 10:31:36', '', 0, NULL, NULL, NULL, NULL, NULL, 9728, NULL, 'aman', 8303204543, NULL, NULL),
(396, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'Charbagh, Lucknow, Uttar Pradesh, India', 26.8322933, 80.9214337, 'Barbanki, West Bengal 721659, India', 22.0825194, 87.8316429, 1083.71, 1236.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-10 10:39:21', '2026-02-10 10:39:56', '', 0, NULL, NULL, NULL, NULL, NULL, 4259, NULL, 'aman', 7705827321, NULL, NULL),
(398, 6, 0, NULL, 1, 0.00, 0.00, '[78,88]', '[93]', 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 'Lakhimpur, Uttar Pradesh 262701, India', 27.9462395, 80.7787163, 129.80, 1298.00, NULL, '', 1, NULL, 0, NULL, '2026-02-10 10:41:41', '2026-02-10 10:42:29', '', 0, NULL, NULL, NULL, NULL, NULL, 9180, NULL, 'aman', 7705827321, NULL, NULL),
(402, 8, 0, NULL, 1, 0.00, 0.00, '[78,88]', '[93]', 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822848, 80.9317665, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.69, 1236.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-10 11:01:24', '2026-02-10 11:03:13', '', 0, NULL, NULL, NULL, NULL, NULL, 2636, NULL, 'aman', 7705827321, NULL, NULL),
(403, 8, 0, NULL, 1, 0.00, 0.00, '[78,88]', '[93]', 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822848, 80.9317665, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.69, 1236.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-10 11:03:18', '2026-02-10 11:03:59', '', 0, NULL, NULL, NULL, NULL, NULL, 2886, NULL, 'aman', 7705827321, NULL, NULL),
(404, 8, 0, NULL, 1, 0.00, 0.00, '[78,88]', '[93]', 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822848, 80.9317665, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.69, 1236.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-10 11:04:02', '2026-02-10 11:04:29', '', 0, NULL, NULL, NULL, NULL, NULL, 8736, NULL, 'aman', 7705827321, NULL, NULL),
(410, 8, 0, NULL, 1, 0.00, 0.00, '[78,93]', '[88]', 17, 2, 'Mini', 4, 'Hyundai', 17, 'Hyundai Venue', 'Sidhauli, Uttar Pradesh, India', 27.2820753, 80.8344294, 'Lakhimpur, Uttar Pradesh 262701, India', 27.9462395, 80.7787163, 79.18, 1265.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-10 13:12:20', '2026-02-10 13:13:19', '', 0, NULL, NULL, NULL, NULL, NULL, 9397, NULL, 'aman', 7705827321, NULL, NULL),
(411, 6, 0, NULL, 1, 0.00, 0.00, '[78,88,93]', NULL, 17, 2, 'Mini', 4, 'Hyundai', 17, 'Hyundai Venue', 'Sidhauli, Uttar Pradesh, India', 27.2820753, 80.8344294, 'Lakhimpur, Uttar Pradesh 262701, India', 27.9462395, 80.7787163, 79.18, 1265.00, NULL, '', 1, NULL, 0, NULL, '2026-02-10 13:13:22', '2026-02-10 13:14:45', '', 0, NULL, NULL, NULL, NULL, NULL, 6944, NULL, 'aman', 7705827321, NULL, NULL),
(412, 6, 0, NULL, 1, 0.00, 0.00, '[88]', NULL, 17, 2, 'Mini', 4, 'Hyundai', 17, 'Hyundai Venue', 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 'Pilibhit, Uttar Pradesh 262001, India', 28.6249400, 79.8075272, 167.54, 1346.00, NULL, '', 1, NULL, 0, NULL, '2026-02-10 13:15:18', '2026-02-10 13:16:07', '', 0, NULL, NULL, NULL, NULL, NULL, 1425, NULL, 'aman', 7705827321, NULL, NULL),
(413, 8, 0, NULL, 1, 0.00, 0.00, '[88]', NULL, 17, 2, 'Mini', 4, 'Hyundai', 17, 'Hyundai Venue', 'Khairabad, Uttar Pradesh, India', 27.5284275, 80.7491563, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 9.35, 281.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-10 13:16:38', '2026-02-10 13:18:30', '', 0, NULL, NULL, NULL, NULL, NULL, 1621, NULL, 'aman', 7705827321, NULL, NULL),
(415, 8, 0, NULL, 1, 0.00, 0.00, '[78]', '[93]', 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'Daliganj, Lucknow, Uttar Pradesh, India', 26.8727982, 80.9275954, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 84.26, 2200.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-10 14:45:29', '2026-02-10 14:45:58', '', 0, NULL, NULL, NULL, NULL, NULL, 7003, NULL, 'aman', 7705827321, NULL, NULL),
(416, 6, 0, NULL, 1, 0.00, 0.00, '[88]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 'Shahjahanpur, Uttar Pradesh, India', 27.8753399, 79.9147268, 88.91, 1432.00, NULL, '', 1, NULL, 0, NULL, '2026-02-10 14:46:29', '2026-02-10 14:47:02', '', 0, NULL, NULL, NULL, NULL, NULL, 3814, NULL, 'aman', 7705827321, NULL, NULL),
(418, 8, 0, NULL, 1, 0.00, 0.00, '[78]', '[93]', 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'VW3H+77Q, Kaiser Bagh, Lucknow, Uttar Pradesh 226018, India', 26.8532129, 80.9282270, 'Polytechnic Chauraha, Block D, Indira Nagar, Lucknow, Uttar Pradesh, India', 26.8731342, 80.9955176, 9.90, 297.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-10 14:55:27', '2026-02-10 14:56:31', '', 0, NULL, NULL, NULL, NULL, NULL, 7914, NULL, 'aman', 7705827321, NULL, NULL),
(419, 8, 0, NULL, 1, 0.00, 0.00, '[88]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 'Lucknow, Uttar Pradesh, India', 26.8466937, 80.9461660, 88.48, 297.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-10 14:57:16', '2026-02-10 14:57:39', '', 0, NULL, NULL, NULL, NULL, NULL, 3307, NULL, 'aman', 7705827321, NULL, NULL),
(420, 8, 0, NULL, 1, 0.00, 0.00, '[78,93]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823182, 80.9317677, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.69, 1236.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-10 14:58:26', '2026-02-10 14:59:04', '', 0, NULL, NULL, NULL, NULL, NULL, 1878, NULL, 'aman', 7705827321, NULL, NULL),
(424, 6, 0, NULL, 1, 0.00, 0.00, '[78,93]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823461, 80.9317734, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.61, 1234.00, NULL, '', 1, NULL, 0, NULL, '2026-02-10 18:07:24', '2026-02-10 18:07:34', '', 0, NULL, NULL, NULL, NULL, NULL, 4790, NULL, 'aman', 7705827321, NULL, NULL),
(425, 8, 0, NULL, 1, 0.00, 0.00, '[78,93]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823461, 80.9317734, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.61, 1234.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-10 18:07:42', '2026-02-10 18:07:57', '', 0, NULL, NULL, NULL, NULL, NULL, 1150, NULL, 'aman', 7705827321, NULL, NULL),
(428, 8, 0, NULL, 1, 0.00, 0.00, '[88,96]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'Laharpur, Uttar Pradesh 261135, India', 27.7100960, 80.9014160, 'Shahjahanpur, Uttar Pradesh, India', 27.8753399, 79.9147268, 122.91, 1229.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-10 18:33:10', '2026-02-10 18:35:22', '', 0, NULL, NULL, NULL, NULL, NULL, 7885, NULL, 'aman', 7705827321, NULL, NULL),
(433, 6, 0, NULL, 1, 0.00, 0.00, '[96]', '[88]', 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'Laharpur, Uttar Pradesh 261135, India', 27.7100960, 80.9014160, 'Barbanki, West Bengal 721659, India', 22.0825194, 87.8316429, 1200.02, 567.00, NULL, '', 1, NULL, 0, NULL, '2026-02-10 18:43:44', '2026-02-10 18:44:03', '', 0, NULL, NULL, NULL, NULL, NULL, 3683, NULL, 'aman', 7705827321, NULL, NULL),
(436, 8, 0, NULL, 1, 0.00, 0.00, '[78]', '[93]', 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823278, 80.9317639, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.69, 1236.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-10 18:53:17', '2026-02-10 18:54:22', '', 0, NULL, NULL, NULL, NULL, NULL, 2744, NULL, 'aman', 7705827321, NULL, NULL),
(437, 8, 0, NULL, 1, 0.00, 0.00, '[78]', '[93]', 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823278, 80.9317639, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.69, 1236.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-10 18:54:25', '2026-02-10 18:55:42', '', 0, NULL, NULL, NULL, NULL, NULL, 6429, NULL, 'aman', 7705827321, NULL, NULL),
(440, 8, 0, NULL, 1, 0.00, 0.00, '[78]', '[93]', 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 'Amar Shaheed Path, Golf City, Sector B Ansal API, Lucknow, Hariharpur, Uttar Pradesh 226030, India', 26.7846669, 80.9911459, 22.19, 377.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-10 19:05:41', '2026-02-10 19:06:39', '', 0, NULL, NULL, NULL, NULL, NULL, 6604, NULL, 'aman', 7705827321, NULL, NULL),
(441, 6, 0, NULL, 1, 0.00, 0.00, '[78,93]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 'Amar Shaheed Path, Golf City, Sector B Ansal API, Lucknow, Hariharpur, Uttar Pradesh 226030, India', 26.7846669, 80.9911459, 22.19, 377.00, NULL, '', 1, NULL, 0, NULL, '2026-02-10 19:06:42', '2026-02-10 19:07:06', '', 0, NULL, NULL, NULL, NULL, NULL, 3200, NULL, 'aman', 7705827321, NULL, NULL),
(443, 8, 0, NULL, 1, 0.00, 0.00, '[78]', '[93]', 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823555, 80.9316995, 'Charbagh, Lucknow, Uttar Pradesh, India', 26.8322933, 80.9214337, 21.10, 349.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-10 19:16:20', '2026-02-10 19:17:10', '', 0, NULL, NULL, NULL, NULL, NULL, 7241, NULL, 'aman', 7705827321, NULL, NULL),
(445, 8, 0, NULL, 1, 0.00, 0.00, '[78]', '[93]', 17, 2, 'Mini', 4, 'Hyundai', 17, 'Hyundai Venue', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823593, 80.9317007, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.61, 1234.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-10 19:28:07', '2026-02-10 19:28:56', '', 0, NULL, NULL, NULL, NULL, NULL, 2905, NULL, 'aman', 7705827321, NULL, NULL),
(448, 6, 0, NULL, 1, 0.00, 0.00, '[78]', '[93]', 17, 2, 'Mini', 4, 'Hyundai', 17, 'Hyundai Venue', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823587, 80.9316514, 'Lakhimpur, Uttar Pradesh 262701, India', 27.9462395, 80.7787163, 114.31, 1236.00, NULL, '', 1, NULL, 0, NULL, '2026-02-10 20:09:29', '2026-02-10 20:10:04', '', 0, NULL, NULL, NULL, NULL, NULL, 8457, NULL, 'aman', 7705827321, NULL, NULL),
(451, 6, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87]', NULL, 20, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9821850, 80.9315067, 'Amar Shaheed Path, Golf City, Sector B Ansal API, Lucknow, Hariharpur, Uttar Pradesh 226030, India', 26.7846669, 80.9911459, 30.69, 184.00, NULL, '', 1, NULL, 0, NULL, '2026-02-10 20:13:51', '2026-02-10 20:14:23', '', 0, NULL, NULL, NULL, NULL, NULL, 2234, NULL, 'aman', 8303204543, NULL, NULL),
(453, 6, 0, NULL, 1, 0.00, 0.00, '[88,96]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'JVJX+C57, Takeli, Uttar Pradesh 261135, India', 27.6310362, 80.8979158, 'Kanpur, Uttar Pradesh, India', 26.4499230, 80.3318736, 192.46, 1925.00, NULL, '', 1, NULL, 0, NULL, '2026-02-10 20:59:42', '2026-02-10 21:00:16', '', 0, NULL, NULL, NULL, NULL, NULL, 7183, NULL, 'aman', 7705827321, NULL, NULL),
(455, 6, 0, NULL, 1, 0.00, 0.00, '[78,93]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823306, 80.9317004, 'Delhi, India', 28.7040592, 77.1024902, 566.30, 5663.00, NULL, '', 1, NULL, 0, NULL, '2026-02-10 21:09:02', '2026-02-10 21:09:48', '', 0, NULL, NULL, NULL, NULL, NULL, 1986, NULL, 'aman', 7705827321, NULL, NULL),
(456, 6, 0, NULL, 1, 0.00, 0.00, '[96]', '[88]', 38, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'JVJX+JWP, Takeli, Uttar Pradesh, 261135', 27.6320062, 80.9012060, 'Laharpur, Uttar Pradesh 261135, India', 27.7100960, 80.9014160, 12.87, 386.00, NULL, '', 1, NULL, 0, NULL, '2026-02-10 21:09:21', '2026-02-10 21:10:20', '', 0, NULL, NULL, NULL, NULL, NULL, 6340, NULL, 'rahul ', 8173006663, NULL, NULL),
(457, 6, 0, NULL, 1, 0.00, 0.00, '[96]', '[88]', 38, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'JVJX+JWP, Takeli, Uttar Pradesh, 261135', 27.6320062, 80.9012060, 'Laharpur, Uttar Pradesh 261135, India', 27.7100960, 80.9014160, 12.87, 386.00, NULL, '', 1, NULL, 0, NULL, '2026-02-10 21:10:26', '2026-02-10 21:10:49', '', 0, NULL, NULL, NULL, NULL, NULL, 1518, NULL, 'rahul ', 8173006663, NULL, NULL),
(458, 6, 0, NULL, 1, 0.00, 0.00, '[88,96]', NULL, 38, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'JVJX+JWP, Takeli, Uttar Pradesh, 261135', 27.6320062, 80.9012060, 'Laharpur, Uttar Pradesh 261135, India', 27.7100960, 80.9014160, 12.87, 386.00, NULL, '', 1, NULL, 0, NULL, '2026-02-10 21:10:54', '2026-02-10 21:11:05', '', 0, NULL, NULL, NULL, NULL, NULL, 6676, NULL, 'rahul ', 8173006663, NULL, NULL),
(460, 6, 0, NULL, 1, 0.00, 0.00, '[78,93]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822686, 80.9317657, 'Lakhimpur, Uttar Pradesh 262701, India', 27.9462395, 80.7787163, 114.30, 1143.00, NULL, '', 1, NULL, 0, NULL, '2026-02-10 22:55:40', '2026-02-10 22:56:21', '', 0, NULL, NULL, NULL, NULL, NULL, 3709, NULL, 'aman', 7705827321, NULL, NULL),
(461, 8, 0, NULL, 1, 0.00, 0.00, '[78,93]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822686, 80.9317657, 'Lakhimpur, Uttar Pradesh 262701, India', 27.9462395, 80.7787163, 114.30, 1143.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-10 22:56:23', '2026-02-10 22:57:37', '', 0, NULL, NULL, NULL, NULL, NULL, 9091, NULL, 'aman', 7705827321, NULL, NULL),
(463, 8, 0, NULL, 1, 0.00, 0.00, '[78]', NULL, 17, 2, 'Mini', 4, 'Hyundai', 17, 'Hyundai Venue', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822712, 80.9317664, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.68, 1236.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-10 23:04:56', '2026-02-10 23:05:36', '', 0, NULL, NULL, NULL, NULL, NULL, 4742, NULL, 'aman', 7705827321, NULL, NULL),
(465, 8, 0, NULL, 1, 0.00, 0.00, '[78]', '[93]', 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822499, 80.9316300, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.68, 1236.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-11 10:32:04', '2026-02-11 10:32:48', '', 0, NULL, NULL, NULL, NULL, NULL, 8580, NULL, 'aman', 7705827321, NULL, NULL),
(469, 8, 0, NULL, 1, 0.00, 0.00, '[78,93]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822827, 80.9316726, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.68, 1236.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-11 22:22:14', '2026-02-11 22:22:36', '', 0, NULL, NULL, NULL, NULL, NULL, 4848, NULL, 'aman', 7705827321, NULL, NULL),
(474, 6, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87,98]', NULL, 4, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435717, 80.9405616, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, '', 1, NULL, 0, NULL, '2026-02-12 09:41:39', '2026-02-12 09:42:07', '', 0, NULL, NULL, NULL, NULL, NULL, 2991, NULL, 'Ramu ', 8423953286, NULL, NULL),
(475, 6, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87,98]', NULL, 4, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435717, 80.9405616, 'Barabanki, Uttar Pradesh, India', 26.9268042, 81.1833809, 32.79, 121.00, NULL, '', 1, NULL, 0, NULL, '2026-02-12 09:42:25', '2026-02-12 09:42:46', '', 0, NULL, NULL, NULL, NULL, NULL, 2237, NULL, 'Ramu ', 8423953286, NULL, NULL),
(476, 6, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 4, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 'Barabanki, Uttar Pradesh, India', 26.9268042, 81.1833809, 110.93, 555.00, NULL, '', 1, NULL, 0, NULL, '2026-02-12 09:43:06', '2026-02-12 09:43:39', '', 0, NULL, NULL, NULL, NULL, NULL, 7374, NULL, 'Ramu ', 8423953286, NULL, NULL),
(477, 7, 0, 98, 1, 0.00, 716.00, '[19,20,77,87,98]', NULL, 4, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435709, 80.9405621, 'Ayodhya, Uttar Pradesh, India', 26.7921605, 82.1997954, 140.29, 701.00, 119, 'User not responding', 1, NULL, 0, NULL, '2026-02-12 09:44:05', '2026-02-12 09:44:47', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1770867607064.jpg', 'Black', 'nitin pandey', 'UP 32 LK 5612', 9208339102, 2382, 4.5, 'Ramu ', 8423953286, NULL, NULL),
(479, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,87,98]', '[19]', 4, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435613, 80.9405691, 'Tedhi Pulia, Sector D, Jankipuram, Lucknow, Uttar Pradesh 226021, India', 26.9170385, 80.9543270, 4.88, 39.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-12 10:33:25', '2026-02-12 10:34:19', '', 0, NULL, NULL, NULL, NULL, NULL, 8999, NULL, 'Ramu ', 8423953286, NULL, NULL),
(480, 8, 0, NULL, 1, 0.00, 0.00, '[78,93]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823297, 80.9317563, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.69, 1236.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-12 10:37:34', '2026-02-12 10:38:05', '', 0, NULL, NULL, NULL, NULL, NULL, 8958, NULL, 'aman', 7705827321, NULL, NULL),
(481, 6, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87,98]', '[91]', 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435672, 80.9405663, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 39.00, NULL, '', 1, NULL, 0, NULL, '2026-02-12 10:47:04', '2026-02-12 10:48:19', '', 0, NULL, NULL, NULL, NULL, NULL, 1366, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(482, 6, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87,98]', '[91]', 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435672, 80.9405663, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 39.00, NULL, '', 1, NULL, 0, NULL, '2026-02-12 10:48:56', '2026-02-12 10:49:17', '', 0, NULL, NULL, NULL, NULL, NULL, 9569, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(483, 6, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87,98]', '[91]', 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435672, 80.9405663, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 39.00, NULL, '', 1, NULL, 0, NULL, '2026-02-12 10:49:31', '2026-02-12 10:50:19', '', 0, NULL, NULL, NULL, NULL, NULL, 2726, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(484, 6, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87,98]', '[91]', 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435672, 80.9405663, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 115.00, NULL, '', 1, NULL, 0, NULL, '2026-02-12 10:51:25', '2026-02-12 10:52:22', '', 0, NULL, NULL, NULL, NULL, NULL, 6182, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(485, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87,98]', '[91]', 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435705, 80.9405623, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-12 11:10:01', '2026-02-12 11:10:37', '', 0, NULL, NULL, NULL, NULL, NULL, 3334, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(486, 6, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87,98]', '[91]', 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435705, 80.9405623, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, '', 1, NULL, 0, NULL, '2026-02-12 11:10:44', '2026-02-12 11:11:27', '', 0, NULL, NULL, NULL, NULL, NULL, 4928, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(487, 6, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87,98]', '[91]', 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435668, 80.9405740, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, '', 1, NULL, 0, NULL, '2026-02-12 11:13:01', '2026-02-12 11:13:24', '', 0, NULL, NULL, NULL, NULL, NULL, 9722, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(488, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,98]', '[91]', 20, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9821667, 80.9317017, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 22.32, 156.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-12 11:27:11', '2026-02-12 11:28:05', '', 0, NULL, NULL, NULL, NULL, NULL, 6304, NULL, 'aman', 8303204543, NULL, NULL),
(489, 6, 0, NULL, 1, 0.00, 0.00, '[78,93]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWJJ+XHR, Bargadi Magath, Uttar Pradesh, 226201', 26.9820644, 80.9316374, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 22.30, 379.00, NULL, '', 1, NULL, 0, NULL, '2026-02-12 11:32:44', '2026-02-12 11:33:01', '', 0, NULL, NULL, NULL, NULL, NULL, 5839, NULL, 'aman', 7705827321, NULL, NULL),
(490, 8, 0, NULL, 1, 0.00, 0.00, '[78]', '[93]', 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822373, 80.9318883, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.69, 1236.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-12 11:48:25', '2026-02-12 11:49:26', '', 0, NULL, NULL, NULL, NULL, NULL, 8185, NULL, 'aman', 7705827321, NULL, NULL),
(492, 8, 0, NULL, 1, 0.00, 0.00, '[78,93]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822011, 80.9316413, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.67, 1235.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-12 21:27:56', '2026-02-12 21:29:19', '', 0, NULL, NULL, NULL, NULL, NULL, 9070, NULL, 'aman', 7705827321, NULL, NULL),
(494, 6, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87,91,98]', NULL, 41, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'WWVR+M4M, Sector 11, Jankipuram Vistar, Lucknow, Mirzapur, Uttar Pradesh 226031, India', 26.9442086, 80.9402825, 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 4.93, 39.00, NULL, '', 1, NULL, 0, NULL, '2026-02-13 10:21:47', '2026-02-13 10:22:21', '', 0, NULL, NULL, NULL, NULL, NULL, 4020, NULL, 'pragy', 7705020474, NULL, NULL),
(495, 7, 0, 91, 1, 0.00, 30.00, '[19,20,77,87,91,98]', NULL, 42, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435680, 80.9405741, 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 4.49, 27.00, 120, 'Trip distance too short', 1, NULL, 0, NULL, '2026-02-13 10:35:56', '2026-02-13 10:37:44', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769192716418.jpg', NULL, 'ncbcbd bdbddb', NULL, 9636962851, 9983, 4.5, 'pragya', 7705018444, NULL, NULL),
(496, 6, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87,91,98]', NULL, 17, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Tahsil Road, Lucknow, Uttar Pradesh, 226202', 27.0036317, 80.9078817, 'Charbagh, Lucknow, Uttar Pradesh, India', 26.8322933, 80.9214337, 24.51, 172.00, NULL, '', 1, NULL, 0, NULL, '2026-02-13 15:17:09', '2026-02-13 15:17:26', '', 0, NULL, NULL, NULL, NULL, NULL, 2717, NULL, 'aman', 7705827321, NULL, NULL),
(499, 8, 0, NULL, 1, 0.00, 0.00, '[78]', '[93]', 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822142, 80.9317182, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.68, 1236.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-14 09:43:31', '2026-02-14 09:46:01', '', 0, NULL, NULL, NULL, NULL, NULL, 9664, NULL, 'aman', 7705827321, NULL, NULL),
(500, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 6, 'WagonR', 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 'Lucknow, Uttar Pradesh, India', 26.8466937, 80.9461660, 93.13, 1583.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-14 12:32:36', '2026-02-14 12:33:22', '', 0, NULL, NULL, NULL, NULL, NULL, 4245, NULL, 'aman', 7705827321, NULL, NULL),
(501, 6, 0, NULL, 1, 0.00, 0.00, '[19,20,77,91,98]', '[87]', 20, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823276, 80.9316988, 'Charbagh, Lucknow, Uttar Pradesh, India', 26.8322933, 80.9214337, 21.10, 148.00, NULL, '', 1, NULL, 0, NULL, '2026-02-14 16:19:07', '2026-02-14 16:20:36', '', 0, NULL, NULL, NULL, NULL, NULL, 6187, NULL, 'aman', 8303204543, NULL, NULL),
(503, 6, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87,91,98]', NULL, 20, 3, 'Bike', 5, 'Honda', 10, 'Shine', 'Shree Vinayak General Store Shyam Vihar Colony, Lucknow, Uttar Pradesh, 226201', 26.9837740, 80.9320780, 'RWJH+C32, Railway Colony, Charbagh, Lucknow, Uttar Pradesh 226004, India', 26.8310060, 80.9276460, 20.41, 143.00, NULL, '', 1, NULL, 0, NULL, '2026-02-14 18:37:57', '2026-02-14 18:39:18', '', 0, NULL, NULL, NULL, NULL, NULL, 6960, NULL, 'aman', 8303204543, NULL, NULL),
(511, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,91,98]', '[87]', 17, 3, 'Bike', 5, 'Honda', 10, 'Shine', 'XWMJ+FQF, Bargadi Magath, Uttar Pradesh, 226201', 26.9837498, 80.9321168, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.44, 362.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-14 19:11:51', '2026-02-14 19:12:47', '', 0, NULL, NULL, NULL, NULL, NULL, 2360, NULL, 'aman', 7705827321, NULL, NULL),
(513, 6, 0, NULL, 1, 0.00, 0.00, '[78,93]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'KH N 638, Lucknow, Uttar Pradesh, 226201', 26.9838040, 80.9322346, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.45, 1232.00, NULL, '', 1, NULL, 0, NULL, '2026-02-14 19:32:17', '2026-02-14 19:34:03', '', 0, NULL, NULL, NULL, NULL, NULL, 8707, NULL, 'aman', 7705827321, NULL, NULL),
(514, 8, 0, NULL, 1, 0.00, 0.00, '[78,93]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'KH N 638, Lucknow, Uttar Pradesh, 226201', 26.9838040, 80.9322346, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.45, 1232.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-14 19:34:06', '2026-02-14 19:35:18', '', 0, NULL, NULL, NULL, NULL, NULL, 3992, NULL, 'aman', 7705827321, NULL, NULL),
(515, 8, 0, NULL, 1, 0.00, 0.00, '[78]', '[93]', 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+FQF, Bargadi Magath, Uttar Pradesh, 226201', 26.9836936, 80.9319918, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.43, 1231.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-14 19:37:09', '2026-02-14 19:39:38', '', 0, NULL, NULL, NULL, NULL, NULL, 3786, NULL, 'aman', 7705827321, NULL, NULL),
(516, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87,91,98]', NULL, 17, 3, 'Bike', 5, 'Honda', 10, 'Shine', 'XWMJ+FQF, Bargadi Magath, Uttar Pradesh, 226201', 26.9836483, 80.9320273, 'Alambagh, Lucknow, Uttar Pradesh, India', 26.8127442, 80.9012798, 30.46, 183.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-14 19:41:09', '2026-02-14 19:41:37', '', 0, NULL, NULL, NULL, NULL, NULL, 3921, NULL, 'aman', 7705827321, NULL, NULL),
(517, 6, 0, NULL, 1, 0.00, 0.00, '[78]', '[93]', 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+FQF, Bargadi Magath, Uttar Pradesh, 226201', 26.9837114, 80.9320132, 'Delhi, India', 28.7040592, 77.1024902, 566.04, 5660.00, NULL, '', 1, NULL, 0, NULL, '2026-02-14 19:42:37', '2026-02-14 19:44:22', '', 0, NULL, NULL, NULL, NULL, NULL, 9298, NULL, 'aman', 7705827321, NULL, NULL),
(518, 8, 0, NULL, 1, 0.00, 0.00, '[78,93]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+FQF, Bargadi Magath, Uttar Pradesh, 226201', 26.9837114, 80.9320132, 'Delhi, India', 28.7040592, 77.1024902, 566.04, 5660.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-14 19:44:26', '2026-02-14 19:45:26', '', 0, NULL, NULL, NULL, NULL, NULL, 2801, NULL, 'aman', 7705827321, NULL, NULL),
(519, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87,91,98]', NULL, 17, 3, 'Bike', 5, 'Honda', 10, 'Shine', 'XWMJ+6F, Bargadi Magath, Uttar Pradesh, 226201', 26.9830515, 80.9316603, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.51, 363.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-14 19:46:07', '2026-02-14 19:46:15', '', 0, NULL, NULL, NULL, NULL, NULL, 2205, NULL, 'aman', 7705827321, NULL, NULL),
(520, 8, 0, NULL, 1, 0.00, 0.00, '[78,93]', NULL, 20, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'Shree Vinayak General Store Shyam Vihar Colony, Lucknow, Uttar Pradesh, 226201', 26.9837908, 80.9320904, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.44, 1231.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-14 19:50:17', '2026-02-14 19:51:17', '', 0, NULL, NULL, NULL, NULL, NULL, 8572, NULL, 'aman', 8303204543, NULL, NULL),
(521, 8, 0, NULL, 1, 0.00, 0.00, '[78,93]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'KH N 638, Lucknow, Uttar Pradesh, 226201', 26.9837385, 80.9321875, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.45, 1232.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-14 19:51:50', '2026-02-14 19:52:11', '', 0, NULL, NULL, NULL, NULL, NULL, 9510, NULL, 'aman', 7705827321, NULL, NULL),
(523, 6, 0, NULL, 1, 0.00, 0.00, '[78,93]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+6F, Bargadi Magath, Uttar Pradesh, 226201', 26.9830515, 80.9316603, 'Lakhimpur, Uttar Pradesh 262701, India', 27.9462395, 80.7787163, 114.13, 1141.00, NULL, '', 1, NULL, 0, NULL, '2026-02-14 19:56:24', '2026-02-14 19:57:14', '', 0, NULL, NULL, NULL, NULL, NULL, 8863, NULL, 'aman', 7705827321, NULL, NULL),
(524, 6, 0, NULL, 1, 0.00, 0.00, '[78,93]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+6F, Bargadi Magath, Uttar Pradesh, 226201', 26.9830515, 80.9316603, 'Lakhimpur, Uttar Pradesh 262701, India', 27.9462395, 80.7787163, 114.13, 1141.00, NULL, '', 1, NULL, 0, NULL, '2026-02-14 19:57:49', '2026-02-14 19:57:53', '', 0, NULL, NULL, NULL, NULL, NULL, 2023, NULL, 'aman', 7705827321, NULL, NULL),
(525, 8, 0, NULL, 1, 0.00, 0.00, '[78,93]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+6F, Bargadi Magath, Uttar Pradesh, 226201', 26.9830515, 80.9316603, 'Lakhimpur, Uttar Pradesh 262701, India', 27.9462395, 80.7787163, 114.13, 1141.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-14 19:57:57', '2026-02-14 19:58:04', '', 0, NULL, NULL, NULL, NULL, NULL, 5558, NULL, 'aman', 7705827321, NULL, NULL),
(526, 8, 0, NULL, 1, 0.00, 0.00, '[78]', '[93]', 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+6F, Bargadi Magath, Uttar Pradesh, 226201', 26.9830515, 80.9316603, 'Lakhimpur, Uttar Pradesh 262701, India', 27.9462395, 80.7787163, 114.13, 1141.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-14 19:58:08', '2026-02-14 19:58:45', '', 0, NULL, NULL, NULL, NULL, NULL, 5090, NULL, 'aman', 7705827321, NULL, NULL),
(527, 6, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87,91,98]', NULL, 17, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'XWMJ+FQF, Bargadi Magath, Uttar Pradesh, 226201', 26.9836555, 80.9320664, 'Charbagh, Lucknow, Uttar Pradesh, India', 26.8322933, 80.9214337, 20.85, 146.00, NULL, '', 1, NULL, 0, NULL, '2026-02-14 20:03:09', '2026-02-14 20:03:26', '', 0, NULL, NULL, NULL, NULL, NULL, 2516, NULL, 'aman', 7705827321, NULL, NULL);
INSERT INTO `cab_orders` (`id`, `order_status`, `wallet_apply`, `driver_id`, `pay_mode`, `amount_after_wallet`, `final_amount`, `matched_driver_id`, `ignored_drivers_id`, `user_id`, `vehicle_id`, `vehicle_name`, `brand_id`, `brand_name`, `model_id`, `model_name`, `pickup_location`, `pickup_latitude`, `pickup_longitude`, `drop_location`, `drop_latitude`, `drop_longitude`, `distance_km`, `estimated_amount`, `accepted_offer_id`, `cancel_reason`, `order_type`, `schedule_time`, `payment_status`, `coupon_id`, `created_at`, `updated_at`, `user_comment`, `over_limit_passenger`, `profile_photo`, `vehicle_color`, `driver_name`, `vehicle_plate_number`, `contact_number`, `orderOtp`, `rating`, `user_name`, `user_mobile`, `order_rating`, `cancel_by_admin`) VALUES
(529, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87,91,98]', NULL, 17, 3, 'Bike', 5, 'Honda', 10, 'Shine', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823113, 80.9317411, 'Charbagh, Lucknow, Uttar Pradesh, India', 26.8322933, 80.9214337, 21.10, 148.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-14 20:28:25', '2026-02-14 20:28:40', '', 0, NULL, NULL, NULL, NULL, NULL, 8519, NULL, 'aman', 7705827321, NULL, NULL),
(531, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87,91,98]', NULL, 17, 3, 'Bike', 5, 'Honda', 10, 'Shine', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823394, 80.9317115, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.69, 148.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-14 20:32:35', '2026-02-14 20:32:50', '', 0, NULL, NULL, NULL, NULL, NULL, 1975, NULL, 'aman', 7705827321, NULL, NULL),
(532, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 17, 4, 'Sedan', 9, 'Hyundai Verna', 16, 'Verna SX Turbo', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823394, 80.9317115, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.69, 872.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-14 20:32:56', '2026-02-14 20:33:37', '', 0, NULL, NULL, NULL, NULL, NULL, 8754, NULL, 'aman', 7705827321, NULL, NULL),
(534, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87,91,98]', NULL, 17, 3, 'Bike', 6, 'Bajaj', 11, 'Pulsar 150', 'XWMH+5MG, Bargadi Magath, Uttar Pradesh, 226201', 26.9825306, 80.9292412, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.32, 362.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-14 21:21:07', '2026-02-14 21:21:22', '', 0, NULL, NULL, NULL, NULL, NULL, 9780, NULL, 'aman', 7705827321, NULL, NULL),
(535, 8, 0, NULL, 1, 0.00, 0.00, '[78,93]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823093, 80.9317078, 'Charbagh, Lucknow, Uttar Pradesh, India', 26.8322933, 80.9214337, 21.09, 1229.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-14 21:24:20', '2026-02-14 21:24:24', '', 0, NULL, NULL, NULL, NULL, NULL, 7966, NULL, 'aman', 7705827321, NULL, NULL),
(536, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87,91,98]', NULL, 17, 3, 'Bike', 6, 'Bajaj', 11, 'Pulsar 150', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823093, 80.9317078, 'Charbagh, Lucknow, Uttar Pradesh, India', 26.8322933, 80.9214337, 21.09, 148.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-14 21:24:28', '2026-02-14 21:24:43', '', 0, NULL, NULL, NULL, NULL, NULL, 1359, NULL, 'aman', 7705827321, NULL, NULL),
(537, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87,91,98]', NULL, 17, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823210, 80.9317087, 'Charbagh, Lucknow, Uttar Pradesh, India', 26.8322933, 80.9214337, 21.09, 148.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-14 21:25:51', '2026-02-14 21:26:06', '', 0, NULL, NULL, NULL, NULL, NULL, 2855, NULL, 'aman', 7705827321, NULL, NULL),
(538, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87,91,98]', NULL, 17, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822367, 80.9318793, 'Charbagh, Lucknow, Uttar Pradesh, India', 26.8322933, 80.9214337, 21.09, 148.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-14 21:28:18', '2026-02-14 21:28:29', '', 0, NULL, NULL, NULL, NULL, NULL, 7324, NULL, 'aman', 7705827321, NULL, NULL),
(539, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,91,98]', '[87]', 17, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822367, 80.9318793, 'Charbagh, Lucknow, Uttar Pradesh, India', 26.8322933, 80.9214337, 21.09, 148.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-14 21:28:32', '2026-02-14 21:32:41', '', 0, NULL, NULL, NULL, NULL, NULL, 3753, NULL, 'aman', 7705827321, NULL, NULL),
(543, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 15, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'Lakhimpur, Uttar Pradesh 262701, India', 27.9462395, 80.7787163, 'Delhi, India', 28.7040592, 77.1024902, 473.01, 4730.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-14 22:12:13', '2026-02-14 22:12:57', '', 0, NULL, NULL, NULL, NULL, NULL, 4449, NULL, 'amar', 9759999888, NULL, NULL),
(544, 6, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 15, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'Lakhimpur, Uttar Pradesh 262701, India', 27.9462395, 80.7787163, 'Lucknow, Uttar Pradesh, India', 26.8466937, 80.9461660, 134.76, 1348.00, NULL, '', 1, NULL, 0, NULL, '2026-02-14 22:13:09', '2026-02-14 22:14:31', '', 0, NULL, NULL, NULL, NULL, NULL, 6988, NULL, 'amar', 9759999888, NULL, NULL),
(546, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87,91,98]', NULL, 17, 3, 'Bike', 6, 'Bajaj', 11, 'Pulsar 150', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822835, 80.9317779, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.69, 363.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-15 11:42:26', '2026-02-15 11:42:33', '', 0, NULL, NULL, NULL, NULL, NULL, 9879, NULL, 'aman', 7705827321, NULL, NULL),
(547, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,91,98]', '[87]', 17, 3, 'Bike', 6, 'Bajaj', 11, 'Pulsar 150', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822835, 80.9317779, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.69, 363.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-15 11:43:11', '2026-02-15 11:43:46', '', 0, NULL, NULL, NULL, NULL, NULL, 9904, NULL, 'aman', 7705827321, NULL, NULL),
(548, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87,91,98]', NULL, 17, 3, 'Bike', 6, 'Bajaj', 11, 'Pulsar 150', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822835, 80.9317779, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.69, 363.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-15 11:43:48', '2026-02-15 11:43:57', '', 0, NULL, NULL, NULL, NULL, NULL, 4682, NULL, 'aman', 7705827321, NULL, NULL),
(549, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,91,98]', '[87]', 17, 3, 'Bike', 6, 'Bajaj', 11, 'Pulsar 150', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822789, 80.9317514, 'Lucknow, Uttar Pradesh, India', 26.8466937, 80.9461660, 23.09, 162.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-15 11:44:46', '2026-02-15 11:45:33', '', 0, NULL, NULL, NULL, NULL, NULL, 5609, NULL, 'aman', 7705827321, NULL, NULL),
(552, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87,91,98]', NULL, 17, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822911, 80.9316969, 'VW3H+77Q, Kaiser Bagh, Lucknow, Uttar Pradesh 226018, India', 26.8532129, 80.9282270, 16.96, 119.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-16 08:43:32', '2026-02-16 08:43:41', '', 0, NULL, NULL, NULL, NULL, NULL, 1114, NULL, 'aman', 7705827321, NULL, NULL),
(553, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87,91,98]', NULL, 17, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822910, 80.9316969, 'Charbagh, Lucknow, Uttar Pradesh, India', 26.8322933, 80.9214337, 21.09, 119.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-16 08:44:21', '2026-02-16 08:44:32', '', 0, NULL, NULL, NULL, NULL, NULL, 7153, NULL, 'aman', 7705827321, NULL, NULL),
(556, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87,91,98]', NULL, 17, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Indira Nagar Sector 16 Room No 16/11 Munshi Pulia, Lucknow, Uttar Pradesh, 226024', 26.9113631, 80.9378140, 'Charbagh, Lucknow, Uttar Pradesh, India', 26.8322933, 80.9214337, 11.90, 83.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-16 10:06:28', '2026-02-16 10:06:33', '', 0, NULL, NULL, NULL, NULL, NULL, 3412, NULL, 'aman', 7705827321, NULL, NULL),
(557, 8, 0, NULL, 1, 0.00, 0.00, '[78,93]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 6, 'WagonR', 'Indira Nagar Sector 16 Room No 16/11 Munshi Pulia, Lucknow, Uttar Pradesh, 226024', 26.9113631, 80.9378140, 'Charbagh, Lucknow, Uttar Pradesh, India', 26.8322933, 80.9214337, 11.90, 357.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-16 10:06:38', '2026-02-16 10:08:19', '', 0, NULL, NULL, NULL, NULL, NULL, 6200, NULL, 'aman', 7705827321, NULL, NULL),
(561, 8, 0, NULL, 1, 0.00, 0.00, '[78,93]', NULL, 18, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823617, 80.9316250, 'Lakhimpur, Uttar Pradesh 262701, India', 27.9462395, 80.7787163, 114.31, 1143.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-16 17:04:56', '2026-02-16 17:05:08', '', 0, NULL, NULL, NULL, NULL, NULL, 7029, NULL, 'ANSAL', 9651511938, NULL, NULL),
(562, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87,91,98]', NULL, 18, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'IIM Rd, Bhitauli, Lucknow, Uttar Pradesh 226013, India', 26.9340660, 80.9211946, 'Takeli, Uttar Pradesh 261135, India', 27.6306372, 80.8979587, 89.37, 14.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-16 17:07:20', '2026-02-16 17:07:41', '', 0, NULL, NULL, NULL, NULL, NULL, 5800, NULL, 'ANSAL', 9651511938, NULL, NULL),
(564, 8, 0, NULL, 1, 0.00, 0.00, '[78,93]', NULL, 18, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823417, 80.9316883, 'Shahjahanpur, Uttar Pradesh, India', 27.8753399, 79.9147268, 161.63, 1616.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-16 17:12:17', '2026-02-16 17:12:24', '', 0, NULL, NULL, NULL, NULL, NULL, 3600, NULL, 'ANSAL', 9651511938, NULL, NULL),
(565, 6, 0, NULL, 1, 0.00, 0.00, '[78,93]', NULL, 18, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', '6/24, Lucknow, Uttar Pradesh, 226201', 26.9745387, 80.9260752, 'Shahjahanpur, Uttar Pradesh, India', 27.8753399, 79.9147268, 166.80, 1668.00, NULL, '', 1, NULL, 0, NULL, '2026-02-16 17:15:32', '2026-02-16 17:16:22', '', 0, NULL, NULL, NULL, NULL, NULL, 8373, NULL, 'ANSAL', 9651511938, NULL, NULL),
(568, 6, 0, NULL, 1, 0.00, 0.00, '[78,93]', NULL, 18, 2, 'Mini', 3, 'Maruti Suzuki', 6, 'WagonR', '00, Lucknow, Uttar Pradesh, 226203', 27.0488483, 80.9024783, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 63.90, 1086.00, NULL, '', 1, NULL, 0, NULL, '2026-02-17 19:47:21', '2026-02-17 19:47:40', '', 0, NULL, NULL, NULL, NULL, NULL, 9608, NULL, 'ANSAL', 9651511938, NULL, NULL),
(569, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,87,91,98]', NULL, 42, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435733, 80.9405663, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-18 09:56:09', '2026-02-18 09:56:14', '', 0, NULL, NULL, NULL, NULL, NULL, 5792, NULL, 'pragya', 7705018444, NULL, NULL),
(572, 8, 1, NULL, 3, 0.00, 0.00, NULL, NULL, 3, 3, 'Black Car', 1, 'TVS Motor', 2, 'King Deluxe', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435628, 80.9405068, 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.7844888, 80.9913370, 12.50, 300.00, NULL, 'Driver not assigned', 2, '2025-03-10 17:21:37', 0, NULL, '2026-02-18 16:00:40', '2026-02-21 21:17:07', '', 0, NULL, NULL, NULL, NULL, NULL, 8332, NULL, 'nbjh', 8423953286, NULL, NULL),
(573, 8, 1, NULL, 3, 0.00, 0.00, NULL, NULL, 3, 3, 'Black Car', 1, 'TVS Motor', 2, 'King Deluxe', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435628, 80.9405068, 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.7844888, 80.9913370, 12.50, 300.00, NULL, 'Driver not assigned', 2, '2025-02-18 16:10:37', 0, NULL, '2026-02-18 16:08:43', '2026-02-21 21:17:11', '', 0, NULL, NULL, NULL, NULL, NULL, 6324, NULL, 'nbjh', 8423953286, NULL, NULL),
(574, 8, 1, NULL, 3, 0.00, 0.00, NULL, NULL, 3, 3, 'Black Car', 1, 'TVS Motor', 2, 'King Deluxe', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435628, 80.9405068, 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.7844888, 80.9913370, 12.50, 300.00, NULL, 'Driver not assigned', 2, '2025-02-18 16:10:37', 0, NULL, '2026-02-18 16:09:27', '2026-02-21 21:17:21', '', 0, NULL, NULL, NULL, NULL, NULL, 5322, NULL, 'nbjh', 8423953286, NULL, NULL),
(575, 8, 1, NULL, 3, 0.00, 0.00, NULL, NULL, 3, 3, 'Black Car', 1, 'TVS Motor', 2, 'King Deluxe', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435628, 80.9405068, 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.7844888, 80.9913370, 12.50, 300.00, NULL, 'Driver not assigned', 2, '2025-02-18 16:14:37', 0, NULL, '2026-02-18 16:11:41', '2026-02-21 21:17:32', '', 0, NULL, NULL, NULL, NULL, NULL, 5527, NULL, 'nbjh', 8423953286, NULL, NULL),
(577, 6, 0, NULL, 1, 0.00, 0.00, '[]', '[87]', 17, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'HP28+CQ8, Sitapur, Uttar Pradesh, 261125', 27.5510328, 80.7164663, 'Lakhimpur, Uttar Pradesh 262701, India', 27.9462395, 80.7787163, 45.63, 274.00, NULL, '', 1, NULL, 0, NULL, '2026-02-18 18:51:25', '2026-02-18 18:56:16', '', 0, NULL, NULL, NULL, NULL, NULL, 8696, NULL, 'aman', 7705827321, NULL, NULL),
(580, 8, 0, NULL, 2, 0.00, 0.00, '[20,77,91,98]', '[19]', 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435682, 80.9405687, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-19 10:18:48', '2026-02-19 10:19:35', '', 0, NULL, NULL, NULL, NULL, NULL, 8238, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(581, 8, 0, NULL, 2, 0.00, 0.00, '[19,20,77,91,98]', NULL, 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435682, 80.9405687, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-19 10:23:23', '2026-02-19 10:23:41', '', 0, NULL, NULL, NULL, NULL, NULL, 2866, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(583, 8, 0, NULL, 2, 0.00, 0.00, '[20,77,91,98]', '[19]', 3, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435677, 80.9405763, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 16.59, 116.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-19 11:10:14', '2026-02-19 11:10:36', '', 0, NULL, NULL, NULL, NULL, NULL, 7487, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(584, 8, 0, NULL, 2, 0.00, 0.00, '[20,77,91,98]', '[19]', 3, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435677, 80.9405763, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 16.59, 116.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-19 11:10:44', '2026-02-19 11:11:01', '', 0, NULL, NULL, NULL, NULL, NULL, 9313, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(585, 8, 0, NULL, 2, 0.00, 0.00, '[19,20,77,91,98]', NULL, 3, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435677, 80.9405763, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 16.59, 116.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-19 11:14:37', '2026-02-19 11:14:47', '', 0, NULL, NULL, NULL, NULL, NULL, 1746, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(586, 8, 0, NULL, 2, 0.00, 0.00, '[20,77,91,98]', '[19]', 3, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435677, 80.9405763, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 16.59, 116.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-19 11:15:16', '2026-02-19 11:15:34', '', 0, NULL, NULL, NULL, NULL, NULL, 1305, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(587, 8, 0, NULL, 2, 0.00, 0.00, '[20,77,91,98]', '[19]', 3, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435677, 80.9405763, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 16.59, 116.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-19 11:15:37', '2026-02-19 11:15:51', '', 0, NULL, NULL, NULL, NULL, NULL, 6081, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(588, 8, 0, NULL, 2, 0.00, 0.00, '[20,77,91,98]', '[19]', 3, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435677, 80.9405763, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 16.59, 116.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-19 11:15:55', '2026-02-19 11:16:10', '', 0, NULL, NULL, NULL, NULL, NULL, 8983, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(589, 8, 0, NULL, 2, 0.00, 0.00, '[20,77,91,98]', '[19]', 3, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435677, 80.9405763, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 16.59, 116.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-19 11:16:13', '2026-02-19 11:17:50', '', 0, NULL, NULL, NULL, NULL, NULL, 2696, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(596, 8, 0, NULL, 2, 0.00, 0.00, '[84]', NULL, 3, 1, 'Auto', 1, 'Bajaj Auto', 2, 'Maxima', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435753, 80.9405607, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 16.59, 232.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-19 12:08:59', '2026-02-19 12:09:14', '', 0, NULL, NULL, NULL, NULL, NULL, 1450, NULL, 'pankaj ji', 9876543210, NULL, NULL),
(597, 8, 0, NULL, 1, 0.00, 0.00, '[78,93]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822380, 80.9317283, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.68, 1236.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-19 21:51:08', '2026-02-19 21:51:22', '', 0, NULL, NULL, NULL, NULL, NULL, 4650, NULL, 'aman', 7705827321, NULL, NULL),
(599, 8, 0, NULL, 1, 0.00, 0.00, '[78]', '[93]', 17, 2, 'Mini', 12, 'DZIRE', 5, 'Dzire', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822702, 80.9315970, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.68, 1236.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-20 09:01:01', '2026-02-20 09:01:17', '', 0, NULL, NULL, NULL, NULL, NULL, 1030, NULL, 'aman', 7705827321, NULL, NULL),
(605, 6, 0, NULL, 1, 0.00, 0.00, '[20,77,87,91,98]', NULL, 17, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Milestone from Biotech Park, Basaha, Uttar Pradesh, 226026', 26.9524876, 80.9937036, 'BKT, Bakshi Ka Talab, Bargadi Magath, Uttar Pradesh 226201, India', 26.9842428, 80.9232795, 16.09, 113.00, NULL, '', 1, NULL, 0, NULL, '2026-02-20 21:40:06', '2026-02-20 21:40:17', '', 0, NULL, NULL, NULL, NULL, NULL, 7598, NULL, 'aman', 7705827321, NULL, NULL),
(606, 8, 0, NULL, 1, 0.00, 0.00, '[78,93]', NULL, 17, 2, 'Mini', 12, 'DZIRE', 5, 'Dzire', 'XX2V+GM9, Lucknow, Uttar Pradesh, 226026', 26.9514076, 80.9941980, 'Gure Para, Uttar Pradesh 261207, India', 27.6080283, 80.9245756, 84.09, 1430.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-20 22:34:07', '2026-02-20 22:34:31', '', 0, NULL, NULL, NULL, NULL, NULL, 4455, NULL, 'aman', 7705827321, NULL, NULL),
(607, 6, 0, NULL, 2, 0.00, 0.00, '[20,77,87,91]', NULL, 26, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434406, 80.9404011, 'Carter Rd, Bandra West, Mumbai, Maharashtra 400050, India', 19.0591481, 72.8218360, 1415.06, 120.00, NULL, '', 1, NULL, 0, NULL, '2026-02-21 09:51:48', '2026-02-21 09:53:05', '', 0, NULL, NULL, NULL, NULL, NULL, 1782, NULL, 'nitin', 9208339102, NULL, NULL),
(609, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,91]', NULL, 17, 3, 'Bike', 6, 'Bajaj', 11, 'Pulsar 150', 'Jj - 58, Lucknow, Uttar Pradesh, 226021', 26.9256623, 80.9637932, 'Kapoorthla, Chandralok, Lucknow, Uttar Pradesh 226024, India', 26.8819465, 80.9449643, 6.81, 48.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-21 15:41:10', '2026-02-21 15:41:18', '', 0, NULL, NULL, NULL, NULL, NULL, 9256, NULL, 'aman', 7705827321, NULL, NULL),
(614, 8, 0, NULL, 1, 0.00, 0.00, NULL, NULL, 3, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434346, 80.9404026, 'Barabanki, Uttar Pradesh, India', 26.9268042, 81.1833809, 32.65, 555.00, NULL, 'Driver not assigned', 2, '2026-02-21 21:43:00', 0, NULL, '2026-02-21 17:47:19', '2026-02-21 16:14:48', '', 0, NULL, NULL, NULL, NULL, NULL, 8455, NULL, 'Niranjan ', 9876543210, NULL, NULL),
(615, 8, 0, NULL, 2, 0.00, 0.00, '[19,20,77,87,91]', NULL, 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434346, 80.9404026, 'Barabanki, Uttar Pradesh, India', 26.9268042, 81.1833809, 32.65, 196.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-21 17:48:35', '2026-02-21 17:48:40', '', 0, NULL, NULL, NULL, NULL, NULL, 8424, NULL, 'Niranjan ', 9876543210, NULL, NULL),
(616, 8, 0, NULL, 2, 0.00, 0.00, '[19,20,77,87,91]', NULL, 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434346, 80.9404026, 'Barabanki, Uttar Pradesh, India', 26.9268042, 81.1833809, 32.65, 196.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-21 17:48:57', '2026-02-21 17:49:04', '', 0, NULL, NULL, NULL, NULL, NULL, 5529, NULL, 'Niranjan ', 9876543210, NULL, NULL),
(617, 8, 0, NULL, 2, 0.00, 0.00, '[19,20,77,87,91]', NULL, 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434346, 80.9404026, 'Barabanki, Uttar Pradesh, India', 26.9268042, 81.1833809, 32.65, 196.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-21 17:49:20', '2026-02-21 17:49:24', '', 0, NULL, NULL, NULL, NULL, NULL, 6775, NULL, 'Niranjan ', 9876543210, NULL, NULL),
(618, 8, 0, NULL, 2, 0.00, 0.00, '[19,20,77,87,91]', NULL, 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434346, 80.9404026, 'Barabanki, Uttar Pradesh, India', 26.9268042, 81.1833809, 32.65, 196.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-21 17:49:35', '2026-02-21 17:49:42', '', 0, NULL, NULL, NULL, NULL, NULL, 4794, NULL, 'Niranjan ', 9876543210, NULL, NULL),
(619, 8, 0, NULL, 2, 0.00, 0.00, '[19,20,77,87,91]', NULL, 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434346, 80.9404026, 'Barabanki, Uttar Pradesh, India', 26.9268042, 81.1833809, 32.65, 196.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-21 17:51:02', '2026-02-21 17:51:13', '', 0, NULL, NULL, NULL, NULL, NULL, 4782, NULL, 'Niranjan ', 9876543210, NULL, NULL),
(623, 8, 0, NULL, 2, 0.00, 0.00, '[19,20,77,87,91]', NULL, 3, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434389, 80.9403985, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.09, 116.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-21 17:57:12', '2026-02-21 17:57:47', '', 0, NULL, NULL, NULL, NULL, NULL, 2725, NULL, 'Niranjan ', 9876543210, NULL, NULL),
(624, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87,91]', NULL, 17, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9429993, 80.9405370, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 78.62, 393.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-21 17:59:30', '2026-02-21 17:59:47', '', 0, NULL, NULL, NULL, NULL, NULL, 4149, NULL, 'aman', 7705827321, NULL, NULL),
(626, 8, 0, NULL, 1, 0.00, 0.00, '[78,93]', NULL, 3, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', '1/613, Mirzapur, Uttar Pradesh, 226031', 26.9475037, 80.9389749, 'Gontha, Uttar Pradesh 275303, India', 26.2349074, 83.5150168, 314.19, 3142.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-21 21:48:58', '2026-02-21 21:49:43', '', 0, NULL, NULL, NULL, NULL, NULL, 6494, NULL, 'Niranjan ', 9876543210, NULL, NULL),
(627, 8, 0, NULL, 1, 0.00, 0.00, NULL, NULL, 3, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', '1/613, Mirzapur, Uttar Pradesh, 226031', 26.9475037, 80.9389749, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.35, 121.00, NULL, 'Driver not assigned', 2, '2026-02-21 21:49:00', 0, NULL, '2026-02-21 21:50:16', '2026-02-21 21:52:03', '', 0, NULL, NULL, NULL, NULL, NULL, 6898, NULL, 'Niranjan ', 9876543210, NULL, NULL),
(630, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,91]', NULL, 3, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', '1/613, Mirzapur, Uttar Pradesh, 226031', 26.9475101, 80.9389766, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.35, 103.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-21 23:24:12', '2026-02-21 23:24:31', '', 0, NULL, NULL, NULL, NULL, NULL, 4473, NULL, 'Niranjan ', 9876543210, NULL, NULL),
(632, 6, 0, NULL, 1, 0.00, 0.00, '[78,93]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822821, 80.9317777, 'Reusa, Uttar Pradesh 261205, India', 27.5457964, 81.2174582, 87.49, 1487.00, NULL, '', 1, NULL, 0, NULL, '2026-02-22 08:20:31', '2026-02-22 08:20:48', '', 0, NULL, NULL, NULL, NULL, NULL, 2797, NULL, 'aman', 7705827321, NULL, NULL),
(633, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,91]', NULL, 3, 3, 'Bike', 5, 'Honda', 10, 'Shine', '1/613, Mirzapur, Uttar Pradesh, 226031', 26.9475403, 80.9389829, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.35, 121.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-22 08:59:53', '2026-02-22 09:00:17', '', 0, NULL, NULL, NULL, NULL, NULL, 9215, NULL, 'Niranjan ', 9876543210, NULL, NULL),
(636, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,91]', NULL, 18, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', '2W7F+89, Bhaisamau, Uttar Pradesh, 226201', 27.0130461, 80.9232263, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 71.08, 355.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-23 19:25:06', '2026-02-23 19:25:43', '', 0, NULL, NULL, NULL, NULL, NULL, 4257, NULL, 'ANSAL', 9651511938, NULL, NULL),
(637, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,91]', NULL, 17, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822465, 80.9317593, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.68, 363.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-24 09:52:57', '2026-02-24 09:54:09', '', 0, NULL, NULL, NULL, NULL, NULL, 3646, NULL, 'aman', 7705827321, NULL, NULL),
(639, 6, 0, NULL, 1, 0.00, 0.00, '[84]', NULL, 51, 1, 'Auto', 2, 'TVS Motor', 4, 'King Duramax', 'Bakshi Ka Talab, Bargadi Magath, Uttar Pradesh 226201, India', 26.9841027, 80.9219764, 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 9.67, 193.00, NULL, '', 1, NULL, 0, NULL, '2026-02-24 10:40:41', '2026-02-24 10:41:42', '', 0, NULL, NULL, NULL, NULL, NULL, 8967, NULL, 'Some Datta', 8090666407, NULL, NULL),
(640, 8, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 14, 'TVS', 23, 'TVS 100', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822742, 80.9316621, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.68, 363.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-25 09:15:39', '2026-02-25 09:15:50', '', 0, NULL, NULL, NULL, NULL, NULL, 7072, NULL, 'aman', 7705827321, NULL, NULL),
(641, 8, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 14, 'TVS', 23, 'TVS 100', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822742, 80.9316621, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.68, 363.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-25 09:16:14', '2026-02-25 09:16:28', '', 0, NULL, NULL, NULL, NULL, NULL, 9285, NULL, 'aman', 7705827321, NULL, NULL),
(642, 8, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 14, 'TVS', 23, 'TVS 100', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822572, 80.9316538, 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 10.23, 363.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-25 09:16:58', '2026-02-25 09:17:10', '', 0, NULL, NULL, NULL, NULL, NULL, 8993, NULL, 'aman', 7705827321, NULL, NULL),
(643, 8, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 14, 'TVS', 23, 'TVS 100', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822022, 80.9316703, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.67, 363.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-25 15:42:50', '2026-02-25 15:43:06', '', 0, NULL, NULL, NULL, NULL, NULL, 2419, NULL, 'aman', 7705827321, NULL, NULL),
(644, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,87,91]', '[102]', 17, 3, 'Bike', 14, 'TVS', 23, 'TVS 100', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822886, 80.9317868, 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 10.24, 363.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-25 15:43:21', '2026-02-25 15:43:40', '', 0, NULL, NULL, NULL, NULL, NULL, 3023, NULL, 'aman', 7705827321, NULL, NULL),
(645, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93,101]', NULL, 17, 2, 'Mini', 12, 'DZIRE', 5, 'Dzire', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822886, 80.9317868, 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 10.24, 307.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-25 15:43:45', '2026-02-25 15:44:06', '', 0, NULL, NULL, NULL, NULL, NULL, 2804, NULL, 'aman', 7705827321, NULL, NULL),
(646, 6, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 54, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Logix City Centre, 1007, Wave City Center, Sector 32, Noida, Uttar Pradesh 201307, India', 28.5743497, 77.3542515, 'Sector 98, Noida, Uttar Pradesh 201304, India', 28.5319188, 77.3613337, 9.56, 67.00, NULL, '', 1, NULL, 0, NULL, '2026-02-25 19:07:46', '2026-02-25 19:07:51', '', 0, NULL, NULL, NULL, NULL, NULL, 1892, NULL, 'gello', 9599089358, NULL, NULL),
(647, 5, 0, 101, 2, 0.00, 232.00, '[101]', NULL, 53, 4, 'Sedan', 9, 'Hyundai Verna', 16, 'Verna SX Turbo', 'Nahar Rd, Lucknow, Uttar Pradesh, 226021', 26.9399963, 80.9571705, 'Kapoorthla, Chandralok, Lucknow, Uttar Pradesh 226024, India', 26.8819465, 80.9449643, 8.60, 232.00, 164, NULL, 1, NULL, 0, NULL, '2026-02-26 12:44:08', '2026-02-26 23:36:32', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771912100753.jpg', 'Beige', 'SHIVANSHU  PANDEY ', 'UP 32 QN 1274', 9565789026, 5658, 4.5, 'Sumkhi', 8874420521, NULL, NULL),
(648, 8, 0, NULL, 1, 0.00, 0.00, '[102,104,20,77,87,91]', NULL, 18, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', '528, Lucknow, Uttar Pradesh, 226021', 26.9381000, 80.9589600, 'Ladakh, India', 34.2268475, 77.5619419, 1476.88, 139.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-26 23:27:47', '2026-02-26 23:27:59', '', 0, NULL, NULL, NULL, NULL, NULL, 2894, NULL, 'ANSAL', 9651511938, NULL, NULL),
(649, 6, 0, NULL, 1, 0.00, 0.00, '[]', '[101]', 53, 4, 'Sedan', 9, 'Hyundai Verna', 16, 'Verna SX Turbo', 'H.N. 647/P-5, Lucknow, Uttar Pradesh, 226021', 26.9382275, 80.9590285, 'Bakshi Ka Talab, Bargadi Magath, Uttar Pradesh 226201, India', 26.9841027, 80.9219764, 9.61, 259.00, NULL, '', 1, NULL, 0, NULL, '2026-02-26 23:37:00', '2026-02-26 23:38:08', '', 0, NULL, NULL, NULL, NULL, NULL, 1194, NULL, 'Sumkhi', 8874420521, NULL, NULL),
(650, 8, 0, NULL, 1, 0.00, 0.00, '[]', '[101]', 53, 4, 'Sedan', 9, 'Hyundai Verna', 16, 'Verna SX Turbo', 'H.N. 647/P-5, Lucknow, Uttar Pradesh, 226021', 26.9382275, 80.9590285, 'Bakshi Ka Talab, Bargadi Magath, Uttar Pradesh 226201, India', 26.9841027, 80.9219764, 9.61, 259.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-26 23:38:16', '2026-02-26 23:38:24', '', 0, NULL, NULL, NULL, NULL, NULL, 1272, NULL, 'Sumkhi', 8874420521, NULL, NULL),
(651, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93,101]', NULL, 18, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823483, 80.9316850, 'Atariya, Uttar Pradesh 241123, India', 27.5489270, 79.7413896, 168.06, 1681.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-27 11:23:23', '2026-02-27 11:23:34', '', 0, NULL, NULL, NULL, NULL, NULL, 9970, NULL, 'ANSAL', 9651511938, NULL, NULL),
(652, 6, 0, NULL, 1, 0.00, 0.00, '[102,104,20,77,87,91]', NULL, 17, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'near SR college, Lucknow, Uttar Pradesh, 226201', 27.0083041, 80.9292160, 'VX23+QRH, Dainik Jagran Chauraha, Civil Lines, Lucknow, Uttar Pradesh 226001, India', 26.8519485, 80.9545941, 24.34, 170.00, NULL, '', 1, NULL, 0, NULL, '2026-02-27 11:43:48', '2026-02-27 11:44:27', '', 0, NULL, NULL, NULL, NULL, NULL, 7404, NULL, 'aman', 7705827321, NULL, NULL),
(653, 8, 0, NULL, 1, 0.00, 0.00, '[102,104,20,77,87,91]', NULL, 18, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823300, 80.9317183, 'Kamlapur, Uttar Pradesh 261302, India', 27.3862094, 80.8180879, 53.12, 266.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-27 11:44:50', '2026-02-27 11:44:59', '', 0, NULL, NULL, NULL, NULL, NULL, 7215, NULL, 'ANSAL', 9651511938, NULL, NULL),
(654, 6, 0, NULL, 1, 0.00, 0.00, '[102,104,20,77,87,91]', NULL, 18, 3, 'Bike', 5, 'Honda', 10, 'Shine', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823200, 80.9317867, 'Alambagh, Lucknow, Uttar Pradesh, India', 26.8127442, 80.9012798, 30.71, 184.00, NULL, '', 1, NULL, 0, NULL, '2026-02-27 12:57:01', '2026-02-27 12:57:25', '', 0, NULL, NULL, NULL, NULL, NULL, 9808, NULL, 'ANSAL', 9651511938, NULL, NULL),
(655, 5, 0, 102, 2, 0.00, 184.00, '[102,104,20,77,87,91]', NULL, 18, 3, 'Bike', 5, 'Honda', 10, 'Shine', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823200, 80.9317867, 'Alambagh, Lucknow, Uttar Pradesh, India', 26.8127442, 80.9012798, 30.71, 184.00, 165, NULL, 1, NULL, 0, NULL, '2026-02-27 12:57:31', '2026-02-27 13:00:09', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771938239753.jpg', 'Blue', 'aman mishra', 'UP 32 RD 9603', 7705827321, 1936, 4.5, 'ANSAL', 9651511938, NULL, NULL),
(657, 8, 0, NULL, 1, 0.00, 0.00, '[102,104,20,77,87,91]', NULL, 18, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823067, 80.9317683, 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 10.24, 72.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-27 13:34:23', '2026-02-27 13:34:31', '', 0, NULL, NULL, NULL, NULL, NULL, 4351, NULL, 'ANSAL', 9651511938, NULL, NULL),
(658, 8, 0, NULL, 1, 0.00, 0.00, '[102,104,20,77,87,91]', NULL, 18, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823067, 80.9317683, 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 10.24, 72.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-27 13:34:34', '2026-02-27 13:34:50', '', 0, NULL, NULL, NULL, NULL, NULL, 3854, NULL, 'ANSAL', 9651511938, NULL, NULL),
(660, 6, 0, NULL, 1, 0.00, 0.00, '[101]', NULL, 17, 4, 'Sedan', 9, 'Hyundai Verna', 16, 'Verna SX Turbo', 'VW3H+77Q, Kaiser Bagh, Lucknow, Uttar Pradesh 226018, India', 26.8532129, 80.9282270, 'Delhi, India', 28.7040592, 77.1024902, 551.53, 6618.00, NULL, '', 1, NULL, 0, NULL, '2026-02-27 16:31:19', '2026-02-27 16:31:52', '', 0, NULL, NULL, NULL, NULL, NULL, 1656, NULL, 'aman', 7705827321, NULL, NULL),
(661, 5, 0, 101, 2, 0.00, 6618.00, '[101]', NULL, 17, 4, 'Sedan', 9, 'Hyundai Verna', 16, 'Verna SX Turbo', 'VW3H+77Q, Kaiser Bagh, Lucknow, Uttar Pradesh 226018, India', 26.8532129, 80.9282270, 'Delhi, India', 28.7040592, 77.1024902, 551.53, 6618.00, 167, NULL, 1, NULL, 0, NULL, '2026-02-27 16:31:56', '2026-02-27 16:32:35', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771912100753.jpg', 'Beige', 'SHIVANSHU  PANDEY ', 'UP 32 QN 1274', 9565789026, 7427, 4.5, 'aman', 7705827321, NULL, NULL),
(662, 7, 0, 101, 1, 0.00, 398.00, '[101]', NULL, 17, 4, 'Sedan', 9, 'Hyundai Verna', 16, 'Verna SX Turbo', 'Nahar Rd, Lucknow, Uttar Pradesh, 226021', 26.9399761, 80.9571642, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 14.74, 398.00, 168, 'User not responding', 1, NULL, 0, NULL, '2026-02-27 16:33:21', '2026-02-27 16:33:38', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771912100753.jpg', 'Beige', 'SHIVANSHU  PANDEY ', 'UP 32 QN 1274', 9565789026, 8292, 4.5, 'aman', 7705827321, NULL, NULL),
(663, 8, 0, NULL, 1, 0.00, 0.00, '[104,20,77,87,91]', NULL, 17, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Nahar Rd, Lucknow, Uttar Pradesh, 226021', 26.9399794, 80.9571608, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 80.61, 103.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-27 16:34:12', '2026-02-27 16:34:17', '', 0, NULL, NULL, NULL, NULL, NULL, 4321, NULL, 'aman', 7705827321, NULL, NULL),
(664, 5, 0, 101, 2, 0.00, 967.00, '[101]', NULL, 17, 4, 'Sedan', 9, 'Hyundai Verna', 16, 'Verna SX Turbo', 'Nahar Rd, Lucknow, Uttar Pradesh, 226021', 26.9399794, 80.9571608, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 80.61, 967.00, 169, NULL, 1, NULL, 0, NULL, '2026-02-27 16:34:21', '2026-02-27 16:34:54', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771912100753.jpg', 'Beige', 'SHIVANSHU  PANDEY ', 'UP 32 QN 1274', 9565789026, 8569, 4.5, 'aman', 7705827321, NULL, NULL),
(665, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 18, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', '72CG+2MR, Ramnagar, Uttar Pradesh, 221008', 25.2701083, 83.0267650, 'Siliguri, West Bengal, India', 26.7271012, 88.3952861, 686.51, 3208.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-28 01:36:22', '2026-02-28 01:36:31', '', 0, NULL, NULL, NULL, NULL, NULL, 9931, NULL, 'ANSAL', 9651511938, NULL, NULL),
(666, 8, 0, NULL, 1, 0.00, 0.00, '[102,104,20,77,87,91]', NULL, 17, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822675, 80.9318146, 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 10.24, 72.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-28 17:08:33', '2026-02-28 17:09:00', '', 0, NULL, NULL, NULL, NULL, NULL, 3933, NULL, 'aman', 7705827321, NULL, NULL),
(667, 6, 0, NULL, 1, 0.00, 0.00, '[104,20,77,87,91]', NULL, 51, 3, 'Bike', 6, 'Bajaj', 11, 'Pulsar 150', 'Bakshi Ka Talab, Bargadi Magath, Uttar Pradesh 226201, India', 26.9841027, 80.9219764, 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 9.67, 68.00, NULL, '', 1, NULL, 0, NULL, '2026-03-02 14:31:22', '2026-03-02 14:32:44', '', 0, NULL, NULL, NULL, NULL, NULL, 9724, NULL, 'Some Datta', 8090666407, NULL, NULL),
(668, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 18, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'JVJX+JWP, Takeli, Uttar Pradesh, 261135', 27.6310800, 80.8994367, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 27.16, 190.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-04 20:59:46', '2026-03-04 20:59:57', '', 0, NULL, NULL, NULL, NULL, NULL, 4555, NULL, 'ANSAL', 9651511938, NULL, NULL),
(669, 8, 0, NULL, 1, 0.00, 0.00, '[104,20,77,87,91]', '[102]', 17, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'XWRC+R42, Bargadi Magath, Uttar Pradesh, 226201', 26.9920722, 80.9202996, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 71.54, 358.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-05 13:19:16', '2026-03-05 13:19:34', '', 0, NULL, NULL, NULL, NULL, NULL, 3041, NULL, 'aman', 7705827321, NULL, NULL),
(670, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,87,91]', '[102]', 17, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823996, 80.9317081, 'VW3H+77Q, Kaiser Bagh, Lucknow, Uttar Pradesh 226018, India', 26.8532129, 80.9282270, 16.89, 118.00, NULL, 'Driver not assigned', 2, '2026-03-05 17:00:00', 0, NULL, '2026-03-05 14:21:38', '2026-03-05 17:03:02', '', 0, NULL, NULL, NULL, NULL, NULL, 9669, NULL, 'aman', 7705827321, NULL, NULL),
(671, 7, 0, 102, 2, 0.00, 118.00, '[20,77,87,91]', '[102]', 17, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', '4VV9+5PG, Nidhasan, Uttar Pradesh, 261304', 27.1426678, 80.8699214, 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 27.61, 118.00, 171, 'User not responding', 1, NULL, 0, NULL, '2026-03-05 14:25:07', '2026-03-05 14:31:45', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771938239753.jpg', 'Blue', 'aman mishra', 'UP 32 RD 9603', 7705827321, 4166, 4.5, 'aman', 7705827321, NULL, NULL),
(672, 6, 0, NULL, 1, 0.00, 0.00, '[96]', NULL, 58, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'JVRP+48J, Gokulpur, Uttar Pradesh, 261135', 27.6401066, 80.8862815, 'Tambaur, Uttar Pradesh 261208, India', 27.7312621, 81.1591734, 38.43, 653.00, NULL, '', 1, NULL, 0, NULL, '2026-03-05 14:34:30', '2026-03-05 14:35:24', '', 0, NULL, NULL, NULL, NULL, NULL, 4289, NULL, 'Anjani ', 6393085442, NULL, NULL),
(673, 6, 0, NULL, 1, 0.00, 0.00, '[96]', NULL, 58, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'JVRP+48J, Gokulpur, Uttar Pradesh, 261135', 27.6401066, 80.8862815, 'Tambaur, Uttar Pradesh 261208, India', 27.7312621, 81.1591734, 38.43, 653.00, NULL, '', 1, NULL, 0, NULL, '2026-03-05 14:35:31', '2026-03-05 14:36:24', '', 0, NULL, NULL, NULL, NULL, NULL, 4177, NULL, 'Anjani ', 6393085442, NULL, NULL),
(674, 6, 0, NULL, 1, 0.00, 0.00, '[96]', NULL, 58, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'JVRP+48J, Gokulpur, Uttar Pradesh, 261135', 27.6401066, 80.8862815, 'Tambaur, Uttar Pradesh 261208, India', 27.7312621, 81.1591734, 38.43, 653.00, NULL, '', 1, NULL, 0, NULL, '2026-03-05 14:36:27', '2026-03-05 14:39:09', '', 0, NULL, NULL, NULL, NULL, NULL, 4329, NULL, 'Anjani ', 6393085442, NULL, NULL),
(675, 6, 0, NULL, 1, 0.00, 0.00, '[96]', NULL, 58, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'JVRP+48J, Gokulpur, Uttar Pradesh, 261135', 27.6401066, 80.8862815, 'H3F5+7F7, Matua - Sakaran - Biswan Rd, Sanda, Uttar Pradesh 261202, India', 27.5759553, 81.0623109, 26.00, 2125.00, NULL, '', 1, NULL, 0, NULL, '2026-03-05 14:40:07', '2026-03-05 14:41:44', '', 0, NULL, NULL, NULL, NULL, NULL, 7303, NULL, 'Anjani ', 6393085442, NULL, NULL),
(676, 6, 0, NULL, 1, 0.00, 0.00, '[96]', NULL, 58, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'JVRP+48J, Gokulpur, Uttar Pradesh, 261135', 27.6401066, 80.8862815, 'Noida, Uttar Pradesh, India', 28.5355161, 77.3910265, 455.43, 4554.00, NULL, '', 1, NULL, 0, NULL, '2026-03-05 14:42:16', '2026-03-05 14:42:26', '', 0, NULL, NULL, NULL, NULL, NULL, 6303, NULL, 'Anjani ', 6393085442, NULL, NULL),
(677, 6, 0, NULL, 1, 0.00, 0.00, '[96]', NULL, 58, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'JVRP+48J, Gokulpur, Uttar Pradesh, 261135', 27.6401066, 80.8862815, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 25.13, 427.00, NULL, '', 1, NULL, 0, NULL, '2026-03-05 14:43:03', '2026-03-05 14:43:14', '', 0, NULL, NULL, NULL, NULL, NULL, 6416, NULL, 'Anjani ', 6393085442, NULL, NULL),
(678, 8, 0, NULL, 1, 0.00, 0.00, '[96]', NULL, 58, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'JVRP+48J, Gokulpur, Uttar Pradesh, 261135', 27.6401066, 80.8862815, 'Takeli, Uttar Pradesh 261135, India', 27.6306372, 80.8979587, 2.63, 427.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-05 14:44:15', '2026-03-05 14:44:39', '', 0, NULL, NULL, NULL, NULL, NULL, 4701, NULL, 'Anjani ', 6393085442, NULL, NULL),
(679, 8, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 6, 'Bajaj', 11, 'Pulsar 150', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9826868, 80.9316603, 'Amar Shaheed Path, Golf City, Sector B Ansal API, Lucknow, Hariharpur, Uttar Pradesh 226030, India', 26.7844601, 80.9913085, 30.67, 184.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-05 14:50:17', '2026-03-05 14:51:01', '', 0, NULL, NULL, NULL, NULL, NULL, 4816, NULL, 'aman', 7705827321, NULL, NULL),
(680, 6, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Asti Rd, Roodahi, Uttar Pradesh, 226201', 26.9844605, 80.9262256, 'VW3H+77Q, Kaiser Bagh, Lucknow, Uttar Pradesh 226018, India', 26.8532129, 80.9282270, 16.07, 112.00, NULL, '', 1, NULL, 0, NULL, '2026-03-05 17:00:39', '2026-03-05 17:01:21', '', 0, NULL, NULL, NULL, NULL, NULL, 4114, NULL, 'aman', 7705827321, NULL, NULL),
(681, 8, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'XWMG+VC3, Launa, Uttar Pradesh, 226201', 26.9845223, 80.9261685, 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 9.44, 112.00, NULL, 'Driver not assigned', 2, '2026-03-05 19:30:00', 0, NULL, '2026-03-05 17:05:01', '2026-03-05 19:33:09', '', 0, NULL, NULL, NULL, NULL, NULL, 7213, NULL, 'aman', 7705827321, NULL, NULL),
(682, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,87,91]', NULL, 17, 3, 'Bike', 6, 'Bajaj', 11, 'Pulsar 150', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9825704, 80.9317461, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.59, 363.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-05 19:58:55', '2026-03-05 19:59:19', '', 0, NULL, NULL, NULL, NULL, NULL, 8988, NULL, 'aman', 7705827321, NULL, NULL),
(683, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,87,91]', '[102]', 17, 3, 'Bike', 6, 'Bajaj', 11, 'Pulsar 150', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9825704, 80.9317461, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.59, 363.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-05 19:59:21', '2026-03-05 19:59:37', '', 0, NULL, NULL, NULL, NULL, NULL, 5872, NULL, 'aman', 7705827321, NULL, NULL),
(685, 6, 0, NULL, 1, 0.00, 0.00, '[96]', NULL, 58, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'JVRP+47X, Gokulpur, Uttar Pradesh, 261135', 27.6409950, 80.8855483, 'Lucknow, Uttar Pradesh, India', 26.8466937, 80.9461660, 101.70, 1017.00, NULL, '', 1, NULL, 0, NULL, '2026-03-05 20:03:41', '2026-03-05 20:03:57', '', 0, NULL, NULL, NULL, NULL, NULL, 7459, NULL, 'Anjani ', 6393085442, NULL, NULL),
(686, 6, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 58, 1, 'Auto', 2, 'TVS Motor', 4, 'King Duramax', 'JVRP+47X, Gokulpur, Uttar Pradesh, 261135', 27.6409950, 80.8855483, 'Biswan, Uttar Pradesh 261201, India', 27.4937578, 80.9964806, 27.84, 330.00, NULL, '', 1, NULL, 0, NULL, '2026-03-05 20:04:53', '2026-03-05 20:05:46', '', 0, NULL, NULL, NULL, NULL, NULL, 4401, NULL, 'Anjani ', 6393085442, NULL, NULL),
(687, 8, 0, NULL, 1, 0.00, 0.00, '[104]', NULL, 58, 3, 'Bike', 6, 'Bajaj', 11, 'Pulsar 150', 'JVRP+47X, Gokulpur, Uttar Pradesh, 261135', 27.6409950, 80.8855483, 'Laharpur, Uttar Pradesh 261135, India', 27.7100960, 80.9014160, 13.93, 98.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-05 20:07:14', '2026-03-05 20:07:34', '', 0, NULL, NULL, NULL, NULL, NULL, 6190, NULL, 'Anjani ', 6393085442, NULL, NULL),
(688, 6, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 60, 3, 'Bike', 5, 'Honda', 10, 'Shine', '285, Lucknow, Uttar Pradesh, 226010', 26.8451058, 81.0184518, 'Polytechnic Chauraha, Block D, Indira Nagar, Lucknow, Uttar Pradesh, India', 26.8731342, 80.9955176, 7.80, 55.00, NULL, '', 1, NULL, 0, NULL, '2026-03-06 16:29:14', '2026-03-06 16:29:46', '', 0, NULL, NULL, NULL, NULL, NULL, 7225, NULL, 'gautam ', 9794116633, NULL, NULL),
(689, 6, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9827213, 80.9317788, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 21.60, 151.00, NULL, '', 1, NULL, 0, NULL, '2026-03-06 20:06:11', '2026-03-06 20:06:25', '', 0, NULL, NULL, NULL, NULL, NULL, 2322, NULL, 'aman', 7705827321, NULL, NULL),
(690, 8, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822923, 80.9317361, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 21.71, 151.00, NULL, 'Driver not assigned', 2, '2026-03-06 22:15:00', 0, NULL, '2026-03-06 20:07:01', '2026-03-06 22:18:01', '', 0, NULL, NULL, NULL, NULL, NULL, 3605, NULL, 'aman', 7705827321, NULL, NULL),
(691, 7, 0, 102, 1, 0.00, 613.00, '[102,20,77,87,91]', NULL, 18, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'H.N. 647/P-5, Lucknow, Uttar Pradesh, 226021', 26.9381758, 80.9591483, 'Lakhimpur, Uttar Pradesh 262701, India', 27.9462395, 80.7787163, 122.62, 613.00, 172, 'User not responding', 1, NULL, 0, NULL, '2026-03-06 21:27:07', '2026-03-06 21:27:57', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771938239753.jpg', 'Blue', 'aman mishra', 'UP 32 RD 9603', 7705827321, 3768, 4.5, 'ANSAL', 9651511938, NULL, NULL),
(692, 8, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 5, 'Honda', 10, 'Shine', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823247, 80.9315594, 'Lakhimpur, Uttar Pradesh 262701, India', 27.9462395, 80.7787163, 114.30, 572.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-07 08:53:04', '2026-03-07 08:53:23', '', 0, NULL, NULL, NULL, NULL, NULL, 3104, NULL, 'aman', 7705827321, NULL, NULL),
(693, 8, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 5, 'Honda', 10, 'Shine', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823247, 80.9315594, 'Amritsar, Punjab, India', 31.6339793, 74.8722642, 1002.82, 572.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-07 08:53:59', '2026-03-07 08:54:04', '', 0, NULL, NULL, NULL, NULL, NULL, 1440, NULL, 'aman', 7705827321, NULL, NULL),
(695, 8, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 5, 'Honda', 10, 'Shine', 'XWRC+R42, Bargadi Magath, Uttar Pradesh, 226201', 26.9919544, 80.9202340, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 71.53, 358.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-07 11:56:11', '2026-03-07 11:56:21', '', 0, NULL, NULL, NULL, NULL, NULL, 3533, NULL, 'aman', 7705827321, NULL, NULL),
(697, 8, 0, NULL, 1, 0.00, 0.00, '[84]', NULL, 51, 1, 'Auto', 2, 'TVS Motor', 4, 'King Duramax', 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 'Bakshi Ka Talab, Bargadi Magath, Uttar Pradesh 226201, India', 26.9841027, 80.9219764, 8.95, 179.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-07 13:39:23', '2026-03-07 13:39:35', '', 0, NULL, NULL, NULL, NULL, NULL, 2609, NULL, 'Some Datta', 8090666407, NULL, NULL),
(698, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93,101]', NULL, 61, 2, 'Mini', 4, 'Hyundai', 7, 'i10', 'XWMH+PPX, Lucknow, Uttar Pradesh, 226201', 26.9843957, 80.9290273, 'VW3H+77Q, Kaiser Bagh, Lucknow, Uttar Pradesh 226018, India', 26.8532129, 80.9282270, 16.34, 278.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-07 16:07:17', '2026-03-07 16:07:27', '', 0, NULL, NULL, NULL, NULL, NULL, 4192, NULL, 'janmejay singh ', 9990230532, NULL, NULL);
INSERT INTO `cab_orders` (`id`, `order_status`, `wallet_apply`, `driver_id`, `pay_mode`, `amount_after_wallet`, `final_amount`, `matched_driver_id`, `ignored_drivers_id`, `user_id`, `vehicle_id`, `vehicle_name`, `brand_id`, `brand_name`, `model_id`, `model_name`, `pickup_location`, `pickup_latitude`, `pickup_longitude`, `drop_location`, `drop_latitude`, `drop_longitude`, `distance_km`, `estimated_amount`, `accepted_offer_id`, `cancel_reason`, `order_type`, `schedule_time`, `payment_status`, `coupon_id`, `created_at`, `updated_at`, `user_comment`, `over_limit_passenger`, `profile_photo`, `vehicle_color`, `driver_name`, `vehicle_plate_number`, `contact_number`, `orderOtp`, `rating`, `user_name`, `user_mobile`, `order_rating`, `cancel_by_admin`) VALUES
(699, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93,101]', NULL, 61, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'BHEEKHAPURWA, Lucknow, Uttar Pradesh, 226201', 26.9843994, 80.9294328, 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 9.66, 290.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-07 16:11:33', '2026-03-07 16:11:37', '', 0, NULL, NULL, NULL, NULL, NULL, 8596, NULL, 'janmejay singh ', 9990230532, NULL, NULL),
(700, 5, 0, 102, 2, 0.00, 68.00, '[102,20,77,87,91]', NULL, 61, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'BHEEKHAPURWA, Lucknow, Uttar Pradesh, 226201', 26.9843994, 80.9294328, 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 9.66, 68.00, 173, NULL, 1, NULL, 0, NULL, '2026-03-07 16:11:57', '2026-03-07 16:14:27', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771938239753.jpg', 'Blue', 'aman mishra', 'UP 32 RD 9603', 7705827321, 9379, 4.5, 'janmejay singh ', 9990230532, NULL, NULL),
(701, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,87,91]', NULL, 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435490, 80.9405874, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-07 16:13:57', '2026-03-07 16:14:08', '', 0, NULL, NULL, NULL, NULL, NULL, 1226, NULL, 'Niranjan ', 9876543210, NULL, NULL),
(702, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,87,91]', NULL, 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435490, 80.9405874, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 121.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-07 16:14:15', '2026-03-07 16:14:20', '', 0, NULL, NULL, NULL, NULL, NULL, 1457, NULL, 'Niranjan ', 9876543210, NULL, NULL),
(703, 6, 0, NULL, 1, 0.00, 0.00, '[20,77,87,91]', '[102]', 61, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'BHEEKHAPURWA, Lucknow, Uttar Pradesh, 226201', 26.9843943, 80.9293887, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.10, 68.00, NULL, '', 1, NULL, 0, NULL, '2026-03-07 16:14:51', '2026-03-07 16:15:11', '', 0, NULL, NULL, NULL, NULL, NULL, 3943, NULL, 'janmejay singh ', 9990230532, NULL, NULL),
(704, 6, 0, NULL, 1, 0.00, 0.00, '[20,77,87,91]', '[102]', 61, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'BHEEKHAPURWA, Lucknow, Uttar Pradesh, 226201', 26.9843943, 80.9293887, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.10, 68.00, NULL, '', 1, NULL, 0, NULL, '2026-03-07 16:15:17', '2026-03-07 16:16:21', '', 0, NULL, NULL, NULL, NULL, NULL, 7690, NULL, 'janmejay singh ', 9990230532, NULL, NULL),
(705, 8, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 61, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'BHEEKHAPURWA, Lucknow, Uttar Pradesh, 226201', 26.9843943, 80.9293887, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.10, 68.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-07 16:16:25', '2026-03-07 16:17:00', '', 0, NULL, NULL, NULL, NULL, NULL, 8508, NULL, 'janmejay singh ', 9990230532, NULL, NULL),
(706, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,87,91]', '[102]', 61, 3, 'Bike', 5, 'Honda', 10, 'Shine', 'BHEEKHAPURWA, Lucknow, Uttar Pradesh, 226201', 26.9843943, 80.9293887, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.10, 361.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-07 16:19:59', '2026-03-07 16:20:16', '', 0, NULL, NULL, NULL, NULL, NULL, 2667, NULL, 'janmejay singh ', 9990230532, NULL, NULL),
(707, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93,101]', NULL, 3, 2, 'Mini', 4, 'Hyundai', 7, 'i10', '1/613, Mirzapur, Uttar Pradesh, 226031', 26.9475795, 80.9386966, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.34, 295.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-08 11:19:52', '2026-03-08 11:19:58', '', 0, NULL, NULL, NULL, NULL, NULL, 1853, NULL, 'Niranjan ', 9876543210, NULL, NULL),
(708, 8, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 3, 3, 'Bike', 15, 'HERO', 25, 'Hero HF Deluxe', '1/613, Mirzapur, Uttar Pradesh, 226031', 26.9476241, 80.9388416, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.35, 121.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-08 11:25:48', '2026-03-08 11:25:54', '', 0, NULL, NULL, NULL, NULL, NULL, 3129, NULL, 'Niranjan ', 9876543210, NULL, NULL),
(709, 6, 0, NULL, 1, 0.00, 0.00, '[84]', NULL, 63, 1, 'Auto', 1, 'Bajaj Auto', 2, 'Maxima', '140A, Lucknow, Uttar Pradesh, 226016', 26.8850278, 81.0081115, 'Kamta, Lucknow, Uttar Pradesh, India', 26.8827306, 81.0134444, 0.65, 16.00, NULL, '', 1, NULL, 0, NULL, '2026-03-08 14:11:17', '2026-03-08 14:11:46', '', 0, NULL, NULL, NULL, NULL, NULL, 1650, NULL, 'vivek', 7307229576, NULL, NULL),
(710, 8, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 14, 'TVS', 23, 'TVS 100', 'XWV9+RMX, Bargadi Magath, Uttar Pradesh, 226201', 26.9946224, 80.9193492, 'Lakhimpur, Uttar Pradesh 262701, India', 27.9462395, 80.7787163, 111.78, 559.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-08 18:33:57', '2026-03-08 18:34:40', '', 0, NULL, NULL, NULL, NULL, NULL, 8626, NULL, 'aman', 7705827321, NULL, NULL),
(711, 8, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 14, 'TVS', 23, 'TVS 100', 'XWV9+RMX, Bargadi Magath, Uttar Pradesh, 226201', 26.9946224, 80.9193492, 'Lakhimpur, Uttar Pradesh 262701, India', 27.9462395, 80.7787163, 111.78, 559.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-08 20:20:36', '2026-03-08 20:20:45', '', 0, NULL, NULL, NULL, NULL, NULL, 7642, NULL, 'aman', 7705827321, NULL, NULL),
(713, 6, 0, NULL, 1, 0.00, 0.00, '[20,77,87,91]', NULL, 17, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823230, 80.9316561, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.69, 363.00, NULL, '', 1, NULL, 0, NULL, '2026-03-09 11:13:54', '2026-03-09 11:14:14', '', 0, NULL, NULL, NULL, NULL, NULL, 9954, NULL, 'aman', 7705827321, NULL, NULL),
(714, 6, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823230, 80.9316561, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.69, 363.00, NULL, '', 1, NULL, 0, NULL, '2026-03-09 11:14:18', '2026-03-09 11:14:33', '', 0, NULL, NULL, NULL, NULL, NULL, 3232, NULL, 'aman', 7705827321, NULL, NULL),
(716, 6, 0, 102, 1, 0.00, 143.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', '2W35+M66, Sarhamau, Uttar Pradesh, 226202', 27.0036311, 80.9079756, 'VW3H+77Q, Kaiser Bagh, Lucknow, Uttar Pradesh 226018, India', 26.8532129, 80.9282270, 20.38, 143.00, 174, 'Driver is taking too long', 1, NULL, 0, NULL, '2026-03-09 14:17:27', '2026-03-09 14:18:42', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771938239753.jpg', 'Blue', 'aman mishra', 'UP 32 RD 9603', 7705827321, 7150, 4.5, 'aman', 7705827321, NULL, NULL),
(717, 8, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 5, 'Honda', 10, 'Shine', '2W35+M66, Sarhamau, Uttar Pradesh, 226202', 27.0036538, 80.9080002, 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 13.66, 96.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-09 14:35:51', '2026-03-09 14:36:00', '', 0, NULL, NULL, NULL, NULL, NULL, 3959, NULL, 'aman', 7705827321, NULL, NULL),
(718, 6, 0, NULL, 1, 0.00, 0.00, '[20,77,87,91]', '[102]', 17, 3, 'Bike', 5, 'Honda', 10, 'Shine', '2W35+M66, Sarhamau, Uttar Pradesh, 226202', 27.0036538, 80.9080002, 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 13.66, 96.00, NULL, '', 1, NULL, 0, NULL, '2026-03-09 14:36:04', '2026-03-09 14:36:45', '', 0, NULL, NULL, NULL, NULL, NULL, 5193, NULL, 'aman', 7705827321, NULL, NULL),
(719, 6, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 5, 'Honda', 10, 'Shine', '2W35+M66, Sarhamau, Uttar Pradesh, 226202', 27.0036538, 80.9080002, 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 13.66, 96.00, NULL, '', 1, NULL, 0, NULL, '2026-03-09 14:36:47', '2026-03-09 14:36:54', '', 0, NULL, NULL, NULL, NULL, NULL, 4746, NULL, 'aman', 7705827321, NULL, NULL),
(720, 8, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 65, 3, 'Bike', 5, 'Honda', 10, 'Shine', '2W35+M66, Sarhamau, Uttar Pradesh, 226202', 27.0036299, 80.9079788, 'Parvatpur, Chandrika Devi Rd, Bakshi Ka Talab, Lucknow, Hardhaurpur, Uttar Pradesh 226202, India', 27.0012689, 80.8820926, 7.06, 49.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-09 14:36:52', '2026-03-09 14:37:07', '', 0, NULL, NULL, NULL, NULL, NULL, 4675, NULL, 'shubham Kumar ', 8127570413, NULL, NULL),
(721, 5, 0, 102, 2, 0.00, 49.00, '[102,20,77,87,91]', NULL, 65, 3, 'Bike', 5, 'Honda', 10, 'Shine', '2W35+M66, Sarhamau, Uttar Pradesh, 226202', 27.0036299, 80.9079788, 'Parvatpur, Chandrika Devi Rd, Bakshi Ka Talab, Lucknow, Hardhaurpur, Uttar Pradesh 226202, India', 27.0012689, 80.8820926, 7.06, 49.00, 175, NULL, 1, NULL, 0, NULL, '2026-03-09 14:37:22', '2026-03-09 14:38:13', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771938239753.jpg', 'Blue', 'aman mishra', 'UP 32 RD 9603', 7705827321, 8669, 4.5, 'shubham Kumar ', 8127570413, NULL, NULL),
(722, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93,101]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMH+M84, Bargadi Magath, Uttar Pradesh, 226201', 26.9842534, 80.9284697, 'Janakpuri, New Delhi, Delhi, India', 28.6218990, 77.0878385, 557.03, 5570.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-09 16:24:23', '2026-03-09 16:24:36', '', 0, NULL, NULL, NULL, NULL, NULL, 6392, NULL, 'aman', 7705827321, NULL, NULL),
(724, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,87,91]', '[102]', 17, 3, 'Bike', 14, 'TVS', 23, 'TVS 100', 'XWMH+JWC, Lucknow, Uttar Pradesh, 226201', 26.9844119, 80.9297419, 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 9.69, 68.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-09 17:02:04', '2026-03-09 17:02:19', '', 0, NULL, NULL, NULL, NULL, NULL, 1374, NULL, 'aman', 7705827321, NULL, NULL),
(725, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,87,91]', '[102]', 17, 3, 'Bike', 15, 'HERO', 25, 'Hero HF Deluxe', 'XWJJ+W8R, Bargadi Magath, Uttar Pradesh, 226201', 26.9821503, 80.9309884, 'Amar Shaheed Path, Golf City, Sector B Ansal API, Lucknow, Hariharpur, Uttar Pradesh 226030, India', 26.7844601, 80.9913085, 30.69, 184.00, NULL, 'Driver not assigned', 2, '2026-03-09 21:31:00', 0, NULL, '2026-03-09 19:28:02', '2026-03-09 21:34:01', '', 0, NULL, NULL, NULL, NULL, NULL, 4527, NULL, 'aman', 7705827321, NULL, NULL),
(726, 8, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 14, 'TVS', 23, 'TVS 100', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823077, 80.9316730, 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 10.24, 72.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-10 09:26:58', '2026-03-10 09:27:07', '', 0, NULL, NULL, NULL, NULL, NULL, 8830, NULL, 'aman', 7705827321, NULL, NULL),
(727, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,87,91]', '[102]', 17, 3, 'Bike', 14, 'TVS', 23, 'TVS 100', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823077, 80.9316730, 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 10.24, 72.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-10 09:27:30', '2026-03-10 09:27:46', '', 0, NULL, NULL, NULL, NULL, NULL, 3302, NULL, 'aman', 7705827321, NULL, NULL),
(728, 5, 0, 102, 2, 0.00, 119.00, '[102,20,77,87,91]', NULL, 67, 3, 'Bike', 14, 'TVS', 23, 'TVS 100', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823339, 80.9315220, 'VW3H+77Q, Kaiser Bagh, Lucknow, Uttar Pradesh 226018, India', 26.8532129, 80.9282270, 16.96, 119.00, 176, NULL, 1, NULL, 0, NULL, '2026-03-10 14:55:13', '2026-03-10 14:56:08', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771938239753.jpg', 'Blue', 'aman mishra', 'UP 32 RD 9603', 7705827321, 2343, 4.5, 'Ashish Kumar Saini ', 7393952737, NULL, NULL),
(729, 6, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 15, 'HERO', 25, 'Hero HF Deluxe', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823499, 80.9316226, 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 10.24, 72.00, NULL, '', 1, NULL, 0, NULL, '2026-03-12 09:29:12', '2026-03-12 09:29:22', '', 0, NULL, NULL, NULL, NULL, NULL, 5640, NULL, 'aman', 7705827321, NULL, NULL),
(731, 6, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'XWXC+42V, Mampur Bana, Uttar Pradesh, 226201', 26.9978954, 80.9200881, 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 10.62, 74.00, NULL, '', 1, NULL, 0, NULL, '2026-03-12 12:09:37', '2026-03-12 12:10:31', '', 0, NULL, NULL, NULL, NULL, NULL, 7154, NULL, 'aman', 7705827321, NULL, NULL),
(732, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93,101]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWXC+42V, Mampur Bana, Uttar Pradesh, 226201', 26.9978954, 80.9200881, 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 10.62, 319.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-12 12:10:39', '2026-03-12 12:10:44', '', 0, NULL, NULL, NULL, NULL, NULL, 6290, NULL, 'aman', 7705827321, NULL, NULL),
(733, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,87,91]', NULL, 17, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'XWX9+8H5, Mampur Bana, Uttar Pradesh, 226201', 26.9982720, 80.9188727, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 69.88, 349.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-12 12:11:00', '2026-03-12 12:11:09', '', 0, NULL, NULL, NULL, NULL, NULL, 3925, NULL, 'aman', 7705827321, NULL, NULL),
(734, 8, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'XWX9+8H5, Mampur Bana, Uttar Pradesh, 226201', 26.9982720, 80.9188727, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 69.88, 349.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-12 12:11:32', '2026-03-12 12:11:36', '', 0, NULL, NULL, NULL, NULL, NULL, 8348, NULL, 'aman', 7705827321, NULL, NULL),
(735, 6, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'XWX9+8H5, Mampur Bana, Uttar Pradesh, 226201', 26.9982720, 80.9188727, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 69.88, 349.00, NULL, '', 1, NULL, 0, NULL, '2026-03-12 12:12:13', '2026-03-12 12:12:24', '', 0, NULL, NULL, NULL, NULL, NULL, 4332, NULL, 'aman', 7705827321, NULL, NULL),
(736, 6, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'XWX9+8H5, Mampur Bana, Uttar Pradesh, 226201', 26.9982720, 80.9188727, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 69.88, 349.00, NULL, '', 1, NULL, 0, NULL, '2026-03-12 12:12:28', '2026-03-12 12:12:59', '', 0, NULL, NULL, NULL, NULL, NULL, 2684, NULL, 'aman', 7705827321, NULL, NULL),
(737, 6, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'XWXC+428, Mampur Bana, Uttar Pradesh, 226201', 26.9978816, 80.9201420, 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 10.61, 349.00, NULL, '', 1, NULL, 0, NULL, '2026-03-12 12:13:19', '2026-03-12 12:13:30', '', 0, NULL, NULL, NULL, NULL, NULL, 5928, NULL, 'aman', 7705827321, NULL, NULL),
(738, 8, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'XWXC+428, Mampur Bana, Uttar Pradesh, 226201', 26.9978816, 80.9201420, 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 10.61, 349.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-12 17:01:20', '2026-03-12 17:01:26', '', 0, NULL, NULL, NULL, NULL, NULL, 2885, NULL, 'aman', 7705827321, NULL, NULL),
(739, 8, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'WXQ5+V5C, Lucknow, Uttar Pradesh, 226021', 26.9398777, 80.9579204, 'Delhi, India', 28.7040592, 77.1024902, 559.33, 74.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-12 17:38:58', '2026-03-12 17:39:04', '', 0, NULL, NULL, NULL, NULL, NULL, 2415, NULL, 'aman', 7705827321, NULL, NULL),
(740, 6, 0, 101, 1, 0.00, 5593.00, '[78,88,93,101]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'WXQ5+V5C, Lucknow, Uttar Pradesh, 226021', 26.9398777, 80.9579204, 'Delhi, India', 28.7040592, 77.1024902, 559.33, 5593.00, 177, 'Driver is taking too long', 1, NULL, 0, NULL, '2026-03-12 17:39:09', '2026-03-12 17:39:40', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771912100753.jpg', 'Beige', 'SHIVANSHU  PANDEY ', 'UP 32 QN 1274', 9565789026, 2001, 4.5, 'aman', 7705827321, NULL, NULL),
(741, 5, 0, 101, 1, 0.00, 5593.00, '[78,88,93,101]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'WXQ5+V5C, Lucknow, Uttar Pradesh, 226021', 26.9398777, 80.9579204, 'Delhi, India', 28.7040592, 77.1024902, 559.33, 5593.00, 178, NULL, 1, NULL, 0, NULL, '2026-03-12 17:40:10', '2026-03-12 17:43:06', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771912100753.jpg', 'Beige', 'SHIVANSHU  PANDEY ', 'UP 32 QN 1274', 9565789026, 7628, 4.5, 'aman', 7705827321, NULL, NULL),
(742, 8, 0, NULL, 1, 0.00, 0.00, '[]', '[101]', 17, 4, 'Sedan', 9, 'Hyundai Verna', 16, 'Verna SX Turbo', 'WXQ4+XX8, Lucknow, Uttar Pradesh, 226021', 26.9402203, 80.9575750, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 80.64, 968.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-12 17:43:40', '2026-03-12 17:43:54', '', 0, NULL, NULL, NULL, NULL, NULL, 9793, NULL, 'aman', 7705827321, NULL, NULL),
(743, 5, 0, 101, 1, 0.00, 968.00, '[101]', NULL, 17, 4, 'Sedan', 9, 'Hyundai Verna', 16, 'Verna SX Turbo', 'WXQ4+XX8, Lucknow, Uttar Pradesh, 226021', 26.9402203, 80.9575750, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 80.64, 968.00, 180, NULL, 1, NULL, 0, NULL, '2026-03-12 17:46:49', '2026-03-12 17:48:04', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771912100753.jpg', 'Beige', 'SHIVANSHU  PANDEY ', 'UP 32 QN 1274', 9565789026, 6576, 4.5, 'aman', 7705827321, NULL, NULL),
(744, 6, 0, 102, 1, 0.00, 74.00, '[20,77,87,91]', '[102]', 68, 3, 'Bike', 15, 'HERO', 25, 'Hero HF Deluxe', 'XWXC+428, Mampur Bana, Uttar Pradesh, 226201', 26.9977379, 80.9200066, 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 10.60, 74.00, 181, 'Driver is taking too long', 1, NULL, 0, NULL, '2026-03-12 22:14:57', '2026-03-12 22:16:39', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771938239753.jpg', 'Blue', 'aman mishra', 'UP 32 RD 9603', 7705827321, 2532, 4.5, 'parkah', 7355646015, NULL, NULL),
(745, 8, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 15, 'HERO', 25, 'Hero HF Deluxe', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822898, 80.9318040, 'Lakhimpur, Uttar Pradesh 262701, India', 27.9462395, 80.7787163, 114.31, 572.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-13 11:30:38', '2026-03-13 11:30:56', '', 0, NULL, NULL, NULL, NULL, NULL, 7794, NULL, 'aman', 7705827321, NULL, NULL),
(746, 8, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 15, 'HERO', 25, 'Hero HF Deluxe', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823709, 80.9318894, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.60, 363.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-13 11:32:09', '2026-03-13 11:33:06', '', 0, NULL, NULL, NULL, NULL, NULL, 8496, NULL, 'aman', 7705827321, NULL, NULL),
(748, 6, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 15, 'HERO', 25, 'Hero HF Deluxe', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823144, 80.9317704, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.69, 363.00, NULL, '', 1, NULL, 0, NULL, '2026-03-13 11:43:36', '2026-03-13 11:44:03', '', 0, NULL, NULL, NULL, NULL, NULL, 1673, NULL, 'aman', 7705827321, NULL, NULL),
(749, 8, 0, NULL, 1, 0.00, 0.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 15, 'HERO', 25, 'Hero HF Deluxe', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823144, 80.9317704, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.69, 363.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-13 11:44:16', '2026-03-13 11:44:35', '', 0, NULL, NULL, NULL, NULL, NULL, 3406, NULL, 'aman', 7705827321, NULL, NULL),
(750, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,87,91]', NULL, 17, 3, 'Bike', 15, 'HERO', 25, 'Hero HF Deluxe', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823144, 80.9317704, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.69, 363.00, NULL, NULL, 1, NULL, 0, NULL, '2026-03-13 11:44:54', '2026-03-13 11:45:03', '', 0, NULL, NULL, NULL, NULL, NULL, 8245, NULL, 'aman', 7705827321, NULL, NULL),
(751, 5, 0, 102, 1, 0.00, 154.00, '[102,20,77,87,91]', NULL, 17, 3, 'Bike', 15, 'HERO', 25, 'Hero HF Deluxe', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823615, 80.9317070, 'Lucknow, Uttar Pradesh, India', 26.8466937, 80.9461660, 22.01, 154.00, 182, NULL, 1, NULL, 0, NULL, '2026-03-13 11:45:47', '2026-03-13 11:48:56', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771938239753.jpg', 'Blue', 'aman mishra', 'UP 32 RD 9603', 7705827321, 4453, 4.5, 'aman', 7705827321, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `image`, `status`, `created_at`) VALUES
(1, 'Gardener', 'categories/gardener-removebg-preview.png', 1, '2025-12-06 08:31:30'),
(2, 'AC CoolCare', 'categories/ac_coolcar.png', 1, '2025-12-06 08:31:30'),
(3, 'Electrician', 'categories/electrician-removebg-preview.png', 1, '2025-12-06 08:31:30'),
(4, 'Cooking', 'categories/cokking-removebg-preview.png', 1, '2025-12-06 08:31:30'),
(5, 'Carpenter', 'categories/carpenter-removebg-preview.png', 1, '2025-12-06 08:31:30'),
(6, 'Cleaning', 'categories/cleaning-removebg-preview.png', 1, '2025-12-06 08:31:30'),
(7, 'Laundry', 'categories/laundry-removebg-preview.png', 1, '2025-12-06 08:31:30'),
(8, 'Painter', 'categories/painter-removebg-preview.png', 1, '2025-12-06 08:31:30'),
(9, 'Pandit', 'categories/pandit-removebg-preview.png', 1, '2025-12-06 08:31:30'),
(10, 'Photography', 'categories/photography-removebg-preview.png', 1, '2025-12-06 08:31:30'),
(11, 'Pest Control', 'categories/pest_control-removebg-preview.png', 1, '2025-12-06 08:31:30'),
(12, 'Plumber', 'categories/plumber-removebg-preview.png', 1, '2025-12-06 08:31:30'),
(13, 'Remote Service', 'categories/remote_support-removebg-preview.png', 1, '2025-12-06 08:31:30'),
(14, 'Salon', 'categories/salon-removebg-preview.png', 1, '2025-12-06 08:31:30'),
(15, 'Sanitization', 'categories/sanitaization-removebg-preview.png', 1, '2025-12-06 08:31:30'),
(16, 'Smart Home', 'categories/automatic-removebg-preview.png', 1, '2025-12-06 08:31:30'),
(17, 'PBC Working', 'categories/1768648261261.jpg', 1, '2026-01-17 11:11:01'),
(18, 'Driver', 'categories/1773153012636.jpg', 1, '2026-03-10 14:30:12');

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cities`
--

INSERT INTO `cities` (`id`, `name`, `status`, `created_at`) VALUES
(1, 'Lucknow', 1, '2025-12-05 04:13:20'),
(2, 'Kanpur', 1, '2025-12-05 04:13:20'),
(3, 'Agra', 1, '2025-12-05 04:13:20'),
(4, 'Varanasi', 1, '2025-12-05 04:13:20'),
(5, 'Prayagraj', 1, '2025-12-05 04:13:20'),
(6, 'Ghaziabad', 1, '2025-12-05 04:13:20'),
(7, 'Noida', 1, '2025-12-05 04:13:20'),
(8, 'Meerut', 1, '2025-12-05 04:13:20'),
(9, 'Mathura-Vrindavan', 1, '2025-12-05 04:13:20'),
(10, 'Ayodhya', 1, '2025-12-05 04:13:20'),
(11, 'Bareilly', 1, '2025-12-05 04:13:20'),
(12, 'Moradabad', 1, '2025-12-05 04:13:20'),
(13, 'Aligarh', 1, '2025-12-05 04:13:20'),
(14, 'Shahjahanpur', 1, '2025-12-05 04:13:20'),
(15, 'Firozabad', 1, '2025-12-05 04:13:20'),
(16, 'Gorakhpur', 1, '2025-12-05 04:13:20'),
(17, 'Jhansi', 1, '2025-12-05 04:13:20');

-- --------------------------------------------------------

--
-- Table structure for table `colors`
--

CREATE TABLE `colors` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `colors`
--

INSERT INTO `colors` (`id`, `name`) VALUES
(1, 'Beige'),
(2, 'Black'),
(3, 'Blue'),
(4, 'Bronze'),
(5, 'Brown'),
(6, 'Burgundy'),
(7, 'Dark Gray'),
(8, 'Gold'),
(9, 'Gray'),
(10, 'Green'),
(11, 'Light Blue'),
(12, 'Orange'),
(13, 'Pink');

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `discount_percent` int(11) NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 services, 2 rides',
  `expires_at` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `title` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `coupons`
--

INSERT INTO `coupons` (`id`, `code`, `discount_percent`, `type`, `expires_at`, `status`, `created_at`, `title`) VALUES
(4, '123412', 5, 1, '2026-01-23 14:55:00', 1, '2026-01-10 09:26:05', 'winter discount'),
(5, '12341345', 5, 1, '2026-02-18 22:38:00', 1, '2026-02-18 04:40:47', 'special offer');

-- --------------------------------------------------------

--
-- Table structure for table `coupons_used`
--

CREATE TABLE `coupons_used` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `coupon_id` int(11) NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 services, 2 rides',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `applied_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `coupons_used`
--

INSERT INTO `coupons_used` (`id`, `user_id`, `coupon_id`, `type`, `status`, `applied_at`, `updated_at`) VALUES
(1, 25, 4, 1, 1, '2026-01-23 05:35:44', NULL),
(2, 1, 4, 1, 1, '2026-01-23 09:06:14', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `driver_offer`
--

CREATE TABLE `driver_offer` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `profile_photo` varchar(255) DEFAULT NULL,
  `estimated_amount` decimal(10,2) NOT NULL,
  `offer_amount` decimal(10,2) NOT NULL,
  `offer_status` tinyint(4) DEFAULT '0' COMMENT '0=pending,1=accepted,2=rejected,3=expired',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int(10) DEFAULT NULL,
  `driver_id` int(10) DEFAULT NULL,
  `brand_name` varchar(100) DEFAULT NULL,
  `model_name` varchar(100) DEFAULT NULL,
  `driver_name` varchar(255) NOT NULL,
  `total_rides` int(11) NOT NULL DEFAULT '56',
  `rating` double NOT NULL DEFAULT '4.5'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `driver_offer`
--

INSERT INTO `driver_offer` (`id`, `order_id`, `profile_photo`, `estimated_amount`, `offer_amount`, `offer_status`, `created_at`, `updated_at`, `user_id`, `driver_id`, `brand_name`, `model_name`, `driver_name`, `total_rides`, `rating`) VALUES
(1, 1, 'https://admin.rainbowsenterprises.com/DriverDocuments/1768651954610.jpg', 269.00, 269.00, 0, '2026-01-17 17:53:03', '2026-01-17 17:53:03', 18, 78, 'Maruti Suzuki', 'WagonR', 'aman mishra', 56, 4.5),
(2, 2, 'https://admin.rainbowsenterprises.com/DriverDocuments/1768651954610.jpg', 235.00, 235.00, 0, '2026-01-17 18:36:33', '2026-01-17 18:36:49', 18, 78, 'Maruti Suzuki', 'WagonR', 'aman mishra', 56, 4.5),
(3, 3, 'https://admin.rainbowsenterprises.com/DriverDocuments/1768651954610.jpg', 235.00, 217.00, 0, '2026-01-17 18:37:38', '2026-01-17 18:37:38', 18, 78, 'Maruti Suzuki', 'WagonR', 'aman mishra', 56, 4.5),
(4, 4, 'https://admin.rainbowsenterprises.com/DriverDocuments/1768651954610.jpg', 299.00, 299.00, 0, '2026-01-17 18:40:07', '2026-01-17 18:40:10', 18, 78, 'Maruti Suzuki', 'WagonR', 'aman mishra', 56, 4.5),
(5, 9, 'https://admin.rainbowsenterprises.com/DriverDocuments/1768651954610.jpg', 207.00, 207.00, 0, '2026-01-17 19:45:04', '2026-01-17 19:45:04', 20, 78, 'Maruti Suzuki', 'WagonR', 'aman mishra', 56, 4.5),
(6, 20, 'https://admin.rainbowsenterprises.com/DriverDocuments/1768651954610.jpg', 304.00, 304.00, 0, '2026-01-17 22:43:12', '2026-01-17 22:43:17', 20, 78, 'Maruti Suzuki', 'WagonR', 'aman mishra', 56, 4.5),
(7, 21, 'https://admin.rainbowsenterprises.com/DriverDocuments/1768651954610.jpg', 175.00, 175.00, 0, '2026-01-17 22:51:11', '2026-01-17 22:51:20', 20, 78, 'Maruti Suzuki', 'WagonR', 'aman mishra', 56, 4.5),
(8, 22, 'https://admin.rainbowsenterprises.com/DriverDocuments/1768651954610.jpg', 429.00, 429.00, 0, '2026-01-17 22:53:08', '2026-01-17 22:53:08', 20, 78, 'Maruti Suzuki', 'WagonR', 'aman mishra', 56, 4.5),
(9, 23, 'https://admin.rainbowsenterprises.com/DriverDocuments/1768651954610.jpg', 431.00, 431.00, 0, '2026-01-17 22:55:57', '2026-01-17 22:55:57', 20, 78, 'Maruti Suzuki', 'WagonR', 'aman mishra', 56, 4.5),
(10, 24, 'https://admin.rainbowsenterprises.com/DriverDocuments/1768651954610.jpg', 264.00, 264.00, 0, '2026-01-18 07:53:47', '2026-01-18 07:53:47', 20, 78, 'Maruti Suzuki', 'WagonR', 'aman mishra', 56, 4.5),
(11, 25, 'https://admin.rainbowsenterprises.com/DriverDocuments/1768651954610.jpg', 264.00, 264.00, 0, '2026-01-18 07:57:22', '2026-01-18 07:57:22', 20, 78, 'Maruti Suzuki', 'WagonR', 'aman mishra', 56, 4.5),
(12, 26, 'https://admin.rainbowsenterprises.com/DriverDocuments/1768651954610.jpg', 207.00, 207.00, 0, '2026-01-18 11:59:35', '2026-01-18 11:59:40', 21, 78, 'Maruti Suzuki', 'WagonR', 'aman mishra', 56, 4.5),
(13, 28, 'https://admin.rainbowsenterprises.com/DriverDocuments/1768651954610.jpg', 182.00, 182.00, 0, '2026-01-18 12:02:46', '2026-01-18 12:02:46', 21, 78, 'Maruti Suzuki', 'WagonR', 'aman mishra', 56, 4.5),
(14, 42, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 185.00, 185.00, 0, '2026-01-22 12:00:09', '2026-01-22 12:00:09', 4, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5),
(15, 44, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 276.00, 276.00, 0, '2026-01-22 13:00:36', '2026-01-22 13:00:36', 4, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5),
(16, 45, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 276.00, 276.00, 0, '2026-01-22 13:02:22', '2026-01-22 13:02:22', 4, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5),
(17, 66, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769142856196.jpg', 72.00, 81.00, 0, '2026-01-23 10:34:27', '2026-01-23 10:34:27', 25, 84, 'Bajaj Auto', 'RE Compact', 'Harsh  singh', 56, 4.5),
(18, 67, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 98.00, 98.00, 0, '2026-01-23 13:41:16', '2026-01-23 13:41:16', 18, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(19, 73, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 4251.00, 4251.00, 0, '2026-01-23 14:11:11', '2026-01-23 14:11:11', 17, 88, 'Maruti Suzuki', 'WagonR', 'ANSAL  Pandey ', 56, 4.5),
(20, 75, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 2437.00, 2437.00, 0, '2026-01-23 16:35:34', '2026-01-23 16:35:41', 17, 88, 'Maruti Suzuki', 'WagonR', 'ANSAL  Pandey ', 56, 4.5),
(21, 87, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 3312.00, 3312.00, 0, '2026-01-23 16:58:35', '2026-01-23 16:58:40', 17, 88, 'Maruti Suzuki', 'WagonR', 'ANSAL  Pandey ', 56, 4.5),
(22, 89, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 1975.00, 1975.00, 0, '2026-01-23 17:15:00', '2026-01-23 17:15:00', 17, 88, 'Maruti Suzuki', 'WagonR', 'ANSAL  Pandey ', 56, 4.5),
(23, 94, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 3287.00, 3287.00, 0, '2026-01-24 09:11:16', '2026-01-24 09:11:16', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(24, 98, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 2460.00, 2460.00, 0, '2026-01-24 11:11:55', '2026-01-24 11:12:14', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(25, 100, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 2434.00, 2434.00, 0, '2026-01-24 11:26:53', '2026-01-24 11:27:41', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(26, 113, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 1186.00, 1186.00, 0, '2026-01-24 20:57:30', '2026-01-24 20:57:30', 17, 88, 'Maruti Suzuki', 'WagonR', 'ANSAL  Pandey ', 56, 4.5),
(27, 118, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 413.00, 413.00, 0, '2026-01-24 21:04:17', '2026-01-24 21:04:17', 17, 88, 'Maruti Suzuki', 'WagonR', 'ANSAL  Pandey ', 56, 4.5),
(28, 119, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 284.00, 284.00, 0, '2026-01-24 21:04:45', '2026-01-24 21:04:45', 17, 88, 'Maruti Suzuki', 'WagonR', 'ANSAL  Pandey ', 56, 4.5),
(29, 125, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 252.00, 252.00, 0, '2026-01-25 18:32:28', '2026-01-25 18:32:28', 34, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(30, 162, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 571.00, 571.00, 0, '2026-01-26 22:08:53', '2026-01-26 22:08:53', 18, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(31, 164, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 1752.00, 1752.00, 0, '2026-01-26 22:15:25', '2026-01-26 22:15:27', 18, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(32, 166, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 159.00, 159.00, 0, '2026-01-26 22:20:42', '2026-01-26 22:20:53', 18, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(33, 172, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 5580.00, 5580.00, 0, '2026-01-27 11:09:47', '2026-01-27 11:09:47', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(34, 173, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 1627.00, 1627.00, 0, '2026-01-27 11:15:13', '2026-01-27 11:15:13', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(35, 174, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 6358.00, 6358.00, 0, '2026-01-27 13:33:35', '2026-01-27 13:33:35', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(36, 176, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769502101076.jpg', 824.00, 824.00, 0, '2026-01-27 18:04:37', '2026-01-27 18:04:48', 15, 96, 'Maruti Suzuki', 'Dzire', 'amar soni', 56, 4.5),
(37, 179, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769502101076.jpg', 4730.00, 4730.00, 0, '2026-01-27 18:10:15', '2026-01-27 18:10:15', 17, 96, 'Maruti Suzuki', 'Dzire', 'amar soni', 56, 4.5),
(38, 181, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769502101076.jpg', 5555.00, 5555.00, 0, '2026-01-27 18:14:34', '2026-01-27 18:14:34', 17, 96, 'Maruti Suzuki', 'Dzire', 'amar soni', 56, 4.5),
(39, 183, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769502101076.jpg', 6226.00, 6226.00, 0, '2026-01-27 18:28:54', '2026-01-27 18:29:00', 17, 96, 'Maruti Suzuki', 'Dzire', 'amar soni', 56, 4.5),
(40, 184, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769502101076.jpg', 1142.00, 1142.00, 0, '2026-01-27 18:34:36', '2026-01-27 18:34:36', 17, 96, 'Maruti Suzuki', 'Dzire', 'amar soni', 56, 4.5),
(41, 188, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 1301.00, 1301.00, 0, '2026-01-27 22:45:54', '2026-01-27 22:45:54', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(42, 192, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 1016.00, 1016.00, 0, '2026-01-27 22:51:14', '2026-01-27 22:51:14', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(43, 199, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 945.00, 945.00, 0, '2026-01-28 08:24:26', '2026-01-28 08:24:26', 18, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(44, 200, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 347.00, 347.00, 0, '2026-01-28 08:45:59', '2026-01-28 08:45:59', 18, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(45, 201, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 347.00, 347.00, 0, '2026-01-28 08:48:13', '2026-01-28 08:48:40', 18, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(46, 202, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 361.00, 361.00, 0, '2026-01-28 08:54:32', '2026-01-28 08:54:32', 18, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(47, 207, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 368.00, 368.00, 0, '2026-01-28 09:19:18', '2026-01-28 09:19:24', 18, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(48, 213, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 79.00, 79.00, 0, '2026-01-28 12:41:05', '2026-01-28 12:41:05', 3, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(49, 226, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 870.00, 870.00, 0, '2026-01-29 10:44:10', '2026-01-29 10:44:10', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(50, 227, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 1346.00, 1346.00, 0, '2026-01-29 10:57:36', '2026-01-29 10:57:36', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(51, 230, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 643.00, 643.00, 0, '2026-01-29 11:35:39', '2026-01-29 11:35:39', 17, 88, 'Maruti Suzuki', 'WagonR', 'ANSAL  Pandey ', 56, 4.5),
(52, 233, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 103.00, 103.00, 0, '2026-01-29 12:00:52', '2026-01-29 12:00:52', 3, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(53, 249, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 44.00, 44.00, 0, '2026-01-29 13:27:34', '2026-01-29 13:27:41', 3, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(54, 252, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 44.00, 44.00, 0, '2026-01-29 13:45:59', '2026-01-29 13:46:10', 3, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(55, 254, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 44.00, 44.00, 0, '2026-01-29 14:53:27', '2026-01-29 14:53:27', 3, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5),
(56, 255, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 44.00, 44.00, 0, '2026-01-29 14:54:45', '2026-01-29 14:54:45', 3, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5),
(57, 256, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 103.00, 103.00, 0, '2026-01-29 15:00:01', '2026-01-29 15:00:01', 3, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5),
(58, 257, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 103.00, 103.00, 0, '2026-01-29 15:00:58', '2026-01-29 15:00:58', 3, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5),
(59, 259, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 372.00, 372.00, 0, '2026-01-30 13:03:33', '2026-01-30 13:03:33', 18, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(60, 264, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 2178.00, 2178.00, 0, '2026-01-30 21:05:16', '2026-01-30 21:05:16', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(61, 272, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 5708.00, 5708.00, 0, '2026-02-01 10:24:06', '2026-02-01 10:24:06', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(62, 274, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 2706.00, 2706.00, 0, '2026-02-02 19:57:21', '2026-02-02 19:57:21', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(63, 276, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 293.00, 293.00, 0, '2026-02-03 10:04:03', '2026-02-03 10:04:03', 4, 88, 'Maruti Suzuki', 'WagonR', 'ANSAL  Pandey ', 56, 4.5),
(64, 277, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 293.00, 293.00, 0, '2026-02-03 10:08:47', '2026-02-03 10:08:47', 4, 88, 'Maruti Suzuki', 'WagonR', 'ANSAL  Pandey ', 56, 4.5),
(65, 278, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 293.00, 293.00, 0, '2026-02-03 10:13:28', '2026-02-03 10:13:28', 4, 88, 'Maruti Suzuki', 'WagonR', 'ANSAL  Pandey ', 56, 4.5),
(66, 279, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 1229.00, 1229.00, 0, '2026-02-03 12:28:32', '2026-02-03 12:28:32', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(67, 307, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 293.00, 293.00, 0, '2026-02-04 15:17:40', '2026-02-04 15:17:40', 4, 88, 'Maruti Suzuki', 'WagonR', 'ANSAL  Pandey ', 56, 4.5),
(68, 308, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 5495.00, 5495.00, 0, '2026-02-06 10:21:18', '2026-02-06 10:21:18', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(69, 309, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 401.00, 401.00, 0, '2026-02-06 13:15:27', '2026-02-06 13:15:27', 3, 88, 'Maruti Suzuki', 'WagonR', 'ANSAL  Pandey ', 56, 4.5),
(70, 316, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 121.00, 121.00, 0, '2026-02-06 15:11:51', '2026-02-06 15:11:51', 3, 19, 'Bajaj', 'Platina', 'Ramu Sharma', 56, 4.5),
(71, 321, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 94.00, 94.00, 0, '2026-02-06 15:25:44', '2026-02-06 15:25:44', 3, 19, 'Bajaj', 'Platina', 'Ramu Sharma', 56, 4.5),
(72, 323, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 94.00, 94.00, 0, '2026-02-06 15:29:44', '2026-02-06 15:29:44', 3, 19, 'Bajaj', 'Platina', 'Ramu Sharma', 56, 4.5),
(73, 329, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 121.00, 121.00, 0, '2026-02-06 17:21:00', '2026-02-06 17:21:00', 3, 19, 'Bajaj', 'Platina', 'Ramu Sharma', 56, 4.5),
(74, 366, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 1219.00, 1219.00, 0, '2026-02-09 19:45:20', '2026-02-09 19:45:20', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(75, 367, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 1239.00, 1239.00, 0, '2026-02-09 19:48:42', '2026-02-09 19:48:42', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(76, 369, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 1236.00, 1236.00, 0, '2026-02-09 19:52:43', '2026-02-09 19:52:43', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(77, 371, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 377.00, 377.00, 0, '2026-02-09 23:10:12', '2026-02-09 23:10:12', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(78, 374, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 362.00, 362.00, 0, '2026-02-10 09:32:21', '2026-02-10 09:32:21', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(79, 375, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 362.00, 362.00, 0, '2026-02-10 09:34:20', '2026-02-10 09:34:20', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(80, 376, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 1229.00, 1229.00, 0, '2026-02-10 09:38:37', '2026-02-10 09:38:47', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(81, 380, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 111.00, 111.00, 0, '2026-02-10 09:46:49', '2026-02-10 09:46:49', 20, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(82, 382, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 119.00, 119.00, 0, '2026-02-10 09:49:08', '2026-02-10 09:49:08', 20, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(83, 383, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 184.00, 184.00, 0, '2026-02-10 09:52:31', '2026-02-10 09:52:31', 20, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(84, 384, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 130.00, 130.00, 0, '2026-02-10 10:14:40', '2026-02-10 10:14:40', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(85, 386, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 121.00, 121.00, 0, '2026-02-10 10:16:18', '2026-02-10 10:16:18', 3, 19, 'Bajaj', 'Platina', 'Ramu Sharma', 56, 4.5),
(86, 387, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 1236.00, 1236.00, 0, '2026-02-10 10:16:24', '2026-02-10 10:16:24', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(87, 388, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 121.00, 121.00, 0, '2026-02-10 10:18:12', '2026-02-10 10:18:12', 3, 19, 'Bajaj', 'Platina', 'Ramu Sharma', 56, 4.5),
(88, 390, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 120.00, 120.00, 0, '2026-02-10 10:24:03', '2026-02-10 10:24:03', 20, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(89, 391, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 120.00, 120.00, 0, '2026-02-10 10:27:42', '2026-02-10 10:27:42', 20, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(90, 394, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 82.00, 82.00, 0, '2026-02-10 10:32:33', '2026-02-10 10:32:33', 20, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(91, 395, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 158.00, 158.00, 0, '2026-02-10 10:34:47', '2026-02-10 10:34:50', 20, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(92, 397, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 1236.00, 1236.00, 0, '2026-02-10 10:40:07', '2026-02-10 10:40:07', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(93, 399, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 119.00, 119.00, 0, '2026-02-10 10:43:58', '2026-02-10 10:43:58', 20, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(94, 400, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 2546.00, 2546.00, 0, '2026-02-10 10:47:50', '2026-02-10 10:47:50', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(95, 408, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 883.00, 883.00, 0, '2026-02-10 13:05:50', '2026-02-10 13:05:50', 17, 88, 'Maruti Suzuki', 'WagonR', 'ANSAL  Pandey ', 56, 4.5),
(96, 409, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 1265.00, 1265.00, 0, '2026-02-10 13:11:12', '2026-02-10 13:11:12', 17, 88, 'Maruti Suzuki', 'WagonR', 'ANSAL  Pandey ', 56, 4.5),
(97, 414, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 270.00, 270.00, 0, '2026-02-10 14:39:51', '2026-02-10 14:39:51', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(98, 417, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 384.00, 384.00, 0, '2026-02-10 14:48:06', '2026-02-10 14:48:10', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(99, 421, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 84.00, 84.00, 0, '2026-02-10 15:54:37', '2026-02-10 15:54:41', 20, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(100, 422, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 72.00, 72.00, 0, '2026-02-10 15:58:00', '2026-02-10 15:58:00', 20, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(101, 426, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 500.00, 500.00, 0, '2026-02-10 18:14:14', '2026-02-10 18:14:14', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(102, 427, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 521.00, 521.00, 0, '2026-02-10 18:16:51', '2026-02-10 18:16:51', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(103, 429, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 1229.00, 1229.00, 0, '2026-02-10 18:36:31', '2026-02-10 18:36:31', 17, 88, 'Maruti Suzuki', 'WagonR', 'ANSAL  Pandey ', 56, 4.5),
(104, 430, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 511.00, 511.00, 0, '2026-02-10 18:38:06', '2026-02-10 18:38:06', 17, 88, 'Maruti Suzuki', 'WagonR', 'ANSAL  Pandey ', 56, 4.5),
(105, 431, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 511.00, 511.00, 0, '2026-02-10 18:40:18', '2026-02-10 18:40:18', 17, 88, 'Maruti Suzuki', 'WagonR', 'ANSAL  Pandey ', 56, 4.5),
(106, 432, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 511.00, 511.00, 0, '2026-02-10 18:41:52', '2026-02-10 18:42:17', 17, 88, 'Maruti Suzuki', 'WagonR', 'ANSAL  Pandey ', 56, 4.5),
(107, 435, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 1080.00, 1080.00, 0, '2026-02-10 18:47:40', '2026-02-10 18:47:40', 17, 88, 'Maruti Suzuki', 'WagonR', 'ANSAL  Pandey ', 56, 4.5),
(108, 440, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 377.00, 377.00, 0, '2026-02-10 19:06:11', '2026-02-10 19:06:11', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(109, 442, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 1234.00, 1234.00, 0, '2026-02-10 19:14:20', '2026-02-10 19:14:20', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(110, 444, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 144.00, 144.00, 0, '2026-02-10 19:18:33', '2026-02-10 19:18:38', 20, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(111, 447, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 1236.00, 1236.00, 0, '2026-02-10 20:07:56', '2026-02-10 20:07:56', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(112, 449, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 1236.00, 1236.00, 0, '2026-02-10 20:10:34', '2026-02-10 20:10:34', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(113, 450, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 5663.00, 5663.00, 0, '2026-02-10 20:12:44', '2026-02-10 20:12:44', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(114, 459, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 386.00, 386.00, 0, '2026-02-10 21:11:37', '2026-02-10 21:11:37', 38, 88, 'Maruti Suzuki', 'WagonR', 'ANSAL  Pandey ', 56, 4.5),
(115, 462, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 1143.00, 1143.00, 0, '2026-02-10 22:58:04', '2026-02-10 22:58:04', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(116, 464, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 184.00, 184.00, 0, '2026-02-10 23:07:47', '2026-02-10 23:07:47', 20, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(117, 467, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 197.00, 197.00, 0, '2026-02-11 20:30:56', '2026-02-11 20:30:56', 39, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(118, 468, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 197.00, 197.00, 0, '2026-02-11 20:34:26', '2026-02-11 20:34:26', 40, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(119, 477, 'https://admin.rainbowsenterprises.com/DriverDocuments/1770867607064.jpg', 701.00, 716.00, 0, '2026-02-12 09:44:31', '2026-02-12 09:44:31', 4, 98, 'Bajaj', 'Platina', 'nitin pandey', 56, 4.5),
(120, 495, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769192716418.jpg', 27.00, 30.00, 0, '2026-02-13 10:37:06', '2026-02-13 10:37:31', 42, 91, NULL, NULL, 'ncbcbd bdbddb', 56, 4.5),
(121, 497, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769192716418.jpg', 38.00, 41.00, 0, '2026-02-13 16:14:20', '2026-02-13 16:14:28', 41, 91, NULL, NULL, 'ncbcbd bdbddb', 56, 4.5),
(122, 498, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 1234.00, 1234.00, 0, '2026-02-13 20:50:46', '2026-02-13 20:50:46', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(123, 502, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 143.00, 143.00, 0, '2026-02-14 17:40:08', '2026-02-14 17:40:08', 20, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(124, 506, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 143.00, 143.00, 0, '2026-02-14 18:53:59', '2026-02-14 18:54:35', 20, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(125, 507, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 117.00, 117.00, 0, '2026-02-14 18:57:17', '2026-02-14 18:57:17', 20, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(126, 508, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 117.00, 117.00, 0, '2026-02-14 19:00:03', '2026-02-14 19:00:03', 20, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(127, 510, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 1500.00, 1500.00, 0, '2026-02-14 19:06:35', '2026-02-14 19:06:44', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(128, 512, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 1231.00, 1231.00, 0, '2026-02-14 19:13:57', '2026-02-14 19:13:57', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(129, 522, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 1232.00, 1232.00, 0, '2026-02-14 19:53:48', '2026-02-14 19:54:13', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(130, 530, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 120.00, 120.00, 0, '2026-02-14 20:30:04', '2026-02-14 20:30:04', 20, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(131, 542, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769502101076.jpg', 788.00, 788.00, 0, '2026-02-14 22:09:34', '2026-02-14 22:09:34', 15, 96, 'Maruti Suzuki', 'Dzire', 'amar soni', 56, 4.5),
(132, 545, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769502101076.jpg', 4452.00, 4463.00, 0, '2026-02-14 22:17:07', '2026-02-14 22:17:07', 15, 96, 'Maruti Suzuki', 'Dzire', 'amar soni', 56, 4.5),
(133, 550, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 393.00, 393.00, 0, '2026-02-15 11:46:36', '2026-02-15 11:46:36', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(134, 554, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 1235.00, 1235.00, 0, '2026-02-16 08:55:04', '2026-02-16 08:55:04', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(135, 555, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 85.00, 85.00, 0, '2026-02-16 10:02:37', '2026-02-16 10:02:37', 17, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(136, 558, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 1236.00, 1236.00, 0, '2026-02-16 16:57:53', '2026-02-16 16:57:53', 18, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(137, 559, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 1236.00, 1236.00, 0, '2026-02-16 17:01:05', '2026-02-16 17:01:05', 18, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(138, 560, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 351.00, 351.00, 0, '2026-02-16 17:02:42', '2026-02-16 17:02:42', 18, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(139, 563, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 1519.00, 1519.00, 0, '2026-02-16 17:08:06', '2026-02-16 17:08:06', 18, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(140, 566, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 5582.00, 5582.00, 0, '2026-02-16 17:17:24', '2026-02-16 17:17:24', 18, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(141, 570, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 205.00, 205.00, 0, '2026-02-18 14:51:30', '2026-02-18 14:51:30', 18, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(142, 577, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 274.00, 274.00, 0, '2026-02-18 18:52:01', '2026-02-18 18:52:03', 17, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(143, 578, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 264.00, 264.00, 0, '2026-02-18 18:54:51', '2026-02-18 18:54:51', 18, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(144, 579, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 121.00, 121.00, 0, '2026-02-19 10:06:05', '2026-02-19 10:06:05', 3, 19, 'Bajaj', 'Platina', 'Ramu Sharma', 56, 4.5),
(145, 582, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 121.00, 121.00, 0, '2026-02-19 10:53:31', '2026-02-19 10:53:31', 3, 19, 'Bajaj', 'Platina', 'Ramu Sharma', 56, 4.5),
(146, 590, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 116.00, 116.00, 0, '2026-02-19 11:27:56', '2026-02-19 11:27:58', 3, 19, 'Bajaj', 'Platina', 'Ramu Sharma', 56, 4.5),
(147, 591, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 121.00, 121.00, 0, '2026-02-19 11:56:32', '2026-02-19 11:56:32', 3, 19, 'Bajaj', 'Platina', 'Ramu Sharma', 56, 4.5),
(148, 592, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 121.00, 121.00, 0, '2026-02-19 11:58:54', '2026-02-19 11:58:54', 3, 19, 'Bajaj', 'Platina', 'Ramu Sharma', 56, 4.5),
(149, 600, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 1236.00, 1236.00, 0, '2026-02-20 09:01:55', '2026-02-20 09:01:55', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(150, 601, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 1295.00, 1295.00, 0, '2026-02-20 09:04:46', '2026-02-20 09:04:46', 17, 93, 'Maruti Suzuki', 'Dzire', 'manu mishra', 56, 4.5),
(151, 604, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 513.00, 513.00, 0, '2026-02-20 21:20:08', '2026-02-20 21:20:08', 50, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(152, 612, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 116.00, 116.00, 0, '2026-02-21 17:33:58', '2026-02-21 17:33:58', 3, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(153, 613, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 118.00, 116.00, 0, '2026-02-21 17:37:09', '2026-02-21 17:37:18', 3, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(154, 620, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 196.00, 196.00, 0, '2026-02-21 17:52:18', '2026-02-21 17:52:18', 3, 19, 'Bajaj', 'Platina', 'Ramu Sharma', 56, 4.5),
(155, 621, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 120.00, 120.00, 0, '2026-02-21 17:53:36', '2026-02-21 17:53:50', 3, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(156, 621, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 120.00, 122.00, 0, '2026-02-21 17:53:49', '2026-02-21 17:53:49', 3, 19, 'Bajaj', 'Platina', 'Ramu Sharma', 56, 4.5),
(157, 622, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 120.00, 120.00, 0, '2026-02-21 17:55:31', '2026-02-21 17:55:31', 3, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(158, 625, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 393.00, 393.00, 0, '2026-02-21 18:00:12', '2026-02-21 18:00:12', 17, 19, 'Bajaj', 'Platina', 'Ramu Sharma', 56, 4.5),
(159, 629, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 103.00, 103.00, 0, '2026-02-21 23:12:18', '2026-02-21 23:12:18', 3, 19, 'Bajaj', 'Platina', 'Ramu Sharma', 56, 4.5),
(160, 631, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 103.00, 103.00, 0, '2026-02-21 23:24:38', '2026-02-21 23:24:38', 3, 19, 'Bajaj', 'Platina', 'Ramu Sharma', 56, 4.5),
(161, 634, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 121.00, 121.00, 0, '2026-02-22 09:00:27', '2026-02-22 09:00:27', 3, 19, 'Bajaj', 'Platina', 'Ramu Sharma', 56, 4.5),
(162, 635, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 121.00, 121.00, 0, '2026-02-22 09:01:34', '2026-02-22 09:01:34', 3, 19, 'Bajaj', 'Platina', 'Ramu Sharma', 56, 4.5),
(163, 638, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 363.00, 363.00, 0, '2026-02-24 09:54:21', '2026-02-24 09:54:21', 17, 87, 'Bajaj', 'Platina', 'ama  mishra', 56, 4.5),
(164, 647, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771912100753.jpg', 232.00, 232.00, 0, '2026-02-26 12:44:25', '2026-02-26 12:44:25', 53, 101, 'Honda City', 'Sport', 'SHIVANSHU  PANDEY ', 56, 4.5),
(165, 655, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771938239753.jpg', 184.00, 184.00, 0, '2026-02-27 12:57:36', '2026-02-27 12:57:36', 18, 102, 'Honda', 'Shine', 'aman mishra', 56, 4.5),
(166, 656, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771938239753.jpg', 72.00, 72.00, 0, '2026-02-27 13:27:28', '2026-02-27 13:27:38', 18, 102, 'Honda', 'Shine', 'aman mishra', 56, 4.5),
(167, 661, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771912100753.jpg', 6618.00, 6618.00, 0, '2026-02-27 16:31:59', '2026-02-27 16:32:01', 17, 101, 'Honda City', 'Sport', 'SHIVANSHU  PANDEY ', 56, 4.5),
(168, 662, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771912100753.jpg', 398.00, 398.00, 0, '2026-02-27 16:33:27', '2026-02-27 16:33:27', 17, 101, 'Honda City', 'Sport', 'SHIVANSHU  PANDEY ', 56, 4.5),
(169, 664, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771912100753.jpg', 967.00, 967.00, 0, '2026-02-27 16:34:26', '2026-02-27 16:34:26', 17, 101, 'Honda City', 'Sport', 'SHIVANSHU  PANDEY ', 56, 4.5),
(170, 669, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771938239753.jpg', 358.00, 358.00, 0, '2026-03-05 13:19:23', '2026-03-05 13:19:23', 17, 102, 'Honda', 'Shine', 'aman mishra', 56, 4.5),
(171, 671, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771938239753.jpg', 118.00, 118.00, 0, '2026-03-05 14:26:06', '2026-03-05 14:26:07', 17, 102, 'Honda', 'Shine', 'aman mishra', 56, 4.5),
(172, 691, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771938239753.jpg', 613.00, 613.00, 0, '2026-03-06 21:27:31', '2026-03-06 21:27:31', 18, 102, 'Honda', 'Shine', 'aman mishra', 56, 4.5),
(173, 700, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771938239753.jpg', 68.00, 68.00, 0, '2026-03-07 16:12:14', '2026-03-07 16:12:23', 61, 102, 'Honda', 'Shine', 'aman mishra', 56, 4.5),
(174, 716, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771938239753.jpg', 143.00, 143.00, 0, '2026-03-09 14:17:53', '2026-03-09 14:17:53', 17, 102, 'Honda', 'Shine', 'aman mishra', 56, 4.5),
(175, 721, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771938239753.jpg', 49.00, 49.00, 0, '2026-03-09 14:37:34', '2026-03-09 14:37:34', 65, 102, 'Honda', 'Shine', 'aman mishra', 56, 4.5),
(176, 728, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771938239753.jpg', 119.00, 119.00, 0, '2026-03-10 14:55:37', '2026-03-10 14:55:37', 67, 102, 'Honda', 'Shine', 'aman mishra', 56, 4.5),
(177, 740, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771912100753.jpg', 5593.00, 5593.00, 0, '2026-03-12 17:39:27', '2026-03-12 17:39:32', 17, 101, 'Honda City', 'Sport', 'SHIVANSHU  PANDEY ', 56, 4.5),
(178, 741, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771912100753.jpg', 5593.00, 5593.00, 0, '2026-03-12 17:40:22', '2026-03-12 17:40:22', 17, 101, 'Honda City', 'Sport', 'SHIVANSHU  PANDEY ', 56, 4.5),
(179, 742, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771912100753.jpg', 968.00, 968.00, 0, '2026-03-12 17:43:49', '2026-03-12 17:43:49', 17, 101, 'Honda City', 'Sport', 'SHIVANSHU  PANDEY ', 56, 4.5),
(180, 743, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771912100753.jpg', 968.00, 968.00, 0, '2026-03-12 17:47:00', '2026-03-12 17:47:00', 17, 101, 'Honda City', 'Sport', 'SHIVANSHU  PANDEY ', 56, 4.5),
(181, 744, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771938239753.jpg', 74.00, 74.00, 0, '2026-03-12 22:15:32', '2026-03-12 22:15:34', 68, 102, 'Honda', 'Shine', 'aman mishra', 56, 4.5),
(182, 751, 'https://admin.rainbowsenterprises.com/DriverDocuments/1771938239753.jpg', 154.00, 154.00, 0, '2026-03-13 11:46:06', '2026-03-13 11:46:06', 17, 102, 'Honda', 'Shine', 'aman mishra', 56, 4.5);

-- --------------------------------------------------------

--
-- Table structure for table `driver_online_logs`
--

CREATE TABLE `driver_online_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `driver_id` bigint(20) UNSIGNED NOT NULL,
  `online_time` datetime NOT NULL,
  `offline_time` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `driver_online_logs`
--

INSERT INTO `driver_online_logs` (`id`, `driver_id`, `online_time`, `offline_time`, `created_at`, `updated_at`) VALUES
(1, 20, '2026-01-05 17:17:22', '2026-01-05 17:24:38', '2026-01-05 17:17:22', '2026-01-05 17:24:38'),
(2, 20, '2026-01-05 17:41:25', '2026-01-06 16:56:29', '2026-01-05 17:41:25', '2026-01-06 16:56:29'),
(3, 19, '2026-01-05 22:33:08', '2026-01-09 09:23:13', '2026-01-05 22:33:08', '2026-01-09 09:23:13'),
(4, 20, '2026-01-06 16:56:40', '2026-01-10 13:08:33', '2026-01-06 16:56:40', '2026-01-10 13:08:33'),
(5, 19, '2026-01-09 09:20:32', '2026-01-09 09:24:09', '2026-01-09 09:23:32', '2026-01-09 09:24:09'),
(6, 19, '2026-01-09 09:24:32', '2026-01-22 11:06:23', '2026-01-09 09:24:32', '2026-01-22 11:06:23'),
(7, 20, '2026-01-10 13:08:50', NULL, '2026-01-10 13:08:50', '2026-01-10 13:08:50'),
(8, 77, '2026-01-17 12:26:05', NULL, '2026-01-17 12:26:05', '2026-01-17 12:26:05'),
(9, 78, '2026-01-17 17:48:56', '2026-01-17 20:01:43', '2026-01-17 17:48:56', '2026-01-17 20:01:43'),
(10, 78, '2026-01-17 20:01:49', '2026-01-17 21:00:00', '2026-01-17 20:01:49', '2026-01-17 21:00:00'),
(11, 78, '2026-01-17 21:02:28', NULL, '2026-01-17 21:02:28', '2026-01-17 21:02:28'),
(12, 78, '2026-01-17 21:02:28', NULL, '2026-01-17 21:02:28', '2026-01-17 21:02:28'),
(13, 19, '2026-01-22 11:48:09', '2026-01-22 17:52:39', '2026-01-22 11:48:09', '2026-01-22 17:52:39'),
(14, 19, '2026-01-22 17:53:00', '2026-01-22 17:53:18', '2026-01-22 17:53:00', '2026-01-22 17:53:18'),
(15, 19, '2026-01-22 17:53:28', '2026-01-22 17:53:46', '2026-01-22 17:53:28', '2026-01-22 17:53:46'),
(16, 19, '2026-01-22 17:53:49', '2026-01-22 17:53:56', '2026-01-22 17:53:49', '2026-01-22 17:53:56'),
(17, 84, '2026-01-23 10:28:43', NULL, '2026-01-23 10:28:43', '2026-01-23 10:28:43'),
(18, 84, '2026-01-23 10:28:43', NULL, '2026-01-23 10:28:43', '2026-01-23 10:28:43'),
(19, 87, '2026-01-23 13:35:07', NULL, '2026-01-23 13:35:07', '2026-01-23 13:35:07'),
(20, 87, '2026-01-23 13:35:07', '2026-01-27 12:59:28', '2026-01-23 13:35:07', '2026-01-27 12:59:28'),
(21, 88, '2026-01-23 14:10:43', '2026-02-03 10:18:25', '2026-01-23 14:10:43', '2026-02-03 10:18:25'),
(22, 19, '2026-01-24 00:24:01', '2026-01-26 15:39:49', '2026-01-24 00:24:01', '2026-01-26 15:39:49'),
(23, 93, '2026-01-24 09:10:28', '2026-01-24 09:28:45', '2026-01-24 09:10:28', '2026-01-24 09:28:45'),
(24, 93, '2026-01-24 09:28:48', NULL, '2026-01-24 09:28:48', '2026-01-24 09:28:48'),
(25, 96, '2026-01-27 18:02:21', NULL, '2026-01-27 18:02:21', '2026-01-27 18:02:21'),
(26, 87, '2026-01-27 20:08:55', NULL, '2026-01-27 20:08:55', '2026-01-27 20:08:55'),
(27, 87, '2026-01-27 20:08:55', '2026-02-21 15:38:15', '2026-01-27 20:08:55', '2026-02-21 15:38:15'),
(28, 87, '2026-01-27 20:08:55', '2026-02-18 18:51:05', '2026-01-27 20:08:55', '2026-02-18 18:51:05'),
(29, 19, '2026-01-29 09:33:17', '2026-01-29 12:27:07', '2026-01-29 09:33:17', '2026-01-29 12:27:07'),
(30, 19, '2026-01-29 12:27:10', '2026-01-30 13:19:15', '2026-01-29 12:27:10', '2026-01-30 13:19:15'),
(31, 19, '2026-01-30 13:19:17', '2026-02-06 15:04:55', '2026-01-30 13:19:17', '2026-02-06 15:04:55'),
(32, 88, '2026-02-03 10:18:35', NULL, '2026-02-03 10:18:35', '2026-02-03 10:18:35'),
(33, 19, '2026-02-06 15:05:08', '2026-02-06 15:08:44', '2026-02-06 15:05:08', '2026-02-06 15:08:44'),
(34, 19, '2026-02-06 15:09:05', '2026-02-07 12:41:04', '2026-02-06 15:09:05', '2026-02-07 12:41:04'),
(35, 19, '2026-02-07 12:41:15', '2026-02-09 12:43:36', '2026-02-07 12:41:15', '2026-02-09 12:43:36'),
(36, 19, '2026-02-09 12:43:47', '2026-02-09 15:05:53', '2026-02-09 12:43:47', '2026-02-09 15:05:53'),
(37, 19, '2026-02-09 15:09:27', '2026-02-09 15:35:17', '2026-02-09 15:09:27', '2026-02-09 15:35:17'),
(38, 19, '2026-02-09 15:35:41', '2026-02-09 15:47:43', '2026-02-09 15:35:41', '2026-02-09 15:47:43'),
(39, 19, '2026-02-10 10:15:25', NULL, '2026-02-10 10:15:25', '2026-02-10 10:15:25'),
(40, 87, '2026-02-10 10:26:03', '2026-02-18 10:28:54', '2026-02-10 10:26:03', '2026-02-18 10:28:54'),
(41, 93, '2026-02-10 10:40:47', NULL, '2026-02-10 10:40:47', '2026-02-10 10:40:47'),
(42, 19, '2026-02-10 10:44:59', '2026-02-10 10:45:11', '2026-02-10 10:44:59', '2026-02-10 10:45:11'),
(43, 19, '2026-02-10 10:45:41', '2026-02-10 10:45:46', '2026-02-10 10:45:41', '2026-02-10 10:45:46'),
(44, 19, '2026-02-10 10:45:58', NULL, '2026-02-10 10:45:58', '2026-02-10 10:45:58'),
(45, 88, '2026-02-10 12:56:01', '2026-02-10 13:07:46', '2026-02-10 12:56:01', '2026-02-10 13:07:46'),
(46, 88, '2026-02-10 13:09:01', NULL, '2026-02-10 13:09:01', '2026-02-10 13:09:01'),
(47, 98, '2026-02-12 09:17:35', '2026-02-21 09:36:54', '2026-02-12 09:17:35', '2026-02-21 09:36:54'),
(48, 91, '2026-02-12 10:46:46', NULL, '2026-02-12 10:46:46', '2026-02-12 10:46:46'),
(49, 87, '2026-02-14 12:29:14', '2026-02-14 21:31:22', '2026-02-14 12:29:14', '2026-02-14 21:31:22'),
(50, 87, '2026-02-14 12:29:14', '2026-02-14 18:51:58', '2026-02-14 12:29:14', '2026-02-14 18:51:58'),
(51, 87, '2026-02-14 18:52:01', '2026-02-14 18:52:15', '2026-02-14 18:52:01', '2026-02-14 18:52:15'),
(52, 87, '2026-02-14 18:52:40', '2026-02-14 21:21:43', '2026-02-14 18:52:40', '2026-02-14 21:21:43'),
(53, 93, '2026-02-14 19:03:28', '2026-02-14 19:05:54', '2026-02-14 19:03:28', '2026-02-14 19:05:54'),
(54, 93, '2026-02-14 19:06:02', '2026-02-14 19:34:25', '2026-02-14 19:06:02', '2026-02-14 19:34:25'),
(55, 93, '2026-02-14 19:34:32', '2026-02-14 19:37:46', '2026-02-14 19:34:32', '2026-02-14 19:37:46'),
(56, 93, '2026-02-14 19:37:49', '2026-02-14 19:44:41', '2026-02-14 19:37:49', '2026-02-14 19:44:41'),
(57, 93, '2026-02-14 19:44:46', '2026-02-14 19:52:35', '2026-02-14 19:44:46', '2026-02-14 19:52:35'),
(58, 93, '2026-02-14 19:52:37', '2026-02-14 20:09:45', '2026-02-14 19:52:37', '2026-02-14 20:09:45'),
(59, 93, '2026-02-14 20:09:46', '2026-02-14 20:31:40', '2026-02-14 20:09:46', '2026-02-14 20:31:40'),
(60, 93, '2026-02-14 20:31:42', '2026-02-14 20:34:17', '2026-02-14 20:31:42', '2026-02-14 20:34:17'),
(61, 93, '2026-02-14 20:34:19', '2026-02-15 11:46:05', '2026-02-14 20:34:19', '2026-02-15 11:46:05'),
(62, 87, '2026-02-14 21:21:45', '2026-02-14 21:25:12', '2026-02-14 21:21:45', '2026-02-14 21:25:12'),
(63, 87, '2026-02-14 21:25:16', '2026-02-14 21:28:49', '2026-02-14 21:25:16', '2026-02-14 21:28:49'),
(64, 87, '2026-02-14 21:28:51', '2026-02-14 21:31:22', '2026-02-14 21:28:51', '2026-02-14 21:31:22'),
(65, 87, '2026-02-14 21:31:40', '2026-02-15 11:42:46', '2026-02-14 21:31:40', '2026-02-15 11:42:46'),
(66, 96, '2026-02-14 22:06:56', NULL, '2026-02-14 22:06:56', '2026-02-14 22:06:56'),
(67, 87, '2026-02-15 11:42:48', '2026-02-15 11:44:25', '2026-02-15 11:42:48', '2026-02-15 11:44:25'),
(68, 87, '2026-02-15 11:44:28', '2026-02-15 14:12:29', '2026-02-15 11:44:28', '2026-02-15 14:12:29'),
(69, 93, '2026-02-15 11:46:07', '2026-02-16 08:53:37', '2026-02-15 11:46:07', '2026-02-16 08:53:37'),
(70, 87, '2026-02-15 14:12:34', '2026-02-16 08:43:53', '2026-02-15 14:12:34', '2026-02-16 08:43:53'),
(71, 87, '2026-02-16 08:43:58', '2026-02-16 10:02:29', '2026-02-16 08:43:58', '2026-02-16 10:02:29'),
(72, 93, '2026-02-16 08:53:45', '2026-02-16 08:54:47', '2026-02-16 08:53:45', '2026-02-16 08:54:47'),
(73, 93, '2026-02-16 08:54:49', '2026-02-16 16:56:52', '2026-02-16 08:54:49', '2026-02-16 16:56:52'),
(74, 87, '2026-02-16 10:02:30', '2026-02-18 10:28:54', '2026-02-16 10:02:30', '2026-02-18 10:28:54'),
(75, 88, '2026-02-16 10:05:52', '2026-02-16 10:06:00', '2026-02-16 10:05:52', '2026-02-16 10:06:00'),
(76, 88, '2026-02-16 10:06:03', '2026-02-16 10:06:55', '2026-02-16 10:06:03', '2026-02-16 10:06:55'),
(77, 88, '2026-02-16 10:06:56', NULL, '2026-02-16 10:06:56', '2026-02-16 10:06:56'),
(78, 93, '2026-02-16 16:56:55', '2026-02-16 17:02:15', '2026-02-16 16:56:55', '2026-02-16 17:02:15'),
(79, 93, '2026-02-16 17:02:20', '2026-02-20 08:50:46', '2026-02-16 17:02:20', '2026-02-20 08:50:46'),
(80, 19, '2026-02-17 08:37:30', '2026-02-17 08:37:32', '2026-02-17 08:37:30', '2026-02-17 08:37:32'),
(81, 19, '2026-02-17 08:37:40', NULL, '2026-02-17 08:37:40', '2026-02-17 08:37:40'),
(82, 19, '2026-02-17 08:37:40', '2026-02-17 08:37:51', '2026-02-17 08:37:40', '2026-02-17 08:37:51'),
(83, 19, '2026-02-17 08:37:55', '2026-02-17 08:38:05', '2026-02-17 08:37:55', '2026-02-17 08:38:05'),
(84, 87, '2026-02-18 10:28:55', '2026-02-18 14:50:38', '2026-02-18 10:28:55', '2026-02-18 14:50:38'),
(85, 87, '2026-02-18 14:50:40', '2026-02-18 15:16:09', '2026-02-18 14:50:40', '2026-02-18 15:16:09'),
(86, 87, '2026-02-18 15:16:16', '2026-02-18 18:12:18', '2026-02-18 15:16:16', '2026-02-18 18:12:18'),
(87, 19, '2026-02-18 16:09:16', NULL, '2026-02-18 16:09:16', '2026-02-18 16:09:16'),
(88, 19, '2026-02-18 16:09:16', NULL, '2026-02-18 16:09:16', '2026-02-18 16:09:16'),
(89, 87, '2026-02-18 18:12:27', '2026-02-18 18:51:05', '2026-02-18 18:12:27', '2026-02-18 18:51:05'),
(90, 87, '2026-02-18 18:51:06', '2026-02-19 21:49:06', '2026-02-18 18:51:06', '2026-02-19 21:49:06'),
(91, 19, '2026-02-19 09:44:58', '2026-02-19 10:17:55', '2026-02-19 09:44:58', '2026-02-19 10:17:55'),
(92, 19, '2026-02-19 10:18:06', '2026-02-19 10:22:41', '2026-02-19 10:18:06', '2026-02-19 10:22:41'),
(93, 19, '2026-02-19 10:22:52', NULL, '2026-02-19 10:22:52', '2026-02-19 10:22:52'),
(94, 19, '2026-02-19 10:22:52', '2026-02-19 10:30:20', '2026-02-19 10:22:52', '2026-02-19 10:30:20'),
(95, 19, '2026-02-19 10:31:42', '2026-02-19 10:32:44', '2026-02-19 10:31:42', '2026-02-19 10:32:44'),
(96, 19, '2026-02-19 10:52:53', '2026-02-19 11:14:56', '2026-02-19 10:52:53', '2026-02-19 11:14:56'),
(97, 19, '2026-02-19 11:15:07', NULL, '2026-02-19 11:15:07', '2026-02-19 11:15:07'),
(98, 19, '2026-02-19 11:15:07', '2026-02-19 11:55:17', '2026-02-19 11:15:07', '2026-02-19 11:55:17'),
(99, 19, '2026-02-19 11:55:27', '2026-02-19 12:34:14', '2026-02-19 11:55:27', '2026-02-19 12:34:14'),
(100, 93, '2026-02-20 08:50:47', '2026-02-20 09:00:42', '2026-02-20 08:50:47', '2026-02-20 09:00:42'),
(101, 93, '2026-02-20 09:00:43', '2026-02-20 09:01:41', '2026-02-20 09:00:43', '2026-02-20 09:01:41'),
(102, 93, '2026-02-20 09:01:42', NULL, '2026-02-20 09:01:42', '2026-02-20 09:01:42'),
(103, 87, '2026-02-20 09:03:05', '2026-02-20 09:03:08', '2026-02-20 09:03:05', '2026-02-20 09:03:08'),
(104, 87, '2026-02-20 10:53:19', '2026-02-20 10:58:07', '2026-02-20 10:53:19', '2026-02-20 10:58:07'),
(105, 87, '2026-02-20 10:58:08', '2026-02-20 21:16:46', '2026-02-20 10:58:08', '2026-02-20 21:16:46'),
(106, 19, '2026-02-20 15:08:04', '2026-02-20 15:08:16', '2026-02-20 15:08:04', '2026-02-20 15:08:16'),
(107, 19, '2026-02-20 15:11:40', '2026-02-20 15:11:58', '2026-02-20 15:11:40', '2026-02-20 15:11:58'),
(108, 19, '2026-02-20 15:20:58', '2026-02-20 15:22:17', '2026-02-20 15:20:58', '2026-02-20 15:22:17'),
(109, 98, '2026-02-20 17:57:19', '2026-02-20 17:57:24', '2026-02-20 17:57:19', '2026-02-20 17:57:24'),
(110, 98, '2026-02-20 17:57:27', '2026-02-21 09:20:25', '2026-02-20 17:57:27', '2026-02-21 09:20:25'),
(111, 87, '2026-02-20 21:16:48', '2026-02-21 15:38:15', '2026-02-20 21:16:48', '2026-02-21 15:38:15'),
(112, 98, '2026-02-21 09:20:39', '2026-02-21 09:20:47', '2026-02-21 09:20:39', '2026-02-21 09:20:47'),
(113, 98, '2026-02-21 09:20:55', '2026-02-21 09:23:32', '2026-02-21 09:20:55', '2026-02-21 09:23:32'),
(114, 98, '2026-02-21 09:23:35', '2026-02-21 09:23:40', '2026-02-21 09:23:35', '2026-02-21 09:23:40'),
(115, 98, '2026-02-21 09:24:46', '2026-02-21 09:24:49', '2026-02-21 09:24:46', '2026-02-21 09:24:49'),
(116, 98, '2026-02-21 09:25:10', '2026-02-21 09:25:13', '2026-02-21 09:25:10', '2026-02-21 09:25:13'),
(117, 98, '2026-02-21 09:27:03', '2026-02-21 09:34:26', '2026-02-21 09:27:03', '2026-02-21 09:34:26'),
(118, 98, '2026-02-21 09:35:08', '2026-02-21 09:35:10', '2026-02-21 09:35:08', '2026-02-21 09:35:10'),
(119, 98, '2026-02-21 09:36:39', '2026-02-21 09:36:54', '2026-02-21 09:36:39', '2026-02-21 09:36:54'),
(120, 98, '2026-02-21 09:37:52', '2026-02-21 09:39:53', '2026-02-21 09:37:52', '2026-02-21 09:39:53'),
(121, 98, '2026-02-21 09:41:50', '2026-02-21 09:42:00', '2026-02-21 09:41:50', '2026-02-21 09:42:00'),
(122, 98, '2026-02-21 09:42:19', '2026-02-21 09:43:10', '2026-02-21 09:42:19', '2026-02-21 09:43:10'),
(123, 87, '2026-02-21 15:38:19', '2026-02-21 15:39:54', '2026-02-21 15:38:19', '2026-02-21 15:39:54'),
(124, 87, '2026-02-21 15:41:29', '2026-02-21 17:23:12', '2026-02-21 15:41:29', '2026-02-21 17:23:12'),
(125, 87, '2026-02-21 17:23:19', '2026-02-21 17:24:27', '2026-02-21 17:23:19', '2026-02-21 17:24:27'),
(126, 87, '2026-02-21 17:24:30', '2026-02-21 17:33:42', '2026-02-21 17:24:30', '2026-02-21 17:33:42'),
(127, 87, '2026-02-21 17:33:47', '2026-02-21 17:36:47', '2026-02-21 17:33:47', '2026-02-21 17:36:47'),
(128, 87, '2026-02-21 17:36:49', '2026-02-21 17:49:49', '2026-02-21 17:36:49', '2026-02-21 17:49:49'),
(129, 19, '2026-02-21 17:47:57', '2026-02-23 10:35:39', '2026-02-21 17:47:57', '2026-02-23 10:35:39'),
(130, 87, '2026-02-21 17:50:35', '2026-02-21 18:01:57', '2026-02-21 17:50:35', '2026-02-21 18:01:57'),
(131, 19, '2026-02-23 10:51:41', '2026-02-23 10:51:57', '2026-02-23 10:51:41', '2026-02-23 10:51:57'),
(132, 87, '2026-02-24 09:53:56', '2026-02-24 09:53:56', '2026-02-24 09:53:56', '2026-02-24 09:53:56'),
(133, 87, '2026-02-24 09:53:59', NULL, '2026-02-24 09:53:59', '2026-02-24 09:53:59'),
(134, 101, '2026-02-24 14:34:30', '2026-02-26 23:37:35', '2026-02-24 14:34:30', '2026-02-26 23:37:35'),
(135, 102, '2026-02-24 23:07:37', '2026-02-25 09:16:40', '2026-02-24 23:07:37', '2026-02-25 09:16:40'),
(136, 102, '2026-02-25 09:16:42', '2026-02-25 15:43:34', '2026-02-25 09:16:42', '2026-02-25 15:43:34'),
(137, 102, '2026-02-25 16:23:45', '2026-02-25 16:40:19', '2026-02-25 16:23:45', '2026-02-25 16:40:19'),
(138, 102, '2026-02-25 16:46:42', '2026-02-25 16:47:40', '2026-02-25 16:46:42', '2026-02-25 16:47:40'),
(139, 102, '2026-02-25 20:30:26', '2026-02-27 11:43:59', '2026-02-25 20:30:26', '2026-02-27 11:43:59'),
(140, 104, '2026-02-26 21:28:21', '2026-02-26 21:28:28', '2026-02-26 21:28:21', '2026-02-26 21:28:28'),
(141, 104, '2026-02-26 21:28:39', '2026-03-05 14:14:54', '2026-02-26 21:28:39', '2026-03-05 14:14:54'),
(142, 101, '2026-02-26 23:37:40', '2026-02-27 16:30:17', '2026-02-26 23:37:40', '2026-02-27 16:30:17'),
(143, 102, '2026-02-27 11:44:01', '2026-02-27 11:44:12', '2026-02-27 11:44:01', '2026-02-27 11:44:12'),
(144, 102, '2026-02-27 11:44:47', '2026-02-27 12:57:55', '2026-02-27 11:44:47', '2026-02-27 12:57:55'),
(145, 102, '2026-02-27 13:00:15', '2026-02-27 13:24:23', '2026-02-27 13:00:15', '2026-02-27 13:24:23'),
(146, 102, '2026-02-27 13:26:11', '2026-02-27 13:27:08', '2026-02-27 13:26:11', '2026-02-27 13:27:08'),
(147, 102, '2026-02-27 13:27:11', '2026-02-27 13:35:30', '2026-02-27 13:27:11', '2026-02-27 13:35:30'),
(148, 102, '2026-02-27 13:35:32', '2026-02-27 13:36:48', '2026-02-27 13:35:32', '2026-02-27 13:36:48'),
(149, 102, '2026-02-27 13:36:51', '2026-02-27 13:38:21', '2026-02-27 13:36:51', '2026-02-27 13:38:21'),
(150, 101, '2026-02-27 16:30:26', '2026-03-12 17:38:30', '2026-02-27 16:30:26', '2026-03-12 17:38:30'),
(151, 102, '2026-02-28 14:59:59', '2026-02-28 15:00:06', '2026-02-28 14:59:59', '2026-02-28 15:00:06'),
(152, 102, '2026-02-28 15:00:09', '2026-02-28 17:08:55', '2026-02-28 15:00:09', '2026-02-28 17:08:55'),
(153, 102, '2026-02-28 17:09:15', '2026-03-02 12:08:36', '2026-02-28 17:09:15', '2026-03-02 12:08:36'),
(154, 102, '2026-03-05 13:19:01', '2026-03-05 13:19:28', '2026-03-05 13:19:01', '2026-03-05 13:19:28'),
(155, 102, '2026-03-05 14:00:34', '2026-03-05 14:01:15', '2026-03-05 14:00:34', '2026-03-05 14:01:15'),
(156, 102, '2026-03-05 14:01:29', '2026-03-05 14:25:38', '2026-03-05 14:01:29', '2026-03-05 14:25:38'),
(157, 102, '2026-03-05 14:25:50', '2026-03-05 14:33:27', '2026-03-05 14:25:50', '2026-03-05 14:33:27'),
(158, 104, '2026-03-05 14:34:58', NULL, '2026-03-05 14:34:58', '2026-03-05 14:34:58'),
(159, 102, '2026-03-05 14:40:51', '2026-03-05 14:50:40', '2026-03-05 14:40:51', '2026-03-05 14:50:40'),
(160, 102, '2026-03-05 14:50:44', '2026-03-05 17:00:56', '2026-03-05 14:50:44', '2026-03-05 17:00:56'),
(161, 102, '2026-03-05 17:00:58', '2026-03-05 17:05:12', '2026-03-05 17:00:58', '2026-03-05 17:05:12'),
(162, 102, '2026-03-05 17:05:15', '2026-03-05 19:57:34', '2026-03-05 17:05:15', '2026-03-05 19:57:34'),
(163, 102, '2026-03-05 19:59:09', '2026-03-06 11:12:43', '2026-03-05 19:59:09', '2026-03-06 11:12:43'),
(164, 102, '2026-03-06 11:36:12', '2026-03-06 16:55:03', '2026-03-06 11:36:12', '2026-03-06 16:55:03'),
(165, 102, '2026-03-06 20:05:48', '2026-03-07 09:05:22', '2026-03-06 20:05:48', '2026-03-07 09:05:22'),
(166, 102, '2026-03-07 09:05:24', '2026-03-07 16:15:34', '2026-03-07 09:05:24', '2026-03-07 16:15:34'),
(167, 102, '2026-03-07 16:15:58', NULL, '2026-03-07 16:15:58', '2026-03-07 16:15:58'),
(168, 102, '2026-03-07 16:15:58', '2026-03-08 18:34:20', '2026-03-07 16:15:58', '2026-03-08 18:34:20'),
(169, 102, '2026-03-08 18:34:25', '2026-03-08 20:21:17', '2026-03-08 18:34:25', '2026-03-08 20:21:17'),
(170, 102, '2026-03-08 20:21:19', '2026-03-08 20:21:45', '2026-03-08 20:21:19', '2026-03-08 20:21:45'),
(171, 102, '2026-03-09 11:14:07', '2026-03-09 14:17:07', '2026-03-09 11:14:07', '2026-03-09 14:17:07'),
(172, 102, '2026-03-09 14:17:10', '2026-03-09 14:37:13', '2026-03-09 14:17:10', '2026-03-09 14:37:13'),
(173, 102, '2026-03-09 14:37:15', '2026-03-09 17:02:15', '2026-03-09 14:37:15', '2026-03-09 17:02:15'),
(174, 102, '2026-03-09 19:22:39', '2026-03-10 09:27:19', '2026-03-09 19:22:39', '2026-03-10 09:27:19'),
(175, 102, '2026-03-10 09:27:22', '2026-03-11 10:37:17', '2026-03-10 09:27:22', '2026-03-11 10:37:17'),
(176, 102, '2026-03-11 10:37:20', '2026-03-12 09:29:48', '2026-03-11 10:37:20', '2026-03-12 09:29:48'),
(177, 102, '2026-03-12 09:29:51', '2026-03-12 09:30:05', '2026-03-12 09:29:51', '2026-03-12 09:30:05'),
(178, 102, '2026-03-12 09:30:52', '2026-03-12 12:09:52', '2026-03-12 09:30:52', '2026-03-12 12:09:52'),
(179, 102, '2026-03-12 12:09:56', '2026-03-12 12:10:22', '2026-03-12 12:09:56', '2026-03-12 12:10:22'),
(180, 102, '2026-03-12 12:11:26', '2026-03-12 12:12:42', '2026-03-12 12:11:26', '2026-03-12 12:12:42'),
(181, 102, '2026-03-12 12:12:46', '2026-03-12 17:01:53', '2026-03-12 12:12:46', '2026-03-12 17:01:53'),
(182, 102, '2026-03-12 17:01:56', '2026-03-12 22:15:15', '2026-03-12 17:01:56', '2026-03-12 22:15:15'),
(183, 101, '2026-03-12 17:38:32', NULL, '2026-03-12 17:38:32', '2026-03-12 17:38:32'),
(184, 102, '2026-03-12 22:15:18', '2026-03-13 11:31:14', '2026-03-12 22:15:18', '2026-03-13 11:31:14'),
(185, 102, '2026-03-13 11:31:26', '2026-03-13 11:33:01', '2026-03-13 11:31:26', '2026-03-13 11:33:01'),
(186, 102, '2026-03-13 11:35:55', '2026-03-13 11:43:48', '2026-03-13 11:35:55', '2026-03-13 11:43:48'),
(187, 102, '2026-03-13 11:43:50', '2026-03-13 11:44:50', '2026-03-13 11:43:50', '2026-03-13 11:44:50'),
(188, 102, '2026-03-13 11:45:23', NULL, '2026-03-13 11:45:23', '2026-03-13 11:45:23');

-- --------------------------------------------------------

--
-- Table structure for table `driver_registration`
--

CREATE TABLE `driver_registration` (
  `id` int(10) UNSIGNED NOT NULL,
  `wallet` double(10,2) NOT NULL DEFAULT '0.00',
  `due_wallet` double(10,2) NOT NULL DEFAULT '0.00',
  `personal_information_status` tinyint(1) DEFAULT '0' COMMENT '0 = Pending, 1 = Submitted, 2 = Approved, 3 = Rejected',
  `vehicle_info_status` tinyint(1) DEFAULT '0' COMMENT '0 = Pending, 1 = Submitted, 2 = Approved, 3 = Rejected',
  `driver_licence_status` tinyint(1) DEFAULT '0' COMMENT '0 = Pending, 1 = Submitted, 2 = Approved, 3 = Rejected',
  `aadhaar_pan_status` tinyint(1) DEFAULT '0' COMMENT '0 = Pending, 1 = Submitted, 2 = Approved, 3 = Rejected',
  `required_certificates_status` tinyint(1) DEFAULT '0' COMMENT '0 = Pending, 1 = Submitted, 2 = Approved, 3 = Rejected',
  `vehicle_documents_status` tinyint(1) DEFAULT '0' COMMENT '0 = Pending, 1 = Submitted, 2 = Approved, 3 = Rejected',
  `platform_type` tinyint(1) DEFAULT NULL,
  `vehicle_name` varchar(100) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `profile_photo` varchar(255) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `date_of_birth` varchar(50) DEFAULT NULL,
  `personal_information_reject_reason` text,
  `driver_licence_reject_reason` text,
  `driver_licence_front` varchar(255) DEFAULT NULL,
  `driver_licence_back` varchar(255) DEFAULT NULL,
  `driver_licence_number` varchar(50) DEFAULT NULL,
  `licence_validity_date` date DEFAULT NULL,
  `aadhaar_pan_reject_reason` text,
  `aadhaar_front` varchar(255) DEFAULT NULL,
  `aadhaar_back` varchar(255) DEFAULT NULL,
  `aadhaar_number` varchar(20) DEFAULT NULL,
  `pan_card_front` varchar(255) DEFAULT NULL,
  `pan_card_back` varchar(255) DEFAULT NULL,
  `pan_card_number` varchar(20) DEFAULT NULL,
  `required_certificates_reject_reason` text,
  `fitness_certificate` varchar(255) DEFAULT NULL,
  `pollution_certificate` varchar(255) DEFAULT NULL,
  `insurance_certificate` varchar(255) DEFAULT NULL,
  `police_certificate` varchar(255) DEFAULT NULL,
  `vehicle_info_reject_reason` text,
  `vehicle_photo` varchar(255) DEFAULT NULL,
  `vehicle_color` varchar(50) DEFAULT NULL,
  `vehicle_plate_number` varchar(50) DEFAULT NULL,
  `vehicle_documents_reject_reason` text,
  `vehicle_permit_part_a` varchar(255) DEFAULT NULL,
  `vehicle_permit_part_b` varchar(255) DEFAULT NULL,
  `vehicle_registration_front` varchar(255) DEFAULT NULL,
  `vehicle_registration_back` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `device_id` varchar(100) NOT NULL,
  `fcm_token` longtext NOT NULL,
  `online_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1 online \r\n0 offline',
  `login_status_inactive_reasion` varchar(255) DEFAULT NULL,
  `login_status` tinyint(4) NOT NULL DEFAULT '1',
  `current_latitude` varchar(100) DEFAULT NULL,
  `current_longitude` varchar(100) DEFAULT NULL,
  `vehicle_type` varchar(50) DEFAULT NULL,
  `vehicle_category` tinyint(1) DEFAULT NULL COMMENT '2=Two Wheeler, 3=Three Wheeler, 4=Four Wheeler',
  `model_id` tinyint(4) DEFAULT NULL,
  `brand_id` tinyint(4) DEFAULT NULL,
  `model_name` varchar(100) DEFAULT NULL,
  `brand_name` varchar(100) DEFAULT NULL,
  `vehicle_production_year` varchar(25) DEFAULT NULL,
  `rating` double DEFAULT '4.5',
  `email` varchar(100) NOT NULL DEFAULT 'cabuser@gmail.com',
  `rating_count` int(11) NOT NULL DEFAULT '0',
  `rating_sum` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `driver_registration`
--

INSERT INTO `driver_registration` (`id`, `wallet`, `due_wallet`, `personal_information_status`, `vehicle_info_status`, `driver_licence_status`, `aadhaar_pan_status`, `required_certificates_status`, `vehicle_documents_status`, `platform_type`, `vehicle_name`, `mobile`, `profile_photo`, `first_name`, `last_name`, `date_of_birth`, `personal_information_reject_reason`, `driver_licence_reject_reason`, `driver_licence_front`, `driver_licence_back`, `driver_licence_number`, `licence_validity_date`, `aadhaar_pan_reject_reason`, `aadhaar_front`, `aadhaar_back`, `aadhaar_number`, `pan_card_front`, `pan_card_back`, `pan_card_number`, `required_certificates_reject_reason`, `fitness_certificate`, `pollution_certificate`, `insurance_certificate`, `police_certificate`, `vehicle_info_reject_reason`, `vehicle_photo`, `vehicle_color`, `vehicle_plate_number`, `vehicle_documents_reject_reason`, `vehicle_permit_part_a`, `vehicle_permit_part_b`, `vehicle_registration_front`, `vehicle_registration_back`, `created_at`, `updated_at`, `device_id`, `fcm_token`, `online_status`, `login_status_inactive_reasion`, `login_status`, `current_latitude`, `current_longitude`, `vehicle_type`, `vehicle_category`, `model_id`, `brand_id`, `model_name`, `brand_name`, `vehicle_production_year`, `rating`, `email`, `rating_count`, `rating_sum`) VALUES
(1, 0.00, 4000.00, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, '9876543210', 'DriverDocuments/1766217684864.png', 'ramu sharma', 'aaaaaaaaa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-20 08:01:25', '2026-01-23 19:35:29', 'ABC123XYZ', 'token123', 0, NULL, 0, '26.9479308', '80.9390122', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(2, 200.00, 0.00, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '8956562326', 'DriverDocuments/1766219167852.jpg', 'dhdgdh', 'bfbfhfh', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-20 08:26:08', '2026-03-12 03:42:26', 'kmjnhbg', 'kjhgjnh', 0, NULL, 1, '28.6139', '77.2090', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(3, 470.00, 0.00, 3, NULL, 1, 1, 1, NULL, NULL, NULL, '5986532256', 'DriverDocuments/1766222586331.jpg', 'sbshsush', 'dbdhsh', NULL, 'easrtghj', NULL, 'DriverDocuments/1766223181469.jpg', 'DriverDocuments/1766223181577.jpg', 'vjvkviivk', '2025-12-26', NULL, 'DriverDocuments/1766223216777.jpg', 'DriverDocuments/1766223216877.jpg', 'hfhdhfh', 'DriverDocuments/1766223216977.jpg', 'DriverDocuments/1766223217065.jpg', 'hfhfhf', NULL, 'DriverDocuments/1766223341703.jpg', 'DriverDocuments/1766223341918.jpg', 'DriverDocuments/1766223342012.jpg', 'DriverDocuments/1766223342018.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-20 09:23:06', '2026-02-06 12:02:23', 'kmjnhbg', 'kjhgjnh', 0, NULL, 1, '28.6139', '77.2090', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(4, 0.00, 0.00, 2, 2, 2, 2, 2, 3, NULL, NULL, '8864546232', 'DriverDocuments/1766223428775.jpg', 'hdhd', 'dgdgd', NULL, NULL, NULL, 'DriverDocuments/1766223450527.jpg', 'DriverDocuments/1766223450647.jpg', 'hhuuh', '2025-12-26', NULL, 'DriverDocuments/1766223474325.jpg', 'DriverDocuments/1766223474418.jpg', 'bhhuh', 'DriverDocuments/1766223474511.jpg', 'DriverDocuments/1766223474516.jpg', 'bhhu', NULL, 'DriverDocuments/1766223495972.jpg', 'DriverDocuments/1766223496067.jpg', 'DriverDocuments/1766223496163.jpg', 'DriverDocuments/1766223496221.jpg', NULL, NULL, NULL, NULL, 'vehicle document status reject', NULL, NULL, NULL, NULL, '2025-12-20 09:37:08', '2025-12-27 11:14:18', 'kmjnhbg', 'kjhgjnh', 0, NULL, 1, '26.9435287', '80.9405264', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(5, 0.00, 0.00, 2, 1, 2, 1, 1, 1, 2, NULL, '5656565656', 'DriverDocuments/1766223739400.jpg', 'gussa', 'aa rha hai ', NULL, NULL, NULL, 'DriverDocuments/1766223752569.jpg', 'DriverDocuments/1766223752677.jpg', 'dhdudh', '2025-12-27', NULL, 'DriverDocuments/1766223779881.jpg', 'DriverDocuments/1766223779978.jpg', 'bzjssh', 'DriverDocuments/1766223780069.jpg', 'DriverDocuments/1766223780077.jpg', 'upsbhsh', NULL, 'DriverDocuments/1766223795889.jpg', 'DriverDocuments/1766223795990.jpg', 'DriverDocuments/1766223796088.jpg', 'DriverDocuments/1766223796175.jpg', NULL, 'DriverDocuments/1766224394130.jpg', 'Bronze', 'bfbdbd', NULL, 'DriverDocuments/1766224434425.jpg', 'DriverDocuments/1766224434527.jpg', 'DriverDocuments/1766224434626.jpg', 'DriverDocuments/1766224434724.jpg', '2025-12-20 09:42:19', '2025-12-20 12:36:54', 'RP1A.200720.011', 'e-zsq6KyS9KoyigjnH6cFl:APA91bESbKeD_J-luQzMvWQ39-bS4qQAH1hh8KCJdr1mYqEuNdX4LY_RD9QYm25ZStcQ1ykRVH9_M2wvpRzOuJmmfOGltHFc736WGtGQZ5qdbwdTnUBtbO0', 0, NULL, 1, '26.9433457', '80.940395', NULL, NULL, 6, 3, 'HF Deluxe', 'Maruti', NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(12, 0.00, 0.00, 2, 2, 2, 2, 2, 2, 2, 'abc', '7235947666', 'DriverDocuments/1766376185037.png', 'ramu sharma', 'aaaaaaaaa', '2001-08-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-22 04:03:05', '2026-01-06 05:23:17', 'fvgbhnj', 'd1uVSDquQKCh6RhAb66BlV:APA91bEn0inBi4IFGG15w2-6-ZGgdcALmuzPJ49oDcgLJNFADMjsmBayJa5pRsQtDlVpzIjIcCP_hi3V57BuQ9S2NqMNxxqiJXp6GtvMyMYA8agkmt2FiWY', 0, NULL, 1, '28.6139', '77.2090', '2', NULL, 3, 2, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(18, 0.00, 0.00, 2, 2, 2, 2, 2, 2, 2, 'Black Car', '6333222552', 'DriverDocuments/1766576896221.jpg', 'Rohit ', 'kumar', '2000-01-22', NULL, NULL, 'DriverDocuments/1766576916117.jpg', 'DriverDocuments/1766576916583.jpg', 'jhuihu', '2025-12-25', NULL, 'DriverDocuments/1766576941812.jpg', 'DriverDocuments/1766576942303.jpg', 'hhuu', 'DriverDocuments/1766576942740.jpg', 'DriverDocuments/1766576943038.jpg', 'hjiu', NULL, 'DriverDocuments/1766576966422.jpg', 'DriverDocuments/1766576967027.jpg', 'DriverDocuments/1766576967161.jpg', 'DriverDocuments/1766576967426.jpg', NULL, 'DriverDocuments/1766576987633.jpg', 'Bronze', 'vbhuh', NULL, 'DriverDocuments/1766577014905.jpg', 'DriverDocuments/1766577015419.jpg', 'DriverDocuments/1766577015844.jpg', 'DriverDocuments/1766577016114.jpg', '2025-12-24 11:48:16', '2026-01-05 16:33:55', 'fvgbhnj', 'cEDPol0xQLyCDWhzxv27uu:APA91bGo_2Ka7p0mptSujTpQ3clhrn87sBGOF-4OLUZiJm9X4BMyr962-gfiTczs1-pivwbuV680Zw6zaALLqP7-3aC8quA65-vukwnDkjkYADYYg3rFzcE', 0, NULL, 1, '26.9476236', '80.9387408', '3', NULL, 2, 1, 'i10', 'Hyundai', '2020', 4.5, 'cabuser@gmail.com', 0, 0),
(20, 546.78, 3000.00, 2, 2, 2, 2, 2, 2, 2, 'Black Car', '1111111111', 'DriverDocuments/1766576896221.jpg', 'wao', 'ki', '2000-01-22', NULL, NULL, 'DriverDocuments/1766576916117.jpg', 'DriverDocuments/1766576916583.jpg', 'jhuihu', '2025-12-25', NULL, 'DriverDocuments/1766576941812.jpg', 'DriverDocuments/1766576942303.jpg', 'hhuu', 'DriverDocuments/1766576942740.jpg', 'DriverDocuments/1766576943038.jpg', 'hjiu', NULL, 'DriverDocuments/1766576966422.jpg', 'DriverDocuments/1766576967027.jpg', 'DriverDocuments/1766576967161.jpg', 'DriverDocuments/1766576967426.jpg', NULL, 'DriverDocuments/1766576987633.jpg', 'Bronze', 'vbhuh', NULL, 'DriverDocuments/1766577014905.jpg', 'DriverDocuments/1766577015419.jpg', 'DriverDocuments/1766577015844.jpg', 'DriverDocuments/1766577016114.jpg', '2025-12-24 11:48:16', '2026-01-10 07:38:50', 'fvgbhnj', 'c0WwPmxESFmXhUJSy5GH3i:APA91bFYVW2orZ_dALjbaaRYGvSYQ9ZHaE-AL9be7Thc2Fr4b8J4A5-NDJhhPoGCTFNBlcHCHOSYm6lkcAFjQCd5RWhqgwNlSCDLSilZ9AzWDw4rAwxvEks', 0, NULL, 1, '26.9434758', '80.9405371', '3', NULL, 2, 1, 'i10', 'Hyundai', '2020', 5, 'cabuser@gmail.com', 46, 10),
(59, 0.00, 0.00, 2, 2, 2, 2, 2, 2, 2, 'Car', '9856325641', 'DriverDocuments/1767694239880.jpg', 'Kumar', 'dog', '2000-01-14', NULL, NULL, 'DriverDocuments/1767694840895.jpg', 'DriverDocuments/1767694841352.jpg', 'gjfjrhfh', '2022-01-06', NULL, 'DriverDocuments/1767695719404.jpg', 'DriverDocuments/1767695720281.jpg', '989894545121', 'DriverDocuments/1767695720836.jpg', 'DriverDocuments/1767695721856.jpg', 'XDDDD33636', NULL, 'DriverDocuments/1767695833514.jpg', 'DriverDocuments/1767695833822.jpg', 'DriverDocuments/1767695834201.jpg', 'DriverDocuments/1767695834521.jpg', NULL, 'DriverDocuments/1767696399567.jpg', 'Beige', 'GF08QW1234', NULL, 'DriverDocuments/1767696680051.jpg', 'DriverDocuments/1767696680412.pdf', 'DriverDocuments/1767696683607.jpg', NULL, '2026-01-06 10:10:40', '2026-01-06 10:54:39', 'edfrgtyujy', 'dqefwtrhy', 0, NULL, 1, '28.6139', '77.2090', '2', NULL, 6, 3, 'WagonR', 'Maruti Suzuki', '2025', 4.5, 'cabuser@gmail.com', 0, 0),
(67, 0.00, 0.00, 1, 0, 0, 0, 0, 0, 2, 'Bike', '9632584946', 'DriverDocuments/1768215136010.jpg', 'Aryan ', 'lalala', '2000-01-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-12 10:52:16', NULL, 'edfrgtyujy', 'dqefwtrhy', 0, NULL, 1, NULL, NULL, '3', NULL, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(68, 0.00, 0.00, 1, 0, 0, 0, 0, 0, 2, 'Bike', '9632584946', 'DriverDocuments/1768215197856.jpg', 'Aryan ', 'lalala', '2000-01-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-12 10:53:18', NULL, 'edfrgtyujy', 'dqefwtrhy', 0, NULL, 1, NULL, NULL, '3', NULL, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(70, 0.00, 0.00, 1, 0, 0, 0, 0, 0, 2, 'Bike', '9633589494', 'DriverDocuments/1768215314257.jpg', 'dbdjsh', 'dbdjdj', '2000-01-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-12 10:55:14', '2026-01-12 11:11:44', 'edfrgtyujy', 'dqefwtrhy', 0, NULL, 1, '26.9434821', '80.9405241', '3', NULL, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(73, 0.00, 0.00, 1, 0, 1, 1, 1, 0, 2, 'Bike', '9793168164', 'DriverDocuments/1768216010821.jpg', 'Aryan', 'Lala', '2000-01-08', NULL, NULL, 'DriverDocuments/1768216071972.jpg', 'DriverDocuments/1768216072375.jpg', 'ehsuhdheyedgvzhs', '2026-01-12', NULL, 'DriverDocuments/1768216113457.jpg', 'DriverDocuments/1768216114775.jpg', '545519596431', 'DriverDocuments/1768216115844.jpg', 'DriverDocuments/1768216116039.jpg', 'DHYDUSHSBS', NULL, 'DriverDocuments/1768216197913.jpg', 'DriverDocuments/1768216199390.jpg', 'DriverDocuments/1768216200705.jpg', 'DriverDocuments/1768216200856.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-12 11:06:50', '2026-01-12 11:14:36', 'edfrgtyujy', 'dqefwtrhy', 0, NULL, 1, '26.9434823', '80.9405388', '3', NULL, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(74, 0.00, 0.00, 1, 0, 1, 1, 1, 0, 2, 'Bike', '9855663256', 'DriverDocuments/1768216525146.jpg', 'vg', 'vh', '2000-01-14', NULL, NULL, 'DriverDocuments/1768216540253.jpg', 'DriverDocuments/1768216540253.jpg', 'vhhhhh', '2026-01-12', NULL, 'DriverDocuments/1768216566284.jpg', 'DriverDocuments/1768216566284.jpg', '996658996328', 'DriverDocuments/1768216566412.jpg', 'DriverDocuments/1768216566450.jpg', 'VHHGVHUUGB', NULL, 'DriverDocuments/1768216585740.jpg', 'DriverDocuments/1768216585755.jpg', 'DriverDocuments/1768216585807.jpg', 'DriverDocuments/1768216585853.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-12 11:15:25', '2026-01-12 11:16:26', 'edfrgtyujy', 'dqefwtrhy', 0, NULL, 1, '26.9434962', '80.9405396', '3', NULL, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(75, 0.00, 0.00, 3, 3, 3, 3, 3, 3, 2, 'Bike', '6666666589', 'DriverDocuments/1768217207731.jpg', 'new', 'newa', '2000-01-01', 'fir se upload kre', NULL, 'DriverDocuments/1768217231635.jpg', 'DriverDocuments/1768217231760.jpg', 'dhdhdhs', '2026-01-29', NULL, 'DriverDocuments/1768217268081.jpg', 'DriverDocuments/1768217268193.jpg', '956962386454', 'DriverDocuments/1768217268543.jpg', 'DriverDocuments/1768217268596.jpg', 'SHSHHS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-12 11:26:49', '2026-01-12 11:33:13', 'fvgbhnj', 'dwGr5ERfQjupaw6vVsD4uh:APA91bHir1WTK2RDZTJuP7uEMBPE1pw7lk7BaCjcVmSAhED9tN2KtO3oyl39WP53NdEV7OdkXQqU6YpJ_MW2aZmQVtTa47ryVaHc68igdHPPzxeyPnOdL-8', 0, NULL, 1, '26.94348', '80.9405314', '3', NULL, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(76, 0.00, 0.00, 1, 1, 1, 1, 1, 1, 2, 'Car', '9044704604', 'DriverDocuments/1768303480649.heif', 'Bharat ', 'Kumar ', '1992-07-08', NULL, NULL, 'DriverDocuments/1768303569452.jpg', 'DriverDocuments/1768303571760.jpg', 'UP4320220009854', '2032-01-13', NULL, 'DriverDocuments/1768303658426.jpg', 'DriverDocuments/1768303658633.jpg', '211736024554', 'DriverDocuments/1768303658833.jpg', 'DriverDocuments/1768303659009.jpg', 'CIPK5294P', NULL, 'DriverDocuments/1768303754722.jpg', 'DriverDocuments/1768303756979.jpg', 'DriverDocuments/1768303759264.jpg', 'DriverDocuments/1768303761754.jpg', NULL, 'DriverDocuments/1768303826368.jpg', 'Beige', 'UP43AX7818', NULL, 'DriverDocuments/1768303913112.jpg', 'DriverDocuments/1768303915895.jpg', 'DriverDocuments/1768303918675.jpg', 'DriverDocuments/1768303921305.jpg', '2026-01-13 11:24:41', '2026-01-16 08:26:01', 'edfrgtyujy', 'dqefwtrhy', 0, NULL, 1, '26.7998725', '82.2208159', '2', NULL, 6, 3, 'WagonR', 'Maruti Suzuki', '2026', 4.5, 'cabuser@gmail.com', 0, 0),
(77, 185.00, 12.95, 2, 2, 2, 2, 2, 2, 2, 'Bike', '9895542454', 'DriverDocuments/1768629251684.jpg', 'gullu', 'pandey', '2000-01-01', NULL, NULL, 'DriverDocuments/1768629283413.jpg', 'DriverDocuments/1768629283586.jpg', 'bhhuyh', '2026-01-17', NULL, 'DriverDocuments/1768629326120.jpg', 'DriverDocuments/1768629326337.jpg', '966985214785', 'DriverDocuments/1768629326487.jpg', 'DriverDocuments/1768629326547.jpg', 'BHHGFRSRTG', NULL, 'DriverDocuments/1768629355479.jpg', 'DriverDocuments/1768629355521.jpg', 'DriverDocuments/1768629355658.jpg', 'DriverDocuments/1768629355658.jpg', NULL, 'DriverDocuments/1768630157779.jpg', 'Bronze', 'UP04AS1234', NULL, 'DriverDocuments/1768630183021.jpg', 'DriverDocuments/1768630183163.jpg', 'DriverDocuments/1768630183522.jpg', NULL, '2026-01-17 05:54:11', '2026-01-20 04:46:37', 'edfrgtyujy', 'dqefwtrhy', 0, NULL, 1, '26.9435185', '80.9405498', '3', NULL, 12, 6, 'Platina', 'Bajaj', '2020', 4.5, 'cabuser@gmail.com', 0, 0),
(79, 0.00, 0.00, 1, 1, 1, 1, 1, 0, 2, 'Bike', '9895656465', 'DriverDocuments/1768979025076.jpg', 'kunsh', 'fhdhd', '2000-01-01', NULL, NULL, 'DriverDocuments/1768979097028.jpg', 'DriverDocuments/1768979097166.jpg', 'bffhd', '2026-01-21', NULL, 'DriverDocuments/1768979180987.jpg', 'DriverDocuments/1768979181144.jpg', '845445454659', 'DriverDocuments/1768979181193.jpg', 'DriverDocuments/1768979181238.jpg', 'DHDDDHDEEV', NULL, 'DriverDocuments/1768979282679.jpg', 'DriverDocuments/1768979282804.jpg', 'DriverDocuments/1768979282959.jpg', 'DriverDocuments/1768979283021.jpg', NULL, 'DriverDocuments/1768979377852.jpg', 'Black', 'AS09AS1234', NULL, NULL, NULL, NULL, NULL, '2026-01-21 07:03:45', '2026-01-21 07:09:41', 'edfrgtyujy', 'e7pFnQnoRL-8syy9tPXfRz:APA91bGcjR2FZ9R9zAHWwrPszfJqESQfCuFGaJ3_NddDaoh334ixzurBaD2TSXlCUuoIWr_8uCTdmWZaE1b4ar1cpjI1ZQWOvhbu5qD5iJhZTHArvp9OjKw', 0, NULL, 1, '26.9434979', '80.9405477', '3', NULL, 12, 6, 'Platina', 'Bajaj', '2023', 4.5, 'cabuser@gmail.com', 0, 0),
(80, 0.00, 0.00, 1, 0, 0, 1, 1, 0, 2, 'abc', '8888887777', 'DriverDocuments/1768990735568.png', 'ramu sharma', 'aaaaaaaaa', '2001-08-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'DriverDocuments/1769171796246.jpeg', 'DriverDocuments/1769171796370.png', '496137593369', 'DriverDocuments/1769171796430.png', NULL, '121hagshs', NULL, 'DriverDocuments/1769171869056.png', 'DriverDocuments/1769171883107.png', 'DriverDocuments/1769171883341.png', 'DriverDocuments/1769171883410.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-21 10:18:55', '2026-01-23 12:38:03', 'sdzfxcghjklhgfxchjk', 'szdxfghjkhgcfxd', 0, NULL, 1, '28.6139', '77.2090', '1', 3, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(81, 0.00, 0.00, 1, 1, 1, 1, 1, 1, 2, 'Car', '5655655989', 'DriverDocuments/1768995810616.jpg', 'huhu', 'jiii', '2000-01-07', NULL, NULL, 'DriverDocuments/1768995854039.jpg', 'DriverDocuments/1768995854168.jpg', 'bfhdhdhddh', '2026-01-23', NULL, 'DriverDocuments/1768995879576.jpg', 'DriverDocuments/1768995879715.jpg', '655444215989', 'DriverDocuments/1768995879767.jpg', 'DriverDocuments/1768995879820.jpg', 'DHDDDHSHSH', NULL, 'DriverDocuments/1768995967383.jpg', 'DriverDocuments/1768995967521.jpg', 'DriverDocuments/1768995967572.jpg', 'DriverDocuments/1768995967616.jpg', NULL, 'DriverDocuments/1768995993160.jpg', 'Bronze', 'DH12GS1234', NULL, 'DriverDocuments/1768996011979.jpg', 'DriverDocuments/1768996012129.jpg', 'DriverDocuments/1768996012183.jpg', NULL, '2026-01-21 11:43:30', '2026-01-21 11:47:07', 'edfrgtyujy', 'eTSDd_5PQjyvC6h0NgfF5s:APA91bFb6hHRC2Arm48CqYpjbu2cQWCTfZL6OmzMi30nopt4eKrVpOh9nB7JlVabtUZHRt9EPpuzhvy5kn4XNQ9omq1_MmeFT_UgzgQKKjxk5TGbZGTE_8s', 0, NULL, 1, '26.9435052', '80.9405786', '2', 4, 6, 3, 'WagonR', 'Maruti Suzuki', '2020', 4.5, 'cabuser@gmail.com', 0, 0),
(82, 0.00, 0.00, 1, 1, 1, 1, 1, 0, 2, 'Bike', '6652232265', 'DriverDocuments/1768996380300.jpg', 'tinku', 'jiaa', '2000-01-13', NULL, NULL, 'DriverDocuments/1768996404026.jpg', 'DriverDocuments/1768996404157.jpg', 'bhyvghytgk', '2026-01-22', NULL, 'DriverDocuments/1768996439865.jpg', 'DriverDocuments/1768996439994.jpg', '939282841829', 'DriverDocuments/1768996440053.jpg', 'DriverDocuments/1768996440102.jpg', 'BUBUBYVYVT', NULL, 'DriverDocuments/1768996602599.jpg', 'DriverDocuments/1768996602723.jpg', 'DriverDocuments/1768996602770.jpg', NULL, NULL, 'DriverDocuments/1768996635257.jpg', 'Bronze', 'NB12SD1234', NULL, NULL, NULL, NULL, NULL, '2026-01-21 11:53:00', '2026-01-21 11:57:18', 'edfrgtyujy', 'eMQTI08XQ5e5wI80zdjPY-:APA91bFaIObvWaZPP-WAdYy881_y0oYGXGFqBxCk7eIZgDb0BkUv586Fd8p4Y8BhOTVyhH223GHMRTL_ynOxLcTlOZ3C9CBVYmyQQvcGVl7kDYRIE9AkBkY', 0, NULL, 1, '26.943497', '80.940539', '3', 2, 12, 6, 'Platina', 'Bajaj', '2020', 4.5, 'cabuser@gmail.com', 0, 0),
(84, 81.00, 0.00, 2, 2, 2, 2, 1, 2, 2, 'Auto', '7458946942', 'DriverDocuments/1769142856196.jpg', 'Harsh ', 'singh', '1997-04-11', NULL, NULL, 'DriverDocuments/1769143005054.jpg', 'DriverDocuments/1769143005336.jpg', 'up633844848484848484', '2030-02-23', NULL, 'DriverDocuments/1769143151192.jpg', 'DriverDocuments/1769143151611.jpg', '646465646464', 'DriverDocuments/1769143151861.jpg', 'DriverDocuments/1769143152210.jpg', 'HGMPS6411L', NULL, 'DriverDocuments/1769149601457.png', 'DriverDocuments/1769149601609.png', 'DriverDocuments/1769149601705.png', 'DriverDocuments/1769149601811.png', NULL, 'DriverDocuments/1769143422043.jpg', 'Orange', 'UP63JA7268', NULL, 'DriverDocuments/1769143533088.jpg', 'DriverDocuments/1769143533621.jpg', 'DriverDocuments/1769143533967.jpg', NULL, '2026-01-23 04:34:16', '2026-01-23 06:26:42', 'edfrgtyujy', 'dgwbzbyqSOO5xG_LCOIAbE:APA91bFSeTNMyuJJV071NRBXuk_6r42k-U6W6ZVczw0tp9clXu0Yms2Mau9R_v56qNWSTwzMDdOZIJaN8FxlIPVQiz5RLDssuPJMDZeBknKP_o3c93H737E', 0, NULL, 1, '26.9434998', '80.9405488', '1', 3, 1, 1, 'RE Compact', 'Bajaj Auto', '2025', 4.5, 'cabuser@gmail.com', 0, 0),
(85, 0.00, 0.00, 1, 0, 0, 0, 0, 0, 2, 'Car', '6532256535', 'DriverDocuments/1769150018483.jpg', 'hfhfhf', 'vn cn', '2000-01-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-23 06:33:38', '2026-01-23 07:06:59', 'edfrgtyujy', 'csNv_-riT7iXbPZza5y8nX:APA91bFe4IWmgT9mOk1-gCdHx-k_DHJPuwq4T_9yj20CjCZM769fRL7uHZxJFiFEcQFWXDFjVox0W9EIjzULBBxRby0Q6_pUqN38f38UVFNJcMZKaRbbTgU', 0, NULL, 1, '26.9435389', '80.9405651', '2', 4, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(86, 0.00, 0.00, 1, 1, 1, 1, 1, 0, 2, 'Bike', '7570006440', 'DriverDocuments/1769151606883.png', 'Vishal ', 'Mishra ', '2000-01-08', NULL, NULL, 'DriverDocuments/1769151624032.png', 'DriverDocuments/1769151624910.png', 'gdhhdjd', '2026-01-24', NULL, 'DriverDocuments/1769151657158.png', 'DriverDocuments/1769151657551.png', '565656989494', 'DriverDocuments/1769151657701.png', 'DriverDocuments/1769151657856.png', 'HDHDJDJD', NULL, 'DriverDocuments/1769151683802.pdf', 'DriverDocuments/1769151684490.pdf', 'DriverDocuments/1769151684640.pdf', NULL, NULL, 'DriverDocuments/1769151734521.png', 'Beige', 'UP57AB6432', NULL, NULL, NULL, NULL, NULL, '2026-01-23 07:00:07', '2026-01-23 07:02:32', 'edfrgtyujy', 'd9RWRN-LTeKoj7CCa-WrzS:APA91bE6aHJ-5Cr_gAWMiR-9p_pIXZe1o0QJ5bEVsMTDCQXRmOPrk5AEs_bFUt06FHDfx3b9PQR3nAJHPyiK-Aqzc4dMPDf7cdn3RMJa5PiFoXjq_8rz_78', 0, NULL, 1, '26.9435077', '80.9405513', '3', 2, 12, 6, 'Platina', 'Bajaj', '2017', 4.5, 'cabuser@gmail.com', 0, 0),
(90, 0.00, 0.00, 2, 2, 2, 2, 2, 2, 2, 'Bike', '5656532598', 'DriverDocuments/1769192061257.jpg', 'basant', 'panchmi ', '2000-01-01', NULL, NULL, 'DriverDocuments/1769192096542.jpg', 'DriverDocuments/1769192096809.jpg', 'BD12GE123356', '2026-01-31', NULL, 'DriverDocuments/1769192147635.jpg', 'DriverDocuments/1769192147898.jpg', '956431215487', 'DriverDocuments/1769192148098.jpg', NULL, 'BFHDHDHEGD', NULL, NULL, 'DriverDocuments/1769192403616.jpg', 'DriverDocuments/1769192403833.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-23 18:14:21', '2026-01-23 18:21:29', 'edfrgtyujy', 'eaHaBWbzSBWk7uAVN8ZRMe:APA91bESB9XwBm1hwWHdh58ht-w8-gdL6SRWcWry8VY__CnYZkmoNOn03rZOIv0qeIEbR1Cl0yPVOfvjtvfbzMbBzNgb194gJVdqjSloZGl22ZL5Qqvmwsw', 0, NULL, 1, '26.9476026', '80.9389603', '3', 2, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(91, 0.00, 0.00, 2, 2, 2, 2, 2, 2, 2, 'Bike', '9636962851', 'DriverDocuments/1769192716418.jpg', 'ncbcbd', 'bdbddb', '2000-01-12', NULL, NULL, 'DriverDocuments/1769192773466.jpg', 'DriverDocuments/1769192773466.jpg', 'GG12FT1234455', '2026-01-31', NULL, 'DriverDocuments/1769192798600.jpg', 'DriverDocuments/1769192798838.jpg', '963355855211', 'DriverDocuments/1769192799103.jpg', NULL, 'VHYYFGBHHY', NULL, 'DriverDocuments/1769192817176.jpg', 'DriverDocuments/1769192817459.jpg', 'DriverDocuments/1769192817784.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-23 18:25:16', '2026-02-14 04:45:53', 'fvgbhnj', 'f9IEdS5zSGauCIrqjwUjFK:APA91bEZn6o71-lBkaCCXJx7DB20hiWCf1z1nvmc8acJcLj1v-UmkBYw2DzB2jeKSiCJQpmiZ2kyumnkLwNv0MSVWF_9NRWGWxDKfHJnLqVOOZSo17_X7B0', 0, NULL, 1, '26.9431639', '80.9404249', '3', 2, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(92, 0.00, 0.00, 1, 1, 1, 1, 1, 0, 2, 'Bike', '6565689598', 'DriverDocuments/1769193485292.jpg', 'ugufucuc', ' bcchch', '2000-01-29', NULL, NULL, 'DriverDocuments/1769193513382.jpg', 'DriverDocuments/1769193514100.jpg', 'VU12VG1234447', '2026-01-31', NULL, 'DriverDocuments/1769193548526.jpg', 'DriverDocuments/1769193549183.jpg', '693838252283', 'DriverDocuments/1769193549854.jpg', NULL, 'BIBUBIUDTF', NULL, NULL, 'DriverDocuments/1769193561915.jpg', 'DriverDocuments/1769193562569.jpg', NULL, NULL, 'DriverDocuments/1769193584901.jpg', 'Bronze', 'VH 12 3456', NULL, NULL, NULL, NULL, NULL, '2026-01-23 18:38:05', '2026-01-23 18:46:26', 'edfrgtyujy', 'd1h5RkmCQMy2Qru47tKHw4:APA91bFo4tgMTSx_Y-xmwBtP5d272w9jeWfSQ9y5bGu9-fTWpXZVbbdDLGeR1sv0mJWPEcCMQws8EvY6hr15UAmXGqyVIf8C8ATT2qdEx6R7O7LegsunJEU', 0, NULL, 1, '26.9475098', '80.9389708', '3', 2, 12, 6, 'Platina', 'Bajaj', '2023', 4.5, 'cabuser@gmail.com', 0, 0),
(94, 0.00, 0.00, 1, 0, 0, 0, 0, 0, 2, 'Bike', '7376154153', 'DriverDocuments/1769250525476.jpg', 'Anshika ', 'pathak', '2000-01-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-24 10:28:29', '2026-01-24 10:28:48', 'edfrgtyujy', 'dqefwtrhy', 0, NULL, 1, NULL, NULL, '3', 2, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(95, 0.00, 0.00, 1, 1, 1, 1, 1, 1, 2, 'Bike', '6306206322', 'DriverDocuments/1769251001382.jpg', 'vv', 'vv', '2000-01-01', NULL, NULL, 'DriverDocuments/1769251040136.jpg', 'DriverDocuments/1769251040534.jpg', 'ggghvcghhjjffggghhcgjljh', '2026-01-24', NULL, 'DriverDocuments/1769251091141.jpg', 'DriverDocuments/1769251091685.jpg', '889756845574', 'DriverDocuments/1769251092169.jpg', 'DriverDocuments/1769251092239.jpg', 'MCVNP65457', NULL, 'DriverDocuments/1769251115904.jpg', 'DriverDocuments/1769251116265.jpg', 'DriverDocuments/1769251116314.jpg', 'DriverDocuments/1769251116850.jpg', NULL, 'DriverDocuments/1769251168699.jpg', 'Blue', 'UP31RW4423', NULL, 'DriverDocuments/1769251185052.jpg', 'DriverDocuments/1769251185065.jpg', 'DriverDocuments/1769251185652.jpg', NULL, '2026-01-24 10:36:42', '2026-02-02 03:54:57', 'edfrgtyujy', 'dqefwtrhy', 0, NULL, 1, '26.9432645', '80.9403746', '3', 2, 12, 6, 'Platina', 'Bajaj', '2023', 4.5, 'cabuser@gmail.com', 0, 0),
(98, 0.00, 0.00, 2, 2, 2, 2, 2, 2, 2, 'Bike', '9208339102', 'DriverDocuments/1770867607064.jpg', 'nitin', 'pandey', '2004-01-01', NULL, NULL, 'DriverDocuments/1770867659376.jpg', 'DriverDocuments/1770867659996.jpg', 'BH01AB1234567644', '2026-11-27', NULL, 'DriverDocuments/1770867695361.jpg', 'DriverDocuments/1770867695841.jpg', '124846534955', 'DriverDocuments/1770867696336.jpg', NULL, 'MHVPK0703J', NULL, NULL, 'DriverDocuments/1770867720509.jpg', 'DriverDocuments/1770867721118.jpg', NULL, NULL, 'DriverDocuments/1770867776446.jpg', 'Black', 'UP 32 LK 5612', NULL, NULL, NULL, NULL, NULL, '2026-02-12 03:40:08', '2026-02-21 04:13:12', 'fvgbhnj', 'enfV7vG4TWG4x4wkDeWTht:APA91bHn664YVGWZQAJkASId5Jq8xXdwT6uI9sDgUMyFN98bofqJPXgqzMG7GcdNGxbEcm3LfbOD1t1GXp3vQj3prF1vSgIb-T8W5_CNMYksmVVihzd7bCI', 0, NULL, 1, '0', '0', '3', 2, 12, 6, 'Platina', 'Bajaj', '2020', 4.5, 'cabuser@gmail.com', 0, 0),
(99, 0.00, 0.00, 1, 0, 0, 0, 0, 0, 2, 'Bike', '7705020474', 'DriverDocuments/1770959470740.jpg', 'ujjwal', 'ujj', '2000-01-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-13 05:10:52', '2026-02-13 05:11:11', 'edfrgtyujy', 'ctR-ynXVRXSDjieK1QW9oh:APA91bF5D8aNxcoSb45DIhS46JxQM5hwUVHiyDMar-RHaTztqozQDPKxJFd1YSfm-pKSy8HH8UAXTSvTbik-a3sPBbKcwuM1K65wJQu_oV8yGqBqyuj4WBA', 0, NULL, 1, NULL, NULL, '3', 2, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(101, 6561.00, 586.27, 2, 2, 2, 2, 2, 2, 2, 'Sedan', '9565789026', 'DriverDocuments/1771912100753.jpg', 'SHIVANSHU ', 'PANDEY ', '2008-07-18', NULL, NULL, 'DriverDocuments/1771912293501.jpg', 'DriverDocuments/1771912293679.jpg', 'UP3420100012033', '2031-02-24', NULL, 'DriverDocuments/1771912343395.jpg', 'DriverDocuments/1771912343396.jpg', '648836330721', 'DriverDocuments/1771912343638.jpg', NULL, 'CMQPP9258R', NULL, 'DriverDocuments/1771912441319.jpg', 'DriverDocuments/1771912441320.jpg', 'DriverDocuments/1771912441658.jpg', 'DriverDocuments/1771912441738.jpg', NULL, 'DriverDocuments/1771912512550.jpg', 'Beige', 'UP 32 QN 1274', NULL, 'DriverDocuments/1771912530459.jpg', 'DriverDocuments/1771912530528.jpg', 'DriverDocuments/1771912531168.jpg', 'DriverDocuments/1771912531283.jpg', '2026-02-24 05:48:21', '2026-03-12 12:18:46', 'edfrgtyujy', 'eTre4P4HRy-jbBWfQwh8ob:APA91bE09ghXfjPYJqomWi0IpX547J_DYIlGSlIqZCADqD4h-AXJRdheaE2QqmlpvhCliITEwN1UKm25UfUM0HkcpgiZtd1g2wwx1oikmFTi8mD4sZLPpns', 1, NULL, 1, '26.9399812', '80.9571715', '4', 4, 13, 8, 'Sport', 'Honda City', '2021', 4.5, 'cabuser@gmail.com', 0, 0),
(102, 154.00, 31.50, 2, 2, 2, 2, 2, 2, 2, 'Bike', '7705827321', 'DriverDocuments/1771938239753.jpg', 'aman', 'mishra', '1996-01-05', NULL, NULL, 'DriverDocuments/1771937945063.jpg', 'DriverDocuments/1771937945435.jpg', 'UP3420170013464', '2036-02-22', NULL, 'DriverDocuments/1771938174073.jpg', 'DriverDocuments/1771938174777.jpg', '266436729341', 'DriverDocuments/1771938175013.jpg', NULL, 'CRPKM4587P', NULL, 'DriverDocuments/1771938301770.jpg', 'DriverDocuments/1771938302108.jpg', 'DriverDocuments/1771938302238.jpg', 'DriverDocuments/1771938302268.jpg', NULL, 'DriverDocuments/1771938358459.jpg', 'Blue', 'UP 32 RD 9603', NULL, NULL, NULL, NULL, NULL, '2026-02-24 12:55:35', '2026-03-13 06:15:24', 'fvgbhnj', 'f1ItRLyIQ4C3dXPO4La5ei:APA91bFg4mWx2kNBLA6OyeXmhVaPR2KX_mEAoj_n-_QPi15EwnJN8w2svkufZANWYEdLSEPG-OE3lSHHgwR7z625eHl28nBsRnTOAioB5el06RWPHVGXzys', 1, NULL, 1, '26.9823616', '80.931707', '3', 2, 10, 5, 'Shine', 'Honda', '2025', 4.5, 'cabuser@gmail.com', 0, 0),
(103, 0.00, 0.00, 1, 0, 1, 1, 0, 0, 2, 'Bike', '9721107123', 'DriverDocuments/1771958489938.jpg', 'Anand ', 'kumar ', '1995-10-01', NULL, NULL, 'DriverDocuments/1771958978845.jpg', 'DriverDocuments/1771958979263.jpg', 'UP32A20190009559', '2035-08-07', NULL, 'DriverDocuments/1772033025394.jpg', 'DriverDocuments/1772033028791.jpg', '602885613368', 'DriverDocuments/1772033030711.jpg', NULL, 'HTSPK1530H', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-24 18:41:31', '2026-03-07 07:07:53', 'fvgbhnj', 'eEXn_W21SRqY5s5_ISb-U-:APA91bHj8KcjP7RhjHhLwbqzvEQYskAEN9kDLDIZeq9fqFmJnExRnKNp-0FwpYyTXmBAV0M-4AcdJ1j-FS1SIzKRRHqr6a7mzNylPaCzuJz5vNyAEV6PzU4', 0, NULL, 1, '26.9520292', '80.9255651', '3', 2, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(105, 0.00, 0.00, 1, 0, 0, 0, 0, 0, 2, 'Bike', '7054124397', 'DriverDocuments/1772206426467.jpg', 'anju', 'pal', '1999-11-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-27 15:29:45', '2026-02-27 15:33:47', 'edfrgtyujy', 'fUpdBjT8SVWgP87RQHth2X:APA91bESs-bpaDvHohBTcE-nRRTHgWy-TEFoc78TVc9Tpkux--ogzQ2aNHg-JAuticyroX3ndHbUotyX3_qSDWW5er3ZBFd1-pYdP6jlcYgs-Knj8N3ILP0', 0, NULL, 1, NULL, NULL, '3', 2, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(106, 0.00, 0.00, 1, 0, 1, 1, 1, 0, 2, 'Bike', '9794116633', 'DriverDocuments/1772795156604.jpg', 'gautam  ', 'panday', '1992-01-01', NULL, NULL, 'DriverDocuments/1772795550838.jpg', 'DriverDocuments/1772795551583.jpg', 'UP34116613181', '2031-12-30', NULL, 'DriverDocuments/1772795657717.jpg', 'DriverDocuments/1772795658204.jpg', '650934058444', 'DriverDocuments/1772795658600.jpg', NULL, 'DZEPP3258V', NULL, 'DriverDocuments/1772795793572.jpg', 'DriverDocuments/1772795794235.jpg', 'DriverDocuments/1772795794718.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-06 11:05:57', '2026-03-06 11:31:59', 'edfrgtyujy', 'dkSLElgNSqiOeVcwHBlQVc:APA91bEfFVME5dQC1RkDuQ6DkMfJASLz52SPKLAw_vc1LuVHbL6KM1U_rjCDqcNLqF-XkahwLgKdReuVrqAfZx7eB514sRMrp9Vr5o0ZeRgYftS3xjfgFQM', 0, NULL, 1, '26.845143', '81.0185924', '3', 2, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(107, 0.00, 0.00, 1, 0, 0, 0, 0, 0, 2, 'Bike', '8127570413', 'DriverDocuments/1773046766966.heic', 'shubam', 'kumar', '2006-02-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-09 09:01:33', NULL, 'edfrgtyujy', 'dJPT-1hATqu1Fm4rftsBHP:APA91bES0do8-0z0lHlQ_86GutV4BDqSjx0dWP_3KtiIoS2oF1GujIDIWUlwR2WQbOqbPYIy5Y3WtU6WqMQVgzNPsfUcaLv4sTqOmRwPIWEey7ABwD7eopc', 0, NULL, 1, NULL, NULL, '3', 2, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(108, 0.00, 0.00, 1, 0, 1, 1, 1, 0, 2, 'Sedan', '9651511938', 'DriverDocuments/1773132006169.jpg', 'Bramha ', 'Narayan ', '1987-03-16', NULL, NULL, 'DriverDocuments/1773142693160.jpg', 'DriverDocuments/1773142693694.jpg', 'UP3420100012033', '2030-10-17', NULL, 'DriverDocuments/1773142781450.jpg', 'DriverDocuments/1773142784323.jpg', '648836330721', 'DriverDocuments/1773142786505.jpg', NULL, 'CMQPP9258R', NULL, 'DriverDocuments/1773143688215.jpg', 'DriverDocuments/1773143689064.jpg', 'DriverDocuments/1773143690029.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-10 08:40:07', '2026-03-12 12:42:59', 'edfrgtyujy', 'ccyXgovHRN6bsSQVm7xE2o:APA91bHj1pzqAwRBaZ2nAXG6tKtNJQGDQ3rKOHnllb6sbfMaKk3PcPBOdRGX7p4Y_jbbQXwAiNRRoI9dRgUNHixCCzEZA6-q6OBfWIILV2yNJ_IjqYIGckI', 0, NULL, 1, '27.6395117', '80.8496167', '4', 4, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(109, 0.00, 0.00, 1, 0, 1, 1, 1, 0, 2, 'Mini', '8840442287', 'DriverDocuments/1773202199575.jpg', 'abc', 'test', '2000-01-01', NULL, NULL, 'DriverDocuments/1773202248914.jpg', 'DriverDocuments/1773202250162.jpg', 'MH12FT1122', '2026-03-11', NULL, 'DriverDocuments/1773202275837.jpg', 'DriverDocuments/1773202277451.jpg', '662225663333', 'DriverDocuments/1773202278936.jpg', NULL, 'HHHHYYGGGH', NULL, 'DriverDocuments/1773202296667.jpg', 'DriverDocuments/1773202298105.jpg', 'DriverDocuments/1773202299698.jpg', 'DriverDocuments/1773202300742.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-11 04:09:59', '2026-03-11 04:11:43', 'edfrgtyujy', 'cxH3wcVDRyCJlkVwFLR6Ym:APA91bHAa81KSdXH-eVqOHCkzIBfx33CpHbxyYdaDclL6Yoy-c-SPGhyrs4GmWQ2txPstaWDcrbn7u_0Df3TosqQ0-6YUFQUr0MTWND7tT3ShAsd1nbKaPY', 0, NULL, 1, '26.943562', '80.9405901', '2', 4, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `invoice_settings`
--

CREATE TABLE `invoice_settings` (
  `id` int(11) NOT NULL,
  `company_name` varchar(150) NOT NULL,
  `company_logo` varchar(255) DEFAULT NULL,
  `company_address` text,
  `gst_number` varchar(20) DEFAULT NULL,
  `gst_percentage` decimal(5,2) DEFAULT '0.00',
  `cgst_percentage` decimal(5,2) DEFAULT '0.00',
  `sgst_percentage` decimal(5,2) DEFAULT '0.00',
  `igst_percentage` decimal(5,2) DEFAULT '0.00',
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `website_link` varchar(155) DEFAULT NULL,
  `booking_fee` double(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `invoice_settings`
--

INSERT INTO `invoice_settings` (`id`, `company_name`, `company_logo`, `company_address`, `gst_number`, `gst_percentage`, `cgst_percentage`, `sgst_percentage`, `igst_percentage`, `is_active`, `created_at`, `updated_at`, `website_link`, `booking_fee`) VALUES
(1, 'Rainbow Enterprises', '/assets/img/invoicelogo.png', 'House Number 12, Shyam Vihar Colony,\r\nNear Asha Polyclinic, Asthi Road,\r\nBakshi Ka Talab, Lucknow – 227202, India', '', 18.00, 2.50, 2.50, 0.00, 1, '2026-01-30 04:43:16', '2026-02-03 12:11:27', 'https://rainbowsenterprises.com/', 1.00);

-- --------------------------------------------------------

--
-- Table structure for table `job_request`
--

CREATE TABLE `job_request` (
  `id` int(11) NOT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `mobile` varchar(12) DEFAULT NULL,
  `designation` longtext,
  `profile_photo` varchar(255) DEFAULT NULL,
  `police_verification_certificate` varchar(100) DEFAULT NULL,
  `skill_type` tinyint(4) DEFAULT NULL,
  `designation_file` longtext,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `user_id` int(10) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `usertype` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `job_request`
--

INSERT INTO `job_request` (`id`, `first_name`, `last_name`, `email`, `mobile`, `designation`, `profile_photo`, `police_verification_certificate`, `skill_type`, `designation_file`, `created_at`, `status`, `user_id`, `city`, `usertype`) VALUES
(1, 'ramu', 'sharma', 'ram@gmail.com', '8423953286', 'electicial', NULL, 'JobFiles/1764933353544.png', 1, '[\"JobFiles/1764933354249.png\",\"JobFiles/1764933354715.png\",\"JobFiles/1764933355135.png\"]', '2025-12-05 11:15:53', 0, NULL, NULL, NULL),
(2, 'ramu', 'sharma', 'ram@gmail.com', '8423953286', 'electicial', NULL, 'JobFiles/1764933496316.png', 1, '[]', '2025-12-05 11:18:16', 0, NULL, NULL, NULL),
(3, 'ramu', 'sharma', 'ram@gmail.com', '8423953286', 'electicial', NULL, 'JobFiles/1764933675328.png', 1, '[]', '2025-12-05 11:21:15', 0, 1, NULL, NULL),
(4, 'ramu', 'sharma', 'ram@gmail.com', '8423953286', 'electicial', NULL, 'JobFiles/1764933958535.png', 1, '[]', '2025-12-05 11:25:58', 0, 1, 'lucknow', NULL),
(5, 'ramu', 'sharma', 'ram@gmail.com', '8423953286', 'electicial', NULL, 'JobFiles/1764934134770.png', 1, '[\"JobFiles/1764934135423.png\",\"JobFiles/1764934135808.png\"]', '2025-12-05 11:28:54', 0, 1, 'lucknow', NULL),
(6, 'ramu', 'sharma', 'ramszdxfghj@gmail.com', '8423953286', 'electicial', NULL, 'JobFiles/1764934221591.png', 1, '[\"JobFiles/1764934222243.png\",\"JobFiles/1764934222680.png\"]', '2025-12-05 11:30:21', 0, 1, 'lucknow', NULL),
(7, 'ramu', 'sharma', 'ramszdxfghj@gmail.com', '8423953286', 'electicial', NULL, 'JobFiles/1764934318379.png', 0, '[\"JobFiles/1764934319138.png\",\"JobFiles/1765001614675.pdf\"]', '2025-12-05 11:31:58', 0, 1, 'lucknow', NULL),
(8, 'ramu', 'sharma', 'ramszdxfghj@gmail.com', '8423953286', 'electicial', NULL, 'JobFiles/1764934784676.png', 1, '[]', '2025-12-05 11:39:44', 0, 1, 'lucknow', NULL),
(9, 'ramu', 'sharma', 'ramszdxfghj@gmail.com', '8423953286', 'electicial', NULL, NULL, 1, '[]', '2025-12-05 11:43:38', 0, 1, 'lucknow', NULL),
(10, 'ramu', 'sharma', 'ramszdxfghj@gmail.com', '8423953286', 'electicial', NULL, NULL, 1, '[]', '2025-12-05 11:47:00', 0, 1, 'lucknow', NULL),
(11, 'ramu', 'sharma', 'ramszdxfghj@gmail.com', '8423953286', 'electicial', NULL, NULL, 1, '[]', '2025-12-05 11:47:52', 0, 1, 'lucknow', NULL),
(12, 'ramu', 'sharma', 'ramszdxfghj@gmail.com', '8423953286', 'electicial', NULL, NULL, 1, '[]', '2025-12-05 11:50:59', 0, 1, 'lucknow', NULL),
(13, 'ramu', 'sharma', 'ramszdxfghj@gmail.com', '8423953286', 'electicial', NULL, NULL, 1, '[]', '2025-12-05 12:30:33', 0, 1, 'lucknow', 1),
(15, 'ramu', 'sharma', 'ramszdxfghj@gmail.com', '8423953286', 'electicial', 'JobFiles/1764997582262.png', 'JobFiles/1764997581344.png', 1, '[]', '2025-12-06 05:06:21', 0, 1, 'lucknow', 1),
(16, 'ramu', 'sharma', 'ramszdxfghj@gmail.com', '8423953286', 'electicial', 'JobFiles/1764997636473.png', 'JobFiles/1764997634248.png', 0, '[\"JobFiles/1764997635260.png\",\"JobFiles/1764997635980.png\"]', '2025-12-06 05:07:14', 0, 1, 'lucknow', 1),
(18, 'ramu', 'sharma', 'ramszdxfghj@gmail.com', '8423953286', 'electicial', 'JobFiles/1764999646066.png', 'JobFiles/1764999644550.png', 0, '[\"JobFiles/1764999645195.png\",\"JobFiles/1764999645688.png\"]', '2025-12-06 05:40:44', 0, 1, 'lucknow', 1),
(19, 'Anshika ', 'Pathankot ', 'anshu@gmail.com', '9946341691', 'lummebh', 'JobFiles/1765001614045.jpg', 'JobFiles/1765001614045.jpg', 0, '[\"JobFiles/1765001614276.jpg\",\"JobFiles/1765001614675.pdf\"]', '2025-12-06 06:13:34', 0, 11, 'lucknow', 1),
(20, 'Advika ', 'Sharma ', 'asv@gmail.com', '6565265656', 'bfhfhd', 'JobFiles/1765003682207.jpg', 'JobFiles/1765003681959.jpg', 1, '[]', '2025-12-06 06:48:01', 0, 11, 'Agra', 1),
(21, 'basant ', 'Panchami', 'basabt@gmail.com', '9808522666', 'hello', 'JobFiles/1769235639183.jpg', 'JobFiles/1769235638638.jpg', 0, '[\"JobFiles/1769235639445.jpg\",\"JobFiles/1769235639569.jpg\"]', '2026-01-24 06:20:38', 0, 28, 'Lucknow', 1);

-- --------------------------------------------------------

--
-- Table structure for table `loginadds`
--

CREATE TABLE `loginadds` (
  `id` int(11) NOT NULL,
  `heading` varchar(100) NOT NULL,
  `sub_heading` varchar(100) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `loginadds`
--

INSERT INTO `loginadds` (`id`, `heading`, `sub_heading`, `image`, `created_at`) VALUES
(1, 'Your App for Fair Deals', 'Choose rides that are right for you', 'loginadds/img2.png', '2025-12-04 05:22:21'),
(2, 'Fast and Secure Rides', 'Safe rides available anytime', 'loginadds/img1.png', '2025-12-04 05:22:21'),
(3, 'Lowest Prices', 'Get the best deals near you', 'loginadds/img2.png', '2025-12-04 05:22:21');

-- --------------------------------------------------------

--
-- Table structure for table `login_policy`
--

CREATE TABLE `login_policy` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `type` int(10) DEFAULT NULL COMMENT '1 = for driver\r\n2 = for User',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `login_policy`
--

INSERT INTO `login_policy` (`id`, `title`, `description`, `type`, `created_at`) VALUES
(1, 'Privacy Policy', '<article>\n  <h1>Privacy Policy</h1>\n\n  <h2>Your Privacy Matters to Us</h2>\n  <p>We are committed to protecting your personal information and ensuring that your data is handled lawfully and transparently.</p>\n\n  <h2>1. Information We Collect</h2>\n  <p>We may collect information such as your name, phone number, email, location, and device details while you are using the app.</p>\n\n  <h2>2. How We Use Your Information</h2>\n  <p>Your information is used to improve app performance, enhance security, provide a better user experience, and enable service features like ride booking and service appointments.</p>\n\n  <h2>3. Location Access</h2>\n  <p>Location data helps us find nearby service providers, calculate distance, estimate arrival time, and ensure accurate pickups and deliveries.</p>\n\n  <h2>4. Third-Party Services</h2>\n  <p>We may share limited information with trusted partners such as payment gateways and mapping providers to complete specific operations.</p>\n\n  <h2>5. Data Protection</h2>\n  <p>Your data is stored securely. Unauthorized access, misuse, or disclosure is strictly prohibited. We regularly update our security measures.</p>\n\n  <h2>6. Your Rights</h2>\n  <p>You may request deletion of your data, update your account details, or contact support for any privacy-related concerns.</p>\n\n  <h2>7. Updates to This Policy</h2>\n  <p>We may revise this Privacy Policy from time to time. Continued use of the app signifies your acceptance of the updated terms.</p>\n\n  <footer>\n    <p style=\"text-align:center; margin-top:20px;\">❤️ Thank you for trusting Rainbow!</p>\n  </footer>\n</article>\n', 2, '2025-12-04 04:39:29'),
(2, 'Terms of Login', '<article>\n  <h1>Terms of Login</h1>\n\n  <h2>Secure and Responsible Account Access</h2>\n  <p>By logging into the app, you agree to follow the guidelines below to ensure safe, secure, and responsible access to your account.</p>\n\n  <h2>1. Accurate Login Information</h2>\n  <p>You must provide correct and updated information, including your mobile number or email, to access your account without restrictions.</p>\n\n  <h2>2. Protection of Login Credentials</h2>\n  <p>You are responsible for keeping your login details confidential. Do not share your OTP, password, or access details with anyone.</p>\n\n  <h2>3. OTP-Based Verification</h2>\n  <p>Login may require OTP verification. By using our app, you agree to receive OTPs on your registered number for authentication and security purposes.</p>\n\n  <h2>4. Prevention of Unauthorized Access</h2>\n  <p>If you observe any unusual or unauthorized login attempts, report it to our support team immediately to safeguard your account.</p>\n\n  <h2>5. Device Security Requirements</h2>\n  <p>Ensure your device is protected with a lock screen and avoid logging in on untrusted or public devices to prevent unauthorized use.</p>\n\n  <h2>6. Misuse of Account</h2>\n  <p>Engaging in fraudulent activity, impersonation, harmful actions, or violating community rules may result in account suspension or termination.</p>\n\n  <h2>7. Updates to Terms of Login</h2>\n  <p>We may modify these Terms of Login from time to time. Continued use of the app after an update indicates your acceptance of the revised terms.</p>\n\n  <footer>\n    <p style=\"text-align:center; margin-top:20px;\">🔐 Thank you for accessing your account responsibly!</p>\n  </footer>\n</article>\n', 2, '2025-12-04 04:39:29');

-- --------------------------------------------------------

--
-- Table structure for table `model`
--

CREATE TABLE `model` (
  `id` int(11) NOT NULL,
  `brand_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `status` tinyint(4) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `model`
--

INSERT INTO `model` (`id`, `brand_id`, `name`, `status`, `created_at`) VALUES
(1, 1, 'RE Compact', 1, '2025-12-30 04:34:09'),
(2, 1, 'Maxima', 1, '2025-12-30 04:34:09'),
(3, 2, 'King Deluxe', 1, '2025-12-30 04:34:09'),
(4, 2, 'King Duramax', 1, '2025-12-30 04:34:09'),
(5, 12, 'Dzire', 1, '2025-12-30 04:34:19'),
(6, 3, 'WagonR', 1, '2025-12-30 04:34:19'),
(7, 4, 'i10', 1, '2025-12-30 04:34:19'),
(8, 4, 'Aura', 1, '2025-12-30 04:34:19'),
(9, 5, 'CB Hornet', 1, '2025-12-30 04:34:35'),
(10, 5, 'Shine', 1, '2025-12-30 04:34:35'),
(11, 6, 'Pulsar 150', 1, '2025-12-30 04:34:35'),
(12, 6, 'Platina', 1, '2025-12-30 04:34:35'),
(13, 8, 'Sport', 1, '2026-01-23 11:23:10'),
(14, 8, 'V CVT', 1, '2026-01-23 11:28:58'),
(15, 9, 'Verna EX', 1, '2026-01-23 11:30:39'),
(16, 9, 'Verna SX Turbo', 1, '2026-01-23 11:31:08'),
(17, 4, 'Hyundai Venue', 1, '2026-01-23 11:36:01'),
(18, 10, 'Hyundai Venue', 1, '2026-01-23 11:36:34'),
(19, 10, 'Hyundai Creta', 1, '2026-01-23 11:37:38'),
(20, 11, 'Tata Nexon', 1, '2026-01-23 11:38:17'),
(21, 11, 'Tata Harrier', 1, '2026-01-23 11:39:26'),
(22, 13, 'WAGNOR', 1, '2026-01-29 04:06:08'),
(23, 14, 'TVS 100', 1, '2026-02-24 13:15:00'),
(24, 12, 'ZXI+', 1, '2026-02-26 03:18:31'),
(25, 15, 'Hero HF Deluxe', 1, '2026-03-08 05:55:01');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `entity_type` tinyint(4) NOT NULL COMMENT '1=User Cab, 2=User Service, 3=Driver, 4=Serviceman, 5=Public',
  `entity_id` bigint(20) DEFAULT NULL COMMENT 'User/Driver/Serviceman ID, NULL for public',
  `title` varchar(150) NOT NULL,
  `text` text NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `data` json DEFAULT NULL COMMENT 'Extra payload like order_id, type, screen',
  `is_read` tinyint(1) DEFAULT '0' COMMENT '0=Unread, 1=Read',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `entity_type`, `entity_id`, `title`, `text`, `image`, `data`, `is_read`, `created_at`) VALUES
(1, 1, 4, 'hii', 'hii', NULL, NULL, 0, '2026-01-31 05:34:56'),
(2, 2, 4, 'service', 'service', NULL, NULL, 0, '2026-01-31 05:36:28'),
(3, 1, 3, 'cab service', 'cab service', NULL, NULL, 0, '2026-01-31 05:37:23'),
(4, 2, 3, 'service', 'service', NULL, NULL, 0, '2026-01-31 05:37:41'),
(5, 3, 19, ' for driver', ' for deriver', NULL, NULL, 0, '2026-01-31 05:38:15'),
(6, 4, 1, 'serviceman', 'serviceman', NULL, NULL, 0, '2026-01-31 05:38:46'),
(7, 3, 19, 'hii', 'heloo', NULL, NULL, 0, '2026-02-06 09:52:00'),
(8, 3, 19, 'hello', 'hello', NULL, NULL, 0, '2026-02-07 06:28:26'),
(9, 3, 19, 'hello', 'hello tanisha', NULL, NULL, 0, '2026-02-07 06:31:40'),
(10, 3, 19, 'hhiiiiiiii', 'hi....................', NULL, NULL, 0, '2026-02-07 06:34:15'),
(11, 3, 19, 'h', 'a', NULL, NULL, 0, '2026-02-07 06:37:14'),
(12, 3, 19, 'sdfgyu', 'sdfghj', NULL, NULL, 0, '2026-02-07 06:38:39'),
(13, 3, 19, 'hii', 'hiii', NULL, NULL, 0, '2026-02-07 06:40:38'),
(14, 3, 19, 'hi', 'hii', NULL, NULL, 0, '2026-02-07 06:46:06'),
(15, 3, 19, 'hiiiiiiiii', 'hello', NULL, NULL, 0, '2026-02-07 07:09:13'),
(16, 3, 19, 'Ramu Sharma ask You', 'Project done ?', NULL, NULL, 0, '2026-02-09 10:10:28'),
(17, 3, 19, 'Ramu Sharma ', 'again', NULL, NULL, 0, '2026-02-09 10:11:09'),
(18, 4, 1, 'serviceman', 'serviceman', NULL, NULL, 0, '2026-02-09 10:25:32'),
(19, 3, 93, 'RANIBOW', 'HAPPAY BIRTHDAY', NULL, NULL, 0, '2026-02-09 13:53:44'),
(20, 3, 96, 'Join rainbow- downlod app now', 'Easy booking reliable service and better earning opportunities', NULL, NULL, 0, '2026-02-10 15:07:25'),
(21, 3, 88, 'New ride request', 'Dear driver\r\nA new booking is avavilable for you please open the app to check the details and accept the ride on time thankyou', NULL, NULL, 0, '2026-02-10 15:17:52'),
(22, 1, 3, 'A', 'b', NULL, NULL, 0, '2026-02-21 15:59:57'),
(23, 1, 1, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(24, 1, 2, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(25, 1, 3, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(26, 1, 4, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(27, 1, 5, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(28, 1, 6, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(29, 1, 7, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(30, 1, 8, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(31, 1, 9, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(32, 1, 10, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(33, 1, 11, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(34, 1, 12, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(35, 1, 13, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(36, 1, 14, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(37, 1, 15, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(38, 1, 16, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(39, 1, 17, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(40, 1, 18, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(41, 1, 19, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(42, 1, 20, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(43, 1, 21, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(44, 1, 22, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(45, 1, 23, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(46, 1, 24, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(47, 1, 26, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(48, 1, 27, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(49, 1, 28, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(50, 1, 29, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(51, 1, 30, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(52, 1, 31, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(53, 1, 32, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(54, 1, 33, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(55, 1, 34, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(56, 1, 35, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(57, 1, 36, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(58, 1, 37, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(59, 1, 38, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(60, 1, 39, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(61, 1, 40, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(62, 1, 41, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(63, 1, 42, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(64, 1, 43, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(65, 1, 44, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(66, 1, 45, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(67, 1, 46, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(68, 1, 47, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(69, 1, 48, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(70, 1, 49, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(71, 1, 50, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(72, 1, 51, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(73, 1, 52, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08'),
(74, 1, 53, 'WELCOME TO RAINBOW APP', 'THANKU YOU FOR DOWNLODING OUR APP  AB APP AASANI SE RIDE BOOKING AUR SERVICES KA FAYDA UTHASAKTE HAIN .SAFE FAST RELIABLE SERVICE KE LEYE HAMARE SAATH  BANE RAHIYE', NULL, NULL, 0, '2026-02-24 14:40:08');

-- --------------------------------------------------------

--
-- Table structure for table `otp_counter`
--

CREATE TABLE `otp_counter` (
  `id` int(11) NOT NULL,
  `counter_name` varchar(50) NOT NULL DEFAULT 'default',
  `remaining_otp` int(11) DEFAULT '5000',
  `total_otp` int(11) DEFAULT '5000',
  `reset_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `otp_counter`
--

INSERT INTO `otp_counter` (`id`, `counter_name`, `remaining_otp`, `total_otp`, `reset_date`) VALUES
(1, 'default', 4999, 5000, '2025-12-25 04:25:22');

-- --------------------------------------------------------

--
-- Table structure for table `otp_logs`
--

CREATE TABLE `otp_logs` (
  `id` int(10) UNSIGNED NOT NULL,
  `mobile` varchar(15) NOT NULL,
  `otp` varchar(6) NOT NULL,
  `is_used` tinyint(1) NOT NULL DEFAULT '0',
  `expires_at` datetime NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `otp_logs`
--

INSERT INTO `otp_logs` (`id`, `mobile`, `otp`, `is_used`, `expires_at`, `created_at`) VALUES
(1, '8423953286', '2486', 0, '2025-12-24 04:51:42', '2025-12-24 04:46:42'),
(2, '8423953286', '1903', 1, '2025-12-24 10:27:43', '2025-12-24 10:15:43'),
(3, '8423953286', '8997', 0, '2025-12-24 10:40:29', '2025-12-24 10:35:29'),
(4, '8423953286', '2537', 0, '2025-12-24 11:02:34', '2025-12-24 10:57:34'),
(5, '8423953286', '4724', 0, '2025-12-27 10:56:16', '2025-12-27 10:51:16'),
(6, '8423953286', '3922', 0, '2025-12-27 10:56:50', '2025-12-27 10:51:50'),
(7, '6306206322', '2136', 0, '2026-01-08 15:38:29', '2026-01-08 15:33:29'),
(8, '6306206322', '1735', 0, '2026-01-08 15:42:11', '2026-01-08 15:37:11'),
(9, '6306206322', '7955', 0, '2026-01-08 15:43:34', '2026-01-08 15:38:34'),
(10, '6306206322', '9417', 0, '2026-01-08 15:43:45', '2026-01-08 15:38:45'),
(11, '8423953286', '5005', 0, '2026-01-08 15:44:39', '2026-01-08 15:39:39'),
(12, '8423953286', '4366', 0, '2026-01-08 15:48:50', '2026-01-08 15:43:50'),
(13, '8423953286', '4347', 0, '2026-01-08 16:04:34', '2026-01-08 15:59:34'),
(14, '8423953286', '2974', 0, '2026-01-08 16:04:09', '2026-01-08 16:02:09'),
(15, '8423953286', '2168', 0, '2026-01-08 16:04:20', '2026-01-08 16:02:20'),
(16, '8423953286', '4527', 0, '2026-01-08 16:06:18', '2026-01-08 16:04:18'),
(17, '8423953286', '1121', 0, '2026-01-08 16:06:44', '2026-01-08 16:04:44'),
(18, '8423953286', '1278', 0, '2026-01-08 16:09:56', '2026-01-08 16:07:56'),
(19, '8423953286', '6696', 0, '2026-01-08 16:16:45', '2026-01-08 16:14:45'),
(20, '8423953286', '1451', 0, '2026-01-08 16:19:18', '2026-01-08 16:17:18'),
(21, '1234567890', '8186', 0, '2026-01-08 16:20:15', '2026-01-08 16:18:15'),
(22, '8423953286', '9229', 0, '2026-01-08 16:20:31', '2026-01-08 16:18:31'),
(23, '8423953286', '9288', 1, '2026-01-08 16:27:00', '2026-01-08 16:25:00'),
(24, '8423953286', '4026', 1, '2026-01-08 16:29:13', '2026-01-08 16:27:13'),
(25, '8423953286', '1111', 1, '2026-01-08 16:51:40', '2026-01-08 16:49:40'),
(26, '8423953286', '6569', 0, '2026-01-08 16:52:02', '2026-01-08 16:50:02'),
(27, '8423953286', '8945', 0, '2026-01-08 16:53:58', '2026-01-08 16:51:58'),
(28, '8423953286', '1111', 1, '2026-01-08 16:54:08', '2026-01-08 16:52:08'),
(29, '8423953286', '1111', 0, '2026-01-17 16:13:30', '2026-01-17 16:11:30'),
(30, '8423959819', '1111', 0, '2026-01-17 16:14:59', '2026-01-17 16:12:59'),
(31, '8423953286', '7320', 1, '2026-01-17 16:16:03', '2026-01-17 16:14:03'),
(32, '7705827321', '1972', 1, '2026-01-17 16:54:18', '2026-01-17 16:52:18'),
(33, '9651511938', '5692', 1, '2026-01-17 17:04:02', '2026-01-17 17:02:02'),
(34, '7705827321', '8969', 1, '2026-01-17 17:19:40', '2026-01-17 17:17:40'),
(35, '9559960255', '7543', 1, '2026-01-17 17:22:27', '2026-01-17 17:20:27'),
(36, '7705017444', '8335', 1, '2026-01-17 17:29:24', '2026-01-17 17:27:24'),
(37, '7705017444', '5729', 1, '2026-01-17 17:31:19', '2026-01-17 17:29:19'),
(38, '7705827321', '1515', 1, '2026-01-17 17:43:35', '2026-01-17 17:41:35'),
(39, '9559960255', '5356', 1, '2026-01-17 18:06:26', '2026-01-17 18:04:26'),
(40, '7705827321', '5018', 1, '2026-01-17 18:35:33', '2026-01-17 18:33:33'),
(41, '7705827321', '8132', 1, '2026-01-17 18:35:58', '2026-01-17 18:33:58'),
(42, '8303204543', '3238', 1, '2026-01-17 19:25:45', '2026-01-17 19:23:45'),
(43, '7705827321', '8147', 1, '2026-01-17 21:03:26', '2026-01-17 21:01:26'),
(44, '7800019135', '9080', 1, '2026-01-18 11:59:10', '2026-01-18 11:57:10'),
(45, '9236639289', '5988', 1, '2026-01-18 15:35:04', '2026-01-18 15:33:04'),
(46, '6665852214', '7544', 1, '2026-01-21 09:42:33', '2026-01-21 09:40:33'),
(47, '9632580099', '2365', 1, '2026-01-21 10:22:00', '2026-01-21 10:20:00'),
(48, '9884544689', '7290', 1, '2026-01-21 10:35:12', '2026-01-21 10:33:12'),
(49, '9808559632', '1083', 1, '2026-01-21 11:17:24', '2026-01-21 11:15:24'),
(50, '9895656465', '2840', 1, '2026-01-21 12:07:41', '2026-01-21 12:05:41'),
(51, '9808559632', '7494', 1, '2026-01-21 12:57:00', '2026-01-21 12:55:00'),
(52, '9808559632', '2237', 1, '2026-01-21 12:58:15', '2026-01-21 12:56:15'),
(53, '5655655989', '8817', 1, '2026-01-21 17:13:27', '2026-01-21 17:11:27'),
(54, '6652232265', '1202', 1, '2026-01-21 17:24:28', '2026-01-21 17:22:28'),
(55, '9879543210', '4144', 0, '2026-01-22 09:45:47', '2026-01-22 09:43:47'),
(56, '9876543210', '6902', 1, '2026-01-22 09:49:37', '2026-01-22 09:47:37'),
(57, '9876543211', '4008', 1, '2026-01-22 09:54:16', '2026-01-22 09:52:16'),
(58, '9876543210', '1111', 0, '2026-01-22 10:07:12', '2026-01-22 10:05:12'),
(59, '8423953286', '6197', 1, '2026-01-22 10:08:58', '2026-01-22 10:06:58'),
(60, '9876543211', '1111', 0, '2026-01-22 10:10:00', '2026-01-22 10:08:00'),
(61, '9876543210', '1111', 0, '2026-01-22 11:02:34', '2026-01-22 11:00:34'),
(62, '8303204543', '5694', 1, '2026-01-22 12:43:22', '2026-01-22 12:41:22'),
(63, '9876543211', '1111', 0, '2026-01-22 13:32:22', '2026-01-22 13:30:22'),
(64, '9876543210', '1111', 0, '2026-01-22 13:36:41', '2026-01-22 13:34:41'),
(65, '7705827321', '6652', 1, '2026-01-22 15:01:30', '2026-01-22 14:59:30'),
(66, '8757315025', '5660', 0, '2026-01-22 16:17:05', '2026-01-22 16:15:05'),
(67, '8757315025', '8059', 0, '2026-01-22 16:18:55', '2026-01-22 16:16:55'),
(68, '7705827321', '3989', 1, '2026-01-22 17:35:09', '2026-01-22 17:33:09'),
(69, '9876543211', '1111', 0, '2026-01-22 18:07:07', '2026-01-22 18:05:07'),
(70, '8423953286', '3113', 1, '2026-01-22 18:19:46', '2026-01-22 18:17:46'),
(71, '8423953286', '9542', 1, '2026-01-22 18:20:29', '2026-01-22 18:18:29'),
(72, '8423953286', '7085', 1, '2026-01-22 18:21:42', '2026-01-22 18:19:42'),
(73, '9876543210', '1111', 0, '2026-01-22 18:23:30', '2026-01-22 18:21:30'),
(74, '9876543211', '1111', 0, '2026-01-22 18:23:57', '2026-01-22 18:21:57'),
(75, '8423953286', '1111', 0, '2026-01-23 09:23:12', '2026-01-23 09:21:12'),
(76, '8423953286', '6155', 0, '2026-01-23 09:23:20', '2026-01-23 09:21:20'),
(77, '8423953286', '9258', 1, '2026-01-23 09:25:44', '2026-01-23 09:23:44'),
(78, '8423953286', '1867', 1, '2026-01-23 09:29:34', '2026-01-23 09:27:34'),
(79, '7800764914', '7544', 1, '2026-01-23 09:30:40', '2026-01-23 09:28:40'),
(80, '8423953286', '6905', 1, '2026-01-23 09:30:51', '2026-01-23 09:28:51'),
(81, '7458946942', '3350', 1, '2026-01-23 10:03:28', '2026-01-23 10:01:28'),
(82, '7570006440', '7667', 1, '2026-01-23 10:03:41', '2026-01-23 10:01:41'),
(83, '9140183315', '4896', 1, '2026-01-23 10:52:57', '2026-01-23 10:50:57'),
(84, '9876543210', '1111', 0, '2026-01-23 11:28:37', '2026-01-23 11:26:37'),
(85, '9208339102', '5884', 1, '2026-01-23 11:46:08', '2026-01-23 11:44:08'),
(86, '7570006440', '1772', 1, '2026-01-23 12:03:30', '2026-01-23 12:01:30'),
(87, '6532256535', '4328', 1, '2026-01-23 12:05:03', '2026-01-23 12:03:03'),
(88, '7570006440', '3353', 1, '2026-01-23 12:14:49', '2026-01-23 12:12:49'),
(89, '7570006440', '3418', 1, '2026-01-23 12:18:44', '2026-01-23 12:16:44'),
(90, '7570006440', '4532', 0, '2026-01-23 12:19:02', '2026-01-23 12:17:02'),
(91, '7570006440', '4947', 1, '2026-01-23 12:19:34', '2026-01-23 12:17:34'),
(92, '7570006440', '7643', 0, '2026-01-23 12:30:46', '2026-01-23 12:28:46'),
(93, '7570006440', '5301', 1, '2026-01-23 12:31:25', '2026-01-23 12:29:25'),
(94, '7705827321', '1931', 0, '2026-01-23 13:13:33', '2026-01-23 13:11:33'),
(95, '7705827321', '5172', 1, '2026-01-23 13:14:29', '2026-01-23 13:12:29'),
(96, '7705827321', '3660', 0, '2026-01-23 13:26:28', '2026-01-23 13:24:28'),
(97, '7705827321', '6305', 1, '2026-01-23 13:26:55', '2026-01-23 13:24:55'),
(98, '7705827321', '9841', 1, '2026-01-23 13:35:45', '2026-01-23 13:33:45'),
(99, '7235947667', '1209', 1, '2026-01-23 13:39:29', '2026-01-23 13:37:29'),
(100, '9651511938', '3751', 1, '2026-01-23 13:40:42', '2026-01-23 13:38:42'),
(101, '9651511938', '5000', 1, '2026-01-23 13:50:06', '2026-01-23 13:48:06'),
(102, '7705827321', '2364', 1, '2026-01-23 13:50:46', '2026-01-23 13:48:46'),
(103, '9559960255', '5041', 1, '2026-01-23 14:20:11', '2026-01-23 14:18:11'),
(104, '7705827321', '1286', 1, '2026-01-23 15:23:28', '2026-01-23 15:21:28'),
(105, '7258836052', '2184', 1, '2026-01-23 15:51:40', '2026-01-23 15:49:40'),
(106, '7258836052', '8128', 1, '2026-01-23 15:52:36', '2026-01-23 15:50:36'),
(107, '8423953286', '8100', 1, '2026-01-23 16:22:00', '2026-01-23 16:20:00'),
(108, '8423953286', '5764', 1, '2026-01-23 16:23:25', '2026-01-23 16:21:25'),
(109, '8423953286', '6035', 1, '2026-01-23 16:25:23', '2026-01-23 16:23:23'),
(110, '9876543211', '1111', 0, '2026-01-23 16:55:55', '2026-01-23 16:53:55'),
(111, '8423953286', '1028', 1, '2026-01-23 18:03:10', '2026-01-23 18:01:10'),
(112, '5656532598', '5669', 1, '2026-01-23 23:33:28', '2026-01-23 23:31:28'),
(113, '9636962851', '4915', 1, '2026-01-23 23:56:18', '2026-01-23 23:54:18'),
(114, '6565689598', '1198', 1, '2026-01-24 00:09:32', '2026-01-24 00:07:32'),
(115, '9876543210', '1111', 0, '2026-01-24 00:20:04', '2026-01-24 00:18:04'),
(116, '9876543211', '1111', 0, '2026-01-24 00:45:32', '2026-01-24 00:43:32'),
(117, '9876543210', '1111', 0, '2026-01-24 00:47:09', '2026-01-24 00:45:09'),
(118, '9876543211', '1111', 0, '2026-01-24 00:53:55', '2026-01-24 00:51:55'),
(119, '8303204543', '5229', 1, '2026-01-24 09:01:09', '2026-01-24 08:59:09'),
(120, '9876543211', '1111', 0, '2026-01-24 09:53:47', '2026-01-24 09:51:47'),
(121, '9876543210', '1111', 0, '2026-01-24 13:02:50', '2026-01-24 13:00:50'),
(122, '9876543210', '1111', 0, '2026-01-24 13:22:18', '2026-01-24 13:20:18'),
(123, '9876543211', '1111', 0, '2026-01-24 13:22:43', '2026-01-24 13:20:43'),
(124, '9876543210', '1111', 0, '2026-01-24 16:53:17', '2026-01-24 16:51:17'),
(125, '9506438531', '5557', 1, '2026-01-24 20:51:02', '2026-01-24 20:49:02'),
(126, '7705827321', '4843', 1, '2026-01-25 18:28:00', '2026-01-25 18:26:00'),
(127, '8173077880', '1079', 1, '2026-01-25 18:29:41', '2026-01-25 18:27:41'),
(128, '8303204543', '2687', 1, '2026-01-25 20:40:49', '2026-01-25 20:38:49'),
(129, '7705827321', '8317', 1, '2026-01-26 10:11:02', '2026-01-26 10:09:02'),
(130, '7705827321', '5131', 1, '2026-01-26 10:12:33', '2026-01-26 10:10:33'),
(131, '8303204543', '4270', 1, '2026-01-26 10:35:57', '2026-01-26 10:33:57'),
(132, '7705017444', '8815', 1, '2026-01-26 11:07:27', '2026-01-26 11:05:27'),
(133, '9876543210', '1111', 0, '2026-01-26 11:09:09', '2026-01-26 11:07:09'),
(134, '9876543210', '1111', 0, '2026-01-26 11:39:01', '2026-01-26 11:37:01'),
(135, '9876543210', '1111', 0, '2026-01-26 15:33:47', '2026-01-26 15:31:47'),
(136, '9876543210', '1111', 0, '2026-01-26 16:37:01', '2026-01-26 16:35:01'),
(137, '7705827321', '1560', 1, '2026-01-26 16:44:58', '2026-01-26 16:42:58'),
(138, '9651511938', '5541', 1, '2026-01-26 22:06:04', '2026-01-26 22:04:04'),
(139, '8303204543', '3447', 1, '2026-01-27 11:26:55', '2026-01-27 11:24:55'),
(140, '9559960255', '2087', 1, '2026-01-27 13:02:11', '2026-01-27 13:00:11'),
(141, '8604396064', '2712', 1, '2026-01-27 13:52:15', '2026-01-27 13:50:15'),
(142, '9651511938', '9849', 1, '2026-01-27 20:05:29', '2026-01-27 20:03:29'),
(143, '7705827321', '6537', 1, '2026-01-27 20:10:07', '2026-01-27 20:08:07'),
(144, '9559960255', '6731', 1, '2026-01-28 11:07:50', '2026-01-28 11:05:50'),
(145, '9651511938', '7480', 0, '2026-01-28 12:15:49', '2026-01-28 12:13:49'),
(146, '9876543211', '1111', 0, '2026-01-28 12:16:09', '2026-01-28 12:14:09'),
(147, '9651511938', '3266', 0, '2026-01-28 12:17:55', '2026-01-28 12:15:55'),
(148, '9651511938', '9559', 1, '2026-01-28 12:18:18', '2026-01-28 12:16:18'),
(149, '7705827321', '4601', 1, '2026-01-28 12:21:08', '2026-01-28 12:19:08'),
(150, '9876543210', '1111', 0, '2026-01-28 12:54:41', '2026-01-28 12:52:41'),
(151, '8423953286', '3180', 1, '2026-01-28 13:25:30', '2026-01-28 13:23:30'),
(152, '9651511938', '9425', 1, '2026-01-28 13:40:13', '2026-01-28 13:38:13'),
(153, '9876543210', '1111', 0, '2026-01-29 09:58:04', '2026-01-29 09:56:04'),
(154, '9876543211', '1111', 0, '2026-01-29 09:59:10', '2026-01-29 09:57:10'),
(155, '9876543210', '1111', 0, '2026-01-29 11:42:17', '2026-01-29 11:40:17'),
(156, '9876543210', '1111', 0, '2026-01-29 13:02:09', '2026-01-29 13:00:09'),
(157, '9876543210', '1111', 0, '2026-01-29 13:12:14', '2026-01-29 13:10:14'),
(158, '9876543210', '1111', 0, '2026-01-29 13:46:55', '2026-01-29 13:44:55'),
(159, '9219180433', '8494', 0, '2026-01-29 14:54:53', '2026-01-29 14:52:53'),
(160, '9876543210', '1111', 0, '2026-01-29 15:04:57', '2026-01-29 15:02:57'),
(161, '9876543211', '1111', 0, '2026-01-29 15:40:59', '2026-01-29 15:38:59'),
(162, '9876543210', '1111', 0, '2026-01-30 09:29:24', '2026-01-30 09:27:24'),
(163, '9876543210', '1111', 0, '2026-01-30 12:30:32', '2026-01-30 12:28:32'),
(164, '9651511938', '3777', 1, '2026-01-30 13:12:50', '2026-01-30 13:10:50'),
(165, '9876543210', '1111', 0, '2026-01-30 17:54:00', '2026-01-30 17:52:00'),
(166, '8423953286', '3144', 1, '2026-01-30 20:55:35', '2026-01-30 20:53:35'),
(167, '8423953286', '1368', 1, '2026-01-30 21:00:19', '2026-01-30 20:58:19'),
(168, '8423953286', '4201', 1, '2026-01-30 21:02:02', '2026-01-30 21:00:02'),
(169, '8423953286', '4385', 1, '2026-01-30 21:02:18', '2026-01-30 21:00:18'),
(170, '8423953286', '4834', 1, '2026-01-30 21:03:31', '2026-01-30 21:01:31'),
(171, '8423953286', '2483', 1, '2026-01-30 21:05:38', '2026-01-30 21:03:38'),
(172, '8423953286', '8062', 1, '2026-01-30 21:07:30', '2026-01-30 21:05:30'),
(173, '9876543211', '1111', 0, '2026-01-31 11:16:14', '2026-01-31 11:14:14'),
(174, '9879543211', '8509', 0, '2026-01-31 12:06:59', '2026-01-31 12:04:59'),
(175, '9876543211', '1111', 0, '2026-01-31 12:07:19', '2026-01-31 12:05:19'),
(176, '9876543211', '1111', 0, '2026-01-31 12:43:56', '2026-01-31 12:41:56'),
(177, '9876543210', '1111', 0, '2026-01-31 12:47:04', '2026-01-31 12:45:04'),
(178, '8381969475', '2091', 1, '2026-02-01 16:14:27', '2026-02-01 16:12:27'),
(179, '9651511938', '5260', 1, '2026-02-03 10:04:31', '2026-02-03 10:02:31'),
(180, '9651511938', '5093', 1, '2026-02-04 11:58:50', '2026-02-04 11:56:50'),
(181, '9876543210', '1111', 0, '2026-02-06 13:29:17', '2026-02-06 13:27:17'),
(182, '9876543210', '1111', 0, '2026-02-06 14:58:13', '2026-02-06 14:56:13'),
(183, '9876543210', '1111', 0, '2026-02-06 15:22:36', '2026-02-06 15:20:36'),
(184, '9876543211', '1111', 0, '2026-02-06 17:09:31', '2026-02-06 17:07:31'),
(185, '9876543210', '1111', 0, '2026-02-06 17:21:36', '2026-02-06 17:19:36'),
(186, '9876543211', '1111', 0, '2026-02-06 17:47:12', '2026-02-06 17:45:12'),
(187, '9876543210', '1111', 0, '2026-02-06 17:49:01', '2026-02-06 17:47:01'),
(188, '9876543211', '1111', 0, '2026-02-06 17:55:01', '2026-02-06 17:53:01'),
(189, '9876543210', '1111', 0, '2026-02-06 18:04:28', '2026-02-06 18:02:28'),
(190, '9876543210', '1111', 0, '2026-02-09 12:36:10', '2026-02-09 12:34:10'),
(191, '9876543210', '1111', 0, '2026-02-09 12:44:58', '2026-02-09 12:42:58'),
(192, '9876543210', '1111', 0, '2026-02-09 15:36:56', '2026-02-09 15:34:56'),
(193, '9876543210', '1111', 0, '2026-02-09 15:50:01', '2026-02-09 15:48:01'),
(194, '9876543211', '1111', 0, '2026-02-09 15:50:18', '2026-02-09 15:48:18'),
(195, '9876543211', '1111', 0, '2026-02-09 17:34:43', '2026-02-09 17:32:43'),
(196, '9876543211', '1111', 0, '2026-02-09 18:03:55', '2026-02-09 18:01:55'),
(197, '9876543211', '1111', 0, '2026-02-09 18:33:19', '2026-02-09 18:31:19'),
(198, '9876543210', '1111', 0, '2026-02-09 18:37:11', '2026-02-09 18:35:11'),
(199, '9876543211', '1111', 0, '2026-02-09 18:37:27', '2026-02-09 18:35:27'),
(200, '8303204543', '4313', 1, '2026-02-10 09:30:23', '2026-02-10 09:28:23'),
(201, '8303204543', '7611', 1, '2026-02-10 09:44:28', '2026-02-10 09:42:28'),
(202, '9876543210', '1111', 0, '2026-02-10 10:16:39', '2026-02-10 10:14:39'),
(203, '9876543210', '1111', 0, '2026-02-10 10:46:42', '2026-02-10 10:44:42'),
(204, '9651511938', '9992', 1, '2026-02-10 12:57:42', '2026-02-10 12:55:42'),
(205, '9651511938', '4196', 1, '2026-02-10 12:58:43', '2026-02-10 12:56:43'),
(206, '9651511938', '3519', 1, '2026-02-10 13:10:43', '2026-02-10 13:08:43'),
(207, '8303204543', '7121', 1, '2026-02-10 19:05:04', '2026-02-10 19:03:04'),
(208, '8173006663', '5478', 1, '2026-02-10 21:10:05', '2026-02-10 21:08:05'),
(209, '8948417974', '5361', 1, '2026-02-11 20:31:02', '2026-02-11 20:29:02'),
(210, '9455512328', '4467', 1, '2026-02-11 20:31:40', '2026-02-11 20:29:40'),
(211, '7705827321', '3866', 1, '2026-02-12 08:56:09', '2026-02-12 08:54:09'),
(212, '9208339102', '4603', 1, '2026-02-12 09:11:09', '2026-02-12 09:09:09'),
(213, '8303204543', '9566', 1, '2026-02-12 09:16:49', '2026-02-12 09:14:49'),
(214, '8303204543', '6782', 1, '2026-02-12 09:18:06', '2026-02-12 09:16:06'),
(215, '8423953286', '4015', 1, '2026-02-12 10:38:13', '2026-02-12 10:36:13'),
(216, '9876543210', '1111', 0, '2026-02-12 10:39:57', '2026-02-12 10:37:57'),
(217, '9636962851', '9078', 1, '2026-02-12 10:45:01', '2026-02-12 10:43:01'),
(218, '9636962851', '3491', 1, '2026-02-12 10:48:12', '2026-02-12 10:46:12'),
(219, '8303204543', '1945', 1, '2026-02-12 11:48:30', '2026-02-12 11:46:30'),
(220, '8303204543', '8600', 1, '2026-02-12 11:49:40', '2026-02-12 11:47:40'),
(221, '7705020474', '7170', 1, '2026-02-13 10:22:42', '2026-02-13 10:20:42'),
(222, '7705018444', '4613', 1, '2026-02-13 10:36:35', '2026-02-13 10:34:35'),
(223, '7705020474', '3463', 1, '2026-02-13 10:41:33', '2026-02-13 10:39:33'),
(224, '7705020474', '4165', 1, '2026-02-13 16:10:46', '2026-02-13 16:08:46'),
(225, '6200629758', '9385', 1, '2026-02-13 20:07:21', '2026-02-13 20:05:21'),
(226, '9559960255', '1477', 1, '2026-02-13 21:21:23', '2026-02-13 21:19:23'),
(227, '6200629758', '5395', 1, '2026-02-13 21:55:34', '2026-02-13 21:53:34'),
(228, '9876543210', '1111', 0, '2026-02-14 14:44:36', '2026-02-14 14:42:36'),
(229, '9876543211', '1111', 0, '2026-02-14 14:44:41', '2026-02-14 14:42:41'),
(230, '8303204543', '8817', 0, '2026-02-14 16:04:31', '2026-02-14 16:02:31'),
(231, '8303204543', '6416', 0, '2026-02-14 16:05:50', '2026-02-14 16:03:50'),
(232, '8303204543', '6998', 0, '2026-02-14 16:09:54', '2026-02-14 16:07:54'),
(233, '8303204543', '1658', 0, '2026-02-14 16:12:17', '2026-02-14 16:10:17'),
(234, '8303204543', '7164', 0, '2026-02-14 16:14:00', '2026-02-14 16:12:00'),
(235, '8303204543', '8504', 0, '2026-02-14 16:17:03', '2026-02-14 16:15:03'),
(236, '9208339102', '9655', 1, '2026-02-14 16:42:19', '2026-02-14 16:40:19'),
(237, '8303204543', '7830', 0, '2026-02-14 17:08:52', '2026-02-14 17:06:52'),
(238, '8303204543', '3963', 0, '2026-02-14 17:15:52', '2026-02-14 17:13:52'),
(239, '7063385801', '5665', 1, '2026-02-14 18:13:02', '2026-02-14 18:11:02'),
(240, '8303204543', '8370', 0, '2026-02-14 18:27:50', '2026-02-14 18:25:50'),
(241, '8303204543', '6717', 1, '2026-02-14 18:36:11', '2026-02-14 18:34:11'),
(242, '9559960255', '8673', 1, '2026-02-14 19:20:02', '2026-02-14 19:18:02'),
(243, '7705827321', '2310', 1, '2026-02-14 19:42:17', '2026-02-14 19:40:17'),
(244, '9559960255', '8679', 1, '2026-02-14 19:49:46', '2026-02-14 19:47:46'),
(245, '7705827321', '8731', 1, '2026-02-14 20:04:22', '2026-02-14 20:02:22'),
(246, '8604396064', '8033', 1, '2026-02-14 22:04:22', '2026-02-14 22:02:22'),
(247, '7365036744', '3854', 1, '2026-02-15 10:37:13', '2026-02-15 10:35:13'),
(248, '8957315025', '4424', 1, '2026-02-15 14:17:28', '2026-02-15 14:15:28'),
(249, '6299249539', '5633', 1, '2026-02-15 20:22:03', '2026-02-15 20:20:03'),
(250, '9876543210', '1111', 0, '2026-02-16 09:59:31', '2026-02-16 09:57:31'),
(251, '9876543210', '1111', 0, '2026-02-16 10:00:27', '2026-02-16 09:58:27'),
(252, '9876543210', '1111', 0, '2026-02-16 10:02:05', '2026-02-16 10:00:05'),
(253, '9559960255', '2669', 1, '2026-02-16 10:36:34', '2026-02-16 10:34:34'),
(254, '9876543210', '1111', 0, '2026-02-16 10:51:25', '2026-02-16 10:49:25'),
(255, '9876543210', '1111', 0, '2026-02-17 08:37:37', '2026-02-17 08:35:37'),
(256, '7705827321', '9229', 1, '2026-02-17 09:18:51', '2026-02-17 09:16:51'),
(257, '9559960255', '9549', 0, '2026-02-18 15:20:41', '2026-02-18 15:18:41'),
(258, '9559960255', '5786', 0, '2026-02-18 15:21:03', '2026-02-18 15:19:03'),
(259, '9559960255', '2891', 0, '2026-02-18 15:22:58', '2026-02-18 15:20:58'),
(260, '9559960255', '6304', 0, '2026-02-18 17:37:10', '2026-02-18 17:35:10'),
(261, '7705827321', '2949', 0, '2026-02-18 18:12:55', '2026-02-18 18:10:55'),
(262, '7705827321', '5976', 1, '2026-02-18 18:13:18', '2026-02-18 18:11:18'),
(263, '9559960255', '6902', 0, '2026-02-18 18:16:30', '2026-02-18 18:14:30'),
(264, '9559960255', '9740', 1, '2026-02-18 18:18:49', '2026-02-18 18:16:49'),
(265, '7705827321', '4842', 1, '2026-02-18 18:51:10', '2026-02-18 18:49:10'),
(266, '9876543210', '1111', 0, '2026-02-19 09:36:25', '2026-02-19 09:34:25'),
(267, '9876543211', '1111', 0, '2026-02-19 10:00:55', '2026-02-19 09:58:55'),
(268, '9876543210', '1111', 0, '2026-02-19 10:06:31', '2026-02-19 10:04:31'),
(269, '9876543210', '1111', 0, '2026-02-19 10:33:22', '2026-02-19 10:31:22'),
(270, '9876543211', '1111', 0, '2026-02-19 10:34:56', '2026-02-19 10:32:56'),
(271, '9876543210', '1111', 0, '2026-02-19 10:54:33', '2026-02-19 10:52:33'),
(272, '9876543210', '1111', 0, '2026-02-19 11:56:53', '2026-02-19 11:54:53'),
(273, '8303204543', '2561', 1, '2026-02-20 08:59:03', '2026-02-20 08:57:03'),
(274, '8303204543', '1410', 1, '2026-02-20 09:01:24', '2026-02-20 08:59:24'),
(275, '9129565346', '8258', 1, '2026-02-20 10:57:50', '2026-02-20 10:55:50'),
(276, '9876543210', '1111', 0, '2026-02-20 15:12:59', '2026-02-20 15:10:59'),
(277, '9876543210', '1111', 0, '2026-02-20 15:18:54', '2026-02-20 15:16:54'),
(278, '9876543210', '1111', 0, '2026-02-20 15:22:20', '2026-02-20 15:20:20'),
(279, '6306061852', '6800', 1, '2026-02-20 21:20:57', '2026-02-20 21:18:57'),
(280, '1234567890', '3232', 0, '2026-02-21 01:52:44', '2026-02-21 01:50:44'),
(281, '1234567890', '6733', 0, '2026-02-21 01:54:43', '2026-02-21 01:52:43'),
(282, '1234567890', '6763', 0, '2026-02-21 01:54:57', '2026-02-21 01:52:57'),
(283, '9208399102', '5767', 0, '2026-02-21 09:21:20', '2026-02-21 09:19:20'),
(284, '9208339102', '1010', 1, '2026-02-21 09:21:47', '2026-02-21 09:19:47'),
(285, '9208339102', '6767', 1, '2026-02-21 09:28:08', '2026-02-21 09:26:08'),
(286, '9208339102', '6431', 1, '2026-02-21 09:35:38', '2026-02-21 09:33:38'),
(287, '9208339102', '8625', 1, '2026-02-21 09:45:26', '2026-02-21 09:43:26'),
(288, '9208339102', '5409', 0, '2026-02-21 09:52:46', '2026-02-21 09:50:46'),
(289, '8090666407', '2426', 1, '2026-02-21 09:53:28', '2026-02-21 09:51:28'),
(290, '9208339102', '9047', 1, '2026-02-21 10:01:02', '2026-02-21 09:59:02'),
(291, '8090666407', '2344', 1, '2026-02-21 10:16:17', '2026-02-21 10:14:17'),
(292, '7705827321', '8562', 1, '2026-02-21 15:37:09', '2026-02-21 15:35:09'),
(293, '7705827321', '7261', 1, '2026-02-21 15:38:41', '2026-02-21 15:36:41'),
(294, '9876543210', '1111', 0, '2026-02-21 17:24:34', '2026-02-21 17:22:34'),
(295, '9876543210', '1111', 0, '2026-02-21 17:49:38', '2026-02-21 17:47:38'),
(296, '9559960255', '6611', 1, '2026-02-21 18:04:28', '2026-02-21 18:02:28'),
(297, '9876543210', '1111', 0, '2026-02-21 21:24:04', '2026-02-21 21:22:04'),
(298, '9876543211', '1111', 0, '2026-02-22 08:59:51', '2026-02-22 08:57:51'),
(299, '9876543210', '1111', 0, '2026-02-22 09:00:34', '2026-02-22 08:58:34'),
(300, '1234567890', '8634', 0, '2026-02-22 17:52:45', '2026-02-22 17:50:45'),
(301, '9580056250', '1455', 0, '2026-02-22 21:02:21', '2026-02-22 21:00:21'),
(302, '9580056250', '8217', 0, '2026-02-22 21:04:53', '2026-02-22 21:02:53'),
(303, '9795755998', '8826', 0, '2026-02-23 09:10:40', '2026-02-23 09:08:40'),
(304, '9651511938', '4367', 1, '2026-02-23 16:54:01', '2026-02-23 16:52:01'),
(305, '9651511938', '9638', 1, '2026-02-23 19:24:41', '2026-02-23 19:22:41'),
(306, '9580056250', '2399', 1, '2026-02-23 21:07:42', '2026-02-23 21:05:42'),
(307, '7705827321', '3705', 1, '2026-02-24 09:55:35', '2026-02-24 09:53:35'),
(308, '8090666407', '4222', 1, '2026-02-24 10:57:01', '2026-02-24 10:55:01'),
(309, '9565789026', '4989', 1, '2026-02-24 11:17:12', '2026-02-24 11:15:12'),
(310, '9651511938', '4182', 1, '2026-02-24 11:31:45', '2026-02-24 11:29:45'),
(311, '7705827321', '6213', 1, '2026-02-24 14:23:18', '2026-02-24 14:21:18'),
(312, '7705827321', '8981', 0, '2026-02-24 14:23:36', '2026-02-24 14:21:36'),
(313, '7705827321', '7568', 1, '2026-02-24 14:24:29', '2026-02-24 14:22:29'),
(314, '9876543210', '1111', 0, '2026-02-24 16:05:13', '2026-02-24 16:03:13'),
(315, '9876543210', '1111', 0, '2026-02-24 16:06:37', '2026-02-24 16:04:37'),
(316, '8874420521', '5530', 1, '2026-02-24 19:11:04', '2026-02-24 19:09:04'),
(317, '7705827321', '1741', 1, '2026-02-24 21:19:28', '2026-02-24 21:17:28'),
(318, '9721107123', '2376', 1, '2026-02-24 23:58:09', '2026-02-24 23:56:09'),
(319, '9721107123', '6589', 1, '2026-02-25 00:04:05', '2026-02-25 00:02:05'),
(320, '9876543210', '1111', 0, '2026-02-25 09:15:52', '2026-02-25 09:13:52'),
(321, '9651511938', '3792', 1, '2026-02-25 15:13:02', '2026-02-25 15:11:02'),
(322, '9599089358', '8018', 1, '2026-02-25 19:08:46', '2026-02-25 19:06:46'),
(323, '8090666407', '2897', 1, '2026-02-25 20:12:26', '2026-02-25 20:10:26'),
(324, '9519595231', '1967', 0, '2026-02-25 20:33:07', '2026-02-25 20:31:07'),
(325, '9519595231', '6307', 0, '2026-02-25 20:35:15', '2026-02-25 20:33:15'),
(326, '9519595231', '7530', 0, '2026-02-25 20:36:31', '2026-02-25 20:34:31'),
(327, '9876543210', '1111', 0, '2026-02-26 11:01:28', '2026-02-26 10:59:28'),
(328, '9876543210', '1111', 0, '2026-02-26 13:02:07', '2026-02-26 13:00:07'),
(329, '9876543210', '1111', 0, '2026-02-26 13:02:38', '2026-02-26 13:00:38'),
(330, '9876543211', '1111', 0, '2026-02-26 13:02:55', '2026-02-26 13:00:55'),
(331, '8740803396', '5922', 1, '2026-02-27 13:14:30', '2026-02-27 13:12:30'),
(332, '9559960255', '1939', 1, '2026-02-27 16:38:17', '2026-02-27 16:36:17'),
(333, '9565789026', '7335', 1, '2026-02-27 16:38:55', '2026-02-27 16:36:55'),
(334, '7054124397', '3955', 1, '2026-02-27 20:56:35', '2026-02-27 20:54:35'),
(335, '7054124397', '3179', 1, '2026-02-27 20:58:36', '2026-02-27 20:56:36'),
(336, '7705827321', '7969', 1, '2026-02-28 15:01:44', '2026-02-28 14:59:44'),
(337, '6393427244', '9372', 1, '2026-03-02 10:32:04', '2026-03-02 10:30:04'),
(338, '1234567890', '7625', 0, '2026-03-04 18:21:34', '2026-03-04 18:19:34'),
(339, '7705827321', '1852', 1, '2026-03-05 14:33:19', '2026-03-05 14:31:19'),
(340, '6393085442', '8314', 1, '2026-03-05 14:34:38', '2026-03-05 14:32:38'),
(341, '9559960255', '8406', 1, '2026-03-05 14:36:04', '2026-03-05 14:34:04'),
(342, '7705827321', '4601', 1, '2026-03-05 14:42:33', '2026-03-05 14:40:33'),
(343, '1234567890', '8600', 0, '2026-03-05 18:01:54', '2026-03-05 17:59:54'),
(344, '1234567890', '4897', 0, '2026-03-05 18:03:17', '2026-03-05 18:01:17'),
(345, '9794375816', '3569', 0, '2026-03-06 12:14:09', '2026-03-06 12:12:09'),
(346, '9794375816', '2450', 1, '2026-03-06 12:19:53', '2026-03-06 12:17:53'),
(347, '9794116633', '3228', 1, '2026-03-06 16:29:12', '2026-03-06 16:27:12'),
(348, '9794116633', '2381', 1, '2026-03-06 16:34:27', '2026-03-06 16:32:27'),
(349, '9559960255', '2573', 1, '2026-03-06 16:57:16', '2026-03-06 16:55:16'),
(350, '7705827321', '3233', 1, '2026-03-06 20:07:33', '2026-03-06 20:05:33'),
(351, '9721107123', '1156', 1, '2026-03-07 12:39:18', '2026-03-07 12:37:18'),
(352, '9990230532', '8976', 1, '2026-03-07 16:08:06', '2026-03-07 16:06:06'),
(353, '9794480196', '4723', 1, '2026-03-08 11:31:25', '2026-03-08 11:29:25'),
(354, '7705017444', '2698', 1, '2026-03-08 12:20:22', '2026-03-08 12:18:22'),
(355, '7307229576', '4090', 1, '2026-03-08 14:10:17', '2026-03-08 14:08:17'),
(356, '7238829360', '2628', 1, '2026-03-08 14:38:43', '2026-03-08 14:36:43'),
(357, '8127570413', '9391', 1, '2026-03-09 14:22:07', '2026-03-09 14:20:07'),
(358, '8127570413', '5909', 1, '2026-03-09 14:23:57', '2026-03-09 14:21:57'),
(359, '8127570413', '6657', 1, '2026-03-09 14:26:26', '2026-03-09 14:24:26'),
(360, '8127570413', '7974', 1, '2026-03-09 14:28:06', '2026-03-09 14:26:06'),
(361, '8127570413', '1095', 1, '2026-03-09 14:32:58', '2026-03-09 14:30:58'),
(362, '9133687768', '2112', 1, '2026-03-10 00:14:57', '2026-03-10 00:12:57'),
(363, '7705827321', '6268', 1, '2026-03-10 09:25:39', '2026-03-10 09:23:39'),
(364, '9651511938', '6734', 1, '2026-03-10 14:02:56', '2026-03-10 14:00:56'),
(365, '7897473239', '8269', 1, '2026-03-10 14:14:07', '2026-03-10 14:12:07'),
(366, '7393952737', '1628', 1, '2026-03-10 14:52:30', '2026-03-10 14:50:30'),
(367, '7393952737', '1185', 1, '2026-03-10 14:56:40', '2026-03-10 14:54:40'),
(368, '7393952737', '2910', 1, '2026-03-10 17:37:34', '2026-03-10 17:35:34'),
(369, '8856658777', '9758', 0, '2026-03-11 09:40:07', '2026-03-11 09:38:07'),
(370, '8840442287', '1353', 1, '2026-03-11 09:40:24', '2026-03-11 09:38:24'),
(371, '7355646015', '7318', 1, '2026-03-12 22:16:04', '2026-03-12 22:14:04'),
(372, '7705827321', '6585', 1, '2026-03-13 11:36:57', '2026-03-13 11:34:57'),
(373, '7705827321', '2737', 1, '2026-03-13 11:37:31', '2026-03-13 11:35:31');

-- --------------------------------------------------------

--
-- Table structure for table `paying`
--

CREATE TABLE `paying` (
  `id` int(11) NOT NULL,
  `service_order_id` int(11) DEFAULT NULL COMMENT 'NULL for wallet top-up or self wallet add',
  `user_id` int(11) DEFAULT NULL COMMENT 'Payment always done by user',
  `amount` decimal(10,2) DEFAULT NULL COMMENT 'Original amount',
  `platform_fee` varchar(150) DEFAULT NULL COMMENT 'Admin/Platform charges',
  `final_amount` decimal(10,2) DEFAULT NULL COMMENT 'Amount after fee deduction',
  `payment_type` tinyint(4) DEFAULT NULL COMMENT '1=online, 2=offline(cash), 3=wallet-payment, 4=self-wallet-add\r\n5 due wallet',
  `gateway_type` varchar(50) DEFAULT NULL COMMENT '''1=cashfree, 2=paytm''\r\n',
  `transaction_id` varchar(150) DEFAULT NULL COMMENT 'Gateway Transaction ID',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0=pending, 1=success, 2=failed',
  `module_type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1 for service booking \r\n2 for cab booking',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `paying`
--

INSERT INTO `paying` (`id`, `service_order_id`, `user_id`, `amount`, `platform_fee`, `final_amount`, `payment_type`, `gateway_type`, `transaction_id`, `status`, `module_type`, `created_at`, `updated_at`) VALUES
(132, 323, 3, 94.00, '7.5% - ₹7.05', 94.00, 2, NULL, NULL, 1, 2, '2026-02-06 15:30:28', '2026-02-06 15:30:28'),
(133, 53, 3, 499.00, '7.5% - ₹37.42', 461.58, 1, '1', 'ORD1770377888716', 1, 1, '2026-02-06 17:08:08', '2026-02-06 11:38:51'),
(134, 329, 3, 121.00, '7.5% - ₹9.07', 121.00, 2, NULL, NULL, 1, 2, '2026-02-06 17:23:32', '2026-02-06 17:23:32'),
(135, 54, 3, 588.82, '7.5% - ₹44.16', 544.66, 2, NULL, NULL, 1, 1, '2026-02-06 17:59:23', '2026-02-06 17:59:23'),
(136, 55, 4, 588.82, '7.5% - ₹44.16', 544.66, 2, NULL, NULL, 1, 1, '2026-02-09 16:13:21', '2026-02-09 16:13:21'),
(137, 366, 17, 1219.00, '6% - ₹73.14', 1145.86, 1, '1', 'ORD1770646593312', 1, 2, '2026-02-09 19:46:33', '2026-02-09 14:17:09'),
(138, 369, 17, 1236.00, '6% - ₹74.16', 1161.84, 1, '1', 'ORD1770647229012', 1, 2, '2026-02-09 19:57:09', '2026-02-09 14:27:47'),
(139, 371, 17, 377.00, '7.5% - ₹28.27', 377.00, 2, NULL, NULL, 1, 2, '2026-02-10 09:31:25', '2026-02-10 09:31:25'),
(140, 375, 17, 362.00, '7.5% - ₹27.15', 362.00, 2, NULL, NULL, 1, 2, '2026-02-10 09:36:24', '2026-02-10 09:36:24'),
(141, 382, 20, 119.00, '6% - ₹7.14', 111.86, 1, '1', 'ORD1770697194269', 0, 2, '2026-02-10 09:49:54', '2026-02-10 09:49:54'),
(142, 382, 20, 119.00, '6% - ₹7.14', 111.86, 1, '1', 'ORD1770697220919', 1, 2, '2026-02-10 09:50:20', '2026-02-10 04:21:17'),
(143, 383, 20, 184.00, '7.5% - ₹13.80', 184.00, 2, NULL, NULL, 1, 2, '2026-02-10 09:53:19', '2026-02-10 09:53:19'),
(144, 384, 17, 130.00, '7.5% - ₹9.75', 130.00, 2, NULL, NULL, 1, 2, '2026-02-10 10:15:52', '2026-02-10 10:15:52'),
(145, 387, 17, 1236.00, '7.5% - ₹92.70', 1236.00, 2, NULL, NULL, 1, 2, '2026-02-10 10:18:29', '2026-02-10 10:18:29'),
(146, 388, 3, 121.00, '7.5% - ₹9.07', 121.00, 2, NULL, NULL, 1, 2, '2026-02-10 10:19:31', '2026-02-10 10:19:31'),
(147, 390, 20, 120.00, '7.5% - ₹9.00', 120.00, 2, NULL, NULL, 1, 2, '2026-02-10 10:25:36', '2026-02-10 10:25:36'),
(148, 391, 20, 120.00, '7.5% - ₹9.00', 120.00, 2, NULL, NULL, 1, 2, '2026-02-10 10:28:12', '2026-02-10 10:28:12'),
(149, 394, 20, 82.00, '7.5% - ₹6.15', 82.00, 2, NULL, NULL, 1, 2, '2026-02-10 10:33:03', '2026-02-10 10:33:03'),
(150, 395, 20, 158.00, '7.5% - ₹11.85', 158.00, 2, NULL, NULL, 1, 2, '2026-02-10 10:36:04', '2026-02-10 10:36:04'),
(151, 397, 17, 1236.00, '7.5% - ₹92.70', 1236.00, 2, NULL, NULL, 1, 2, '2026-02-10 10:40:40', '2026-02-10 10:40:40'),
(152, 414, 17, 270.00, '7.5% - ₹20.25', 270.00, 2, NULL, NULL, 1, 2, '2026-02-10 14:40:54', '2026-02-10 14:40:54'),
(153, 417, 17, 384.00, '7.5% - ₹28.80', 384.00, 2, NULL, NULL, 1, 2, '2026-02-10 14:50:08', '2026-02-10 14:50:08'),
(154, 421, 20, 84.00, '7.5% - ₹6.30', 84.00, 2, NULL, NULL, 1, 2, '2026-02-10 15:55:45', '2026-02-10 15:55:45'),
(155, 426, 17, 500.00, '7.5% - ₹37.50', 500.00, 2, NULL, NULL, 1, 2, '2026-02-10 18:15:46', '2026-02-10 18:15:46'),
(156, 427, 17, 521.00, '7.5% - ₹39.08', 521.00, 2, NULL, NULL, 1, 2, '2026-02-10 18:18:03', '2026-02-10 18:18:03'),
(157, 429, 17, 1229.00, '7.5% - ₹92.17', 1229.00, 2, NULL, NULL, 1, 2, '2026-02-10 18:37:14', '2026-02-10 18:37:14'),
(158, 430, 17, 511.00, '6% - ₹30.66', 480.34, 1, '1', 'ORD1770728936433', 1, 2, '2026-02-10 18:38:56', '2026-02-10 13:09:34'),
(159, 431, 17, 511.00, '7.5% - ₹38.33', 511.00, 2, NULL, NULL, 1, 2, '2026-02-10 18:41:00', '2026-02-10 18:41:00'),
(160, 432, 17, 511.00, '7.5% - ₹38.33', 511.00, 2, NULL, NULL, 1, 2, '2026-02-10 18:42:55', '2026-02-10 18:42:55'),
(161, 435, 17, 1080.00, '7.5% - ₹81.00', 1080.00, 2, NULL, NULL, 1, 2, '2026-02-10 18:48:49', '2026-02-10 18:48:49'),
(162, 442, 17, 1234.00, '7.5% - ₹92.55', 1234.00, 2, NULL, NULL, 1, 2, '2026-02-10 19:15:51', '2026-02-10 19:15:51'),
(163, 447, 17, 1236.00, '7.5% - ₹92.70', 1236.00, 2, NULL, NULL, 1, 2, '2026-02-10 20:08:35', '2026-02-10 20:08:35'),
(164, 449, 17, 1236.00, '7.5% - ₹92.70', 1236.00, 2, NULL, NULL, 1, 2, '2026-02-10 20:11:25', '2026-02-10 20:11:25'),
(165, 459, 38, 386.00, '6% - ₹23.16', 362.84, 1, '1', 'ORD1770738365741', 0, 2, '2026-02-10 21:16:05', '2026-02-10 21:16:05'),
(166, 462, 17, 1143.00, '6% - ₹68.58', 1074.42, 1, '1', 'ORD1770744527352', 0, 2, '2026-02-10 22:58:47', '2026-02-10 22:58:47'),
(167, 462, 17, 1143.00, '6% - ₹68.58', 1074.42, 1, '1', 'ORD1770744825897', 0, 2, '2026-02-10 23:03:45', '2026-02-10 23:03:45'),
(168, 462, 17, 1143.00, '6% - ₹68.58', 1074.42, 1, '1', 'ORD1770786087925', 1, 2, '2026-02-11 10:31:27', '2026-02-11 05:01:50'),
(169, 467, 39, 197.00, '7.5% - ₹14.78', 197.00, 2, NULL, NULL, 1, 2, '2026-02-11 20:31:28', '2026-02-11 20:31:28'),
(170, 468, 40, 197.00, '7.5% - ₹14.78', 197.00, 2, NULL, NULL, 1, 2, '2026-02-11 20:34:57', '2026-02-11 20:34:57'),
(171, 498, 17, 1234.00, '7.5% - ₹92.55', 1234.00, 2, NULL, NULL, 1, 2, '2026-02-13 20:51:19', '2026-02-13 20:51:19'),
(172, 502, 20, 143.00, '7.5% - ₹10.72', 143.00, 2, NULL, NULL, 1, 2, '2026-02-14 17:40:45', '2026-02-14 17:40:45'),
(173, 522, 17, 1232.00, '6% - ₹73.92', 1158.08, 1, '1', 'ORD1771079098468', 1, 2, '2026-02-14 19:54:58', '2026-02-14 14:25:31'),
(174, 530, 20, 120.00, '7.5% - ₹9.00', 120.00, 2, NULL, NULL, 1, 2, '2026-02-14 20:31:06', '2026-02-14 20:31:06'),
(175, 542, 15, 788.00, '6% - ₹47.28', 740.72, 1, '1', 'ORD1771087244305', 0, 2, '2026-02-14 22:10:44', '2026-02-14 22:10:44'),
(176, 542, 15, 788.00, '6% - ₹47.28', 740.72, 1, '1', 'ORD1771087508936', 0, 2, '2026-02-14 22:15:08', '2026-02-14 22:15:08'),
(177, 542, 15, 788.00, '7.5% - ₹59.10', 788.00, 2, NULL, NULL, 1, 2, '2026-02-14 22:16:18', '2026-02-14 22:16:18'),
(178, 545, 15, 4463.00, '7.5% - ₹334.73', 4463.00, 2, NULL, NULL, 1, 2, '2026-02-14 22:18:23', '2026-02-14 22:18:23'),
(179, NULL, 96, 1717.80, '0% - ₹0.00', 1717.80, 5, '1', 'ORD1771087809520', 0, 2, '2026-02-14 22:20:09', '2026-02-14 22:20:09'),
(180, 550, 17, 393.00, '7.5% - ₹29.48', 393.00, 2, NULL, NULL, 1, 2, '2026-02-15 11:47:35', '2026-02-15 11:47:35'),
(181, 554, 17, 1235.00, '7.5% - ₹92.63', 1235.00, 2, NULL, NULL, 1, 2, '2026-02-16 08:56:01', '2026-02-16 08:56:01'),
(182, NULL, 19, 316.80, '0% - ₹0.00', 316.80, 5, '1', 'ORD1771221217642', 0, 2, '2026-02-16 11:23:37', '2026-02-16 11:23:37'),
(183, NULL, 19, 316.80, '0% - ₹0.00', 316.80, 5, '1', 'ORD1771221224942', 0, 2, '2026-02-16 11:23:44', '2026-02-16 11:23:44'),
(184, NULL, 19, 316.80, '0% - ₹0.00', 316.80, 5, '1', 'ORD1771221459913', 0, 2, '2026-02-16 11:27:39', '2026-02-16 11:27:39'),
(185, NULL, 19, 316.80, '0% - ₹0.00', 316.80, 5, '1', 'ORD1771221552667', 0, 2, '2026-02-16 11:29:12', '2026-02-16 11:29:12'),
(186, NULL, 19, 316.80, '0% - ₹0.00', 316.80, 5, '1', 'ORD1771221667101', 0, 2, '2026-02-16 11:31:07', '2026-02-16 11:31:07'),
(187, NULL, 19, 316.80, '0% - ₹0.00', 316.80, 5, '1', 'ORD1771221803006', 1, 2, '2026-02-16 11:33:23', '2026-02-16 06:04:00'),
(188, 99, 18, 800.00, '7.5% - ₹60.00', 740.00, 1, '1', 'ORD1771240812364', 0, 1, '2026-02-16 16:50:12', '2026-02-16 16:50:12'),
(189, 99, 18, 800.00, '7.5% - ₹60.00', 740.00, 1, '1', 'ORD1771240898858', 1, 1, '2026-02-16 16:51:38', '2026-02-16 11:22:47'),
(190, 559, 18, 1236.00, '7.5% - ₹92.70', 1236.00, 2, NULL, NULL, 1, 2, '2026-02-16 17:01:45', '2026-02-16 17:01:45'),
(191, 560, 18, 351.00, '7.5% - ₹26.32', 351.00, 2, NULL, NULL, 1, 2, '2026-02-16 17:03:48', '2026-02-16 17:03:48'),
(192, 100, 18, 1100.00, '7.5% - ₹82.50', 1017.50, 1, '1', 'ORD1771242516151', 1, 1, '2026-02-16 17:18:36', '2026-02-16 11:51:55'),
(193, 566, 18, 5582.00, '7.5% - ₹418.65', 5582.00, 2, NULL, NULL, 1, 2, '2026-02-16 17:25:07', '2026-02-16 17:25:07'),
(194, 570, 18, 205.00, '7.5% - ₹15.38', 205.00, 2, NULL, NULL, 1, 2, '2026-02-18 14:59:45', '2026-02-18 14:59:45'),
(195, 578, 18, 264.00, '7.5% - ₹19.80', 264.00, 2, NULL, NULL, 1, 2, '2026-02-18 20:20:49', '2026-02-18 20:20:49'),
(196, 106, 3, 588.82, '7.5% - ₹44.16', 544.66, 2, NULL, NULL, 1, 1, '2026-02-19 10:02:17', '2026-02-19 10:02:17'),
(197, 579, 3, 121.00, '7.5% - ₹9.07', 121.00, 2, NULL, NULL, 1, 2, '2026-02-19 10:13:23', '2026-02-19 10:13:23'),
(198, 582, 3, 121.00, '7.5% - ₹9.07', 121.00, 2, NULL, NULL, 1, 2, '2026-02-19 11:09:32', '2026-02-19 11:09:32'),
(199, 590, 3, 116.00, '7.5% - ₹8.70', 116.00, 2, NULL, NULL, 1, 2, '2026-02-19 11:36:12', '2026-02-19 11:36:12'),
(200, 592, 3, 121.00, '6% - ₹7.26', 113.74, 1, '1', 'ORD1771482797151', 1, 2, '2026-02-19 12:03:17', '2026-02-19 06:33:53'),
(201, 600, 17, 1236.00, '7.5% - ₹92.70', 1236.00, 2, NULL, NULL, 1, 2, '2026-02-20 09:02:41', '2026-02-20 09:02:41'),
(202, 601, 17, 1295.00, '6% - ₹77.70', 1217.30, 1, '1', 'ORD1771558517908', 1, 2, '2026-02-20 09:05:17', '2026-02-20 03:35:56'),
(203, 604, 50, 513.00, '7.5% - ₹38.48', 513.00, 2, NULL, NULL, 1, 2, '2026-02-20 21:20:58', '2026-02-20 21:20:58'),
(204, 622, 3, 120.00, '7.5% - ₹9.00', 120.00, 2, NULL, NULL, 1, 2, '2026-02-21 17:56:03', '2026-02-21 17:56:03'),
(205, 110, 3, 499.00, '7.5% - ₹37.42', 461.58, 1, '1', 'ORD1771677591485', 1, 1, '2026-02-21 18:09:51', '2026-02-21 12:40:31'),
(206, 629, 3, 103.00, '7.5% - ₹7.72', 103.00, 2, NULL, NULL, 1, 2, '2026-02-21 23:13:17', '2026-02-21 23:13:17'),
(207, 631, 3, 103.00, '7.5% - ₹7.72', 103.00, 2, NULL, NULL, 1, 2, '2026-02-21 23:25:51', '2026-02-21 23:25:51'),
(208, NULL, 19, 42.29, '0% - ₹0.00', 42.29, 5, '1', 'ORD1771696597545', 0, 2, '2026-02-21 23:26:37', '2026-02-21 23:26:37'),
(209, NULL, 19, 42.29, '0% - ₹0.00', 42.29, 5, '1', 'ORD1771696606379', 0, 2, '2026-02-21 23:26:46', '2026-02-21 23:26:46'),
(210, 635, 3, 121.00, '6% - ₹7.26', 113.74, 1, '1', 'ORD1771731182852', 1, 2, '2026-02-22 09:03:02', '2026-02-22 03:33:46'),
(211, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772007387128', 0, 1, '2026-02-25 13:46:02', '2026-02-25 13:46:02'),
(212, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772007463174', 0, 1, '2026-02-25 13:46:02', '2026-02-25 13:46:02'),
(213, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772008021821', 0, 1, '2026-02-25 13:46:02', '2026-02-25 13:46:02'),
(214, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772010830652', 1, 1, '2026-02-25 13:46:02', '2026-02-25 09:18:53'),
(215, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772011507008', 0, 1, '2026-02-25 13:46:02', '2026-02-25 13:46:02'),
(216, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772080100928', 0, 1, '2026-02-25 16:22:49', '2026-02-25 16:22:49'),
(217, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772080149478', 0, 1, '2026-02-25 16:22:49', '2026-02-25 16:22:49'),
(218, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772081937299', 0, 1, '2026-02-26 10:28:48', '2026-02-26 10:28:48'),
(219, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772081961919', 0, 1, '2026-02-26 10:28:48', '2026-02-26 10:28:48'),
(220, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772082022883', 0, 1, '2026-02-26 10:30:19', '2026-02-26 10:30:19'),
(221, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772082033014', 0, 2, '2026-02-26 10:30:19', '2026-02-26 10:30:19'),
(222, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772082058640', 0, 1, '2026-02-26 10:30:19', '2026-02-26 10:30:19'),
(223, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772083006863', 0, 1, '2026-02-26 10:30:19', '2026-02-26 10:30:19'),
(224, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772083124033', 0, 1, '2026-02-26 10:30:19', '2026-02-26 10:30:19'),
(225, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772083138042', 0, 1, '2026-02-26 10:30:19', '2026-02-26 10:30:19'),
(226, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772083233096', 0, 1, '2026-02-26 10:49:52', '2026-02-26 10:49:52'),
(227, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772083790054', 0, 1, '2026-02-26 10:59:02', '2026-02-26 10:59:02'),
(228, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772083798758', 0, 1, '2026-02-26 10:59:02', '2026-02-26 10:59:02'),
(229, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772083834634', 0, 1, '2026-02-26 10:59:02', '2026-02-26 10:59:02'),
(230, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772083845737', 0, 1, '2026-02-26 10:59:02', '2026-02-26 10:59:02'),
(231, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772083884199', 0, 1, '2026-02-26 11:01:05', '2026-02-26 11:01:05'),
(232, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772083907499', 0, 1, '2026-02-26 11:01:05', '2026-02-26 11:01:05'),
(233, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772083924547', 0, 1, '2026-02-26 11:01:05', '2026-02-26 11:01:05'),
(234, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772083942779', 0, 1, '2026-02-26 11:01:05', '2026-02-26 11:01:05'),
(235, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772083943474', 0, 1, '2026-02-26 11:01:05', '2026-02-26 11:01:05'),
(236, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772084029310', 0, 1, '2026-02-26 11:01:05', '2026-02-26 11:01:05'),
(237, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772084033464', 0, 1, '2026-02-26 11:01:05', '2026-02-26 11:01:05'),
(238, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772084067975', 0, 1, '2026-02-26 11:01:05', '2026-02-26 11:01:05'),
(239, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772084148050', 0, 1, '2026-02-26 11:05:23', '2026-02-26 11:05:23'),
(240, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772084152901', 0, 1, '2026-02-26 11:05:23', '2026-02-26 11:05:23'),
(241, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772084177313', 0, 1, '2026-02-26 11:05:23', '2026-02-26 11:05:23'),
(242, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772084924669', 0, 1, '2026-02-26 11:05:23', '2026-02-26 11:05:23'),
(243, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772084929035', 0, 1, '2026-02-26 11:05:23', '2026-02-26 11:05:23'),
(244, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772084939907', 0, 1, '2026-02-26 11:05:23', '2026-02-26 11:05:23'),
(245, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772084953735', 0, 1, '2026-02-26 11:05:23', '2026-02-26 11:05:23'),
(246, NULL, 12, 10.00, '0% - ₹0.00', 10.00, 4, '2', 'ORD1772085090963', 0, 1, '2026-02-26 11:21:11', '2026-02-26 11:21:11'),
(247, NULL, 12, 10.00, '0% - ₹0.00', 10.00, 4, '2', 'ORD1772085091650', 2, 1, '2026-02-26 11:21:11', '2026-02-26 05:51:46'),
(248, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772085120586', 0, 1, '2026-02-26 11:21:11', '2026-02-26 11:21:11'),
(249, NULL, 12, 10.00, '0% - ₹0.00', 10.00, 4, '2', 'ORD1772085189527', 2, 1, '2026-02-26 11:21:11', '2026-02-26 05:53:27'),
(250, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772085270159', 0, 1, '2026-02-26 11:21:11', '2026-02-26 11:21:11'),
(251, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772085298567', 0, 1, '2026-02-26 11:21:11', '2026-02-26 11:21:11'),
(252, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772085320191', 0, 1, '2026-02-26 11:21:11', '2026-02-26 11:21:11'),
(253, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772085351246', 0, 1, '2026-02-26 11:21:11', '2026-02-26 11:21:11'),
(254, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772085386470', 0, 1, '2026-02-26 11:21:11', '2026-02-26 11:21:11'),
(255, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772085464875', 0, 1, '2026-02-26 11:27:38', '2026-02-26 11:27:38'),
(256, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772085470887', 0, 1, '2026-02-26 11:27:38', '2026-02-26 11:27:38'),
(257, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772085477945', 0, 1, '2026-02-26 11:27:38', '2026-02-26 11:27:38'),
(258, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772085753927', 0, 1, '2026-02-26 11:27:38', '2026-02-26 11:27:38'),
(259, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772085783428', 0, 1, '2026-02-26 11:32:58', '2026-02-26 11:32:58'),
(260, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772085788543', 0, 1, '2026-02-26 11:32:58', '2026-02-26 11:32:58'),
(261, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772085819419', 0, 1, '2026-02-26 11:32:58', '2026-02-26 11:32:58'),
(262, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772085845663', 0, 1, '2026-02-26 11:32:58', '2026-02-26 11:32:58'),
(263, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772085958177', 0, 1, '2026-02-26 11:35:51', '2026-02-26 11:35:51'),
(264, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772085977039', 0, 1, '2026-02-26 11:35:51', '2026-02-26 11:35:51'),
(265, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772085990952', 0, 1, '2026-02-26 11:35:51', '2026-02-26 11:35:51'),
(266, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772086007998', 0, 1, '2026-02-26 11:36:44', '2026-02-26 11:36:44'),
(267, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772086024916', 0, 1, '2026-02-26 11:36:44', '2026-02-26 11:36:44'),
(268, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772086063474', 0, 1, '2026-02-26 11:37:41', '2026-02-26 11:37:41'),
(269, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772086162167', 0, 1, '2026-02-26 11:37:41', '2026-02-26 11:37:41'),
(270, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772086299642', 0, 1, '2026-02-26 11:37:41', '2026-02-26 11:37:41'),
(271, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772086353353', 0, 1, '2026-02-26 11:37:41', '2026-02-26 11:37:41'),
(272, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772086385494', 0, 1, '2026-02-26 11:37:41', '2026-02-26 11:37:41'),
(273, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772086392293', 0, 1, '2026-02-26 11:37:41', '2026-02-26 11:37:41'),
(274, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772086631233', 0, 1, '2026-02-26 11:37:41', '2026-02-26 11:37:41'),
(275, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772086863119', 0, 1, '2026-02-26 11:37:41', '2026-02-26 11:37:41'),
(276, NULL, 12, 10.00, '0% - ₹0.00', 10.00, 4, '2', 'ORD1772086901428', 0, 1, '2026-02-26 11:37:41', '2026-02-26 11:37:41'),
(277, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772087407914', 0, 1, '2026-02-26 11:37:41', '2026-02-26 11:37:41'),
(278, NULL, 12, 20.00, '0% - ₹0.00', 20.00, 4, '2', 'ORD1772087469498', 0, 1, '2026-02-26 11:37:41', '2026-02-26 11:37:41'),
(279, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772087872072', 0, 1, '2026-02-26 11:37:41', '2026-02-26 11:37:41'),
(280, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772087965349', 0, 1, '2026-02-26 11:37:41', '2026-02-26 11:37:41'),
(281, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772088041470', 0, 1, '2026-02-26 11:37:41', '2026-02-26 11:37:41'),
(282, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772088091944', 0, 1, '2026-02-26 11:37:41', '2026-02-26 11:37:41'),
(283, NULL, 12, 20.00, '0% - ₹0.00', 20.00, 4, '2', 'ORD1772088147809', 0, 1, '2026-02-26 11:37:41', '2026-02-26 11:37:41'),
(284, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772088197487', 0, 1, '2026-02-26 11:37:41', '2026-02-26 11:37:41'),
(285, NULL, 12, 20.00, '0% - ₹0.00', 20.00, 4, '2', 'ORD1772088269456', 2, 1, '2026-02-26 11:37:41', '2026-02-26 06:44:51'),
(286, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772088312346', 1, 1, '2026-02-26 11:37:41', '2026-02-26 06:46:22'),
(287, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772088419785', 2, 1, '2026-02-26 11:37:41', '2026-02-26 06:50:23'),
(288, NULL, 12, 500.00, '0% - ₹0.00', 500.00, 4, '2', 'ORD1772088588620', 0, 1, '2026-02-26 11:37:41', '2026-02-26 11:37:41'),
(289, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772089180207', 0, 1, '2026-02-26 11:37:41', '2026-02-26 11:37:41'),
(290, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772089268031', 0, 1, '2026-02-26 11:37:41', '2026-02-26 11:37:41'),
(291, NULL, 12, 10.00, '0% - ₹0.00', 10.00, 4, '2', 'ORD1772089552875', 0, 1, '2026-02-26 11:37:41', '2026-02-26 11:37:41'),
(292, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772089687637', 0, 1, '2026-02-26 11:37:41', '2026-02-26 11:37:41'),
(293, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772089816807', 0, 1, '2026-02-26 11:37:41', '2026-02-26 11:37:41'),
(294, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772089872563', 0, 1, '2026-02-26 11:37:41', '2026-02-26 11:37:41'),
(295, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772089943861', 0, 1, '2026-02-26 11:37:41', '2026-02-26 11:37:41'),
(296, NULL, 3, 200.00, '0% - ₹0.00', 200.00, 4, '2', 'ORD1772090377802', 1, 1, '2026-02-26 11:37:41', '2026-02-26 07:20:06'),
(297, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772090571638', 1, 1, '2026-02-26 11:37:41', '2026-02-26 07:23:01'),
(298, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772090745977', 1, 1, '2026-02-26 11:37:41', '2026-02-26 07:26:01'),
(299, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772090815297', 1, 1, '2026-02-26 11:37:41', '2026-02-26 07:27:05'),
(300, NULL, 3, 502.00, '0% - ₹0.00', 502.00, 4, '2', 'ORD1772090868335', 1, 1, '2026-02-26 11:37:41', '2026-02-26 07:27:57'),
(301, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772090990686', 1, 1, '2026-02-26 11:37:41', '2026-02-26 07:30:09'),
(302, NULL, 3, 200.00, '0% - ₹0.00', 200.00, 4, '2', 'ORD1772091095645', 1, 1, '2026-02-26 11:37:41', '2026-02-26 07:31:44'),
(303, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772091773246', 1, 1, '2026-02-26 11:37:41', '2026-02-26 07:43:05'),
(304, NULL, 3, 111.00, '0% - ₹0.00', 111.00, 4, '2', 'ORD1772092199211', 1, 1, '2026-02-26 11:37:41', '2026-02-26 07:50:10'),
(305, NULL, 3, 111.00, '0% - ₹0.00', 111.00, 4, '2', 'ORD1772092674927', 1, 1, '2026-02-26 11:37:41', '2026-02-26 07:58:05'),
(306, 647, 53, 232.00, '7.5% - ₹17.40', 232.00, 2, NULL, NULL, 1, 2, '2026-02-26 23:36:32', '2026-02-26 23:36:32'),
(307, 655, 18, 184.00, '6% - ₹11.04', 172.96, 1, '2', 'ORD1772177353320', 0, 2, '2026-02-26 11:37:41', '2026-02-26 11:37:41'),
(308, 655, 18, 184.00, '7.5% - ₹13.80', 184.00, 2, NULL, NULL, 1, 2, '2026-02-27 13:00:09', '2026-02-27 13:00:09'),
(309, 661, 17, 6618.00, '7.5% - ₹496.35', 6618.00, 2, NULL, NULL, 1, 2, '2026-02-27 16:32:35', '2026-02-27 16:32:35'),
(310, 664, 17, 967.00, '7.5% - ₹72.53', 967.00, 2, NULL, NULL, 1, 2, '2026-02-27 16:34:54', '2026-02-27 16:34:54'),
(311, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772263925810', 1, 1, '2026-02-26 11:37:41', '2026-02-28 07:32:18'),
(312, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772264167644', 1, 1, '2026-02-26 11:37:41', '2026-02-28 07:36:19'),
(313, NULL, 3, 100.00, '0% - ₹0.00', 100.00, 4, '2', 'ORD1772264203952', 1, 1, '2026-02-26 11:37:41', '2026-02-28 07:37:18'),
(314, NULL, 3, 111.00, '0% - ₹0.00', 111.00, 4, '2', 'ORD1772264421937', 1, 1, '2026-02-26 11:37:41', '2026-02-28 07:40:34'),
(315, NULL, 3, 263.00, '0% - ₹0.00', 263.00, 4, '2', 'ORD1772264658375', 1, 1, '2026-02-26 11:37:41', '2026-02-28 07:44:33'),
(316, NULL, 3, 580.00, '0% - ₹0.00', 580.00, 4, '2', 'ORD1772264690864', 2, 1, '2026-02-26 11:37:41', '2026-02-28 07:45:00'),
(317, 700, 61, 68.00, '7.5% - ₹5.10', 68.00, 2, NULL, NULL, 1, 2, '2026-03-07 16:14:27', '2026-03-07 16:14:27'),
(318, 721, 65, 49.00, '7.5% - ₹3.67', 49.00, 2, NULL, NULL, 1, 2, '2026-03-09 14:38:13', '2026-03-09 14:38:13'),
(319, 728, 67, 119.00, '7.5% - ₹8.93', 119.00, 2, NULL, NULL, 1, 2, '2026-03-10 14:56:08', '2026-03-10 14:56:08'),
(320, 741, 17, 5593.00, '6% - ₹335.58', 5257.42, 1, '2', 'ORD1773317460418', 0, 2, '2026-03-12 10:20:28', '2026-03-12 10:20:28'),
(321, 741, 17, 5593.00, '6% - ₹335.58', 5257.42, 1, '2', 'ORD1773317492188', 0, 2, '2026-03-12 10:20:28', '2026-03-12 10:20:28'),
(322, 741, 17, 5593.00, '6% - ₹335.58', 5257.42, 1, '2', 'ORD1773317542476', 2, 2, '2026-03-12 10:20:28', '2026-03-12 12:12:42'),
(323, 741, 17, 5593.00, '6% - ₹335.58', 5257.42, 1, '2', 'ORD1773317566379', 1, 2, '2026-03-12 10:20:28', '2026-03-12 12:13:01'),
(324, 743, 17, 968.00, '6% - ₹58.08', 909.92, 1, '2', 'ORD1773317861634', 1, 2, '2026-03-12 10:20:28', '2026-03-12 12:18:04'),
(325, 751, 17, 154.00, '6% - ₹9.24', 144.76, 1, '2', 'ORD1773382611639', 1, 2, '2026-03-12 10:20:28', '2026-03-13 06:18:56');

-- --------------------------------------------------------

--
-- Table structure for table `payment_gateways`
--

CREATE TABLE `payment_gateways` (
  `id` int(11) NOT NULL,
  `gateway_name` varchar(50) NOT NULL,
  `mid` varchar(100) NOT NULL,
  `merchant_key` varchar(150) NOT NULL,
  `website` varchar(50) NOT NULL,
  `txn_url` text NOT NULL,
  `callback_url` text NOT NULL,
  `status` tinyint(4) DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `payment_gateways`
--

INSERT INTO `payment_gateways` (`id`, `gateway_name`, `mid`, `merchant_key`, `website`, `txn_url`, `callback_url`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Paytm', 'IneuZB64959027148878', '3C0XgpYmOkh@MHoB', 'WEBSTAGING', 'https://securestage.paytmpayments.com/theia/api/v1/initiateTransaction', 'https://admin.rainbowsenterprises.com/api/callback_paytm', 1, '2026-02-26 05:12:59', '2026-02-26 05:12:59');

-- --------------------------------------------------------

--
-- Table structure for table `policies`
--

CREATE TABLE `policies` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` tinyint(3) UNSIGNED NOT NULL COMMENT '1 = privacy_policy, 2 = term_condition',
  `description` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `policies`
--

INSERT INTO `policies` (`id`, `name`, `type`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Privacy Policy', 1, '<article class=\"privacy-policy\">\n  <h1>Privacy Policy</h1>\n\n  <p>\n    This Privacy Policy explains how <strong>rainboW</strong> (“we”, “our”, “us”)\n    collects, uses, shares, and protects user information when you use our mobile\n    application for <strong>cab booking and handyman services</strong>.\n  </p>\n\n  <h2>1. Information We Collect</h2>\n\n  <h3>a) Personal Information</h3>\n  <p>We may collect the following information:</p>\n  <ul>\n    <li>Name</li>\n    <li>Mobile number</li>\n    <li>Email address</li>\n    <li>Service or pickup address</li>\n  </ul>\n\n  <h3>b) Location Information</h3>\n  <p>We collect location data to:</p>\n  <ul>\n    <li>Enable cab booking and navigation</li>\n    <li>Find nearby service professionals</li>\n  </ul>\n  <p>\n    Location data may be collected while the app is in use (foreground) or running\n    in the background, only with user consent.\n  </p>\n\n  <h3>c) Service &amp; Usage Information</h3>\n  <ul>\n    <li>Booking details and service history</li>\n    <li>Time, date, and type of service requested</li>\n    <li>App interaction and usage patterns</li>\n  </ul>\n\n  <h3>d) Device Information</h3>\n  <ul>\n    <li>Device model and OS version</li>\n    <li>IP address</li>\n    <li>App performance and crash data</li>\n  </ul>\n\n  <h2>2. How We Use Information</h2>\n  <p>Collected information is used to:</p>\n  <ul>\n    <li>Provide cab booking and handyman services</li>\n    <li>Connect users with drivers or service professionals</li>\n    <li>Process service requests and confirmations</li>\n    <li>Communicate important updates and support messages</li>\n    <li>Improve app reliability and user experience</li>\n    <li>Prevent fraud and misuse</li>\n  </ul>\n\n  <h2>3. Data Sharing</h2>\n  <p>We do not sell or trade user personal data. Information may be shared only with:</p>\n  <ul>\n    <li>Drivers and service providers to complete bookings</li>\n    <li>Technical partners required for app functionality</li>\n    <li>Legal or regulatory authorities when required by law</li>\n  </ul>\n  <p>All data sharing is limited to service-related purposes.</p>\n\n  <h2>4. Data Security</h2>\n  <p>\n    We use appropriate technical and administrative measures to protect user data\n    from unauthorized access, loss, or misuse. While we strive to protect your\n    information, no system is completely secure.\n  </p>\n\n  <h2>5. Data Retention</h2>\n  <p>User data is retained only for:</p>\n  <ul>\n    <li>Service delivery</li>\n    <li>Legal and regulatory compliance</li>\n    <li>Dispute resolution and enforcement</li>\n  </ul>\n  <p>\n    Users may request deletion of their data by contacting us.\n  </p>\n\n  <h2>6. User Rights &amp; Controls</h2>\n  <ul>\n    <li>Access and update personal information</li>\n    <li>Withdraw permissions (including location) via device settings</li>\n    <li>Request account and data deletion</li>\n  </ul>\n\n  <h2>7. Children’s Privacy</h2>\n  <p>\n    rainboW is not intended for users under the age of 18. We do not knowingly\n    collect personal information from children.\n  </p>\n\n  <h2>8. Third-Party Services</h2>\n  <p>\n    The app may use third-party services such as maps, messaging, or payment\n    gateways. These services operate under their own privacy policies.\n  </p>\n\n  <h2>9. Policy Updates</h2>\n  <p>\n    This Privacy Policy may be updated periodically. Any changes will be reflected\n    within the app or on the official policy page.\n  </p>\n\n  <h2>10. Contact Information</h2>\n  <p>\n    For privacy-related questions or requests:<br />\n    📧 <a href=\"mailto:info@rainbowempservices.in\">\n      info@rainbowempservices.in\n    </a>\n  </p>\n</article>\n', '2025-10-03 09:24:02', '2026-01-31 06:19:13'),
(2, 'Term Condition', 2, '<article class=\"terms-conditions\">\n  <h1>Terms and Conditions</h1>\n\n  <p>\n    These Terms and Conditions (“Terms”) govern your access to and use of the\n    <strong>rainboW</strong> mobile application and related services. By\n    downloading, accessing, or using the app, you agree to be bound by these\n    Terms.\n  </p>\n\n  <p>\n    If you do not agree with these Terms, please do not use the application.\n  </p>\n\n  <h2>1. Service Description</h2>\n  <p>rainboW is a digital platform that enables users to:</p>\n  <ul>\n    <li>Book cab transportation services</li>\n    <li>Request handyman and home services</li>\n  </ul>\n  <p>\n    rainboW acts as a technology platform only and does not directly provide\n    transportation or handyman services.\n  </p>\n\n  <h2>2. Eligibility</h2>\n  <p>To use the app, you must:</p>\n  <ul>\n    <li>Be at least 18 years of age</li>\n    <li>Be legally capable of entering into a binding agreement</li>\n  </ul>\n  <p>\n    By using the app, you confirm that you meet these requirements.\n  </p>\n\n  <h2>3. User Account Responsibilities</h2>\n  <ul>\n    <li>You are responsible for maintaining the confidentiality of your account details</li>\n    <li>You agree to provide accurate and up-to-date information</li>\n    <li>You are responsible for all activity conducted through your account</li>\n  </ul>\n  <p>\n    rainboW reserves the right to suspend or terminate accounts found to be in\n    violation of these Terms.\n  </p>\n\n  <h2>4. Booking &amp; Service Use</h2>\n  <ul>\n    <li>Service availability depends on location and provider availability</li>\n    <li>Estimated times and prices are indicative and may vary</li>\n    <li>You agree to use the services only for lawful and intended purposes</li>\n    <li>Misuse of the platform may result in account suspension</li>\n  </ul>\n\n  <h2>5. Payments &amp; Charges</h2>\n  <ul>\n    <li>Prices shown in the app may include applicable taxes or fees</li>\n    <li>Payment methods may include online or cash (where available)</li>\n    <li>rainboW is not responsible for payment failures caused by third-party gateways</li>\n    <li>Any pricing disputes must be raised via in-app support or email</li>\n  </ul>\n\n  <h2>6. Cancellations &amp; Refunds</h2>\n  <ul>\n    <li>Cancellation policies may vary depending on service type</li>\n    <li>Late cancellations may attract charges</li>\n    <li>Refunds, if applicable, will be processed as per service policy</li>\n    <li>rainboW reserves the right to modify cancellation rules at any time</li>\n  </ul>\n\n  <h2>7. User Conduct</h2>\n  <p>You agree not to:</p>\n  <ul>\n    <li>Provide false or misleading information</li>\n    <li>Abuse, harass, or harm service providers or other users</li>\n    <li>Use the app for illegal or unauthorized activities</li>\n    <li>Attempt to damage, hack, or misuse the platform</li>\n  </ul>\n  <p>\n    Violation may result in immediate termination of access.\n  </p>\n\n  <h2>8. Service Providers</h2>\n  <ul>\n    <li>Service providers are independent third parties</li>\n    <li>rainboW does not guarantee service quality, behavior, or outcomes</li>\n    <li>Disputes between users and service providers should be resolved directly</li>\n  </ul>\n  <p>\n    rainboW may assist with support but is not liable for service execution.\n  </p>\n\n  <h2>9. Limitation of Liability</h2>\n  <p>To the maximum extent permitted by law:</p>\n  <ul>\n    <li>rainboW shall not be liable for indirect, incidental, or consequential damages</li>\n    <li>We are not responsible for delays, service failures, or provider conduct</li>\n    <li>Use of the app is at your own risk</li>\n  </ul>\n\n  <h2>10. Intellectual Property</h2>\n  <p>\n    All content, logos, trademarks, and app materials are the property of\n    rainboW or its licensors. You may not copy, reproduce, or distribute any\n    content without prior written permission.\n  </p>\n\n  <h2>11. Suspension &amp; Termination</h2>\n  <p>rainboW may suspend or terminate access if:</p>\n  <ul>\n    <li>These Terms are violated</li>\n    <li>Fraudulent or harmful activity is detected</li>\n    <li>Required by law or regulatory authority</li>\n  </ul>\n\n  <h2>12. Modifications to Terms</h2>\n  <p>\n    We may update these Terms from time to time. Continued use of the app\n    indicates acceptance of the revised Terms.\n  </p>\n\n  <h2>13. Governing Law</h2>\n  <p>\n    These Terms shall be governed by and interpreted in accordance with the laws\n    of India. Any disputes shall be subject to the jurisdiction of courts in\n    Uttar Pradesh.\n  </p>\n\n  <h2>14. Contact Information</h2>\n  <p>\n    For questions or support regarding these Terms:<br />\n    📧 <a href=\"mailto:info@rainbowempservices.in\">\n      info@rainbowempservices.in\n    </a>\n  </p>\n</article>\n', '2025-10-03 09:24:02', '2026-01-31 06:19:56');

-- --------------------------------------------------------

--
-- Table structure for table `rating_history`
--

CREATE TABLE `rating_history` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `driver_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rating_history`
--

INSERT INTO `rating_history` (`id`, `order_id`, `user_id`, `driver_id`, `rating`, `created_at`) VALUES
(1, 20, 12, 20, 4, '2026-01-07 13:58:11'),
(2, 21, 12, 20, 4, '2026-01-07 13:58:53'),
(3, 23, 12, 20, 5, '2026-01-07 14:00:22'),
(4, 24, 12, 20, 5, '2026-01-07 14:00:28'),
(5, 25, 12, 20, 5, '2026-01-07 14:00:32'),
(6, 26, 12, 20, 5, '2026-01-07 14:01:04'),
(7, 27, 12, 20, 5, '2026-01-07 14:01:09'),
(8, 28, 12, 20, 5, '2026-01-07 14:01:17'),
(9, 29, 12, 20, 5, '2026-01-07 14:01:22'),
(10, 31, 12, 20, 3, '2026-01-07 15:03:25'),
(11, 5, 3, 19, 5, '2026-01-10 10:44:30'),
(12, 4, 3, 19, 2, '2026-01-10 10:55:16');

-- --------------------------------------------------------

--
-- Table structure for table `saved_address`
--

CREATE TABLE `saved_address` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `type` tinyint(1) NOT NULL COMMENT '1 = Service, 2 = Cab Booking',
  `address` text NOT NULL,
  `flat_house_building_name` varchar(255) DEFAULT NULL,
  `floor` varchar(50) DEFAULT NULL,
  `nearby_landmark` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `service_latitude` varchar(25) DEFAULT NULL,
  `service_longitude` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `saved_address`
--

INSERT INTO `saved_address` (`id`, `user_id`, `type`, `address`, `flat_house_building_name`, `floor`, `nearby_landmark`, `created_at`, `service_latitude`, `service_longitude`) VALUES
(5, 12, 1, '4/5, Gomti Nagar, Lucknow, Uttar Pradesh', 'Shiv Apartment', '2nd Floor', 'Near City Mall', '2025-12-19 08:14:08', '26.216515', '80.555446'),
(10, 3, 1, '1/798, Sector H Road, Sector H, Jankipuram, Lucknow, Uttar Pradesh, India', 'vhhhf', '4', 'vhjjj', '2025-12-19 10:48:09', '26.919232342863356', '80.95782212913036'),
(11, 15, 1, '617, Lakhimpur, Uttar Pradesh, 262701', '1#', NULL, NULL, '2026-01-14 16:57:04', '27.957634738256843', '80.7850955799222'),
(12, 18, 1, 'Jankipuram Police Station, Sultanpur Village, Jankipuram Extension, Balamau, Uttar Pradesh, India', '121', '2', 'police station', '2026-01-17 12:03:10', '26.92610643092992', '80.93939166516066'),
(13, 13, 1, 'WWXR+C6X, Lucknow, Uttar Pradesh, 226031', 'gjh', 'ghn', 'hhjjj', '2026-01-20 04:49:54', '26.948085156401604', '80.94074416905642'),
(14, 4, 1, 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 'bjbjb', 'hvh', 'vhvhhv', '2026-01-21 09:17:01', '26.943490817583424', '80.94053294509649'),
(15, 4, 1, 'Gorakhpur, Uttar Pradesh, India', '2/45', '2', 'Gorakhnath temple', '2026-01-21 09:37:08', '26.760554553796823', '83.37316744029522'),
(16, 25, 1, '1/798, Sector H Road, Sector H, Jankipuram, Lucknow, Uttar Pradesh, India', '1/798', 'ground floor', 'near char no chauraha', '2026-01-23 05:34:54', '26.919232342863356', '80.95782212913036'),
(17, 1, 1, 'Sector H, Jankipuram, Lucknow, Uttar Pradesh, India', 'ghh', 'ground floor', 'chauraha', '2026-01-23 09:05:38', '26.917772871792863', '80.95740236341953'),
(18, 28, 1, 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', '1/2', 'ground floor', 'CDRI', '2026-01-24 04:26:16', '26.943490518700237', '80.94053294509649'),
(21, 20, 1, 'Unable to fetch address', '12 a', '2 floor', 'shiv mander', '2026-01-27 07:51:45', '26.980786461901808', '80.93168031424284'),
(22, 20, 1, 'Jankipuram, Lucknow, Uttar Pradesh, India', '12 a', '2 floor', 'shiv mandir', '2026-01-27 13:28:38', '26.92102152938948', '80.9511836618185'),
(23, 17, 1, 'Lucknow Outer Ring Road, Hardhaurpur, Uttar Pradesh, 226202', '12', '2', 'shiv mandir', '2026-01-29 09:17:03', '27.003684151091246', '80.8725818619132'),
(24, 42, 1, '301, Lucknow, Uttar Pradesh, 226031', 'aktu', 'aktu', 'aktu', '2026-02-14 04:31:00', '26.944491474074145', '80.93891724944115'),
(26, 54, 1, 'Udyog Bhawan, New Delhi, Delhi, 110011', 'g2v', 'hw', 'bsjs', '2026-02-25 13:39:19', '28.61275420930139', '77.21200257539749'),
(27, 56, 1, 'CN242, New Delhi, Delhi, 110074', 'sghh', 'ghu', 'vghh', '2026-02-27 07:45:19', '28.504513353635', '77.18335423618555'),
(28, 57, 1, 'J.P.Hospital, Lucknow, Uttar Pradesh, 226021', '00', NULL, NULL, '2026-02-27 11:08:06', '26.939990542161436', '80.95716129988432'),
(29, 57, 1, '647B/J-PN-084(K-825, Lucknow, Uttar Pradesh, 226026', '78', NULL, NULL, '2026-02-27 11:32:53', '26.92952045050312', '80.96583757549524'),
(30, 60, 1, 'Sushaantanu Dham, Lucknow, Uttar Pradesh, 226010', '12A', '2', 'Kamakhya Devi Mandir', '2026-03-06 11:30:02', '26.845236845722926', '81.0186680406332'),
(31, 66, 1, '9-227/1, Vuyyuru, Andhra Pradesh, 521165', 'mm mk', 'km', 'jkkm', '2026-03-09 18:44:02', '16.365102144304828', '80.84488704800606');

-- --------------------------------------------------------

--
-- Table structure for table `scheduled_api_hits`
--

CREATE TABLE `scheduled_api_hits` (
  `id` int(11) NOT NULL,
  `hit_datetime` datetime NOT NULL,
  `is_done` tinyint(1) DEFAULT '0',
  `order_id` bigint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `first_notification_status` tinyint(4) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `scheduled_api_hits`
--

INSERT INTO `scheduled_api_hits` (`id`, `hit_datetime`, `is_done`, `order_id`, `created_at`, `first_notification_status`) VALUES
(1, '2026-01-06 17:01:00', 0, NULL, '2026-01-06 10:43:51', 0),
(2, '2026-01-06 17:02:00', 0, NULL, '2026-01-06 10:43:51', 0),
(3, '2026-01-06 17:03:00', 0, NULL, '2026-01-06 10:43:51', 0),
(4, '2026-01-06 17:04:00', 0, NULL, '2026-01-06 10:43:51', 0),
(5, '2026-01-06 17:05:00', 0, NULL, '2026-01-06 10:43:51', 0),
(6, '2026-01-06 17:06:00', 0, NULL, '2026-01-06 10:43:51', 0),
(7, '2026-01-06 17:07:00', 0, NULL, '2026-01-06 10:43:51', 0),
(8, '2026-01-06 17:08:00', 0, NULL, '2026-01-06 10:43:51', 0),
(9, '2026-01-06 17:09:00', 0, NULL, '2026-01-06 10:43:51', 0),
(10, '2026-01-06 17:10:00', 0, NULL, '2026-01-06 10:43:51', 0),
(11, '2026-01-06 17:11:00', 1, NULL, '2026-01-06 10:43:51', 0),
(12, '2026-01-06 17:12:00', 1, NULL, '2026-01-06 10:43:51', 0),
(13, '2026-01-06 17:13:00', 1, NULL, '2026-01-06 10:43:51', 0),
(14, '2026-01-06 17:14:00', 1, NULL, '2026-01-06 10:43:51', 0),
(15, '2026-01-06 17:15:00', 1, NULL, '2026-01-06 10:43:51', 0),
(16, '2026-01-06 17:16:00', 1, NULL, '2026-01-06 10:43:51', 0),
(17, '2026-01-06 17:17:00', 1, NULL, '2026-01-06 10:43:51', 0),
(18, '2026-01-06 17:18:00', 1, NULL, '2026-01-06 10:43:51', 0),
(19, '2026-01-06 17:19:00', 1, NULL, '2026-01-06 10:43:51', 0),
(20, '2026-01-06 17:20:00', 1, NULL, '2026-01-06 10:43:51', 0),
(21, '2026-01-07 10:30:00', 1, 53, '2026-01-07 04:58:58', 0),
(22, '2026-01-07 10:33:00', 1, 54, '2026-01-07 05:01:23', 0),
(23, '2026-01-07 10:42:00', 1, 55, '2026-01-07 05:10:17', 0),
(24, '2026-01-07 22:48:00', 1, 56, '2026-01-07 05:16:47', 1),
(25, '2026-01-07 10:49:00', 1, 57, '2026-01-07 05:17:43', 0),
(26, '2026-01-07 11:56:00', 1, 58, '2026-01-07 06:24:32', 0),
(27, '2026-01-07 12:03:00', 1, 59, '2026-01-07 06:31:23', 0),
(28, '2026-01-07 12:05:00', 1, 60, '2026-01-07 06:33:25', 0),
(29, '2026-01-07 12:20:00', 1, 62, '2026-01-07 06:49:29', 0),
(30, '2026-01-07 12:36:00', 1, 63, '2026-01-07 07:04:57', 1),
(31, '2026-01-07 12:53:00', 1, 64, '2026-01-07 07:21:41', 1),
(32, '2026-01-07 12:58:00', 0, 65, '2026-01-07 07:25:42', 0),
(33, '2026-01-07 13:03:00', 1, 66, '2026-01-07 07:31:49', 1),
(34, '2026-01-07 13:12:00', 1, 67, '2026-01-07 07:39:32', 1),
(35, '2026-01-07 15:23:00', 1, 69, '2026-01-07 09:51:52', 1),
(36, '2026-01-07 15:34:00', 1, 70, '2026-01-07 10:02:28', 1),
(37, '2026-01-07 16:50:00', 1, 78, '2026-01-07 11:18:59', 1),
(38, '2026-01-07 16:54:00', 1, 80, '2026-01-07 11:22:58', 1),
(39, '2026-01-07 17:10:00', 1, 82, '2026-01-07 11:36:00', 1),
(40, '2026-01-07 17:25:00', 1, 83, '2026-01-07 11:49:51', 1),
(41, '2026-01-07 17:24:00', 1, 84, '2026-01-07 11:52:44', 1),
(42, '2026-01-07 18:02:00', 0, 85, '2026-01-07 12:31:36', 0),
(43, '2026-01-07 18:05:00', 1, 86, '2026-01-07 12:34:08', 0),
(44, '2026-01-07 18:09:00', 1, 87, '2026-01-07 12:37:51', 1),
(45, '2026-01-07 18:35:00', 1, 88, '2026-01-07 13:04:19', 0),
(46, '2026-01-09 15:15:00', 1, 90, '2026-01-08 07:31:06', 0),
(47, '2026-01-10 17:00:00', 1, 2, '2026-01-10 11:28:40', 1),
(48, '2025-01-10 17:21:37', 0, 3, '2026-01-10 11:49:33', 0),
(49, '2026-01-11 17:25:00', 1, 4, '2026-01-10 11:53:32', 0),
(50, '2026-01-10 17:30:00', 1, 5, '2026-01-10 11:58:09', 1),
(51, '2026-01-10 17:42:00', 1, 1, '2026-01-10 12:09:52', 1),
(52, '2026-01-10 18:13:00', 1, 3, '2026-01-10 12:40:52', 1),
(53, '2026-01-10 21:15:00', 1, 2, '2026-01-10 15:42:21', 1),
(54, '2026-01-10 21:25:00', 1, 1, '2026-01-10 15:52:23', 1),
(55, '2026-01-10 21:31:00', 1, 2, '2026-01-10 15:59:33', 1),
(56, '2026-01-23 12:12:00', 1, 7, '2026-01-17 06:42:19', 0),
(57, '2026-01-22 09:15:00', 1, 37, '2026-01-22 03:42:56', 1),
(58, '2026-01-22 15:06:00', 1, 46, '2026-01-22 09:31:41', 1),
(59, '2026-01-22 15:40:00', 1, 47, '2026-01-22 10:07:28', 1),
(60, '2026-01-22 15:50:00', 1, 48, '2026-01-22 10:16:25', 1),
(61, '2026-01-22 16:00:00', 1, 49, '2026-01-22 10:27:51', 1),
(62, '2026-01-22 16:05:00', 1, 50, '2026-01-22 10:33:11', 1),
(63, '2026-01-22 16:13:00', 1, 51, '2026-01-22 10:41:45', 1),
(64, '2026-01-22 16:16:00', 1, 52, '2026-01-22 10:44:51', 1),
(65, '2026-01-22 16:24:00', 1, 54, '2026-01-22 10:52:32', 1),
(66, '2026-01-22 16:26:00', 0, 55, '2026-01-22 10:55:57', 0),
(67, '2026-01-22 16:28:00', 1, 56, '2026-01-22 10:56:41', 1),
(68, '2026-01-22 16:31:00', 1, 57, '2026-01-22 10:59:37', 1),
(69, '2026-01-22 16:43:00', 1, 58, '2026-01-22 11:11:07', 1),
(70, '2026-01-22 16:46:00', 1, 59, '2026-01-22 11:14:38', 1),
(71, '2026-01-22 16:49:00', 1, 60, '2026-01-22 11:17:21', 1),
(72, '2026-01-22 16:53:00', 1, 61, '2026-01-22 11:21:44', 1),
(73, '2026-01-22 16:56:00', 1, 62, '2026-01-22 11:24:23', 1),
(74, '2026-01-22 17:29:00', 1, 63, '2026-01-22 11:57:18', 1),
(75, '2026-01-22 17:40:00', 1, 64, '2026-01-22 12:08:26', 1),
(76, '2026-01-22 17:43:00', 1, 65, '2026-01-22 12:11:20', 1),
(77, '2026-01-24 08:00:00', 1, 71, '2026-01-23 08:14:32', 1),
(78, '2025-01-10 17:21:37', 0, 141, '2026-01-26 07:22:00', 0),
(79, '2025-01-10 17:21:37', 0, 142, '2026-01-26 07:23:13', 0),
(80, '2025-02-04 11:59:37', 0, 289, '2026-02-04 06:29:36', 0),
(81, '2026-02-04 12:04:37', 1, 290, '2026-02-04 06:31:44', 1),
(82, '2026-02-04 12:04:37', 1, 291, '2026-02-04 06:32:18', 1),
(83, '2026-02-04 12:04:37', 1, 292, '2026-02-04 06:32:25', 1),
(84, '2026-02-04 12:10:37', 1, 294, '2026-02-04 06:33:27', 1),
(85, '2026-02-04 12:13:37', 1, 295, '2026-02-04 06:41:09', 1),
(86, '2026-02-04 12:13:37', 0, 296, '2026-02-04 06:43:52', 0),
(87, '2026-02-04 12:15:37', 1, 297, '2026-02-04 06:44:19', 1),
(88, '2026-02-04 12:40:37', 1, 298, '2026-02-04 07:07:02', 1),
(89, '2026-02-04 12:44:37', 1, 299, '2026-02-04 07:12:53', 0),
(90, '2026-02-04 12:45:37', 1, 300, '2026-02-04 07:14:12', 1),
(91, '2026-02-04 12:45:37', 0, 301, '2026-02-04 07:48:39', 0),
(92, '2026-02-04 13:48:37', 1, 302, '2026-02-04 08:16:09', 1),
(93, '2026-02-04 15:08:37', 1, 303, '2026-02-04 09:36:51', 1),
(94, '2026-02-04 15:13:37', 1, 304, '2026-02-04 09:41:53', 1),
(95, '2026-02-04 15:15:37', 1, 305, '2026-02-04 09:44:07', 1),
(96, '2026-02-11 21:00:00', 1, 434, '2026-02-10 13:15:03', 1),
(97, '2026-02-11 06:00:00', 1, 454, '2026-02-10 15:30:44', 1),
(98, '2026-02-20 17:44:00', 1, 571, '2026-02-18 10:14:21', 1),
(99, '2025-03-10 17:21:37', 0, 572, '2026-02-18 10:30:40', 0),
(100, '2025-02-18 16:10:37', 0, 573, '2026-02-18 10:38:43', 0),
(101, '2025-02-18 16:10:37', 0, 574, '2026-02-18 10:39:27', 0),
(102, '2025-02-18 16:14:37', 0, 575, '2026-02-18 10:41:42', 0),
(103, '2026-02-18 16:20:37', 1, 576, '2026-02-18 10:47:07', 1),
(104, '2026-02-22 17:25:00', 1, 614, '2026-02-21 12:17:19', 0),
(105, '2026-02-22 21:50:00', 1, 627, '2026-02-21 16:20:17', 0),
(106, '2026-03-05 17:00:00', 1, 670, '2026-03-05 08:51:38', 1),
(107, '2026-03-05 19:30:00', 1, 681, '2026-03-05 11:35:02', 1),
(108, '2026-03-06 22:15:00', 1, 690, '2026-03-06 14:37:01', 1),
(109, '2026-03-09 21:31:00', 1, 725, '2026-03-09 13:58:02', 1);

-- --------------------------------------------------------

--
-- Table structure for table `serviceman`
--

CREATE TABLE `serviceman` (
  `id` int(11) NOT NULL,
  `service_category` json DEFAULT NULL,
  `wallet` double(10,2) DEFAULT '0.00',
  `mobile` bigint(12) DEFAULT NULL,
  `due_wallet` double(10,2) DEFAULT '0.00',
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `reject_reasion` varchar(255) DEFAULT NULL,
  `online_status` tinyint(4) NOT NULL DEFAULT '0',
  `form_status` tinyint(4) NOT NULL DEFAULT '0',
  `fcm_token` varchar(255) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `aadhaar_front` varchar(150) DEFAULT NULL,
  `aadhaar_back` varchar(150) DEFAULT NULL,
  `skill_status` tinyint(4) NOT NULL,
  `experience_certificate` varchar(150) DEFAULT NULL,
  `device_id` varchar(255) DEFAULT NULL,
  `login_status` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `current_latitude` varchar(100) DEFAULT NULL,
  `current_longitude` varchar(100) DEFAULT NULL,
  `profile_photo` varchar(150) DEFAULT NULL,
  `gender` varchar(30) DEFAULT NULL,
  `city` varchar(140) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `serviceman`
--

INSERT INTO `serviceman` (`id`, `service_category`, `wallet`, `mobile`, `due_wallet`, `first_name`, `last_name`, `reject_reasion`, `online_status`, `form_status`, `fcm_token`, `email`, `address`, `aadhaar_front`, `aadhaar_back`, `skill_status`, `experience_certificate`, `device_id`, `login_status`, `created_at`, `updated_at`, `current_latitude`, `current_longitude`, `profile_photo`, `gender`, `city`) VALUES
(1, '[1, 2, 3, 5]', 19755.93, 9876543211, 176.64, 'ramu', 'sharmaa', NULL, 0, 1, 'f7bYlQI5Ta6GDu0f68CN9w:APA91bEzVKKWwpAZ_A-q9DTUi-oDkEhibKN1EPGJ7RLD7BoGhBNSNxuGsLYBwGv_VEK6OUsM8J039HhHv7j5ZkW2VZ3g7ezmmpQeQSCyrlCKtnVko4OU1zg', 'ramu@gmail.com', 'lucknow', 'ServicemanFiles/1765258792177.jpeg', 'ServicemanFiles/1765258792254.jpeg', 1, NULL, 'fvgbhnj', 1, '2025-12-09 05:39:52', '2026-02-26 07:33:22', '26.9435717', '80.9405749', 'ServicemanFiles/1765451127949.jpg', NULL, NULL),
(2, '1', 300.00, 8423953287, 50.00, 'ramu', 'sharma', 'AsdZFCGNK', 0, 0, 'abc_fcm', 'ramus@gmail.com', 'lucknow', 'ServicemanFiles/1765258880379.jpeg', 'ServicemanFiles/1765258880475.jpeg', 1, NULL, 'asdfcghjkl', 0, '2025-12-09 05:41:20', '2025-12-09 05:41:20', NULL, NULL, NULL, NULL, NULL),
(3, '1', 0.00, 8423953286, 0.00, 'ramu', 'sharma', NULL, 0, 1, 'f9IEdS5zSGauCIrqjwUjFK:APA91bEZn6o71-lBkaCCXJx7DB20hiWCf1z1nvmc8acJcLj1v-UmkBYw2DzB2jeKSiCJQpmiZ2kyumnkLwNv0MSVWF_9NRWGWxDKfHJnLqVOOZSo17_X7B0', 'ramus@gmail.com', 'lucknow', 'ServicemanFiles/1765259068213.jpeg', 'ServicemanFiles/1765259068301.jpeg', 1, NULL, 'fvgbhnj', 1, '2025-12-09 05:44:28', '2026-02-12 05:08:35', '26.9435706', '80.9405633', NULL, NULL, NULL),
(4, '2', 1132.80, 8888888888, 56.64, 'ramu', 'sharma', NULL, 0, 1, 'd1uVSDquQKCh6RhAb66BlV:APA91bEn0inBi4IFGG15w2-6-ZGgdcALmuzPJ49oDcgLJNFADMjsmBayJa5pRsQtDlVpzIjIcCP_hi3V57BuQ9S2NqMNxxqiJXp6GtvMyMYA8agkmt2FiWY', 'ramus@gmail.com', 'lucknow', 'ServicemanFiles/1765259072891.jpeg', 'ServicemanFiles/1765259072991.jpeg', 1, NULL, 'fvgbhnj', 1, '2025-12-09 05:44:32', '2025-12-24 11:39:03', '26.9435', '80.9404747', NULL, NULL, NULL),
(5, '1', 0.00, 8423953210, 0.00, 'ramu', 'sharma', NULL, 0, 0, 'abc_fcm', 'ramus@gmail.com', 'lucknow', 'ServicemanFiles/1765259075800.jpeg', 'ServicemanFiles/1765259075897.jpeg', 1, NULL, 'asdfcghjkl', 0, '2025-12-09 05:44:35', '2025-12-12 06:05:43', NULL, NULL, NULL, NULL, NULL),
(20, '1', 0.00, 9565545464, 0.00, 'Tanisha ', 'sharma ', NULL, 0, 0, 'fcm_123', 'vhvy@gmail.com', 'Lucknow Uttar Pradesh India ', 'ServicemanFiles/1765533195480.jpg', 'ServicemanFiles/1765533195683.jpg', 1, NULL, 'device_123', 0, '2025-12-12 15:23:16', '2025-12-12 15:23:16', '26.90', '80.94', 'ServicemanFiles/1765533195791.heic', 'Female', NULL),
(21, '1', 0.00, 9646486446, 0.00, 'Ramu', 'jiii', NULL, 0, 0, 'fcm_123', 'ratgggmu@gmail.com', 'Lucknow to nh ', 'ServicemanFiles/1765533707453.jpg', 'ServicemanFiles/1765533707649.heic', 1, NULL, 'device_123', 0, '2025-12-12 15:31:48', '2025-12-12 15:31:48', '26.90', '80.94', 'ServicemanFiles/1765533708351.jpg', 'Female', NULL),
(22, '1', 0.00, 9856565656, 0.00, 'pjsh', 'dhhdus', NULL, 0, 0, 'fcm_123', 'xndh@gmail.com', 'luckn ', 'ServicemanFiles/1765533998633.jpg', 'ServicemanFiles/1765533998828.jpg', 1, NULL, 'device_123', 0, '2025-12-12 15:36:38', '2025-12-12 15:36:38', '26.90', '80.94', 'ServicemanFiles/1765533998929.jpg', 'Female', NULL),
(23, '2', 0.00, 9598199932, 0.00, 'Abhishek ', 'sharma ', NULL, 0, 0, 'dgxbz8bnQJyaUHLFpo3fKE:APA91bEuunKDnYEAJsScxce-qCfct33StIBetF-uY3Las9T-dWOc-6WhNw5aKxMs824WNgMyNjhz9w7k_SkH96iParkWCmPqt2rV_2MV0BqhV8hvtE_wCZE', 'niranjan7sharma@gmail.com', 'Vistar Yojna, Jankipuram, Lucknow, Uttar Pradesh, 226031', 'ServicemanFiles/1765859372599.jpg', 'ServicemanFiles/1765859376686.jpg', 1, NULL, 'RKQ1.201004.002', 0, '2025-12-16 09:59:51', '2025-12-16 04:35:39', '26.9125', '75.7875', 'ServicemanFiles/1765859383442.jpg', 'Male', NULL),
(25, '[1, 2, 3, 5]', 0.00, 7235947667, 0.00, 'Tanisha ', 'Sharma', NULL, 0, 0, 'e7pFnQnoRL-8syy9tPXfRz:APA91bGcjR2FZ9R9zAHWwrPszfJqESQfCuFGaJ3_NddDaoh334ixzurBaD2TSXlCUuoIWr_8uCTdmWZaE1b4ar1cpjI1ZQWOvhbu5qD5iJhZTHArvp9OjKw', 'tanu@gmail.com', '1/613, Jankipuram Extension, Mirzapur, Uttar Pradesh, 226031', 'ServicemanFiles/1766075786961.jpg', 'ServicemanFiles/1766075787255.jpg', 1, NULL, 'fvgbhnj', 1, '2025-12-18 22:06:28', '2026-01-21 04:07:00', '26.9435472', '80.9405682', 'ServicemanFiles/1766075787685.jpg', 'Female', NULL),
(26, '2', 0.00, 9695782867, 0.00, 'Akansha ', 'Singh ', NULL, 0, 0, 'egYNYbdsSsyVTXaY1i8OBZ:APA91bEMk2mLEHw1FtygOMK9le0HBjQuO-EHEloSWWPBHfQnLh-kddu3cYH7cAAwdvbv8YD5ohGT6dWp1I9ZuuVnA6qPPVwlpIIrh3PaLsnoUvqZUo47tIM', 'akansha@gmail.com', 'Vistar Yojna, Jankipuram, Lucknow, Uttar Pradesh, 226031', 'ServicemanFiles/1766488379151.jpg', 'ServicemanFiles/1766488380476.jpg', 1, NULL, 'RP1A.200720.011', 0, '2025-12-23 16:43:01', '2025-12-23 16:43:01', '26.9435622', '80.940582', 'ServicemanFiles/1766488380832.jpg', 'Male', NULL),
(27, '2', 0.00, 8741257875, 0.00, 'Kritika ', 'Sharma', NULL, 0, 0, 'fJrITCx4SY2IEFBJdsRcCE:APA91bHGOOAjrJWoZA4Qc6D28o39eFzVZbvdhXmdsIeXgHwJODTrF1P0KMAnRcgibQVkoLywNebibfZ32HLWUE5lTU4cn6CqHpevx4Cf_D0ctsOPM-gxXxM', 'kriti@gmail.com', 'Vistar Yojna, Jankipuram, Lucknow, Uttar Pradesh, 226031', 'ServicemanFiles/1766488819052.jpg', 'ServicemanFiles/1766488819576.jpg', 1, NULL, 'RP1A.200720.011', 1, '2025-12-23 16:50:20', '2025-12-23 16:50:20', '26.943577', '80.9405525', 'ServicemanFiles/1766488819932.jpg', 'Male', NULL),
(28, '2', 0.00, 9662565956, 0.00, 'helo', 'hol', NULL, 0, 0, 'ca4wpfOJSJiWKO6p5IkVXV:APA91bFX3NbxguhSO6ie5wcPwqlCEmnhXk8nqc78JH-XaOGt2p7GJjqJVvzDGbu-KQbxmvkQ8kEr5H4FCHX_-8PRLFiMqMeWL5_eJul_z6d-NWTr4o9flvg', 'helo@gmail.com', 'Vistar Yojna, Jankipuram, Lucknow, Uttar Pradesh, 226031', 'ServicemanFiles/1766489792038.jpg', 'ServicemanFiles/1766489792663.jpg', 1, NULL, 'RP1A.200720.011', 1, '2025-12-23 17:06:33', '2025-12-23 11:36:36', '26.9435686', '80.9405798', 'ServicemanFiles/1766489793091.jpg', 'Male', NULL),
(29, '[1, 2, 3]', 0.00, 8454512252, 0.00, 'girsl', 'hukil', NULL, 0, 0, 'ca4wpfOJSJiWKO6p5IkVXV:APA91bFX3NbxguhSO6ie5wcPwqlCEmnhXk8nqc78JH-XaOGt2p7GJjqJVvzDGbu-KQbxmvkQ8kEr5H4FCHX_-8PRLFiMqMeWL5_eJul_z6d-NWTr4o9flvg', 'girl@gmail.com', 'Vistar Yojna, Jankipuram, Lucknow, Uttar Pradesh, 226031', 'ServicemanFiles/1766490041661.jpg', 'ServicemanFiles/1766490042386.jpg', 1, NULL, 'RP1A.200720.011', 1, '2025-12-23 17:10:43', '2025-12-23 17:10:43', '26.9435692', '80.9405641', 'ServicemanFiles/1766490042787.jpg', 'Male', NULL),
(30, '1', 0.00, 9632655421, 0.00, 'Kunal', 'Singh ', NULL, 0, 0, 'ca4wpfOJSJiWKO6p5IkVXV:APA91bFX3NbxguhSO6ie5wcPwqlCEmnhXk8nqc78JH-XaOGt2p7GJjqJVvzDGbu-KQbxmvkQ8kEr5H4FCHX_-8PRLFiMqMeWL5_eJul_z6d-NWTr4o9flvg', 'kunal@gmail.com', 'Vistar Yojna, Jankipuram, Lucknow, Uttar Pradesh, 226031', 'ServicemanFiles/1766490405119.jpg', 'ServicemanFiles/1766490405596.jpg', 1, NULL, 'RP1A.200720.011', 1, '2025-12-23 17:16:46', '2025-12-23 11:53:22', '26.9435688', '80.9405803', 'ServicemanFiles/1766490406123.jpg', 'Male', NULL),
(33, '[1, 2, 3, 5]', 0.00, 8423953287, 0.00, 'ramu', 'sharma', NULL, 0, 1, 'cQJ98J_1TpiJ_xfVChrZdr:APA91bGom16A4werXjhrhzZgcPwqpdel-GMBMsPtVR0jR_tJ--2vjVdGyAcSji2-f8B8dJ3EVtX4pohWGEGqvwtcyJE7L49HNBTEwX0YQu72csT53pYTlH0', '', 'lucknow', 'ServicemanFiles/1768969264946.png', 'ServicemanFiles/1768969265144.png', 1, NULL, 'fvgbhnj', 1, '2026-01-21 09:51:05', '2026-01-23 10:51:14', '26.9434983', '80.9405493', 'ServicemanFiles/1768969265265.png', 'male', NULL),
(35, '[12, 13]', 0.00, 9884544689, 0.00, 'dhdhd', 'bx xxv', NULL, 0, 0, 'e7pFnQnoRL-8syy9tPXfRz:APA91bGcjR2FZ9R9zAHWwrPszfJqESQfCuFGaJ3_NddDaoh334ixzurBaD2TSXlCUuoIWr_8uCTdmWZaE1b4ar1cpjI1ZQWOvhbu5qD5iJhZTHArvp9OjKw', '', 'jankipuram sector H Lucknow', 'ServicemanFiles/1768973023493.jpg', 'ServicemanFiles/1768973023678.jpg', 1, NULL, 'RKQ1.201004.002', 1, '2026-01-21 10:53:43', '2026-01-21 05:25:12', '26.9434883', '80.9405377', 'ServicemanFiles/1768973023722.jpg', 'Male', NULL),
(36, '[1, 2, 3, 5]', 185.00, 9808559632, 0.00, 'kunal ', 'verma', NULL, 0, 0, 'eTSDd_5PQjyvC6h0NgfF5s:APA91bFb6hHRC2Arm48CqYpjbu2cQWCTfZL6OmzMi30nopt4eKrVpOh9nB7JlVabtUZHRt9EPpuzhvy5kn4XNQ9omq1_MmeFT_UgzgQKKjxk5TGbZGTE_8s', '', 'Vistar Yojna, Jankipuram, Lucknow, Uttar Pradesh, 226031', 'ServicemanFiles/1768974472766.jpg', 'ServicemanFiles/1768974473052.jpg', 1, NULL, 'fvgbhnj', 1, '2026-01-21 11:17:53', '2026-01-21 11:00:47', '26.9125', '75.7875', 'ServicemanFiles/1768974473152.jpg', 'Male', '2'),
(37, '[1, 2, 8]', 0.50, 9140183315, 0.00, 'viveak ', 'oberai', NULL, 0, 0, 'dgwbzbyqSOO5xG_LCOIAbE:APA91bFSeTNMyuJJV071NRBXuk_6r42k-U6W6ZVczw0tp9clXu0Yms2Mau9R_v56qNWSTwzMDdOZIJaN8FxlIPVQiz5RLDssuPJMDZeBknKP_o3c93H737E', 'ramu@foundercodes.com', 'Vistar Yojna, Jankipuram, Lucknow, Uttar Pradesh, 226031', 'ServicemanFiles/1769145890272.jpg', 'ServicemanFiles/1769145890971.jpg', 1, NULL, 'RKQ1.201004.002', 1, '2026-01-23 10:54:51', '2026-01-23 05:50:58', '26.9435083', '80.9405428', 'ServicemanFiles/1769145891082.jpg', 'Male', '10'),
(38, '[3, 12, 2]', 2219.08, 9559960255, 70.80, 'AMAN', 'mishra', NULL, 0, 0, 'f4Y7MNOkR9-31uxzT7Fmrm:APA91bHz8k6C6izQG8GJ_NVTsiPGbOBMFrVreyr_SkCpn4xR8yTvoS-Kq92zi68m2jO45pTujzXGAyTeO_xsZ0pSanx-cu1D_b-uLsm3_bJYOOAecKszpoU', '', 'Vistar Yojna, Jankipuram, Lucknow, Uttar Pradesh, 226031', 'ServicemanFiles/1769158909310.jpg', 'ServicemanFiles/1769158909447.jpg', 1, NULL, 'fvgbhnj', 1, '2026-01-23 14:31:49', '2026-03-06 14:35:19', '26.9825275', '80.9317001', 'ServicemanFiles/1769158909559.jpg', 'Male', '10');

-- --------------------------------------------------------

--
-- Table structure for table `serviceman_ratings`
--

CREATE TABLE `serviceman_ratings` (
  `id` int(10) UNSIGNED NOT NULL,
  `serviceman_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `rating` tinyint(4) NOT NULL COMMENT '1 to 5',
  `order_id` int(10) UNSIGNED NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `service_name` varchar(150) DEFAULT NULL,
  `user_name` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `serviceman_ratings`
--

INSERT INTO `serviceman_ratings` (`id`, `serviceman_id`, `user_id`, `rating`, `order_id`, `created_at`, `service_name`, `user_name`) VALUES
(3, 24, 3, 3, 2, '2025-12-18 16:36:45', 'AC Cooling Service', 'pankaj ji'),
(4, 24, 3, 5, 4, '2025-12-18 16:44:09', 'AC Cooling Service', 'pankaj ji'),
(5, 1, 3, 4, 53, '2026-02-06 17:09:21', 'AC Cooling Service', 'pankaj ji');

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `subcategory_id` int(11) DEFAULT NULL,
  `title` varchar(150) NOT NULL,
  `description` text,
  `image` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT '0.00',
  `rating` float DEFAULT '0',
  `faqs` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `status` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `top_servises_status` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `category_id`, `subcategory_id`, `title`, `description`, `image`, `price`, `rating`, `faqs`, `status`, `created_at`, `top_servises_status`) VALUES
(1, 2, 4, 'AC Cooling Service', 'Complete AC servicing including cleaning, gas check and cooling optimization.', 'serviceImage/ac.jpg', 499.00, 4.7, '[\n  {\n    \"id\": 1,\n    \"question\": \"Is servicing required every year?\",\n    \"answer\": \"Yes, yearly service improves cooling and increases AC life.\"\n  },\n  {\n    \"id\": 2,\n    \"question\": \"How much time does it take?\",\n    \"answer\": \"Usually 45 minutes to 1 hour.\"\n  }\n]\n', 1, '2025-12-06 09:19:24', 1),
(4, 5, 10, 'Furniture Repair', 'Repair of broken furniture, hinges, doors, and wooden fittings.', 'serviceImage/fur.jpg', 349.00, 4.7, '[\n  {\n    \"id\": 1,\n    \"question\": \"Is servicing required every year?\",\n    \"answer\": \"Yes, yearly service improves cooling and increases AC life.\"\n  },\n  {\n    \"id\": 2,\n    \"question\": \"How much time does it take?\",\n    \"answer\": \"Usually 45 minutes to 1 hour.\"\n  }\n]\n', 1, '2025-12-06 09:19:24', 1),
(5, 2, 4, 'AC Deep Cleaning', 'Full AC deep cleaning with antibacterial treatment.', 'serviceImage/deep2.jpg', 599.00, 4.8, '[\n  {\n    \"id\": 1,\n    \"question\": \"Is servicing required every year?\",\n    \"answer\": \"Yes, yearly service improves cooling and increases AC life.\"\n  },\n  {\n    \"id\": 2,\n    \"question\": \"How much time does it take?\",\n    \"answer\": \"Usually 45 minutes to 1 hour.\"\n  }\n]\n', 1, '2025-12-06 09:54:39', 0),
(6, 2, 4, 'AC Gas Refillings', 'Premium AC gas refill with leak check.', 'serviceImage/acgas.jpg', 1100.00, 4.6, '[{\"id\":1,\"question\":\"How much time does it take?\",\"answer\":\"answer How much time does it take?\"}]', 1, '2025-12-06 09:54:39', 1),
(7, 17, 48, 'Home sweet home, where dreams are designed.', 'Home decoration text includes short, inspiring phrases for social media (\"Cozy is my love language,\" \"My happy place, one pillow at a time\"), descriptive captions for different rooms (\"Creating calm in the hustle of deadlines\" for offices, \"Serenity soaks and style sparks\" for bathrooms), and longer quotes about design principles (\"Design is thinking made visual,\" \"A house is made of walls and beams; a home is built with love and dreams\"). These texts aim to evoke feelings of comfort, style', 'serviceImage/1768649693771.jpg', 700.00, 0, '[{\"id\":1,\"question\":\"Home sweet home, where dreams are designed.\",\"answer\":\"Home sweet home, where dreams are designed.\"},{\"id\":2,\"question\":\"Home sweet home, where dreams are designed.\",\"answer\":\"Home sweet home, where dreams are designed.\"}]', 1, '2026-01-17 11:34:53', 0),
(8, 1, 2, 'Plant care man', 'Plant care man works  only 4 hours ll needs ', 'serviceImage/1768983951013.jpg', 200.00, 0, '[{\"id\":1,\"question\":\"Plant care man works  only 4 hours ll needs\",\"answer\":\"Plant care man works  only 4 hours ll needs\"}]', 1, '2026-01-21 08:25:51', 0),
(9, 3, 9, 'A all home Switch Repair', 'Electrical wiring refers to the installation of cabling and associated devices such as switches, distribution panels, outlets, and light fittings within a structure. It is essential to every electrical system, ensuring safe and reliable distribution of power across circuits.', 'serviceImage/1769159760357.jpg', 800.00, 0, '[{\"id\":1,\"question\":\"Electrical wiring refers to the installation\",\"answer\":\"Electrical wiring refers to the installation\"}]', 1, '2026-01-23 09:16:00', 1),
(10, 12, 49, 'plumbing leakage repari service', 'All types of plumbing work including pipe fitting leakage repair tap installation bathroom &kitchen plumbing fast reliable and affordable service', 'serviceImage/1769497472484.jpg', 999.00, 0, '[{\"id\":1,\"question\":\"How much time dose  it take\",\"answer\":\"Is servicing required every year  ?\"}]', 1, '2026-01-27 07:05:01', 1),
(11, 6, 17, 'premium bathroom cleaning service', 'our bathroom cleaning service -ensures a clean hygienic and fresh bathroom for your home and office', 'serviceImage/1769963384232.jfif', 799.00, 0, '[]', 1, '2026-02-01 16:29:44', 0),
(13, 8, 20, 'QUALITY PAINTING SERVICES', 'PROFESSIONAL PAINTER SERVICES FOR HOME AND OFFICE QUALITY WORK CLEAN FINISH AND ON TIME SERVICE', 'serviceImage/1770009628827.jpg', 699.00, 0, '[]', 0, '2026-02-02 05:20:43', 1);

-- --------------------------------------------------------

--
-- Table structure for table `service_order`
--

CREATE TABLE `service_order` (
  `id` int(11) NOT NULL,
  `service_address` varchar(255) NOT NULL,
  `service_latitude` varchar(100) DEFAULT NULL,
  `service_longitude` varchar(100) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `user_name` varchar(100) DEFAULT NULL,
  `user_mobile` varchar(12) DEFAULT NULL,
  `serviceman_id` int(10) DEFAULT NULL,
  `serviceman_name` varchar(255) DEFAULT NULL,
  `serviceman_mobile` varchar(10) DEFAULT NULL,
  `amount` double(10,2) DEFAULT NULL,
  `coupon_discount` double(10,2) DEFAULT NULL,
  `gst_charges` double(10,2) DEFAULT NULL,
  `final_amount` double(10,2) DEFAULT NULL,
  `payment_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0 Pending 1 complete',
  `service_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0 = Pending  \r\n1 = Accepted  \r\n2 = OTP Verification Pending\r\n3 = Completed  \r\n4 = Payment Done  \r\n5 = Cancelled by User  \r\n6 = Cancelled by Serviceman  \r\n7 = Cancelled by System  \r\n',
  `service_id` int(10) DEFAULT NULL,
  `service_name` varchar(255) DEFAULT NULL,
  `pay_mode` tinyint(4) DEFAULT NULL COMMENT '1 = online\r\n2 = offline\r\n3 = wallet',
  `coupon_id` tinyint(4) DEFAULT NULL,
  `available_service_man` varchar(255) DEFAULT NULL,
  `service_datetime` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `quantity` int(10) DEFAULT NULL,
  `cancel_reason` varchar(255) DEFAULT NULL,
  `orderOtp` varchar(10) DEFAULT NULL,
  `description` longtext,
  `rating` tinyint(4) DEFAULT NULL,
  `distance` decimal(10,2) DEFAULT NULL,
  `ignore_service_man` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `service_order`
--

INSERT INTO `service_order` (`id`, `service_address`, `service_latitude`, `service_longitude`, `user_id`, `user_name`, `user_mobile`, `serviceman_id`, `serviceman_name`, `serviceman_mobile`, `amount`, `coupon_discount`, `gst_charges`, `final_amount`, `payment_status`, `service_status`, `service_id`, `service_name`, `pay_mode`, `coupon_id`, `available_service_man`, `service_datetime`, `updated_at`, `created_at`, `quantity`, `cancel_reason`, `orderOtp`, `description`, `rating`, `distance`, `ignore_service_man`) VALUES
(1, '121, Jankipuram Police Station, Sultanpur Village, Jankipuram Extension, Balamau, Uttar Pradesh, India, Near police station, Floor: 2', '26.92610643092992', '80.93939166516066', 18, 'ANSAL', '9651511938', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 7, 1, 'AC Cooling Service', 2, NULL, '[]', '2026-01-17 17:40:00', '2026-01-17 17:34:28', '2026-01-17 17:34:28', 1, 'abvsh', '3410', 'bhhgjh', NULL, NULL, '[4,1,28,60]'),
(2, '121, Jankipuram Police Station, Sultanpur Village, Jankipuram Extension, Balamau, Uttar Pradesh, India, Near police station, Floor: 2', '26.92610643092992', '80.93939166516066', 18, 'ANSAL', '9651511938', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 0, 1, 'AC Cooling Service', 2, NULL, '[32,4,1,28]', '2026-01-17 17:44:00', '2026-01-17 17:38:07', '2026-01-17 17:38:07', 1, NULL, '5147', 'vbh', NULL, NULL, NULL),
(5, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 1, 'AC Cooling Service', 1, 3, '[35]', '2025-12-16 19:35:00', '2026-01-21 11:14:41', '2026-01-21 11:14:41', 1, NULL, '6885', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL, NULL),
(6, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 1, 'AC Cooling Service', 1, 3, '[35]', '2025-12-16 19:35:00', '2026-01-21 11:16:00', '2026-01-21 11:16:00', 1, NULL, '1041', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL, NULL),
(7, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 1, 'AC Cooling Service', 1, 3, '[25]', '2025-12-16 19:35:00', '2026-01-21 11:25:16', '2026-01-21 11:25:16', 1, NULL, '6073', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL, NULL),
(8, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 1, 'AC Cooling Service', 1, 3, '[25]', '2026-01-28 19:35:00', '2026-01-21 11:25:56', '2026-01-21 11:25:56', 1, NULL, '3178', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL, NULL),
(9, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 4, 'Furniture Repair', 1, 3, '[]', '2026-01-28 19:35:00', '2026-01-21 11:26:43', '2026-01-21 11:26:43', 1, NULL, '4093', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL, NULL),
(10, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 4, 'Furniture Repair', 1, 3, '[]', '2026-01-28 19:35:00', '2026-01-21 11:27:09', '2026-01-21 11:27:09', 1, NULL, '7381', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL, NULL),
(11, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 4, 'Furniture Repair', 1, 3, '[]', '2026-01-28 19:35:00', '2026-01-21 11:27:25', '2026-01-21 11:27:25', 1, NULL, '6013', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL, NULL),
(12, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 4, 'Furniture Repair', 1, 3, '[25]', '2026-01-28 19:35:00', '2026-01-21 11:30:18', '2026-01-21 11:30:18', 1, NULL, '9723', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL, NULL),
(13, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 4, 'Furniture Repair', 1, 3, '[36,25]', '2026-01-28 19:35:00', '2026-01-21 12:57:19', '2026-01-21 12:57:19', 1, NULL, '7900', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL, NULL),
(14, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 4, 'Furniture Repair', 1, 3, '[36,25]', '2026-01-28 19:35:00', '2026-01-21 13:00:05', '2026-01-21 13:00:05', 1, NULL, '1978', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL, NULL),
(15, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 4, 'Furniture Repair', 1, 3, '[36,25]', '2026-01-28 19:35:00', '2026-01-21 13:09:00', '2026-01-21 13:09:00', 1, NULL, '3416', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL, NULL),
(16, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 4, 'Furniture Repair', 1, 3, '[36,25]', '2026-01-28 19:35:00', '2026-01-21 13:18:06', '2026-01-21 13:18:06', 1, NULL, '1362', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL, NULL),
(17, 'bjbjb, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near vhvhhv, Floor: hvh', '26.943490817583424', '80.94053294509649', 4, 'Ramu  Sharma ', '8423953286', NULL, NULL, NULL, 200.00, 0.00, 36.00, 236.00, 0, 0, 8, 'Plant care man', 2, NULL, '[36,25]', '2026-01-21 15:05:00', '2026-01-21 14:47:57', '2026-01-21 14:47:57', 1, NULL, '8809', 'bbjbjb', NULL, NULL, NULL),
(18, 'bjbjb, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near vhvhhv, Floor: hvh', '26.943490817583424', '80.94053294509649', 4, 'Ramu  Sharma ', '8423953286', NULL, NULL, NULL, 200.00, 0.00, 36.00, 236.00, 0, 0, 8, 'Plant care man', 2, NULL, '[36,25]', '2026-01-22 12:05:00', '2026-01-21 14:49:56', '2026-01-21 14:49:56', 1, NULL, '7786', '', NULL, NULL, NULL),
(19, 'bjbjb, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near vhvhhv, Floor: hvh', '26.943490817583424', '80.94053294509649', 4, 'Ramu  Sharma ', '8423953286', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 0, 1, 'AC Cooling Service', 2, NULL, '[36,25]', '2026-01-22 15:15:00', '2026-01-21 14:52:22', '2026-01-21 14:52:22', 1, NULL, '8252', '', NULL, NULL, NULL),
(20, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 4, 'Furniture Repair', 1, 3, '[36,25]', '2026-01-28 19:35:00', '2026-01-21 14:53:26', '2026-01-21 14:53:26', 1, NULL, '8316', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL, NULL),
(21, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 4, 'Furniture Repair', 1, 3, '[36,25]', '2026-01-28 19:35:00', '2026-01-21 14:53:35', '2026-01-21 14:53:35', 1, NULL, '1287', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL, NULL),
(22, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 4, 'Furniture Repair', 1, 3, '[36,25]', '2026-01-28 19:35:00', '2026-01-21 14:53:38', '2026-01-21 14:53:38', 1, NULL, '8880', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL, NULL),
(23, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 4, 'Furniture Repair', 1, 3, '[36,25]', '2026-01-28 19:35:00', '2026-01-21 14:53:41', '2026-01-21 14:53:41', 1, NULL, '1926', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL, NULL),
(24, 'bjbjb, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near vhvhhv, Floor: hvh', '26.943490817583424', '80.94053294509649', 4, 'Ramu  Sharma ', '8423953286', 36, 'kunal  verma', '9808559632', 200.00, 0.00, 36.00, 236.00, 0, 4, 8, 'Plant care man', 1, NULL, '[36,25]', '2026-01-22 01:11:00', '2026-01-21 09:42:04', '2026-01-21 15:08:51', 1, NULL, '4911', '', NULL, 0.00, NULL),
(25, 'bjbjb, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near vhvhhv, Floor: hvh', '26.943490817583424', '80.94053294509649', 4, 'Ramu  Sharma ', '8423953286', 1, 'ramu sharmaa', '9876543211', 200.00, 0.00, 36.00, 236.00, 0, 6, 8, 'Plant care man', 2, 4, '[1,25,36]', '2026-01-22 18:25:00', '2026-01-22 18:22:57', '2026-01-22 18:22:57', 1, 'hhuhhn', '3475', '', NULL, 0.00, NULL),
(26, '1/798, 1/798, Sector H Road, Sector H, Jankipuram, Lucknow, Uttar Pradesh, India, Near near char no chauraha, Floor: ground floor', '26.919232342863356', '80.95782212913036', 25, 'Vishal', '7570006440', NULL, NULL, NULL, 400.00, 5.00, 68.40, 448.40, 0, 5, 8, 'Plant care man', 2, 4, '[1,37,33,25,36]', '2026-01-23 12:05:00', '2026-01-23 11:06:20', '2026-01-23 11:06:20', 2, 'koi nahi aaya', '4053', 'heel bss nee ghevar', NULL, NULL, NULL),
(27, '1/798, 1/798, Sector H Road, Sector H, Jankipuram, Lucknow, Uttar Pradesh, India, Near near char no chauraha, Floor: ground floor', '26.919232342863356', '80.95782212913036', 25, 'Vishal', '7570006440', 37, 'viveak  oberai', '9140183315', 200.00, 5.00, 34.20, 224.20, 0, 4, 8, 'Plant care man', 1, 4, '[1,37,33,25,36]', '2026-01-23 12:10:00', '2026-01-23 11:11:06', '2026-01-23 11:11:06', 1, NULL, '9900', 'sjdjdhfjfjfucucjcj rhi tb jhcbgdj sb ydhcehfhf', NULL, 3.20, NULL),
(28, 'ghh, Sector H, Jankipuram, Lucknow, Uttar Pradesh, India, Near chauraha, Floor: ground floor', '26.917772871792863', '80.95740236341953', 1, 'Tanisha Sharma ', '7235947667', 38, 'AMAN mishra', '9559960255', 499.00, 5.00, 85.33, 559.38, 0, 4, 1, 'AC Cooling Service', 2, 4, '[1,37,33,38,25]', '2026-01-23 15:24:00', '2026-01-23 14:36:22', '2026-01-23 14:36:22', 1, NULL, '6997', 'vvhh', NULL, 3.32, NULL),
(29, 'ghh, Sector H, Jankipuram, Lucknow, Uttar Pradesh, India, Near chauraha, Floor: ground floor', '26.917772871792863', '80.95740236341953', 1, 'Tanisha Sharma ', '7235947667', 38, 'AMAN mishra', '9559960255', 800.00, 0.00, 144.00, 944.00, 0, 4, 9, 'A all home Switch Repair', 2, NULL, '[1,33,25,38]', '2026-01-23 15:23:00', '2026-01-23 14:49:26', '2026-01-23 14:49:26', 1, NULL, '5607', 'vhhjh', NULL, 3.32, NULL),
(30, '1/2, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near CDRI, Floor: ground floor', '26.943490518700237', '80.94053294509649', 28, 'pankaj ', '7258836052', NULL, NULL, NULL, 800.00, 0.00, 144.00, 944.00, 0, 0, 9, 'A all home Switch Repair', 2, NULL, '[1,33,25,38]', '2026-01-24 10:56:00', '2026-01-24 09:57:10', '2026-01-24 09:57:10', 1, NULL, '2151', '', NULL, NULL, NULL),
(31, '1/2, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near CDRI, Floor: ground floor', '26.943490518700237', '80.94053294509649', 28, 'pankaj ', '7258836052', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 5, 1, 'AC Cooling Service', 2, NULL, '[33,37,1,25,38]', '2026-01-24 11:38:00', '2026-01-24 10:36:16', '2026-01-24 10:36:16', 1, 'cjfjfjffj vjfjfj', '3532', '', NULL, NULL, NULL),
(32, '1/2, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near CDRI, Floor: ground floor', '26.943490518700237', '80.94053294509649', 28, 'pankaj ', '7258836052', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 5, 1, 'AC Cooling Service', 2, NULL, '[1,33,37,25,38]', '2026-01-24 11:47:00', '2026-01-24 10:47:30', '2026-01-24 10:47:30', 1, 'nh karana hai mujhe', '7617', '', NULL, NULL, NULL),
(33, '1/2, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near CDRI, Floor: ground floor', '26.943490518700237', '80.94053294509649', 28, 'pankaj ', '7258836052', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 0, 1, 'AC Cooling Service', 2, NULL, '[33,37,1,25,38]', '2026-01-24 12:16:00', '2026-01-24 11:16:32', '2026-01-24 11:16:32', 1, NULL, '9283', 'chchchchhfu chfhffy', NULL, NULL, NULL),
(34, '1/2, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near CDRI, Floor: ground floor', '26.943490518700237', '80.94053294509649', 28, 'pankaj ', '7258836052', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 0, 9, 'AC Cooling Service', 2, NULL, '[33,37,1,25,38]', '2026-01-25 11:19:00', '2026-01-24 11:19:34', '2026-01-24 11:19:34', 1, NULL, '3575', 'Accessibility (Alt Text): Brief descriptions for screen readers and slow connections (e.g., \"A barista pouring latte art into a cup\"). Descriptive Writing: Uses sensory words (sight, sound, smell, touch, taste) to create imagery and atmosphere, common in stories and articles. Technical/System Descriptions: Explains processes, requirements, or data for software/knowledge systems, often in formal documents. Search Engine Optimization (SEO): Text descriptions help search engines understand and index images and content, improving discoverability.  Key Elements of Good Descriptions Sensory Details: Appeals to the five senses to make writing vivid. Show, Don\'t Tell: Conveys information through detail rather than direct statements. Context: Explains why something is important, not just what it looks like. Conciseness: Keep it brief and relevant, especially for web/alt text.  Examples Simple: \"A red apple.\" Descriptive: \"The ripe, crimson apple, cool and smooth in my palm, offered a sweet, sharp scent.\". Alt Text: \"A bar chart showing Q3 sales increased by 15% with a steep upward trend in August\" instead of just \"sales chart\". ', NULL, NULL, NULL),
(35, '1/2, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near CDRI, Floor: ground floor', '26.943490518700237', '80.94053294509649', 28, 'pankaj ', '7258836052', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 0, 1, 'AC Cooling Service', 2, NULL, '[33,1,37,25,38]', '2026-01-29 11:46:00', '2026-01-24 11:45:31', '2026-01-24 11:45:31', 1, NULL, '3542', '', NULL, NULL, NULL),
(36, '1/2, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near CDRI, Floor: ground floor', '26.943490518700237', '80.94053294509649', 28, 'pankaj ', '7258836052', 1, 'ramu sharmaa', '9876543211', 499.00, 0.00, 89.82, 588.82, 0, 4, 1, 'AC Cooling Service', 2, NULL, '[33,1,37,25,38]', '2026-01-25 12:16:00', '2026-01-24 12:16:32', '2026-01-24 12:16:32', 1, NULL, '4503', '', NULL, 0.00, NULL),
(37, '1/2, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near CDRI, Floor: ground floor', '26.943490518700237', '80.94053294509649', 28, 'pankaj ', '7258836052', 1, 'ramu sharmaa', '9876543211', 200.00, 0.00, 36.00, 236.00, 0, 6, 8, 'Plant care man', 2, NULL, '[33,37,1,25]', '2026-01-25 12:53:00', '2026-01-24 12:53:23', '2026-01-24 12:53:23', 1, 'nh time gft', '6814', 'mere ghar pe gardening karni hai aur grass bhi cut krns hai ', NULL, 0.00, NULL),
(38, '1/2, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near CDRI, Floor: ground floor', '26.943490518700237', '80.94053294509649', 28, 'pankaj ', '7258836052', NULL, NULL, NULL, 200.00, 0.00, 36.00, 236.00, 0, 0, 8, 'Plant care man', 2, NULL, '[33,37,1,25]', '2026-01-25 12:58:00', '2026-01-24 12:58:19', '2026-01-24 12:58:19', 1, NULL, '3692', 'trees mango aur neem ke lgane hai ', NULL, NULL, NULL),
(39, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near Hanuman ka mandir, Floor: 3', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', NULL, NULL, NULL, 999.00, 0.00, 179.82, 1178.82, 0, 0, 10, 'plumbing leakage repari service', 1, NULL, '[35,38]', '2026-01-27 13:05:00', '2026-01-27 13:05:21', '2026-01-27 13:05:21', 1, NULL, '4555', '', NULL, NULL, NULL),
(40, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near Hanuman ka mandir, Floor: 3', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', NULL, NULL, NULL, 999.00, 0.00, 179.82, 1178.82, 0, 0, 10, 'plumbing leakage repari service', 2, NULL, '[35,38]', '2026-01-27 13:15:00', '2026-01-27 13:07:28', '2026-01-27 13:07:28', 1, NULL, '2991', '', NULL, NULL, NULL),
(41, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near Hanuman ka mandir, Floor: 3', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', NULL, NULL, NULL, 999.00, 0.00, 179.82, 1178.82, 0, 0, 10, 'plumbing leakage repari service', 1, NULL, '[35,38]', '2026-01-27 13:26:00', '2026-01-27 13:09:29', '2026-01-27 13:09:29', 1, NULL, '3740', '', NULL, NULL, NULL),
(42, '12 A, Unable to fetch address, Near shiv Mandir, Floor: 2', '28.588901861273964', '77.25339878350496', 20, 'aman', '8303204543', NULL, NULL, NULL, 1100.00, 0.00, 198.00, 1298.00, 0, 0, 6, 'AC Gas Refillings', 1, NULL, '[]', '2026-01-27 13:25:00', '2026-01-27 13:12:00', '2026-01-27 13:12:00', 1, NULL, '5591', '', NULL, NULL, NULL),
(43, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near Hanuman ka mandir, Floor: 3', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', NULL, NULL, NULL, 349.00, 0.00, 62.82, 411.82, 0, 0, 4, 'Furniture Repair', 1, NULL, '[33,1,25]', '2026-01-27 13:13:00', '2026-01-27 13:13:32', '2026-01-27 13:13:32', 1, NULL, '6741', '', NULL, NULL, NULL),
(44, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near Hanuman ka mandir, Floor: 3', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', NULL, NULL, NULL, 800.00, 0.00, 144.00, 944.00, 0, 0, 9, 'A all home Switch Repair', 2, NULL, '[33,1,25,38]', '2026-01-27 14:21:00', '2026-01-27 13:15:52', '2026-01-27 13:15:52', 1, NULL, '5643', '', NULL, NULL, NULL),
(45, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near Hanuman ka mandir, Floor: 3', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', NULL, NULL, NULL, 800.00, 0.00, 144.00, 944.00, 0, 0, 9, 'A all home Switch Repair', 2, NULL, '[33,1,25,38]', '2026-01-27 14:21:00', '2026-01-27 13:16:14', '2026-01-27 13:16:14', 1, NULL, '1256', '', NULL, NULL, NULL),
(46, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near Hanuman ka mandir, Floor: 3', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', NULL, NULL, NULL, 1100.00, 0.00, 198.00, 1298.00, 0, 0, 6, 'AC Gas Refillings', 2, NULL, '[33,37,1,25,38]', '2026-01-27 13:32:00', '2026-01-27 13:17:46', '2026-01-27 13:17:46', 1, NULL, '7178', '', NULL, NULL, NULL),
(47, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near shiv mandir, Floor: 2 floor', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', NULL, NULL, NULL, 599.00, 0.00, 107.82, 706.82, 0, 0, 5, 'AC Deep Cleaning', 2, NULL, '[33,37,1,25,38]', '2026-01-27 20:00:00', '2026-01-27 18:59:52', '2026-01-27 18:59:52', 1, NULL, '5289', 'service ', NULL, NULL, NULL),
(48, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near shiv mandir, Floor: 2 floor', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 0, 1, 'AC Cooling Service', 1, NULL, '[33,37,1,25,38]', '2026-01-27 20:01:00', '2026-01-27 19:01:10', '2026-01-27 19:01:10', 1, NULL, '9901', 'service ', NULL, NULL, NULL),
(49, '121, Jankipuram Police Station, Sultanpur Village, Jankipuram Extension, Balamau, Uttar Pradesh, India, Near police station, Floor: 2', '26.92610643092992', '80.93939166516066', 18, 'ANSAL', '9651511938', NULL, NULL, NULL, 599.00, 0.00, 107.82, 706.82, 0, 0, 5, 'AC Deep Cleaning', 1, NULL, '[38,33,37,1,25]', '2026-01-28 12:17:00', '2026-01-28 12:12:07', '2026-01-28 12:12:07', 1, NULL, '1833', 'cannot cancil ', NULL, NULL, NULL),
(50, '121, Jankipuram Police Station, Sultanpur Village, Jankipuram Extension, Balamau, Uttar Pradesh, India, Near police station, Floor: 2', '26.92610643092992', '80.93939166516066', 18, 'ANSAL', '9651511938', NULL, NULL, NULL, 599.00, 0.00, 107.82, 706.82, 0, 0, 5, 'AC Deep Cleaning', 1, NULL, '[38,1,33,37,25]', '2026-01-28 12:22:00', '2026-01-28 12:17:43', '2026-01-28 12:17:43', 1, NULL, '2891', '', NULL, NULL, NULL),
(51, 'vhhhf, 1/798, Sector H Road, Sector H, Jankipuram, Lucknow, Uttar Pradesh, India, Near vhjjj, Floor: 4', '26.919232342863356', '80.95782212913036', 3, 'pankaj ji', '9876543210', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 0, 1, 'AC Cooling Service', 2, NULL, '[38,33,1,37,25]', '2026-01-29 13:57:00', '2026-01-29 09:58:09', '2026-01-29 09:58:09', 1, NULL, '8753', '', NULL, NULL, NULL),
(52, 'vhhhf, 1/798, Sector H Road, Sector H, Jankipuram, Lucknow, Uttar Pradesh, India, Near vhjjj, Floor: 4', '26.919232342863356', '80.95782212913036', 3, 'pankaj ji', '9876543210', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 5, 1, 'AC Cooling Service', 1, NULL, '[38,33,37,1,25]', '2026-01-30 15:37:00', '2026-01-29 15:37:43', '2026-01-29 15:37:43', 1, 'ho gyaa', '7189', '', NULL, NULL, NULL),
(53, 'vhhhf, 1/798, Sector H Road, Sector H, Jankipuram, Lucknow, Uttar Pradesh, India, Near vhjjj, Floor: 4', '26.919232342863356', '80.95782212913036', 3, 'pankaj ji', '9876543210', 1, 'ramu sharmaa', '9876543211', 499.00, 0.00, 89.82, 588.82, 0, 4, 1, 'AC Cooling Service', 1, NULL, '[38,33,1,37,25]', '2026-01-31 15:44:00', '2026-01-29 15:44:25', '2026-01-29 15:44:25', 1, NULL, '4471', '', 4, 3.20, NULL),
(54, 'vhhhf, 1/798, Sector H Road, Sector H, Jankipuram, Lucknow, Uttar Pradesh, India, Near vhjjj, Floor: 4', '26.919232342863356', '80.95782212913036', 3, 'pankaj ji', '9876543210', 1, 'ramu sharmaa', '9876543211', 499.00, 0.00, 89.82, 588.82, 0, 4, 1, 'AC Cooling Service', 2, 4, '[38,33,37,25,1]', '2026-02-06 22:58:00', '2026-02-06 17:57:18', '2026-02-06 17:57:18', 1, NULL, '6944', '', NULL, 3.20, NULL),
(55, 'bjbjb, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near vhvhhv, Floor: hvh', '26.943490817583424', '80.94053294509649', 4, 'Ramu  Sharma ', '8423953286', 1, 'ramu sharmaa', '9876543211', 499.00, 0.00, 89.82, 588.82, 0, 4, 1, 'AC Cooling Service', 2, NULL, '[33,37,25,1,38]', '2026-02-09 20:59:00', '2026-02-09 15:59:22', '2026-02-09 15:59:22', 1, NULL, '1384', '', NULL, 0.01, '[4]'),
(56, 'bjbjb, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near vhvhhv, Floor: hvh', '26.943490817583424', '80.94053294509649', 4, 'Ramu  Sharma ', '8423953286', 1, 'ramu sharmaa', '9876543211', 499.00, 0.00, 89.82, 588.82, 0, 6, 1, 'AC Cooling Service', 1, NULL, '[33,37,25,1,38]', '2026-02-09 18:14:00', '2026-02-09 16:15:13', '2026-02-09 16:15:13', 1, 'bhjh', '2421', '', NULL, 0.01, NULL),
(57, 'bjbjb, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near vhvhhv, Floor: hvh', '26.943490817583424', '80.94053294509649', 4, 'Ramu  Sharma ', '8423953286', 1, 'ramu sharmaa', '9876543211', 499.00, 0.00, 89.82, 588.82, 0, 6, 1, 'AC Cooling Service', 1, NULL, '[33,37,25,1,38]', '2026-02-09 19:49:00', '2026-02-09 16:24:56', '2026-02-09 16:24:56', 1, 'jgjf', '4495', '', NULL, 0.01, NULL),
(58, 'bjbjb, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near vhvhhv, Floor: hvh', '26.943490817583424', '80.94053294509649', 4, 'Ramu  Sharma ', '8423953286', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 5, 1, 'AC Cooling Service', 1, NULL, '[37,25,1,38,33]', '2026-02-10 16:26:00', '2026-02-09 16:26:30', '2026-02-09 16:26:30', 1, 'vvhgh', '6760', '', NULL, NULL, NULL),
(59, 'bjbjb, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near vhvhhv, Floor: hvh', '26.943490817583424', '80.94053294509649', 4, 'Ramu  Sharma ', '8423953286', 33, 'ramu sharma', '8423953287', 499.00, 0.00, 89.82, 588.82, 0, 1, 1, 'AC Cooling Service', 2, NULL, '[37,25,1,38,33]', '2026-02-10 17:14:00', '2026-02-09 17:15:07', '2026-02-09 17:15:07', 1, NULL, '4799', '', NULL, 0.00, NULL),
(60, 'bjbjb, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near vhvhhv, Floor: hvh', '26.943490817583424', '80.94053294509649', 4, 'Ramu  Sharma ', '8423953286', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 0, 1, 'AC Cooling Service', 1, NULL, '[37,25,38,33]', '2026-02-09 19:17:00', '2026-02-09 17:17:42', '2026-02-09 17:17:42', 1, NULL, '9123', '', NULL, NULL, '[33,1]'),
(61, 'bjbjb, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near vhvhhv, Floor: hvh', '26.943490817583424', '80.94053294509649', 4, 'Ramu  Sharma ', '8423953286', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 0, 1, 'AC Cooling Service', 1, NULL, '[37,25,1,38,33]', '2026-02-09 18:23:00', '2026-02-09 17:23:29', '2026-02-09 17:23:29', 1, NULL, '6428', '', NULL, NULL, '[33]'),
(62, 'bjbjb, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near vhvhhv, Floor: hvh', '26.943490817583424', '80.94053294509649', 4, 'Ramu  Sharma ', '8423953286', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 0, 1, 'AC Cooling Service', 1, NULL, '[33,37,25,38]', '2026-02-09 18:23:00', '2026-02-09 17:35:57', '2026-02-09 17:35:57', 1, NULL, '4509', '', NULL, NULL, '[1]'),
(63, 'bjbjb, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near vhvhhv, Floor: hvh', '26.943490817583424', '80.94053294509649', 4, 'Ramu  Sharma ', '8423953286', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 0, 1, 'AC Cooling Service', 1, NULL, '[33,37,25,1,38]', '2026-02-09 18:23:00', '2026-02-09 17:38:17', '2026-02-09 17:38:17', 1, NULL, '2077', '', NULL, NULL, NULL),
(64, 'bjbjb, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near vhvhhv, Floor: hvh', '26.943490817583424', '80.94053294509649', 4, 'Ramu  Sharma ', '8423953286', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 0, 1, 'AC Cooling Service', 1, NULL, '[33,37,25,38]', '2026-02-09 18:23:00', '2026-02-09 17:48:13', '2026-02-09 17:48:13', 1, NULL, '9402', '', NULL, NULL, '[1]'),
(65, 'bjbjb, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near vhvhhv, Floor: hvh', '26.943490817583424', '80.94053294509649', 4, 'Ramu  Sharma ', '8423953286', 1, 'ramu sharmaa', '9876543211', 499.00, 0.00, 89.82, 588.82, 0, 1, 1, 'AC Cooling Service', 1, NULL, '[33,37,25,1,38]', '2026-02-09 18:23:00', '2026-02-09 18:02:27', '2026-02-09 18:02:27', 1, NULL, '6539', '', NULL, 0.01, NULL),
(66, 'bjbjb, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near vhvhhv, Floor: hvh', '26.943490817583424', '80.94053294509649', 4, 'Ramu  Sharma ', '8423953286', 1, 'ramu sharmaa', '9876543211', 499.00, 0.00, 89.82, 588.82, 0, 1, 1, 'AC Cooling Service', 1, NULL, '[33,37,25,1,38]', '2026-02-09 18:23:00', '2026-02-09 18:04:40', '2026-02-09 18:04:40', 1, NULL, '8172', '', NULL, 0.01, NULL),
(67, 'vhhhf, 1/798, Sector H Road, Sector H, Jankipuram, Lucknow, Uttar Pradesh, India, Near vhjjj, Floor: 4', '26.919232342863356', '80.95782212913036', 3, 'pankaj ji', '9876543210', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 0, 1, 'AC Cooling Service', 1, NULL, '[38,33,37,25]', '2026-02-10 09:00:00', '2026-02-09 18:32:56', '2026-02-09 18:32:56', 1, NULL, '7354', '', NULL, NULL, '[\"1\"]'),
(68, 'vhhhf, 1/798, Sector H Road, Sector H, Jankipuram, Lucknow, Uttar Pradesh, India, Near vhjjj, Floor: 4', '26.919232342863356', '80.95782212913036', 3, 'pankaj ji', '9876543210', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 0, 1, 'AC Cooling Service', 1, NULL, '[38,33,37,25]', '2026-02-10 15:08:00', '2026-02-09 18:36:03', '2026-02-09 18:36:03', 1, NULL, '6284', '', NULL, NULL, '[\"1\"]'),
(69, 'vhhhf, 1/798, Sector H Road, Sector H, Jankipuram, Lucknow, Uttar Pradesh, India, Near vhjjj, Floor: 4', '26.919232342863356', '80.95782212913036', 3, 'pankaj ji', '9876543210', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 0, 1, 'AC Cooling Service', 1, NULL, '[38,33,37,25]', '2026-02-10 15:08:00', '2026-02-09 18:45:00', '2026-02-09 18:45:00', 1, NULL, '7265', '', NULL, NULL, '[\"1\"]'),
(70, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near shiv mandir, Floor: 2 floor', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', 38, 'AMAN mishra', '9559960255', 800.00, 0.00, 144.00, 944.00, 0, 6, 9, 'A all home Switch Repair', 1, NULL, '[33,25,1,38]', '2026-02-13 22:27:00', '2026-02-13 21:27:37', '2026-02-13 21:27:37', 1, 'not working', '5749', '', NULL, 7.09, NULL),
(71, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near shiv mandir, Floor: 2 floor', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', 38, 'AMAN mishra', '9559960255', 1100.00, 0.00, 198.00, 1298.00, 0, 6, 6, 'AC Gas Refillings', 1, NULL, '[33,37,25,1,38]', '2026-02-13 22:31:00', '2026-02-13 21:31:07', '2026-02-13 21:31:07', 1, 'not working', '9157', '', NULL, 7.09, NULL),
(72, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near shiv mandir, Floor: 2 floor', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 0, 1, 'AC Cooling Service', 1, NULL, '[33,37,25,1,38]', '2026-02-13 21:37:00', '2026-02-13 21:37:42', '2026-02-13 21:37:42', 1, NULL, '5485', '', NULL, NULL, NULL),
(73, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near shiv mandir, Floor: 2 floor', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 0, 1, 'AC Cooling Service', 1, NULL, '[33,37,25,1,38]', '2026-02-13 21:37:00', '2026-02-13 21:38:52', '2026-02-13 21:38:52', 1, NULL, '2328', '', NULL, NULL, NULL),
(74, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near shiv mandir, Floor: 2 floor', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', 38, 'AMAN mishra', '9559960255', 499.00, 0.00, 89.82, 588.82, 0, 3, 1, 'AC Cooling Service', 1, NULL, '[33,37,25,1,38]', '2026-02-13 21:45:00', '2026-02-13 21:39:22', '2026-02-13 21:39:22', 1, NULL, '3632', '', NULL, 7.09, NULL),
(75, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near shiv mandir, Floor: 2 floor', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', 38, 'AMAN mishra', '9559960255', 800.00, 0.00, 144.00, 944.00, 0, 3, 9, 'A all home Switch Repair', 1, NULL, '[33,25,1,38]', '2026-02-13 21:55:00', '2026-02-13 21:40:56', '2026-02-13 21:40:56', 1, NULL, '8278', '', NULL, 7.09, NULL),
(76, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near shiv mandir, Floor: 2 floor', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', NULL, NULL, NULL, 349.00, 0.00, 62.82, 411.82, 0, 0, 4, 'Furniture Repair', 1, NULL, '[33,25,1]', '2026-02-14 10:31:00', '2026-02-14 09:31:09', '2026-02-14 09:31:09', 1, NULL, '5356', '', NULL, NULL, NULL),
(77, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near shiv mandir, Floor: 2 floor', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', NULL, NULL, NULL, 800.00, 0.00, 144.00, 944.00, 0, 0, 9, 'A all home Switch Repair', 1, NULL, '[33,25,1]', '2026-02-14 10:33:00', '2026-02-14 09:32:37', '2026-02-14 09:32:37', 1, NULL, '3412', '', NULL, NULL, '[\"38\"]'),
(78, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near shiv mandir, Floor: 2 floor', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', 38, 'AMAN mishra', '9559960255', 499.00, 0.00, 89.82, 588.82, 0, 6, 1, 'AC Cooling Service', 1, NULL, '[33,37,25,1,38]', '2026-02-14 11:34:00', '2026-02-14 09:33:55', '2026-02-14 09:33:55', 1, 'not working', '2889', '', NULL, 7.08, NULL),
(79, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near shiv mandir, Floor: 2 floor', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', 38, 'AMAN mishra', '9559960255', 800.00, 0.00, 144.00, 944.00, 0, 3, 9, 'A all home Switch Repair', 1, NULL, '[33,25,1,38]', '2026-02-14 10:45:00', '2026-02-14 09:37:17', '2026-02-14 09:37:17', 1, NULL, '1570', '', NULL, 7.08, NULL),
(80, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near shiv mandir, Floor: 2 floor', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', 38, 'AMAN mishra', '9559960255', 800.00, 0.00, 144.00, 944.00, 0, 6, 9, 'A all home Switch Repair', 2, NULL, '[33,25,1,38]', '2026-02-14 10:45:00', '2026-02-14 04:11:53', '2026-02-14 09:40:25', 1, 'not working', '9978', '', NULL, 7.08, NULL),
(81, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near shiv mandir, Floor: 2 floor', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', 38, 'AMAN mishra', '9559960255', 499.00, 0.00, 89.82, 588.82, 0, 6, 1, 'AC Cooling Service', 1, NULL, '[33,37,25,1,38]', '2026-02-14 10:45:00', '2026-02-14 09:45:51', '2026-02-14 09:45:51', 1, 'not working', '8956', '', NULL, 7.08, NULL),
(82, 'aktu, 301, Lucknow, Uttar Pradesh, 226031, Near aktu, Floor: aktu', '26.944491474074145', '80.93891724944115', 42, 'pragya', '7705018444', NULL, NULL, NULL, 200.00, 0.00, 36.00, 236.00, 0, 0, 8, 'Plant care man', 1, NULL, '[1,25,37,33]', '2026-02-14 13:07:00', '2026-02-14 10:01:29', '2026-02-14 10:01:29', 1, NULL, '2272', '', NULL, NULL, NULL),
(83, 'aktu, 301, Lucknow, Uttar Pradesh, 226031, Near aktu, Floor: aktu', '26.944491474074145', '80.93891724944115', 42, 'pragya', '7705018444', NULL, NULL, NULL, 200.00, 0.00, 36.00, 236.00, 0, 0, 8, 'Plant care man', 1, NULL, '[1,25,37,33]', '2026-02-19 16:15:00', '2026-02-14 10:12:18', '2026-02-14 10:12:18', 1, NULL, '7369', '', NULL, NULL, NULL),
(84, 'aktu, 301, Lucknow, Uttar Pradesh, 226031, Near aktu, Floor: aktu', '26.944491474074145', '80.93891724944115', 42, 'pragya', '7705018444', NULL, NULL, NULL, 200.00, 0.00, 36.00, 236.00, 0, 0, 8, 'Plant care man', 1, NULL, '[1,25,37,33]', '2026-02-19 16:15:00', '2026-02-14 10:14:23', '2026-02-14 10:14:23', 1, NULL, '7787', '', NULL, NULL, NULL),
(85, 'aktu, 301, Lucknow, Uttar Pradesh, 226031, Near aktu, Floor: aktu', '26.944491474074145', '80.93891724944115', 42, 'pragya', '7705018444', NULL, NULL, NULL, 200.00, 0.00, 36.00, 236.00, 0, 0, 8, 'Plant care man', 1, NULL, '[1,25,37,33]', '2026-02-19 13:17:00', '2026-02-14 10:14:58', '2026-02-14 10:14:58', 1, NULL, '8000', '', NULL, NULL, NULL),
(86, 'aktu, 301, Lucknow, Uttar Pradesh, 226031, Near aktu, Floor: aktu', '26.944491474074145', '80.93891724944115', 42, 'pragya', '7705018444', NULL, NULL, NULL, 200.00, 0.00, 36.00, 236.00, 0, 0, 8, 'Plant care man', 1, NULL, '[1,25,37,33]', '2026-02-19 13:17:00', '2026-02-14 10:18:23', '2026-02-14 10:18:23', 1, NULL, '6104', '', NULL, NULL, NULL),
(87, 'aktu, 301, Lucknow, Uttar Pradesh, 226031, Near aktu, Floor: aktu', '26.944491474074145', '80.93891724944115', 42, 'pragya', '7705018444', NULL, NULL, NULL, 200.00, 0.00, 36.00, 236.00, 0, 0, 8, 'Plant care man', 1, NULL, '[1,25,37,33]', '2026-02-19 13:17:00', '2026-02-14 10:18:34', '2026-02-14 10:18:34', 1, NULL, '4887', '', NULL, NULL, NULL),
(88, 'aktu, 301, Lucknow, Uttar Pradesh, 226031, Near aktu, Floor: aktu', '26.944491474074145', '80.93891724944115', 42, 'pragya', '7705018444', NULL, NULL, NULL, 200.00, 0.00, 36.00, 236.00, 0, 0, 8, 'Plant care man', 1, NULL, '[25,37,33]', '2026-02-19 13:17:00', '2026-02-14 10:19:50', '2026-02-14 10:19:50', 1, NULL, '3438', '', NULL, NULL, '[\"1\"]'),
(89, 'aktu, 301, Lucknow, Uttar Pradesh, 226031, Near aktu, Floor: aktu', '26.944491474074145', '80.93891724944115', 42, 'pragya', '7705018444', NULL, NULL, NULL, 200.00, 0.00, 36.00, 236.00, 0, 0, 8, 'Plant care man', 1, NULL, '[25,37,33]', '2026-02-19 13:17:00', '2026-02-14 10:21:38', '2026-02-14 10:21:38', 1, NULL, '6043', '', NULL, NULL, '[\"1\"]'),
(90, 'aktu, 301, Lucknow, Uttar Pradesh, 226031, Near aktu, Floor: aktu', '26.944491474074145', '80.93891724944115', 42, 'pragya', '7705018444', NULL, NULL, NULL, 200.00, 0.00, 36.00, 236.00, 0, 7, 8, 'Plant care man', 1, NULL, '[]', '2026-02-20 17:47:00', '2026-02-14 14:44:14', '2026-02-14 14:44:14', 1, NULL, '2318', '', NULL, NULL, '[\"1\"]'),
(91, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near shiv mandir, Floor: 2 floor', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', NULL, NULL, NULL, 800.00, 0.00, 144.00, 944.00, 0, 7, 9, 'A all home Switch Repair', 1, NULL, '[]', '2026-02-14 20:20:00', '2026-02-14 19:19:14', '2026-02-14 19:19:14', 1, NULL, '8980', '', NULL, NULL, '[\"38\"]'),
(92, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near shiv mandir, Floor: 2 floor', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', 38, 'AMAN mishra', '9559960255', 499.00, 0.00, 89.82, 588.82, 0, 6, 1, 'AC Cooling Service', 1, NULL, '[38]', '2026-02-14 20:21:00', '2026-02-14 19:21:07', '2026-02-14 19:21:07', 1, 'not working', '4215', '', NULL, 7.22, NULL),
(93, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near shiv mandir, Floor: 2 floor', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 7, 1, 'AC Cooling Service', 1, NULL, '[]', '2026-02-14 20:24:00', '2026-02-14 19:23:57', '2026-02-14 19:23:57', 1, NULL, '4334', '', NULL, NULL, '[\"38\"]'),
(94, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near shiv mandir, Floor: 2 floor', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 7, 1, 'AC Cooling Service', 1, NULL, '[]', '2026-02-14 20:28:00', '2026-02-14 19:27:14', '2026-02-14 19:27:14', 1, NULL, '8517', '', NULL, NULL, '[\"38\"]'),
(95, '12, Lucknow Outer Ring Road, Hardhaurpur, Uttar Pradesh, 226202, Near shiv mandir, Floor: 2', '27.003684151091246', '80.8725818619132', 17, 'aman', '7705827321', NULL, NULL, NULL, 800.00, 0.00, 144.00, 944.00, 0, 7, 9, 'A all home Switch Repair', 1, NULL, '[]', '2026-02-14 20:29:00', '2026-02-14 19:28:22', '2026-02-14 19:28:22', 1, NULL, '5778', '', NULL, NULL, '[\"38\"]'),
(96, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near shiv mandir, Floor: 2 floor', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', 38, 'AMAN mishra', '9559960255', 499.00, 0.00, 89.82, 588.82, 0, 3, 1, 'AC Cooling Service', 1, NULL, '[38]', '2026-02-14 20:31:00', '2026-02-14 19:30:21', '2026-02-14 19:30:21', 1, NULL, '9009', '', NULL, 7.22, NULL),
(97, '12, Lucknow Outer Ring Road, Hardhaurpur, Uttar Pradesh, 226202, Near shiv mandir, Floor: 2', '27.003684151091246', '80.8725818619132', 17, 'aman', '7705827321', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 5, 1, 'AC Cooling Service', 1, NULL, '[38]', '2026-02-14 20:48:00', '2026-02-14 19:48:47', '2026-02-14 19:48:47', 1, 'not working', '3439', '', NULL, NULL, NULL),
(98, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near shiv mandir, Floor: 2 floor', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', 38, 'AMAN mishra', '9559960255', 499.00, 0.00, 89.82, 588.82, 0, 3, 1, 'AC Cooling Service', 1, NULL, '[38]', '2026-02-14 20:00:00', '2026-02-14 19:59:40', '2026-02-14 19:59:40', 1, NULL, '2329', '', NULL, 7.24, NULL),
(99, '121, Jankipuram Police Station, Sultanpur Village, Jankipuram Extension, Balamau, Uttar Pradesh, India, Near police station, Floor: 2', '26.92610643092992', '80.93939166516066', 18, 'ANSAL', '9651511938', 38, 'AMAN mishra', '9559960255', 800.00, 0.00, 144.00, 944.00, 0, 4, 9, 'A all home Switch Repair', 1, NULL, '[38]', '2026-02-16 17:41:00', '2026-02-16 16:40:46', '2026-02-16 16:40:46', 1, NULL, '5851', '', NULL, 6.30, NULL),
(100, '121, Jankipuram Police Station, Sultanpur Village, Jankipuram Extension, Balamau, Uttar Pradesh, India, Near police station, Floor: 2', '26.92610643092992', '80.93939166516066', 18, 'ANSAL', '9651511938', 38, 'AMAN mishra', '9559960255', 1100.00, 0.00, 198.00, 1298.00, 0, 4, 6, 'AC Gas Refillings', 1, NULL, '[38]', '2026-02-16 17:48:00', '2026-02-16 16:47:52', '2026-02-16 16:47:52', 1, NULL, '7222', '', NULL, 6.30, NULL),
(101, '121, Jankipuram Police Station, Sultanpur Village, Jankipuram Extension, Balamau, Uttar Pradesh, India, Near police station, Floor: 2', '26.92610643092992', '80.93939166516066', 18, 'ANSAL', '9651511938', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 0, 1, 'AC Cooling Service', 1, NULL, '[]', '2026-02-18 20:37:00', '2026-02-18 18:37:45', '2026-02-18 18:37:45', 1, NULL, '7601', '', NULL, NULL, NULL),
(102, '121, Jankipuram Police Station, Sultanpur Village, Jankipuram Extension, Balamau, Uttar Pradesh, India, Near police station, Floor: 2', '26.92610643092992', '80.93939166516066', 18, 'ANSAL', '9651511938', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 0, 1, 'AC Cooling Service', 1, NULL, '[]', '2026-02-18 20:37:00', '2026-02-18 18:38:24', '2026-02-18 18:38:24', 1, NULL, '1730', '', NULL, NULL, NULL),
(103, '121, Jankipuram Police Station, Sultanpur Village, Jankipuram Extension, Balamau, Uttar Pradesh, India, Near police station, Floor: 2', '26.92610643092992', '80.93939166516066', 18, 'ANSAL', '9651511938', NULL, NULL, NULL, 800.00, 0.00, 144.00, 944.00, 0, 0, 9, 'A all home Switch Repair', 1, NULL, '[]', '2026-02-18 20:38:00', '2026-02-18 18:39:03', '2026-02-18 18:39:03', 1, NULL, '8623', '', NULL, NULL, NULL),
(104, 'sitapur, Khairabad, Sitapur, Uttar Pradesh, 261131, Near mandir, Floor: 2', '27.52225500066362', '80.73881842195988', 18, 'ANSAL', '9651511938', NULL, NULL, NULL, 700.00, 0.00, 126.00, 826.00, 0, 0, 7, 'Home sweet home, where dreams are designed.', 1, NULL, '[]', '2026-02-18 20:44:00', '2026-02-18 18:43:36', '2026-02-18 18:43:36', 1, NULL, '2003', '', NULL, NULL, NULL),
(105, '121, Jankipuram Police Station, Sultanpur Village, Jankipuram Extension, Balamau, Uttar Pradesh, India, Near police station, Floor: 2', '26.92610643092992', '80.93939166516066', 18, 'ANSAL', '9651511938', NULL, NULL, NULL, 800.00, 0.00, 144.00, 944.00, 0, 0, 9, 'A all home Switch Repair', 1, NULL, '[]', '2026-02-18 20:45:00', '2026-02-18 18:45:58', '2026-02-18 18:45:58', 1, NULL, '3714', '', NULL, NULL, NULL),
(106, 'vhhhf, 1/798, Sector H Road, Sector H, Jankipuram, Lucknow, Uttar Pradesh, India, Near vhjjj, Floor: 4', '26.919232342863356', '80.95782212913036', 3, 'pankaj ji', '9876543210', 1, 'ramu sharmaa', '9876543211', 499.00, 0.00, 89.82, 588.82, 0, 4, 1, 'AC Cooling Service', 2, NULL, '[1]', '2026-02-19 19:01:00', '2026-02-19 10:01:21', '2026-02-19 10:01:21', 1, NULL, '2440', '', NULL, 3.20, NULL),
(107, 'vhhhf, 1/798, Sector H Road, Sector H, Jankipuram, Lucknow, Uttar Pradesh, India, Near vhjjj, Floor: 4', '26.919232342863356', '80.95782212913036', 3, 'pankaj ji', '9876543210', NULL, NULL, NULL, 200.00, 0.00, 36.00, 236.00, 0, 7, 8, 'Plant care man', 2, NULL, '[]', '2026-02-19 17:02:00', '2026-02-19 10:02:51', '2026-02-19 10:02:51', 1, NULL, '1988', '', NULL, NULL, '[\"1\"]'),
(108, 'vhhhf, 1/798, Sector H Road, Sector H, Jankipuram, Lucknow, Uttar Pradesh, India, Near vhjjj, Floor: 4', '26.919232342863356', '80.95782212913036', 3, 'Niranjan  Sharma ', '9876543210', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 5, 1, 'AC Cooling Service', 1, NULL, '[38]', '2026-02-21 19:39:00', '2026-02-21 18:03:42', '2026-02-21 18:03:42', 1, 'vggh', '6148', '', NULL, NULL, NULL),
(109, 'vhhhf, 1/798, Sector H Road, Sector H, Jankipuram, Lucknow, Uttar Pradesh, India, Near vhjjj, Floor: 4', '26.919232342863356', '80.95782212913036', 3, 'Niranjan  Sharma ', '9876543210', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 0, 1, 'AC Cooling Service', 1, NULL, '[38]', '2026-02-21 23:04:00', '2026-02-21 18:04:28', '2026-02-21 18:04:28', 1, NULL, '3611', '', NULL, NULL, NULL),
(110, 'vhhhf, 1/798, Sector H Road, Sector H, Jankipuram, Lucknow, Uttar Pradesh, India, Near vhjjj, Floor: 4', '26.919232342863356', '80.95782212913036', 3, 'Niranjan  Sharma ', '9876543210', 38, 'AMAN mishra', '9559960255', 499.00, 0.00, 89.82, 588.82, 0, 4, 1, 'AC Cooling Service', 1, NULL, '[38]', '2026-02-21 20:11:00', '2026-02-21 18:08:41', '2026-02-21 18:08:41', 1, NULL, '8114', '', NULL, 2.62, NULL),
(111, 'sghh, CN242, New Delhi, Delhi, 110074, Near vghh, Floor: ghu', '28.504513353635', '77.18335423618555', 56, 'dpal ', '8740803396', NULL, NULL, NULL, 1100.00, 0.00, 198.00, 1298.00, 0, 0, 6, 'AC Gas Refillings', 2, 5, '[]', '2026-02-28 13:16:00', '2026-02-27 13:16:21', '2026-02-27 13:16:21', 1, NULL, '6321', '', NULL, NULL, NULL),
(112, '00, J.P.Hospital, Lucknow, Uttar Pradesh, 226021', '26.939990542161436', '80.95716129988432', 57, 'Abhi', '9565789026', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 5, 1, 'AC Cooling Service', 1, 5, '[38]', '2026-02-27 16:38:00', '2026-02-27 16:38:35', '2026-02-27 16:38:35', 1, 'a', '8584', '', NULL, NULL, NULL),
(113, '00, J.P.Hospital, Lucknow, Uttar Pradesh, 226021', '26.939990542161436', '80.95716129988432', 57, 'Abhi', '9565789026', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 5, 1, 'AC Cooling Service', 1, 5, '[38]', '2026-02-27 16:38:00', '2026-02-27 16:39:27', '2026-02-27 16:39:27', 1, 'a', '2755', '', NULL, NULL, NULL),
(114, '00, J.P.Hospital, Lucknow, Uttar Pradesh, 226021', '26.939990542161436', '80.95716129988432', 57, 'Abhi', '9565789026', 38, 'AMAN mishra', '9559960255', 499.00, 0.00, 89.82, 588.82, 0, 3, 1, 'AC Cooling Service', 2, 5, '[38]', '2026-02-27 17:41:00', '2026-02-27 11:11:56', '2026-02-27 16:40:26', 1, NULL, '2988', '', NULL, 0.00, NULL),
(115, '00, J.P.Hospital, Lucknow, Uttar Pradesh, 226021', '26.939990542161436', '80.95716129988432', 57, 'Abhi', '9565789026', 38, 'AMAN mishra', '9559960255', 1100.00, 0.00, 198.00, 1298.00, 0, 6, 6, 'AC Gas Refillings', 1, NULL, '[38]', '2026-02-27 18:50:00', '2026-02-27 16:49:58', '2026-02-27 16:49:58', 1, 'costumer nahi mila', '6587', '', NULL, 0.00, NULL),
(116, '78, 647B/J-PN-084(K-825, Lucknow, Uttar Pradesh, 226026', '26.92952045050312', '80.96583757549524', 57, 'Abhi', '9565789026', NULL, NULL, NULL, 999.00, 0.00, 179.82, 1178.82, 0, 5, 10, 'plumbing leakage repari service', 1, NULL, '[]', '2026-02-27 17:03:00', '2026-02-27 17:03:03', '2026-02-27 17:03:03', 1, 'a', '8823', '', NULL, NULL, NULL),
(117, '78, 647B/J-PN-084(K-825, Lucknow, Uttar Pradesh, 226026', '26.92952045050312', '80.96583757549524', 57, 'Abhi', '9565789026', NULL, NULL, NULL, 999.00, 0.00, 179.82, 1178.82, 0, 5, 10, 'plumbing leakage repari service', 1, NULL, '[38]', '2026-02-27 17:03:00', '2026-02-27 17:03:44', '2026-02-27 17:03:44', 1, 'a', '2183', '', NULL, NULL, NULL),
(118, '78, 647B/J-PN-084(K-825, Lucknow, Uttar Pradesh, 226026', '26.92952045050312', '80.96583757549524', 57, 'Abhi', '9565789026', NULL, NULL, NULL, 349.00, 0.00, 62.82, 411.82, 0, 5, 4, 'Furniture Repair', 1, NULL, '[]', '2026-02-27 17:04:00', '2026-02-27 17:04:29', '2026-02-27 17:04:29', 1, 'a', '3913', '', NULL, NULL, NULL),
(119, '78, 647B/J-PN-084(K-825, Lucknow, Uttar Pradesh, 226026', '26.92952045050312', '80.96583757549524', 57, 'Abhi', '9565789026', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 5, 1, 'AC Cooling Service', 1, NULL, '[38]', '2026-02-27 17:05:00', '2026-02-27 17:05:33', '2026-02-27 17:05:33', 1, 'a', '3871', '', NULL, NULL, NULL),
(120, '78, 647B/J-PN-084(K-825, Lucknow, Uttar Pradesh, 226026', '26.92952045050312', '80.96583757549524', 57, 'Abhi', '9565789026', NULL, NULL, NULL, 800.00, 0.00, 144.00, 944.00, 0, 0, 9, 'A all home Switch Repair', 1, NULL, '[38]', '2026-02-27 17:07:00', '2026-02-27 17:07:36', '2026-02-27 17:07:36', 1, NULL, '3563', '', NULL, NULL, NULL),
(121, 'vhhhf, 1/798, Sector H Road, Sector H, Jankipuram, Lucknow, Uttar Pradesh, India, Near vhjjj, Floor: 4', '26.919232342863356', '80.95782212913036', 3, 'Niranjan  Sharma ', '9876543210', NULL, NULL, NULL, 400.00, 0.00, NULL, 400.00, 0, 5, 8, 'Plant care man', 1, NULL, '[]', '2026-02-28 18:24:00', '2026-02-28 13:25:54', '2026-02-28 13:25:54', 2, 'ngjg', '2616', '', NULL, NULL, NULL),
(122, '12, Lucknow Outer Ring Road, Hardhaurpur, Uttar Pradesh, 226202, Near shiv mandir, Floor: 2', '27.003684151091246', '80.8725818619132', 17, 'aman', '7705827321', NULL, NULL, NULL, 499.00, 0.00, NULL, 499.00, 0, 5, 1, 'AC Cooling Service', 1, NULL, '[]', '2026-03-05 15:21:00', '2026-03-05 14:20:17', '2026-03-05 14:20:17', 1, 'not working', '8825', '', NULL, NULL, NULL),
(123, '12, Lucknow Outer Ring Road, Hardhaurpur, Uttar Pradesh, 226202, Near shiv mandir, Floor: 2', '27.003684151091246', '80.8725818619132', 17, 'aman', '7705827321', NULL, NULL, NULL, 1100.00, 0.00, NULL, 1100.00, 0, 5, 6, 'AC Gas Refillings', 1, NULL, '[38]', '2026-03-05 15:33:00', '2026-03-05 14:34:40', '2026-03-05 14:34:40', 1, 'not working', '1167', '', NULL, NULL, NULL),
(124, '12, Lucknow Outer Ring Road, Hardhaurpur, Uttar Pradesh, 226202, Near shiv mandir, Floor: 2', '27.003684151091246', '80.8725818619132', 17, 'aman', '7705827321', NULL, NULL, NULL, 999.00, 0.00, NULL, 999.00, 0, 5, 10, 'plumbing leakage repari service', 1, NULL, '[38]', '2026-03-05 15:36:00', '2026-03-05 14:35:21', '2026-03-05 14:35:21', 1, 'not working', '3567', '', NULL, NULL, NULL),
(125, '12, Lucknow Outer Ring Road, Hardhaurpur, Uttar Pradesh, 226202, Near shiv mandir, Floor: 2', '27.003684151091246', '80.8725818619132', 17, 'aman', '7705827321', NULL, NULL, NULL, 999.00, 0.00, NULL, 999.00, 0, 5, 10, 'plumbing leakage repari service', 1, NULL, '[38]', '2026-03-05 15:36:00', '2026-03-05 14:36:05', '2026-03-05 14:36:05', 1, 'not working', '9691', '', NULL, NULL, NULL),
(126, '12A, Sushaantanu Dham, Lucknow, Uttar Pradesh, 226010, Near Kamakhya Devi Mandir, Floor: 2', '26.845236845722926', '81.0186680406332', 60, 'gautam ', '9794116633', NULL, NULL, NULL, 1100.00, 0.00, NULL, 1100.00, 0, 7, 6, 'AC Gas Refillings', 1, NULL, '[]', '2026-03-06 17:13:00', '2026-03-06 17:00:59', '2026-03-06 17:00:59', 1, NULL, '4781', '', NULL, NULL, '[\"38\"]'),
(127, '12A, Sushaantanu Dham, Lucknow, Uttar Pradesh, 226010, Near Kamakhya Devi Mandir, Floor: 2', '26.845236845722926', '81.0186680406332', 60, 'gautam ', '9794116633', 38, 'AMAN mishra', '9559960255', 1100.00, 0.00, NULL, 1100.00, 0, 3, 6, 'AC Gas Refillings', 2, NULL, '[38]', '2026-03-06 17:13:00', '2026-03-06 11:32:32', '2026-03-06 17:01:30', 1, NULL, '2833', '', NULL, 0.02, NULL),
(128, '12A, Sushaantanu Dham, Lucknow, Uttar Pradesh, 226010, Near Kamakhya Devi Mandir, Floor: 2', '26.845236845722926', '81.0186680406332', 60, 'gautam ', '9794116633', NULL, NULL, NULL, 349.00, 0.00, NULL, 349.00, 0, 0, 4, 'Furniture Repair', 1, NULL, '[]', '2026-03-06 17:30:00', '2026-03-06 17:03:24', '2026-03-06 17:03:24', 1, NULL, '3394', '', NULL, NULL, NULL),
(129, '12A, Sushaantanu Dham, Lucknow, Uttar Pradesh, 226010, Near Kamakhya Devi Mandir, Floor: 2', '26.845236845722926', '81.0186680406332', 60, 'gautam ', '9794116633', 38, 'AMAN mishra', '9559960255', 800.00, 0.00, NULL, 800.00, 0, 2, 9, 'A all home Switch Repair', 2, NULL, '[38]', '2026-03-06 18:04:00', '2026-03-06 11:34:56', '2026-03-06 17:04:10', 1, NULL, '3617', '', NULL, 0.03, NULL),
(130, '12, Lucknow Outer Ring Road, Hardhaurpur, Uttar Pradesh, 226202, Near shiv mandir, Floor: 2', '27.003684151091246', '80.8725818619132', 17, 'aman', '7705827321', NULL, NULL, NULL, 499.00, 0.00, NULL, 499.00, 0, 0, 1, 'AC Cooling Service', 1, NULL, '[]', '2026-03-09 15:41:00', '2026-03-09 14:40:11', '2026-03-09 14:40:11', 1, NULL, '7486', '', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `admin_label` varchar(100) NOT NULL,
  `value` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `name`, `admin_label`, `value`, `created_at`, `updated_at`) VALUES
(1, 'service_radius_km', 'Service Radius (KM)', '30', '2025-12-09 09:48:28', '2026-01-28 04:11:12'),
(2, 'platform_fee', 'Service Platform Fee (%)', '7.5', '2025-12-09 09:48:28', '2026-01-31 10:19:53'),
(3, 'due_limit', 'Service Provider Due Limit', '10000', '2025-12-09 09:48:28', '2026-01-27 05:38:24'),
(4, 'cab_platform_fee', 'Cab Platform Fee (%)', '6', '2025-12-09 09:48:28', '2026-01-23 08:45:43'),
(5, 'driver_due_limit', 'Driver Due Limit', '10000', '2025-12-09 09:48:28', '2026-01-27 05:37:54'),
(7, 'ride_radius_km', 'Service Radius (KM)', '40', '2025-12-09 09:48:28', '2026-01-28 03:42:09'),
(8, ' E-mail', ' E-mail', 'rainbowemployment40@gmail.com', '2025-12-09 09:48:28', '2026-01-31 10:19:30'),
(9, 'Support Mob', 'Support Mob', '9559960255', '2025-12-09 09:48:28', '2026-02-09 14:01:27');

-- --------------------------------------------------------

--
-- Table structure for table `subcategories`
--

CREATE TABLE `subcategories` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `subcategories`
--

INSERT INTO `subcategories` (`id`, `category_id`, `name`, `image`, `status`, `created_at`) VALUES
(1, 1, 'Garden Maintenance', 'categories/gardener-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(2, 1, 'Plant Care', 'categories/gardener-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(3, 1, 'Lawn Cleaning', 'categories/gardener-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(4, 2, 'AC Installation', 'categories/ac_coolcar.png', 1, '2025-12-06 08:43:21'),
(5, 2, 'AC Maintenance', 'categories/ac_coolcar.png', 1, '2025-12-06 08:43:21'),
(6, 2, 'AC Troubleshoot', 'categories/ac_coolcar.png', 1, '2025-12-06 08:43:21'),
(7, 2, 'AC Gas Refill', 'categories/ac_coolcar.png', 1, '2025-12-06 08:43:21'),
(8, 3, 'Wiring Work', 'categories/electrician-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(9, 3, 'Switch Repair', 'categories/electrician-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(10, 3, 'Appliance Repair', 'categories/electrician-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(11, 4, 'Home Chef', 'categories/cokking-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(12, 4, 'Event Cooking', 'categories/cokking-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(13, 5, 'Furniture Repair', 'categories/carpenter-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(14, 5, 'Wooden Work', 'categories/carpenter-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(15, 6, 'Home Cleaning', 'categories/cleaning-removebg-preview.png', 0, '2025-12-06 08:43:21'),
(16, 6, 'Kitchen Cleaning', 'categories/cleaning-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(17, 6, 'Bathroom Cleaning', 'categories/cleaning-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(18, 7, 'Washing', 'categories/laundry-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(19, 7, 'Ironing', 'categories/laundry-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(20, 8, 'Wall Painting', 'categories/painter-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(21, 8, 'Ceiling Painting', 'categories/painter-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(22, 9, 'Puja Services', 'categories/pandit-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(23, 9, 'Vastu Consultation', 'categories/pandit-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(24, 10, 'Wedding Shoot', 'categories/photography-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(25, 10, 'Birthday Shoot', 'categories/photography-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(26, 10, 'Product Shoot', 'categories/photography-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(27, 11, 'Cockroach Control', 'categories/pest_control-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(28, 11, 'Termite Control', 'categories/pest_control-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(29, 11, 'Rodent Control', 'categories/pest_control-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(30, 12, 'Tap Repair', 'categories/plumber-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(31, 12, 'Bathroom Fitting', 'categories/plumber-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(32, 12, 'Leakage Fix', 'categories/plumber-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(33, 13, 'PC Support', 'categories/remote_support-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(34, 13, 'Software Installation', 'categories/remote_support-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(35, 14, 'Hair Cutting', 'categories/salon-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(36, 14, 'Facial', 'categories/salon-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(37, 14, 'Makeup', 'categories/salon-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(38, 15, 'Home Sanitization', 'categories/sanitization-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(39, 15, 'Office Sanitization', 'categories/sanitization-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(40, 16, 'Appliance Setup', 'categories/automatic-removebg-preview.png', 1, '2025-12-06 08:43:21'),
(41, 16, 'CCTV Installation', 'categories/automatic-removebg-preview.png', 0, '2025-12-06 08:43:21'),
(42, 16, 'WiFi Setup', 'categories/automatic-removebg-preview.png', 0, '2025-12-06 08:43:21'),
(47, 9, 'antim sansakar', 'subcategories/1765197145704.png', 1, '2025-12-08 12:32:25'),
(48, 17, 'Home decoration', 'subcategories/1768648430535.jpg', 1, '2026-01-17 11:13:50'),
(49, 12, 'LEAKAGE FIX', 'subcategories/1769494789127.jpg', 1, '2026-01-27 06:20:18'),
(50, 18, 'FOUR WHEELER DRIVER', 'subcategories/1773153268142.jpg', 1, '2026-03-10 14:34:28'),
(51, 18, 'HEAVY  VEHICLE  DRIVER', 'subcategories/1773153518102.jpg', 1, '2026-03-10 14:38:38'),
(52, 18, 'TWO  WHEELER DRIVER', 'subcategories/1773153986971.jpg', 1, '2026-03-10 14:46:27'),
(53, 18, 'TRUCK DRIVER', 'subcategories/1773154115587.jpg', 1, '2026-03-10 14:48:35'),
(54, 18, 'BUS DRIVER', 'subcategories/1773154517972.jpg', 1, '2026-03-10 14:55:28');

-- --------------------------------------------------------

--
-- Table structure for table `top_service`
--

CREATE TABLE `top_service` (
  `id` int(11) NOT NULL,
  `image` varchar(50) DEFAULT NULL,
  `price` double(10,2) DEFAULT '0.00',
  `rating` int(10) DEFAULT NULL,
  `service_title` varchar(255) DEFAULT NULL,
  `service_description` longtext,
  `included_service` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(5) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `top_service`
--

INSERT INTO `top_service` (`id`, `image`, `price`, `rating`, `service_title`, `service_description`, `included_service`, `created_at`, `status`) VALUES
(1, 'topServicesImage/ac_service.png', 499.00, 5, 'AC Maintenance', 'This service provides expert inspection and maintenance ensuring efficient cooling, improved air quality, and long-lasting performance for your air conditioning system.', '[\r\n      { \"id\": 1, \"text\": \"Complete AC inspection\" },\r\n      { \"id\": 2, \"text\": \"Filter cleaning\" },\r\n      { \"id\": 3, \"text\": \"Cooling efficiency check\" },\r\n      { \"id\": 4, \"text\": \"Safety check-up\" }\r\n  ]', '2025-12-05 06:21:27', 1),
(2, 'topServicesImage/plumbing.png', 299.00, 5, 'Plumbing Repair', 'This service includes professional diagnosis and repair ensuring smooth water flow, leak prevention, quality workmanship, and reliable solutions for household plumbing needs.', '[\r\n      { \"id\": 1, \"text\": \"Expert technician visit\" },\r\n      { \"id\": 2, \"text\": \"All required tools\" },\r\n      { \"id\": 3, \"text\": \"Safety equipment\" },\r\n      { \"id\": 4, \"text\": \"90 days service warranty\" }\r\n  ]', '2025-12-05 06:21:27', 1),
(3, 'topServicesImage/electrician_repair.png', 399.00, 5, 'Electrical Work', 'This service ensures safe and reliable electrical repair, expert troubleshooting, high-quality components, and dependable solutions for switches, wiring, and household circuits.', '[\r\n      { \"id\": 1, \"text\": \"Expert electrician visit\" },\r\n      { \"id\": 2, \"text\": \"Standard repair tools included\" },\r\n      { \"id\": 3, \"text\": \"Electrical safety check\" },\r\n      { \"id\": 4, \"text\": \"Warranty on service\" }\r\n  ]', '2025-12-05 06:21:27', 1),
(4, 'topServicesImage/cleaining_repo.png', 799.00, 5, 'Deep Cleaning', 'This service provides intensive home cleaning with advanced tools ensuring hygiene, stain removal, dust-free spaces, and refreshing cleanliness for every corner of your home.', '[\r\n      { \"id\": 1, \"text\": \"Floor and surface cleaning\" },\r\n      { \"id\": 2, \"text\": \"Washroom deep cleanse\" },\r\n      { \"id\": 3, \"text\": \"Kitchen degreasing\" },\r\n      { \"id\": 4, \"text\": \"Dusting and sanitization\" }\r\n  ]', '2025-12-05 06:21:27', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(55) NOT NULL,
  `wallet` double(10,2) DEFAULT '0.00',
  `name` varchar(55) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `email` varchar(55) DEFAULT NULL,
  `phone` bigint(10) DEFAULT NULL,
  `status` int(2) DEFAULT '1',
  `image` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `fcm_token` varchar(200) DEFAULT NULL,
  `device_id` longtext,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reason` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `wallet`, `name`, `last_name`, `email`, `phone`, `status`, `image`, `city`, `fcm_token`, `device_id`, `updated_at`, `created_at`, `reason`) VALUES
(1, 600.00, 'Tanisha Sharma ', NULL, NULL, 7235947667, 1, 'ServicemanFiles/1765451127949.jpg', NULL, 'csoa4G7mRxGwU1tPTUfOCo:APA91bH1lVGvIiXqtCG1M1NP75VdcdFtLP18yFfuKjUMp8go5JpGsSZAVFV1tJ8rMj_Kp0ZDEc-2l9UyJL5yQXT1AkoQOgEtGcpAmOyWEXqv3eVX3i7Brxg', 'RP1A.200720.011', '2026-01-23 08:07:28', '2025-12-16 07:15:55', NULL),
(2, 300.00, 'harsh', NULL, NULL, 9793168164, 1, 'ServicemanFiles/1765451127949.jpg', NULL, 'eoxUxobiQ-OJXTruVTTe2s:APA91bHguJPQKINGsjP6Oge4zOIofbcizdKEWvd9TgKKWql_VcyhPffoDqHSzhT96QXCu8pF0Lm5LUqEzCBUXnF1k97p74jjDaaFRg8SNJm1W-JJ29aA5N0', 'RKQ1.201004.002', '2025-12-19 03:41:32', '2025-12-17 04:02:41', NULL),
(3, 1296.00, 'Niranjan ', 'Sharma ', 'ramusharmagr@gmail.com', 9876543210, 1, NULL, 'Lucknow', 'eWgKTGS8TaWfMFY7VVmfud:APA91bGb34XeR_cAw_wfgGJjDRmfEEqzAff9o87Gzt_pXV7fv8MWW-p_TiAqsfaFQj06eBta2HepuPKgZhvBOnT_wfLMEpyQ9R1fLfhfW_KzR4tQjZnNVio', 'RP1A.200720.011', '2026-03-08 05:55:44', '2025-12-18 10:22:32', NULL),
(4, 0.00, 'Ramu ', 'Sharma ', 'ramusharmagr@gmail.com', 8423953286, 1, 'UserprofileImage/1769067390512.jpg', 'Lucknow', 'f9IEdS5zSGauCIrqjwUjFK:APA91bEZn6o71-lBkaCCXJx7DB20hiWCf1z1nvmc8acJcLj1v-UmkBYw2DzB2jeKSiCJQpmiZ2kyumnkLwNv0MSVWF_9NRWGWxDKfHJnLqVOOZSo17_X7B0', 'RKQ1.201004.002', '2026-01-30 15:35:30', '2025-12-31 05:50:57', NULL),
(5, 0.00, 'lulu', NULL, NULL, 8547855558, 1, NULL, NULL, 'dp6PMgjHTXCJqrjRq7_IYF:APA91bH8c90l8Immsbb2-UAyRitr1Jwmhq9eXnbuYRVKQy2ZfZCpVsGr_g7jet5ODRxu-qchECOhDEgJC8PQC6uv2c-qwteor5JX6s9MioIkDQ8D2TMesQ8', 'UKQ1.230924.001', '2026-01-05 16:53:15', '2026-01-05 16:53:15', NULL),
(6, 0.00, 'gdgdgdh', NULL, NULL, 5989898595, 1, NULL, NULL, 'dp6PMgjHTXCJqrjRq7_IYF:APA91bH8c90l8Immsbb2-UAyRitr1Jwmhq9eXnbuYRVKQy2ZfZCpVsGr_g7jet5ODRxu-qchECOhDEgJC8PQC6uv2c-qwteor5JX6s9MioIkDQ8D2TMesQ8', 'UKQ1.230924.001', '2026-01-05 16:53:48', '2026-01-05 16:53:48', NULL),
(7, 0.00, 'fhrhdh', NULL, NULL, 6955885558, 1, NULL, NULL, 'dp6PMgjHTXCJqrjRq7_IYF:APA91bH8c90l8Immsbb2-UAyRitr1Jwmhq9eXnbuYRVKQy2ZfZCpVsGr_g7jet5ODRxu-qchECOhDEgJC8PQC6uv2c-qwteor5JX6s9MioIkDQ8D2TMesQ8', 'UKQ1.230924.001', '2026-01-05 16:54:41', '2026-01-05 16:54:41', NULL),
(8, 0.00, 'ngfhrh', NULL, NULL, 5578485856, 1, NULL, NULL, 'dp6PMgjHTXCJqrjRq7_IYF:APA91bH8c90l8Immsbb2-UAyRitr1Jwmhq9eXnbuYRVKQy2ZfZCpVsGr_g7jet5ODRxu-qchECOhDEgJC8PQC6uv2c-qwteor5JX6s9MioIkDQ8D2TMesQ8', 'UKQ1.230924.001', '2026-01-05 16:55:04', '2026-01-05 16:55:04', NULL),
(9, 0.00, 'xvxhxgd', NULL, NULL, 8989565654, 1, NULL, NULL, 'dp6PMgjHTXCJqrjRq7_IYF:APA91bH8c90l8Immsbb2-UAyRitr1Jwmhq9eXnbuYRVKQy2ZfZCpVsGr_g7jet5ODRxu-qchECOhDEgJC8PQC6uv2c-qwteor5JX6s9MioIkDQ8D2TMesQ8', 'UKQ1.230924.001', '2026-01-05 16:57:04', '2026-01-05 16:57:04', NULL),
(10, 0.00, 'fhfhd', NULL, NULL, 9565655656, 1, NULL, NULL, 'dp6PMgjHTXCJqrjRq7_IYF:APA91bH8c90l8Immsbb2-UAyRitr1Jwmhq9eXnbuYRVKQy2ZfZCpVsGr_g7jet5ODRxu-qchECOhDEgJC8PQC6uv2c-qwteor5JX6s9MioIkDQ8D2TMesQ8', 'UKQ1.230924.001', '2026-01-05 16:57:34', '2026-01-05 16:57:34', NULL),
(11, 0.00, 'fjfjfj', NULL, NULL, 9895653232, 1, NULL, NULL, 'dp6PMgjHTXCJqrjRq7_IYF:APA91bH8c90l8Immsbb2-UAyRitr1Jwmhq9eXnbuYRVKQy2ZfZCpVsGr_g7jet5ODRxu-qchECOhDEgJC8PQC6uv2c-qwteor5JX6s9MioIkDQ8D2TMesQ8', 'UKQ1.230924.001', '2026-01-05 16:58:22', '2026-01-05 16:58:22', NULL),
(12, 2000.00, 'bvvv', NULL, NULL, 1111111111, 1, NULL, NULL, 'dp6PMgjHTXCJqrjRq7_IYF:APA91bH8c90l8Immsbb2-UAyRitr1Jwmhq9eXnbuYRVKQy2ZfZCpVsGr_g7jet5ODRxu-qchECOhDEgJC8PQC6uv2c-qwteor5JX6s9MioIkDQ8D2TMesQ8', 'UKQ1.230924.001', '2026-01-05 17:01:31', '2026-01-05 17:01:31', NULL),
(13, 0.00, 'dhdhdhhd', NULL, NULL, 8454664645, 1, NULL, NULL, 'eoxUxobiQ-OJXTruVTTe2s:APA91bHguJPQKINGsjP6Oge4zOIofbcizdKEWvd9TgKKWql_VcyhPffoDqHSzhT96QXCu8pF0Lm5LUqEzCBUXnF1k97p74jjDaaFRg8SNJm1W-JJ29aA5N0', 'RKQ1.201004.002', '2026-01-06 09:17:57', '2026-01-06 09:17:57', NULL),
(14, 0.00, 'harsh', NULL, NULL, 8887652143, 1, NULL, NULL, 'esBSSynzTfi8zqTDY7aAq_:APA91bGroKndaHZYDy21d8qiKXmsy75VvQ4gGvsArODZlP2Eyes6jERWmosbCqXnfrkrk6avLeO8ql1Zwhy-sutOPKe1urToX_yrBX2yrXI0LWjVIGRO2JI', 'AP3A.240617.008', '2026-01-12 10:49:06', '2026-01-12 10:49:06', NULL),
(15, 0.00, 'amar', NULL, NULL, 9759999888, 1, NULL, NULL, 'eqc3bkPCTYiy5j3PGQZWqw:APA91bGYGxzrDAPoqjEPMRPvIc39af2AOs1BCQ0qbqPDltb8tjlmT_c1KXqwJERbRHpsSW8L2ZFgxFtRFFB1YfO36iqNRQAm6OcnRGY9fS9w5zhRWKQU9HA', 'BP2A.250605.031.A3', '2026-01-14 16:53:27', '2026-01-14 16:53:27', NULL),
(16, 0.00, 'gugu', NULL, NULL, 8423959819, 1, NULL, NULL, 'eotJ3B8qSlyeUiLgwTJJu6:APA91bG6fVUCUwh091dfhjmT2TfaIfkQ1B8JuCsj7Ei45VPeJSdqlHZ5hagoQEyQAiuv1QDNwx-aXbYVN6uHZtu0OSmBKogjTO5HXdHADBm5FOnW_b67jDk', 'RP1A.200720.011', '2026-01-17 10:42:59', '2026-01-17 10:42:59', NULL),
(17, 0.00, 'aman', NULL, NULL, 7705827321, 1, NULL, NULL, 'dRt4iVHWTrarYj2yP2qrO5:APA91bHpKghXqje4FOprV8Og6jVFt961bcLrZthaCybzVVGU2j81uL9ifL1gTU0iqXCFA2FyMzWtXU6wQPeGBY2Z4lg3Z3bGgYYfHdY1pwpih6KQsez3h08', 'V1UO35H.74-16-4-12-3', '2026-03-13 06:15:46', '2026-01-17 11:15:03', NULL),
(18, 0.00, 'ANSAL', NULL, NULL, 9651511938, 1, NULL, NULL, 'fZz4KkToQ8GaUrAyZI93OB:APA91bES7paKGThqtFY5E2Md6eub9ZoJJFB828WS5XKXiHUnGnxcxdsS-kOqivwfA2RfjnYIibiM2ubgfRhTggCJsKzfdmZE99VCqvxI4e53GjfDPptie6E', 'SP1A.210812.016', '2026-03-12 14:14:59', '2026-01-17 11:32:01', NULL),
(19, 0.00, 'aman', NULL, NULL, 9559960255, 1, NULL, NULL, 'ckW28o43QJO56yVf6Yqizt:APA91bFMRWkf-QrWfGxwlPcSsTZnzeakxh1xug70z0a4eVyAj81zGNBRYg-PqU9lYxO3bhyxPe1TCDs-8vY2lOe3tNcXd9RCKZdMOH2wwhmVcVhSYbV4PZA', 'V1UOS35H.74-16-4-12', '2026-01-17 12:34:26', '2026-01-17 12:34:26', NULL),
(20, 0.00, 'aman', NULL, NULL, 8303204543, 1, NULL, NULL, 'dAGq3ioQRZWZfYf7xwEO-a:APA91bFaPlfqmzOoPPpmvhiogwqQOTRwoe60_XpHGD1b0dCnCrgGGGMzdq6uO2Do0XmzewVTxEQso60ZZJBKXbD36ihAPuHAjT9YCVEKBgTLP1xd16Zg2rc', 'UP1A.231005.007', '2026-02-20 03:27:41', '2026-01-17 13:53:44', NULL),
(21, 0.00, 'Ankit ', NULL, NULL, 7800019135, 1, NULL, NULL, 'eeV4Qv7OSHGcMUfHG89uqv:APA91bGS3IlncyWw7BJirt-C-4-rZpOdumgm9hpdaumzwqK1aGYXKzyg3NzY3dg568ObLb98hMO5gReY1gkyzaqP_7zAySzyffPdVsMqB4KyV5Lukj9_4pM', 'AP3A.240617.008', '2026-01-18 06:27:10', '2026-01-18 06:27:10', NULL),
(22, 0.00, 'abhay singh', NULL, NULL, 9236639289, 1, NULL, NULL, 'dRDtwYz1QdaezoBhu6AznI:APA91bHLzKA30hpAEb51r6NroYmAaSPBBKmqK6ogTeqci0jKPWTkb5jNb3CrQpCdHxxkUL2Bc_1yHY8QNV4xCAua845HqLZSv1vDaKPokeuE_oWOatgakHY', 'AP3A.240905.015.A2', '2026-01-18 10:03:03', '2026-01-18 10:03:03', NULL),
(23, 0.00, 'aayansh ', NULL, NULL, 8757315025, 1, NULL, NULL, 'fSYb84eKQruuDOaqgiZlKu:APA91bH-7ffvVWWisP8llkBq-Hzbx4ws4oz1vXNtIjT9QhC_vfpjSwNoSz9cpxilHeZ18AWr2kUrHz9_QPeQ0Hg-6AQfLIfRfich75PaEqLa6kZD7BsXq-g', 'UKQ1.230924.001', '2026-01-22 10:46:55', '2026-01-22 10:45:05', NULL),
(24, 0.00, 'anshuma', NULL, NULL, 7800764914, 1, NULL, NULL, 'eotJ3B8qSlyeUiLgwTJJu6:APA91bG6fVUCUwh091dfhjmT2TfaIfkQ1B8JuCsj7Ei45VPeJSdqlHZ5hagoQEyQAiuv1QDNwx-aXbYVN6uHZtu0OSmBKogjTO5HXdHADBm5FOnW_b67jDk', 'RP1A.200720.011', '2026-01-23 03:58:39', '2026-01-23 03:58:39', NULL),
(26, 0.00, 'nitin', NULL, NULL, 9208339102, 1, NULL, NULL, 'emU6g5M-SBeJicU96YzcEa:APA91bHkO-Z2SAQegQhQOFdtMAVBIK7vHq8aOlDZvRhWizfjF6tMS0m-rcLL1EcQGpkvIWFoe-7K00gI9S4E7CwZd8CIyNAP20Wp6oUwF05y8NPdEk-9s14', 'BP2A.250605.031.A3', '2026-02-21 04:31:21', '2026-01-23 06:14:08', NULL),
(27, 0.00, NULL, NULL, NULL, 75700006441, 1, NULL, NULL, NULL, NULL, '2026-01-23 06:44:32', '2026-01-23 06:44:32', NULL),
(28, 0.00, 'pankaj ', NULL, NULL, 7258836052, 1, NULL, NULL, 'd43DpvmURQWcFOebpKjpnj:APA91bGBH9iKDc7GfiQ8v9zh3sjGKvzp8ScowVcHP85Q3SGha0gWsu2ytZzzFwURzRnRDPRM4OWYWpGP_BXh-K_DyWcT7jbpwviXq6Rezm-G3cQ4xyun3tk', 'RP1A.200720.011', '2026-01-23 10:20:36', '2026-01-23 10:20:36', NULL),
(29, 0.00, 'Anshika ', NULL, NULL, 7308050178, 1, NULL, NULL, 'ewAt8UxhQ1y7yItenGaz8D:APA91bFE-6ffmNr78Tb-ONK-lrUEq7WvtJrs8W1-b1Bg_JcEP9Qi5BdeBW8UGytfax-YHdvF88QpteFX8og_gE1gDr7WDJrRL2L7ZrB-Wuki8mXoC0k44cE', 'BQ2A.250721.001-BP2A.250605.031.A3', '2026-01-24 10:24:39', '2026-01-24 10:24:39', NULL),
(30, 0.00, 'ffbbb', NULL, NULL, 6306026322, 1, NULL, NULL, 'dwSdVPVcTU2QpF_JvsIBrU:APA91bHUcBLRSF8FD_BXjHQHsSYblcXWp6tj2KvGBya5VApVS_WGml_2Hq_lqdxM5ltNaUEm_06mqRFklALBu1OfVbS8ovg3SjtEfspp6oyUmtOp7wgXKEQ', 'UKQ1.230924.001', '2026-01-24 10:40:44', '2026-01-24 10:40:44', NULL),
(31, 0.00, 'Aryan', NULL, NULL, 7705017444, 1, NULL, NULL, 'eHmH2X51QFWRlauDvAJG22:APA91bFRQP_66qbDfXnWFtxSMZuysRpRoqvXLmwBhDOYLMZgtK7CIY-gNOPorvl4mmN3K-q2kf_n28wIU1ntID3DzugWJ1njf0fO1sDizZeXOlwStczKb4g', 'PKQ1.180917.001', '2026-03-08 06:48:30', '2026-01-24 10:44:00', NULL),
(32, 0.00, 'Rashmi Yadav ', NULL, NULL, 7705019444, 1, NULL, NULL, 'dbDy97L7SQiOZqqASGRgcs:APA91bG3CdjnnA5_A06TmuUequkEFzgtunX5myBGZ0MexWON8RNuEGUmwQvFrhl9v4_8si3aM4VqmJU8G7SpJMWESynun9W8sQpzxlg8aQCy-J1Kzp1g0sw', 'UKQ1.231108.001', '2026-01-24 10:44:00', '2026-01-24 10:44:00', NULL),
(33, 0.00, 'Sushil Gupta ', NULL, NULL, 9506438531, 1, NULL, NULL, 'eYKZPqsKRjS0Ce7SDD1mfm:APA91bH8ooPrgY2alXNGU_v7dJGxUGLgRGhfO6ghcuCoBN03S6gkYVp2rLmXHauPwmoF09YqTq_Hka7TqqktUaPeJqHgjl3ic81x-7-kD68gkpBltb6Q1q4', 'AP3A.240905.015.A2', '2026-01-24 15:19:01', '2026-01-24 15:19:01', NULL),
(34, 0.00, 'ankit', NULL, NULL, 8173077880, 1, NULL, NULL, 'cl73o_o5SxStYAyPH51pSl:APA91bH17jJW5A3JCQ0n5s6NaUbf-EgOF4W3I85QkUemNlXgjEyFpq3NTTO05gOT2BSdsVUsLXEwB8UfI0eKEcd0WkZbyImoNk7dOGJAqYiXnbdpeZ7csIg', 'W1VC36H.14-20-12', '2026-01-25 12:57:41', '2026-01-25 12:57:41', NULL),
(35, 0.00, 'sanjana', NULL, NULL, 8303503703, 1, NULL, NULL, 'erCoOwC3Tx-is-J5wG6nMR:APA91bGcxVsPcazkoiXRVXlLr9x1I0Oe65F_X07RywSQmcMuBbIbhRZvOuIvqswbUo3I5-qr5x5FMpF_-XH5kJhEVISbANXhZgB7gCDla1zZe9ae4I2qwZM', 'SP1A.210812.003', '2026-01-25 13:18:26', '2026-01-25 13:18:26', NULL),
(36, 0.00, 'Alok ', NULL, NULL, 9219180433, 1, NULL, NULL, 'c_CPPnIAR12n_qOixcMv2o:APA91bG6BtuBbfaP-aw2kBnAKAv43i_v5ItY8ao632q7A0KOgo4kU6JBovpwI3HOqR-CP5QnwRA6LyFj0-ZZZANEdAnplchOjXzxR_wrPwugPugf0epC7S8', 'SP1A.210812.003', '2026-01-29 09:22:53', '2026-01-29 09:22:53', NULL),
(37, 0.00, 'anu', NULL, NULL, 8381969475, 1, NULL, NULL, 'cqaQMGDhSDakyjw4Z1IMZm:APA91bHFNCgG3bN9uEqvxHd9WQEu7zZzwXApfnuxTNp6dgCS1pmzSf7HcO40Y1LfWKWS4tzGLruzhoLXiVlG-u4rdFlIqZ8GlR3ef49BjBSC-UvYhg_Zd3Q', 'TP1A.220905.001', '2026-02-01 10:42:26', '2026-02-01 10:42:26', NULL),
(38, 0.00, 'rahul ', NULL, NULL, 8173006663, 1, NULL, NULL, 'e4zb9KGIQXO3-tFkbyYLnO:APA91bHh0h2207VXOv-hllBsE_UKzgPMZbvDGOhj5rxG1sLSUyTQUGKTEPVLRmwbmYRL1hkEFt_3Uzauc7zJkT1kgWBMSp9lgotE0_jkQTVUolJWAw1512Y', 'UP1A.231005.007', '2026-02-10 15:38:05', '2026-02-10 15:38:05', NULL),
(39, 0.00, 'Hariom ', NULL, NULL, 8948417974, 1, NULL, NULL, 'fJKXWCoeSw65KVoIh85puQ:APA91bGhGs1aNlJ9oXO0mZdKT0Zlt3xp7_QTEyeu5R2dgMJTkbpnGS67mSb2B4Tsoak6QTEx_HrnYEVlt_tjlRk7Xz8jH8N5YpzISFq16m27vMQCQLPyl3s', 'TP1A.220624.014', '2026-02-11 14:59:01', '2026-02-11 14:59:01', NULL),
(40, 0.00, 'omji awasthi', NULL, NULL, 9455512328, 1, NULL, NULL, 'fT2dNLx9Q6KLpYkXKDqwrn:APA91bFZIUiGNzLA52lO5qUYG5t8txbLIgakXMK_SENmZWbK8NgMyjE5YqZEtV0tguvEDHsKp1bYdEC6da5WnJXuMK8dxoirRUJDWT0mLDhAUeBTpnPzS6E', 'AP3A.240905.015.A2_V000L1', '2026-02-11 14:59:40', '2026-02-11 14:59:40', NULL),
(41, 0.00, 'pragy', NULL, NULL, 7705020474, 1, NULL, NULL, 'dgxArlf9Tv2Fo5wnML8bjw:APA91bF7fEqpWlf5AcSnvqYCbhMr3B_B-eo6QDhRHH72tok4IQPSfOgD54QQsy30f_5cwpdWmeT5q9wIweooVgU92KGhJ_rrVhIKLKlgUBQZq9oxutGwzPg', 'TP1A.220624.014', '2026-02-13 10:38:46', '2026-02-13 04:50:42', NULL),
(42, 0.00, 'pragya', NULL, NULL, 7705018444, 1, NULL, NULL, 'cnjiWuRBR-SZls7bERBOzf:APA91bFdLVN2WrXAKG05sbXlrIo28G8X3WlM1PaMSzJxB3WHFr2ZCMTxocUPu9PYp8-QNTI3tzCIsaNwsfKtP50OzF0IefPscu8RQ2sWq4EorQV3AbJwarI', 'RKQ1.201004.002', '2026-02-13 05:04:34', '2026-02-13 05:04:34', NULL),
(43, 0.00, 'Ankit', NULL, NULL, 6200629758, 1, NULL, NULL, 'cp4Mo1HsSeu2pT4ncG5xol:APA91bFQAm3xu0yADFyikON-DlGVwLdaQT3Snhk2d8Ya36RfeRjfivIHVeFntiU5QKkwbLvzcxTxDBBuhsIQUAQa-_a8AG_ADAbnwTSP5Tors_oCzFuNwtc', 'UKQ1.230924.001', '2026-02-13 16:23:33', '2026-02-13 14:35:20', NULL),
(44, 0.00, 'atul', NULL, NULL, 7063385801, 1, NULL, NULL, 'flBHqrVrTeKcSAzKS-FZ-Z:APA91bFSJWWOX4AEAqu_4eNWeSQvdc4faJBv87-06HjhH2tpPGgZKnJwYlY3GcDPCvxi_GsGB2BU2x4Cs9PPiTY-bdfjU3_Nyt7uptkF14E2V0achRQjYsk', 'V1TLS35.73-60-3-7', '2026-02-14 12:41:01', '2026-02-14 12:41:01', NULL),
(45, 0.00, 'vimla Soni', NULL, NULL, 8604396064, 1, NULL, NULL, 'c2IQ6_OLT6STzZUJgDXyBQ:APA91bE-TfGRJJ3iVpbluwcUlUlAKFTkPMNridWA_4EhG4pJQYOyNRRkD4BsraCkhPzVFL7H69FvS82xvHChMNKaxmpXhS-MgZtE-Eenr5ZnMfjMlefruPU', 'UP1A.231005.007', '2026-02-14 16:32:21', '2026-02-14 16:32:21', NULL),
(46, 0.00, 'Sandeep Kumar ', NULL, NULL, 7365036744, 1, NULL, NULL, 'fDerepITQ7m3bEeqnW092E:APA91bEcLG6xCBK9WdpqeIiQaGyxrenzNXTQ3j1f34H2G4H8h04vdSqVFr-P_Y1nyDA_MFjtWGysjYc4TJrcj7IOUbqbK4rCslxdzmI_AQ1xyNAkRPOiWK0', 'TP1A.220624.014', '2026-02-15 05:05:12', '2026-02-15 05:05:12', NULL),
(47, 0.00, 'aayansh ', NULL, NULL, 8957315025, 1, NULL, NULL, 'fS6oBLVDRZa0wSuWSemrNQ:APA91bGuIlxAw2qBcx_nz8osLIaTy8D0G1Q_chkApOv_WI_zk38mKj6Uk8CBvcaqteOkkx7sKGmkPybVm5tss_sTOTkdLd-EOgeW2qwBglw8NotwqAkmGNc', 'UKQ1.230924.001', '2026-02-15 08:45:28', '2026-02-15 08:45:28', NULL),
(48, 0.00, 'manoj', NULL, NULL, 6299249539, 1, NULL, NULL, 'f9ON8ZGMSTqR4EMzBFjpwH:APA91bFvACdk6TzlcEsbUjfsuloicRTyy-c1N7cEWN9qpxLUmmrM-kyZScSBBZh-oTmQjkI-hcfzFsM3SLSLPbSbLd2FbfbtIHYXCME8p37ELiT1C_r9ijk', 'UKQ1.230924.001', '2026-02-15 14:50:03', '2026-02-15 14:50:03', NULL),
(49, 0.00, 'Tulsi ', NULL, NULL, 9129565346, 1, NULL, NULL, 'c6sqMPn0Q9m_2Z_Dt3DbAj:APA91bFK6rNEHyDEBKfQDue4mvKjY0BH9boX12h-FXrIUQpDkuVesP9sh9f-xM-bP6kQeXy8U8LhpLEM_MfWVqDqc3L_rBK0Gi0CFW00B1oUNfshk3BwUNc', 'HONORALI-N21', '2026-02-26 10:31:53', '2026-02-20 05:25:50', NULL),
(50, 0.00, 'Anurag verma ', NULL, NULL, 6306061852, 1, NULL, NULL, 'cxL_XDtTSYiIQa8b0yx25o:APA91bGGh9eGdnQ-Kawbx4mizB3NfV24JnnE8wUy_K_VR0ZTxQTFhvmgPVuuL3O_3ojpH6TtWOT_3Q_a0C8PvG2cjIr0Io3Ao2vYs85krzCX8OyFSh-j6pI', 'SP1A.210812.016', '2026-02-20 15:51:29', '2026-02-20 15:48:56', NULL),
(51, 0.00, 'Some Datta', NULL, NULL, 8090666407, 1, NULL, NULL, 'czqPpGY2RfuZdG8poWr7YU:APA91bHF2lavuA_4q1GWeVIaCNWw9W6L01zGWIo_-qJmvwF-xCLJv8EZ79TD1jxBrc15Tsas9iszJz1G4-f1D4WZzMNdTqhbar_xyygReNZNTLrZFdemeZ0', 'TP1A.220905.001', '2026-03-07 08:09:20', '2026-02-21 04:44:17', NULL),
(52, 0.00, 'amar Singh Soni', NULL, NULL, 9795755998, 1, NULL, NULL, 'cvTgUU4gSiy4_rlk9VgT0a:APA91bG6tjEEu2JwALHSMd699UfSYE1dfv4yYP_qcmxaXMprzjpWDu2jUsMXAfJKeQQBLHi8Z1KF3Nob59PYcfZ6_N9CuD2zVhYIiZ5cGGyz79GMxqPuqFE', 'BP2A.250605.031.A3', '2026-02-23 03:38:40', '2026-02-23 03:38:40', NULL),
(53, 0.00, 'Sumkhi', NULL, NULL, 8874420521, 1, NULL, NULL, 'eSVBHXHAQyG7572DwhxxCl:APA91bGHv8YmloWNepByRf-4w0ssVouS1MOOWjqljhfzd4o32SBBz4UtVAo7QPchG9iw2Ha6AmEIui9zbOWDRVHbi-OVZ-ydF_7iVPdnryH9Zj2OCQ4p2Gs', 'UP1A.231005.007', '2026-02-26 18:06:56', '2026-02-24 13:39:04', NULL),
(54, 0.00, 'gello', NULL, NULL, 9599089358, 1, NULL, NULL, 'cu_tjIuIR4W2bRCs9Ojlj-:APA91bE3qoVwm86Q8RTPXz7b37ji_7j880DaAJO-ew6zDh0JAZXMDpWq00SdYN5DvcUCKLkkQfeRt-TCrl5urQZq9Tczz6ip_fY4R7hiJCTS0gUp1xokjxw', 'UP1A.231005.007', '2026-02-27 05:13:41', '2026-02-25 13:36:46', NULL),
(55, 0.00, 'Ankit bajpayee ', NULL, NULL, 9519595231, 1, NULL, NULL, 'fcanYaJ9T_KgPRFq0Ta2Lz:APA91bGd3B562FmFW6UU5Rxv4qH7PHlJehuNDhWMmw39jZogL7eXCWx529fPSwkLOS4PVOlxjseu6tlAajTIeWzSNwd7_W46hrL0ibYbpS_eQGjQgWQEixI', 'AP3A.240617.008', '2026-02-25 15:04:31', '2026-02-25 15:01:07', NULL),
(56, 0.00, 'dpal ', NULL, NULL, 8740803396, 1, NULL, NULL, 'fObTQdasSdyrEvByYljU7M:APA91bETrXrCAkQHo2h_1Zfw6IBwCdAlyHryn4UVmkud-tcD_OqnYC8tsvbPHWKmAFsYn8Ac725jfInj7M__woVmtkv-ajzrP1GmfX9CPZ1o1t8GrpLkm6M', 'BP2A.250605.031.A3', '2026-02-27 07:48:23', '2026-02-27 07:42:30', NULL),
(57, 0.00, 'Abhi', NULL, NULL, 9565789026, 1, NULL, NULL, 'dw7fp63ZT_WABLB3UkYSBJ:APA91bEn-LJDcAaFniR4Nsl7UV1R8vu2TMYBjiL01r0C4lUFgrbbl1FALCAjWX5pq0OVgkC8T3TGL8m9UF0GxEf3P4pUfalYDVw6WRNshUh2ktK4KbxYvnE', 'AP3A.240905.015.A2_V000L1', '2026-02-27 11:36:56', '2026-02-27 11:06:54', NULL),
(58, 0.00, 'Anjani ', NULL, NULL, 6393085442, 1, NULL, NULL, 'ecCYr6f0Sn-huZ3o1xMKte:APA91bHnxmWGFGWno64G4grAXSKOdHYIyKY8VHryYuPywF8QNauUkmebs-oa7_PvLjxAjCFV36Z85BDN-Ajuqs-1KJWQwYade4_HBVk4ULjmyY4JiodRTds', 'AP3A.240905.015.A2_IN', '2026-03-05 14:37:04', '2026-03-05 09:02:38', NULL),
(59, 0.00, 'SUDHIR KUMAR', NULL, NULL, 9794375816, 1, NULL, NULL, 'eHBMRHIASO2Obt9jXueeiA:APA91bEiRV3QnhwzPM_DMY8CQ7KMfgONdCqIcrZo1iQVDT3on7w1bddNKHtyEIQyIgcrbYZWadU0rPrH2B20qXZlyarn4ct9f1BjV8xgBq0Cg9k2q_pN45g', 'W1VCS36H.14-20-19-1', '2026-03-06 06:48:16', '2026-03-06 06:42:09', NULL),
(60, 0.00, 'gautam ', NULL, NULL, 9794116633, 1, NULL, NULL, 'cYziCQWNQkC3v7R2QifRw5:APA91bEuRVfHqjS4FIOy6wT_ZkIbZ1LaxFzSFwJN7SHzNE10wPr2jVQcwTjTBUZNpHWcaKihBcl6p1lQndFcttn7xGLN6nN1e_N9yFI_RV9wJZ3HlJThKY4', 'UKQ1.231108.001', '2026-03-06 13:30:06', '2026-03-06 10:57:12', NULL),
(61, 0.00, 'janmejay singh ', NULL, NULL, 9990230532, 1, NULL, NULL, 'fuQyEwCRTKyDU_AmL2yR0V:APA91bFknBfIQt5nkFE37xOB4l8rCv3pLCshrx8SRcOwECt-nhn4-sCGvpKZ9SE3X_Lor_CP3-EGnFj_YCImK7XOyOd2WZgFEgs83oMuli2Dv84f_ycx-lo', 'UKQ1.230924.001', '2026-03-07 10:49:56', '2026-03-07 10:36:06', NULL),
(62, 0.00, 'akshay shukla', NULL, NULL, 9794480196, 1, NULL, NULL, 'chCMrnehSB2BmUPyIlPDt6:APA91bHnMMZecckhb0kgZyMgIxTCtPkcXPRwAEW32ftUXl6hcnvjh3OSoB_npE2Ay2Is15EoQZJaHKZ-srFvYnGJzfh5fHOuf4NwlP4jks2O3EvhQdNP4uE', 'V1UO35H.74-16-4-12-3', '2026-03-12 12:42:35', '2026-03-08 05:59:24', NULL),
(63, 0.00, 'vivek', NULL, NULL, 7307229576, 1, NULL, NULL, 'dACDCKi8QuKXS9oBd_noYr:APA91bFYBMCXPwMcLirsT4zKVMCpTukP8RMLRVbjIiMEWsuoJI9xSV5FoZkURd7Izlgw9219HmptJ-BNiOsIO0KxFdRHHmBeGk63RG8x1caMQgAkIdwdv9o', 'SP1A.210812.003', '2026-03-08 08:42:11', '2026-03-08 08:38:16', NULL),
(64, 0.00, 'Kisha ', NULL, NULL, 7238829360, 1, NULL, NULL, 'c7hTKz17RA-vVLZMa10l8S:APA91bGXzOcFDX4Q-iz3fsbFGefObkD8Vk5BpMfz2LI83UA80LMLbeqtgz6Fztc84R4o50dMELRw-mGONH4z5RSLZNJeE2arWc1pUyWctLkjEDbS2ssDp_U', 'BP2A.250605.015', '2026-03-08 09:07:54', '2026-03-08 09:06:43', NULL),
(65, 0.00, 'shubham Kumar ', NULL, NULL, 8127570413, 1, NULL, NULL, 'cpAf4oozS0ubOUimZzWqnZ:APA91bHxmZMYDw7IIGoiz0ycisiNFkdqwWQgacC0A4ngUADLo9Wuf0SMgwApbCY7AJi4rC3N97auD1nhTXA607DQctbrO9YzyVEm3hLnTspZYw4d5daTdkc', 'QKQ1.190915.002', '2026-03-09 09:06:47', '2026-03-09 08:50:06', NULL),
(66, 0.00, 'ABDUL ', NULL, NULL, 9133687768, 1, NULL, NULL, 'fVhZXGIASiCFbLOYwq4Ite:APA91bEI2hBWwT4HgdGQ-92eVxQj8t5gqmD2xHw_jsY4zM13mjCoHc79T-ab_yXKpMNL8Gtfj7V4A707orHmwGGBerAX9gNRsorloLxAoA4Y8I3kkH8FwBc', 'TP1A.220624.014', '2026-03-09 18:43:14', '2026-03-09 18:42:57', NULL),
(67, 0.00, 'Ashish Kumar Saini ', NULL, NULL, 7393952737, 1, NULL, NULL, 'cKDjZR5cRnmnN9pZszVbPi:APA91bFLpqnnXbjug6YfZ2NPvBttp0kejcUyjG3V4Pvc3cZn-uLk4jyrCFhfQDAdQ5giao8yx-jsFZ6PzRGeRLyB16iNjZ883DUiuj3Q16NUeDK4NOO2ziA', 'AP3A.240617.008', '2026-03-10 12:05:56', '2026-03-10 09:24:40', NULL),
(68, 0.00, 'parkah', NULL, NULL, 7355646015, 1, NULL, NULL, 'fjPnciPHR_qicEbKAmXFN6:APA91bEZKS_syn4XFcXhsNTg4p-hk6IOC0UXa9auBorJxnS1zuZH2RIq9wQFTW-m6zySSbJY6cm5rwW1rpVVV6Z1oqTGYw872pC1lThMxqhRVBTkZccJCOE', 'RP1A.200720.011', '2026-03-12 16:44:55', '2026-03-12 16:44:04', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_app_banner`
--

CREATE TABLE `user_app_banner` (
  `id` int(11) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `status` tinyint(5) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_app_banner`
--

INSERT INTO `user_app_banner` (`id`, `image`, `status`, `created_at`) VALUES
(1, 'userAppBanner/a.jpg', 1, '2025-12-05 05:18:45'),
(2, 'userAppBanner/b.png', 1, '2025-12-05 05:18:45'),
(3, 'userAppBanner/c.png', 1, '2025-12-05 05:18:53');

-- --------------------------------------------------------

--
-- Table structure for table `user_notification`
--

CREATE TABLE `user_notification` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `text` text NOT NULL,
  `type` tinyint(1) NOT NULL COMMENT '1 = Offer, 2 = Announcement',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_notification`
--

INSERT INTO `user_notification` (`id`, `title`, `text`, `type`, `created_at`) VALUES
(1, 'New Year Offer!', 'Get 20% off on all services today only.', 1, '2025-12-05 04:46:46'),
(2, 'Important Update', 'Our service timings have changed from next week.', 2, '2025-12-05 04:46:46');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle`
--

CREATE TABLE `vehicle` (
  `id` int(10) UNSIGNED NOT NULL,
  `vehicle_category` tinyint(4) NOT NULL DEFAULT '2',
  `name` varchar(150) NOT NULL,
  `max_passenger` int(11) NOT NULL DEFAULT '1',
  `image` varchar(255) DEFAULT NULL,
  `register_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 = Can Register, 1 = Cannot Register',
  `visible_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 = Not Visible in Market, 1 = Visible in Market',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `discount` int(10) NOT NULL DEFAULT '10',
  `driver_can_discount` int(10) DEFAULT '5',
  `user_increase` int(10) DEFAULT '15'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `vehicle`
--

INSERT INTO `vehicle` (`id`, `vehicle_category`, `name`, `max_passenger`, `image`, `register_status`, `visible_status`, `created_at`, `discount`, `driver_can_discount`, `user_increase`) VALUES
(1, 3, 'Auto', 3, 'cabbooking/vehicle_image/auto.png', 1, 1, '2025-12-30 04:32:52', 10, 5, 15),
(2, 4, 'Mini', 4, 'cabbooking/vehicle_image/1769166652162.png', 1, 1, '2025-12-30 04:32:52', 10, 5, 15),
(3, 2, 'Bike', 1, 'cabbooking/vehicle_image/1767075817934.png', 1, 1, '2025-12-30 04:32:52', 5, 5, 5),
(4, 4, 'Sedan', 7, 'cabbooking/vehicle_image/1769165968057.png', 1, 1, '2026-01-23 10:59:28', 10, 5, 10),
(5, 4, 'SUV', 7, 'cabbooking/vehicle_image/1769166174137.png', 1, 1, '2026-01-23 11:02:54', 10, 5, 10);

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_charges`
--

CREATE TABLE `vehicle_charges` (
  `id` bigint(20) NOT NULL,
  `vehicle_id` bigint(20) NOT NULL,
  `from_km` decimal(5,2) NOT NULL,
  `to_km` decimal(7,2) DEFAULT NULL,
  `rate_per_km` decimal(6,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `vehicle_charges`
--

INSERT INTO `vehicle_charges` (`id`, `vehicle_id`, `from_km`, `to_km`, `rate_per_km`, `created_at`, `updated_at`) VALUES
(19, 3, 0.00, 5.00, 8.00, '2025-12-31 04:10:41', '2026-01-29 13:06:02'),
(20, 2, 0.00, 5.00, 50.00, '2025-12-31 04:13:37', '2025-12-31 04:13:37'),
(21, 1, 0.00, 5.00, 25.00, '2025-12-31 04:13:54', '2025-12-31 04:13:54'),
(22, 3, 5.00, 30.00, 7.00, '2025-12-31 04:14:59', '2026-01-29 13:42:22'),
(23, 2, 5.00, 15.00, 30.00, '2025-12-31 04:15:22', '2025-12-31 04:15:22'),
(24, 1, 5.00, 15.00, 20.00, '2025-12-31 04:18:03', '2025-12-31 04:18:03'),
(26, 2, 15.00, 100.00, 17.00, '2026-01-23 08:28:40', '2026-01-23 08:28:40'),
(27, 2, 100.00, 2500.00, 10.00, '2026-01-23 08:33:37', '2026-01-24 06:07:29'),
(28, 5, 0.00, 5.00, 30.00, '2026-01-23 11:40:49', '2026-01-23 11:40:49'),
(29, 5, 5.00, 30.00, 25.00, '2026-01-23 11:41:07', '2026-01-23 11:41:07'),
(30, 5, 30.00, 2500.00, 15.00, '2026-01-23 11:44:13', '2026-02-24 05:58:14'),
(31, 4, 0.00, 5.00, 33.00, '2026-01-23 11:45:32', '2026-01-23 11:45:32'),
(32, 4, 5.00, 30.00, 27.00, '2026-01-23 11:46:20', '2026-01-23 11:46:20'),
(33, 4, 30.00, 2500.00, 12.00, '2026-01-23 11:46:58', '2026-01-24 06:05:41'),
(34, 1, 15.00, 50.00, 14.00, '2026-01-23 12:01:41', '2026-01-23 12:01:41'),
(36, 3, 30.00, 50.00, 6.00, '2026-01-23 12:03:15', '2026-01-29 13:42:49'),
(37, 3, 50.00, 150.00, 5.00, '2026-01-29 05:56:41', '2026-01-29 13:43:12');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_driver_discount_slabs`
--

CREATE TABLE `vehicle_driver_discount_slabs` (
  `id` bigint(20) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `starting_amount` decimal(10,2) NOT NULL,
  `end_amount` decimal(10,2) NOT NULL,
  `driver_can_discount` decimal(10,2) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `vehicle_driver_discount_slabs`
--

INSERT INTO `vehicle_driver_discount_slabs` (`id`, `vehicle_id`, `starting_amount`, `end_amount`, `driver_can_discount`, `created_at`) VALUES
(1, 1, 25.00, 50.00, 3.00, '2025-12-23 07:08:24'),
(2, 2, 25.00, 50.00, 3.00, '2025-12-23 07:08:24'),
(3, 3, 25.00, 50.00, 3.00, '2025-12-23 07:08:24'),
(4, 1, 50.00, 100.00, 10.00, '2025-12-23 07:08:24'),
(5, 2, 50.00, 100.00, 10.00, '2025-12-23 07:08:24'),
(6, 3, 50.00, 100.00, 10.00, '2025-12-23 07:08:24'),
(7, 1, 101.00, 200.00, 15.00, '2025-12-23 07:08:24'),
(8, 2, 101.00, 200.00, 15.00, '2025-12-23 07:08:24'),
(9, 3, 101.00, 200.00, 15.00, '2025-12-23 07:08:24'),
(10, 1, 201.00, 500.00, 30.00, '2025-12-23 07:08:24'),
(11, 2, 201.00, 500.00, 30.00, '2025-12-23 07:08:24'),
(12, 3, 201.00, 500.00, 30.00, '2025-12-23 07:08:24'),
(13, 1, 501.00, 5000.00, 50.00, '2025-12-23 07:08:24'),
(14, 2, 501.00, 5000.00, 50.00, '2025-12-23 07:08:24'),
(15, 3, 501.00, 5000.00, 50.00, '2025-12-23 07:08:24');

-- --------------------------------------------------------

--
-- Table structure for table `withdraw_service`
--

CREATE TABLE `withdraw_service` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `user_type` tinyint(4) NOT NULL COMMENT '1=user, 2=serviceman, 3=driver',
  `amount` decimal(10,2) NOT NULL,
  `status` tinyint(4) DEFAULT '0' COMMENT '0=pending, 1=approved, 2=rejected',
  `rejected_reason` varchar(255) DEFAULT NULL,
  `transaction_id` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `withdraw_service`
--

INSERT INTO `withdraw_service` (`id`, `user_id`, `user_type`, `amount`, `status`, `rejected_reason`, `transaction_id`, `created_at`, `updated_at`) VALUES
(3, 2, 3, 200.00, 2, 'abc', 'QP7114769860', '2025-12-17 12:23:49', '2026-01-09 12:23:15'),
(4, 2, 3, 200.00, 1, 'servicemanwithdrawServiceRequest', 'QP7114769860', '2025-12-17 12:23:49', '2026-01-09 05:31:00'),
(5, 2, 3, 200.00, 2, 'servicemanwithdrawServiceRequest', 'QP7114769860', '2025-12-17 12:23:49', '2026-01-09 05:31:04'),
(6, 2, 3, 200.00, 2, 'servicemanwithdrawServiceRequest', 'QP7114769860', '2025-12-17 12:23:49', '2026-01-09 05:31:09'),
(7, 2, 3, 200.00, 2, 'dfghjk', 'JB4371663377', '2025-12-17 16:59:43', '2026-01-09 11:24:28'),
(8, 2, 2, 200.00, 0, NULL, 'MP5849795872', '2025-12-17 17:17:28', '2025-12-17 17:17:28'),
(9, 4, 2, 500.00, 0, NULL, 'NK5109233873', '2025-12-17 18:24:30', '2025-12-17 18:24:30'),
(10, 4, 2, 400.00, 0, NULL, 'ES9810701997', '2025-12-17 18:31:48', '2025-12-17 18:31:48'),
(11, 4, 2, 350.00, 0, NULL, 'MM8886684681', '2025-12-17 18:54:40', '2025-12-17 18:54:40'),
(12, 4, 2, 500.00, 0, NULL, 'SH5546364107', '2025-12-17 18:55:56', '2025-12-17 18:55:56'),
(13, 4, 2, 50.00, 0, NULL, 'YY8661797506', '2025-12-17 18:56:25', '2025-12-17 18:56:25'),
(15, 2, 2, 200.00, 2, 'fir lagao request', 'EM7150336368', '2026-01-09 07:17:13', '2026-01-09 13:47:40'),
(16, 1, 3, 10.00, 2, 'add bank account', 'HL8227647696', '2026-01-09 07:34:36', '2026-01-09 13:06:04'),
(17, 2, 2, 200.00, 1, NULL, 'FM5108230372', '2026-01-09 07:35:05', '2026-01-09 13:47:22'),
(18, 1, 3, 100.00, 0, NULL, 'LG3126204319', '2026-01-09 07:38:10', '2026-01-09 07:38:10'),
(19, 1, 3, 100.00, 0, NULL, 'SL9111126898', '2026-01-09 07:38:18', '2026-01-09 07:38:18'),
(20, 19, 3, 20.00, 0, NULL, 'AJ9586420143', '2026-01-10 08:14:05', '2026-01-10 08:14:05'),
(21, 19, 3, 20.00, 0, NULL, 'UC9703283480', '2026-01-10 08:16:17', '2026-01-10 08:16:17'),
(22, 19, 3, 20.00, 0, NULL, 'OD5568775276', '2026-01-10 08:16:35', '2026-01-10 08:16:35'),
(23, 19, 3, 10.00, 2, 'cfghjkl;\'lkjhvgcvhbjhgcfxgchjkl;jkjhgfxfhkhjkhgjhgxdfhjkjkjhgcfxdghhkjhcfghjkl;\'lkjhvgcvhbjhgcfxgch', 'YB2514778437', '2026-01-10 08:17:42', '2026-01-10 15:34:43'),
(24, 19, 3, 10.00, 2, 'Please provide correct bank details, Please provide correct bank details , Please provide correct bank details Please provide correct bank details, Please provide correct bank details , Please provide correct bank details', 'IH4931185491', '2026-01-10 08:20:48', '2026-01-10 09:53:55'),
(25, 84, 3, 81.00, 2, 'nahi dena', 'YG8800596005', '2026-01-23 05:11:03', '2026-01-23 10:43:53'),
(26, 37, 2, 184.50, 1, NULL, 'QF8849882158', '2026-01-23 05:50:56', '2026-01-23 11:21:32');

-- --------------------------------------------------------

--
-- Table structure for table `zones`
--

CREATE TABLE `zones` (
  `id` int(11) NOT NULL,
  `zone_name` varchar(255) NOT NULL,
  `coordinates` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `type` tinyint(4) DEFAULT NULL COMMENT '1 for service , 2 ride booking',
  `city_name` json DEFAULT NULL,
  `zone_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1=service_zone, 2=ride_zone'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `zones`
--

INSERT INTO `zones` (`id`, `zone_name`, `coordinates`, `created_at`, `type`, `city_name`, `zone_type`) VALUES
(10, 'All India City', '[{\"lat\":29.382471950202728,\"lng\":82.81685123114734},{\"lat\":30.667740230016868,\"lng\":79.23942813544421},{\"lat\":30.024216558690277,\"lng\":73.78334293036609},{\"lat\":28.443032250930234,\"lng\":72.71766910224109},{\"lat\":26.994593384896064,\"lng\":71.30043277411609},{\"lat\":22.182633968622252,\"lng\":72.86049136786609},{\"lat\":17.35751746028105,\"lng\":74.28871402411609},{\"lat\":8.615983405123018,\"lng\":77.41981753974109},{\"lat\":8.600368464394599,\"lng\":77.56263980536609},{\"lat\":11.391520756636716,\"lng\":79.20784244208484},{\"lat\":8.464559360666396,\"lng\":77.39509830145984},{\"lat\":17.282789286625714,\"lng\":74.17198428778796},{\"lat\":26.95910135618313,\"lng\":71.30043277411609},{\"lat\":17.4767571713993,\"lng\":74.29420718817859},{\"lat\":17.22246021394415,\"lng\":74.14039859442859},{\"lat\":8.639744033916724,\"lng\":77.43080386786609},{\"lat\":11.383443215427269,\"lng\":79.31495914130359},{\"lat\":15.265966921330314,\"lng\":79.74342593817859},{\"lat\":19.953016647590587,\"lng\":83.48976382880359},{\"lat\":24.00161933490728,\"lng\":91.10603580145984}]', '2025-12-21 09:46:37', 1, '[{\"id\": 1, \"name\": \"Lucknow\"}, {\"id\": 2, \"name\": \"Barabanki\"}, {\"id\": 3, \"name\": \"Unnao\"}, {\"id\": 4, \"name\": \"Raebareli\"}, {\"id\": 5, \"name\": \"Sitapur\"}, {\"id\": 6, \"name\": \"Hardoi\"}]', 1),
(19, 'All India City', '[{\"lat\":26.896700843888084,\"lng\":84.14592480756102},{\"lat\":28.646346747330256,\"lng\":79.88322949506102},{\"lat\":30.40519589311965,\"lng\":80.19084668256102},{\"lat\":31.310567981817805,\"lng\":78.25725293256102},{\"lat\":33.90151996778312,\"lng\":78.12541699506102},{\"lat\":34.446877519005575,\"lng\":75.04924512006102},{\"lat\":33.75549722758,\"lng\":74.30217480756102},{\"lat\":32.02121506543308,\"lng\":75.66447949506102},{\"lat\":30.63233917048263,\"lng\":74.65373730756102},{\"lat\":27.716702403236923,\"lng\":72.23674512006102},{\"lat\":27.209796265148842,\"lng\":70.65471387006102},{\"lat\":24.481254157955874,\"lng\":71.62151074506102},{\"lat\":22.18140761881953,\"lng\":71.09416699506102},{\"lat\":22.506573556863977,\"lng\":73.29143262006102},{\"lat\":20.83222451488223,\"lng\":73.24748730756102},{\"lat\":18.181453198637595,\"lng\":73.77483105756102},{\"lat\":14.258105856331746,\"lng\":75.00529980756102},{\"lat\":10.91325813183122,\"lng\":76.45549512006102},{\"lat\":8.44423223671763,\"lng\":77.68596387006102},{\"lat\":11.861012441024394,\"lng\":79.26799512006102},{\"lat\":16.12404006022052,\"lng\":79.61955762006102},{\"lat\":19.512270727943665,\"lng\":84.49748730756102},{\"lat\":22.22209478234648,\"lng\":87.92522168256102},{\"lat\":24.76090328889428,\"lng\":87.66154980756102},{\"lat\":26.031222242324304,\"lng\":87.88127637006102}]', '2026-02-07 04:54:27', NULL, NULL, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `adminuser`
--
ALTER TABLE `adminuser`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bank_details`
--
ALTER TABLE `bank_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bank_details_update_requests`
--
ALTER TABLE `bank_details_update_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `brand`
--
ALTER TABLE `brand`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cab_cancel_reasons`
--
ALTER TABLE `cab_cancel_reasons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cab_orders`
--
ALTER TABLE `cab_orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `colors`
--
ALTER TABLE `colors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `coupons_used`
--
ALTER TABLE `coupons_used`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_coupon` (`user_id`,`coupon_id`),
  ADD KEY `coupon_id` (`coupon_id`);

--
-- Indexes for table `driver_offer`
--
ALTER TABLE `driver_offer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `driver_online_logs`
--
ALTER TABLE `driver_online_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `driver_id` (`driver_id`);

--
-- Indexes for table `driver_registration`
--
ALTER TABLE `driver_registration`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoice_settings`
--
ALTER TABLE `invoice_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `job_request`
--
ALTER TABLE `job_request`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loginadds`
--
ALTER TABLE `loginadds`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `login_policy`
--
ALTER TABLE `login_policy`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model`
--
ALTER TABLE `model`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_entity` (`entity_type`,`entity_id`),
  ADD KEY `idx_created` (`created_at`);

--
-- Indexes for table `otp_counter`
--
ALTER TABLE `otp_counter`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_counter` (`counter_name`);

--
-- Indexes for table `otp_logs`
--
ALTER TABLE `otp_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_mobile` (`mobile`),
  ADD KEY `idx_otp` (`otp`),
  ADD KEY `idx_expiry` (`expires_at`);

--
-- Indexes for table `paying`
--
ALTER TABLE `paying`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_gateways`
--
ALTER TABLE `payment_gateways`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `policies`
--
ALTER TABLE `policies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rating_history`
--
ALTER TABLE `rating_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `saved_address`
--
ALTER TABLE `saved_address`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `scheduled_api_hits`
--
ALTER TABLE `scheduled_api_hits`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `serviceman`
--
ALTER TABLE `serviceman`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `serviceman_ratings`
--
ALTER TABLE `serviceman_ratings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `subcategory_id` (`subcategory_id`);

--
-- Indexes for table `service_order`
--
ALTER TABLE `service_order`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subcategories`
--
ALTER TABLE `subcategories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `top_service`
--
ALTER TABLE `top_service`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_app_banner`
--
ALTER TABLE `user_app_banner`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_notification`
--
ALTER TABLE `user_notification`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vehicle`
--
ALTER TABLE `vehicle`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vehicle_charges`
--
ALTER TABLE `vehicle_charges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vehicle_driver_discount_slabs`
--
ALTER TABLE `vehicle_driver_discount_slabs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vehicle_id` (`vehicle_id`),
  ADD KEY `starting_amount` (`starting_amount`,`end_amount`);

--
-- Indexes for table `withdraw_service`
--
ALTER TABLE `withdraw_service`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `zones`
--
ALTER TABLE `zones`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `adminuser`
--
ALTER TABLE `adminuser`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `bank_details`
--
ALTER TABLE `bank_details`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `bank_details_update_requests`
--
ALTER TABLE `bank_details_update_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `brand`
--
ALTER TABLE `brand`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `cab_cancel_reasons`
--
ALTER TABLE `cab_cancel_reasons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `cab_orders`
--
ALTER TABLE `cab_orders`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=752;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `colors`
--
ALTER TABLE `colors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `coupons_used`
--
ALTER TABLE `coupons_used`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `driver_offer`
--
ALTER TABLE `driver_offer`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=183;

--
-- AUTO_INCREMENT for table `driver_online_logs`
--
ALTER TABLE `driver_online_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=189;

--
-- AUTO_INCREMENT for table `driver_registration`
--
ALTER TABLE `driver_registration`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;

--
-- AUTO_INCREMENT for table `invoice_settings`
--
ALTER TABLE `invoice_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `job_request`
--
ALTER TABLE `job_request`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `loginadds`
--
ALTER TABLE `loginadds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `login_policy`
--
ALTER TABLE `login_policy`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `model`
--
ALTER TABLE `model`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `otp_counter`
--
ALTER TABLE `otp_counter`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `otp_logs`
--
ALTER TABLE `otp_logs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=374;

--
-- AUTO_INCREMENT for table `paying`
--
ALTER TABLE `paying`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=326;

--
-- AUTO_INCREMENT for table `payment_gateways`
--
ALTER TABLE `payment_gateways`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `policies`
--
ALTER TABLE `policies`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `rating_history`
--
ALTER TABLE `rating_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `saved_address`
--
ALTER TABLE `saved_address`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `scheduled_api_hits`
--
ALTER TABLE `scheduled_api_hits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;

--
-- AUTO_INCREMENT for table `serviceman`
--
ALTER TABLE `serviceman`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `serviceman_ratings`
--
ALTER TABLE `serviceman_ratings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `service_order`
--
ALTER TABLE `service_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=131;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `subcategories`
--
ALTER TABLE `subcategories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `top_service`
--
ALTER TABLE `top_service`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(55) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `user_app_banner`
--
ALTER TABLE `user_app_banner`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user_notification`
--
ALTER TABLE `user_notification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `vehicle`
--
ALTER TABLE `vehicle`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `vehicle_charges`
--
ALTER TABLE `vehicle_charges`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `vehicle_driver_discount_slabs`
--
ALTER TABLE `vehicle_driver_discount_slabs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `withdraw_service`
--
ALTER TABLE `withdraw_service`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `zones`
--
ALTER TABLE `zones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `coupons_used`
--
ALTER TABLE `coupons_used`
  ADD CONSTRAINT `coupons_used_ibfk_1` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `services`
--
ALTER TABLE `services`
  ADD CONSTRAINT `services_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `services_ibfk_2` FOREIGN KEY (`subcategory_id`) REFERENCES `subcategories` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `subcategories`
--
ALTER TABLE `subcategories`
  ADD CONSTRAINT `subcategories_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
