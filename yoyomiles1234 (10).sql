-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 10, 2026 at 08:19 PM
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
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `adminuser`
--

INSERT INTO `adminuser` (`id`, `name`, `email`, `password`, `image`, `created_at`) VALUES
(1, 'Admin User', 'admin@gmail.com', '12345678', 'profileImage/1767933713855.png', '2025-12-04 05:00:20');

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
(42, 12, '123456789012', 'Ramu Sharma', 'HDFC0001234', '123456789012', 'HDFC Bank', '2025-12-12 11:03:40', '2025-12-13 06:36:37', 1, 1),
(43, 5, '123456789012', 'Ramu Sharma', 'SBIN012345A', '123456789012', 'State Bank of India', '2025-12-12 12:28:09', '2025-12-12 12:28:09', 1, 1),
(44, 1, '963256325635', 'Swati', 'CANN0123456', '963256325635', 'Canara Bank', '2025-12-12 12:39:58', '2025-12-13 12:57:15', 1, 1),
(46, 10, '965632692962', 'Tanisha Sharma ', 'CAIN0123456', '965632692962', 'canara', '2025-12-22 07:56:41', '2025-12-22 07:56:41', 2, 1),
(47, 19, '987654321001', 'Kunal ', 'HYGT0123456', '987654321001', 'HDFC', '2026-01-06 08:02:34', '2026-01-06 08:02:34', 2, 1);

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
(4, 2, 'Hyundai', 0, '2025-12-30 04:33:32'),
(5, 3, 'Honda', 0, '2025-12-30 04:33:47'),
(6, 3, 'Bajaj', 1, '2025-12-30 04:33:47'),
(8, 4, 'test', 1, '2025-12-30 11:29:59');

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
(1, 0, 0, NULL, 2, 0.00, 0.00, '[20]', '[19]', 3, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9434913, 80.9404745, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 9.94, 185.00, NULL, NULL, 2, '2026-01-10 17:42:00', 0, NULL, '2026-01-10 17:39:52', '2026-01-10 17:42:06', '', 0, NULL, NULL, NULL, NULL, NULL, 3672, NULL, 'pankaj ji', 9876543210, NULL),
(2, 5, 0, 19, 2, 0.00, 149.00, '[19,20]', NULL, 3, 3, 'Bike', 6, 'Bajaj', 12, 'Platina', 'Vistar Yojna, Lucknow, Uttar Pradesh, 226031', 26.9435612, 80.9405539, 'Hazratganj, Lucknow, Uttar Pradesh, India', 26.8541536, 80.9447827, 9.95, 149.00, 51, NULL, 1, NULL, 0, NULL, '2026-01-10 17:44:35', '2026-01-10 17:45:25', '', 0, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', NULL, 'Ramu  Sharma ', NULL, 9876543210, 1403, 4, 'pankaj ji', 9876543210, NULL);

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
(16, 'Smart Home', 'categories/automatic-removebg-preview.png', 1, '2025-12-06 08:31:30');

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
(1, 1, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 150.00, 150.00, 0, '2026-01-05 10:46:40', '2026-01-05 10:46:40', 3, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(2, 3, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 149.00, 149.00, 0, '2026-01-05 11:13:35', '2026-01-05 11:13:35', 3, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(3, 4, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 149.00, 150.00, 0, '2026-01-05 11:54:43', '2026-01-05 11:54:43', 3, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(4, 5, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 149.00, 149.00, 0, '2026-01-05 12:24:17', '2026-01-05 12:24:17', 3, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(5, 6, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 149.00, 150.00, 0, '2026-01-05 12:44:43', '2026-01-05 12:44:43', 3, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(6, 7, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 149.00, 149.00, 0, '2026-01-05 13:13:02', '2026-01-05 13:13:02', 3, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(7, 8, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 149.00, 149.00, 0, '2026-01-05 13:20:13', '2026-01-05 13:20:13', 3, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(8, 9, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 149.00, 149.00, 0, '2026-01-05 13:25:36', '2026-01-05 13:25:36', 3, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(9, 10, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 131.00, 131.00, 0, '2026-01-05 13:35:06', '2026-01-05 13:35:06', 3, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(10, 11, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 188.00, 188.00, 0, '2026-01-05 13:45:52', '2026-01-05 13:45:59', 3, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(11, 12, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 149.00, 149.00, 0, '2026-01-05 13:48:59', '2026-01-05 13:48:59', 3, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(12, 13, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 149.00, 149.00, 0, '2026-01-05 13:55:32', '2026-01-05 13:55:32', 3, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(13, 14, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 185.00, 185.00, 0, '2026-01-05 14:01:09', '2026-01-05 14:01:09', 3, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(14, 15, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 149.00, 149.00, 0, '2026-01-05 14:47:06', '2026-01-05 14:47:06', 3, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(15, 16, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 226.00, 226.00, 0, '2026-01-05 14:58:10', '2026-01-05 14:58:10', 3, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(16, 17, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 149.00, 149.00, 0, '2026-01-05 15:26:20', '2026-01-05 15:26:20', 3, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(17, 18, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 149.00, 149.00, 0, '2026-01-05 15:49:12', '2026-01-05 15:49:12', 3, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(18, 19, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 188.00, 188.00, 0, '2026-01-05 15:59:13', '2026-01-05 15:59:13', 3, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(19, 20, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 149.00, 149.00, 0, '2026-01-05 16:06:42', '2026-01-05 16:06:42', 3, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(20, 21, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 149.00, 149.00, 0, '2026-01-05 16:15:01', '2026-01-05 16:15:01', 3, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(21, 22, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 149.00, 149.00, 0, '2026-01-05 16:27:16', '2026-01-05 16:27:16', 3, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(22, 23, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 186.00, 186.00, 0, '2026-01-05 16:29:33', '2026-01-05 16:29:33', 3, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(23, 24, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 149.00, 149.00, 0, '2026-01-05 16:31:33', '2026-01-05 16:31:33', 3, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(24, 25, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 185.00, 185.00, 0, '2026-01-05 16:33:13', '2026-01-05 16:33:13', 3, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(25, 26, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 185.00, 185.00, 0, '2026-01-05 17:17:36', '2026-01-05 17:17:36', 3, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(26, 28, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 185.00, 185.00, 0, '2026-01-05 17:41:36', '2026-01-05 17:41:36', 3, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(27, 29, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 185.00, 185.00, 0, '2026-01-05 17:46:45', '2026-01-05 17:46:45', 3, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(28, 30, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 185.00, 185.00, 0, '2026-01-05 18:05:14', '2026-01-05 18:05:14', 3, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(29, 31, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 149.00, 149.00, 0, '2026-01-05 18:10:21', '2026-01-05 18:10:21', 3, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(30, 32, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 149.00, 150.00, 0, '2026-01-05 18:19:40', '2026-01-05 18:19:40', 3, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(31, 36, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 157.00, 158.00, 0, '2026-01-05 22:33:59', '2026-01-05 22:33:59', 12, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5),
(32, 37, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 192.00, 192.00, 0, '2026-01-05 22:47:55', '2026-01-05 22:47:55', 12, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5),
(33, 38, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 191.00, 191.00, 0, '2026-01-05 22:51:15', '2026-01-05 22:51:15', 12, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5),
(34, 39, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 192.00, 192.00, 0, '2026-01-05 22:57:49', '2026-01-05 22:57:49', 12, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5),
(35, 40, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 192.00, 192.00, 0, '2026-01-05 23:03:53', '2026-01-05 23:03:53', 12, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5),
(36, 41, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 159.00, 159.00, 0, '2026-01-05 23:19:24', '2026-01-05 23:19:24', 12, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5),
(37, 42, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 73.00, 75.00, 0, '2026-01-05 23:22:42', '2026-01-05 23:22:42', 12, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5),
(38, 43, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 132.00, 132.00, 0, '2026-01-05 23:25:40', '2026-01-05 23:25:40', 12, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5),
(39, 44, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 132.00, 132.00, 0, '2026-01-05 23:26:55', '2026-01-05 23:26:55', 12, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5),
(40, 46, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 185.00, 186.00, 0, '2026-01-06 16:56:59', '2026-01-06 16:56:59', 13, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(41, 47, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 185.00, 186.00, 0, '2026-01-06 17:07:41', '2026-01-06 17:07:41', 13, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(42, 48, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 185.00, 185.00, 0, '2026-01-06 17:15:47', '2026-01-06 17:15:47', 13, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(43, 49, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 185.00, 185.00, 0, '2026-01-06 17:16:51', '2026-01-06 17:16:51', 13, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(44, 50, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 185.00, 187.00, 0, '2026-01-06 17:17:59', '2026-01-06 17:17:59', 13, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(45, 51, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 185.00, 185.00, 0, '2026-01-06 17:30:07', '2026-01-06 17:30:07', 13, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(46, 52, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 149.00, 151.00, 0, '2026-01-06 17:44:34', '2026-01-06 17:44:34', 13, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(47, 68, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 300.00, 340.00, 0, '2026-01-07 15:14:56', '2026-01-07 15:14:56', 1, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(48, 81, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 300.00, 340.00, 0, '2026-01-07 17:01:35', '2026-01-07 17:01:35', 1, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(49, 87, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766576896221.jpg', 300.00, 340.00, 0, '2026-01-08 12:35:54', '2026-01-08 12:47:14', 1, 20, 'Hyundai', 'i10', 'wao ki', 56, 4.5),
(50, 1, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 185.00, 185.00, 0, '2026-01-08 18:09:31', '2026-01-09 16:18:02', 3, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5),
(51, 2, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 149.00, 149.00, 0, '2026-01-09 09:56:29', '2026-01-10 17:44:41', 3, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5),
(52, 3, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 185.00, 186.00, 0, '2026-01-09 16:18:08', '2026-01-09 16:18:08', 13, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5),
(53, 4, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 161.00, 161.00, 0, '2026-01-10 09:44:53', '2026-01-10 09:44:53', 3, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5),
(54, 5, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 149.00, 149.00, 0, '2026-01-10 10:22:52', '2026-01-10 10:22:52', 3, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5),
(55, 6, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 149.00, 149.00, 0, '2026-01-10 10:33:53', '2026-01-10 10:34:31', 3, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5),
(56, 7, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 300.00, 340.00, 0, '2026-01-10 10:41:19', '2026-01-10 10:41:19', 3, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5),
(57, 9, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 185.00, 185.00, 0, '2026-01-10 11:26:09', '2026-01-10 11:26:09', 3, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5),
(58, 12, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 128.00, 128.00, 0, '2026-01-10 11:45:43', '2026-01-10 11:45:43', 3, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5),
(59, 13, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 185.00, 185.00, 0, '2026-01-10 11:54:29', '2026-01-10 13:26:28', 3, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5),
(60, 14, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 149.00, 149.00, 0, '2026-01-10 12:03:44', '2026-01-10 12:03:44', 3, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5),
(61, 15, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 149.00, 150.00, 0, '2026-01-10 12:09:37', '2026-01-10 12:09:37', 3, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5),
(62, 11, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 300.00, 340.00, 0, '2026-01-10 12:11:53', '2026-01-10 12:11:53', 3, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5),
(63, 17, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 185.00, 185.00, 0, '2026-01-10 12:15:48', '2026-01-10 12:15:48', 3, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5),
(64, 23, 'https://admin.rainbowsenterprises.com/DriverDocuments/1766834163079.jpg', 185.00, 185.00, 0, '2026-01-10 16:11:11', '2026-01-10 16:11:11', 3, 19, NULL, NULL, 'Ramu  Sharma ', 56, 4.5);

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
(6, 19, '2026-01-09 09:24:32', NULL, '2026-01-09 09:24:32', '2026-01-09 09:24:32'),
(7, 20, '2026-01-10 13:08:50', NULL, '2026-01-10 13:08:50', '2026-01-10 13:08:50');

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

INSERT INTO `driver_registration` (`id`, `wallet`, `due_wallet`, `personal_information_status`, `vehicle_info_status`, `driver_licence_status`, `aadhaar_pan_status`, `required_certificates_status`, `vehicle_documents_status`, `platform_type`, `vehicle_name`, `mobile`, `profile_photo`, `first_name`, `last_name`, `date_of_birth`, `personal_information_reject_reason`, `driver_licence_reject_reason`, `driver_licence_front`, `driver_licence_back`, `driver_licence_number`, `licence_validity_date`, `aadhaar_pan_reject_reason`, `aadhaar_front`, `aadhaar_back`, `aadhaar_number`, `pan_card_front`, `pan_card_back`, `pan_card_number`, `required_certificates_reject_reason`, `fitness_certificate`, `pollution_certificate`, `insurance_certificate`, `police_certificate`, `vehicle_info_reject_reason`, `vehicle_photo`, `vehicle_color`, `vehicle_plate_number`, `vehicle_documents_reject_reason`, `vehicle_permit_part_a`, `vehicle_permit_part_b`, `vehicle_registration_front`, `vehicle_registration_back`, `created_at`, `updated_at`, `device_id`, `fcm_token`, `online_status`, `login_status_inactive_reasion`, `login_status`, `current_latitude`, `current_longitude`, `vehicle_type`, `model_id`, `brand_id`, `model_name`, `brand_name`, `vehicle_production_year`, `rating`, `email`, `rating_count`, `rating_sum`) VALUES
(1, 0.00, -1000.00, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, '8423953211', 'DriverDocuments/1766217684864.png', 'ramu sharma', 'aaaaaaaaa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-20 08:01:25', '2025-12-26 12:31:37', 'ABC123XYZ', 'token123', 0, NULL, 0, '28.6139', '77.2090', NULL, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(2, 200.00, 0.00, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '8956562326', 'DriverDocuments/1766219167852.jpg', 'dhdgdh', 'bfbfhfh', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-20 08:26:08', '2025-12-22 05:22:19', 'kmjnhbg', 'kjhgjnh', 1, NULL, 1, '28.6139', '77.2090', NULL, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(3, 470.00, 0.00, 3, NULL, 1, 1, 1, NULL, NULL, NULL, '5986532256', 'DriverDocuments/1766222586331.jpg', 'sbshsush', 'dbdhsh', NULL, 'easrtghj', NULL, 'DriverDocuments/1766223181469.jpg', 'DriverDocuments/1766223181577.jpg', 'vjvkviivk', '2025-12-26', NULL, 'DriverDocuments/1766223216777.jpg', 'DriverDocuments/1766223216877.jpg', 'hfhdhfh', 'DriverDocuments/1766223216977.jpg', 'DriverDocuments/1766223217065.jpg', 'hfhfhf', NULL, 'DriverDocuments/1766223341703.jpg', 'DriverDocuments/1766223341918.jpg', 'DriverDocuments/1766223342012.jpg', 'DriverDocuments/1766223342018.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-20 09:23:06', '2025-12-22 08:24:46', 'kmjnhbg', 'kjhgjnh', 0, NULL, 1, '26.946196', '80.937907', NULL, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(4, 0.00, 0.00, 2, 2, 2, 2, 2, 3, NULL, NULL, '8864546232', 'DriverDocuments/1766223428775.jpg', 'hdhd', 'dgdgd', NULL, NULL, NULL, 'DriverDocuments/1766223450527.jpg', 'DriverDocuments/1766223450647.jpg', 'hhuuh', '2025-12-26', NULL, 'DriverDocuments/1766223474325.jpg', 'DriverDocuments/1766223474418.jpg', 'bhhuh', 'DriverDocuments/1766223474511.jpg', 'DriverDocuments/1766223474516.jpg', 'bhhu', NULL, 'DriverDocuments/1766223495972.jpg', 'DriverDocuments/1766223496067.jpg', 'DriverDocuments/1766223496163.jpg', 'DriverDocuments/1766223496221.jpg', NULL, NULL, NULL, NULL, 'vehicle document status reject', NULL, NULL, NULL, NULL, '2025-12-20 09:37:08', '2025-12-27 11:14:18', 'kmjnhbg', 'kjhgjnh', 0, NULL, 1, '26.9435287', '80.9405264', NULL, NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(5, 0.00, 0.00, 2, 1, 2, 1, 1, 1, 2, NULL, '5656565656', 'DriverDocuments/1766223739400.jpg', 'gussa', 'aa rha hai ', NULL, NULL, NULL, 'DriverDocuments/1766223752569.jpg', 'DriverDocuments/1766223752677.jpg', 'dhdudh', '2025-12-27', NULL, 'DriverDocuments/1766223779881.jpg', 'DriverDocuments/1766223779978.jpg', 'bzjssh', 'DriverDocuments/1766223780069.jpg', 'DriverDocuments/1766223780077.jpg', 'upsbhsh', NULL, 'DriverDocuments/1766223795889.jpg', 'DriverDocuments/1766223795990.jpg', 'DriverDocuments/1766223796088.jpg', 'DriverDocuments/1766223796175.jpg', NULL, 'DriverDocuments/1766224394130.jpg', 'Bronze', 'bfbdbd', NULL, 'DriverDocuments/1766224434425.jpg', 'DriverDocuments/1766224434527.jpg', 'DriverDocuments/1766224434626.jpg', 'DriverDocuments/1766224434724.jpg', '2025-12-20 09:42:19', '2025-12-20 12:36:54', 'RP1A.200720.011', 'e-zsq6KyS9KoyigjnH6cFl:APA91bESbKeD_J-luQzMvWQ39-bS4qQAH1hh8KCJdr1mYqEuNdX4LY_RD9QYm25ZStcQ1ykRVH9_M2wvpRzOuJmmfOGltHFc736WGtGQZ5qdbwdTnUBtbO0', 1, NULL, 1, '26.9433457', '80.940395', NULL, 6, 3, 'HF Deluxe', 'Maruti', NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(6, 0.00, 0.00, 1, NULL, NULL, NULL, NULL, NULL, 2, 'abc', '8423953286', 'DriverDocuments/1766224649841.png', 'ramu sharma', 'aaaaaaaaa', '2001-08-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-20 09:55:43', '2025-12-23 09:24:11', 'sdzfxcghjklhgfxchjk', 'szdxfghjkhgcfxd', 1, NULL, 1, '26.8506', '80.9462', '1', NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(7, 0.00, 0.00, 2, 2, 2, 2, 2, 2, 2, 'abc', '8423953286', 'DriverDocuments/1766225268057.png', 'ramu sharma', 'aaaaaaaaa', '2001-08-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-20 10:07:48', NULL, 'sdzfxcghjklhgfxchjk', 'szdxfghjkhgcfxd', 1, NULL, 1, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(8, 0.00, 0.00, 2, 2, 2, 2, 2, 2, 2, 'abc', '8423953286', 'DriverDocuments/1766225733188.png', 'ramu sharma', 'aaaaaaaaa', '2001-08-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-20 10:15:33', NULL, 'sdzfxcghjklhgfxchjk', 'szdxfghjkhgcfxd', 1, NULL, 1, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(9, 0.00, 0.00, 1, NULL, NULL, NULL, NULL, NULL, 2, 'abc', '8423953286', 'DriverDocuments/1766376185037.png', 'ramu sharma', 'aaaaaaaaa', '2001-08-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-22 04:03:05', '2025-12-23 09:24:19', 'sdzfxcghjklhgfxchjk', 'eoxUxobiQ-OJXTruVTTe2s:APA91bHguJPQKINGsjP6Oge4zOIofbcizdKEWvd9TgKKWql_VcyhPffoDqHSzhT96QXCu8pF0Lm5LUqEzCBUXnF1k97p74jjDaaFRg8SNJm1W-JJ29aA5N0', 1, NULL, 1, '26.9435628', '80.9405068', '2', 3, 2, 'Maruti', 'HF Deluxe', NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(12, 0.00, 0.00, 2, 2, 2, 2, 2, 2, 2, 'abc', '7235947666', 'DriverDocuments/1766376185037.png', 'ramu sharma', 'aaaaaaaaa', '2001-08-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-22 04:03:05', '2026-01-06 05:23:17', 'fvgbhnj', 'd1uVSDquQKCh6RhAb66BlV:APA91bEn0inBi4IFGG15w2-6-ZGgdcALmuzPJ49oDcgLJNFADMjsmBayJa5pRsQtDlVpzIjIcCP_hi3V57BuQ9S2NqMNxxqiJXp6GtvMyMYA8agkmt2FiWY', 1, NULL, 1, '28.6139', '77.2090', '2', 3, 2, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(18, 0.00, 0.00, 2, 2, 2, 2, 2, 2, 2, 'Black Car', '6333222552', 'DriverDocuments/1766576896221.jpg', 'Rohit ', 'kumar', '2000-01-22', NULL, NULL, 'DriverDocuments/1766576916117.jpg', 'DriverDocuments/1766576916583.jpg', 'jhuihu', '2025-12-25', NULL, 'DriverDocuments/1766576941812.jpg', 'DriverDocuments/1766576942303.jpg', 'hhuu', 'DriverDocuments/1766576942740.jpg', 'DriverDocuments/1766576943038.jpg', 'hjiu', NULL, 'DriverDocuments/1766576966422.jpg', 'DriverDocuments/1766576967027.jpg', 'DriverDocuments/1766576967161.jpg', 'DriverDocuments/1766576967426.jpg', NULL, 'DriverDocuments/1766576987633.jpg', 'Bronze', 'vbhuh', NULL, 'DriverDocuments/1766577014905.jpg', 'DriverDocuments/1766577015419.jpg', 'DriverDocuments/1766577015844.jpg', 'DriverDocuments/1766577016114.jpg', '2025-12-24 11:48:16', '2026-01-05 16:33:55', 'fvgbhnj', 'cEDPol0xQLyCDWhzxv27uu:APA91bGo_2Ka7p0mptSujTpQ3clhrn87sBGOF-4OLUZiJm9X4BMyr962-gfiTczs1-pivwbuV680Zw6zaALLqP7-3aC8quA65-vukwnDkjkYADYYg3rFzcE', 1, NULL, 1, '26.9476236', '80.9387408', '3', 2, 1, 'i10', 'Hyundai', '2020', 4.5, 'cabuser@gmail.com', 0, 0),
(19, 2976.00, 150.77, 2, 2, 2, 2, 2, 2, 2, 'Bike', '9876543210', 'DriverDocuments/1766834163079.jpg', 'Ramu ', 'Sharma ', '2000-01-29', NULL, NULL, 'DriverDocuments/1766839604960.jpg', 'DriverDocuments/1766839605191.jpg', 'gshshd', '2025-12-24', NULL, 'DriverDocuments/1766839629326.jpg', 'DriverDocuments/1766839629559.jpg', 'xbshhdhdb', 'DriverDocuments/1766839629661.jpg', 'DriverDocuments/1766839629756.jpg', 'shhshshshs', NULL, 'DriverDocuments/1766839703064.jpg', 'DriverDocuments/1766839703326.jpg', 'DriverDocuments/1766839703435.jpg', 'DriverDocuments/1766839703531.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-27 11:16:04', '2026-01-10 12:15:34', 'fvgbhnj', 'fIHKV0i5RJmrl_bGYK_kyE:APA91bFnK9PmPZ8Z4hdBpByJr-C_Yu0FtxxXSLf6Mzp_0eu2vFuWyjhDC2347WCV6bO7nZYa8QSHjg482qTL0kCuge5rBkccS65Y-40esjBu3Zi8mH6MxYU', 1, NULL, 1, '26.943506', '80.9405402', '3', NULL, NULL, NULL, NULL, NULL, 4, 'cabuser@gmail.com', 7, 2),
(20, 546.78, 3000.00, 2, 2, 2, 2, 2, 2, 2, 'Black Car', '1111111111', 'DriverDocuments/1766576896221.jpg', 'wao', 'ki', '2000-01-22', NULL, NULL, 'DriverDocuments/1766576916117.jpg', 'DriverDocuments/1766576916583.jpg', 'jhuihu', '2025-12-25', NULL, 'DriverDocuments/1766576941812.jpg', 'DriverDocuments/1766576942303.jpg', 'hhuu', 'DriverDocuments/1766576942740.jpg', 'DriverDocuments/1766576943038.jpg', 'hjiu', NULL, 'DriverDocuments/1766576966422.jpg', 'DriverDocuments/1766576967027.jpg', 'DriverDocuments/1766576967161.jpg', 'DriverDocuments/1766576967426.jpg', NULL, 'DriverDocuments/1766576987633.jpg', 'Bronze', 'vbhuh', NULL, 'DriverDocuments/1766577014905.jpg', 'DriverDocuments/1766577015419.jpg', 'DriverDocuments/1766577015844.jpg', 'DriverDocuments/1766577016114.jpg', '2025-12-24 11:48:16', '2026-01-10 07:38:50', 'fvgbhnj', 'c0WwPmxESFmXhUJSy5GH3i:APA91bFYVW2orZ_dALjbaaRYGvSYQ9ZHaE-AL9be7Thc2Fr4b8J4A5-NDJhhPoGCTFNBlcHCHOSYm6lkcAFjQCd5RWhqgwNlSCDLSilZ9AzWDw4rAwxvEks', 1, NULL, 1, '26.9434758', '80.9405371', '3', 2, 1, 'i10', 'Hyundai', '2020', 5, 'cabuser@gmail.com', 46, 10),
(58, 0.00, 3000.00, 1, 0, 1, 1, 1, 0, 2, 'Bike', '7607336673', 'DriverDocuments/1767691341062.jpg', 'Nitesh ', 'Sharma ', '2001-01-01', NULL, NULL, 'DriverDocuments/1767691427852.jpg', 'DriverDocuments/1767691430978.jpg', 'Nitesh ', '2026-01-06', NULL, 'DriverDocuments/1767691580589.jpg', 'DriverDocuments/1767691582365.jpg', '496137593369', 'DriverDocuments/1767691582876.jpg', 'DriverDocuments/1767691583354.jpg', 'abddho', NULL, 'DriverDocuments/1767691644267.jpg', 'DriverDocuments/1767691648345.jpg', 'DriverDocuments/1767691649582.jpg', 'DriverDocuments/1767691650631.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-06 09:22:21', '2026-01-07 04:46:05', 'edfrgtyujy', 'dqefwtrhy', 1, NULL, 1, '26.9435053', '80.9405569', '3', NULL, NULL, NULL, NULL, NULL, 4.5, 'cabuser@gmail.com', 0, 0),
(59, 0.00, 0.00, 2, 2, 2, 2, 2, 2, 2, 'Car', '9856325641', 'DriverDocuments/1767694239880.jpg', 'Kumar', 'dog', '2000-01-14', NULL, NULL, 'DriverDocuments/1767694840895.jpg', 'DriverDocuments/1767694841352.jpg', 'gjfjrhfh', '2022-01-06', NULL, 'DriverDocuments/1767695719404.jpg', 'DriverDocuments/1767695720281.jpg', '989894545121', 'DriverDocuments/1767695720836.jpg', 'DriverDocuments/1767695721856.jpg', 'XDDDD33636', NULL, 'DriverDocuments/1767695833514.jpg', 'DriverDocuments/1767695833822.jpg', 'DriverDocuments/1767695834201.jpg', 'DriverDocuments/1767695834521.jpg', NULL, 'DriverDocuments/1767696399567.jpg', 'Beige', 'GF08QW1234', NULL, 'DriverDocuments/1767696680051.jpg', 'DriverDocuments/1767696680412.pdf', 'DriverDocuments/1767696683607.jpg', NULL, '2026-01-06 10:10:40', '2026-01-06 10:54:39', 'edfrgtyujy', 'dqefwtrhy', 1, NULL, 1, '28.6139', '77.2090', '2', 6, 3, 'WagonR', 'Maruti Suzuki', '2025', 4.5, 'cabuser@gmail.com', 0, 0);

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
(20, 'Advika ', 'Sharma ', 'asv@gmail.com', '6565265656', 'bfhfhd', 'JobFiles/1765003682207.jpg', 'JobFiles/1765003681959.jpg', 1, '[]', '2025-12-06 06:48:01', 0, 11, 'Agra', 1);

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
(5, 3, 'Dzire', 0, '2025-12-30 04:34:19'),
(6, 3, 'WagonR', 1, '2025-12-30 04:34:19'),
(7, 4, 'i10', 0, '2025-12-30 04:34:19'),
(8, 4, 'Aura', 0, '2025-12-30 04:34:19'),
(9, 5, 'CB Hornet', 0, '2025-12-30 04:34:35'),
(10, 5, 'Shine', 0, '2025-12-30 04:34:35'),
(11, 6, 'Pulsar 150', 0, '2025-12-30 04:34:35'),
(12, 6, 'Platina', 1, '2025-12-30 04:34:35');

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
(28, '8423953286', '1111', 1, '2026-01-08 16:54:08', '2026-01-08 16:52:08');

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
(1, NULL, 13, 100.00, '0% - ₹0.00', 100.00, 4, '1', 'ORD1767698579124', 1, 1, '2026-01-06 16:52:59', '2026-01-06 11:23:41'),
(2, 46, 13, 86.00, '6% - ₹5.16', 80.84, 1, '1', 'ORD1767698944793', 0, 2, '2026-01-06 16:59:04', '2026-01-06 16:59:04'),
(3, 46, NULL, 186.00, '5% - ₹9.30', 186.00, 2, NULL, NULL, 1, 2, '2026-01-06 16:59:52', '2026-01-06 16:59:52'),
(4, 50, 13, 187.00, '6% - ₹11.22', 175.78, 1, '1', 'ORD1767700115566', 1, 2, '2026-01-06 17:18:35', '2026-01-06 11:49:10'),
(5, 51, NULL, 185.00, '5% - ₹9.25', 185.00, 2, NULL, NULL, 1, 2, '2026-01-06 17:32:09', '2026-01-06 17:32:09'),
(6, 1, NULL, 185.00, '7% - ₹12.95', 185.00, 2, NULL, NULL, 1, 2, '2026-01-08 18:10:04', '2026-01-08 18:10:04'),
(7, 2, 13, 191.00, '6% - ₹11.46', 179.54, 1, '1', 'ORD1767932866702', 0, 2, '2026-01-09 09:57:46', '2026-01-09 09:57:46'),
(8, 4, 3, 161.00, '6% - ₹9.66', 151.34, 1, '1', 'ORD1768018832473', 1, 2, '2026-01-10 09:50:32', '2026-01-10 04:21:12'),
(9, 9, NULL, 185.00, '7% - ₹12.95', 185.00, 2, NULL, NULL, 1, 2, '2026-01-10 11:27:18', '2026-01-10 11:27:18'),
(10, 12, NULL, 128.00, '7% - ₹8.96', 128.00, 2, NULL, NULL, 1, 2, '2026-01-10 11:46:07', '2026-01-10 11:46:07'),
(11, 13, NULL, 185.00, '7% - ₹12.95', 185.00, 2, NULL, NULL, 1, 2, '2026-01-10 11:54:49', '2026-01-10 11:54:49'),
(12, 14, NULL, 149.00, '7% - ₹10.43', 149.00, 2, NULL, NULL, 1, 2, '2026-01-10 12:04:04', '2026-01-10 12:04:04'),
(13, 15, 3, 150.00, '6% - ₹9.00', 141.00, 1, '1', 'ORD1768027272212', 1, 2, '2026-01-10 12:11:12', '2026-01-10 06:41:48'),
(14, 17, NULL, 185.00, '7% - ₹12.95', 185.00, 2, NULL, NULL, 1, 2, '2026-01-10 12:17:00', '2026-01-10 12:17:00'),
(15, 13, NULL, 185.00, '7% - ₹12.95', 185.00, 2, NULL, NULL, 1, 2, '2026-01-10 13:27:53', '2026-01-10 13:27:53'),
(16, 23, NULL, 185.00, '7% - ₹12.95', 185.00, 2, NULL, NULL, 1, 2, '2026-01-10 16:11:35', '2026-01-10 16:11:35'),
(17, 2, NULL, 149.00, '7% - ₹10.43', 149.00, 2, NULL, NULL, 1, 2, '2026-01-10 17:45:25', '2026-01-10 17:45:25');

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
(10, 3, 1, '1/798, Sector H Road, Sector H, Jankipuram, Lucknow, Uttar Pradesh, India', 'vhhhf', '4', 'vhjjj', '2025-12-19 10:48:09', '26.919232342863356', '80.95782212913036');

-- --------------------------------------------------------

--
-- Table structure for table `scheduled_api_hits`
--

CREATE TABLE `scheduled_api_hits` (
  `id` int(11) NOT NULL,
  `hit_datetime` datetime NOT NULL,
  `is_done` tinyint(1) DEFAULT '0',
  `order_id` tinyint(4) DEFAULT NULL,
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
(49, '2026-01-11 17:25:00', 0, 4, '2026-01-10 11:53:32', 0),
(50, '2026-01-10 17:30:00', 1, 5, '2026-01-10 11:58:09', 1),
(51, '2026-01-10 17:42:00', 1, 1, '2026-01-10 12:09:52', 1);

-- --------------------------------------------------------

--
-- Table structure for table `serviceman`
--

CREATE TABLE `serviceman` (
  `id` int(11) NOT NULL,
  `wallet` double(10,2) DEFAULT '0.00',
  `mobile` bigint(12) DEFAULT NULL,
  `due_wallet` double(10,2) DEFAULT '0.00',
  `first_name` varchar(255) DEFAULT NULL,
  `reject_reasion` varchar(255) DEFAULT NULL,
  `online_status` tinyint(4) NOT NULL DEFAULT '1',
  `last_name` varchar(255) DEFAULT NULL,
  `form_status` tinyint(4) NOT NULL DEFAULT '0',
  `fcm_token` varchar(255) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `service_category` int(5) DEFAULT NULL,
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
  `gender` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `serviceman`
--

INSERT INTO `serviceman` (`id`, `wallet`, `mobile`, `due_wallet`, `first_name`, `reject_reasion`, `online_status`, `last_name`, `form_status`, `fcm_token`, `email`, `address`, `service_category`, `aadhaar_front`, `aadhaar_back`, `skill_status`, `experience_certificate`, `device_id`, `login_status`, `created_at`, `updated_at`, `current_latitude`, `current_longitude`, `profile_photo`, `gender`) VALUES
(1, 19294.35, 9876543211, 400.54, 'ramu', 'qAEWTGHJI', 1, 'sharmaa', 1, 'd-avi56-Qqe7j4-YPuJ8LB:APA91bF3wjrCUD_Tl4aF8bM-PJLI1sRXmU9aTa9wSH8vpj4dMikSYedrXFGEP5MO0k-fgocSsTeZ3dT0dI905xNAAYMcgtftwueTzRIGZVtNQlx0lU4eeyA', 'ramu@gmail.com', 'lucknow', 2, 'ServicemanFiles/1765258792177.jpeg', 'ServicemanFiles/1765258792254.jpeg', 1, NULL, 'fvgbhnj', 1, '2025-12-09 05:39:52', '2026-01-08 06:35:31', '26.9435041', '80.9405417', 'ServicemanFiles/1765451127949.jpg', NULL),
(2, 300.00, 8423953287, 50.00, 'ramu', 'AsdZFCGNK', 1, 'sharma', 0, 'abc_fcm', 'ramus@gmail.com', 'lucknow', 1, 'ServicemanFiles/1765258880379.jpeg', 'ServicemanFiles/1765258880475.jpeg', 1, NULL, 'asdfcghjkl', 0, '2025-12-09 05:41:20', '2025-12-09 05:41:20', NULL, NULL, NULL, NULL),
(3, 0.00, 8423953288, 0.00, 'ramu', NULL, 1, 'sharma', 1, 'abc_fcm', 'ramus@gmail.com', 'lucknow', 1, 'ServicemanFiles/1765259068213.jpeg', 'ServicemanFiles/1765259068301.jpeg', 1, NULL, 'asdfcghjkl', 0, '2025-12-09 05:44:28', '2025-12-09 05:44:28', NULL, NULL, NULL, NULL),
(4, 1132.80, 8888888888, 56.64, 'ramu', NULL, 1, 'sharma', 1, 'd1uVSDquQKCh6RhAb66BlV:APA91bEn0inBi4IFGG15w2-6-ZGgdcALmuzPJ49oDcgLJNFADMjsmBayJa5pRsQtDlVpzIjIcCP_hi3V57BuQ9S2NqMNxxqiJXp6GtvMyMYA8agkmt2FiWY', 'ramus@gmail.com', 'lucknow', 2, 'ServicemanFiles/1765259072891.jpeg', 'ServicemanFiles/1765259072991.jpeg', 1, NULL, 'fvgbhnj', 1, '2025-12-09 05:44:32', '2025-12-24 11:39:03', '26.9435', '80.9404747', NULL, NULL),
(5, 0.00, 8423953210, 0.00, 'ramu', NULL, 0, 'sharma', 0, 'abc_fcm', 'ramus@gmail.com', 'lucknow', 1, 'ServicemanFiles/1765259075800.jpeg', 'ServicemanFiles/1765259075897.jpeg', 1, NULL, 'asdfcghjkl', 0, '2025-12-09 05:44:35', '2025-12-12 06:05:43', NULL, NULL, NULL, NULL),
(20, 0.00, 9565545464, 0.00, 'Tanisha ', NULL, 1, 'sharma ', 0, 'fcm_123', 'vhvy@gmail.com', 'Lucknow Uttar Pradesh India ', 1, 'ServicemanFiles/1765533195480.jpg', 'ServicemanFiles/1765533195683.jpg', 1, NULL, 'device_123', 0, '2025-12-12 15:23:16', '2025-12-12 15:23:16', '26.90', '80.94', 'ServicemanFiles/1765533195791.heic', 'Female'),
(21, 0.00, 9646486446, 0.00, 'Ramu', NULL, 1, 'jiii', 0, 'fcm_123', 'ratgggmu@gmail.com', 'Lucknow to nh ', 1, 'ServicemanFiles/1765533707453.jpg', 'ServicemanFiles/1765533707649.heic', 1, NULL, 'device_123', 0, '2025-12-12 15:31:48', '2025-12-12 15:31:48', '26.90', '80.94', 'ServicemanFiles/1765533708351.jpg', 'Female'),
(22, 0.00, 9856565656, 0.00, 'pjsh', NULL, 1, 'dhhdus', 0, 'fcm_123', 'xndh@gmail.com', 'luckn ', 1, 'ServicemanFiles/1765533998633.jpg', 'ServicemanFiles/1765533998828.jpg', 1, NULL, 'device_123', 0, '2025-12-12 15:36:38', '2025-12-12 15:36:38', '26.90', '80.94', 'ServicemanFiles/1765533998929.jpg', 'Female'),
(23, 0.00, 9598199932, 0.00, 'Abhishek ', NULL, 1, 'sharma ', 0, 'dgxbz8bnQJyaUHLFpo3fKE:APA91bEuunKDnYEAJsScxce-qCfct33StIBetF-uY3Las9T-dWOc-6WhNw5aKxMs824WNgMyNjhz9w7k_SkH96iParkWCmPqt2rV_2MV0BqhV8hvtE_wCZE', 'niranjan7sharma@gmail.com', 'Vistar Yojna, Jankipuram, Lucknow, Uttar Pradesh, 226031', 2, 'ServicemanFiles/1765859372599.jpg', 'ServicemanFiles/1765859376686.jpg', 1, NULL, 'RKQ1.201004.002', 0, '2025-12-16 09:59:51', '2025-12-16 04:35:39', '26.9125', '75.7875', 'ServicemanFiles/1765859383442.jpg', 'Male'),
(24, 559.38, 7570006440, 206.08, 'vishal', NULL, 1, 'mishra ', 0, 'eHsIrpdbQJ6hUzF85KOZUF:APA91bFg-sF0cqU1ivMALFY4MrYsv3cpj7BpopfiywovdjFnREwzIBLPO_nXh5hXxAeI7RhfsF_t5TfEBpX6zu5G5VK6T_dLf3fggfWCHGv6e0nZPrESnfU', 'vishal@gmail.com', 'Vistar Yojna, Jankipuram, Lucknow, Uttar Pradesh, 226031', 2, 'ServicemanFiles/1766053441691.jpg', 'ServicemanFiles/1766053442454.jpg', 1, NULL, 'RKQ1.201004.002', 0, '2025-12-18 15:54:03', '2025-12-18 12:19:41', '26.9435853', '80.9405951', 'ServicemanFiles/1766053442893.jpg', 'Male'),
(25, 0.00, 7235947667, 0.00, 'Tanisha ', NULL, 1, 'Sharma', 0, 'cSwMsPyQQF2rI8hYOD9aBp:APA91bEyOpATUFbjQuOYQygdFQ7-xkcqWBUpv1N2LoGQ2y1xSQzbes9j5eJ26MdUuIrlvHqNH9oUTCKUdiSxHMaf4RQ2jG6SlgziWyVedF5W0BgyrgmuWB0', 'tanu@gmail.com', '1/613, Jankipuram Extension, Mirzapur, Uttar Pradesh, 226031', 2, 'ServicemanFiles/1766075786961.jpg', 'ServicemanFiles/1766075787255.jpg', 1, NULL, 'RP1A.200720.011', 0, '2025-12-18 22:06:28', '2025-12-19 10:24:41', '26.9435808', '80.9405654', 'ServicemanFiles/1766075787685.jpg', 'Female'),
(26, 0.00, 9695782867, 0.00, 'Akansha ', NULL, 1, 'Singh ', 0, 'egYNYbdsSsyVTXaY1i8OBZ:APA91bEMk2mLEHw1FtygOMK9le0HBjQuO-EHEloSWWPBHfQnLh-kddu3cYH7cAAwdvbv8YD5ohGT6dWp1I9ZuuVnA6qPPVwlpIIrh3PaLsnoUvqZUo47tIM', 'akansha@gmail.com', 'Vistar Yojna, Jankipuram, Lucknow, Uttar Pradesh, 226031', 2, 'ServicemanFiles/1766488379151.jpg', 'ServicemanFiles/1766488380476.jpg', 1, NULL, 'RP1A.200720.011', 0, '2025-12-23 16:43:01', '2025-12-23 16:43:01', '26.9435622', '80.940582', 'ServicemanFiles/1766488380832.jpg', 'Male'),
(27, 0.00, 8741257875, 0.00, 'Kritika ', NULL, 1, 'Sharma', 0, 'fJrITCx4SY2IEFBJdsRcCE:APA91bHGOOAjrJWoZA4Qc6D28o39eFzVZbvdhXmdsIeXgHwJODTrF1P0KMAnRcgibQVkoLywNebibfZ32HLWUE5lTU4cn6CqHpevx4Cf_D0ctsOPM-gxXxM', 'kriti@gmail.com', 'Vistar Yojna, Jankipuram, Lucknow, Uttar Pradesh, 226031', 2, 'ServicemanFiles/1766488819052.jpg', 'ServicemanFiles/1766488819576.jpg', 1, NULL, 'RP1A.200720.011', 0, '2025-12-23 16:50:20', '2025-12-23 16:50:20', '26.943577', '80.9405525', 'ServicemanFiles/1766488819932.jpg', 'Male'),
(28, 0.00, 9662565956, 0.00, 'helo', NULL, 1, 'hol', 0, 'ca4wpfOJSJiWKO6p5IkVXV:APA91bFX3NbxguhSO6ie5wcPwqlCEmnhXk8nqc78JH-XaOGt2p7GJjqJVvzDGbu-KQbxmvkQ8kEr5H4FCHX_-8PRLFiMqMeWL5_eJul_z6d-NWTr4o9flvg', 'helo@gmail.com', 'Vistar Yojna, Jankipuram, Lucknow, Uttar Pradesh, 226031', 2, 'ServicemanFiles/1766489792038.jpg', 'ServicemanFiles/1766489792663.jpg', 1, NULL, 'RP1A.200720.011', 1, '2025-12-23 17:06:33', '2025-12-23 11:36:36', '26.9435686', '80.9405798', 'ServicemanFiles/1766489793091.jpg', 'Male'),
(29, 0.00, 8454512252, 0.00, 'girsl', NULL, 1, 'hukil', 0, 'ca4wpfOJSJiWKO6p5IkVXV:APA91bFX3NbxguhSO6ie5wcPwqlCEmnhXk8nqc78JH-XaOGt2p7GJjqJVvzDGbu-KQbxmvkQ8kEr5H4FCHX_-8PRLFiMqMeWL5_eJul_z6d-NWTr4o9flvg', 'girl@gmail.com', 'Vistar Yojna, Jankipuram, Lucknow, Uttar Pradesh, 226031', 2, 'ServicemanFiles/1766490041661.jpg', 'ServicemanFiles/1766490042386.jpg', 1, NULL, 'RP1A.200720.011', 1, '2025-12-23 17:10:43', '2025-12-23 17:10:43', '26.9435692', '80.9405641', 'ServicemanFiles/1766490042787.jpg', 'Male'),
(30, 0.00, 9632655421, 0.00, 'Kunal', NULL, 1, 'Singh ', 0, 'ca4wpfOJSJiWKO6p5IkVXV:APA91bFX3NbxguhSO6ie5wcPwqlCEmnhXk8nqc78JH-XaOGt2p7GJjqJVvzDGbu-KQbxmvkQ8kEr5H4FCHX_-8PRLFiMqMeWL5_eJul_z6d-NWTr4o9flvg', 'kunal@gmail.com', 'Vistar Yojna, Jankipuram, Lucknow, Uttar Pradesh, 226031', 1, 'ServicemanFiles/1766490405119.jpg', 'ServicemanFiles/1766490405596.jpg', 1, NULL, 'RP1A.200720.011', 1, '2025-12-23 17:16:46', '2025-12-23 11:53:22', '26.9435688', '80.9405803', 'ServicemanFiles/1766490406123.jpg', 'Male');

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
(6, 2, 4, 'AC Gas Refilling', 'Premium AC gas refill with leak check.', 'serviceImage/acgas.jpg', 1200.00, 4.6, '[\n  {\n    \"id\": 1,\n    \"question\": \"Is servicing required every year?\",\n    \"answer\": \"Yes, yearly service improves cooling and increases AC life.\"\n  },\n  {\n    \"id\": 2,\n    \"question\": \"How much time does it take?\",\n    \"answer\": \"Usually 45 minutes to 1 hour.\"\n  }\n]\n', 1, '2025-12-06 09:54:39', 0);

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
  `description` varchar(255) DEFAULT NULL,
  `rating` tinyint(4) DEFAULT NULL,
  `distance` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `service_order`
--

INSERT INTO `service_order` (`id`, `service_address`, `service_latitude`, `service_longitude`, `user_id`, `user_name`, `user_mobile`, `serviceman_id`, `serviceman_name`, `serviceman_mobile`, `amount`, `coupon_discount`, `gst_charges`, `final_amount`, `payment_status`, `service_status`, `service_id`, `service_name`, `pay_mode`, `coupon_id`, `available_service_man`, `service_datetime`, `updated_at`, `created_at`, `quantity`, `cancel_reason`, `orderOtp`, `description`, `rating`, `distance`) VALUES
(1, '123 MG Road, Lucknow', '26.942676', '80.938179', 1, 'Tanisha Sharma ', '7235947667', 4, 'ramu sharma', '8888888888', 100.00, 50.00, 81.00, 100.00, 0, 6, 5, 'AC Deep Cleaning', 3, 3, '[4,1]', '2025-12-20 19:35:00', '2025-12-18 22:02:35', '2025-12-18 22:02:35', 1, 'hchfhf', '1248', 'new testing', NULL, 0.24),
(2, '123 MG Road, Lucknow', '26.942676', '80.938179', 1, 'Tanisha Sharma ', '7235947667', 1, 'ramu sharmaa', '8423953286', 100.00, 50.00, 81.00, 100.00, 0, 1, 5, 'AC Deep Cleaning', 3, 3, '[4,1]', '2025-12-20 19:35:00', '2025-12-18 22:03:03', '2025-12-18 22:03:03', 1, NULL, '3144', 'new testing', NULL, 0.39),
(3, '1/613, Jankipuram Extension, Mirzapur, 226031', '26.9474843', '80.9388218', 3, 'pankaj ji', '7258836052', 25, 'Tanisha  Sharma', '7235947667', 499.00, 0.00, 89.82, 588.82, 0, 6, 1, 'AC Cooling Service', 2, NULL, '[1,4]', '2025-12-19 22:31:00', '2025-12-18 22:32:07', '2025-12-18 22:32:07', 1, 'ggggh', '2237', '', NULL, 0.02),
(4, '3/56 KWA, 1/798, Sector H Road, Sector H, Jankipuram, Lucknow, Uttar Pradesh, India, Near Near neem park, Floor: 2', '26.919232342863356', '80.95782212913036', 3, 'pankaj ji', '7258836052', NULL, NULL, NULL, 499.00, 0.00, 89.82, 588.82, 0, 0, 1, 'AC Cooling Service', 2, NULL, '[4,1]', '2025-12-20 15:15:00', '2025-12-19 13:58:08', '2025-12-19 13:58:08', 1, NULL, '2332', 'bcncngn', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `value` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `name`, `value`, `created_at`, `updated_at`) VALUES
(1, 'service_radius_km', '1000', '2025-12-09 09:48:28', '2026-01-08 08:05:18'),
(2, 'platform_fee', '7', '2025-12-09 09:48:28', '2026-01-08 09:19:17'),
(3, 'due_limit', '100', '2025-12-09 09:48:28', '2025-12-17 11:53:39'),
(4, 'cab_platform_fee', '6', '2025-12-09 09:48:28', '2026-01-02 09:41:44'),
(5, 'driver_due_limit', '200', '2025-12-09 09:48:28', '2026-01-08 06:48:30');

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
(47, 9, 'antim sansakar', 'subcategories/1765197145704.png', 1, '2025-12-08 12:32:25');

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
(1, 600.00, 'Tanisha Sharma ', NULL, NULL, 7235947667, 1, 'ServicemanFiles/1765451127949.jpg', NULL, 'eoxUxobiQ-OJXTruVTTe2s:APA91bHguJPQKINGsjP6Oge4zOIofbcizdKEWvd9TgKKWql_VcyhPffoDqHSzhT96QXCu8pF0Lm5LUqEzCBUXnF1k97p74jjDaaFRg8SNJm1W-JJ29aA5N0', 'RKQ1.201004.002', '2025-12-26 11:04:11', '2025-12-16 07:15:55', NULL),
(2, 300.00, 'harsh', NULL, NULL, 9793168164, 1, 'ServicemanFiles/1765451127949.jpg', NULL, 'eoxUxobiQ-OJXTruVTTe2s:APA91bHguJPQKINGsjP6Oge4zOIofbcizdKEWvd9TgKKWql_VcyhPffoDqHSzhT96QXCu8pF0Lm5LUqEzCBUXnF1k97p74jjDaaFRg8SNJm1W-JJ29aA5N0', 'RKQ1.201004.002', '2025-12-19 03:41:32', '2025-12-17 04:02:41', NULL),
(3, 5000.00, 'pankaj ji', NULL, NULL, 9876543210, 1, NULL, NULL, 'fBnb0DgRSK67yy2vrKQtq1:APA91bFMQ9gC6xaSWy9cXFTHXJ6Z9w-QsdsaeOBp_OQYuLvdRrbhpyhe8PtP_ICF-2tm4wyHIHyOrgIr3DJWrROyZSp-gFTSiBLSIF15Da3pEcBI9ib7qo0', 'RP1A.200720.011', '2026-01-10 07:47:35', '2025-12-18 10:22:32', NULL),
(4, 0.00, 'Ramu ', 'Sharma ', 'ramusharmagr@gmail.com', 8423953286, 1, 'UserprofileImage/1767160319646.jpg', 'Lucknow', 'eoxUxobiQ-OJXTruVTTe2s:APA91bHguJPQKINGsjP6Oge4zOIofbcizdKEWvd9TgKKWql_VcyhPffoDqHSzhT96QXCu8pF0Lm5LUqEzCBUXnF1k97p74jjDaaFRg8SNJm1W-JJ29aA5N0', 'RKQ1.201004.002', '2025-12-31 05:51:59', '2025-12-31 05:50:57', NULL),
(5, 0.00, 'lulu', NULL, NULL, 8547855558, 1, NULL, NULL, 'dp6PMgjHTXCJqrjRq7_IYF:APA91bH8c90l8Immsbb2-UAyRitr1Jwmhq9eXnbuYRVKQy2ZfZCpVsGr_g7jet5ODRxu-qchECOhDEgJC8PQC6uv2c-qwteor5JX6s9MioIkDQ8D2TMesQ8', 'UKQ1.230924.001', '2026-01-05 16:53:15', '2026-01-05 16:53:15', NULL),
(6, 0.00, 'gdgdgdh', NULL, NULL, 5989898595, 1, NULL, NULL, 'dp6PMgjHTXCJqrjRq7_IYF:APA91bH8c90l8Immsbb2-UAyRitr1Jwmhq9eXnbuYRVKQy2ZfZCpVsGr_g7jet5ODRxu-qchECOhDEgJC8PQC6uv2c-qwteor5JX6s9MioIkDQ8D2TMesQ8', 'UKQ1.230924.001', '2026-01-05 16:53:48', '2026-01-05 16:53:48', NULL),
(7, 0.00, 'fhrhdh', NULL, NULL, 6955885558, 1, NULL, NULL, 'dp6PMgjHTXCJqrjRq7_IYF:APA91bH8c90l8Immsbb2-UAyRitr1Jwmhq9eXnbuYRVKQy2ZfZCpVsGr_g7jet5ODRxu-qchECOhDEgJC8PQC6uv2c-qwteor5JX6s9MioIkDQ8D2TMesQ8', 'UKQ1.230924.001', '2026-01-05 16:54:41', '2026-01-05 16:54:41', NULL),
(8, 0.00, 'ngfhrh', NULL, NULL, 5578485856, 1, NULL, NULL, 'dp6PMgjHTXCJqrjRq7_IYF:APA91bH8c90l8Immsbb2-UAyRitr1Jwmhq9eXnbuYRVKQy2ZfZCpVsGr_g7jet5ODRxu-qchECOhDEgJC8PQC6uv2c-qwteor5JX6s9MioIkDQ8D2TMesQ8', 'UKQ1.230924.001', '2026-01-05 16:55:04', '2026-01-05 16:55:04', NULL),
(9, 0.00, 'xvxhxgd', NULL, NULL, 8989565654, 1, NULL, NULL, 'dp6PMgjHTXCJqrjRq7_IYF:APA91bH8c90l8Immsbb2-UAyRitr1Jwmhq9eXnbuYRVKQy2ZfZCpVsGr_g7jet5ODRxu-qchECOhDEgJC8PQC6uv2c-qwteor5JX6s9MioIkDQ8D2TMesQ8', 'UKQ1.230924.001', '2026-01-05 16:57:04', '2026-01-05 16:57:04', NULL),
(10, 0.00, 'fhfhd', NULL, NULL, 9565655656, 1, NULL, NULL, 'dp6PMgjHTXCJqrjRq7_IYF:APA91bH8c90l8Immsbb2-UAyRitr1Jwmhq9eXnbuYRVKQy2ZfZCpVsGr_g7jet5ODRxu-qchECOhDEgJC8PQC6uv2c-qwteor5JX6s9MioIkDQ8D2TMesQ8', 'UKQ1.230924.001', '2026-01-05 16:57:34', '2026-01-05 16:57:34', NULL),
(11, 0.00, 'fjfjfj', NULL, NULL, 9895653232, 1, NULL, NULL, 'dp6PMgjHTXCJqrjRq7_IYF:APA91bH8c90l8Immsbb2-UAyRitr1Jwmhq9eXnbuYRVKQy2ZfZCpVsGr_g7jet5ODRxu-qchECOhDEgJC8PQC6uv2c-qwteor5JX6s9MioIkDQ8D2TMesQ8', 'UKQ1.230924.001', '2026-01-05 16:58:22', '2026-01-05 16:58:22', NULL),
(12, 0.00, 'bvvv', NULL, NULL, 1111111111, 1, NULL, NULL, 'dp6PMgjHTXCJqrjRq7_IYF:APA91bH8c90l8Immsbb2-UAyRitr1Jwmhq9eXnbuYRVKQy2ZfZCpVsGr_g7jet5ODRxu-qchECOhDEgJC8PQC6uv2c-qwteor5JX6s9MioIkDQ8D2TMesQ8', 'UKQ1.230924.001', '2026-01-05 17:01:31', '2026-01-05 17:01:31', NULL),
(13, 0.00, 'dhdhdhhd', NULL, NULL, 8454664645, 1, NULL, NULL, 'eoxUxobiQ-OJXTruVTTe2s:APA91bHguJPQKINGsjP6Oge4zOIofbcizdKEWvd9TgKKWql_VcyhPffoDqHSzhT96QXCu8pF0Lm5LUqEzCBUXnF1k97p74jjDaaFRg8SNJm1W-JJ29aA5N0', 'RKQ1.201004.002', '2026-01-06 09:17:57', '2026-01-06 09:17:57', NULL);

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

INSERT INTO `vehicle` (`id`, `name`, `max_passenger`, `image`, `register_status`, `visible_status`, `created_at`, `discount`, `driver_can_discount`, `user_increase`) VALUES
(1, 'Auto', 3, 'cabbooking/vehicle_image/auto.png', 1, 1, '2025-12-30 04:32:52', 10, 5, 15),
(2, 'Car', 4, 'cabbooking/vehicle_image/black_car.png', 1, 1, '2025-12-30 04:32:52', 10, 5, 15),
(3, 'Bike', 1, 'cabbooking/vehicle_image/1767075817934.png', 1, 1, '2025-12-30 04:32:52', 5, 5, 5);

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_charges`
--

CREATE TABLE `vehicle_charges` (
  `id` bigint(20) NOT NULL,
  `vehicle_id` bigint(20) NOT NULL,
  `from_km` decimal(5,2) NOT NULL,
  `to_km` decimal(5,2) NOT NULL,
  `rate_per_km` decimal(6,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `vehicle_charges`
--

INSERT INTO `vehicle_charges` (`id`, `vehicle_id`, `from_km`, `to_km`, `rate_per_km`, `created_at`, `updated_at`) VALUES
(19, 3, 0.00, 5.00, 20.00, '2025-12-31 04:10:41', '2025-12-31 04:10:41'),
(20, 2, 0.00, 5.00, 50.00, '2025-12-31 04:13:37', '2025-12-31 04:13:37'),
(21, 1, 0.00, 5.00, 25.00, '2025-12-31 04:13:54', '2025-12-31 04:13:54'),
(22, 3, 5.00, 20.00, 15.00, '2025-12-31 04:14:59', '2025-12-31 04:14:59'),
(23, 2, 5.00, 15.00, 30.00, '2025-12-31 04:15:22', '2025-12-31 04:15:22'),
(24, 1, 5.00, 15.00, 20.00, '2025-12-31 04:18:03', '2025-12-31 04:18:03'),
(25, 3, 20.00, 30.00, 17.00, '2026-01-05 12:36:17', '2026-01-05 12:36:17');

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
(24, 19, 3, 10.00, 2, 'Please provide correct bank details, Please provide correct bank details , Please provide correct bank details Please provide correct bank details, Please provide correct bank details , Please provide correct bank details', 'IH4931185491', '2026-01-10 08:20:48', '2026-01-10 09:53:55');

-- --------------------------------------------------------

--
-- Table structure for table `zones`
--

CREATE TABLE `zones` (
  `id` int(11) NOT NULL,
  `zone_name` varchar(255) NOT NULL,
  `coordinates` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `zones`
--

INSERT INTO `zones` (`id`, `zone_name`, `coordinates`, `created_at`) VALUES
(10, 'Lucknow', '[{\"lat\":27.135227308507975,\"lng\":80.86403140692859},{\"lat\":27.010499970861403,\"lng\":80.67177066474109},{\"lat\":26.841530753080114,\"lng\":80.63881168036609},{\"lat\":26.704210612140216,\"lng\":80.70198306708484},{\"lat\":26.64285342571791,\"lng\":80.82008609442859},{\"lat\":26.645308346790785,\"lng\":81.05629214911609},{\"lat\":26.809667667475395,\"lng\":81.18812808661609},{\"lat\":26.90033135425287,\"lng\":81.25953921942859},{\"lat\":27.04230638955457,\"lng\":81.23756656317859},{\"lat\":27.118116090093206,\"lng\":81.11671695380359},{\"lat\":27.152335908328087,\"lng\":80.91896304755359}]', '2025-12-21 09:46:37');

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
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `bank_details_update_requests`
--
ALTER TABLE `bank_details_update_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `brand`
--
ALTER TABLE `brand`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `cab_cancel_reasons`
--
ALTER TABLE `cab_cancel_reasons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `cab_orders`
--
ALTER TABLE `cab_orders`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `driver_online_logs`
--
ALTER TABLE `driver_online_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `driver_registration`
--
ALTER TABLE `driver_registration`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `job_request`
--
ALTER TABLE `job_request`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `otp_counter`
--
ALTER TABLE `otp_counter`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `otp_logs`
--
ALTER TABLE `otp_logs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `paying`
--
ALTER TABLE `paying`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `rating_history`
--
ALTER TABLE `rating_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `saved_address`
--
ALTER TABLE `saved_address`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `scheduled_api_hits`
--
ALTER TABLE `scheduled_api_hits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `serviceman`
--
ALTER TABLE `serviceman`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `serviceman_ratings`
--
ALTER TABLE `serviceman_ratings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `service_order`
--
ALTER TABLE `service_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `subcategories`
--
ALTER TABLE `subcategories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `top_service`
--
ALTER TABLE `top_service`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(55) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `vehicle_charges`
--
ALTER TABLE `vehicle_charges`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `vehicle_driver_discount_slabs`
--
ALTER TABLE `vehicle_driver_discount_slabs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `withdraw_service`
--
ALTER TABLE `withdraw_service`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `zones`
--
ALTER TABLE `zones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

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
