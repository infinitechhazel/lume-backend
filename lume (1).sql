-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 07, 2026 at 01:22 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lume`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `street` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postal_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`id`, `user_id`, `street`, `city`, `state`, `postal_code`, `country`, `is_default`, `created_at`, `updated_at`) VALUES
(1, 3, '23', 'fsdf', 'sdfd', '1232', 'ewfes', 0, '2026-04-01 00:54:28', '2026-04-05 21:55:41'),
(2, 3, 'sac', 'sax', 'sa', '123', 'asdas', 1, '2026-04-01 01:27:18', '2026-04-05 21:55:41');

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE `announcements` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `announcements`
--

INSERT INTO `announcements` (`id`, `title`, `content`, `is_active`, `created_at`, `updated_at`) VALUES
(3, 'dasdsad', 'dasdasdsa', 1, '2026-04-05 17:27:29', '2026-04-05 17:27:29');

-- --------------------------------------------------------

--
-- Table structure for table `blog_posts`
--

CREATE TABLE `blog_posts` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `excerpt` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `author` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `blog_posts`
--

INSERT INTO `blog_posts` (`id`, `title`, `excerpt`, `content`, `author`, `image_url`, `created_at`, `updated_at`) VALUES
(1, 'asd', 'adasd', 'asdasd', 'das', NULL, '2026-04-05 17:29:31', '2026-04-05 17:29:31'),
(2, 'asd', 'ads', 'das', 'asd', NULL, '2026-04-05 17:30:43', '2026-04-05 17:30:43'),
(3, 'fds', 'dsf', 'dfs', 'fds', '/images/blog/1775440563_24.png', '2026-04-05 17:32:13', '2026-04-05 17:56:03'),
(4, 'dasdasd', 'sadasd', 'asdas', 'asdasd', '/images/blog/1775439416_WHOLE_LOVE_LOGO.png', '2026-04-05 17:36:56', '2026-04-05 17:36:56'),
(5, 'Post 1', '12', 'fdf', 'we', '/images/blog/1775440548_WHOLE_LOVE_LOGO.png', '2026-04-05 17:46:24', '2026-04-05 17:55:48');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel-cache-5c785c036466adea360111aa28563bfd556b5fba', 'i:1;', 1775524142),
('laravel-cache-5c785c036466adea360111aa28563bfd556b5fba:timer', 'i:1775524142;', 1775524142);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chefs`
--

CREATE TABLE `chefs` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `specialty` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `experience_years` int NOT NULL,
  `bio` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rating` decimal(3,2) NOT NULL DEFAULT '5.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `capacity` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('upcoming','ongoing','completed','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'upcoming',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_09_05_053654_create_contacts_table', 1),
(5, '2025_09_05_061801_create_personal_access_tokens_table', 1),
(6, '2025_09_05_063626_create_orders_table', 1),
(7, '2025_09_05_063635_create_order_items_table', 1),
(8, '2025_09_08_000117_create_products_table', 1),
(9, '2025_09_08_012156_update_price_column_in_products_table', 1),
(10, '2025_09_08_052346_add_is_featured_to_products_table', 1),
(11, '2025_10_20_033333_create_blog_posts_table', 1),
(12, '2025_10_20_033340_create_reservations_table', 1),
(13, '2025_10_20_035724_create_events_table', 1),
(14, '2025_10_20_035728_create_chefs_table', 1),
(15, '2025_10_20_035740_create_promos_table', 1),
(16, '2025_10_20_051622_create_testimonials_table', 1),
(17, '2025_10_20_052520_create_announcements_table', 1),
(18, '2025_10_20_054848_add_user_id_to_reservations_table', 1),
(19, '2025_10_20_065100_add_user_id_to_events_table', 1),
(20, '2025_11_17_021052_fix_reservations_time_column', 1),
(21, '2025_11_17_024759_add_is_walkin_to_reservations_table', 1),
(22, '2025_11_17_045908_add_reservation_fee_to_reservations_table', 1),
(23, '2026_04_01_080832_create_addresses_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `order_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `delivery_fee` decimal(8,2) NOT NULL,
  `payment_method` enum('cash','gcash','paypal','bpi','maya') COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_status` enum('pending','paid','failed','refunded') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `order_status` enum('pending','confirmed','preparing','ready','out_for_delivery','delivered','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `delivery_address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `delivery_city` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `delivery_zip_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `receipt_file` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `delivered_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `order_number`, `total_amount`, `delivery_fee`, `payment_method`, `payment_status`, `order_status`, `delivery_address`, `delivery_city`, `delivery_zip_code`, `customer_name`, `customer_email`, `customer_phone`, `receipt_file`, `notes`, `delivered_at`, `created_at`, `updated_at`) VALUES
