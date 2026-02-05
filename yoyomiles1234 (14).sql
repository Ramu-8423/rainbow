-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Feb 05, 2026 at 07:47 PM
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
-- Database: `yoyomiles1234`
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
(47, 19, '987654321001', 'Kunal ', 'HYGT0123456', '987654321001', 'HDFC', '2026-01-06 08:02:34', '2026-01-06 08:02:34', 2, 1),
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
(13, 2, 'WAGON R', 1, '2026-01-27 13:22:18');

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
  `order_rating` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cab_orders`
--

INSERT INTO `cab_orders` (`id`, `order_status`, `wallet_apply`, `driver_id`, `pay_mode`, `amount_after_wallet`, `final_amount`, `matched_driver_id`, `ignored_drivers_id`, `user_id`, `vehicle_id`, `vehicle_name`, `brand_id`, `brand_name`, `model_id`, `model_name`, `pickup_location`, `pickup_latitude`, `pickup_longitude`, `drop_location`, `drop_latitude`, `drop_longitude`, `distance_km`, `estimated_amount`, `accepted_offer_id`, `cancel_reason`, `order_type`, `schedule_time`, `payment_status`, `coupon_id`, `created_at`, `updated_at`, `user_comment`, `over_limit_passenger`, `profile_photo`, `vehicle_color`, `driver_name`, `vehicle_plate_number`, `contact_number`, `orderOtp`, `rating`, `user_name`, `user_mobile`, `order_rating`) VALUES
(1, 5, 0, 78, 2, 0.00, 269.00, '[78]', NULL, 18, 2, 'Car', 3, 'Maruti Suzuki', 6, 'WagonR', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Vistar Yojna, Lucknow, Uttar Pradesh, 226031,Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434415, 80.9403007, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 9.94, 269.00, 1, NULL, 1, NULL, 0, NULL, '2026-01-17 17:52:56', '2026-01-30 08:21:51', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1768651954610.jpg', 'Beige', 'aman mishra', 'UP42HH7270', 7705827321, 5100, 4.5, 'ANSAL', 9651511938, NULL),
(3, 8, 0, NULL, 1, 0.00, 0.00, '[]', '[78]', 18, 2, 'Car', 3, 'Maruti Suzuki', 6, 'WagonR', '1/533, Lucknow, Uttar Pradesh, 226031', 26.9433367, 80.9381783, 'XWMG+PH9, Asti Rd, in front of lowrence inter College, Bargadi, Bakshi Ka Talab, Chanda Coder, Bargadi Magath, Uttar Pradesh 226201, India', 26.9842961, 80.9264973, 4.70, 235.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-17 18:36:28', '2026-01-17 18:37:54', '', 0, NULL, NULL, NULL, NULL, NULL, 1502, NULL, 'ANSAL', 9651511938, NULL),
(4, 5, 0, 78, 2, 0.00, 299.00, '[78]', NULL, 18, 2, 'Car', 3, 'Maruti Suzuki', 6, 'WagonR', '1/533, Lucknow, Uttar Pradesh, 226031', 26.9434183, 80.9381733, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 9.95, 299.00, 4, NULL, 1, NULL, 0, NULL, '2026-01-17 18:40:04', '2026-01-17 19:44:20', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1768651954610.jpg', 'Beige', 'aman mishra', 'UP42HH7270', 7705827321, 1281, 4.5, 'ANSAL', 9651511938, NULL),
(9, 5, 0, 78, 2, 0.00, 207.00, '[78]', NULL, 20, 2, 'Car', 3, 'Maruti Suzuki', 6, 'WagonR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823017, 80.9317383, 'Madiyaon, Lucknow, Uttar Pradesh, India', 26.9313253, 80.9525655, 6.03, 207.00, 5, NULL, 1, NULL, 0, NULL, '2026-01-17 19:44:59', '2026-01-17 22:40:51', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1768651954610.jpg', 'Beige', 'aman mishra', 'UP42HH7270', 7705827321, 2319, 4.5, 'aman', 8303204543, NULL),
(20, 5, 0, 78, 2, 0.00, 304.00, '[78]', NULL, 20, 2, 'Car', 3, 'Maruti Suzuki', 6, 'WagonR', 'Kamakhya Devi Marg, Saraswati Puram, Khargapur, Gomti Nagar, Lucknow, Uttar Pradesh 226010, India', 26.8446339, 81.0161371, 'Tedhi Pulia, Sector D, Jankipuram, Lucknow, Uttar Pradesh 226021, India', 26.9170385, 80.9543270, 10.12, 304.00, 6, NULL, 1, NULL, 0, NULL, '2026-01-17 22:42:55', '2026-01-17 22:45:26', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1768651954610.jpg', 'Beige', 'aman mishra', 'UP42HH7270', 7705827321, 8356, 4.5, 'aman', 8303204543, NULL),
(21, 5, 0, 78, 2, 0.00, 175.00, '[78]', NULL, 20, 2, 'Car', 3, 'Maruti Suzuki', 6, 'WagonR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822533, 80.9317867, 'Shukla Chauraha, Rasoolpur Rd, Beti Village, Jankipuram, Lucknow, Uttar Pradesh 226021, India', 26.9407246, 80.9539088, 5.11, 175.00, 7, NULL, 1, NULL, 0, NULL, '2026-01-17 22:50:57', '2026-01-17 22:51:50', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1768651954610.jpg', 'Beige', 'aman mishra', 'UP42HH7270', 7705827321, 7811, 4.5, 'aman', 8303204543, NULL),
(22, 5, 0, 78, 2, 0.00, 429.00, '[78]', NULL, 20, 2, 'Car', 3, 'Maruti Suzuki', 6, 'WagonR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822617, 80.9317717, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 14.30, 429.00, 8, NULL, 1, NULL, 0, NULL, '2026-01-17 22:52:54', '2026-01-17 22:53:38', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1768651954610.jpg', 'Beige', 'aman mishra', 'UP42HH7270', 7705827321, 2603, 4.5, 'aman', 8303204543, NULL),
(23, 5, 0, 78, 2, 0.00, 431.00, '[78]', NULL, 20, 2, 'Car', 3, 'Maruti Suzuki', 6, 'WagonR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822567, 80.9317867, 'VW3H+77Q, Kaiser Bagh, Lucknow, Uttar Pradesh 226018, India', 26.8532129, 80.9282270, 14.35, 431.00, 9, NULL, 1, NULL, 0, NULL, '2026-01-17 22:55:54', '2026-01-17 22:56:39', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1768651954610.jpg', 'Beige', 'aman mishra', 'UP42HH7270', 7705827321, 8060, 4.5, 'aman', 8303204543, NULL),
(24, 5, 0, 78, 2, 0.00, 264.00, '[78]', NULL, 20, 2, 'Car', 3, 'Maruti Suzuki', 6, 'WagonR', 'Shukla Chauraha, Rasoolpur Rd, Beti Village, Jankipuram, Lucknow, Uttar Pradesh 226021, India', 26.9407246, 80.9539088, 'Shah Mina Rd, Chowk, Lucknow, Uttar Pradesh 226003, India', 26.8692441, 80.9161691, 8.79, 264.00, 10, NULL, 1, NULL, 0, NULL, '2026-01-18 07:53:43', '2026-01-18 07:54:36', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1768651954610.jpg', 'Beige', 'aman mishra', 'UP42HH7270', 7705827321, 6388, 4.5, 'aman', 8303204543, NULL),
(25, 5, 0, 78, 2, 0.00, 264.00, '[78]', NULL, 20, 2, 'Car', 3, 'Maruti Suzuki', 6, 'WagonR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822817, 80.9317717, 'Kamakhya Devi Marg, Saraswati Puram, Khargapur, Gomti Nagar, Lucknow, Uttar Pradesh 226010, India', 26.8446339, 81.0161371, 17.44, 264.00, 11, NULL, 1, NULL, 0, NULL, '2026-01-18 07:57:06', '2026-01-18 07:57:54', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1768651954610.jpg', 'Beige', 'aman mishra', 'UP42HH7270', 7705827321, 8331, 4.5, 'aman', 8303204543, NULL),
(26, 5, 0, 78, 2, 0.00, 207.00, '[78]', NULL, 21, 2, 'Car', 3, 'Maruti Suzuki', 6, 'WagonR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9826506, 80.9317625, 'Tedhi Pulia, Sector D, Jankipuram, Lucknow, Uttar Pradesh 226021, India', 26.9170385, 80.9543270, 7.63, 207.00, 12, NULL, 1, NULL, 0, NULL, '2026-01-18 11:59:29', '2026-01-18 12:01:24', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1768651954610.jpg', 'Beige', 'aman mishra', 'UP42HH7270', 7705827321, 3536, 4.5, 'Ankit ', 7800019135, NULL),
(28, 5, 0, 78, 2, 0.00, 182.00, '[78]', NULL, 21, 2, 'Car', 3, 'Maruti Suzuki', 6, 'WagonR', 'Madiyaon, Lucknow, Uttar Pradesh, India', 26.9313253, 80.9525655, 'NH 230, Sindhunagar, Lucknow, Uttar Pradesh 226023, India', 26.7775844, 80.8824811, 18.45, 182.00, 13, NULL, 1, NULL, 0, NULL, '2026-01-18 12:02:42', '2026-01-18 12:03:09', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1768651954610.jpg', 'Beige', 'aman mishra', 'UP42HH7270', 7705827321, 5724, 4.5, 'Ankit ', 7800019135, NULL),
(29, 8, 0, NULL, 1, 0.00, 0.00, '[]', '[78]', 21, 2, 'Car', 3, 'Maruti Suzuki', 6, 'WagonR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9826282, 80.9317341, 'Munshipulia Chouraha, Munshi Pulia, Block D, Indira Nagar, Lucknow, Uttar Pradesh 226016, India', 26.8852340, 80.9959173, 12.56, 1.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-18 12:04:20', '2026-01-18 12:05:12', '', 0, NULL, NULL, NULL, NULL, NULL, 5922, NULL, 'Ankit ', 7800019135, NULL),
(30, 8, 0, NULL, 1, 0.00, 0.00, '[]', '[78]', 21, 2, 'Car', 3, 'Maruti Suzuki', 6, 'WagonR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9826282, 80.9317341, 'Munshipulia Chouraha, Munshi Pulia, Block D, Indira Nagar, Lucknow, Uttar Pradesh 226016, India', 26.8852340, 80.9959173, 12.56, 377.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-18 12:04:45', '2026-01-18 12:05:24', '', 0, NULL, NULL, NULL, NULL, NULL, 2005, NULL, 'Ankit ', 7800019135, NULL),
(31, 8, 0, NULL, 1, 0.00, 0.00, '[]', '[78]', 21, 2, 'Car', 3, 'Maruti Suzuki', 6, 'WagonR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9826282, 80.9317341, 'Munshipulia Chouraha, Munshi Pulia, Block D, Indira Nagar, Lucknow, Uttar Pradesh 226016, India', 26.8852340, 80.9959173, 12.56, 377.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-18 12:05:26', '2026-01-18 12:05:42', '', 0, NULL, NULL, NULL, NULL, NULL, 7960, NULL, 'Ankit ', 7800019135, NULL),
(33, 8, 0, NULL, 1, 0.00, 0.00, '[]', '[78]', 22, 2, 'Car', 3, 'Maruti Suzuki', 6, 'WagonR', 'XWMJ+FQF, Bargadi Magath, Uttar Pradesh, 226201', 26.9837976, 80.9319445, 'Jankipuram Extension, Lucknow, Uttar Pradesh, India', 26.9425687, 80.9382750, 4.63, 232.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-18 15:33:55', '2026-01-18 15:34:26', '', 0, NULL, NULL, NULL, NULL, NULL, 3112, NULL, 'abhay singh', 9236639289, NULL),
(34, 8, 0, NULL, 1, 0.00, 0.00, '[]', '[78]', 20, 2, 'Car', 3, 'Maruti Suzuki', 6, 'WagonR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823233, 80.9316767, 'Shukla Chauraha, Rasoolpur Rd, Beti Village, Jankipuram, Lucknow, Uttar Pradesh 226021, India', 26.9407246, 80.9539088, 5.12, 162.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-19 15:47:45', '2026-01-19 15:48:28', '', 0, NULL, NULL, NULL, NULL, NULL, 3885, NULL, 'aman', 8303204543, NULL),
(36, 8, 0, NULL, 1, 0.00, 0.00, '[]', '[78]', 20, 2, 'Car', 3, 'Maruti Suzuki', 6, 'WagonR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822667, 80.9317667, 'Shukla Chauraha, Rasoolpur Rd, Beti Village, Jankipuram, Lucknow, Uttar Pradesh 226021, India', 26.9407246, 80.9539088, 5.11, 153.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-21 20:59:58', '2026-01-21 21:00:41', '', 0, NULL, NULL, NULL, NULL, NULL, 5817, NULL, 'aman', 8303204543, NULL),
(37, 0, 0, NULL, 1, 0.00, 0.00, '[20,77]', '[19]', 13, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434822, 80.9405382, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 12.36, 185.00, NULL, NULL, 2, '2026-01-22 09:15:00', 0, NULL, '2026-01-22 09:12:56', '2026-01-22 11:01:05', '', 0, NULL, NULL, NULL, NULL, NULL, 8616, NULL, 'dhdhdhhd', 8454664645, NULL),
(40, 6, 0, NULL, 1, 0.00, 0.00, '[20,77]', NULL, 4, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434905, 80.9405276, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 12.36, 185.00, NULL, '', 1, NULL, 0, NULL, '2026-01-22 11:25:17', '2026-01-22 11:38:21', '', 0, NULL, NULL, NULL, NULL, NULL, 8882, NULL, 'Ramu ', 8423953286, NULL),
(41, 6, 0, NULL, 1, 0.00, 0.00, '[19,20,77]', NULL, 4, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434905, 80.9405276, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 12.36, 185.00, NULL, '', 1, NULL, 0, NULL, '2026-01-22 11:51:39', '2026-01-22 11:51:48', '', 0, NULL, NULL, NULL, NULL, NULL, 8061, NULL, 'Ramu ', 8423953286, NULL),
(42, 5, 0, 19, 1, 0.00, 185.00, '[19,20,77]', NULL, 4, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434356, 80.9405760, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 9.94, 185.00, 14, NULL, 1, NULL, 0, NULL, '2026-01-22 12:00:03', '2026-01-22 12:45:46', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', NULL, 'Ramu  Sharma ', NULL, 9876543210, 9492, 4, 'Ramu ', 8423953286, NULL),
(43, 8, 0, NULL, 1, 0.00, 0.00, '[]', '[78]', 20, 2, 'Car', 3, 'Maruti Suzuki', 6, 'WagonR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823089, 80.9317384, 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 7.08, 212.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-22 12:39:02', '2026-01-22 12:39:37', '', 0, NULL, NULL, NULL, NULL, NULL, 8908, NULL, 'aman', 8303204543, NULL),
(44, 6, 0, 19, 1, 0.00, 276.00, '[19,20,77]', NULL, 4, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9436606, 80.9406460, 'Amar Shaheed Path, Golf City, Sector B Ansal API, Lucknow, Hariharpur, Uttar Pradesh 226030, India', 26.7844888, 80.9913370, 18.40, 276.00, 15, 'Changed my mind', 1, NULL, 0, NULL, '2026-01-22 13:00:31', '2026-01-22 13:00:47', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', NULL, 'Ramu  Sharma ', NULL, 9876543210, 8766, 4, 'Ramu ', 8423953286, NULL),
(45, 7, 0, 19, 1, 0.00, 276.00, '[19,20,77]', NULL, 4, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435606, 80.9404741, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 9.95, 276.00, 16, 'User not responding', 1, NULL, 0, NULL, '2026-01-22 13:02:13', '2026-01-22 13:02:33', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', NULL, 'Ramu  Sharma ', NULL, 9876543210, 2666, 4, 'Ramu ', 8423953286, NULL),
(46, 5, 0, 19, 1, 0.00, 148.00, '[19,20,77]', NULL, 4, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434854, 80.9405297, 'Kamta, Lucknow, Uttar Pradesh, India', 26.8827306, 81.0134444, 9.89, 148.00, NULL, NULL, 2, '2026-01-22 15:06:00', 0, NULL, '2026-01-22 15:01:41', '2026-01-22 15:08:45', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', NULL, 'Ramu  Sharma ', NULL, 9876543210, 1301, 4, 'Ramu ', 8423953286, NULL),
(47, 7, 0, 19, 2, 0.00, 153.00, '[19,20,77]', NULL, 4, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'road, Lucknow, Uttar Pradesh, 226031', 26.9457171, 80.9407930, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 10.19, 153.00, NULL, 'Vehicle issue', 2, '2026-01-22 15:40:00', 0, NULL, '2026-01-22 15:37:28', '2026-01-22 15:40:50', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', NULL, 'Ramu  Sharma ', NULL, 9876543210, 1408, 4, 'Ramu ', 8423953286, NULL),
(48, 7, 0, 19, 1, 0.00, 149.00, '[19,20,77]', NULL, 4, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9433200, 80.9405300, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 9.92, 149.00, NULL, 'Wrong pickup location', 2, '2026-01-22 15:50:00', 0, NULL, '2026-01-22 15:46:25', '2026-01-22 15:50:20', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', NULL, 'Ramu  Sharma ', NULL, 9876543210, 9424, 4, 'Ramu ', 8423953286, NULL),
(49, 7, 0, 19, 1, 0.00, 149.00, '[19,20,77]', NULL, 4, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435276, 80.9405656, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 9.95, 149.00, NULL, 'Wrong pickup location', 2, '2026-01-22 16:00:00', 0, NULL, '2026-01-22 15:57:51', '2026-01-22 16:00:17', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', NULL, 'Ramu  Sharma ', NULL, 9876543210, 7084, 4, 'Ramu ', 8423953286, NULL),
(50, 7, 0, 19, 1, 0.00, 149.00, '[19,20,77]', NULL, 4, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9437109, 80.9405351, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 12.38, 149.00, NULL, 'User not responding', 2, '2026-01-22 16:05:00', 0, NULL, '2026-01-22 16:03:11', '2026-01-22 16:05:33', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', NULL, 'Ramu  Sharma ', NULL, 9876543210, 9279, 4, 'Ramu ', 8423953286, NULL),
(51, 7, 0, 19, 1, 0.00, 149.00, '[19,20,77]', NULL, 4, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435126, 80.9405434, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 9.95, 149.00, NULL, 'Wrong pickup location', 2, '2026-01-22 16:13:00', 0, NULL, '2026-01-22 16:11:45', '2026-01-22 16:14:12', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', NULL, 'Ramu  Sharma ', NULL, 9876543210, 8604, 4, 'Ramu ', 8423953286, NULL),
(52, 7, 0, 19, 1, 0.00, 185.00, '[19,20,77]', NULL, 4, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434860, 80.9405610, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 12.35, 185.00, NULL, 'Trip distance too short', 2, '2026-01-22 16:16:00', 0, NULL, '2026-01-22 16:14:51', '2026-01-22 16:21:52', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', NULL, 'Ramu  Sharma ', NULL, 9876543210, 8722, 4, 'Ramu ', 8423953286, NULL),
(54, 7, 0, 19, 1, 0.00, 185.00, '[19,20,77]', NULL, 4, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435417, 80.9405781, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 12.36, 185.00, NULL, 'Trip distance too short', 2, '2026-01-22 16:24:00', 0, NULL, '2026-01-22 16:22:32', '2026-01-22 16:25:32', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', NULL, 'Ramu  Sharma ', NULL, 9876543210, 5775, 4, 'Ramu ', 8423953286, NULL),
(55, 0, 0, NULL, 1, 0.00, 0.00, '[19,20,77]', NULL, 4, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9432881, 80.9405519, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 9.92, 185.00, NULL, NULL, 2, '2026-01-22 16:26:00', 0, NULL, '2026-01-22 16:25:57', '2026-01-22 10:55:57', '', 0, NULL, NULL, NULL, NULL, NULL, 6144, NULL, 'Ramu ', 8423953286, NULL),
(56, 7, 0, 19, 1, 0.00, 149.00, '[19,20,77]', NULL, 4, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434871, 80.9405910, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 9.94, 149.00, NULL, 'Trip distance too short', 2, '2026-01-22 16:28:00', 0, NULL, '2026-01-22 16:26:41', '2026-01-22 16:29:07', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', NULL, 'Ramu  Sharma ', NULL, 9876543210, 5496, 4, 'Ramu ', 8423953286, NULL),
(57, 7, 0, 19, 1, 0.00, 149.00, '[19,20,77]', NULL, 4, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9436506, 80.9405647, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 9.96, 149.00, NULL, 'User not responding', 2, '2026-01-22 16:31:00', 0, NULL, '2026-01-22 16:29:37', '2026-01-22 16:40:40', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', NULL, 'Ramu  Sharma ', NULL, 9876543210, 1792, 4, 'Ramu ', 8423953286, NULL),
(58, 7, 0, 19, 1, 0.00, 149.00, '[19,20,77]', NULL, 4, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9436561, 80.9405647, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 9.96, 149.00, NULL, 'Wrong pickup location', 2, '2026-01-22 16:43:00', 0, NULL, '2026-01-22 16:41:07', '2026-01-22 16:44:10', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', NULL, 'Ramu  Sharma ', NULL, 9876543210, 6828, 4, 'Ramu ', 8423953286, NULL),
(59, 7, 0, 19, 1, 0.00, 149.00, '[19,20,77]', NULL, 4, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9438945, 80.9405969, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 9.99, 149.00, NULL, 'Wrong pickup location', 2, '2026-01-22 16:46:00', 0, NULL, '2026-01-22 16:44:38', '2026-01-22 16:46:55', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', NULL, 'Ramu  Sharma ', NULL, 9876543210, 7499, 4, 'Ramu ', 8423953286, NULL),
(60, 7, 0, 19, 1, 0.00, 150.00, '[19,20,77]', NULL, 4, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9437547, 80.9405943, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 9.97, 150.00, NULL, 'User did not come to pickup point', 2, '2026-01-22 16:49:00', 0, NULL, '2026-01-22 16:47:21', '2026-01-22 16:51:17', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', NULL, 'Ramu  Sharma ', NULL, 9876543210, 7479, 4, 'Ramu ', 8423953286, NULL),
(61, 7, 0, 19, 1, 0.00, 150.00, '[19,20,77]', NULL, 4, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9436151, 80.9405248, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 9.96, 150.00, NULL, 'User did not come to pickup point', 2, '2026-01-22 16:53:00', 0, NULL, '2026-01-22 16:51:44', '2026-01-22 16:53:58', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', NULL, 'Ramu  Sharma ', NULL, 9876543210, 2367, 4, 'Ramu ', 8423953286, NULL),
(62, 7, 0, 19, 1, 0.00, 149.00, '[19,20,77]', NULL, 4, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9437296, 80.9406202, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 9.97, 149.00, NULL, 'User not responding', 2, '2026-01-22 16:56:00', 0, NULL, '2026-01-22 16:54:23', '2026-01-22 16:57:22', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', NULL, 'Ramu  Sharma ', NULL, 9876543210, 3224, 4, 'Ramu ', 8423953286, NULL),
(63, 6, 0, 19, 1, 0.00, 149.00, '[19,20,77]', NULL, 4, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435354, 80.9405644, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 9.95, 149.00, NULL, 'Driver is taking too long', 2, '2026-01-22 17:29:00', 0, NULL, '2026-01-22 17:27:18', '2026-01-22 17:31:27', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', NULL, 'Ramu  Sharma ', NULL, 9876543210, 4265, 4, 'Ramu ', 8423953286, NULL),
(64, 7, 0, 19, 1, 0.00, 149.00, '[19,20,77]', NULL, 4, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435030, 80.9405422, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 9.94, 149.00, NULL, 'User did not come to pickup point', 2, '2026-01-22 17:40:00', 0, NULL, '2026-01-22 17:38:26', '2026-01-22 17:40:05', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', NULL, 'Ramu  Sharma ', NULL, 9876543210, 4737, 4, 'Ramu ', 8423953286, NULL),
(65, 7, 0, 19, 1, 0.00, 149.00, '[19,20,77]', NULL, 4, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435928, 80.9405576, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 12.36, 149.00, NULL, 'User did not come to pickup point', 2, '2026-01-22 17:43:00', 0, NULL, '2026-01-22 17:41:20', '2026-01-22 17:43:12', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', NULL, 'Ramu  Sharma ', NULL, 9876543210, 4683, 4, 'Ramu ', 8423953286, NULL),
(66, 5, 0, 84, 1, 0.00, 81.00, '[84]', NULL, 25, 1, 'Auto', 2, 'TVS Motor', 3, 'King Deluxe', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434888, 80.9405366, 'Sector H Rd, Sector H, Jankipuram, Lucknow, Uttar Pradesh, India', 26.9192324, 80.9578222, 3.20, 72.00, 17, NULL, 1, NULL, 0, NULL, '2026-01-23 10:34:16', '2026-01-23 10:37:44', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769142856196.jpg', 'Orange', 'Harsh  singh', 'UP63JA7268', 7458946942, 9268, 4.5, 'Vishal', 7570006440, NULL),
(68, 6, 0, NULL, 1, 0.00, 0.00, '[20,77,87]', NULL, 18, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9433996, 80.9402909, 'Bakshi Ka Talab, Bargadi Magath, Uttar Pradesh 226201, India', 26.9841027, 80.9219764, 4.88, 98.00, NULL, '', 1, NULL, 0, NULL, '2026-01-23 13:41:39', '2026-01-23 13:41:51', '', 0, NULL, NULL, NULL, NULL, NULL, 4705, NULL, 'ANSAL', 9651511938, NULL),
(69, 6, 0, NULL, 1, 0.00, 0.00, '[20,77,87]', NULL, 18, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9433996, 80.9402909, 'Bakshi Ka Talab, Bargadi Magath, Uttar Pradesh 226201, India', 26.9841027, 80.9219764, 4.88, 98.00, NULL, '', 1, NULL, 0, NULL, '2026-01-23 13:42:10', '2026-01-23 13:42:15', '', 0, NULL, NULL, NULL, NULL, NULL, 2893, NULL, 'ANSAL', 9651511938, NULL),
(71, 7, 0, 87, 1, 0.00, 65.00, '[19,20,77,87]', NULL, 18, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434320, 80.9403218, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 12.36, 65.00, NULL, 'User not responding', 2, '2026-01-24 08:00:00', 0, NULL, '2026-01-23 13:44:32', '2026-01-25 18:26:44', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 'Bronze', 'ama  mishra', 'UP32JH5656', 7705827321, 8211, 4.5, 'ANSAL', 9651511938, NULL),
(73, 5, 0, 88, 1, 0.00, 4251.00, '[78,88]', NULL, 17, 2, 'Car', 3, 'Maruti Suzuki', 6, 'WagonR', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434399, 80.9403195, 'Delhi, India', 28.7040592, 77.1024902, 425.13, 4251.00, 19, NULL, 1, NULL, 0, NULL, '2026-01-23 14:10:47', '2026-01-23 14:13:07', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 'Beige', 'ANSAL  Pandey ', 'UP32QN1274', 9651511938, 7302, 4.5, 'aman', 7705827321, NULL),
(75, 7, 0, 88, 1, 0.00, 2437.00, '[78,88]', NULL, 17, 2, 'Mini Car', 3, 'Maruti Suzuki', 6, 'WagonR', '229, Lucknow, Uttar Pradesh, 226031', 26.9366974, 80.9346855, 'Azamgarh, Uttar Pradesh, India', 26.0739138, 83.1859495, 243.69, 2437.00, 20, 'Payment issue', 1, NULL, 0, NULL, '2026-01-23 16:34:43', '2026-01-23 16:36:38', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 'Beige', 'ANSAL  Pandey ', 'UP32QN1274', 9651511938, 4830, 4.5, 'aman', 7705827321, NULL),
(79, 8, 0, NULL, 1, 0.00, 0.00, '[84]', NULL, 28, 1, 'Auto', 1, 'Bajaj Auto', 2, 'Maxima', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434926, 80.9405322, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 9.94, 199.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-23 16:42:36', '2026-01-23 16:42:53', '', 0, NULL, NULL, NULL, NULL, NULL, 4700, NULL, 'pankaj ', 7258836052, NULL),
(87, 6, 0, 88, 1, 0.00, 3312.00, '[78,88]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 6, 'WagonR', '229, Lucknow, Uttar Pradesh, 226031', 26.9367289, 80.9346412, 'Raman Reiti, Vrindavan, Uttar Pradesh 281121, India', 27.5721848, 77.6724122, 330.11, 3312.00, 21, 'Driver is taking too long', 1, NULL, 0, NULL, '2026-01-23 16:58:12', '2026-01-23 17:00:09', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 'Beige', 'ANSAL  Pandey ', 'UP32QN1274', 9651511938, 2748, 4.5, 'aman', 7705827321, NULL),
(89, 5, 0, 88, 2, 0.00, 1975.00, '[78,88]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 6, 'WagonR', '229, Lucknow, Uttar Pradesh, 226031', 26.9367338, 80.9346392, 'Gauri Bazar, Uttar Pradesh 274202, India', 26.5958962, 83.6707463, 274.27, 1975.00, 22, NULL, 1, NULL, 0, NULL, '2026-01-23 17:14:45', '2026-01-23 17:18:37', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 'Beige', 'ANSAL  Pandey ', 'UP32QN1274', 9651511938, 2478, 4.5, 'aman', 7705827321, NULL),
(94, 5, 0, 93, 1, 0.00, 3287.00, '[78,88,93]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822355, 80.9317299, 'Raman Reiti, Vrindavan, Uttar Pradesh 281121, India', 27.5721848, 77.6724122, 328.72, 3287.00, 23, NULL, 1, NULL, 0, NULL, '2026-01-24 09:10:50', '2026-01-24 11:10:34', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 'Beige', 'manu mishra', 'UP32RD9606', 8303204543, 2040, 4.5, 'aman', 7705827321, NULL),
(98, 5, 0, 93, 2, 0.00, 2460.00, '[78,88,93]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822908, 80.9316594, 'Azamgarh, Uttar Pradesh, India', 26.0739138, 83.1859495, 245.96, 2460.00, 24, NULL, 1, NULL, 0, NULL, '2026-01-24 11:11:19', '2026-01-24 11:13:02', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 'Beige', 'manu mishra', 'UP32RD9606', 8303204543, 2538, 4.5, 'aman', 7705827321, NULL),
(100, 5, 0, 93, 2, 0.00, 2434.00, '[78,88,93]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', 'sitapur', 26.9822980, 80.9315965, 'Gorakhpur, Uttar Pradesh, India', 26.7605545, 83.3731675, 243.42, 2434.00, 25, NULL, 1, NULL, 0, NULL, '2026-01-24 11:26:27', '2026-01-24 11:34:11', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 'Beige', 'manu mishra', 'UP32RD9606', 8303204543, 4767, 4.5, 'aman', 7705827321, NULL),
(104, 8, 0, NULL, 2, 0.00, 0.00, '[78,88,93]', NULL, 28, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434953, 80.9405551, 'Gorakhpur, Uttar Pradesh, India', 26.7605545, 83.3731675, 242.18, 2422.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-24 14:01:41', '2026-01-24 14:02:03', '', 0, NULL, NULL, NULL, NULL, NULL, 2790, NULL, 'pankaj ', 7258836052, NULL),
(105, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93]', NULL, 28, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435151, 80.9405776, 'Gorakhpur, Uttar Pradesh, India', 26.7605545, 83.3731675, 242.18, 2422.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-24 14:52:03', '2026-01-24 14:52:36', '', 0, NULL, NULL, NULL, NULL, NULL, 4708, NULL, 'pankaj ', 7258836052, NULL),
(106, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 28, 5, 'SUV', 10, 'Hyundai', 19, 'Hyundai Creta', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434932, 80.9403181, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 12.37, 309.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-24 14:57:34', '2026-01-24 14:58:42', '', 0, NULL, NULL, NULL, NULL, NULL, 3425, NULL, 'pankaj ', 7258836052, NULL),
(113, 7, 0, 88, 1, 0.00, 1186.00, '[78,88,93]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 6, 'WagonR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823002, 80.9315681, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 69.75, 1186.00, 26, 'Payment issue', 1, NULL, 0, NULL, '2026-01-24 20:55:57', '2026-01-24 20:58:55', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 'Beige', 'ANSAL  Pandey ', 'UP32QN1274', 9651511938, 4965, 4.5, 'aman', 7705827321, NULL),
(119, 7, 0, 88, 2, 0.00, 284.00, '[78,88,93]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 6, 'WagonR', 'sitapur', 26.9823968, 80.9316054, 'Barabanki, Uttar Pradesh, India', 26.9268042, 81.1833809, 25.71, 284.00, 28, 'Payment issue', 1, NULL, 0, NULL, '2026-01-24 21:04:28', '2026-01-24 21:06:45', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 'Beige', 'ANSAL  Pandey ', 'UP32QN1274', 9651511938, 6984, 4.5, 'aman', 7705827321, NULL),
(123, 6, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87]', NULL, 34, 3, 'Bike', 5, 'Honda', 10, 'Shine', 'khsra no 644, Lucknow, Uttar Pradesh, 226201', 26.9841657, 80.9317111, 'Chandika Dham Rd, Shesh Ka Pura, Mewari, Uttar Pradesh 231304, India', 25.1010474, 82.7434232, 276.77, 2214.00, NULL, '', 1, NULL, 0, NULL, '2026-01-25 18:29:03', '2026-01-25 18:29:31', '', 0, NULL, NULL, NULL, NULL, NULL, 4228, NULL, 'ankit', 8173077880, NULL),
(125, 5, 0, 87, 2, 0.00, 252.00, '[19,20,77,87]', NULL, 34, 3, 'Bike', 5, 'Honda', 10, 'Shine', 'khsra no 644, Lucknow, Uttar Pradesh, 226201', 26.9843028, 80.9318394, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 14.53, 252.00, 29, NULL, 1, NULL, 0, NULL, '2026-01-25 18:32:14', '2026-01-25 18:32:54', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 'Bronze', 'ama  mishra', 'UP32JH5656', 7705827321, 9641, 4.5, 'ankit', 8173077880, NULL),
(126, 6, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87]', NULL, 34, 3, 'Bike', 5, 'Honda', 10, 'Shine', 'Gata no 644, Lucknow, Uttar Pradesh, 226201', 26.9843231, 80.9318806, '5/29, Vishal Khand, Gomti Nagar, Lucknow, Uttar Pradesh 2260, India', 26.8615460, 81.0046100, 15.44, 218.00, NULL, '', 1, NULL, 0, NULL, '2026-01-25 18:33:47', '2026-01-25 18:34:15', '', 0, NULL, NULL, NULL, NULL, NULL, 1484, NULL, 'ankit', 8173077880, NULL),
(133, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', 'Lucknow, Uttar Pradesh, India', 26.8466937, 80.9461660, 'Delhi, India', 28.7040592, 77.1024902, 430.84, 4308.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-26 10:35:26', '2026-01-26 10:36:49', '', 0, NULL, NULL, NULL, NULL, NULL, 3122, NULL, 'aman', 7705827321, NULL),
(134, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', 'Lucknow, Uttar Pradesh, India', 26.8466937, 80.9461660, 'Delhi, India', 28.7040592, 77.1024902, 430.84, 4308.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-26 10:36:56', '2026-01-26 10:37:27', '', 0, NULL, NULL, NULL, NULL, NULL, 1817, NULL, 'aman', 7705827321, NULL),
(137, 6, 0, NULL, 2, 0.00, 0.00, '[20,77,87]', '[19]', 3, 3, 'Bike', 5, 'Honda', 10, 'Shine', 'BKT, Bakshi Ka Talab, Bargadi Magath, Uttar Pradesh 226201, India', 26.9842428, 80.9232795, 'Delhi, India', 28.7040592, 77.1024902, 421.50, 3372.00, NULL, '', 1, NULL, 0, NULL, '2026-01-26 11:38:09', '2026-01-26 11:40:04', '', 0, NULL, NULL, NULL, NULL, NULL, 7182, NULL, 'pankaj ji', 9876543210, NULL),
(138, 0, 1, NULL, 3, 0.00, 0.00, '[19,20,77,87]', NULL, 3, 3, 'Black Car', 1, 'TVS Motor', 2, 'King Deluxe', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435628, 80.9405068, 'Amar Shaheed Path, Golf City, Sector B, Ansal API, Lucknow, Uttar Pradesh, 226030, India', 26.7844888, 80.9913370, 72.00, 300.00, NULL, NULL, 2, '2025-01-10 17:21:37', 0, NULL, '2026-01-26 12:32:10', '2026-01-26 07:02:10', '', 0, NULL, NULL, NULL, NULL, NULL, 4500, NULL, 'nbjh', 8423953286, NULL),
(139, 0, 1, NULL, 3, 0.00, 0.00, '[19,20,77,87]', NULL, 3, 3, 'Black Car', 1, 'TVS Motor', 2, 'King Deluxe', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435628, 80.9405068, 'Amar Shaheed Path, Golf City, Sector B, Ansal API, Lucknow, Uttar Pradesh, 226030, India', 26.7844888, 80.9913370, 72.00, 300.00, NULL, NULL, 2, '2025-01-10 17:21:37', 0, NULL, '2026-01-26 12:33:33', '2026-01-26 07:03:33', '', 0, NULL, NULL, NULL, NULL, NULL, 5155, NULL, 'nbjh', 8423953286, NULL),
(140, 0, 1, NULL, 3, 0.00, 0.00, '[19,20,77,87]', NULL, 3, 3, 'Black Car', 1, 'TVS Motor', 2, 'King Deluxe', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435628, 80.9405068, 'Amar Shaheed Path, Golf City, Sector B, Ansal API, Lucknow, Uttar Pradesh, 226030, India', 26.7844888, 80.9913370, 72.00, 300.00, NULL, NULL, 2, '2025-01-10 17:21:37', 0, NULL, '2026-01-26 12:48:29', '2026-01-26 07:18:29', '', 0, NULL, NULL, NULL, NULL, NULL, 3537, NULL, 'nbjh', 8423953286, NULL),
(141, 0, 1, NULL, 3, 0.00, 0.00, '[19,20,77,87]', NULL, 3, 3, 'Black Car', 1, 'TVS Motor', 2, 'King Deluxe', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435628, 80.9405068, 'Amar Shaheed Path, Golf City, Sector B, Ansal API, Lucknow, Uttar Pradesh, 226030, India', 26.7844888, 80.9913370, 72.00, 300.00, NULL, NULL, 2, '2025-01-10 17:21:37', 0, NULL, '2026-01-26 12:52:00', '2026-01-26 07:22:00', '', 0, NULL, NULL, NULL, NULL, NULL, 7687, NULL, 'nbjh', 8423953286, NULL),
(142, 0, 1, NULL, 3, 0.00, 0.00, '[19,20,77,87]', NULL, 3, 3, 'Black Car', 1, 'TVS Motor', 2, 'King Deluxe', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435628, 80.9405068, 'Amar Shaheed Path, Golf City, Sector B, Ansal API, Lucknow, Uttar Pradesh, 226030, India', 26.7844888, 80.9913370, 72.00, 300.00, NULL, NULL, 2, '2025-01-10 17:21:37', 0, NULL, '2026-01-26 12:53:12', '2026-01-26 07:23:13', '', 0, NULL, NULL, NULL, NULL, NULL, 5222, NULL, 'nbjh', 8423953286, NULL),
(143, 6, 0, NULL, 2, 0.00, 0.00, '[20,77,87]', '[19]', 3, 3, 'Bike', 5, 'Honda', 10, 'Shine', 'BKT, Bakshi Ka Talab, Bargadi Magath, Uttar Pradesh 226201, India', 26.9842428, 80.9232795, 'Delhi, India', 28.7040592, 77.1024902, 565.11, 4521.00, NULL, '', 1, NULL, 0, NULL, '2026-01-26 15:38:10', '2026-01-26 15:38:30', '', 0, NULL, NULL, NULL, NULL, NULL, 1558, NULL, 'pankaj ji', 9876543210, NULL),
(144, 8, 0, NULL, 2, 0.00, 0.00, '[]', NULL, 3, 5, 'SUV', 10, 'Hyundai', 18, 'Hyundai Venue', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434902, 80.9405377, 'Varanasi, Uttar Pradesh, India', 25.3176452, 82.9739144, 327.27, 3273.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-26 16:35:51', '2026-01-26 16:36:00', '', 0, NULL, NULL, NULL, NULL, NULL, 3952, NULL, 'pankaj ji', 9876543210, NULL),
(145, 8, 0, NULL, 1, 0.00, 0.00, '[78,88]', '[93]', 17, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9821950, 80.9316364, 'Gure Para, Uttar Pradesh 261207, India', 27.6080283, 80.9245756, 86.62, 1473.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-26 16:59:56', '2026-01-26 17:01:24', '', 0, NULL, NULL, NULL, NULL, NULL, 5582, NULL, 'aman', 7705827321, NULL),
(146, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', 'Gure Para, Uttar Pradesh 261207, India', 27.6080283, 80.9245756, 'Chitrakoot, Madhya Pradesh, India', 25.1788154, 80.8654534, 335.71, 1473.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-26 17:02:01', '2026-01-26 17:02:16', '', 0, NULL, NULL, NULL, NULL, NULL, 7723, NULL, 'aman', 7705827321, NULL),
(147, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', 'Gure Para, Uttar Pradesh 261207, India', 27.6080283, 80.9245756, 'Chitrakoot, Madhya Pradesh, India', 25.1788154, 80.8654534, 335.71, 3357.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-26 17:03:15', '2026-01-26 17:03:36', '', 0, NULL, NULL, NULL, NULL, NULL, 1466, NULL, 'aman', 7705827321, NULL),
(148, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', 'Sitapur Rd, Kamlapur, Uttar Pradesh, India', 27.3847506, 80.8182824, 'Chitrakoot, Madhya Pradesh, India', 25.1788154, 80.8654534, 314.20, 3357.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-26 17:05:00', '2026-01-26 17:05:08', '', 0, NULL, NULL, NULL, NULL, NULL, 3858, NULL, 'aman', 7705827321, NULL),
(149, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', 'Sidhauli, Uttar Pradesh, India', 27.2820753, 80.8344294, 'Chitrakoot, Madhya Pradesh, India', 25.1788154, 80.8654534, 302.90, 3142.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-26 17:05:43', '2026-01-26 17:06:36', '', 0, NULL, NULL, NULL, NULL, NULL, 6608, NULL, 'aman', 7705827321, NULL),
(150, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', '4V3M+9CX, Sitapur Rd, Karaundi, Uttar Pradesh 226203, India', 27.1034818, 80.8836172, 'Jhansi, Uttar Pradesh, India', 25.4487699, 78.5697526, 349.00, 3029.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-26 17:07:09', '2026-01-26 17:07:14', '', 0, NULL, NULL, NULL, NULL, NULL, 3740, NULL, 'aman', 7705827321, NULL),
(151, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822170, 80.9316945, 'Chitrakoot, Madhya Pradesh, India', 25.1788154, 80.8654534, 270.63, 2706.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-26 17:07:40', '2026-01-26 17:08:12', '', 0, NULL, NULL, NULL, NULL, NULL, 2543, NULL, 'aman', 7705827321, NULL),
(152, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', 'Charbagh, Lucknow, Uttar Pradesh, India', 26.8322933, 80.9214337, 'Delhi, India', 28.7040592, 77.1024902, 549.54, 5495.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-26 17:09:32', '2026-01-26 17:09:58', '', 0, NULL, NULL, NULL, NULL, NULL, 4282, NULL, 'aman', 7705827321, NULL),
(153, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822066, 80.9316903, 'Delhi, India', 28.7040592, 77.1024902, 566.28, 5495.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-26 17:10:32', '2026-01-26 17:10:55', '', 0, NULL, NULL, NULL, NULL, NULL, 8964, NULL, 'aman', 7705827321, NULL),
(154, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', 'VW3H+77Q, Kaiser Bagh, Lucknow, Uttar Pradesh 226018, India', 26.8532129, 80.9282270, 'Delhi, India', 28.7040592, 77.1024902, 551.52, 5663.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-26 17:14:28', '2026-01-26 17:15:10', '', 0, NULL, NULL, NULL, NULL, NULL, 5905, NULL, 'aman', 7705827321, NULL),
(155, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', 'VW3H+77Q, Kaiser Bagh, Lucknow, Uttar Pradesh 226018, India', 26.8532129, 80.9282270, 'Delhi, India', 28.7040592, 77.1024902, 551.52, 5663.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-26 17:15:14', '2026-01-26 17:16:10', '', 0, NULL, NULL, NULL, NULL, NULL, 4198, NULL, 'aman', 7705827321, NULL),
(157, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', 'Daliganj, Lucknow, Uttar Pradesh, India', 26.8727982, 80.9275954, 'Noida, Uttar Pradesh, India', 28.5355161, 77.3910265, 508.33, 5083.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-26 17:22:52', '2026-01-26 17:23:15', '', 0, NULL, NULL, NULL, NULL, NULL, 4083, NULL, 'aman', 7705827321, NULL),
(159, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 18, 2, 'Mini', 3, 'Maruti Suzuki', 6, 'WagonR', 'JVHX+W3G, Takeli, Uttar Pradesh, 261135', 27.6295000, 80.8974717, 'Bakshi Ka Talab, Bargadi Magath, Uttar Pradesh 226201, India', 26.9841027, 80.9219764, 81.43, 1384.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-26 22:05:18', '2026-01-26 22:05:43', '', 0, NULL, NULL, NULL, NULL, NULL, 4089, NULL, 'ANSAL', 9651511938, NULL),
(160, 8, 0, NULL, 1, 0.00, 0.00, '[78,88]', '[93]', 18, 2, 'Mini', 3, 'Maruti Suzuki', 6, 'WagonR', 'Bakshi Ka Talab, Bargadi Magath, Uttar Pradesh 226201, India', 26.9841027, 80.9219764, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 71.36, 1384.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-26 22:06:13', '2026-01-26 22:07:22', '', 0, NULL, NULL, NULL, NULL, NULL, 9038, NULL, 'ANSAL', 9651511938, NULL),
(161, 8, 0, NULL, 1, 0.00, 0.00, '[20,77]', '[87]', 18, 3, 'Bike', 5, 'Honda', 10, 'Shine', 'Bakshi Ka Talab, Bargadi Magath, Uttar Pradesh 226201, India', 26.9841027, 80.9219764, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 71.36, 571.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-26 22:07:35', '2026-01-26 22:08:21', '', 0, NULL, NULL, NULL, NULL, NULL, 2141, NULL, 'ANSAL', 9651511938, NULL),
(162, 5, 0, 87, 2, 0.00, 571.00, '[20,77,87]', NULL, 18, 3, 'Bike', 5, 'Honda', 10, 'Shine', 'Bakshi Ka Talab, Bargadi Magath, Uttar Pradesh 226201, India', 26.9841027, 80.9219764, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 71.36, 571.00, 30, NULL, 1, NULL, 0, NULL, '2026-01-26 22:08:30', '2026-01-26 22:10:49', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 'Bronze', 'ama  mishra', 'UP32JH5656', 7705827321, 7629, 4.5, 'ANSAL', 9651511938, NULL),
(163, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 18, 3, 'Bike', 5, 'Honda', 10, 'Shine', 'Kapoorthla, Chandralok, Lucknow, Uttar Pradesh 226024, India', 26.8819465, 80.9449643, 'Faizabad, Uttar Pradesh, India', 26.7729751, 82.1457934, 126.47, 1012.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-26 22:11:55', '2026-01-26 22:12:48', '', 0, NULL, NULL, NULL, NULL, NULL, 9462, NULL, 'ANSAL', 9651511938, NULL),
(164, 5, 0, 87, 2, 0.00, 1752.00, '[20,77,87]', NULL, 18, 3, 'Bike', 5, 'Honda', 10, 'Shine', 'Jankipuram, Lucknow, Uttar Pradesh, India', 26.9210215, 80.9511835, 'Prayagraj, Uttar Pradesh, India', 25.4683380, 81.8546019, 218.95, 1752.00, 31, NULL, 1, NULL, 0, NULL, '2026-01-26 22:15:02', '2026-01-26 22:17:29', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 'Bronze', 'ama  mishra', 'UP32JH5656', 7705827321, 6378, 4.5, 'ANSAL', 9651511938, NULL),
(165, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 18, 3, 'Bike', 5, 'Honda', 10, 'Shine', 'Aliganj, Lucknow, Uttar Pradesh, India', 26.8983705, 80.9491069, 'Bakshi Ka Talab, Bargadi Magath, Uttar Pradesh 226201, India', 26.9841027, 80.9219764, 10.64, 159.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-26 22:18:19', '2026-01-26 22:18:34', '', 0, NULL, NULL, NULL, NULL, NULL, 6174, NULL, 'ANSAL', 9651511938, NULL),
(168, 6, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', 'Gure Para, Uttar Pradesh 261207, India', 27.6080283, 80.9245756, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 29.74, 460.00, NULL, '', 1, NULL, 0, NULL, '2026-01-27 10:24:18', '2026-01-27 10:24:53', '', 0, NULL, NULL, NULL, NULL, NULL, 7712, NULL, 'aman', 7705827321, NULL),
(170, 8, 0, NULL, 1, 0.00, 0.00, '[78,88]', '[93]', 17, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 'Delhi, India', 28.7040592, 77.1024902, 458.91, 4589.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-27 10:32:05', '2026-01-27 10:32:43', '', 0, NULL, NULL, NULL, NULL, NULL, 2969, NULL, 'aman', 7705827321, NULL),
(172, 5, 0, 93, 2, 0.00, 5580.00, '[78,88,93]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 6, 'WagonR', 'Bahraich, Uttar Pradesh, India', 27.5705152, 81.5976672, 'Delhi, India', 28.7040592, 77.1024902, 558.04, 5580.00, 33, NULL, 1, NULL, 0, NULL, '2026-01-27 11:09:37', '2026-01-27 11:12:47', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 'Beige', 'manu mishra', 'UP32RD9606', 8303204543, 7273, 4.5, 'aman', 7705827321, NULL),
(173, 5, 0, 93, 2, 0.00, 1627.00, '[78,88,93]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 6, 'WagonR', 'Gure Para, Uttar Pradesh 261207, India', 27.6080283, 80.9245756, 'Lucknow, Uttar Pradesh, India', 26.8466937, 80.9461660, 95.71, 1627.00, 34, NULL, 1, NULL, 0, NULL, '2026-01-27 11:13:44', '2026-01-27 11:16:24', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 'Beige', 'manu mishra', 'UP32RD9606', 8303204543, 6665, 4.5, 'aman', 7705827321, NULL),
(174, 5, 0, 93, 2, 0.00, 6358.00, '[78,88,93]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823192, 80.9316492, 'Panipat, Haryana, India', 29.3909464, 76.9635023, 635.80, 6358.00, 35, NULL, 1, NULL, 0, NULL, '2026-01-27 13:33:11', '2026-01-27 13:34:25', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 'Beige', 'manu mishra', 'UP32RD9606', 8303204543, 1621, 4.5, 'aman', 7705827321, NULL),
(175, 6, 0, NULL, 1, 0.00, 0.00, '[78,88]', '[93]', 17, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', 'Lakhimpur, Uttar Pradesh 262701, India', 27.9462395, 80.7787163, 'Delhi, India', 28.7040592, 77.1024902, 473.01, 4730.00, NULL, '', 1, NULL, 0, NULL, '2026-01-27 17:59:54', '2026-01-27 18:01:12', '', 0, NULL, NULL, NULL, NULL, NULL, 6684, NULL, 'aman', 7705827321, NULL),
(176, 5, 0, 96, 1, 0.00, 824.00, '[78,88,93,96]', NULL, 15, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', '184, Lakhimpur, Uttar Pradesh, 262701', 27.9566449, 80.7843054, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 48.45, 824.00, 36, NULL, 1, NULL, 0, NULL, '2026-01-27 18:04:16', '2026-01-27 18:06:40', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769502101076.jpg', 'Blue', 'amar soni', 'UP 01 AB 1234', 8604396064, 1538, 4.5, 'amar', 9759999888, NULL),
(177, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', 'Lakhimpur, Uttar Pradesh 262701, India', 27.9462395, 80.7787163, 'Delhi, India', 28.7040592, 77.1024902, 473.01, 4730.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-27 18:06:35', '2026-01-27 18:08:04', '', 0, NULL, NULL, NULL, NULL, NULL, 6691, NULL, 'aman', 7705827321, NULL),
(178, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93,96]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', 'Lakhimpur, Uttar Pradesh 262701, India', 27.9462395, 80.7787163, 'Delhi, India', 28.7040592, 77.1024902, 473.01, 4730.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-27 18:08:12', '2026-01-27 18:08:17', '', 0, NULL, NULL, NULL, NULL, NULL, 6613, NULL, 'aman', 7705827321, NULL),
(179, 5, 0, 96, 2, 0.00, 4730.00, '[78,88,93,96]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', 'Lakhimpur, Uttar Pradesh 262701, India', 27.9462395, 80.7787163, 'Delhi, India', 28.7040592, 77.1024902, 473.01, 4730.00, 37, NULL, 1, NULL, 0, NULL, '2026-01-27 18:09:03', '2026-01-27 18:11:46', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769502101076.jpg', 'Blue', 'amar soni', 'UP 01 AB 1234', 8604396064, 4969, 4.5, 'aman', 7705827321, NULL),
(180, 6, 0, NULL, 1, 0.00, 0.00, '[78,88,93,96]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', 'Lucknow, Uttar Pradesh, India', 26.8466937, 80.9461660, 'Delhi, India', 28.7040592, 77.1024902, 555.47, 4730.00, NULL, '', 1, NULL, 0, NULL, '2026-01-27 18:12:12', '2026-01-27 18:13:17', '', 0, NULL, NULL, NULL, NULL, NULL, 4802, NULL, 'aman', 7705827321, NULL),
(181, 5, 0, 96, 2, 0.00, 5555.00, '[78,88,93,96]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', 'Lucknow, Uttar Pradesh, India', 26.8466937, 80.9461660, 'Delhi, India', 28.7040592, 77.1024902, 555.47, 5555.00, 38, NULL, 1, NULL, 0, NULL, '2026-01-27 18:13:42', '2026-01-27 18:20:25', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769502101076.jpg', 'Blue', 'amar soni', 'UP 01 AB 1234', 8604396064, 2439, 4.5, 'aman', 7705827321, NULL),
(183, 5, 0, 96, 2, 0.00, 6226.00, '[78,88,93,96]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', 'Lakhimpur, Uttar Pradesh 262701, India', 27.9462395, 80.7787163, 'Jaipur, Rajasthan, India', 26.9124336, 75.7872709, 622.59, 6226.00, 39, NULL, 1, NULL, 0, NULL, '2026-01-27 18:28:19', '2026-01-27 18:30:15', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769502101076.jpg', 'Blue', 'amar soni', 'UP 01 AB 1234', 8604396064, 6527, 4.5, 'aman', 7705827321, NULL),
(184, 5, 0, 96, 2, 0.00, 1142.00, '[78,88,93,96]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 5, 'Dzire', 'XWMJ+5VP, Bargadi Magath, Uttar Pradesh, 226201', 26.9826084, 80.9321528, 'Lakhimpur, Uttar Pradesh 262701, India', 27.9462395, 80.7787163, 114.18, 1142.00, 40, NULL, 1, NULL, 0, NULL, '2026-01-27 18:34:17', '2026-01-27 18:35:40', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769502101076.jpg', 'Blue', 'amar soni', 'UP 01 AB 1234', 8604396064, 5978, 4.5, 'aman', 7705827321, NULL);
INSERT INTO `cab_orders` (`id`, `order_status`, `wallet_apply`, `driver_id`, `pay_mode`, `amount_after_wallet`, `final_amount`, `matched_driver_id`, `ignored_drivers_id`, `user_id`, `vehicle_id`, `vehicle_name`, `brand_id`, `brand_name`, `model_id`, `model_name`, `pickup_location`, `pickup_latitude`, `pickup_longitude`, `drop_location`, `drop_latitude`, `drop_longitude`, `distance_km`, `estimated_amount`, `accepted_offer_id`, `cancel_reason`, `order_type`, `schedule_time`, `payment_status`, `coupon_id`, `created_at`, `updated_at`, `user_comment`, `over_limit_passenger`, `profile_photo`, `vehicle_color`, `driver_name`, `vehicle_plate_number`, `contact_number`, `orderOtp`, `rating`, `user_name`, `user_mobile`, `order_rating`) VALUES
(185, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 18, 4, 'Sedan', 9, 'Hyundai Verna', 15, 'Verna EX', '9, Lucknow, Uttar Pradesh, 226003', 26.8665667, 80.9080250, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 86.98, 1044.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-27 20:08:42', '2026-01-27 20:08:51', '', 0, NULL, NULL, NULL, NULL, NULL, 9539, NULL, 'ANSAL', 9651511938, NULL),
(186, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,87]', NULL, 18, 3, 'Bike', 6, 'Bajaj', 11, 'Pulsar 150', '9, Lucknow, Uttar Pradesh, 226003', 26.8665667, 80.9080250, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 86.98, 696.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-27 20:08:57', '2026-01-27 20:09:20', '', 0, NULL, NULL, NULL, NULL, NULL, 9461, NULL, 'ANSAL', 9651511938, NULL),
(187, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93,96]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 6, 'WagonR', 'Lakhimpur, Uttar Pradesh 262701, India', 27.9462395, 80.7787163, 'Lucknow, Uttar Pradesh, India', 26.8466937, 80.9461660, 130.10, 1301.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-27 20:13:18', '2026-01-27 20:13:41', '', 0, NULL, NULL, NULL, NULL, NULL, 7672, NULL, 'aman', 7705827321, NULL),
(188, 5, 0, 93, 2, 0.00, 1301.00, '[78,88,93,96]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 6, 'WagonR', 'Takeli, Uttar Pradesh 261135, India', 27.6306372, 80.8979587, 'Charbagh, Lucknow, Uttar Pradesh, India', 26.8322933, 80.9214337, 101.61, 1301.00, 41, NULL, 1, NULL, 0, NULL, '2026-01-27 22:45:17', '2026-01-27 22:48:20', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 'Beige', 'manu mishra', 'UP32RD9606', 8303204543, 7599, 4.5, 'aman', 7705827321, NULL),
(189, 6, 0, NULL, 1, 0.00, 0.00, '[78,88,96]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 6, 'WagonR', 'Takeli, Uttar Pradesh 261135, India', 27.6306372, 80.8979587, 'Charbagh, Lucknow, Uttar Pradesh, India', 26.8322933, 80.9214337, 101.61, 1301.00, NULL, '', 1, NULL, 0, NULL, '2026-01-27 22:48:01', '2026-01-27 22:49:09', '', 0, NULL, NULL, NULL, NULL, NULL, 1973, NULL, 'aman', 7705827321, NULL),
(190, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,96]', '[93]', 17, 2, 'Mini', 3, 'Maruti Suzuki', 6, 'WagonR', 'Takeli, Uttar Pradesh 261135, India', 27.6306372, 80.8979587, 'Charbagh, Lucknow, Uttar Pradesh, India', 26.8322933, 80.9214337, 101.61, 1301.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-27 22:49:28', '2026-01-27 22:49:44', '', 0, NULL, NULL, NULL, NULL, NULL, 6358, NULL, 'aman', 7705827321, NULL),
(191, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93,96]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 6, 'WagonR', 'Takeli, Uttar Pradesh 261135, India', 27.6306372, 80.8979587, 'Charbagh, Lucknow, Uttar Pradesh, India', 26.8322933, 80.9214337, 101.61, 1016.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-27 22:50:11', '2026-01-27 22:50:18', '', 0, NULL, NULL, NULL, NULL, NULL, 2711, NULL, 'aman', 7705827321, NULL),
(192, 6, 0, 93, 1, 0.00, 1016.00, '[78,88,93,96]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 6, 'WagonR', 'Takeli, Uttar Pradesh 261135, India', 27.6306372, 80.8979587, 'Charbagh, Lucknow, Uttar Pradesh, India', 26.8322933, 80.9214337, 101.61, 1016.00, 42, 'Driver is taking too long', 1, NULL, 0, NULL, '2026-01-27 22:50:48', '2026-01-27 22:54:33', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 'Beige', 'manu mishra', 'UP32RD9606', 8303204543, 1105, 4.5, 'aman', 7705827321, NULL),
(193, 8, 0, NULL, 2, 0.00, 0.00, '[]', NULL, 17, 4, 'Sedan', 9, 'Hyundai Verna', 15, 'Verna EX', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823527, 80.9314832, '2V5X+4QG, Rajapur Indaura, Uttar Pradesh 226202, India', 27.0081760, 80.8994302, 6.11, 165.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-28 07:49:46', '2026-01-28 07:49:55', '', 1, NULL, NULL, NULL, NULL, NULL, 5934, NULL, 'aman', 7705827321, NULL),
(194, 8, 0, NULL, 2, 0.00, 0.00, '[]', NULL, 17, 5, 'SUV', 11, 'Tata Motors', 21, 'Tata Harrier', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823527, 80.9314832, '2V5X+4QG, Rajapur Indaura, Uttar Pradesh 226202, India', 27.0081760, 80.8994302, 6.11, 153.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-28 07:50:16', '2026-01-28 07:50:22', '', 1, NULL, NULL, NULL, NULL, NULL, 7539, NULL, 'aman', 7705827321, NULL),
(195, 8, 0, NULL, 2, 0.00, 0.00, '[]', NULL, 17, 5, 'SUV', 11, 'Tata Motors', 21, 'Tata Harrier', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823527, 80.9314832, '2V5X+4QG, Rajapur Indaura, Uttar Pradesh 226202, India', 27.0081760, 80.8994302, 6.11, 153.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-28 07:50:32', '2026-01-28 07:50:38', '', 1, NULL, NULL, NULL, NULL, NULL, 6180, NULL, 'aman', 7705827321, NULL),
(196, 8, 0, NULL, 1, 0.00, 0.00, '[84]', NULL, 17, 1, 'Auto', 1, 'Bajaj Auto', 2, 'Maxima', 'XWMJ+6F, Bargadi Magath, Uttar Pradesh, 226201', 26.9828288, 80.9314272, '2V5X+4QG, Rajapur Indaura, Uttar Pradesh 226202, India', 27.0081760, 80.8994302, 5.97, 119.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-28 07:52:00', '2026-01-28 07:52:31', '', 0, NULL, NULL, NULL, NULL, NULL, 9736, NULL, 'aman', 7705827321, NULL),
(197, 8, 0, NULL, 1, 0.00, 0.00, '[20,77]', '[87]', 20, 3, 'Bike', 5, 'Honda', 10, 'Shine', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822021, 80.9316856, 'VW3H+77Q, Kaiser Bagh, Lucknow, Uttar Pradesh 226018, India', 26.8532129, 80.9282270, 16.96, 254.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-28 08:22:58', '2026-01-28 08:24:01', '', 0, NULL, NULL, NULL, NULL, NULL, 4013, NULL, 'aman', 8303204543, NULL),
(198, 8, 0, NULL, 1, 0.00, 0.00, '[20,77]', '[87]', 18, 3, 'Bike', 5, 'Honda', 10, 'Shine', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823017, 80.9316817, 'Raebareli, Uttar Pradesh, India', 26.2144806, 81.2528139, 118.07, 945.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-28 08:23:07', '2026-01-28 08:24:10', '', 0, NULL, NULL, NULL, NULL, NULL, 6762, NULL, 'ANSAL', 9651511938, NULL),
(199, 5, 0, 87, 2, 0.00, 945.00, '[20,77,87]', NULL, 18, 3, 'Bike', 5, 'Honda', 10, 'Shine', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823017, 80.9316817, 'Raebareli, Uttar Pradesh, India', 26.2144806, 81.2528139, 118.07, 945.00, 43, NULL, 1, NULL, 0, NULL, '2026-01-28 08:24:13', '2026-01-28 08:25:06', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 'Bronze', 'ama  mishra', 'UP32JH5656', 7705827321, 8311, 4.5, 'ANSAL', 9651511938, NULL),
(200, 6, 0, 87, 1, 0.00, 347.00, '[20,77,87]', NULL, 18, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822917, 80.9316667, 'Gure Para, Uttar Pradesh 261207, India', 27.6080283, 80.9245756, 86.63, 347.00, 44, 'Changed my mind', 1, NULL, 0, NULL, '2026-01-28 08:45:46', '2026-01-28 08:46:39', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 'Bronze', 'ama  mishra', 'UP32JH5656', 7705827321, 3533, 4.5, 'ANSAL', 9651511938, NULL),
(201, 7, 0, 87, 1, 0.00, 347.00, '[20,77,87]', NULL, 18, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Kapoorthla, Chandralok, Lucknow, Uttar Pradesh 226024, India', 26.8819465, 80.9449643, 'Sultanpur, Uttar Pradesh, India', 26.2585371, 82.0659858, 146.66, 347.00, 45, 'User not responding', 1, NULL, 0, NULL, '2026-01-28 08:47:57', '2026-01-28 08:48:57', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 'Bronze', 'ama  mishra', 'UP32JH5656', 7705827321, 3337, 4.5, 'ANSAL', 9651511938, NULL),
(202, 7, 0, 87, 1, 0.00, 361.00, '[20,77,87]', NULL, 18, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Atariya, Uttar Pradesh 241123, India', 27.5489270, 79.7413896, 'Maholi, Uttar Pradesh 261141, India', 27.6537759, 80.4757570, 90.34, 361.00, 46, 'User not responding', 1, NULL, 0, NULL, '2026-01-28 08:54:09', '2026-01-28 09:07:26', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 'Bronze', 'ama  mishra', 'UP32JH5656', 7705827321, 5484, 4.5, 'ANSAL', 9651511938, NULL),
(203, 8, 0, NULL, 1, 0.00, 0.00, '[20,77]', NULL, 18, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Atariya, Uttar Pradesh 241123, India', 27.5489270, 79.7413896, 'Maholi, Uttar Pradesh 261141, India', 27.6537759, 80.4757570, 90.34, 361.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-28 09:04:24', '2026-01-28 09:04:54', '', 0, NULL, NULL, NULL, NULL, NULL, 1929, NULL, 'ANSAL', 9651511938, NULL),
(204, 8, 0, NULL, 1, 0.00, 0.00, '[20,77]', NULL, 18, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'HP95+4HG, Naipalapur, Sitapur, Uttar Pradesh 261001, India', 27.5678214, 80.7089559, 'Lucknow, Uttar Pradesh, India', 26.8466937, 80.9461660, 91.95, 361.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-28 09:06:28', '2026-01-28 09:06:45', '', 0, NULL, NULL, NULL, NULL, NULL, 2082, NULL, 'ANSAL', 9651511938, NULL),
(205, 8, 0, NULL, 1, 0.00, 0.00, '[20,77]', NULL, 18, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'HP95+4HG, Naipalapur, Sitapur, Uttar Pradesh 261001, India', 27.5678214, 80.7089559, 'Lucknow, Uttar Pradesh, India', 26.8466937, 80.9461660, 91.95, 361.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-28 09:06:48', '2026-01-28 09:07:12', '', 0, NULL, NULL, NULL, NULL, NULL, 1092, NULL, 'ANSAL', 9651511938, NULL),
(206, 8, 0, NULL, 1, 0.00, 0.00, '[20,77]', NULL, 18, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'HP95+4HG, Naipalapur, Sitapur, Uttar Pradesh 261001, India', 27.5678214, 80.7089559, 'Lucknow, Uttar Pradesh, India', 26.8466937, 80.9461660, 91.95, 361.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-28 09:07:18', '2026-01-28 09:07:22', '', 0, NULL, NULL, NULL, NULL, NULL, 3039, NULL, 'ANSAL', 9651511938, NULL),
(207, 5, 0, 87, 2, 0.00, 368.00, '[20,77,87]', NULL, 18, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'bas stand, रेलवे कॉलोनी, आलमबाग, लखनऊ, उत्तर प्रदेश 226005, India', 26.8192526, 80.9069525, 'Orai, Uttar Pradesh, India', 25.9875230, 79.4488695, 191.78, 368.00, 47, NULL, 1, NULL, 0, NULL, '2026-01-28 09:18:53', '2026-01-28 09:20:23', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 'Bronze', 'ama  mishra', 'UP32JH5656', 7705827321, 8241, 4.5, 'ANSAL', 9651511938, NULL),
(208, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 18, 4, 'Sedan', 9, 'Hyundai Verna', 15, 'Verna EX', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9432430, 80.9403724, 'Sidhauli, Uttar Pradesh, India', 27.2820753, 80.8344294, 41.58, 499.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-28 12:28:39', '2026-01-28 12:28:48', '', 0, NULL, NULL, NULL, NULL, NULL, 2433, NULL, 'ANSAL', 9651511938, NULL),
(209, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 18, 5, 'SUV', 11, 'Tata Motors', 21, 'Tata Harrier', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9432430, 80.9403724, 'Sidhauli, Uttar Pradesh, India', 27.2820753, 80.8344294, 41.58, 416.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-28 12:28:55', '2026-01-28 12:29:05', '', 0, NULL, NULL, NULL, NULL, NULL, 6912, NULL, 'ANSAL', 9651511938, NULL),
(210, 6, 0, NULL, 1, 0.00, 0.00, '[20,77,87]', NULL, 18, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9432430, 80.9403724, 'Sidhauli, Uttar Pradesh, India', 27.2820753, 80.8344294, 41.58, 166.00, NULL, '', 1, NULL, 0, NULL, '2026-01-28 12:32:23', '2026-01-28 12:32:57', '', 0, NULL, NULL, NULL, NULL, NULL, 8000, NULL, 'ANSAL', 9651511938, NULL),
(211, 6, 0, NULL, 1, 0.00, 0.00, '[20,77,87]', NULL, 3, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434316, 80.9403181, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 13.22, 79.00, NULL, '', 1, NULL, 0, NULL, '2026-01-28 12:33:04', '2026-01-28 12:33:21', '', 0, NULL, NULL, NULL, NULL, NULL, 4003, NULL, 'pankaj ji', 9876543210, NULL),
(212, 8, 0, NULL, 1, 0.00, 0.00, '[20,77]', '[87]', 18, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9432430, 80.9403724, 'Sidhauli, Uttar Pradesh, India', 27.2820753, 80.8344294, 41.58, 166.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-28 12:33:13', '2026-01-28 12:33:45', '', 0, NULL, NULL, NULL, NULL, NULL, 7523, NULL, 'ANSAL', 9651511938, NULL),
(213, 7, 0, 87, 1, 0.00, 79.00, '[20,77,87]', NULL, 3, 3, 'Bike', 6, 'Bajaj', 11, 'Pulsar 150', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434130, 80.9403382, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 13.22, 79.00, 48, 'User not responding', 1, NULL, 0, NULL, '2026-01-28 12:40:59', '2026-01-28 12:41:18', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 'Bronze', 'ama  mishra', 'UP32JH5656', 7705827321, 8828, 4.5, 'pankaj ji', 9876543210, NULL),
(214, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 4, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', '2VVX+86Q, Sirsia Bir Bhan, Uttar Pradesh, 274305', 27.0435597, 83.8980201, 'Padrauna, Uttar Pradesh, India', 26.8983907, 83.9797173, 19.23, 115.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-28 13:24:11', '2026-01-28 13:24:15', '', 0, NULL, NULL, NULL, NULL, NULL, 3053, NULL, 'Ramu ', 8423953286, NULL),
(215, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 4, 4, 'Sedan', 9, 'Hyundai Verna', 15, 'Verna EX', '2VVX+86Q, Sirsia Bir Bhan, Uttar Pradesh, 274305', 27.0435597, 83.8980201, 'Padrauna, Uttar Pradesh, India', 26.8983907, 83.9797173, 19.23, 519.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-28 13:24:19', '2026-01-28 13:24:23', '', 0, NULL, NULL, NULL, NULL, NULL, 6700, NULL, 'Ramu ', 8423953286, NULL),
(216, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 4, 5, 'SUV', 11, 'Tata Motors', 21, 'Tata Harrier', '2VVX+86Q, Sirsia Bir Bhan, Uttar Pradesh, 274305', 27.0435597, 83.8980201, 'Padrauna, Uttar Pradesh, India', 26.8983907, 83.9797173, 19.23, 481.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-28 13:24:27', '2026-01-28 13:24:34', '', 0, NULL, NULL, NULL, NULL, NULL, 6583, NULL, 'Ramu ', 8423953286, NULL),
(217, 8, 0, NULL, 1, 0.00, 0.00, '[78,88]', '[93]', 17, 2, 'Mini', 3, 'Maruti Suzuki', 6, 'WagonR', 'Gomti Nagar Railway Sta Rd, Vibhuti Khand, Gomti Nagar, Lucknow, Uttar Pradesh 226010, India', 26.8636243, 81.0011848, 'Aliganj, Lucknow, Uttar Pradesh, India', 26.8983705, 80.9491069, 11.31, 2450.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-28 20:19:22', '2026-01-28 20:20:18', '', 0, NULL, NULL, NULL, NULL, NULL, 4430, NULL, 'aman', 7705827321, NULL),
(218, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 4, 2, 'Mini', 4, 'Hyundai', 17, 'Hyundai Venue', 'RQ8G+35P, Basti, Uttar Pradesh, 272001', 26.8146851, 82.7762825, 'Lucknow, Uttar Pradesh, India', 26.8466937, 80.9461660, 206.20, 2194.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-28 20:58:25', '2026-01-28 20:58:34', '', 0, NULL, NULL, NULL, NULL, NULL, 6282, NULL, 'Ramu ', 8423953286, NULL),
(219, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 4, 2, 'Mini', 4, 'Hyundai', 17, 'Hyundai Venue', 'RQ8G+35P, Basti, Uttar Pradesh, 272001', 26.8146851, 82.7762825, 'Lucknow, Uttar Pradesh, India', 26.8466937, 80.9461660, 206.20, 2194.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-28 20:58:38', '2026-01-28 20:58:42', '', 0, NULL, NULL, NULL, NULL, NULL, 9061, NULL, 'Ramu ', 8423953286, NULL),
(220, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 4, 2, 'Mini', 4, 'Hyundai', 17, 'Hyundai Venue', 'RQ8G+35P, Basti, Uttar Pradesh, 272001', 26.8146851, 82.7762825, 'Amar Shaheed Path, Golf City, Sector B Ansal API, Lucknow, Hariharpur, Uttar Pradesh 226030, India', 26.7844888, 80.9913370, 219.41, 2194.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-28 20:58:56', '2026-01-28 20:59:02', '', 0, NULL, NULL, NULL, NULL, NULL, 9359, NULL, 'Ramu ', 8423953286, NULL),
(221, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93]', NULL, 18, 2, 'Mini', 3, 'Maruti Suzuki', 6, 'WagonR', '967, Lucknow, Uttar Pradesh, 226026', 26.9199683, 80.9643983, 'Sidhauli, Uttar Pradesh, India', 27.2820753, 80.8344294, 45.16, 582.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-29 08:51:03', '2026-01-29 08:51:21', '', 0, NULL, NULL, NULL, NULL, NULL, 3213, NULL, 'ANSAL', 9651511938, NULL),
(222, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93]', NULL, 18, 2, 'Mini', 4, 'Hyundai', 17, 'Hyundai Venue', '967, Lucknow, Uttar Pradesh, 226026', 26.9200100, 80.9644217, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 82.02, 1394.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-29 08:58:09', '2026-01-29 08:58:47', '', 0, NULL, NULL, NULL, NULL, NULL, 7231, NULL, 'ANSAL', 9651511938, NULL),
(223, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93]', NULL, 4, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434988, 80.9405418, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 293.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-29 09:38:47', '2026-01-29 09:38:57', '', 0, NULL, NULL, NULL, NULL, NULL, 3246, NULL, 'Ramu ', 8423953286, NULL),
(224, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822873, 80.9315741, 'VW3H+77Q, Kaiser Bagh, Lucknow, Uttar Pradesh 226018, India', 26.8532129, 80.9282270, 16.96, 288.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-29 10:36:30', '2026-01-29 10:38:20', '', 0, NULL, NULL, NULL, NULL, NULL, 2276, NULL, 'aman', 7705827321, NULL),
(226, 5, 0, 93, 1, 0.00, 870.00, '[78,88,93]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'Ataria, Uttar Pradesh 261304, India', 27.1664842, 80.8682203, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 51.17, 870.00, 49, NULL, 1, NULL, 0, NULL, '2026-01-29 10:43:53', '2026-01-29 10:47:54', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 'Beige', 'manu mishra', 'UP32RD9606', 8303204543, 6446, 4.5, 'aman', 7705827321, NULL),
(227, 5, 0, 93, 1, 0.00, 1346.00, '[78,88,93]', NULL, 17, 2, 'Mini', 12, 'DZIRE', 5, 'Dzire', 'Sidhauli, Uttar Pradesh, India', 27.2820753, 80.8344294, 'Lakhimpur, Uttar Pradesh 262701, India', 27.9462395, 80.7787163, 79.18, 1346.00, 50, NULL, 1, NULL, 0, NULL, '2026-01-29 10:56:40', '2026-01-29 10:58:42', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 'Beige', 'manu mishra', 'UP32RD9606', 8303204543, 7967, 4.5, 'aman', 7705827321, NULL),
(228, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93]', NULL, 3, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434975, 80.9405376, 'Ayodhya, Uttar Pradesh, India', 26.7921605, 82.1997954, 140.29, 1403.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-29 11:32:19', '2026-01-29 11:32:38', '', 0, NULL, NULL, NULL, NULL, NULL, 2233, NULL, 'pankaj ji', 9876543210, NULL),
(229, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 3, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'Padrauna, Uttar Pradesh, India', 26.8983907, 83.9797173, 'Kushinagar, Uttar Pradesh 274403, India', 26.7398787, 83.8869698, 21.65, 368.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-29 11:35:19', '2026-01-29 11:35:34', '', 0, NULL, NULL, NULL, NULL, NULL, 2199, NULL, 'pankaj ji', 9876543210, NULL),
(230, 5, 0, 88, 2, 0.00, 643.00, '[78,88,93]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'Ataria, Uttar Pradesh 261304, India', 27.1664842, 80.8682203, 'VW3H+77Q, Kaiser Bagh, Lucknow, Uttar Pradesh 226018, India', 26.8532129, 80.9282270, 37.82, 643.00, 51, NULL, 1, NULL, 0, NULL, '2026-01-29 11:35:22', '2026-01-29 13:22:07', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 'Beige', 'ANSAL  Pandey ', 'UP32QN1274', 9651511938, 2034, 4.5, 'aman', 7705827321, NULL),
(231, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 3, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'Gorakhpur, Uttar Pradesh, India', 26.7605545, 83.3731675, 'Bihar, India', 25.9644427, 85.2722472, 241.99, 2420.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-29 11:37:56', '2026-01-29 11:38:13', '', 0, NULL, NULL, NULL, NULL, NULL, 4251, NULL, 'pankaj ji', 9876543210, NULL),
(233, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87]', NULL, 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434999, 80.9405511, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 103.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-29 11:59:55', '2026-01-29 12:00:53', '', 0, NULL, NULL, NULL, NULL, NULL, 5570, NULL, 'pankaj ji', 9876543210, NULL),
(235, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87]', NULL, 3, 3, 'Bike', 6, 'Bajaj', 11, 'Pulsar 150', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435156, 80.9405518, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 103.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-29 12:38:41', '2026-01-29 12:38:51', '', 0, NULL, NULL, NULL, NULL, NULL, 7708, NULL, 'pankaj ji', 9876543210, NULL),
(236, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87]', NULL, 3, 3, 'Bike', 6, 'Bajaj', 11, 'Pulsar 150', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435156, 80.9405518, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 103.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-29 12:40:26', '2026-01-29 12:40:36', '', 0, NULL, NULL, NULL, NULL, NULL, 2184, NULL, 'pankaj ji', 9876543210, NULL),
(237, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87]', NULL, 3, 3, 'Bike', 6, 'Bajaj', 11, 'Pulsar 150', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435156, 80.9405518, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 103.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-29 12:42:43', '2026-01-29 12:43:40', '', 0, NULL, NULL, NULL, NULL, NULL, 3903, NULL, 'pankaj ji', 9876543210, NULL),
(238, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87]', NULL, 3, 3, 'Bike', 6, 'Bajaj', 11, 'Pulsar 150', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435156, 80.9405518, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 103.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-29 12:44:20', '2026-01-29 12:44:54', '', 0, NULL, NULL, NULL, NULL, NULL, 8183, NULL, 'pankaj ji', 9876543210, NULL),
(239, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,87]', '[19]', 3, 3, 'Bike', 6, 'Bajaj', 11, 'Pulsar 150', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435156, 80.9405518, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 103.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-29 12:47:16', '2026-01-29 12:48:01', '', 0, NULL, NULL, NULL, NULL, NULL, 2716, NULL, 'pankaj ji', 9876543210, NULL),
(240, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87]', NULL, 3, 3, 'Bike', 6, 'Bajaj', 11, 'Pulsar 150', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435156, 80.9405518, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 103.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-29 12:52:24', '2026-01-29 12:52:49', '', 0, NULL, NULL, NULL, NULL, NULL, 1930, NULL, 'pankaj ji', 9876543210, NULL),
(241, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87]', NULL, 3, 3, 'Bike', 6, 'Bajaj', 11, 'Pulsar 150', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435156, 80.9405518, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 103.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-29 12:54:47', '2026-01-29 12:57:30', '', 0, NULL, NULL, NULL, NULL, NULL, 5586, NULL, 'pankaj ji', 9876543210, NULL),
(242, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87]', NULL, 3, 3, 'Bike', 6, 'Bajaj', 11, 'Pulsar 150', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435156, 80.9405518, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 103.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-29 12:57:37', '2026-01-29 12:58:03', '', 0, NULL, NULL, NULL, NULL, NULL, 4143, NULL, 'pankaj ji', 9876543210, NULL),
(244, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87]', NULL, 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434982, 80.9405311, 'BKT, Bakshi Ka Talab, Bargadi Magath, Uttar Pradesh 226201, India', 26.9842428, 80.9232795, 7.34, 44.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-29 13:05:21', '2026-01-29 13:05:39', '', 0, NULL, NULL, NULL, NULL, NULL, 1891, NULL, 'pankaj ji', 9876543210, NULL),
(245, 8, 0, NULL, 1, 0.00, 0.00, '[20,77,87]', '[19]', 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434982, 80.9405311, 'BKT, Bakshi Ka Talab, Bargadi Magath, Uttar Pradesh 226201, India', 26.9842428, 80.9232795, 7.34, 44.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-29 13:10:31', '2026-01-29 13:11:14', '', 0, NULL, NULL, NULL, NULL, NULL, 6462, NULL, 'pankaj ji', 9876543210, NULL),
(246, 8, 0, NULL, 1, 0.00, 0.00, '[78,93]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'Amar Shaheed Path, Golf City, Sector B Ansal API, Lucknow, Hariharpur, Uttar Pradesh 226030, India', 26.7844888, 80.9913370, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 102.86, 1029.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-29 13:21:50', '2026-01-29 13:22:49', '', 0, NULL, NULL, NULL, NULL, NULL, 4771, NULL, 'aman', 7705827321, NULL),
(247, 6, 0, NULL, 1, 0.00, 0.00, '[78,93]', '[88]', 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'Amar Shaheed Path, Golf City, Sector B Ansal API, Lucknow, Hariharpur, Uttar Pradesh 226030, India', 26.7844888, 80.9913370, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 102.86, 1029.00, NULL, '', 1, NULL, 0, NULL, '2026-01-29 13:22:52', '2026-01-29 13:23:29', '', 0, NULL, NULL, NULL, NULL, NULL, 9735, NULL, 'aman', 7705827321, NULL),
(248, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87]', NULL, 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434982, 80.9405311, 'BKT, Bakshi Ka Talab, Bargadi Magath, Uttar Pradesh 226201, India', 26.9842428, 80.9232795, 7.34, 44.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-29 13:26:39', '2026-01-29 13:26:52', '', 0, NULL, NULL, NULL, NULL, NULL, 1480, NULL, 'pankaj ji', 9876543210, NULL),
(250, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', '2W28+XX2, Bhaisamau, Uttar Pradesh, 226201', 27.0029233, 80.9174901, 'VW3H+77Q, Kaiser Bagh, Lucknow, Uttar Pradesh 226018, India', 26.8532129, 80.9282270, 19.32, 328.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-29 13:34:42', '2026-01-29 13:35:14', '', 0, NULL, NULL, NULL, NULL, NULL, 3120, NULL, 'aman', 7705827321, NULL),
(251, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87]', NULL, 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434868, 80.9405402, 'BKT, Bakshi Ka Talab, Bargadi Magath, Uttar Pradesh 226201, India', 26.9842428, 80.9232795, 7.34, 44.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-29 13:42:49', '2026-01-29 13:43:01', '', 0, NULL, NULL, NULL, NULL, NULL, 6361, NULL, 'pankaj ji', 9876543210, NULL),
(252, 8, 0, NULL, 1, 0.00, 0.00, '[19,20,77,87]', NULL, 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434868, 80.9405402, 'BKT, Bakshi Ka Talab, Bargadi Magath, Uttar Pradesh 226201, India', 26.9842428, 80.9232795, 7.34, 44.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-29 13:45:44', '2026-01-29 13:46:14', '', 0, NULL, NULL, NULL, NULL, NULL, 9970, NULL, 'pankaj ji', 9876543210, NULL),
(253, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93]', NULL, 17, 2, 'Mini', 3, 'Maruti Suzuki', 6, 'WagonR', 'Lucknow Outer Ring Rd, Hardhaurpur, Uttar Pradesh, 226202', 27.0036987, 80.8725989, 'Chitrakoot Dham, Uttar Pradesh 210205, India', 25.2157049, 80.9212199, 256.92, 2569.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-29 14:45:14', '2026-01-29 14:45:37', '', 0, NULL, NULL, NULL, NULL, NULL, 5005, NULL, 'aman', 7705827321, NULL),
(254, 7, 0, 19, 1, 0.00, 44.00, '[19,20,77,87]', NULL, 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435062, 80.9405462, 'BKT, Bakshi Ka Talab, Bargadi Magath, Uttar Pradesh 226201, India', 26.9842428, 80.9232795, 7.34, 44.00, 55, 'User not responding', 1, NULL, 0, NULL, '2026-01-29 14:52:44', '2026-01-29 14:53:40', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', NULL, 'Ramu  Sharma ', NULL, 9876543210, 4467, 4, 'pankaj ji', 9876543210, NULL),
(255, 6, 0, 19, 1, 0.00, 44.00, '[19,20,77,87]', NULL, 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435025, 80.9405470, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 13.36, 44.00, 56, 'Changed my mind', 1, NULL, 0, NULL, '2026-01-29 14:54:36', '2026-01-29 14:55:04', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', NULL, 'Ramu  Sharma ', NULL, 9876543210, 9625, 4, 'pankaj ji', 9876543210, NULL),
(256, 7, 0, 19, 1, 0.00, 103.00, '[19,20,77,87]', NULL, 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435150, 80.9405495, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 103.00, 57, 'Vehicle issue', 1, NULL, 0, NULL, '2026-01-29 14:59:54', '2026-01-29 15:00:15', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', NULL, 'Ramu  Sharma ', NULL, 9876543210, 2959, 4, 'pankaj ji', 9876543210, NULL),
(257, 6, 0, 19, 1, 0.00, 103.00, '[19,20,77,87]', NULL, 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434938, 80.9405354, 'BKT, Bakshi Ka Talab, Bargadi Magath, Uttar Pradesh 226201, India', 26.9842428, 80.9232795, 7.34, 103.00, 58, 'Driver is taking too long', 1, NULL, 0, NULL, '2026-01-29 15:00:52', '2026-01-29 15:01:18', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', NULL, 'Ramu  Sharma ', NULL, 9876543210, 2581, 4, 'pankaj ji', 9876543210, NULL),
(259, 7, 0, 87, 1, 0.00, 372.00, '[19,20,77,87]', NULL, 18, 3, 'Bike', 5, 'Honda', 10, 'Shine', 'Sidhauli, Uttar Pradesh, India', 27.2820753, 80.8344294, 'Barabanki, Uttar Pradesh, India', 26.9268042, 81.1833809, 74.42, 372.00, 59, 'User not responding', 1, NULL, 0, NULL, '2026-01-30 13:02:57', '2026-01-30 13:07:18', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769154987917.jpg', 'Bronze', 'ama  mishra', 'UP32JH5656', 7705827321, 8033, 4.5, 'ANSAL', 9651511938, NULL),
(260, 6, 0, NULL, 1, 0.00, 0.00, '[78,93]', '[88]', 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'VW3H+77Q, Kaiser Bagh, Lucknow, Uttar Pradesh 226018, India', 26.8532129, 80.9282270, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 87.83, 1493.00, NULL, '', 1, NULL, 0, NULL, '2026-01-30 13:12:34', '2026-01-30 13:13:13', '', 0, NULL, NULL, NULL, NULL, NULL, 5416, NULL, 'aman', 7705827321, NULL),
(261, 8, 0, NULL, 1, 0.00, 0.00, '[78,93]', '[88]', 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'VW3H+77Q, Kaiser Bagh, Lucknow, Uttar Pradesh 226018, India', 26.8532129, 80.9282270, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 87.83, 1493.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-30 13:13:18', '2026-01-30 13:13:59', '', 0, NULL, NULL, NULL, NULL, NULL, 8701, NULL, 'aman', 7705827321, NULL),
(262, 6, 0, NULL, 1, 0.00, 0.00, '[78,88,93]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'VW3H+77Q, Kaiser Bagh, Lucknow, Uttar Pradesh 226018, India', 26.8532129, 80.9282270, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 87.83, 1493.00, NULL, '', 1, NULL, 0, NULL, '2026-01-30 13:14:02', '2026-01-30 13:14:10', '', 0, NULL, NULL, NULL, NULL, NULL, 7014, NULL, 'aman', 7705827321, NULL),
(263, 8, 0, NULL, 1, 0.00, 0.00, '[78,93]', '[88]', 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', '6/541, Lucknow, Uttar Pradesh, 226031', 26.9386239, 80.9441004, 'Bareilly, Uttar Pradesh, India', 28.3670355, 79.4304381, 245.85, 2105.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-30 13:20:04', '2026-01-30 13:22:04', '', 0, NULL, NULL, NULL, NULL, NULL, 1983, NULL, 'aman', 7705827321, NULL),
(264, 5, 0, 93, 2, 0.00, 2178.00, '[78,88,93,19]', NULL, 17, 2, 'Mini', 12, 'DZIRE', 5, 'Dzire', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9822995, 80.9317248, 'Basti, Uttar Pradesh, India', 26.8139844, 82.7629893, 217.81, 2178.00, 60, NULL, 1, NULL, 0, NULL, '2026-01-30 21:04:21', '2026-01-31 10:04:55', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 'Beige', 'manu mishra', 'UP32RD9606', 8303204543, 9008, 4.5, 'aman', 7705827321, NULL),
(265, 6, 0, NULL, 1, 0.00, 0.00, '[96]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'Talgaon, Uttar Pradesh 261207, India', 27.6174110, 80.8548650, 'Bareilly, Uttar Pradesh, India', 28.3670355, 79.4304381, 192.19, 1922.00, NULL, '', 1, NULL, 0, NULL, '2026-01-31 09:59:47', '2026-01-31 10:01:25', '', 0, NULL, NULL, NULL, NULL, NULL, 5917, NULL, 'aman', 7705827321, NULL),
(266, 8, 0, NULL, 1, 0.00, 0.00, '[96]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'Laharpur, Uttar Pradesh 261135, India', 27.7100960, 80.9014160, 'Bareilly, Uttar Pradesh, India', 28.3670355, 79.4304381, 201.66, 2017.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-31 10:01:50', '2026-01-31 10:03:10', '', 0, NULL, NULL, NULL, NULL, NULL, 9546, NULL, 'aman', 7705827321, NULL),
(267, 8, 0, NULL, 1, 0.00, 0.00, '[96]', NULL, 17, 2, 'Mini', 4, 'Hyundai', 17, 'Hyundai Venue', 'Lakhimpur, Uttar Pradesh 262701, India', 27.9462395, 80.7787163, 'Lucknow, Uttar Pradesh, India', 26.8466937, 80.9461660, 130.10, 1301.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-31 22:32:45', '2026-01-31 22:33:07', '', 0, NULL, NULL, NULL, NULL, NULL, 2685, NULL, 'aman', 7705827321, NULL),
(268, 8, 0, NULL, 1, 0.00, 0.00, '[96]', NULL, 17, 2, 'Mini', 4, 'Hyundai', 17, 'Hyundai Venue', 'Khamaria Pandit, Uttar Pradesh 262722, India', 27.8541642, 81.0823645, 'Lucknow, Uttar Pradesh, India', 26.8466937, 80.9461660, 142.13, 1301.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-31 22:33:42', '2026-01-31 22:34:39', '', 0, NULL, NULL, NULL, NULL, NULL, 4131, NULL, 'aman', 7705827321, NULL),
(269, 8, 0, NULL, 1, 0.00, 0.00, '[96]', NULL, 17, 2, 'Mini', 4, 'Hyundai', 17, 'Hyundai Venue', 'Khamaria Pandit, Uttar Pradesh 262722, India', 27.8541642, 81.0823645, 'Lakhimpur, Uttar Pradesh 262701, India', 27.9462395, 80.7787163, 37.04, 1421.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-31 22:35:45', '2026-01-31 22:35:55', '', 0, NULL, NULL, NULL, NULL, NULL, 1958, NULL, 'aman', 7705827321, NULL),
(270, 8, 0, NULL, 1, 0.00, 0.00, '[]', NULL, 17, 1, 'Auto', 1, 'Bajaj Auto', 2, 'Maxima', 'Khamaria Pandit, Uttar Pradesh 262722, India', 27.8541642, 81.0823645, 'Lakhimpur, Uttar Pradesh 262701, India', 27.9462395, 80.7787163, 37.04, 519.00, NULL, NULL, 1, NULL, 0, NULL, '2026-01-31 22:35:59', '2026-01-31 22:36:34', '', 0, NULL, NULL, NULL, NULL, NULL, 8335, NULL, 'aman', 7705827321, NULL),
(271, 8, 0, NULL, 2, 0.00, 0.00, '[]', NULL, 3, 3, 'Bike', 5, 'Honda', 9, 'CB Hornet', 'QJPV+97P, Dilwal, Uttar Pradesh, 224119', 26.7860400, 81.6431100, 'Lucknow, Uttar Pradesh, India', 26.8466937, 80.9461660, 80.95, 405.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-01 09:46:08', '2026-02-01 09:46:26', '', 0, NULL, NULL, NULL, NULL, NULL, 3772, NULL, 'pankaj ji', 9876543210, NULL),
(272, 5, 0, 93, 1, 0.00, 5708.00, '[78,88,93,19]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', '5V86+P8J, Sitapur Rd, Ataria, Uttar Pradesh 261304, India', 27.1666200, 80.8610000, 'Delhi, India', 28.7040592, 77.1024902, 570.77, 5708.00, 61, NULL, 1, NULL, 0, NULL, '2026-02-01 10:23:36', '2026-02-01 10:25:58', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 'Beige', 'manu mishra', 'UP32RD9606', 8303204543, 9047, 4.5, 'aman', 7705827321, NULL),
(273, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93,19]', NULL, 17, 2, 'Mini', 4, 'Hyundai', 7, 'i10', 'XWJJ+V9X, Bargadi Magath, Uttar Pradesh, 226201', 26.9822465, 80.9312534, 'Delhi, India', 28.7040592, 77.1024902, 566.23, 5662.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-01 19:23:58', '2026-02-01 19:24:09', '', 0, NULL, NULL, NULL, NULL, NULL, 6942, NULL, 'aman', 7705827321, NULL),
(274, 6, 0, 93, 1, 0.00, 2706.00, '[78,88,93,19]', NULL, 17, 2, 'Mini', 12, 'DZIRE', 5, 'Dzire', 'Amar Shaheed Path, Golf City, Sector B Ansal API, Lucknow, Hariharpur, Uttar Pradesh 226030, India', 26.7844888, 80.9913370, 'Bareilly, Uttar Pradesh, India', 28.3670355, 79.4304381, 270.56, 2706.00, 62, 'Driver is taking too long', 1, NULL, 0, NULL, '2026-02-02 19:56:38', '2026-02-02 19:58:36', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 'Beige', 'manu mishra', 'UP32RD9606', 8303204543, 9867, 4.5, 'aman', 7705827321, NULL),
(275, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93,19]', NULL, 17, 2, 'Mini', 12, 'DZIRE', 5, 'Dzire', 'XWMJ+2H2, Bargadi Magath, Uttar Pradesh, 226201', 26.9823140, 80.9317889, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.69, 2706.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-02 19:59:02', '2026-02-02 19:59:17', '', 0, NULL, NULL, NULL, NULL, NULL, 1450, NULL, 'aman', 7705827321, NULL),
(276, 5, 0, 88, 1, 0.00, 293.00, '[78,88,93,19]', NULL, 4, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435711, 80.9405634, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 293.00, 63, NULL, 1, NULL, 0, NULL, '2026-02-03 10:03:43', '2026-02-03 10:06:25', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 'Beige', 'ANSAL  Pandey ', 'UP32QN1274', 9651511938, 3582, 4.5, 'Ramu ', 8423953286, NULL),
(278, 5, 0, 88, 1, 0.00, 293.00, '[78,88,93,19]', NULL, 4, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435773, 80.9405771, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 293.00, 65, NULL, 1, NULL, 0, NULL, '2026-02-03 10:13:22', '2026-02-03 10:16:10', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 'Beige', 'ANSAL  Pandey ', 'UP32QN1274', 9651511938, 1803, 4.5, 'Ramu ', 8423953286, NULL),
(279, 5, 0, 93, 1, 0.00, 1229.00, '[78,88,93,19]', NULL, 17, 2, 'Mini', 13, 'WAGON R', 22, 'WAGNOR', 'XWMH+5MG, Bargadi Magath, Uttar Pradesh, 226201', 26.9825305, 80.9292412, 'Sitapur, Uttar Pradesh, India', 27.5680156, 80.6789519, 72.32, 1229.00, 66, NULL, 1, NULL, 0, NULL, '2026-02-03 12:27:55', '2026-02-03 12:29:42', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769225436217.jpg', 'Beige', 'manu mishra', 'UP32RD9606', 8303204543, 9073, 4.5, 'aman', 7705827321, NULL),
(280, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93,19]', NULL, 4, 2, 'Mini', 3, 'Maruti Suzuki', 6, 'WagonR', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435767, 80.9405823, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 293.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-04 10:40:54', '2026-02-04 10:42:38', '', 0, NULL, NULL, NULL, NULL, NULL, 8178, NULL, 'Ramu ', 8423953286, NULL),
(281, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93,19]', NULL, 4, 2, 'Mini', 3, 'Maruti Suzuki', 6, 'WagonR', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435767, 80.9405823, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 293.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-04 10:42:41', '2026-02-04 10:47:02', '', 0, NULL, NULL, NULL, NULL, NULL, 8376, NULL, 'Ramu ', 8423953286, NULL),
(282, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93,19]', NULL, 4, 2, 'Mini', 3, 'Maruti Suzuki', 6, 'WagonR', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435767, 80.9405823, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 293.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-04 10:47:07', '2026-02-04 10:48:04', '', 0, NULL, NULL, NULL, NULL, NULL, 3102, NULL, 'Ramu ', 8423953286, NULL),
(283, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93,19]', NULL, 4, 2, 'Mini', 3, 'Maruti Suzuki', 6, 'WagonR', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435767, 80.9405823, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 293.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-04 10:48:14', '2026-02-04 10:50:38', '', 0, NULL, NULL, NULL, NULL, NULL, 9521, NULL, 'Ramu ', 8423953286, NULL),
(284, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93,19]', NULL, 4, 2, 'Mini', 3, 'Maruti Suzuki', 6, 'WagonR', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435680, 80.9405741, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 293.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-04 10:52:29', '2026-02-04 10:59:34', '', 0, NULL, NULL, NULL, NULL, NULL, 6012, NULL, 'Ramu ', 8423953286, NULL),
(285, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93,19]', NULL, 4, 2, 'Mini', 3, 'Maruti Suzuki', 6, 'WagonR', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435680, 80.9405741, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 293.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-04 10:59:38', '2026-02-04 11:03:11', '', 0, NULL, NULL, NULL, NULL, NULL, 8327, NULL, 'Ramu ', 8423953286, NULL),
(286, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93,19]', NULL, 4, 2, 'Mini', 3, 'Maruti Suzuki', 6, 'WagonR', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435680, 80.9405741, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 293.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-04 11:03:15', '2026-02-04 11:10:05', '', 0, NULL, NULL, NULL, NULL, NULL, 1282, NULL, 'Ramu ', 8423953286, NULL),
(287, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93,19]', NULL, 4, 2, 'Mini', 3, 'Maruti Suzuki', 6, 'WagonR', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435680, 80.9405741, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 293.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-04 11:10:08', '2026-02-04 11:17:43', '', 0, NULL, NULL, NULL, NULL, NULL, 3825, NULL, 'Ramu ', 8423953286, NULL),
(289, 7, 1, NULL, 3, 0.00, 0.00, '[78,88,93,19]', NULL, 3, 2, 'Black Car', 1, 'TVS Motor', 2, 'King Deluxe', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434415, 80.9403007, 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.7844888, 80.9913370, 12.50, 300.00, NULL, NULL, 2, '2025-02-04 11:59:37', 0, NULL, '2026-02-04 11:59:35', '2026-02-04 07:07:57', '', 0, NULL, NULL, NULL, NULL, NULL, 2941, NULL, 'nbjh', 8423953286, NULL),
(290, 0, 1, NULL, 3, 0.00, 0.00, '[78,93]', '[88]', 3, 2, 'Black Car', 1, 'TVS Motor', 2, 'King Deluxe', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434415, 80.9403007, 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.7844888, 80.9913370, 12.50, 300.00, NULL, NULL, 2, '2026-02-04 12:04:37', 0, NULL, '2026-02-04 12:01:44', '2026-02-04 12:10:19', '', 0, NULL, NULL, NULL, NULL, NULL, 4848, NULL, 'nbjh', 8423953286, NULL),
(291, 0, 1, NULL, 3, 0.00, 0.00, '[78,93]', '[88]', 3, 2, 'Black Car', 1, 'TVS Motor', 2, 'King Deluxe', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434415, 80.9403007, 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.7844888, 80.9913370, 12.50, 300.00, NULL, NULL, 2, '2026-02-04 12:04:37', 0, NULL, '2026-02-04 12:02:17', '2026-02-04 12:10:22', '', 0, NULL, NULL, NULL, NULL, NULL, 3682, NULL, 'nbjh', 8423953286, NULL),
(292, 0, 1, NULL, 3, 0.00, 0.00, '[78,93]', '[88]', 3, 2, 'Black Car', 1, 'TVS Motor', 2, 'King Deluxe', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434415, 80.9403007, 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.7844888, 80.9913370, 12.50, 300.00, NULL, NULL, 2, '2026-02-04 12:04:37', 0, NULL, '2026-02-04 12:02:25', '2026-02-04 12:10:27', '', 0, NULL, NULL, NULL, NULL, NULL, 9133, NULL, 'nbjh', 8423953286, NULL),
(294, 0, 1, NULL, 3, 0.00, 0.00, '[78,93]', '[88]', 3, 2, 'Black Car', 1, 'TVS Motor', 2, 'King Deluxe', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434415, 80.9403007, 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.7844888, 80.9913370, 12.50, 300.00, NULL, NULL, 2, '2026-02-04 12:10:37', 0, NULL, '2026-02-04 12:03:27', '2026-02-04 12:10:24', '', 0, NULL, NULL, NULL, NULL, NULL, 3368, NULL, 'nbjh', 8423953286, NULL),
(295, 5, 0, 88, 2, 0.00, 300.00, '[78,88,93]', NULL, 3, 2, 'Black Car', 1, 'TVS Motor', 2, 'King Deluxe', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434415, 80.9403007, 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.7844888, 80.9913370, 12.50, 300.00, NULL, NULL, 2, '2026-02-04 12:13:37', 0, NULL, '2026-02-04 12:11:09', '2026-02-04 07:06:26', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 'Beige', 'ANSAL  Pandey ', 'UP32QN1274', 9651511938, 5535, 4.5, 'nbjh', 8423953286, NULL),
(296, 0, 1, NULL, 3, 0.00, 0.00, '[78,93,19]', NULL, 1, 2, 'Black Car', 1, 'TVS Motor', 2, 'King Deluxe', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434415, 80.9403007, 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.7844888, 80.9913370, 12.50, 300.00, NULL, NULL, 2, '2026-02-04 12:13:37', 0, NULL, '2026-02-04 12:13:52', '2026-02-04 06:43:52', '', 0, NULL, NULL, NULL, NULL, NULL, 1683, NULL, 'nbjh', 8423953286, NULL),
(297, 0, 1, NULL, 3, 0.00, 0.00, '[78,93]', NULL, 1, 2, 'Black Car', 1, 'TVS Motor', 2, 'King Deluxe', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434415, 80.9403007, 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.7844888, 80.9913370, 12.50, 300.00, NULL, NULL, 2, '2026-02-04 12:15:37', 0, NULL, '2026-02-04 12:14:19', '2026-02-04 06:45:07', '', 0, NULL, NULL, NULL, NULL, NULL, 1516, NULL, 'nbjh', 8423953286, NULL),
(298, 0, 1, NULL, 3, 0.00, 0.00, '[78,93]', '[88]', 1, 2, 'Black Car', 1, 'TVS Motor', 2, 'King Deluxe', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434415, 80.9403007, 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.7844888, 80.9913370, 12.50, 300.00, NULL, NULL, 2, '2026-02-04 12:40:37', 0, NULL, '2026-02-04 12:37:01', '2026-02-04 12:41:05', '', 0, NULL, NULL, NULL, NULL, NULL, 8113, NULL, 'nbjh', 8423953286, NULL),
(300, 0, 1, NULL, 3, 0.00, 0.00, '[78,93]', '[88]', 1, 2, 'Black Car', 1, 'TVS Motor', 2, 'King Deluxe', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434415, 80.9403007, 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.7844888, 80.9913370, 12.50, 300.00, NULL, NULL, 2, '2026-02-04 12:45:37', 0, NULL, '2026-02-04 12:44:11', '2026-02-04 12:45:15', '', 0, NULL, NULL, NULL, NULL, NULL, 2069, NULL, 'nbjh', 8423953286, NULL),
(302, 5, 1, 88, 3, 0.00, 300.00, '[78,88,93]', NULL, 1, 2, 'Black Car', 1, 'TVS Motor', 2, 'King Deluxe', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434415, 80.9403007, 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.7844888, 80.9913370, 12.50, 300.00, NULL, NULL, 2, '2026-02-04 13:48:37', 0, NULL, '2026-02-04 13:46:09', '2026-02-04 09:15:08', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 'Beige', 'ANSAL  Pandey ', 'UP32QN1274', 9651511938, 5331, 4.5, 'nbjh', 8423953286, NULL),
(303, 7, 1, 88, 3, 0.00, 300.00, '[78,88,93]', NULL, 1, 2, 'Black Car', 1, 'TVS Motor', 2, 'King Deluxe', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434415, 80.9403007, 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.7844888, 80.9913370, 12.50, 300.00, NULL, 'User not responding', 2, '2026-02-04 15:08:37', 0, NULL, '2026-02-04 15:06:50', '2026-02-04 15:11:31', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 'Beige', 'ANSAL  Pandey ', 'UP32QN1274', 9651511938, 2519, 4.5, 'nbjh', 8423953286, NULL),
(304, 7, 1, 88, 3, 0.00, 300.00, '[78,88,93]', NULL, 1, 2, 'Black Car', 1, 'TVS Motor', 2, 'King Deluxe', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434415, 80.9403007, 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.7844888, 80.9913370, 12.50, 300.00, NULL, 'User not responding', 2, '2026-02-04 15:13:37', 0, NULL, '2026-02-04 15:11:53', '2026-02-04 15:13:32', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 'Beige', 'ANSAL  Pandey ', 'UP32QN1274', 9651511938, 6748, 4.5, 'nbjh', 8423953286, NULL),
(305, 0, 1, NULL, 3, 0.00, 0.00, '[78,93]', '[88]', 1, 2, 'Black Car', 1, 'TVS Motor', 2, 'King Deluxe', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434415, 80.9403007, 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.7844888, 80.9913370, 12.50, 300.00, NULL, NULL, 2, '2026-02-04 15:15:37', 0, NULL, '2026-02-04 15:14:06', '2026-02-04 15:15:14', '', 0, NULL, NULL, NULL, NULL, NULL, 4722, NULL, 'nbjh', 8423953286, NULL),
(306, 8, 0, NULL, 1, 0.00, 0.00, '[78,88,93,19]', NULL, 4, 2, 'Mini', 12, 'DZIRE', 5, 'Dzire', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435715, 80.9405626, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 293.00, NULL, NULL, 1, NULL, 0, NULL, '2026-02-04 15:16:25', '2026-02-04 15:17:03', '', 0, NULL, NULL, NULL, NULL, NULL, 7953, NULL, 'Ramu ', 8423953286, NULL),
(307, 7, 0, 88, 1, 0.00, 293.00, '[78,88,93,19]', NULL, 4, 2, 'Mini', 12, 'DZIRE', 5, 'Dzire', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435715, 80.9405626, 'Gomti Nagar, Lucknow, Uttar Pradesh, India', 26.8496217, 81.0072193, 17.22, 293.00, 67, 'Trip distance too short', 1, NULL, 0, NULL, '2026-02-04 15:17:29', '2026-02-04 15:18:07', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 'Beige', 'ANSAL  Pandey ', 'UP32QN1274', 9651511938, 4130, 4.5, 'Ramu ', 8423953286, NULL);

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
(17, 'PBC Working', 'categories/1768648261261.jpg', 1, '2026-01-17 11:11:01');

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
(4, '123412', 5, 1, '2026-01-23 14:55:00', 1, '2026-01-10 09:26:05', 'winter discount');

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
(67, 307, 'https://admin.rainbowsenterprises.com/DriverDocuments/1769156348204.jpg', 293.00, 293.00, 0, '2026-02-04 15:17:40', '2026-02-04 15:17:40', 4, 88, 'Maruti Suzuki', 'WagonR', 'ANSAL  Pandey ', 56, 4.5);

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
(27, 87, '2026-01-27 20:08:55', NULL, '2026-01-27 20:08:55', '2026-01-27 20:08:55'),
(28, 87, '2026-01-27 20:08:55', NULL, '2026-01-27 20:08:55', '2026-01-27 20:08:55'),
(29, 19, '2026-01-29 09:33:17', '2026-01-29 12:27:07', '2026-01-29 09:33:17', '2026-01-29 12:27:07'),
(30, 19, '2026-01-29 12:27:10', '2026-01-30 13:19:15', '2026-01-29 12:27:10', '2026-01-30 13:19:15'),
(31, 19, '2026-01-30 13:19:17', NULL, '2026-01-30 13:19:17', '2026-01-30 13:19:17'),
(32, 88, '2026-02-03 10:18:35', NULL, '2026-02-03 10:18:35', '2026-02-03 10:18:35');

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
(1, 0.00, 4000.00, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, '8423953211', 'DriverDocuments/1766217684864.png', 'ramu sharma', 'aaaaaaaaa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-20 08:01:25', '2026-01-23 19:35:29', 'ABC123XYZ', 'token123', 0, NULL, 0, '26.9479308', '80.9390122', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(2, 200.00, 0.00, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '8956562326', 'DriverDocuments/1766219167852.jpg', 'dhdgdh', 'bfbfhfh', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-20 08:26:08', '2026-01-21 11:01:48', 'kmjnhbg', 'kjhgjnh', 1, NULL, 1, '28.6139', '77.2090', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(3, 470.00, 0.00, 3, NULL, 1, 1, 1, NULL, NULL, NULL, '5986532256', 'DriverDocuments/1766222586331.jpg', 'sbshsush', 'dbdhsh', NULL, 'easrtghj', NULL, 'DriverDocuments/1766223181469.jpg', 'DriverDocuments/1766223181577.jpg', 'vjvkviivk', '2025-12-26', NULL, 'DriverDocuments/1766223216777.jpg', 'DriverDocuments/1766223216877.jpg', 'hfhdhfh', 'DriverDocuments/1766223216977.jpg', 'DriverDocuments/1766223217065.jpg', 'hfhfhf', NULL, 'DriverDocuments/1766223341703.jpg', 'DriverDocuments/1766223341918.jpg', 'DriverDocuments/1766223342012.jpg', 'DriverDocuments/1766223342018.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-20 09:23:06', '2025-12-22 08:24:46', 'kmjnhbg', 'kjhgjnh', 0, NULL, 1, '26.946196', '80.937907', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(4, 0.00, 0.00, 2, 2, 2, 2, 2, 3, NULL, NULL, '8864546232', 'DriverDocuments/1766223428775.jpg', 'hdhd', 'dgdgd', NULL, NULL, NULL, 'DriverDocuments/1766223450527.jpg', 'DriverDocuments/1766223450647.jpg', 'hhuuh', '2025-12-26', NULL, 'DriverDocuments/1766223474325.jpg', 'DriverDocuments/1766223474418.jpg', 'bhhuh', 'DriverDocuments/1766223474511.jpg', 'DriverDocuments/1766223474516.jpg', 'bhhu', NULL, 'DriverDocuments/1766223495972.jpg', 'DriverDocuments/1766223496067.jpg', 'DriverDocuments/1766223496163.jpg', 'DriverDocuments/1766223496221.jpg', NULL, NULL, NULL, NULL, 'vehicle document status reject', NULL, NULL, NULL, NULL, '2025-12-20 09:37:08', '2025-12-27 11:14:18', 'kmjnhbg', 'kjhgjnh', 0, NULL, 1, '26.9435287', '80.9405264', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(5, 0.00, 0.00, 2, 1, 2, 1, 1, 1, 2, NULL, '5656565656', 'DriverDocuments/1766223739400.jpg', 'gussa', 'aa rha hai ', NULL, NULL, NULL, 'DriverDocuments/1766223752569.jpg', 'DriverDocuments/1766223752677.jpg', 'dhdudh', '2025-12-27', NULL, 'DriverDocuments/1766223779881.jpg', 'DriverDocuments/1766223779978.jpg', 'bzjssh', 'DriverDocuments/1766223780069.jpg', 'DriverDocuments/1766223780077.jpg', 'upsbhsh', NULL, 'DriverDocuments/1766223795889.jpg', 'DriverDocuments/1766223795990.jpg', 'DriverDocuments/1766223796088.jpg', 'DriverDocuments/1766223796175.jpg', NULL, 'DriverDocuments/1766224394130.jpg', 'Bronze', 'bfbdbd', NULL, 'DriverDocuments/1766224434425.jpg', 'DriverDocuments/1766224434527.jpg', 'DriverDocuments/1766224434626.jpg', 'DriverDocuments/1766224434724.jpg', '2025-12-20 09:42:19', '2025-12-20 12:36:54', 'RP1A.200720.011', 'e-zsq6KyS9KoyigjnH6cFl:APA91bESbKeD_J-luQzMvWQ39-bS4qQAH1hh8KCJdr1mYqEuNdX4LY_RD9QYm25ZStcQ1ykRVH9_M2wvpRzOuJmmfOGltHFc736WGtGQZ5qdbwdTnUBtbO0', 1, NULL, 1, '26.9433457', '80.940395', NULL, NULL, 6, 3, 'HF Deluxe', 'Maruti', NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(12, 0.00, 0.00, 2, 2, 2, 2, 2, 2, 2, 'abc', '7235947666', 'DriverDocuments/1766376185037.png', 'ramu sharma', 'aaaaaaaaa', '2001-08-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-22 04:03:05', '2026-01-06 05:23:17', 'fvgbhnj', 'd1uVSDquQKCh6RhAb66BlV:APA91bEn0inBi4IFGG15w2-6-ZGgdcALmuzPJ49oDcgLJNFADMjsmBayJa5pRsQtDlVpzIjIcCP_hi3V57BuQ9S2NqMNxxqiJXp6GtvMyMYA8agkmt2FiWY', 1, NULL, 1, '28.6139', '77.2090', '2', NULL, 3, 2, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(18, 0.00, 0.00, 2, 2, 2, 2, 2, 2, 2, 'Black Car', '6333222552', 'DriverDocuments/1766576896221.jpg', 'Rohit ', 'kumar', '2000-01-22', NULL, NULL, 'DriverDocuments/1766576916117.jpg', 'DriverDocuments/1766576916583.jpg', 'jhuihu', '2025-12-25', NULL, 'DriverDocuments/1766576941812.jpg', 'DriverDocuments/1766576942303.jpg', 'hhuu', 'DriverDocuments/1766576942740.jpg', 'DriverDocuments/1766576943038.jpg', 'hjiu', NULL, 'DriverDocuments/1766576966422.jpg', 'DriverDocuments/1766576967027.jpg', 'DriverDocuments/1766576967161.jpg', 'DriverDocuments/1766576967426.jpg', NULL, 'DriverDocuments/1766576987633.jpg', 'Bronze', 'vbhuh', NULL, 'DriverDocuments/1766577014905.jpg', 'DriverDocuments/1766577015419.jpg', 'DriverDocuments/1766577015844.jpg', 'DriverDocuments/1766577016114.jpg', '2025-12-24 11:48:16', '2026-01-05 16:33:55', 'fvgbhnj', 'cEDPol0xQLyCDWhzxv27uu:APA91bGo_2Ka7p0mptSujTpQ3clhrn87sBGOF-4OLUZiJm9X4BMyr962-gfiTczs1-pivwbuV680Zw6zaALLqP7-3aC8quA65-vukwnDkjkYADYYg3rFzcE', 1, NULL, 1, '26.9476236', '80.9387408', '3', NULL, 2, 1, 'i10', 'Hyundai', '2020', 4.5, 'cabuser@gmail.com', 0, 0),
(19, 4026.00, 0.00, 2, 2, 2, 2, 2, 2, 2, 'Bike', '9876543210', 'DriverDocuments/1766834163079.jpg', 'Ramu ', 'Sharma ', '2000-01-29', NULL, NULL, 'DriverDocuments/1766839604960.jpg', 'DriverDocuments/1766839605191.jpg', 'gshshd', '2025-12-24', NULL, 'DriverDocuments/1766839629326.jpg', 'DriverDocuments/1766839629559.jpg', 'xbshhdhdb', 'DriverDocuments/1766839629661.jpg', 'DriverDocuments/1766839629756.jpg', 'shhshshshs', NULL, 'DriverDocuments/1766839703064.jpg', 'DriverDocuments/1766839703326.jpg', 'DriverDocuments/1766839703435.jpg', 'DriverDocuments/1766839703531.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-27 11:16:04', '2026-01-31 07:22:26', 'fvgbhnj', 'd_slLKHfSvOZtazkxXzFW7:APA91bE5D5-jV6EP8xnwCa-xjkoOhQD0Bx36Kfe48P4h29C-6aWENEWrsLkLTY5-ftYAG0ucEC2o_mj5ESvT9VYXXkHvBwoBMpg7Y0J_tiB4arPiBqMkM5g', 1, NULL, 1, '26.9435205', '80.9405536', '5', NULL, NULL, NULL, NULL, NULL, NULL, 4, 'cabuser@gmail.com', 7, 2),
(20, 546.78, 3000.00, 2, 2, 2, 2, 2, 2, 2, 'Black Car', '1111111111', 'DriverDocuments/1766576896221.jpg', 'wao', 'ki', '2000-01-22', NULL, NULL, 'DriverDocuments/1766576916117.jpg', 'DriverDocuments/1766576916583.jpg', 'jhuihu', '2025-12-25', NULL, 'DriverDocuments/1766576941812.jpg', 'DriverDocuments/1766576942303.jpg', 'hhuu', 'DriverDocuments/1766576942740.jpg', 'DriverDocuments/1766576943038.jpg', 'hjiu', NULL, 'DriverDocuments/1766576966422.jpg', 'DriverDocuments/1766576967027.jpg', 'DriverDocuments/1766576967161.jpg', 'DriverDocuments/1766576967426.jpg', NULL, 'DriverDocuments/1766576987633.jpg', 'Bronze', 'vbhuh', NULL, 'DriverDocuments/1766577014905.jpg', 'DriverDocuments/1766577015419.jpg', 'DriverDocuments/1766577015844.jpg', 'DriverDocuments/1766577016114.jpg', '2025-12-24 11:48:16', '2026-01-10 07:38:50', 'fvgbhnj', 'c0WwPmxESFmXhUJSy5GH3i:APA91bFYVW2orZ_dALjbaaRYGvSYQ9ZHaE-AL9be7Thc2Fr4b8J4A5-NDJhhPoGCTFNBlcHCHOSYm6lkcAFjQCd5RWhqgwNlSCDLSilZ9AzWDw4rAwxvEks', 1, NULL, 1, '26.9434758', '80.9405371', '3', NULL, 2, 1, 'i10', 'Hyundai', '2020', 5, 'cabuser@gmail.com', 46, 10),
(59, 0.00, 0.00, 2, 2, 2, 2, 2, 2, 2, 'Car', '9856325641', 'DriverDocuments/1767694239880.jpg', 'Kumar', 'dog', '2000-01-14', NULL, NULL, 'DriverDocuments/1767694840895.jpg', 'DriverDocuments/1767694841352.jpg', 'gjfjrhfh', '2022-01-06', NULL, 'DriverDocuments/1767695719404.jpg', 'DriverDocuments/1767695720281.jpg', '989894545121', 'DriverDocuments/1767695720836.jpg', 'DriverDocuments/1767695721856.jpg', 'XDDDD33636', NULL, 'DriverDocuments/1767695833514.jpg', 'DriverDocuments/1767695833822.jpg', 'DriverDocuments/1767695834201.jpg', 'DriverDocuments/1767695834521.jpg', NULL, 'DriverDocuments/1767696399567.jpg', 'Beige', 'GF08QW1234', NULL, 'DriverDocuments/1767696680051.jpg', 'DriverDocuments/1767696680412.pdf', 'DriverDocuments/1767696683607.jpg', NULL, '2026-01-06 10:10:40', '2026-01-06 10:54:39', 'edfrgtyujy', 'dqefwtrhy', 1, NULL, 1, '28.6139', '77.2090', '2', NULL, 6, 3, 'WagonR', 'Maruti Suzuki', '2025', 4.5, 'cabuser@gmail.com', 0, 0),
(67, 0.00, 0.00, 1, 0, 0, 0, 0, 0, 2, 'Bike', '9632584946', 'DriverDocuments/1768215136010.jpg', 'Aryan ', 'lalala', '2000-01-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-12 10:52:16', NULL, 'edfrgtyujy', 'dqefwtrhy', 0, NULL, 1, NULL, NULL, '3', NULL, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(68, 0.00, 0.00, 1, 0, 0, 0, 0, 0, 2, 'Bike', '9632584946', 'DriverDocuments/1768215197856.jpg', 'Aryan ', 'lalala', '2000-01-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-12 10:53:18', NULL, 'edfrgtyujy', 'dqefwtrhy', 0, NULL, 1, NULL, NULL, '3', NULL, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(70, 0.00, 0.00, 1, 0, 0, 0, 0, 0, 2, 'Bike', '9633589494', 'DriverDocuments/1768215314257.jpg', 'dbdjsh', 'dbdjdj', '2000-01-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-12 10:55:14', '2026-01-12 11:11:44', 'edfrgtyujy', 'dqefwtrhy', 0, NULL, 1, '26.9434821', '80.9405241', '3', NULL, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(73, 0.00, 0.00, 1, 0, 1, 1, 1, 0, 2, 'Bike', '9793168164', 'DriverDocuments/1768216010821.jpg', 'Aryan', 'Lala', '2000-01-08', NULL, NULL, 'DriverDocuments/1768216071972.jpg', 'DriverDocuments/1768216072375.jpg', 'ehsuhdheyedgvzhs', '2026-01-12', NULL, 'DriverDocuments/1768216113457.jpg', 'DriverDocuments/1768216114775.jpg', '545519596431', 'DriverDocuments/1768216115844.jpg', 'DriverDocuments/1768216116039.jpg', 'DHYDUSHSBS', NULL, 'DriverDocuments/1768216197913.jpg', 'DriverDocuments/1768216199390.jpg', 'DriverDocuments/1768216200705.jpg', 'DriverDocuments/1768216200856.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-12 11:06:50', '2026-01-12 11:14:36', 'edfrgtyujy', 'dqefwtrhy', 0, NULL, 1, '26.9434823', '80.9405388', '3', NULL, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(74, 0.00, 0.00, 1, 0, 1, 1, 1, 0, 2, 'Bike', '9855663256', 'DriverDocuments/1768216525146.jpg', 'vg', 'vh', '2000-01-14', NULL, NULL, 'DriverDocuments/1768216540253.jpg', 'DriverDocuments/1768216540253.jpg', 'vhhhhh', '2026-01-12', NULL, 'DriverDocuments/1768216566284.jpg', 'DriverDocuments/1768216566284.jpg', '996658996328', 'DriverDocuments/1768216566412.jpg', 'DriverDocuments/1768216566450.jpg', 'VHHGVHUUGB', NULL, 'DriverDocuments/1768216585740.jpg', 'DriverDocuments/1768216585755.jpg', 'DriverDocuments/1768216585807.jpg', 'DriverDocuments/1768216585853.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-12 11:15:25', '2026-01-12 11:16:26', 'edfrgtyujy', 'dqefwtrhy', 0, NULL, 1, '26.9434962', '80.9405396', '3', NULL, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(75, 0.00, 0.00, 3, 3, 3, 3, 3, 3, 2, 'Bike', '6666666589', 'DriverDocuments/1768217207731.jpg', 'new', 'newa', '2000-01-01', 'fir se upload kre', NULL, 'DriverDocuments/1768217231635.jpg', 'DriverDocuments/1768217231760.jpg', 'dhdhdhs', '2026-01-29', NULL, 'DriverDocuments/1768217268081.jpg', 'DriverDocuments/1768217268193.jpg', '956962386454', 'DriverDocuments/1768217268543.jpg', 'DriverDocuments/1768217268596.jpg', 'SHSHHS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-12 11:26:49', '2026-01-12 11:33:13', 'fvgbhnj', 'dwGr5ERfQjupaw6vVsD4uh:APA91bHir1WTK2RDZTJuP7uEMBPE1pw7lk7BaCjcVmSAhED9tN2KtO3oyl39WP53NdEV7OdkXQqU6YpJ_MW2aZmQVtTa47ryVaHc68igdHPPzxeyPnOdL-8', 0, NULL, 1, '26.94348', '80.9405314', '3', NULL, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(76, 0.00, 0.00, 1, 1, 1, 1, 1, 1, 2, 'Car', '9044704604', 'DriverDocuments/1768303480649.heif', 'Bharat ', 'Kumar ', '1992-07-08', NULL, NULL, 'DriverDocuments/1768303569452.jpg', 'DriverDocuments/1768303571760.jpg', 'UP4320220009854', '2032-01-13', NULL, 'DriverDocuments/1768303658426.jpg', 'DriverDocuments/1768303658633.jpg', '211736024554', 'DriverDocuments/1768303658833.jpg', 'DriverDocuments/1768303659009.jpg', 'CIPK5294P', NULL, 'DriverDocuments/1768303754722.jpg', 'DriverDocuments/1768303756979.jpg', 'DriverDocuments/1768303759264.jpg', 'DriverDocuments/1768303761754.jpg', NULL, 'DriverDocuments/1768303826368.jpg', 'Beige', 'UP43AX7818', NULL, 'DriverDocuments/1768303913112.jpg', 'DriverDocuments/1768303915895.jpg', 'DriverDocuments/1768303918675.jpg', 'DriverDocuments/1768303921305.jpg', '2026-01-13 11:24:41', '2026-01-16 08:26:01', 'edfrgtyujy', 'dqefwtrhy', 0, NULL, 1, '26.7998725', '82.2208159', '2', NULL, 6, 3, 'WagonR', 'Maruti Suzuki', '2026', 4.5, 'cabuser@gmail.com', 0, 0),
(77, 185.00, 12.95, 2, 2, 2, 2, 2, 2, 2, 'Bike', '9895542454', 'DriverDocuments/1768629251684.jpg', 'gullu', 'pandey', '2000-01-01', NULL, NULL, 'DriverDocuments/1768629283413.jpg', 'DriverDocuments/1768629283586.jpg', 'bhhuyh', '2026-01-17', NULL, 'DriverDocuments/1768629326120.jpg', 'DriverDocuments/1768629326337.jpg', '966985214785', 'DriverDocuments/1768629326487.jpg', 'DriverDocuments/1768629326547.jpg', 'BHHGFRSRTG', NULL, 'DriverDocuments/1768629355479.jpg', 'DriverDocuments/1768629355521.jpg', 'DriverDocuments/1768629355658.jpg', 'DriverDocuments/1768629355658.jpg', NULL, 'DriverDocuments/1768630157779.jpg', 'Bronze', 'UP04AS1234', NULL, 'DriverDocuments/1768630183021.jpg', 'DriverDocuments/1768630183163.jpg', 'DriverDocuments/1768630183522.jpg', NULL, '2026-01-17 05:54:11', '2026-01-20 04:46:37', 'edfrgtyujy', 'dqefwtrhy', 1, NULL, 1, '26.9435185', '80.9405498', '3', NULL, 12, 6, 'Platina', 'Bajaj', '2020', 4.5, 'cabuser@gmail.com', 0, 0),
(79, 0.00, 0.00, 1, 1, 1, 1, 1, 0, 2, 'Bike', '9895656465', 'DriverDocuments/1768979025076.jpg', 'kunsh', 'fhdhd', '2000-01-01', NULL, NULL, 'DriverDocuments/1768979097028.jpg', 'DriverDocuments/1768979097166.jpg', 'bffhd', '2026-01-21', NULL, 'DriverDocuments/1768979180987.jpg', 'DriverDocuments/1768979181144.jpg', '845445454659', 'DriverDocuments/1768979181193.jpg', 'DriverDocuments/1768979181238.jpg', 'DHDDDHDEEV', NULL, 'DriverDocuments/1768979282679.jpg', 'DriverDocuments/1768979282804.jpg', 'DriverDocuments/1768979282959.jpg', 'DriverDocuments/1768979283021.jpg', NULL, 'DriverDocuments/1768979377852.jpg', 'Black', 'AS09AS1234', NULL, NULL, NULL, NULL, NULL, '2026-01-21 07:03:45', '2026-01-21 07:09:41', 'edfrgtyujy', 'e7pFnQnoRL-8syy9tPXfRz:APA91bGcjR2FZ9R9zAHWwrPszfJqESQfCuFGaJ3_NddDaoh334ixzurBaD2TSXlCUuoIWr_8uCTdmWZaE1b4ar1cpjI1ZQWOvhbu5qD5iJhZTHArvp9OjKw', 0, NULL, 1, '26.9434979', '80.9405477', '3', NULL, 12, 6, 'Platina', 'Bajaj', '2023', 4.5, 'cabuser@gmail.com', 0, 0),
(80, 0.00, 0.00, 1, 0, 0, 1, 1, 0, 2, 'abc', '8888887777', 'DriverDocuments/1768990735568.png', 'ramu sharma', 'aaaaaaaaa', '2001-08-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'DriverDocuments/1769171796246.jpeg', 'DriverDocuments/1769171796370.png', '496137593369', 'DriverDocuments/1769171796430.png', NULL, '121hagshs', NULL, 'DriverDocuments/1769171869056.png', 'DriverDocuments/1769171883107.png', 'DriverDocuments/1769171883341.png', 'DriverDocuments/1769171883410.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-21 10:18:55', '2026-01-23 12:38:03', 'sdzfxcghjklhgfxchjk', 'szdxfghjkhgcfxd', 0, NULL, 1, '28.6139', '77.2090', '1', 3, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(81, 0.00, 0.00, 1, 1, 1, 1, 1, 1, 2, 'Car', '5655655989', 'DriverDocuments/1768995810616.jpg', 'huhu', 'jiii', '2000-01-07', NULL, NULL, 'DriverDocuments/1768995854039.jpg', 'DriverDocuments/1768995854168.jpg', 'bfhdhdhddh', '2026-01-23', NULL, 'DriverDocuments/1768995879576.jpg', 'DriverDocuments/1768995879715.jpg', '655444215989', 'DriverDocuments/1768995879767.jpg', 'DriverDocuments/1768995879820.jpg', 'DHDDDHSHSH', NULL, 'DriverDocuments/1768995967383.jpg', 'DriverDocuments/1768995967521.jpg', 'DriverDocuments/1768995967572.jpg', 'DriverDocuments/1768995967616.jpg', NULL, 'DriverDocuments/1768995993160.jpg', 'Bronze', 'DH12GS1234', NULL, 'DriverDocuments/1768996011979.jpg', 'DriverDocuments/1768996012129.jpg', 'DriverDocuments/1768996012183.jpg', NULL, '2026-01-21 11:43:30', '2026-01-21 11:47:07', 'edfrgtyujy', 'eTSDd_5PQjyvC6h0NgfF5s:APA91bFb6hHRC2Arm48CqYpjbu2cQWCTfZL6OmzMi30nopt4eKrVpOh9nB7JlVabtUZHRt9EPpuzhvy5kn4XNQ9omq1_MmeFT_UgzgQKKjxk5TGbZGTE_8s', 0, NULL, 1, '26.9435052', '80.9405786', '2', 4, 6, 3, 'WagonR', 'Maruti Suzuki', '2020', 4.5, 'cabuser@gmail.com', 0, 0),
(82, 0.00, 0.00, 1, 1, 1, 1, 1, 0, 2, 'Bike', '6652232265', 'DriverDocuments/1768996380300.jpg', 'tinku', 'jiaa', '2000-01-13', NULL, NULL, 'DriverDocuments/1768996404026.jpg', 'DriverDocuments/1768996404157.jpg', 'bhyvghytgk', '2026-01-22', NULL, 'DriverDocuments/1768996439865.jpg', 'DriverDocuments/1768996439994.jpg', '939282841829', 'DriverDocuments/1768996440053.jpg', 'DriverDocuments/1768996440102.jpg', 'BUBUBYVYVT', NULL, 'DriverDocuments/1768996602599.jpg', 'DriverDocuments/1768996602723.jpg', 'DriverDocuments/1768996602770.jpg', NULL, NULL, 'DriverDocuments/1768996635257.jpg', 'Bronze', 'NB12SD1234', NULL, NULL, NULL, NULL, NULL, '2026-01-21 11:53:00', '2026-01-21 11:57:18', 'edfrgtyujy', 'eMQTI08XQ5e5wI80zdjPY-:APA91bFaIObvWaZPP-WAdYy881_y0oYGXGFqBxCk7eIZgDb0BkUv586Fd8p4Y8BhOTVyhH223GHMRTL_ynOxLcTlOZ3C9CBVYmyQQvcGVl7kDYRIE9AkBkY', 0, NULL, 1, '26.943497', '80.940539', '3', 2, 12, 6, 'Platina', 'Bajaj', '2020', 4.5, 'cabuser@gmail.com', 0, 0),
(84, 81.00, 0.00, 2, 2, 2, 2, 1, 2, 2, 'Auto', '7458946942', 'DriverDocuments/1769142856196.jpg', 'Harsh ', 'singh', '1997-04-11', NULL, NULL, 'DriverDocuments/1769143005054.jpg', 'DriverDocuments/1769143005336.jpg', 'up633844848484848484', '2030-02-23', NULL, 'DriverDocuments/1769143151192.jpg', 'DriverDocuments/1769143151611.jpg', '646465646464', 'DriverDocuments/1769143151861.jpg', 'DriverDocuments/1769143152210.jpg', 'HGMPS6411L', NULL, 'DriverDocuments/1769149601457.png', 'DriverDocuments/1769149601609.png', 'DriverDocuments/1769149601705.png', 'DriverDocuments/1769149601811.png', NULL, 'DriverDocuments/1769143422043.jpg', 'Orange', 'UP63JA7268', NULL, 'DriverDocuments/1769143533088.jpg', 'DriverDocuments/1769143533621.jpg', 'DriverDocuments/1769143533967.jpg', NULL, '2026-01-23 04:34:16', '2026-01-23 06:26:42', 'edfrgtyujy', 'dgwbzbyqSOO5xG_LCOIAbE:APA91bFSeTNMyuJJV071NRBXuk_6r42k-U6W6ZVczw0tp9clXu0Yms2Mau9R_v56qNWSTwzMDdOZIJaN8FxlIPVQiz5RLDssuPJMDZeBknKP_o3c93H737E', 1, NULL, 1, '26.9434998', '80.9405488', '1', 3, 1, 1, 'RE Compact', 'Bajaj Auto', '2025', 4.5, 'cabuser@gmail.com', 0, 0),
(85, 0.00, 0.00, 1, 0, 0, 0, 0, 0, 2, 'Car', '6532256535', 'DriverDocuments/1769150018483.jpg', 'hfhfhf', 'vn cn', '2000-01-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-23 06:33:38', '2026-01-23 07:06:59', 'edfrgtyujy', 'csNv_-riT7iXbPZza5y8nX:APA91bFe4IWmgT9mOk1-gCdHx-k_DHJPuwq4T_9yj20CjCZM769fRL7uHZxJFiFEcQFWXDFjVox0W9EIjzULBBxRby0Q6_pUqN38f38UVFNJcMZKaRbbTgU', 0, NULL, 1, '26.9435389', '80.9405651', '2', 4, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(86, 0.00, 0.00, 1, 1, 1, 1, 1, 0, 2, 'Bike', '7570006440', 'DriverDocuments/1769151606883.png', 'Vishal ', 'Mishra ', '2000-01-08', NULL, NULL, 'DriverDocuments/1769151624032.png', 'DriverDocuments/1769151624910.png', 'gdhhdjd', '2026-01-24', NULL, 'DriverDocuments/1769151657158.png', 'DriverDocuments/1769151657551.png', '565656989494', 'DriverDocuments/1769151657701.png', 'DriverDocuments/1769151657856.png', 'HDHDJDJD', NULL, 'DriverDocuments/1769151683802.pdf', 'DriverDocuments/1769151684490.pdf', 'DriverDocuments/1769151684640.pdf', NULL, NULL, 'DriverDocuments/1769151734521.png', 'Beige', 'UP57AB6432', NULL, NULL, NULL, NULL, NULL, '2026-01-23 07:00:07', '2026-01-23 07:02:32', 'edfrgtyujy', 'd9RWRN-LTeKoj7CCa-WrzS:APA91bE6aHJ-5Cr_gAWMiR-9p_pIXZe1o0QJ5bEVsMTDCQXRmOPrk5AEs_bFUt06FHDfx3b9PQR3nAJHPyiK-Aqzc4dMPDf7cdn3RMJa5PiFoXjq_8rz_78', 0, NULL, 1, '26.9435077', '80.9405513', '3', 2, 12, 6, 'Platina', 'Bajaj', '2017', 4.5, 'cabuser@gmail.com', 0, 0),
(87, 0.00, 291.60, 2, 2, 2, 2, 2, 2, 2, 'Bike', '7705827321', 'DriverDocuments/1769154987917.jpg', 'ama ', 'mishra', '1997-01-05', NULL, NULL, 'DriverDocuments/1769155046897.png', 'DriverDocuments/1769155047056.jpg', 'hfyu', '2030-01-30', NULL, 'DriverDocuments/1769155092357.jpg', 'DriverDocuments/1769155092664.png', '656685358523', 'DriverDocuments/1769155092670.png', 'DriverDocuments/1769155092678.jpg', 'CMQLL9652T', NULL, 'DriverDocuments/1769155139868.jpg', 'DriverDocuments/1769155140033.jpg', 'DriverDocuments/1769155140134.jpg', NULL, NULL, 'DriverDocuments/1769155312108.jpg', 'Bronze', 'UP32JH5656', NULL, NULL, NULL, NULL, NULL, '2026-01-23 07:56:28', '2026-02-01 04:57:30', 'fvgbhnj', 'fxXaJpzvQ52z8Vc9dW911s:APA91bG5RQmNHDKpX9eQc7x6vf8lBtlqZaNMmxarKLbL9c5yHPXYkz__BlpBFzWGCRNrrVEesBfRUsPJckdURWXxZ-Ij5F4F9XoyeIo_dSzzsy-9N0_rCfY', 1, NULL, 1, '26.9807292', '80.9317859', '3', 2, 12, 6, 'Platina', 'Bajaj', '2017', 4.5, 'cabuser@gmail.com', 0, 0),
(88, 4837.00, 196.34, 2, 2, 2, 2, 2, 2, 2, 'Car', '9651511938', 'DriverDocuments/1769156348204.jpg', 'ANSAL ', 'Pandey ', '1997-01-01', NULL, NULL, 'DriverDocuments/1769156950800.jpg', 'DriverDocuments/1769156950873.jpg', 'up3420100012033', '2030-01-23', NULL, 'DriverDocuments/1769156990509.jpg', 'DriverDocuments/1769156990903.jpg', '648836330721', 'DriverDocuments/1769156991304.jpg', 'DriverDocuments/1769156991760.jpg', 'CMQPP9258R', NULL, 'DriverDocuments/1769157041590.jpg', 'DriverDocuments/1769157041987.jpg', 'DriverDocuments/1769157042462.jpg', NULL, NULL, 'DriverDocuments/1769157080372.jpg', 'Beige', 'UP32QN1274', NULL, 'DriverDocuments/1769157194665.jpg', 'DriverDocuments/1769157194782.jpg', 'DriverDocuments/1769157194851.jpg', 'DriverDocuments/1769157194866.jpg', '2026-01-23 08:19:08', '2026-02-04 09:58:06', 'fvgbhnj', 'dOAui_z3S9292lI5SbhpQW:APA91bE02gXgKM596edcYQWjDBcbUxg7lmJpj0Ii_DWsTzRMOBEpd_d8jgC5KdY1WA9Tk3KMPOlNa4QLnN7dfhZOuNhxCyG_44krgrsVLH71cUq-URDcuA8', 1, NULL, 1, '26.943568', '80.9405741', '2', 4, 6, 3, 'WagonR', 'Maruti Suzuki', '2022', 4.5, 'cabuser@gmail.com', 0, 0),
(90, 0.00, 0.00, 2, 2, 2, 2, 2, 2, 2, 'Bike', '5656532598', 'DriverDocuments/1769192061257.jpg', 'basant', 'panchmi ', '2000-01-01', NULL, NULL, 'DriverDocuments/1769192096542.jpg', 'DriverDocuments/1769192096809.jpg', 'BD12GE123356', '2026-01-31', NULL, 'DriverDocuments/1769192147635.jpg', 'DriverDocuments/1769192147898.jpg', '956431215487', 'DriverDocuments/1769192148098.jpg', NULL, 'BFHDHDHEGD', NULL, NULL, 'DriverDocuments/1769192403616.jpg', 'DriverDocuments/1769192403833.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-23 18:14:21', '2026-01-23 18:21:29', 'edfrgtyujy', 'eaHaBWbzSBWk7uAVN8ZRMe:APA91bESB9XwBm1hwWHdh58ht-w8-gdL6SRWcWry8VY__CnYZkmoNOn03rZOIv0qeIEbR1Cl0yPVOfvjtvfbzMbBzNgb194gJVdqjSloZGl22ZL5Qqvmwsw', 0, NULL, 1, '26.9476026', '80.9389603', '3', 2, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(91, 0.00, 0.00, 1, 0, 1, 1, 1, 0, 2, 'Bike', '9636962851', 'DriverDocuments/1769192716418.jpg', 'ncbcbd', 'bdbddb', '2000-01-12', NULL, NULL, 'DriverDocuments/1769192773466.jpg', 'DriverDocuments/1769192773466.jpg', 'GG12FT1234455', '2026-01-31', NULL, 'DriverDocuments/1769192798600.jpg', 'DriverDocuments/1769192798838.jpg', '963355855211', 'DriverDocuments/1769192799103.jpg', NULL, 'VHYYFGBHHY', NULL, 'DriverDocuments/1769192817176.jpg', 'DriverDocuments/1769192817459.jpg', 'DriverDocuments/1769192817784.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-23 18:25:16', '2026-01-23 18:32:26', 'edfrgtyujy', 'ea_qFtASRV-8cQEOVptrZV:APA91bEZLVbF_-m2Jep4uW6JZppDdPgFMGruKZAXpqVcz2Ms8sjr1phXKqkXvKQ63MvjE0ceW0irFE1iIrjjEis3HKM2CGe6Oy_lqzdFt8nC4dmBP_VzqRI', 0, NULL, 1, '26.9475292', '80.9389713', '3', 2, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(92, 0.00, 0.00, 1, 1, 1, 1, 1, 0, 2, 'Bike', '6565689598', 'DriverDocuments/1769193485292.jpg', 'ugufucuc', ' bcchch', '2000-01-29', NULL, NULL, 'DriverDocuments/1769193513382.jpg', 'DriverDocuments/1769193514100.jpg', 'VU12VG1234447', '2026-01-31', NULL, 'DriverDocuments/1769193548526.jpg', 'DriverDocuments/1769193549183.jpg', '693838252283', 'DriverDocuments/1769193549854.jpg', NULL, 'BIBUBIUDTF', NULL, NULL, 'DriverDocuments/1769193561915.jpg', 'DriverDocuments/1769193562569.jpg', NULL, NULL, 'DriverDocuments/1769193584901.jpg', 'Bronze', 'VH 12 3456', NULL, NULL, NULL, NULL, NULL, '2026-01-23 18:38:05', '2026-01-23 18:46:26', 'edfrgtyujy', 'd1h5RkmCQMy2Qru47tKHw4:APA91bFo4tgMTSx_Y-xmwBtP5d272w9jeWfSQ9y5bGu9-fTWpXZVbbdDLGeR1sv0mJWPEcCMQws8EvY6hr15UAmXGqyVIf8C8ATT2qdEx6R7O7LegsunJEU', 0, NULL, 1, '26.9475098', '80.9389708', '3', 2, 12, 6, 'Platina', 'Bajaj', '2023', 4.5, 'cabuser@gmail.com', 0, 0),
(93, 9153.00, 1645.35, 2, 2, 2, 2, 2, 2, 2, 'Mini', '8303204543', 'DriverDocuments/1769225436217.jpg', 'manu', 'mishra', '1999-01-05', NULL, NULL, 'DriverDocuments/1769225687776.jpg', 'DriverDocuments/1769225688215.jpg', 'up32 20170013463', '2026-01-24', NULL, 'DriverDocuments/1769225754191.jpg', 'DriverDocuments/1769225754455.jpg', '25253696', 'DriverDocuments/1769225754596.jpg', 'DriverDocuments/1769225754608.jpg', 'PKPM4546P', NULL, 'DriverDocuments/1769225800240.jpg', 'DriverDocuments/1769225800645.jpg', 'DriverDocuments/1769225801289.jpg', NULL, NULL, 'DriverDocuments/1769225871800.jpg', 'Beige', 'UP32RD9606', NULL, 'DriverDocuments/1769225902941.jpg', 'DriverDocuments/1769225903251.jpg', 'DriverDocuments/1769225903313.jpg', 'DriverDocuments/1769225903378.jpg', '2026-01-24 03:30:36', '2026-02-03 06:58:21', 'fvgbhnj', 'cr1KyisyQM-BO1W6_aUaiD:APA91bGFaTGZ0DjIbhYAj_os66bpOXPV_bJKYe9thzfDTbCvFUDHaem_Zs6yVMbFuMdE7EbZbC64zJxpWsJ-PkZ15kWrAwww6pFvVzYD8ZJfb8UoE2tFZ3s', 1, NULL, 1, '26.9825015', '80.9314902', '2', 4, 5, 3, 'Dzire', 'Maruti Suzuki', '2017', 4.5, 'cabuser@gmail.com', 0, 0),
(94, 0.00, 0.00, 1, 0, 0, 0, 0, 0, 2, 'Bike', '7376154153', 'DriverDocuments/1769250525476.jpg', 'Anshika ', 'pathak', '2000-01-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-24 10:28:29', '2026-01-24 10:28:48', 'edfrgtyujy', 'dqefwtrhy', 0, NULL, 1, NULL, NULL, '3', 2, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(95, 0.00, 0.00, 1, 1, 1, 1, 1, 1, 2, 'Bike', '6306206322', 'DriverDocuments/1769251001382.jpg', 'vv', 'vv', '2000-01-01', NULL, NULL, 'DriverDocuments/1769251040136.jpg', 'DriverDocuments/1769251040534.jpg', 'ggghvcghhjjffggghhcgjljh', '2026-01-24', NULL, 'DriverDocuments/1769251091141.jpg', 'DriverDocuments/1769251091685.jpg', '889756845574', 'DriverDocuments/1769251092169.jpg', 'DriverDocuments/1769251092239.jpg', 'MCVNP65457', NULL, 'DriverDocuments/1769251115904.jpg', 'DriverDocuments/1769251116265.jpg', 'DriverDocuments/1769251116314.jpg', 'DriverDocuments/1769251116850.jpg', NULL, 'DriverDocuments/1769251168699.jpg', 'Blue', 'UP31RW4423', NULL, 'DriverDocuments/1769251185052.jpg', 'DriverDocuments/1769251185065.jpg', 'DriverDocuments/1769251185652.jpg', NULL, '2026-01-24 10:36:42', '2026-02-02 03:54:57', 'edfrgtyujy', 'dqefwtrhy', 0, NULL, 1, '26.9432645', '80.9403746', '3', 2, 12, 6, 'Platina', 'Bajaj', '2023', 4.5, 'cabuser@gmail.com', 0, 0),
(96, 824.00, 1323.98, 2, 2, 2, 2, 2, 2, 2, 'Mini', '8604396064', 'DriverDocuments/1769502101076.jpg', 'amar', 'soni', '1992-01-01', NULL, NULL, 'DriverDocuments/1769502200064.jpg', 'DriverDocuments/1769502200748.jpg', 'MH12AB123456', '2027-01-27', NULL, 'DriverDocuments/1769502261734.jpg', 'DriverDocuments/1769502262387.jpg', '235256328565', 'DriverDocuments/1769502262734.jpg', NULL, 'EFUP1291F', NULL, 'DriverDocuments/1769502319142.jpg', 'DriverDocuments/1769502319739.jpg', 'DriverDocuments/1769502320304.jpg', 'DriverDocuments/1769502320983.jpg', NULL, 'DriverDocuments/1769502380706.jpg', 'Blue', 'UP 01 AB 1234', NULL, 'DriverDocuments/1769502412641.jpg', 'DriverDocuments/1769502413323.jpg', 'DriverDocuments/1769502413922.jpg', 'DriverDocuments/1769502414599.jpg', '2026-01-27 08:21:41', '2026-01-27 16:14:47', 'edfrgtyujy', 'f6izpzsJTNC63mRGoSW6Kr:APA91bFpMWH_a2Q6s_zAFpeAHOeYfI_0MvW1fGXgswsKoYWwW0Mf1gJWQ41NPK14KIMMUDTBCzU3LAGe2UIr6KND0WCgqCFd23UPhNDxKuMmRy6PxAZdAeI', 1, NULL, 1, '27.9576193', '80.7850941', '2', 4, 5, 3, 'Dzire', 'Maruti Suzuki', '2020', 4.5, 'cabuser@gmail.com', 0, 0);

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
(22, 13, 'WAGNOR', 1, '2026-01-29 04:06:08');

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
(6, 4, 1, 'serviceman', 'serviceman', NULL, NULL, 0, '2026-01-31 05:38:46');

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
(180, '9651511938', '5093', 1, '2026-02-04 11:58:50', '2026-02-04 11:56:50');

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
(1, 1, 18, 269.00, '7% - ₹18.83', 269.00, 2, NULL, NULL, 1, 2, '2026-01-26 17:55:02', '2026-01-26 17:55:02'),
(2, 4, 18, 299.00, '6% - ₹17.94', 281.06, 1, '1', 'ORD1768655602616', 0, 2, '2026-01-17 18:43:22', '2026-01-17 18:43:22'),
(3, 4, 18, 299.00, '7% - ₹20.93', 299.00, 2, NULL, NULL, 1, 2, '2026-01-26 19:44:20', '2026-01-26 19:44:20'),
(4, 9, 20, 207.00, '6% - ₹12.42', 194.58, 1, '1', 'ORD1768659337361', 0, 2, '2026-01-17 19:45:37', '2026-01-17 19:45:37'),
(5, 9, 20, 207.00, '6% - ₹12.42', 194.58, 1, '1', 'ORD1768669594491', 0, 2, '2026-01-17 22:36:34', '2026-01-17 22:36:34'),
(6, 9, 20, 207.00, '6% - ₹12.42', 194.58, 1, '1', 'ORD1768669648342', 0, 2, '2026-01-17 22:37:28', '2026-01-17 22:37:28'),
(7, 9, 20, 207.00, '6% - ₹12.42', 194.58, 1, '1', 'ORD1768669724731', 0, 2, '2026-01-17 22:38:44', '2026-01-17 22:38:44'),
(8, 9, 20, 207.00, '7% - ₹14.49', 207.00, 2, NULL, NULL, 1, 2, '2026-01-17 22:40:51', '2026-01-17 22:40:51'),
(9, 20, 20, 304.00, '7% - ₹21.28', 304.00, 2, NULL, NULL, 1, 2, '2026-01-17 22:45:26', '2026-01-17 22:45:26'),
(10, 21, 20, 175.00, '7% - ₹12.25', 175.00, 2, NULL, NULL, 1, 2, '2026-01-17 22:51:50', '2026-01-17 22:51:50'),
(11, 22, 20, 429.00, '7% - ₹30.03', 429.00, 2, NULL, NULL, 1, 2, '2026-01-17 22:53:38', '2026-01-17 22:53:38'),
(12, 23, 20, 431.00, '7% - ₹30.17', 431.00, 2, NULL, NULL, 1, 2, '2026-01-17 22:56:39', '2026-01-17 22:56:39'),
(13, 24, 20, 264.00, '7% - ₹18.48', 264.00, 2, NULL, NULL, 1, 2, '2026-01-18 07:54:36', '2026-01-18 07:54:36'),
(14, 25, 20, 264.00, '7% - ₹18.48', 264.00, 2, NULL, NULL, 1, 2, '2026-01-18 07:57:54', '2026-01-18 07:57:54'),
(15, 26, 21, 207.00, '7% - ₹14.49', 207.00, 2, NULL, NULL, 1, 2, '2026-01-18 12:01:24', '2026-01-18 12:01:24'),
(16, 28, 21, 182.00, '7% - ₹12.74', 182.00, 2, NULL, NULL, 1, 2, '2026-01-18 12:03:09', '2026-01-18 12:03:09'),
(17, 24, 4, 200.00, '7.5% - ₹15.00', 185.00, 1, '1', 'ORD1768988541211', 0, 1, '2026-01-21 15:12:21', '2026-01-21 15:12:21'),
(18, 24, 4, 200.00, '7.5% - ₹15.00', 185.00, 1, '1', 'ORD1768988726859', 1, 1, '2026-01-21 15:15:26', '2026-01-21 09:46:04'),
(19, 42, 4, 185.00, '6% - ₹11.10', 173.90, 1, '1', 'ORD1769066110293', 1, 2, '2026-01-22 12:45:10', '2026-01-22 07:15:45'),
(20, NULL, 19, 100.00, '0% - ₹0.00', 100.00, 5, '1', 'ORD1769068342271', 0, 2, '2026-01-22 13:22:22', '2026-01-22 13:22:22'),
(21, NULL, 19, 100.00, '0% - ₹0.00', 100.00, 5, '1', 'ORD1769068370874', 0, 2, '2026-01-22 13:22:50', '2026-01-22 13:22:50'),
(22, NULL, 19, 100.00, '0% - ₹0.00', 100.00, 5, '1', 'ORD1769068512955', 0, 2, '2026-01-22 13:25:12', '2026-01-22 13:25:12'),
(23, NULL, 19, 100.00, '0% - ₹0.00', 100.00, 5, '1', 'ORD1769068595277', 0, 2, '2026-01-22 13:26:35', '2026-01-22 13:26:35'),
(24, NULL, 19, 100.00, '0% - ₹0.00', 100.00, 5, '1', 'ORD1769068733222', 0, 2, '2026-01-22 13:28:53', '2026-01-22 13:28:53'),
(25, NULL, 19, 100.00, '0% - ₹0.00', 100.00, 5, '1', 'ORD1769068795073', 0, 2, '2026-01-22 13:29:55', '2026-01-22 13:29:55'),
(26, NULL, 1, 100.00, '0% - ₹0.00', 100.00, 5, '1', 'ORD1769068853893', 0, 1, '2026-01-22 13:30:53', '2026-01-22 13:30:53'),
(27, NULL, 1, 100.00, '0% - ₹0.00', 100.00, 5, '1', 'ORD1769068927575', 0, 1, '2026-01-22 13:32:07', '2026-01-22 13:32:07'),
(28, NULL, 1, 100.00, '0% - ₹0.00', 100.00, 5, '1', 'ORD1769068966319', 0, 1, '2026-01-22 13:32:46', '2026-01-22 13:32:46'),
(29, NULL, 19, 100.00, '0% - ₹0.00', 100.00, 5, '1', 'ORD1769069104975', 0, 2, '2026-01-22 13:35:04', '2026-01-22 13:35:04'),
(30, NULL, 19, 50.00, '0% - ₹0.00', 50.00, 5, '1', 'ORD1769069578332', 0, 2, '2026-01-22 13:42:58', '2026-01-22 13:42:58'),
(31, NULL, 19, 50.00, '0% - ₹0.00', 50.00, 5, '1', 'ORD1769069586676', 0, 2, '2026-01-22 13:43:06', '2026-01-22 13:43:06'),
(32, NULL, 19, 100.00, '0% - ₹0.00', 100.00, 5, '1', 'ORD1769069592792', 0, 2, '2026-01-22 13:43:12', '2026-01-22 13:43:12'),
(33, NULL, 19, 100.00, '0% - ₹0.00', 100.00, 5, '1', 'ORD1769069894459', 1, 2, '2026-01-22 13:48:14', '2026-01-22 08:18:58'),
(34, NULL, 19, 150.00, '0% - ₹0.00', 150.00, 5, '1', 'ORD1769070474147', 1, 2, '2026-01-22 13:57:54', '2026-01-22 08:28:32'),
(35, 46, 4, 148.00, '6% - ₹8.88', 139.12, 1, '1', 'ORD1769074690323', 1, 2, '2026-01-22 15:08:10', '2026-01-22 09:38:44'),
(36, 66, 25, 81.00, '6% - ₹4.86', 76.14, 1, '1', 'ORD1769144828291', 1, 2, '2026-01-23 10:37:08', '2026-01-23 05:07:44'),
(37, 27, 25, 200.00, '7.5% - ₹15.00', 185.00, 1, '1', 'ORD1769146990632', 1, 1, '2026-01-23 11:13:10', '2026-01-23 05:43:35'),
(38, 73, 17, 4251.00, '6% - ₹255.06', 3995.94, 1, '1', 'ORD1769157749336', 1, 2, '2026-01-23 14:12:29', '2026-01-23 08:43:07'),
(39, 29, 1, 944.00, '7.5% - ₹70.80', 873.20, 2, NULL, NULL, 1, 1, '2026-01-23 14:58:54', '2026-01-23 14:58:54'),
(40, 89, 17, 1975.00, '7.5% - ₹148.13', 1975.00, 2, NULL, NULL, 1, 2, '2026-01-23 17:18:37', '2026-01-23 17:18:37'),
(41, NULL, 1, 400.54, '0% - ₹0.00', 400.54, 5, '1', 'ORD1769196725944', 0, 1, '2026-01-24 01:02:05', '2026-01-24 01:02:05'),
(42, NULL, 1, 400.54, '0% - ₹0.00', 400.54, 5, '1', 'ORD1769196811218', 0, 1, '2026-01-24 01:03:31', '2026-01-24 01:03:31'),
(43, NULL, 1, 400.00, '0% - ₹0.00', 400.00, 5, '1', 'ORD1769196883138', 1, 1, '2026-01-24 01:04:43', '2026-01-23 19:35:28'),
(44, 94, 17, 3287.00, '6% - ₹197.22', 3089.78, 1, '1', 'ORD1769226527901', 0, 2, '2026-01-24 09:18:47', '2026-01-24 09:18:47'),
(45, 94, 17, 3287.00, '6% - ₹197.22', 3089.78, 1, '1', 'ORD1769226557039', 0, 2, '2026-01-24 09:19:17', '2026-01-24 09:19:17'),
(46, 94, 17, 3287.00, '6% - ₹197.22', 3089.78, 1, '1', 'ORD1769226637219', 0, 2, '2026-01-24 09:20:37', '2026-01-24 09:20:37'),
(47, 94, 17, 3287.00, '6% - ₹197.22', 3089.78, 1, '1', 'ORD1769233077459', 0, 2, '2026-01-24 11:07:57', '2026-01-24 11:07:57'),
(48, 94, 17, 3287.00, '6% - ₹197.22', 3089.78, 1, '1', 'ORD1769233116317', 0, 2, '2026-01-24 11:08:36', '2026-01-24 11:08:36'),
(49, 98, 17, 2460.00, '7.5% - ₹184.50', 2460.00, 2, NULL, NULL, 1, 2, '2026-01-24 11:13:02', '2026-01-24 11:13:02'),
(50, 100, 17, 2434.00, '7.5% - ₹182.55', 2434.00, 2, NULL, NULL, 1, 2, '2026-01-24 11:34:11', '2026-01-24 11:34:11'),
(51, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769235447924', 0, 2, '2026-01-24 11:47:27', '2026-01-24 11:47:27'),
(52, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769235450370', 0, 2, '2026-01-24 11:47:30', '2026-01-24 11:47:30'),
(53, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769235452842', 0, 2, '2026-01-24 11:47:32', '2026-01-24 11:47:32'),
(54, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769235467614', 0, 2, '2026-01-24 11:47:47', '2026-01-24 11:47:47'),
(55, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769235473140', 0, 2, '2026-01-24 11:47:53', '2026-01-24 11:47:53'),
(56, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769235476213', 0, 2, '2026-01-24 11:47:56', '2026-01-24 11:47:56'),
(57, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769235476909', 0, 2, '2026-01-24 11:47:56', '2026-01-24 11:47:56'),
(58, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769235477546', 0, 2, '2026-01-24 11:47:57', '2026-01-24 11:47:57'),
(59, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769235499716', 0, 2, '2026-01-24 11:48:19', '2026-01-24 11:48:19'),
(60, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769235504788', 0, 2, '2026-01-24 11:48:24', '2026-01-24 11:48:24'),
(61, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769235509413', 0, 2, '2026-01-24 11:48:29', '2026-01-24 11:48:29'),
(62, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769235514406', 0, 2, '2026-01-24 11:48:34', '2026-01-24 11:48:34'),
(63, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769235533618', 0, 2, '2026-01-24 11:48:53', '2026-01-24 11:48:53'),
(64, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769235583739', 0, 2, '2026-01-24 11:49:43', '2026-01-24 11:49:43'),
(65, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769235585231', 0, 2, '2026-01-24 11:49:45', '2026-01-24 11:49:45'),
(66, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769235586432', 0, 2, '2026-01-24 11:49:46', '2026-01-24 11:49:46'),
(67, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769235589008', 0, 2, '2026-01-24 11:49:49', '2026-01-24 11:49:49'),
(68, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769235589356', 0, 2, '2026-01-24 11:49:49', '2026-01-24 11:49:49'),
(69, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769235589914', 0, 2, '2026-01-24 11:49:49', '2026-01-24 11:49:49'),
(70, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769235590380', 0, 2, '2026-01-24 11:49:50', '2026-01-24 11:49:50'),
(71, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769235590938', 0, 2, '2026-01-24 11:49:50', '2026-01-24 11:49:50'),
(72, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769235591400', 0, 2, '2026-01-24 11:49:51', '2026-01-24 11:49:51'),
(73, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769235680459', 0, 2, '2026-01-24 11:51:20', '2026-01-24 11:51:20'),
(74, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769235685363', 0, 2, '2026-01-24 11:51:25', '2026-01-24 11:51:25'),
(75, NULL, 1, 500.00, '0% - ₹0.00', 500.00, 5, '1', 'ORD1769238772447', 1, 1, '2026-01-24 12:42:52', '2026-01-24 07:13:39'),
(76, 36, 28, 588.82, '7.5% - ₹44.16', 544.66, 2, NULL, NULL, 1, 1, '2026-01-24 15:12:25', '2026-01-24 15:12:25'),
(77, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769257405904', 0, 2, '2026-01-24 17:53:25', '2026-01-24 17:53:25'),
(78, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769257409058', 0, 2, '2026-01-24 17:53:29', '2026-01-24 17:53:29'),
(79, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769257410035', 0, 2, '2026-01-24 17:53:30', '2026-01-24 17:53:30'),
(80, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769257410798', 0, 2, '2026-01-24 17:53:30', '2026-01-24 17:53:30'),
(81, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769257411340', 0, 2, '2026-01-24 17:53:31', '2026-01-24 17:53:31'),
(82, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769257412967', 0, 2, '2026-01-24 17:53:32', '2026-01-24 17:53:32'),
(83, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769257416036', 0, 2, '2026-01-24 17:53:36', '2026-01-24 17:53:36'),
(84, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769257423138', 0, 2, '2026-01-24 17:53:43', '2026-01-24 17:53:43'),
(85, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769257442074', 0, 2, '2026-01-24 17:54:02', '2026-01-26 17:54:02'),
(86, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769257443301', 0, 2, '2026-01-24 17:54:03', '2026-01-24 17:54:03'),
(87, 125, 34, 252.00, '7.5% - ₹18.90', 252.00, 2, NULL, NULL, 1, 2, '2026-01-26 18:32:54', '2026-01-25 18:32:54'),
(88, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769445455148', 0, 2, '2026-01-26 22:07:35', '2026-01-26 22:07:35'),
(89, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769445456862', 0, 2, '2026-01-26 22:07:36', '2026-01-26 22:07:36'),
(90, 162, 18, 571.00, '7.5% - ₹42.83', 571.00, 2, NULL, NULL, 1, 2, '2026-01-26 22:10:49', '2026-01-26 22:10:49'),
(91, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769445716372', 0, 2, '2026-01-26 22:11:56', '2026-01-26 22:11:56'),
(92, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769445746714', 0, 2, '2026-01-26 22:12:26', '2026-01-26 22:12:26'),
(93, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769445778048', 0, 2, '2026-01-26 22:12:58', '2026-01-26 22:12:58'),
(94, 164, 18, 1752.00, '7.5% - ₹131.40', 1752.00, 2, NULL, NULL, 1, 2, '2026-01-26 22:17:29', '2026-01-26 22:17:29'),
(95, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769446274623', 0, 2, '2026-01-26 22:21:14', '2026-01-26 22:21:14'),
(96, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769446277067', 0, 2, '2026-01-26 22:21:17', '2026-01-26 22:21:17'),
(97, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769446278390', 0, 2, '2026-01-26 22:21:18', '2026-01-26 22:21:18'),
(98, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769490172215', 0, 2, '2026-01-27 10:32:52', '2026-01-27 10:32:52'),
(99, NULL, 93, 367.05, '0% - ₹0.00', 367.05, 5, '1', 'ORD1769490180989', 0, 2, '2026-01-27 10:33:00', '2026-01-27 10:33:00'),
(100, 172, 17, 5580.00, '7.5% - ₹418.50', 5580.00, 2, NULL, NULL, 1, 2, '2026-01-27 11:12:47', '2026-01-27 11:12:47'),
(101, 173, 17, 1627.00, '6% - ₹97.62', 1529.38, 1, '1', 'ORD1769492739952', 0, 2, '2026-01-27 11:15:39', '2026-01-27 11:15:39'),
(102, 173, 17, 1627.00, '7.5% - ₹122.03', 1627.00, 2, NULL, NULL, 1, 2, '2026-01-27 11:16:24', '2026-01-27 11:16:24'),
(103, NULL, 38, 70.00, '0% - ₹0.00', 70.00, 5, '1', 'ORD1769500133986', 0, 1, '2026-01-27 13:18:53', '2026-01-27 13:18:53'),
(104, NULL, 38, 70.00, '0% - ₹0.00', 70.00, 5, '1', 'ORD1769500140378', 0, 1, '2026-01-27 13:19:00', '2026-01-27 13:19:00'),
(105, 174, 17, 6358.00, '7.5% - ₹476.85', 6358.00, 2, NULL, NULL, 1, 2, '2026-01-27 13:34:25', '2026-01-27 13:34:25'),
(106, 176, 15, 824.00, '6% - ₹49.44', 774.56, 1, '1', 'ORD1769517369895', 1, 2, '2026-01-27 18:06:09', '2026-01-27 12:36:40'),
(107, 179, 17, 4730.00, '7.5% - ₹354.75', 4730.00, 2, NULL, NULL, 1, 2, '2026-01-27 18:11:46', '2026-01-27 18:11:46'),
(108, 181, 17, 5555.00, '7.5% - ₹416.63', 5555.00, 2, NULL, NULL, 1, 2, '2026-01-27 18:20:25', '2026-01-27 18:20:25'),
(109, 183, 17, 6226.00, '7.5% - ₹466.95', 6226.00, 2, NULL, NULL, 1, 2, '2026-01-27 18:30:15', '2026-01-27 18:30:15'),
(110, NULL, 96, 1238.33, '0% - ₹0.00', 1238.33, 5, '1', 'ORD1769518871273', 0, 2, '2026-01-27 18:31:11', '2026-01-27 18:31:11'),
(111, 184, 17, 1142.00, '7.5% - ₹85.65', 1142.00, 2, NULL, NULL, 1, 2, '2026-01-27 18:35:40', '2026-01-27 18:35:40'),
(112, NULL, 93, 1384.42, '0% - ₹0.00', 1384.42, 5, '1', 'ORD1769519327884', 0, 2, '2026-01-27 18:38:47', '2026-01-27 18:38:47'),
(113, NULL, 93, 1384.42, '0% - ₹0.00', 1384.42, 5, '1', 'ORD1769519329481', 0, 2, '2026-01-27 18:38:49', '2026-01-27 18:38:49'),
(114, NULL, 93, 1384.42, '0% - ₹0.00', 1384.42, 5, '1', 'ORD1769520313462', 0, 2, '2026-01-27 18:55:13', '2026-01-27 18:55:13'),
(115, NULL, 93, 1384.42, '0% - ₹0.00', 1384.42, 5, '1', 'ORD1769520318009', 0, 2, '2026-01-27 18:55:18', '2026-01-27 18:55:18'),
(116, 188, 17, 1301.00, '6% - ₹78.06', 1222.94, 1, '1', 'ORD1769534192627', 0, 2, '2026-01-27 22:46:32', '2026-01-27 22:46:32'),
(117, 188, 17, 1301.00, '6% - ₹78.06', 1222.94, 1, '1', 'ORD1769534248122', 0, 2, '2026-01-27 22:47:28', '2026-01-27 22:47:28'),
(118, 188, 17, 1301.00, '7.5% - ₹97.58', 1301.00, 2, NULL, NULL, 1, 2, '2026-01-27 22:48:20', '2026-01-27 22:48:20'),
(119, 199, 18, 945.00, '7.5% - ₹70.88', 945.00, 2, NULL, NULL, 1, 2, '2026-01-28 08:25:06', '2026-01-28 08:25:06'),
(120, 207, 18, 368.00, '7.5% - ₹27.60', 368.00, 2, NULL, NULL, 1, 2, '2026-01-28 09:20:23', '2026-01-28 09:20:23'),
(121, NULL, 3, 25.00, '0% - ₹0.00', 25.00, 4, '1', 'ORD1769662601535', 1, 1, '2026-01-29 10:26:41', '2026-01-29 04:57:20'),
(122, 226, 17, 870.00, '6% - ₹52.20', 817.80, 1, '1', 'ORD1769663682161', 1, 2, '2026-01-29 10:44:42', '2026-01-29 05:17:54'),
(123, 227, 17, 1346.00, '6% - ₹80.76', 1265.24, 1, '1', 'ORD1769664491931', 1, 2, '2026-01-29 10:58:11', '2026-01-29 05:28:41'),
(124, 230, 17, 643.00, '7.5% - ₹48.23', 643.00, 2, NULL, NULL, 1, 2, '2026-01-29 13:22:07', '2026-01-29 13:22:07'),
(125, 264, 17, 2178.00, '7.5% - ₹163.35', 2178.00, 2, NULL, NULL, 1, 2, '2026-01-31 10:04:55', '2026-01-31 10:04:55'),
(126, 272, 17, 5708.00, '6% - ₹342.48', 5365.52, 1, '1', 'ORD1769921718823', 1, 2, '2026-02-01 10:25:18', '2026-02-01 04:55:58'),
(127, 276, 4, 293.00, '6% - ₹17.58', 275.42, 1, '1', 'ORD1770093345151', 1, 2, '2026-02-03 10:05:45', '2026-02-03 04:36:25'),
(128, 278, 4, 293.00, '6% - ₹17.58', 275.42, 1, '1', 'ORD1770093892540', 0, 2, '2026-02-03 10:14:52', '2026-02-03 10:14:52'),
(129, 278, 4, 293.00, '6% - ₹17.58', 275.42, 1, '1', 'ORD1770093930566', 1, 2, '2026-02-03 10:15:30', '2026-02-03 04:46:09'),
(130, 279, 17, 1229.00, '6% - ₹73.74', 1155.26, 1, '1', 'ORD1770101942697', 1, 2, '2026-02-03 12:29:02', '2026-02-03 06:59:42');

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
(23, 17, 1, 'Lucknow Outer Ring Road, Hardhaurpur, Uttar Pradesh, 226202', '12', '2', 'shiv mandir', '2026-01-29 09:17:03', '27.003684151091246', '80.8725818619132');

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
(95, '2026-02-04 15:15:37', 1, 305, '2026-02-04 09:44:07', 1);

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
(1, '[1, 2, 3, 5]', 19294.35, 9876543211, 44.16, 'ramu', 'sharmaa', NULL, 1, 1, 'd_slLKHfSvOZtazkxXzFW7:APA91bE5D5-jV6EP8xnwCa-xjkoOhQD0Bx36Kfe48P4h29C-6aWENEWrsLkLTY5-ftYAG0ucEC2o_mj5ESvT9VYXXkHvBwoBMpg7Y0J_tiB4arPiBqMkM5g', 'ramu@gmail.com', 'lucknow', 'ServicemanFiles/1765258792177.jpeg', 'ServicemanFiles/1765258792254.jpeg', 1, NULL, 'fvgbhnj', 1, '2025-12-09 05:39:52', '2026-01-31 07:12:05', '26.9435262', '80.9405561', 'ServicemanFiles/1765451127949.jpg', NULL, NULL),
(2, '1', 300.00, 8423953287, 50.00, 'ramu', 'sharma', 'AsdZFCGNK', 1, 0, 'abc_fcm', 'ramus@gmail.com', 'lucknow', 'ServicemanFiles/1765258880379.jpeg', 'ServicemanFiles/1765258880475.jpeg', 1, NULL, 'asdfcghjkl', 0, '2025-12-09 05:41:20', '2025-12-09 05:41:20', NULL, NULL, NULL, NULL, NULL),
(3, '1', 0.00, 8423953286, 0.00, 'ramu', 'sharma', NULL, 1, 1, 'djpDzDO7SSG275VZRsQF7e:APA91bG32HParRI3JvZt-E7lbyUIAOMqQKRquQmjnnIwS5_qx21irT6MDH9KQjFsghacdMgRTwDsiA5uNn75-tOUCWASn38Bm3oBAkt3ouRy7tk9m56LC_s', 'ramus@gmail.com', 'lucknow', 'ServicemanFiles/1765259068213.jpeg', 'ServicemanFiles/1765259068301.jpeg', 1, NULL, 'fvgbhnj', 1, '2025-12-09 05:44:28', '2026-02-03 04:30:15', '26.9435684', '80.9405658', NULL, NULL, NULL),
(4, '2', 1132.80, 8888888888, 56.64, 'ramu', 'sharma', NULL, 1, 1, 'd1uVSDquQKCh6RhAb66BlV:APA91bEn0inBi4IFGG15w2-6-ZGgdcALmuzPJ49oDcgLJNFADMjsmBayJa5pRsQtDlVpzIjIcCP_hi3V57BuQ9S2NqMNxxqiJXp6GtvMyMYA8agkmt2FiWY', 'ramus@gmail.com', 'lucknow', 'ServicemanFiles/1765259072891.jpeg', 'ServicemanFiles/1765259072991.jpeg', 1, NULL, 'fvgbhnj', 1, '2025-12-09 05:44:32', '2025-12-24 11:39:03', '26.9435', '80.9404747', NULL, NULL, NULL),
(5, '1', 0.00, 8423953210, 0.00, 'ramu', 'sharma', NULL, 0, 0, 'abc_fcm', 'ramus@gmail.com', 'lucknow', 'ServicemanFiles/1765259075800.jpeg', 'ServicemanFiles/1765259075897.jpeg', 1, NULL, 'asdfcghjkl', 0, '2025-12-09 05:44:35', '2025-12-12 06:05:43', NULL, NULL, NULL, NULL, NULL),
(20, '1', 0.00, 9565545464, 0.00, 'Tanisha ', 'sharma ', NULL, 0, 0, 'fcm_123', 'vhvy@gmail.com', 'Lucknow Uttar Pradesh India ', 'ServicemanFiles/1765533195480.jpg', 'ServicemanFiles/1765533195683.jpg', 1, NULL, 'device_123', 0, '2025-12-12 15:23:16', '2025-12-12 15:23:16', '26.90', '80.94', 'ServicemanFiles/1765533195791.heic', 'Female', NULL),
(21, '1', 0.00, 9646486446, 0.00, 'Ramu', 'jiii', NULL, 1, 0, 'fcm_123', 'ratgggmu@gmail.com', 'Lucknow to nh ', 'ServicemanFiles/1765533707453.jpg', 'ServicemanFiles/1765533707649.heic', 1, NULL, 'device_123', 0, '2025-12-12 15:31:48', '2025-12-12 15:31:48', '26.90', '80.94', 'ServicemanFiles/1765533708351.jpg', 'Female', NULL),
(22, '1', 0.00, 9856565656, 0.00, 'pjsh', 'dhhdus', NULL, 1, 0, 'fcm_123', 'xndh@gmail.com', 'luckn ', 'ServicemanFiles/1765533998633.jpg', 'ServicemanFiles/1765533998828.jpg', 1, NULL, 'device_123', 0, '2025-12-12 15:36:38', '2025-12-12 15:36:38', '26.90', '80.94', 'ServicemanFiles/1765533998929.jpg', 'Female', NULL),
(23, '2', 0.00, 9598199932, 0.00, 'Abhishek ', 'sharma ', NULL, 1, 0, 'dgxbz8bnQJyaUHLFpo3fKE:APA91bEuunKDnYEAJsScxce-qCfct33StIBetF-uY3Las9T-dWOc-6WhNw5aKxMs824WNgMyNjhz9w7k_SkH96iParkWCmPqt2rV_2MV0BqhV8hvtE_wCZE', 'niranjan7sharma@gmail.com', 'Vistar Yojna, Jankipuram, Lucknow, Uttar Pradesh, 226031', 'ServicemanFiles/1765859372599.jpg', 'ServicemanFiles/1765859376686.jpg', 1, NULL, 'RKQ1.201004.002', 0, '2025-12-16 09:59:51', '2025-12-16 04:35:39', '26.9125', '75.7875', 'ServicemanFiles/1765859383442.jpg', 'Male', NULL),
(25, '[1, 2, 3, 5]', 0.00, 7235947667, 0.00, 'Tanisha ', 'Sharma', NULL, 1, 0, 'e7pFnQnoRL-8syy9tPXfRz:APA91bGcjR2FZ9R9zAHWwrPszfJqESQfCuFGaJ3_NddDaoh334ixzurBaD2TSXlCUuoIWr_8uCTdmWZaE1b4ar1cpjI1ZQWOvhbu5qD5iJhZTHArvp9OjKw', 'tanu@gmail.com', '1/613, Jankipuram Extension, Mirzapur, Uttar Pradesh, 226031', 'ServicemanFiles/1766075786961.jpg', 'ServicemanFiles/1766075787255.jpg', 1, NULL, 'fvgbhnj', 1, '2025-12-18 22:06:28', '2026-01-21 04:07:00', '26.9435472', '80.9405682', 'ServicemanFiles/1766075787685.jpg', 'Female', NULL),
(26, '2', 0.00, 9695782867, 0.00, 'Akansha ', 'Singh ', NULL, 1, 0, 'egYNYbdsSsyVTXaY1i8OBZ:APA91bEMk2mLEHw1FtygOMK9le0HBjQuO-EHEloSWWPBHfQnLh-kddu3cYH7cAAwdvbv8YD5ohGT6dWp1I9ZuuVnA6qPPVwlpIIrh3PaLsnoUvqZUo47tIM', 'akansha@gmail.com', 'Vistar Yojna, Jankipuram, Lucknow, Uttar Pradesh, 226031', 'ServicemanFiles/1766488379151.jpg', 'ServicemanFiles/1766488380476.jpg', 1, NULL, 'RP1A.200720.011', 0, '2025-12-23 16:43:01', '2025-12-23 16:43:01', '26.9435622', '80.940582', 'ServicemanFiles/1766488380832.jpg', 'Male', NULL),
(27, '2', 0.00, 8741257875, 0.00, 'Kritika ', 'Sharma', NULL, 0, 0, 'fJrITCx4SY2IEFBJdsRcCE:APA91bHGOOAjrJWoZA4Qc6D28o39eFzVZbvdhXmdsIeXgHwJODTrF1P0KMAnRcgibQVkoLywNebibfZ32HLWUE5lTU4cn6CqHpevx4Cf_D0ctsOPM-gxXxM', 'kriti@gmail.com', 'Vistar Yojna, Jankipuram, Lucknow, Uttar Pradesh, 226031', 'ServicemanFiles/1766488819052.jpg', 'ServicemanFiles/1766488819576.jpg', 1, NULL, 'RP1A.200720.011', 1, '2025-12-23 16:50:20', '2025-12-23 16:50:20', '26.943577', '80.9405525', 'ServicemanFiles/1766488819932.jpg', 'Male', NULL),
(28, '2', 0.00, 9662565956, 0.00, 'helo', 'hol', NULL, 1, 0, 'ca4wpfOJSJiWKO6p5IkVXV:APA91bFX3NbxguhSO6ie5wcPwqlCEmnhXk8nqc78JH-XaOGt2p7GJjqJVvzDGbu-KQbxmvkQ8kEr5H4FCHX_-8PRLFiMqMeWL5_eJul_z6d-NWTr4o9flvg', 'helo@gmail.com', 'Vistar Yojna, Jankipuram, Lucknow, Uttar Pradesh, 226031', 'ServicemanFiles/1766489792038.jpg', 'ServicemanFiles/1766489792663.jpg', 1, NULL, 'RP1A.200720.011', 1, '2025-12-23 17:06:33', '2025-12-23 11:36:36', '26.9435686', '80.9405798', 'ServicemanFiles/1766489793091.jpg', 'Male', NULL),
(29, '[1, 2, 3]', 0.00, 8454512252, 0.00, 'girsl', 'hukil', NULL, 0, 0, 'ca4wpfOJSJiWKO6p5IkVXV:APA91bFX3NbxguhSO6ie5wcPwqlCEmnhXk8nqc78JH-XaOGt2p7GJjqJVvzDGbu-KQbxmvkQ8kEr5H4FCHX_-8PRLFiMqMeWL5_eJul_z6d-NWTr4o9flvg', 'girl@gmail.com', 'Vistar Yojna, Jankipuram, Lucknow, Uttar Pradesh, 226031', 'ServicemanFiles/1766490041661.jpg', 'ServicemanFiles/1766490042386.jpg', 1, NULL, 'RP1A.200720.011', 1, '2025-12-23 17:10:43', '2025-12-23 17:10:43', '26.9435692', '80.9405641', 'ServicemanFiles/1766490042787.jpg', 'Male', NULL),
(30, '1', 0.00, 9632655421, 0.00, 'Kunal', 'Singh ', NULL, 0, 0, 'ca4wpfOJSJiWKO6p5IkVXV:APA91bFX3NbxguhSO6ie5wcPwqlCEmnhXk8nqc78JH-XaOGt2p7GJjqJVvzDGbu-KQbxmvkQ8kEr5H4FCHX_-8PRLFiMqMeWL5_eJul_z6d-NWTr4o9flvg', 'kunal@gmail.com', 'Vistar Yojna, Jankipuram, Lucknow, Uttar Pradesh, 226031', 'ServicemanFiles/1766490405119.jpg', 'ServicemanFiles/1766490405596.jpg', 1, NULL, 'RP1A.200720.011', 1, '2025-12-23 17:16:46', '2025-12-23 11:53:22', '26.9435688', '80.9405803', 'ServicemanFiles/1766490406123.jpg', 'Male', NULL),
(33, '[1, 2, 3, 5]', 0.00, 8423953287, 0.00, 'ramu', 'sharma', NULL, 1, 1, 'cQJ98J_1TpiJ_xfVChrZdr:APA91bGom16A4werXjhrhzZgcPwqpdel-GMBMsPtVR0jR_tJ--2vjVdGyAcSji2-f8B8dJ3EVtX4pohWGEGqvwtcyJE7L49HNBTEwX0YQu72csT53pYTlH0', '', 'lucknow', 'ServicemanFiles/1768969264946.png', 'ServicemanFiles/1768969265144.png', 1, NULL, 'fvgbhnj', 1, '2026-01-21 09:51:05', '2026-01-23 10:51:14', '26.9434983', '80.9405493', 'ServicemanFiles/1768969265265.png', 'male', NULL),
(35, '[12, 13]', 0.00, 9884544689, 0.00, 'dhdhd', 'bx xxv', NULL, 1, 0, 'e7pFnQnoRL-8syy9tPXfRz:APA91bGcjR2FZ9R9zAHWwrPszfJqESQfCuFGaJ3_NddDaoh334ixzurBaD2TSXlCUuoIWr_8uCTdmWZaE1b4ar1cpjI1ZQWOvhbu5qD5iJhZTHArvp9OjKw', '', 'jankipuram sector H Lucknow', 'ServicemanFiles/1768973023493.jpg', 'ServicemanFiles/1768973023678.jpg', 1, NULL, 'RKQ1.201004.002', 1, '2026-01-21 10:53:43', '2026-01-21 05:25:12', '26.9434883', '80.9405377', 'ServicemanFiles/1768973023722.jpg', 'Male', NULL),
(36, '[1, 2, 3, 5]', 185.00, 9808559632, 0.00, 'kunal ', 'verma', NULL, 1, 0, 'eTSDd_5PQjyvC6h0NgfF5s:APA91bFb6hHRC2Arm48CqYpjbu2cQWCTfZL6OmzMi30nopt4eKrVpOh9nB7JlVabtUZHRt9EPpuzhvy5kn4XNQ9omq1_MmeFT_UgzgQKKjxk5TGbZGTE_8s', '', 'Vistar Yojna, Jankipuram, Lucknow, Uttar Pradesh, 226031', 'ServicemanFiles/1768974472766.jpg', 'ServicemanFiles/1768974473052.jpg', 1, NULL, 'fvgbhnj', 1, '2026-01-21 11:17:53', '2026-01-21 11:00:47', '26.9125', '75.7875', 'ServicemanFiles/1768974473152.jpg', 'Male', '2'),
(37, '[1, 2, 8]', 0.50, 9140183315, 0.00, 'viveak ', 'oberai', NULL, 1, 0, 'dgwbzbyqSOO5xG_LCOIAbE:APA91bFSeTNMyuJJV071NRBXuk_6r42k-U6W6ZVczw0tp9clXu0Yms2Mau9R_v56qNWSTwzMDdOZIJaN8FxlIPVQiz5RLDssuPJMDZeBknKP_o3c93H737E', 'ramu@foundercodes.com', 'Vistar Yojna, Jankipuram, Lucknow, Uttar Pradesh, 226031', 'ServicemanFiles/1769145890272.jpg', 'ServicemanFiles/1769145890971.jpg', 1, NULL, 'RKQ1.201004.002', 1, '2026-01-23 10:54:51', '2026-01-23 05:50:58', '26.9435083', '80.9405428', 'ServicemanFiles/1769145891082.jpg', 'Male', '10'),
(38, '[3, 12, 2]', 0.00, 9559960255, 70.80, 'AMAN', 'mishra', NULL, 1, 0, 'fxXaJpzvQ52z8Vc9dW911s:APA91bG5RQmNHDKpX9eQc7x6vf8lBtlqZaNMmxarKLbL9c5yHPXYkz__BlpBFzWGCRNrrVEesBfRUsPJckdURWXxZ-Ij5F4F9XoyeIo_dSzzsy-9N0_rCfY', '', 'Vistar Yojna, Jankipuram, Lucknow, Uttar Pradesh, 226031', 'ServicemanFiles/1769158909310.jpg', 'ServicemanFiles/1769158909447.jpg', 1, NULL, 'fvgbhnj', 1, '2026-01-23 14:31:49', '2026-01-28 06:40:45', '26.9386239', '80.9441004', 'ServicemanFiles/1769158909559.jpg', 'Male', '10');

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
(4, 24, 3, 5, 4, '2025-12-18 16:44:09', 'AC Cooling Service', 'pankaj ji');

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
  `top_servises_status` tinyint(4) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `category_id`, `subcategory_id`, `title`, `description`, `image`, `price`, `rating`, `faqs`, `status`, `created_at`, `top_servises_status`) VALUES
(1, 2, 4, 'AC Cooling Service', 'Complete AC servicing including cleaning, gas check and cooling optimization.', 'serviceImage/ac.jpg', 499.00, 4.7, '[\n  {\n    \"id\": 1,\n    \"question\": \"Is servicing required every year?\",\n    \"answer\": \"Yes, yearly service improves cooling and increases AC life.\"\n  },\n  {\n    \"id\": 2,\n    \"question\": \"How much time does it take?\",\n    \"answer\": \"Usually 45 minutes to 1 hour.\"\n  }\n]\n', 1, '2025-12-06 09:19:24', 1),
(4, 5, 10, 'Furniture Repair', 'Repair of broken furniture, hinges, doors, and wooden fittings.', 'serviceImage/fur.jpg', 349.00, 4.7, '[\n  {\n    \"id\": 1,\n    \"question\": \"Is servicing required every year?\",\n    \"answer\": \"Yes, yearly service improves cooling and increases AC life.\"\n  },\n  {\n    \"id\": 2,\n    \"question\": \"How much time does it take?\",\n    \"answer\": \"Usually 45 minutes to 1 hour.\"\n  }\n]\n', 1, '2025-12-06 09:19:24', 1),
(5, 2, 4, 'AC Deep Cleaning', 'Full AC deep cleaning with antibacterial treatment.', 'serviceImage/deep2.jpg', 599.00, 4.8, '[\n  {\n    \"id\": 1,\n    \"question\": \"Is servicing required every year?\",\n    \"answer\": \"Yes, yearly service improves cooling and increases AC life.\"\n  },\n  {\n    \"id\": 2,\n    \"question\": \"How much time does it take?\",\n    \"answer\": \"Usually 45 minutes to 1 hour.\"\n  }\n]\n', 1, '2025-12-06 09:54:39', 0),
(6, 2, 4, 'AC Gas Refillings', 'Premium AC gas refill with leak check.', 'serviceImage/acgas.jpg', 1100.00, 4.6, '[{\"id\":1,\"question\":\"How much time does it take?\",\"answer\":\"answer How much time does it take?\"}]', 1, '2025-12-06 09:54:39', 0),
(7, 17, 48, 'Home sweet home, where dreams are designed.', 'Home decoration text includes short, inspiring phrases for social media (\"Cozy is my love language,\" \"My happy place, one pillow at a time\"), descriptive captions for different rooms (\"Creating calm in the hustle of deadlines\" for offices, \"Serenity soaks and style sparks\" for bathrooms), and longer quotes about design principles (\"Design is thinking made visual,\" \"A house is made of walls and beams; a home is built with love and dreams\"). These texts aim to evoke feelings of comfort, style', 'serviceImage/1768649693771.jpg', 700.00, 0, '[{\"id\":1,\"question\":\"Home sweet home, where dreams are designed.\",\"answer\":\"Home sweet home, where dreams are designed.\"},{\"id\":2,\"question\":\"Home sweet home, where dreams are designed.\",\"answer\":\"Home sweet home, where dreams are designed.\"}]', 1, '2026-01-17 11:34:53', 1),
(8, 1, 2, 'Plant care man', 'Plant care man works  only 4 hours ll needs ', 'serviceImage/1768983951013.jpg', 200.00, 0, '[{\"id\":1,\"question\":\"Plant care man works  only 4 hours ll needs\",\"answer\":\"Plant care man works  only 4 hours ll needs\"}]', 1, '2026-01-21 08:25:51', 1),
(9, 3, 9, 'A all home Switch Repair', 'Electrical wiring refers to the installation of cabling and associated devices such as switches, distribution panels, outlets, and light fittings within a structure. It is essential to every electrical system, ensuring safe and reliable distribution of power across circuits.', 'serviceImage/1769159760357.jpg', 800.00, 0, '[{\"id\":1,\"question\":\"Electrical wiring refers to the installation\",\"answer\":\"Electrical wiring refers to the installation\"}]', 1, '2026-01-23 09:16:00', 1),
(10, 12, 49, 'plumbing leakage repari service', 'All types of plumbing work including pipe fitting leakage repair tap installation bathroom &kitchen plumbing fast reliable and affordable service', 'serviceImage/1769497472484.jpg', 999.00, 0, '[{\"id\":1,\"question\":\"How much time dose  it take\",\"answer\":\"Is servicing required every year  ?\"}]', 1, '2026-01-27 07:05:01', 1),
(11, 6, 17, 'premium bathroom cleaning service', 'our bathroom cleaning service -ensures a clean hygienic and fresh bathroom for your home and office', 'serviceImage/1769963384232.jfif', 799.00, 0, '[]', 1, '2026-02-01 16:29:44', 1),
(13, 8, 20, 'QUALITY PAINTING SERVICES', 'PROFESSIONAL PAINTER SERVICES FOR HOME AND OFFICE QUALITY WORK CLEAN FINISH AND ON TIME SERVICE', 'serviceImage/1770009628827.jpg', 699.00, 0, '[]', 1, '2026-02-02 05:20:43', 1);

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
  `distance` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `service_order`
--

INSERT INTO `service_order` (`id`, `service_address`, `service_latitude`, `service_longitude`, `user_id`, `user_name`, `user_mobile`, `serviceman_id`, `serviceman_name`, `serviceman_mobile`, `amount`, `coupon_discount`, `gst_charges`, `final_amount`, `payment_status`, `service_status`, `service_id`, `service_name`, `pay_mode`, `coupon_id`, `available_service_man`, `service_datetime`, `updated_at`, `created_at`, `quantity`, `cancel_reason`, `orderOtp`, `description`, `rating`, `distance`) VALUES
(1, '121, Jankipuram Police Station, Sultanpur Village, Jankipuram Extension, Balamau, Uttar Pradesh, India, Near police station, Floor: 2', '26.92610643092992', '80.93939166516066', 18, 'ANSAL', '9651511938', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 5, 1, 'AC Cooling Service', 2, NULL, '[4,1,28]', '2026-01-17 17:40:00', '2026-01-17 17:34:28', '2026-01-17 17:34:28', 1, 'abvsh', '3410', 'bhhgjh', NULL, NULL),
(2, '121, Jankipuram Police Station, Sultanpur Village, Jankipuram Extension, Balamau, Uttar Pradesh, India, Near police station, Floor: 2', '26.92610643092992', '80.93939166516066', 18, 'ANSAL', '9651511938', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 0, 1, 'AC Cooling Service', 2, NULL, '[32,4,1,28]', '2026-01-17 17:44:00', '2026-01-17 17:38:07', '2026-01-17 17:38:07', 1, NULL, '5147', 'vbh', NULL, NULL),
(5, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 1, 'AC Cooling Service', 1, 3, '[35]', '2025-12-16 19:35:00', '2026-01-21 11:14:41', '2026-01-21 11:14:41', 1, NULL, '6885', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL),
(6, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 1, 'AC Cooling Service', 1, 3, '[35]', '2025-12-16 19:35:00', '2026-01-21 11:16:00', '2026-01-21 11:16:00', 1, NULL, '1041', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL),
(7, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 1, 'AC Cooling Service', 1, 3, '[25]', '2025-12-16 19:35:00', '2026-01-21 11:25:16', '2026-01-21 11:25:16', 1, NULL, '6073', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL),
(8, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 1, 'AC Cooling Service', 1, 3, '[25]', '2026-01-28 19:35:00', '2026-01-21 11:25:56', '2026-01-21 11:25:56', 1, NULL, '3178', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL),
(9, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 4, 'Furniture Repair', 1, 3, '[]', '2026-01-28 19:35:00', '2026-01-21 11:26:43', '2026-01-21 11:26:43', 1, NULL, '4093', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL),
(10, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 4, 'Furniture Repair', 1, 3, '[]', '2026-01-28 19:35:00', '2026-01-21 11:27:09', '2026-01-21 11:27:09', 1, NULL, '7381', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL),
(11, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 4, 'Furniture Repair', 1, 3, '[]', '2026-01-28 19:35:00', '2026-01-21 11:27:25', '2026-01-21 11:27:25', 1, NULL, '6013', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL),
(12, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 4, 'Furniture Repair', 1, 3, '[25]', '2026-01-28 19:35:00', '2026-01-21 11:30:18', '2026-01-21 11:30:18', 1, NULL, '9723', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL),
(13, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 4, 'Furniture Repair', 1, 3, '[36,25]', '2026-01-28 19:35:00', '2026-01-21 12:57:19', '2026-01-21 12:57:19', 1, NULL, '7900', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL),
(14, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 4, 'Furniture Repair', 1, 3, '[36,25]', '2026-01-28 19:35:00', '2026-01-21 13:00:05', '2026-01-21 13:00:05', 1, NULL, '1978', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL),
(15, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 4, 'Furniture Repair', 1, 3, '[36,25]', '2026-01-28 19:35:00', '2026-01-21 13:09:00', '2026-01-21 13:09:00', 1, NULL, '3416', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL),
(16, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 4, 'Furniture Repair', 1, 3, '[36,25]', '2026-01-28 19:35:00', '2026-01-21 13:18:06', '2026-01-21 13:18:06', 1, NULL, '1362', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL),
(17, 'bjbjb, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near vhvhhv, Floor: hvh', '26.943490817583424', '80.94053294509649', 4, 'Ramu  Sharma ', '8423953286', NULL, NULL, NULL, 200.00, 0.00, 36.00, 236.00, 0, 0, 8, 'Plant care man', 2, NULL, '[36,25]', '2026-01-21 15:05:00', '2026-01-21 14:47:57', '2026-01-21 14:47:57', 1, NULL, '8809', 'bbjbjb', NULL, NULL),
(18, 'bjbjb, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near vhvhhv, Floor: hvh', '26.943490817583424', '80.94053294509649', 4, 'Ramu  Sharma ', '8423953286', NULL, NULL, NULL, 200.00, 0.00, 36.00, 236.00, 0, 0, 8, 'Plant care man', 2, NULL, '[36,25]', '2026-01-22 12:05:00', '2026-01-21 14:49:56', '2026-01-21 14:49:56', 1, NULL, '7786', '', NULL, NULL),
(19, 'bjbjb, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near vhvhhv, Floor: hvh', '26.943490817583424', '80.94053294509649', 4, 'Ramu  Sharma ', '8423953286', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 0, 1, 'AC Cooling Service', 2, NULL, '[36,25]', '2026-01-22 15:15:00', '2026-01-21 14:52:22', '2026-01-21 14:52:22', 1, NULL, '8252', '', NULL, NULL),
(20, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 4, 'Furniture Repair', 1, 3, '[36,25]', '2026-01-28 19:35:00', '2026-01-21 14:53:26', '2026-01-21 14:53:26', 1, NULL, '8316', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL),
(21, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 4, 'Furniture Repair', 1, 3, '[36,25]', '2026-01-28 19:35:00', '2026-01-21 14:53:35', '2026-01-21 14:53:35', 1, NULL, '1287', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL),
(22, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 4, 'Furniture Repair', 1, 3, '[36,25]', '2026-01-28 19:35:00', '2026-01-21 14:53:38', '2026-01-21 14:53:38', 1, NULL, '8880', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL),
(23, '123 MG Road, Lucknow', '26.941430', '80.936786', 12, 'bvvv', '1111111111', NULL, NULL, NULL, 500.00, 50.00, 81.00, 531.00, 0, 0, 4, 'Furniture Repair', 1, 3, '[36,25]', '2026-01-28 19:35:00', '2026-01-21 14:53:41', '2026-01-21 14:53:41', 1, NULL, '1926', 'hbgftgyuh hgfghj jhgfgh', NULL, NULL),
(24, 'bjbjb, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near vhvhhv, Floor: hvh', '26.943490817583424', '80.94053294509649', 4, 'Ramu  Sharma ', '8423953286', 36, 'kunal  verma', '9808559632', 200.00, 0.00, 36.00, 236.00, 0, 4, 8, 'Plant care man', 1, NULL, '[36,25]', '2026-01-22 01:11:00', '2026-01-21 09:42:04', '2026-01-21 15:08:51', 1, NULL, '4911', '', NULL, 0.00),
(25, 'bjbjb, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near vhvhhv, Floor: hvh', '26.943490817583424', '80.94053294509649', 4, 'Ramu  Sharma ', '8423953286', 1, 'ramu sharmaa', '9876543211', 200.00, 0.00, 36.00, 236.00, 0, 6, 8, 'Plant care man', 2, 4, '[1,25,36]', '2026-01-22 18:25:00', '2026-01-22 18:22:57', '2026-01-22 18:22:57', 1, 'hhuhhn', '3475', '', NULL, 0.00),
(26, '1/798, 1/798, Sector H Road, Sector H, Jankipuram, Lucknow, Uttar Pradesh, India, Near near char no chauraha, Floor: ground floor', '26.919232342863356', '80.95782212913036', 25, 'Vishal', '7570006440', NULL, NULL, NULL, 400.00, 5.00, 68.40, 448.40, 0, 5, 8, 'Plant care man', 2, 4, '[1,37,33,25,36]', '2026-01-23 12:05:00', '2026-01-23 11:06:20', '2026-01-23 11:06:20', 2, 'koi nahi aaya', '4053', 'heel bss nee ghevar', NULL, NULL),
(27, '1/798, 1/798, Sector H Road, Sector H, Jankipuram, Lucknow, Uttar Pradesh, India, Near near char no chauraha, Floor: ground floor', '26.919232342863356', '80.95782212913036', 25, 'Vishal', '7570006440', 37, 'viveak  oberai', '9140183315', 200.00, 5.00, 34.20, 224.20, 0, 4, 8, 'Plant care man', 1, 4, '[1,37,33,25,36]', '2026-01-23 12:10:00', '2026-01-23 11:11:06', '2026-01-23 11:11:06', 1, NULL, '9900', 'sjdjdhfjfjfucucjcj rhi tb jhcbgdj sb ydhcehfhf', NULL, 3.20),
(28, 'ghh, Sector H, Jankipuram, Lucknow, Uttar Pradesh, India, Near chauraha, Floor: ground floor', '26.917772871792863', '80.95740236341953', 1, 'Tanisha Sharma ', '7235947667', 38, 'AMAN mishra', '9559960255', 499.00, 5.00, 85.33, 559.38, 0, 4, 1, 'AC Cooling Service', 2, 4, '[1,37,33,38,25]', '2026-01-23 15:24:00', '2026-01-23 14:36:22', '2026-01-23 14:36:22', 1, NULL, '6997', 'vvhh', NULL, 3.32),
(29, 'ghh, Sector H, Jankipuram, Lucknow, Uttar Pradesh, India, Near chauraha, Floor: ground floor', '26.917772871792863', '80.95740236341953', 1, 'Tanisha Sharma ', '7235947667', 38, 'AMAN mishra', '9559960255', 800.00, 0.00, 144.00, 944.00, 0, 4, 9, 'A all home Switch Repair', 2, NULL, '[1,33,25,38]', '2026-01-23 15:23:00', '2026-01-23 14:49:26', '2026-01-23 14:49:26', 1, NULL, '5607', 'vhhjh', NULL, 3.32),
(30, '1/2, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near CDRI, Floor: ground floor', '26.943490518700237', '80.94053294509649', 28, 'pankaj ', '7258836052', NULL, NULL, NULL, 800.00, 0.00, 144.00, 944.00, 0, 0, 9, 'A all home Switch Repair', 2, NULL, '[1,33,25,38]', '2026-01-24 10:56:00', '2026-01-24 09:57:10', '2026-01-24 09:57:10', 1, NULL, '2151', '', NULL, NULL),
(31, '1/2, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near CDRI, Floor: ground floor', '26.943490518700237', '80.94053294509649', 28, 'pankaj ', '7258836052', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 5, 1, 'AC Cooling Service', 2, NULL, '[33,37,1,25,38]', '2026-01-24 11:38:00', '2026-01-24 10:36:16', '2026-01-24 10:36:16', 1, 'cjfjfjffj vjfjfj', '3532', '', NULL, NULL),
(32, '1/2, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near CDRI, Floor: ground floor', '26.943490518700237', '80.94053294509649', 28, 'pankaj ', '7258836052', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 5, 1, 'AC Cooling Service', 2, NULL, '[1,33,37,25,38]', '2026-01-24 11:47:00', '2026-01-24 10:47:30', '2026-01-24 10:47:30', 1, 'nh karana hai mujhe', '7617', '', NULL, NULL),
(33, '1/2, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near CDRI, Floor: ground floor', '26.943490518700237', '80.94053294509649', 28, 'pankaj ', '7258836052', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 0, 1, 'AC Cooling Service', 2, NULL, '[33,37,1,25,38]', '2026-01-24 12:16:00', '2026-01-24 11:16:32', '2026-01-24 11:16:32', 1, NULL, '9283', 'chchchchhfu chfhffy', NULL, NULL),
(34, '1/2, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near CDRI, Floor: ground floor', '26.943490518700237', '80.94053294509649', 28, 'pankaj ', '7258836052', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 0, 9, 'AC Cooling Service', 2, NULL, '[33,37,1,25,38]', '2026-01-25 11:19:00', '2026-01-24 11:19:34', '2026-01-24 11:19:34', 1, NULL, '3575', 'Accessibility (Alt Text): Brief descriptions for screen readers and slow connections (e.g., \"A barista pouring latte art into a cup\"). Descriptive Writing: Uses sensory words (sight, sound, smell, touch, taste) to create imagery and atmosphere, common in stories and articles. Technical/System Descriptions: Explains processes, requirements, or data for software/knowledge systems, often in formal documents. Search Engine Optimization (SEO): Text descriptions help search engines understand and index images and content, improving discoverability.  Key Elements of Good Descriptions Sensory Details: Appeals to the five senses to make writing vivid. Show, Don\'t Tell: Conveys information through detail rather than direct statements. Context: Explains why something is important, not just what it looks like. Conciseness: Keep it brief and relevant, especially for web/alt text.  Examples Simple: \"A red apple.\" Descriptive: \"The ripe, crimson apple, cool and smooth in my palm, offered a sweet, sharp scent.\". Alt Text: \"A bar chart showing Q3 sales increased by 15% with a steep upward trend in August\" instead of just \"sales chart\". ', NULL, NULL),
(35, '1/2, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near CDRI, Floor: ground floor', '26.943490518700237', '80.94053294509649', 28, 'pankaj ', '7258836052', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 0, 1, 'AC Cooling Service', 2, NULL, '[33,1,37,25,38]', '2026-01-29 11:46:00', '2026-01-24 11:45:31', '2026-01-24 11:45:31', 1, NULL, '3542', '', NULL, NULL),
(36, '1/2, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near CDRI, Floor: ground floor', '26.943490518700237', '80.94053294509649', 28, 'pankaj ', '7258836052', 1, 'ramu sharmaa', '9876543211', 499.00, 0.00, 89.82, 588.82, 0, 4, 1, 'AC Cooling Service', 2, NULL, '[33,1,37,25,38]', '2026-01-25 12:16:00', '2026-01-24 12:16:32', '2026-01-24 12:16:32', 1, NULL, '4503', '', NULL, 0.00),
(37, '1/2, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near CDRI, Floor: ground floor', '26.943490518700237', '80.94053294509649', 28, 'pankaj ', '7258836052', 1, 'ramu sharmaa', '9876543211', 200.00, 0.00, 36.00, 236.00, 0, 6, 8, 'Plant care man', 2, NULL, '[33,37,1,25]', '2026-01-25 12:53:00', '2026-01-24 12:53:23', '2026-01-24 12:53:23', 1, 'nh time gft', '6814', 'mere ghar pe gardening karni hai aur grass bhi cut krns hai ', NULL, 0.00),
(38, '1/2, Vistar Yojna, Lucknow, Uttar Pradesh, 226031, Near CDRI, Floor: ground floor', '26.943490518700237', '80.94053294509649', 28, 'pankaj ', '7258836052', NULL, NULL, NULL, 200.00, 0.00, 36.00, 236.00, 0, 0, 8, 'Plant care man', 2, NULL, '[33,37,1,25]', '2026-01-25 12:58:00', '2026-01-24 12:58:19', '2026-01-24 12:58:19', 1, NULL, '3692', 'trees mango aur neem ke lgane hai ', NULL, NULL),
(39, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near Hanuman ka mandir, Floor: 3', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', NULL, NULL, NULL, 999.00, 0.00, 179.82, 1178.82, 0, 0, 10, 'plumbing leakage repari service', 1, NULL, '[35,38]', '2026-01-27 13:05:00', '2026-01-27 13:05:21', '2026-01-27 13:05:21', 1, NULL, '4555', '', NULL, NULL),
(40, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near Hanuman ka mandir, Floor: 3', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', NULL, NULL, NULL, 999.00, 0.00, 179.82, 1178.82, 0, 0, 10, 'plumbing leakage repari service', 2, NULL, '[35,38]', '2026-01-27 13:15:00', '2026-01-27 13:07:28', '2026-01-27 13:07:28', 1, NULL, '2991', '', NULL, NULL),
(41, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near Hanuman ka mandir, Floor: 3', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', NULL, NULL, NULL, 999.00, 0.00, 179.82, 1178.82, 0, 0, 10, 'plumbing leakage repari service', 1, NULL, '[35,38]', '2026-01-27 13:26:00', '2026-01-27 13:09:29', '2026-01-27 13:09:29', 1, NULL, '3740', '', NULL, NULL),
(42, '12 A, Unable to fetch address, Near shiv Mandir, Floor: 2', '28.588901861273964', '77.25339878350496', 20, 'aman', '8303204543', NULL, NULL, NULL, 1100.00, 0.00, 198.00, 1298.00, 0, 0, 6, 'AC Gas Refillings', 1, NULL, '[]', '2026-01-27 13:25:00', '2026-01-27 13:12:00', '2026-01-27 13:12:00', 1, NULL, '5591', '', NULL, NULL),
(43, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near Hanuman ka mandir, Floor: 3', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', NULL, NULL, NULL, 349.00, 0.00, 62.82, 411.82, 0, 0, 4, 'Furniture Repair', 1, NULL, '[33,1,25]', '2026-01-27 13:13:00', '2026-01-27 13:13:32', '2026-01-27 13:13:32', 1, NULL, '6741', '', NULL, NULL),
(44, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near Hanuman ka mandir, Floor: 3', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', NULL, NULL, NULL, 800.00, 0.00, 144.00, 944.00, 0, 0, 9, 'A all home Switch Repair', 2, NULL, '[33,1,25,38]', '2026-01-27 14:21:00', '2026-01-27 13:15:52', '2026-01-27 13:15:52', 1, NULL, '5643', '', NULL, NULL),
(45, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near Hanuman ka mandir, Floor: 3', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', NULL, NULL, NULL, 800.00, 0.00, 144.00, 944.00, 0, 0, 9, 'A all home Switch Repair', 2, NULL, '[33,1,25,38]', '2026-01-27 14:21:00', '2026-01-27 13:16:14', '2026-01-27 13:16:14', 1, NULL, '1256', '', NULL, NULL),
(46, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near Hanuman ka mandir, Floor: 3', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', NULL, NULL, NULL, 1100.00, 0.00, 198.00, 1298.00, 0, 0, 6, 'AC Gas Refillings', 2, NULL, '[33,37,1,25,38]', '2026-01-27 13:32:00', '2026-01-27 13:17:46', '2026-01-27 13:17:46', 1, NULL, '7178', '', NULL, NULL),
(47, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near shiv mandir, Floor: 2 floor', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', NULL, NULL, NULL, 599.00, 0.00, 107.82, 706.82, 0, 0, 5, 'AC Deep Cleaning', 2, NULL, '[33,37,1,25,38]', '2026-01-27 20:00:00', '2026-01-27 18:59:52', '2026-01-27 18:59:52', 1, NULL, '5289', 'service ', NULL, NULL),
(48, '12 a, Jankipuram, Lucknow, Uttar Pradesh, India, Near shiv mandir, Floor: 2 floor', '26.92102152938948', '80.9511836618185', 20, 'aman', '8303204543', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 0, 1, 'AC Cooling Service', 1, NULL, '[33,37,1,25,38]', '2026-01-27 20:01:00', '2026-01-27 19:01:10', '2026-01-27 19:01:10', 1, NULL, '9901', 'service ', NULL, NULL),
(49, '121, Jankipuram Police Station, Sultanpur Village, Jankipuram Extension, Balamau, Uttar Pradesh, India, Near police station, Floor: 2', '26.92610643092992', '80.93939166516066', 18, 'ANSAL', '9651511938', NULL, NULL, NULL, 599.00, 0.00, 107.82, 706.82, 0, 0, 5, 'AC Deep Cleaning', 1, NULL, '[38,33,37,1,25]', '2026-01-28 12:17:00', '2026-01-28 12:12:07', '2026-01-28 12:12:07', 1, NULL, '1833', 'cannot cancil ', NULL, NULL),
(50, '121, Jankipuram Police Station, Sultanpur Village, Jankipuram Extension, Balamau, Uttar Pradesh, India, Near police station, Floor: 2', '26.92610643092992', '80.93939166516066', 18, 'ANSAL', '9651511938', NULL, NULL, NULL, 599.00, 0.00, 107.82, 706.82, 0, 0, 5, 'AC Deep Cleaning', 1, NULL, '[38,1,33,37,25]', '2026-01-28 12:22:00', '2026-01-28 12:17:43', '2026-01-28 12:17:43', 1, NULL, '2891', '', NULL, NULL),
(51, 'vhhhf, 1/798, Sector H Road, Sector H, Jankipuram, Lucknow, Uttar Pradesh, India, Near vhjjj, Floor: 4', '26.919232342863356', '80.95782212913036', 3, 'pankaj ji', '9876543210', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 0, 1, 'AC Cooling Service', 2, NULL, '[38,33,1,37,25]', '2026-01-29 13:57:00', '2026-01-29 09:58:09', '2026-01-29 09:58:09', 1, NULL, '8753', '', NULL, NULL),
(52, 'vhhhf, 1/798, Sector H Road, Sector H, Jankipuram, Lucknow, Uttar Pradesh, India, Near vhjjj, Floor: 4', '26.919232342863356', '80.95782212913036', 3, 'pankaj ji', '9876543210', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 0, 1, 'AC Cooling Service', 1, NULL, '[38,33,37,1,25]', '2026-01-30 15:37:00', '2026-01-29 15:37:43', '2026-01-29 15:37:43', 1, NULL, '7189', '', NULL, NULL),
(53, 'vhhhf, 1/798, Sector H Road, Sector H, Jankipuram, Lucknow, Uttar Pradesh, India, Near vhjjj, Floor: 4', '26.919232342863356', '80.95782212913036', 3, 'pankaj ji', '9876543210', 1, 'ramu sharmaa', '9876543211', 499.00, 0.00, 89.82, 588.82, 0, 1, 1, 'AC Cooling Service', 1, NULL, '[38,33,1,37,25]', '2026-01-31 15:44:00', '2026-01-29 15:44:25', '2026-01-29 15:44:25', 1, NULL, '4471', '', NULL, 3.20);

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
(9, 'Support Mob', 'Support Mob', '8888888888', '2025-12-09 09:48:28', '2026-01-31 10:19:40');

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
(49, 12, 'LEAKAGE FIX', 'subcategories/1769494789127.jpg', 1, '2026-01-27 06:20:18');

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
(3, 5025.00, 'pankaj ji', NULL, NULL, 9876543210, 1, NULL, NULL, 'c_b5zQRkQyKoWVdLDN_n4B:APA91bEqHNGEOc_81uE47RYF8aHVbY0W8bKTgXfIATZaA1BKBY8r92jDY-h1iWdl37C_Yqs-05l3mhzgIsRdmK028yp1-CySX6ZZ90yCzlfCPKufohX6Ov4', 'RP1A.200720.011', '2026-01-30 12:21:58', '2025-12-18 10:22:32', NULL),
(4, 0.00, 'Ramu ', 'Sharma ', 'ramusharmagr@gmail.com', 8423953286, 1, 'UserprofileImage/1769067390512.jpg', 'Lucknow', 'f9IEdS5zSGauCIrqjwUjFK:APA91bEZn6o71-lBkaCCXJx7DB20hiWCf1z1nvmc8acJcLj1v-UmkBYw2DzB2jeKSiCJQpmiZ2kyumnkLwNv0MSVWF_9NRWGWxDKfHJnLqVOOZSo17_X7B0', 'RKQ1.201004.002', '2026-01-30 15:35:30', '2025-12-31 05:50:57', NULL),
(5, 0.00, 'lulu', NULL, NULL, 8547855558, 1, NULL, NULL, 'dp6PMgjHTXCJqrjRq7_IYF:APA91bH8c90l8Immsbb2-UAyRitr1Jwmhq9eXnbuYRVKQy2ZfZCpVsGr_g7jet5ODRxu-qchECOhDEgJC8PQC6uv2c-qwteor5JX6s9MioIkDQ8D2TMesQ8', 'UKQ1.230924.001', '2026-01-05 16:53:15', '2026-01-05 16:53:15', NULL),
(6, 0.00, 'gdgdgdh', NULL, NULL, 5989898595, 1, NULL, NULL, 'dp6PMgjHTXCJqrjRq7_IYF:APA91bH8c90l8Immsbb2-UAyRitr1Jwmhq9eXnbuYRVKQy2ZfZCpVsGr_g7jet5ODRxu-qchECOhDEgJC8PQC6uv2c-qwteor5JX6s9MioIkDQ8D2TMesQ8', 'UKQ1.230924.001', '2026-01-05 16:53:48', '2026-01-05 16:53:48', NULL),
(7, 0.00, 'fhrhdh', NULL, NULL, 6955885558, 1, NULL, NULL, 'dp6PMgjHTXCJqrjRq7_IYF:APA91bH8c90l8Immsbb2-UAyRitr1Jwmhq9eXnbuYRVKQy2ZfZCpVsGr_g7jet5ODRxu-qchECOhDEgJC8PQC6uv2c-qwteor5JX6s9MioIkDQ8D2TMesQ8', 'UKQ1.230924.001', '2026-01-05 16:54:41', '2026-01-05 16:54:41', NULL),
(8, 0.00, 'ngfhrh', NULL, NULL, 5578485856, 1, NULL, NULL, 'dp6PMgjHTXCJqrjRq7_IYF:APA91bH8c90l8Immsbb2-UAyRitr1Jwmhq9eXnbuYRVKQy2ZfZCpVsGr_g7jet5ODRxu-qchECOhDEgJC8PQC6uv2c-qwteor5JX6s9MioIkDQ8D2TMesQ8', 'UKQ1.230924.001', '2026-01-05 16:55:04', '2026-01-05 16:55:04', NULL),
(9, 0.00, 'xvxhxgd', NULL, NULL, 8989565654, 1, NULL, NULL, 'dp6PMgjHTXCJqrjRq7_IYF:APA91bH8c90l8Immsbb2-UAyRitr1Jwmhq9eXnbuYRVKQy2ZfZCpVsGr_g7jet5ODRxu-qchECOhDEgJC8PQC6uv2c-qwteor5JX6s9MioIkDQ8D2TMesQ8', 'UKQ1.230924.001', '2026-01-05 16:57:04', '2026-01-05 16:57:04', NULL),
(10, 0.00, 'fhfhd', NULL, NULL, 9565655656, 1, NULL, NULL, 'dp6PMgjHTXCJqrjRq7_IYF:APA91bH8c90l8Immsbb2-UAyRitr1Jwmhq9eXnbuYRVKQy2ZfZCpVsGr_g7jet5ODRxu-qchECOhDEgJC8PQC6uv2c-qwteor5JX6s9MioIkDQ8D2TMesQ8', 'UKQ1.230924.001', '2026-01-05 16:57:34', '2026-01-05 16:57:34', NULL),
(11, 0.00, 'fjfjfj', NULL, NULL, 9895653232, 1, NULL, NULL, 'dp6PMgjHTXCJqrjRq7_IYF:APA91bH8c90l8Immsbb2-UAyRitr1Jwmhq9eXnbuYRVKQy2ZfZCpVsGr_g7jet5ODRxu-qchECOhDEgJC8PQC6uv2c-qwteor5JX6s9MioIkDQ8D2TMesQ8', 'UKQ1.230924.001', '2026-01-05 16:58:22', '2026-01-05 16:58:22', NULL),
(12, 0.00, 'bvvv', NULL, NULL, 1111111111, 1, NULL, NULL, 'dp6PMgjHTXCJqrjRq7_IYF:APA91bH8c90l8Immsbb2-UAyRitr1Jwmhq9eXnbuYRVKQy2ZfZCpVsGr_g7jet5ODRxu-qchECOhDEgJC8PQC6uv2c-qwteor5JX6s9MioIkDQ8D2TMesQ8', 'UKQ1.230924.001', '2026-01-05 17:01:31', '2026-01-05 17:01:31', NULL),
(13, 0.00, 'dhdhdhhd', NULL, NULL, 8454664645, 1, NULL, NULL, 'eoxUxobiQ-OJXTruVTTe2s:APA91bHguJPQKINGsjP6Oge4zOIofbcizdKEWvd9TgKKWql_VcyhPffoDqHSzhT96QXCu8pF0Lm5LUqEzCBUXnF1k97p74jjDaaFRg8SNJm1W-JJ29aA5N0', 'RKQ1.201004.002', '2026-01-06 09:17:57', '2026-01-06 09:17:57', NULL),
(14, 0.00, 'harsh', NULL, NULL, 8887652143, 1, NULL, NULL, 'esBSSynzTfi8zqTDY7aAq_:APA91bGroKndaHZYDy21d8qiKXmsy75VvQ4gGvsArODZlP2Eyes6jERWmosbCqXnfrkrk6avLeO8ql1Zwhy-sutOPKe1urToX_yrBX2yrXI0LWjVIGRO2JI', 'AP3A.240617.008', '2026-01-12 10:49:06', '2026-01-12 10:49:06', NULL),
(15, 0.00, 'amar', NULL, NULL, 9759999888, 1, NULL, NULL, 'eqc3bkPCTYiy5j3PGQZWqw:APA91bGYGxzrDAPoqjEPMRPvIc39af2AOs1BCQ0qbqPDltb8tjlmT_c1KXqwJERbRHpsSW8L2ZFgxFtRFFB1YfO36iqNRQAm6OcnRGY9fS9w5zhRWKQU9HA', 'BP2A.250605.031.A3', '2026-01-14 16:53:27', '2026-01-14 16:53:27', NULL),
(16, 0.00, 'gugu', NULL, NULL, 8423959819, 1, NULL, NULL, 'eotJ3B8qSlyeUiLgwTJJu6:APA91bG6fVUCUwh091dfhjmT2TfaIfkQ1B8JuCsj7Ei45VPeJSdqlHZ5hagoQEyQAiuv1QDNwx-aXbYVN6uHZtu0OSmBKogjTO5HXdHADBm5FOnW_b67jDk', 'RP1A.200720.011', '2026-01-17 10:42:59', '2026-01-17 10:42:59', NULL),
(17, 0.00, 'aman', NULL, NULL, 7705827321, 1, NULL, NULL, 'fSx52B_ET_G-Vd7hPD-kE6:APA91bHfvCxAbbK-xOpx_Yt3OtQKrSVTKDXla0LTZFpkfrVc7qSYoIzotowDvqleP7QJZi7kAvMcS8pNaMYZFrRFF1qhUsfRjYq7HTYqut_iE2r_nmxM2IE', 'V1UOS35H.74-16-4-12', '2026-01-26 11:12:53', '2026-01-17 11:15:03', NULL),
(18, 0.00, 'ANSAL', NULL, NULL, 9651511938, 1, NULL, NULL, 'fVDARDYiQEu5pwK49L4YjE:APA91bEg-_9gQ00zWXU6dshbBvGJ_b_xMQVm3MorCLXKLcg8vPEh-trE2oRS8fHP_dRO9l7PvKTvtuNfZoXf1LKED_K1gvIYMY4HpLyHmMEF6OHs_Y9z9p4', 'SP1A.210812.016', '2026-01-28 06:46:17', '2026-01-17 11:32:01', NULL),
(19, 0.00, 'aman', NULL, NULL, 9559960255, 1, NULL, NULL, 'ckW28o43QJO56yVf6Yqizt:APA91bFMRWkf-QrWfGxwlPcSsTZnzeakxh1xug70z0a4eVyAj81zGNBRYg-PqU9lYxO3bhyxPe1TCDs-8vY2lOe3tNcXd9RCKZdMOH2wwhmVcVhSYbV4PZA', 'V1UOS35H.74-16-4-12', '2026-01-17 12:34:26', '2026-01-17 12:34:26', NULL),
(20, 0.00, 'aman', NULL, NULL, 8303204543, 1, NULL, NULL, 'e1YSgKn-RaO-Pj7MSA_4Yf:APA91bFOk50bRQD7-9FuIFvlXlpOy_93klvU4bkQO7NNDlpChSkZbAdoXu5OvEj-YUVJE9Jgzh_oIyKV_Qi5Ng-KvMPn31mkBizcbDM89MwfVORgfYlTrOg', 'UP1A.231005.007', '2026-01-27 05:54:54', '2026-01-17 13:53:44', NULL),
(21, 0.00, 'Ankit ', NULL, NULL, 7800019135, 1, NULL, NULL, 'eeV4Qv7OSHGcMUfHG89uqv:APA91bGS3IlncyWw7BJirt-C-4-rZpOdumgm9hpdaumzwqK1aGYXKzyg3NzY3dg568ObLb98hMO5gReY1gkyzaqP_7zAySzyffPdVsMqB4KyV5Lukj9_4pM', 'AP3A.240617.008', '2026-01-18 06:27:10', '2026-01-18 06:27:10', NULL),
(22, 0.00, 'abhay singh', NULL, NULL, 9236639289, 1, NULL, NULL, 'dRDtwYz1QdaezoBhu6AznI:APA91bHLzKA30hpAEb51r6NroYmAaSPBBKmqK6ogTeqci0jKPWTkb5jNb3CrQpCdHxxkUL2Bc_1yHY8QNV4xCAua845HqLZSv1vDaKPokeuE_oWOatgakHY', 'AP3A.240905.015.A2', '2026-01-18 10:03:03', '2026-01-18 10:03:03', NULL),
(23, 0.00, 'aayansh ', NULL, NULL, 8757315025, 1, NULL, NULL, 'fSYb84eKQruuDOaqgiZlKu:APA91bH-7ffvVWWisP8llkBq-Hzbx4ws4oz1vXNtIjT9QhC_vfpjSwNoSz9cpxilHeZ18AWr2kUrHz9_QPeQ0Hg-6AQfLIfRfich75PaEqLa6kZD7BsXq-g', 'UKQ1.230924.001', '2026-01-22 10:46:55', '2026-01-22 10:45:05', NULL),
(24, 0.00, 'anshuma', NULL, NULL, 7800764914, 1, NULL, NULL, 'eotJ3B8qSlyeUiLgwTJJu6:APA91bG6fVUCUwh091dfhjmT2TfaIfkQ1B8JuCsj7Ei45VPeJSdqlHZ5hagoQEyQAiuv1QDNwx-aXbYVN6uHZtu0OSmBKogjTO5HXdHADBm5FOnW_b67jDk', 'RP1A.200720.011', '2026-01-23 03:58:39', '2026-01-23 03:58:39', NULL),
(26, 0.00, 'nitin', NULL, NULL, 9208339102, 1, NULL, NULL, 'fpFo9ePpTDuLAxBrdHal4L:APA91bHJK9T-53wy4SkOrqPbFpKj3rjMqySlbYgbXNUPIvq9LChCcF67NcXA5Tp7q9JyfdueuhEbsK67Fo6axxfUJPrFdZstAvSX_wZyU44e26h1EEsQxko', 'BP2A.250605.031.A3', '2026-01-24 10:42:28', '2026-01-23 06:14:08', NULL),
(27, 0.00, NULL, NULL, NULL, 75700006441, 1, NULL, NULL, NULL, NULL, '2026-01-23 06:44:32', '2026-01-23 06:44:32', NULL),
(28, 0.00, 'pankaj ', NULL, NULL, 7258836052, 1, NULL, NULL, 'd43DpvmURQWcFOebpKjpnj:APA91bGBH9iKDc7GfiQ8v9zh3sjGKvzp8ScowVcHP85Q3SGha0gWsu2ytZzzFwURzRnRDPRM4OWYWpGP_BXh-K_DyWcT7jbpwviXq6Rezm-G3cQ4xyun3tk', 'RP1A.200720.011', '2026-01-23 10:20:36', '2026-01-23 10:20:36', NULL),
(29, 0.00, 'Anshika ', NULL, NULL, 7308050178, 1, NULL, NULL, 'ewAt8UxhQ1y7yItenGaz8D:APA91bFE-6ffmNr78Tb-ONK-lrUEq7WvtJrs8W1-b1Bg_JcEP9Qi5BdeBW8UGytfax-YHdvF88QpteFX8og_gE1gDr7WDJrRL2L7ZrB-Wuki8mXoC0k44cE', 'BQ2A.250721.001-BP2A.250605.031.A3', '2026-01-24 10:24:39', '2026-01-24 10:24:39', NULL),
(30, 0.00, 'ffbbb', NULL, NULL, 6306026322, 1, NULL, NULL, 'dwSdVPVcTU2QpF_JvsIBrU:APA91bHUcBLRSF8FD_BXjHQHsSYblcXWp6tj2KvGBya5VApVS_WGml_2Hq_lqdxM5ltNaUEm_06mqRFklALBu1OfVbS8ovg3SjtEfspp6oyUmtOp7wgXKEQ', 'UKQ1.230924.001', '2026-01-24 10:40:44', '2026-01-24 10:40:44', NULL),
(31, 0.00, 'Aryan', NULL, NULL, 7705017444, 1, NULL, NULL, 'cT-JXLlpRruUUeUutAZ-kM:APA91bErnfEK4rUnenrVQhFHxB-N5RgJZPUfovwaNvUeU8cZGEISEV-3WZH5pT5-QX3wZWUQl5YwCmRjY52zxTXy9hSInwxbO0VZ3cGn7oQW1gBSAhsLfF8', 'TP1A.220624.014', '2026-01-26 05:35:27', '2026-01-24 10:44:00', NULL),
(32, 0.00, 'Rashmi Yadav ', NULL, NULL, 7705019444, 1, NULL, NULL, 'dbDy97L7SQiOZqqASGRgcs:APA91bG3CdjnnA5_A06TmuUequkEFzgtunX5myBGZ0MexWON8RNuEGUmwQvFrhl9v4_8si3aM4VqmJU8G7SpJMWESynun9W8sQpzxlg8aQCy-J1Kzp1g0sw', 'UKQ1.231108.001', '2026-01-24 10:44:00', '2026-01-24 10:44:00', NULL),
(33, 0.00, 'Sushil Gupta ', NULL, NULL, 9506438531, 1, NULL, NULL, 'eYKZPqsKRjS0Ce7SDD1mfm:APA91bH8ooPrgY2alXNGU_v7dJGxUGLgRGhfO6ghcuCoBN03S6gkYVp2rLmXHauPwmoF09YqTq_Hka7TqqktUaPeJqHgjl3ic81x-7-kD68gkpBltb6Q1q4', 'AP3A.240905.015.A2', '2026-01-24 15:19:01', '2026-01-24 15:19:01', NULL),
(34, 0.00, 'ankit', NULL, NULL, 8173077880, 1, NULL, NULL, 'cl73o_o5SxStYAyPH51pSl:APA91bH17jJW5A3JCQ0n5s6NaUbf-EgOF4W3I85QkUemNlXgjEyFpq3NTTO05gOT2BSdsVUsLXEwB8UfI0eKEcd0WkZbyImoNk7dOGJAqYiXnbdpeZ7csIg', 'W1VC36H.14-20-12', '2026-01-25 12:57:41', '2026-01-25 12:57:41', NULL),
(35, 0.00, 'sanjana', NULL, NULL, 8303503703, 1, NULL, NULL, 'erCoOwC3Tx-is-J5wG6nMR:APA91bGcxVsPcazkoiXRVXlLr9x1I0Oe65F_X07RywSQmcMuBbIbhRZvOuIvqswbUo3I5-qr5x5FMpF_-XH5kJhEVISbANXhZgB7gCDla1zZe9ae4I2qwZM', 'SP1A.210812.003', '2026-01-25 13:18:26', '2026-01-25 13:18:26', NULL),
(36, 0.00, 'Alok ', NULL, NULL, 9219180433, 1, NULL, NULL, 'c_CPPnIAR12n_qOixcMv2o:APA91bG6BtuBbfaP-aw2kBnAKAv43i_v5ItY8ao632q7A0KOgo4kU6JBovpwI3HOqR-CP5QnwRA6LyFj0-ZZZANEdAnplchOjXzxR_wrPwugPugf0epC7S8', 'SP1A.210812.003', '2026-01-29 09:22:53', '2026-01-29 09:22:53', NULL),
(37, 0.00, 'anu', NULL, NULL, 8381969475, 1, NULL, NULL, 'cqaQMGDhSDakyjw4Z1IMZm:APA91bHFNCgG3bN9uEqvxHd9WQEu7zZzwXApfnuxTNp6dgCS1pmzSf7HcO40Y1LfWKWS4tzGLruzhoLXiVlG-u4rdFlIqZ8GlR3ef49BjBSC-UvYhg_Zd3Q', 'TP1A.220905.001', '2026-02-01 10:42:26', '2026-02-01 10:42:26', NULL);

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
(30, 5, 30.00, 2500.00, 10.00, '2026-01-23 11:44:13', '2026-01-24 06:04:58'),
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
(17, 'All India City', '[{\"lat\":29.382471950202728,\"lng\":82.81685123114734},{\"lat\":30.667740230016868,\"lng\":79.23942813544421},{\"lat\":30.25224412049882,\"lng\":73.43178043036609},{\"lat\":22.182633968622252,\"lng\":73.12416324286609},{\"lat\":26.841530753080114,\"lng\":80.63881168036609},{\"lat\":26.704210612140216,\"lng\":80.70198306708484},{\"lat\":22.159742459429793,\"lng\":73.00056705145984},{\"lat\":22.327526816532913,\"lng\":73.14613589911609},{\"lat\":21.453385729170584,\"lng\":74.03053531317859},{\"lat\":17.22246021394415,\"lng\":74.14039859442859},{\"lat\":15.604848383533694,\"lng\":78.51295718817859},{\"lat\":19.953016647590587,\"lng\":83.48976382880359},{\"lat\":24.00161933490728,\"lng\":91.10603580145984}]', '2025-12-21 09:46:37', 1, '[{\"id\": 1, \"name\": \"Lucknow\"}, {\"id\": 2, \"name\": \"Barabanki\"}, {\"id\": 3, \"name\": \"Unnao\"}, {\"id\": 4, \"name\": \"Raebareli\"}, {\"id\": 5, \"name\": \"Sitapur\"}, {\"id\": 6, \"name\": \"Hardoi\"}]', 2),
(18, 'gorakhpur', '[{\"lat\":27.120828087223593,\"lng\":82.92373906249999},{\"lat\":26.98384751876597,\"lng\":84.76944218749999},{\"lat\":26.394904239828136,\"lng\":84.76944218749999},{\"lat\":26.394904239828136,\"lng\":82.98965703124999}]', '2026-01-30 06:55:10', NULL, NULL, 1);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `cab_cancel_reasons`
--
ALTER TABLE `cab_cancel_reasons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `cab_orders`
--
ALTER TABLE `cab_orders`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=308;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `coupons_used`
--
ALTER TABLE `coupons_used`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `driver_offer`
--
ALTER TABLE `driver_offer`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `driver_online_logs`
--
ALTER TABLE `driver_online_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `driver_registration`
--
ALTER TABLE `driver_registration`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `otp_counter`
--
ALTER TABLE `otp_counter`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `otp_logs`
--
ALTER TABLE `otp_logs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=181;

--
-- AUTO_INCREMENT for table `paying`
--
ALTER TABLE `paying`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=131;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `scheduled_api_hits`
--
ALTER TABLE `scheduled_api_hits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT for table `serviceman`
--
ALTER TABLE `serviceman`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `serviceman_ratings`
--
ALTER TABLE `serviceman_ratings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `service_order`
--
ALTER TABLE `service_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `subcategories`
--
ALTER TABLE `subcategories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `top_service`
--
ALTER TABLE `top_service`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(55) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

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