(3, 3, 'ORD-1775033690400', '34.00', '0.00', 'cash', 'pending', 'preparing', 'dsadsad', 'dsad', '2121', 'Hazel Admin', 'hazelannemendoza321@gmail.com', '09124435435', NULL, NULL, NULL, '2026-04-01 00:54:50', '2026-04-01 00:54:50'),
(4, 3, 'ORD-1775035623156', '22.00', '0.00', 'cash', 'pending', 'cancelled', '23', 'fsdf', '1232', 'Hazel Admin', 'hazelannemendoza321@gmail.com', '09124435435', NULL, NULL, NULL, '2026-04-01 01:27:03', '2026-04-05 22:43:46'),
(8, 4, 'ORD-1775457072452', '88.00', '0.00', 'cash', 'pending', 'pending', 'sasas', 'sasasasasasasa', '123', 'Hazel Anne Mendoza', 'hazel.mendoza1@gmail.com', '09943400836', NULL, NULL, NULL, '2026-04-05 22:31:12', '2026-04-05 22:31:12'),
(9, 2, 'ORD-1775457706918', '67.00', '0.00', 'gcash', 'pending', 'pending', 'sasas', 'sasasasasasasa', '123', 'Hazel Mendoza', 'infinitech.hazel@gmail.com', '09124435435', 'receipts/receipt_1775457706_2.png', NULL, NULL, '2026-04-05 22:41:46', '2026-04-05 22:41:46'),
(10, 3, 'ORD-1775458243988', '11.00', '0.00', 'cash', 'pending', 'pending', 'sac', 'sax', '123', 'Hazel Admin', 'hazelannemendoza321@gmail.com', '12345678901', NULL, NULL, NULL, '2026-04-05 22:50:43', '2026-04-05 22:50:43');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint UNSIGNED NOT NULL,
  `order_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `price` decimal(8,2) NOT NULL,
  `quantity` int NOT NULL,
  `category` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_spicy` tinyint(1) NOT NULL DEFAULT '0',
  `is_vegetarian` tinyint(1) NOT NULL DEFAULT '0',
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subtotal` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `name`, `description`, `price`, `quantity`, `category`, `is_spicy`, `is_vegetarian`, `image_url`, `subtotal`, `created_at`, `updated_at`) VALUES
(5, 3, 'fd', 'gfv', '34.00', 1, 'Noodles', 0, 0, '1775032778_2HHzqXWMD4.png', '34.00', '2026-04-01 00:54:50', '2026-04-01 00:54:50'),
(6, 4, 'Hazel Admin', 'sfdffdd', '11.00', 2, 'Appetizers', 0, 0, '1775032755_HkMuMJl624.png', '22.00', '2026-04-01 01:27:03', '2026-04-01 01:27:03'),
(11, 8, 'Hazel Admin', 'sfdffdd', '11.00', 8, 'Appetizers', 0, 0, '1775032755_HkMuMJl624.png', '88.00', '2026-04-05 22:31:12', '2026-04-05 22:31:12'),
(12, 9, 'Hazel Admin', 'sfdffdd', '11.00', 3, 'coffee', 0, 0, '1775032755_HkMuMJl624.png', '33.00', '2026-04-05 22:41:46', '2026-04-05 22:41:46'),
(13, 9, 'Product 2', 'gfv', '34.00', 1, 'food', 0, 0, '1775032778_2HHzqXWMD4.png', '34.00', '2026-04-05 22:41:46', '2026-04-05 22:41:46'),
(14, 10, 'Hazel Admin', 'sfdffdd', '11.00', 1, 'coffee', 0, 0, '1775032755_HkMuMJl624.png', '11.00', '2026-04-05 22:50:43', '2026-04-05 22:50:43');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 3, 'auth_token', '32b751312ea1631a5892f6dfe8faa28e468fd1f937388a51e72ff4bab6934f62', '[\"*\"]', '2026-04-01 00:37:33', NULL, '2026-04-01 00:37:14', '2026-04-01 00:37:33'),
(2, 'App\\Models\\User', 2, 'auth_token', '77ba8277c90a3a736404fc923516aee53a63e1d8fa6008cc27a9bcab83c76e53', '[\"*\"]', NULL, NULL, '2026-04-01 00:38:49', '2026-04-01 00:38:49'),
(3, 'App\\Models\\User', 3, 'auth_token', 'ab120f77999414bc989cc0ca19c7ed79e7d45fb62e8adc30c873e0229317b62a', '[\"*\"]', '2026-04-05 17:13:07', NULL, '2026-04-01 00:39:49', '2026-04-05 17:13:07'),
(4, 'App\\Models\\User', 2, 'auth_token', 'fb411f8d2ac57db7e996f5c686a545eec2e5b23480a752ae31250bd15fbdd3bd', '[\"*\"]', '2026-04-05 17:27:29', NULL, '2026-04-05 17:18:53', '2026-04-05 17:27:29'),
(5, 'App\\Models\\User', 3, 'auth_token', '8e2de10b9ccec386ca18bdfdbaca92ae554b2baac2bdf0164d4cebe997f2c22b', '[\"*\"]', '2026-04-05 20:57:15', NULL, '2026-04-05 18:11:06', '2026-04-05 20:57:15'),
(6, 'App\\Models\\User', 3, 'auth_token', '83b1f01fe532f8ca9e8be8a202e0494e8b2c5f5bc9b287507b0f58f951d29ab4', '[\"*\"]', '2026-04-05 21:13:19', NULL, '2026-04-05 21:07:15', '2026-04-05 21:13:19'),
(7, 'App\\Models\\User', 3, 'auth_token', '26e024f4a072959a60eb04d8c57220f8b4f26363dfdddd73ff1b9c092c37c12a', '[\"*\"]', '2026-04-05 22:01:09', NULL, '2026-04-05 21:16:43', '2026-04-05 22:01:09'),
(8, 'App\\Models\\User', 2, 'auth_token', 'f06b1d930c074b9f6d2d404482f79d7b6b2503e2781afb54f3506fbded993ce2', '[\"*\"]', '2026-04-05 22:06:05', NULL, '2026-04-05 22:05:54', '2026-04-05 22:06:05'),
(9, 'App\\Models\\User', 3, 'auth_token', 'ecd9866ec9f0759812a7d66433d29ae6336171098a03dba73d1ec3df91e4c1a0', '[\"*\"]', NULL, NULL, '2026-04-05 22:10:08', '2026-04-05 22:10:08'),
(10, 'App\\Models\\User', 3, 'auth_token', '9e470c417a0d62f70b0c26ebdc00dea66bc947957bc8303e4f0d98594ad5637e', '[\"*\"]', '2026-04-05 22:26:55', NULL, '2026-04-05 22:12:22', '2026-04-05 22:26:55'),
(11, 'App\\Models\\User', 4, 'auth_token', '3741dd473c1506255950b3ad93b5b8b4d0588ee80c25c5ad0d61a7ecb0a1b1e8', '[\"*\"]', NULL, NULL, '2026-04-05 22:29:51', '2026-04-05 22:29:51'),
(12, 'App\\Models\\User', 4, 'auth_token', 'a4195ad7cfa2eba5ef47d07eb04d5890816cf7e01ec0ea6bdecc91eab20a26b5', '[\"*\"]', '2026-04-05 22:31:12', NULL, '2026-04-05 22:30:31', '2026-04-05 22:31:12'),
(13, 'App\\Models\\User', 2, 'auth_token', '1d118082ddfdc6df28b1691785d9141bbdffc783c6b748e1a483a3d481c7c621', '[\"*\"]', '2026-04-05 22:43:13', NULL, '2026-04-05 22:31:29', '2026-04-05 22:43:13'),
(14, 'App\\Models\\User', 3, 'auth_token', 'ecaa63590b75b2c04c8df166d0afe1aa6c73d800db2e77c2694260be5786eb4b', '[\"*\"]', '2026-04-05 23:09:16', NULL, '2026-04-05 22:43:35', '2026-04-05 23:09:16'),
(15, 'App\\Models\\User', 3, 'auth_token', 'a6f14721089fc3d0b3c03ac616d9836750c84e9f1dd16c1715a2e711e8b29f31', '[\"*\"]', NULL, NULL, '2026-04-05 23:11:31', '2026-04-05 23:11:31'),
(16, 'App\\Models\\User', 2, 'auth_token', '35814a35fd696b703e3eadc408e2772acdd8b458fcee76ca19fdcb14b14a1a2a', '[\"*\"]', '2026-04-05 23:43:35', NULL, '2026-04-05 23:11:41', '2026-04-05 23:43:35'),
(17, 'App\\Models\\User', 3, 'auth_token', 'd02d9a46f85ac175dccf4c341b9da5e217d0e243c881d95d340c934fd3d1d43f', '[\"*\"]', '2026-04-05 23:33:05', NULL, '2026-04-05 23:31:51', '2026-04-05 23:33:05'),
(18, 'App\\Models\\User', 2, 'auth_token', 'e2c13454701543c7fe25fec6eea6b40df2508785d3f0a10b64f733cdccfc3f8b', '[\"*\"]', '2026-04-06 17:07:50', NULL, '2026-04-05 23:43:45', '2026-04-06 17:07:50'),
(19, 'App\\Models\\User', 2, 'auth_token', 'f16653039e7e97b640934fdb2138283978350d4751f77482e3e957a464c820bd', '[\"*\"]', NULL, NULL, '2026-04-06 17:08:03', '2026-04-06 17:08:03');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(15,2) NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_spicy` tinyint(1) NOT NULL DEFAULT '0',
  `is_vegetarian` tinyint(1) NOT NULL DEFAULT '0',
  `is_featured` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `image`, `category`, `is_spicy`, `is_vegetarian`, `is_featured`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Hazel Admin', 'sfdffdd', '11.00', '1775032755_HkMuMJl624.png', 'coffee', 0, 0, 0, '2026-04-01 00:39:15', '2026-04-01 00:39:15', NULL),
(2, 'Product 2', 'gfv', '34.00', '1775032778_2HHzqXWMD4.png', 'food', 0, 0, 0, '2026-04-01 00:39:38', '2026-04-05 19:07:54', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `promos`
--

CREATE TABLE `promos` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount_percentage` int NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `status` enum('active','upcoming','expired') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'upcoming',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reservations`
--

CREATE TABLE `reservations` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `guests` int NOT NULL,
  `special_requests` text COLLATE utf8mb4_unicode_ci,
  `reservation_fee` decimal(10,2) NOT NULL DEFAULT '2000.00',
  `reservation_fee_paid` tinyint(1) NOT NULL DEFAULT '0',
  `payment_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_reference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_screenshot` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('pending','confirmed','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `is_walkin` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reservations`
--

INSERT INTO `reservations` (`id`, `user_id`, `name`, `email`, `phone`, `date`, `time`, `guests`, `special_requests`, `reservation_fee`, `reservation_fee_paid`, `payment_method`, `payment_reference`, `payment_screenshot`, `status`, `is_walkin`, `created_at`, `updated_at`) VALUES
(1, 2, 'Hazel Admin', 'infinitech.hazel@gmail.com', '09124435435', '2026-04-07', '15:34:00', 2, NULL, '1000.00', 0, 'GCash', '34324324', NULL, 'pending', 0, '2026-04-05 23:39:27', '2026-04-05 23:39:27'),
(2, 2, 'Hazel Admin', 'infinitech.hazel@gmail.com', '09124435435', '2026-04-08', '15:42:00', 2, NULL, '700.00', 0, 'GCash', '123331232', NULL, 'pending', 0, '2026-04-05 23:41:19', '2026-04-05 23:41:19');

-- --------------------------------------------------------

--
-- Table structure for table `testimonials`
--

CREATE TABLE `testimonials` (
  `id` bigint UNSIGNED NOT NULL,
  `client_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rating` int NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('admin','customer') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'customer',
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `verification_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `verification_token_expiry` timestamp NULL DEFAULT NULL,
  `email_verified` tinyint(1) NOT NULL DEFAULT '0',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `address`, `city`, `zip_code`, `password`, `role`, `status`, `verification_token`, `verification_token_expiry`, `email_verified`, `remember_token`, `created_at`, `updated_at`, `deleted_at`) VALUES
(2, 'Hazel Admin', 'infinitech.hazel@gmail.com', '12', NULL, NULL, NULL, '$2y$12$xNyKLRLkZPpnHpLDhW0.t.8l43dEGEvQZ6Cwlt4z8MpEavJVBmuA.', 'admin', 'active', 'a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6q7r8s9t0u1v2w3x4y5z6a7b8c9d0e1f2', '2026-04-02 06:00:00', 1, NULL, '2026-03-31 19:29:01', '2026-03-31 19:29:01', NULL),
(3, 'Hazel User', 'hazelannemendoza321@gmail.com', '12', NULL, NULL, NULL, '$2y$12$gGHnjwCm5yJOM.04h0jV6uOZxgnMAIkdPbUu1KoMOGPm/G5is2pZ6', 'customer', 'active', 'fcnkldcpycwmnfhlrkf', '2026-04-01 19:29:25', 1, NULL, '2026-03-31 19:29:25', '2026-03-31 19:29:25', NULL),
(4, 'Hazel Anne Mendoza', 'hazel.mendoza1@gmail.com', '09943400836', 'sasas', 'sasasasasasasa', '123', '$2y$12$UF3tfOLSoueJNLLmi.MGuO7No7ZtFdBSDJ1IXQplc0CHIVIsRA9F2', 'customer', 'active', 'gm04j7aj8smnmt92ar', '2026-04-06 22:29:51', 1, NULL, '2026-04-05 22:29:51', '2026-04-05 22:29:51', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `addresses_user_id_foreign` (`user_id`);

--
-- Indexes for table `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blog_posts`
--
ALTER TABLE `blog_posts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `chefs`
--
ALTER TABLE `chefs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contacts_created_at_email_index` (`created_at`,`email`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `events_user_id_foreign` (`user_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `orders_order_number_unique` (`order_number`),
  ADD KEY `orders_user_id_foreign` (`user_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_items_order_id_foreign` (`order_id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_category_index` (`category`),
  ADD KEY `products_is_spicy_index` (`is_spicy`),
  ADD KEY `products_is_vegetarian_index` (`is_vegetarian`),
  ADD KEY `products_created_at_index` (`created_at`),
  ADD KEY `products_category_is_spicy_is_vegetarian_index` (`category`,`is_spicy`,`is_vegetarian`);

--
-- Indexes for table `promos`
--
ALTER TABLE `promos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reservations_user_id_index` (`user_id`),
  ADD KEY `reservations_user_id_date_index` (`user_id`,`date`);

--
-- Indexes for table `testimonials`
--
ALTER TABLE `testimonials`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `announcements`
--
ALTER TABLE `announcements`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `blog_posts`
--
ALTER TABLE `blog_posts`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `chefs`
--
ALTER TABLE `chefs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `promos`
--
ALTER TABLE `promos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reservations`
--
ALTER TABLE `reservations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `testimonials`
--
ALTER TABLE `testimonials`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `addresses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `events_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `reservations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
