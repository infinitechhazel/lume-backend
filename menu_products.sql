-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 15, 2026 at 09:25 AM
-- Server version: 8.0.45
-- PHP Version: 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u985819704_lumebeanandbar`
--

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `ingredients` text COLLATE utf8mb4_unicode_ci,
  `price` decimal(15,2) NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `set` tinyint(1) NOT NULL DEFAULT '0',
  `best_seller` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `ingredients`, `price`, `image`, `category`, `set`, `best_seller`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Shots', 'Tequila / Black Tea / Lime', 'Lychee | Strawberry | Passion Fruit | Blueberry | Honey Peach', 299.00, NULL, 'Signature', 0, 1, NULL, NULL, NULL),
(2, 'Antares', 'A silky, spiced bourbon experience', 'Bourbon | Passion Fruit | Aromatic Bitters | Whole Egg | Lemon | Star Anise', 250.00, NULL, 'Signature', 0, 1, NULL, NULL, NULL),
(3, 'Mimosa', 'Effervescent and playful with fruit spheres', 'Soju | Gin | Plum | Bay Leaf | Lime | Ginger | Soda Water | Strawberry Spheres', 250.00, NULL, 'Signature', 0, 0, NULL, NULL, NULL),
(4, 'Adhara', 'Floral and refreshing garden blend', 'Gin | Elderflower | Lime | Blue Pea | Rose | Soda and Tonic Water', 250.00, NULL, 'Signature', 0, 0, NULL, NULL, NULL),
(5, 'Archenar', 'Deep, aromatic and warming spice', 'Brandy | Sherry | Aromatic and Orange Bitters | Cinnamon', 250.00, NULL, 'Signature', 0, 0, NULL, NULL, NULL),
(6, 'Hoku', 'Crystal clear, tropical clarified punch', 'Blanco White Rum | Vodka | Pandan | Coconut | Pineapple | Lime | Milk Clarified', 250.00, NULL, 'Signature', 0, 1, NULL, NULL, NULL),
(7, 'Castor', 'Rich espresso and rum indulgence', 'Gold Rum | Brown Sugar Syrup | Chocolate Bitters | Full Cream Milk | Espresso', 250.00, NULL, 'Signature', 0, 0, NULL, NULL, NULL),
(8, 'Polaris', 'A silky, nutty and fruity delight', 'Amaretto | Vodka | Lemon | Egg White | Strawberry | Rose', 250.00, NULL, 'Signature', 0, 0, NULL, NULL, NULL),
(9, 'Vega', 'A vibrant citrus classic with a hint of mint', 'Tequila | Aperol | Lime | Lychee | Mint | Pink Salt', 250.00, NULL, 'Signature', 0, 0, NULL, NULL, NULL),
(10, 'Namid', 'Complex, smoky and herbaceous balanced', 'Scotch | Red Wine Jus | Tanglad | Lemon | Soda Water', 250.00, NULL, 'Signature', 0, 0, NULL, NULL, NULL),
(11, 'Altair', 'A refreshing floral berry blend', 'Gin | Jasmine | Blueberry | Lemon', 250.00, NULL, 'Signature', 0, 0, NULL, NULL, NULL),
(12, 'Whiskey Highball', 'Light, crisp and refreshing with smooth whiskey warmth and subtle bubbles', 'Bourbon | Soda Water | Lemon Peel', 350.00, NULL, 'Classics', 0, 1, NULL, NULL, NULL),
(13, 'Daiquiri', 'Bright and citrusy with a clean rum backbone and a smooth, dry finish', 'Rum | Brown Sugar Syrup | Lime', 350.00, NULL, 'Classics', 0, 0, NULL, NULL, NULL),
(14, 'Gin And Tonic', 'Fresh, bubbly and lightly bitter with bright citrus and herbal notes', 'Gin | Tonic Water | Orange', 350.00, NULL, 'Classics', 0, 1, NULL, NULL, NULL),
(15, 'Gimlet', 'Sharp, zesty lime balanced by herbal gin and a slightly sweet edge', 'Gin | Sugar Syrup | Lime', 350.00, NULL, 'Classics', 0, 0, NULL, NULL, NULL),
(16, 'Clover Club', 'Soft, creamy and lightly tart with raspberry notes and a silky texture', 'Gin | Dry Vermouth | Raspberry | Lemon | Egg White', 350.00, NULL, 'Classics', 0, 0, NULL, NULL, NULL),
(17, 'Mojito', 'Cool, minty and refreshing with fresh lime and a light rum sweetness', 'Rum | Sugar Syrup | Lime | Mint', 350.00, NULL, 'Classics', 0, 1, NULL, NULL, NULL),
(18, 'Negroni', 'Bold, bittersweet and complex with herbal depth and a warming finish', 'Gin | Sweet Vermouth | Campari', 400.00, NULL, 'Classics', 0, 0, NULL, NULL, NULL),
(19, 'Old Fashioned', 'Rich, smooth and spirit-forward with hints of caramel, spice and citrus', 'Bourbon | Aromatic and Orange Bitters | Brown Sugar Syrup', 400.00, NULL, 'Classics', 0, 1, NULL, NULL, NULL),
(20, 'Paper Plane', 'Bright, bittersweet and smooth with citrus, herbs and a light bourbon warmth', 'Bourbon | Aperol | Amaro Lucano | Lemon', 400.00, NULL, 'Classics', 0, 0, NULL, NULL, NULL),
(21, 'Martini', 'Clean, dry and crisp with sharp botanicals and a smooth, cold finish', 'Gin/Vodka | Orange Bitters | Dry Vermouth | Olives', 400.00, NULL, 'Classics', 0, 0, NULL, NULL, NULL),
(22, 'Heineken Bottle', NULL, NULL, 150.00, NULL, 'Drinks', 0, 1, NULL, NULL, NULL),
(23, 'Heineken Beer Can', NULL, NULL, 150.00, NULL, 'Drinks', 0, 0, NULL, NULL, NULL),
(24, 'San Miguel Pale Pilsen', NULL, NULL, 120.00, NULL, 'Drinks', 0, 1, NULL, NULL, NULL),
(25, 'San Miguel Light', NULL, NULL, 120.00, NULL, 'Drinks', 0, 0, NULL, NULL, NULL),
(26, 'Smirnoff', NULL, NULL, 150.00, NULL, 'Drinks', 0, 0, NULL, NULL, NULL),
(27, 'Coke', NULL, NULL, 100.00, NULL, 'Drinks', 0, 1, NULL, NULL, NULL),
(28, 'Sprite', NULL, NULL, 100.00, NULL, 'Drinks', 0, 0, NULL, NULL, NULL),
(29, 'Soda Water', NULL, NULL, 100.00, NULL, 'Drinks', 0, 0, NULL, NULL, NULL),
(30, 'Tonic Water', NULL, NULL, 100.00, NULL, 'Drinks', 0, 0, NULL, NULL, NULL),
(31, 'Gin And Tonic Set', '1 Bottle Tanqueray Gin + 5 Tonic Water', NULL, 3000.00, NULL, 'Drinks', 1, 0, NULL, NULL, NULL),
(32, 'Aperol Spritz Set', '1 Bottle Aperol + 1 Bottle Prosecco + 5 Soda Water', NULL, 4000.00, NULL, 'Drinks', 1, 0, NULL, NULL, NULL),
(33, 'Highball Set', '1 Bottle Jameson + 5 Soda Water', NULL, 4000.00, NULL, 'Drinks', 1, 0, NULL, NULL, NULL),
(34, 'Black Label Set', '1 Bottle Black Label + Soda Water', NULL, 3500.00, NULL, 'Drinks', 1, 0, NULL, NULL, NULL),
(35, 'Johnnie Walker Blonde Set', '1 Bottle Johnnie Walker Blonde + 5 Soda Water', NULL, 3000.00, NULL, 'Drinks', 1, 0, NULL, NULL, NULL),
(36, 'Spanish Latte', NULL, NULL, 150.00, NULL, 'Coffee', 0, 1, NULL, NULL, NULL),
(37, 'Honey Oat Latte', NULL, NULL, 150.00, NULL, 'Coffee', 0, 0, NULL, NULL, NULL),
(38, 'White Chocolate Latte', NULL, NULL, 160.00, NULL, 'Coffee', 0, 1, NULL, NULL, NULL),
(39, 'Caramel Latte', NULL, NULL, 160.00, NULL, 'Coffee', 0, 0, NULL, NULL, NULL),
(40, 'Dark Chocolate Mocha', NULL, NULL, 170.00, NULL, 'Coffee', 0, 0, NULL, NULL, NULL),
(41, 'Salted Caramel Latte', NULL, NULL, 155.00, NULL, 'Coffee', 0, 0, NULL, NULL, NULL),
(42, 'Biscoff Crunch Latte', NULL, NULL, 165.00, NULL, 'Coffee', 0, 0, NULL, NULL, NULL),
(43, 'Americano', NULL, NULL, 120.00, NULL, 'Coffee', 0, 1, NULL, NULL, NULL),
(44, 'Affogato', 'Vanilla Ice Cream with Espresso', NULL, 100.00, NULL, 'Coffee', 0, 0, NULL, NULL, NULL),
(45, 'Hungarian Sausage With Rice And Egg', NULL, NULL, 290.00, NULL, 'Food', 0, 1, NULL, NULL, NULL),
(46, 'Tapa With Rice And Egg', NULL, NULL, 255.00, NULL, 'Food', 0, 0, NULL, NULL, NULL),
(47, 'Longganisa With Rice And Egg', NULL, NULL, 250.00, NULL, 'Food', 0, 1, NULL, NULL, NULL),
(48, 'Shanghai', NULL, NULL, 215.00, NULL, 'Food', 0, 0, NULL, NULL, NULL),
(49, 'Shanghai With Rice And Egg', NULL, NULL, 250.00, NULL, 'Food', 0, 0, NULL, NULL, NULL),
(50, 'Sizzling Sisig', NULL, NULL, 400.00, NULL, 'Food', 0, 1, NULL, NULL, NULL),
(51, 'Baked Macaroni', NULL, NULL, 220.00, NULL, 'Food', 0, 0, NULL, NULL, NULL),
(52, 'Lasagna', NULL, NULL, 295.00, NULL, 'Food', 0, 0, NULL, NULL, NULL),
(53, 'Nachos', NULL, NULL, 350.00, NULL, 'Food', 0, 0, NULL, NULL, NULL),
(54, 'Chicken Fingers', NULL, NULL, 295.00, NULL, 'Food', 0, 0, NULL, NULL, NULL),
(55, 'Waffles', NULL, NULL, 160.00, NULL, 'Desserts', 0, 1, NULL, NULL, NULL),
(56, 'Waffles With Ice Cream', NULL, NULL, 180.00, NULL, 'Desserts', 0, 0, NULL, NULL, NULL),
(57, 'Ube White Chocolate Cookie', NULL, NULL, 145.00, NULL, 'Desserts', 0, 1, NULL, NULL, NULL),
(58, 'Biscoff Cookie', NULL, NULL, 155.00, NULL, 'Desserts', 0, 0, NULL, NULL, NULL),
(59, 'Matcha Cookie', NULL, NULL, 155.00, NULL, 'Desserts', 0, 0, NULL, NULL, NULL),
(60, 'Chocolate Chip Cookie', NULL, NULL, 145.00, NULL, 'Desserts', 0, 1, NULL, NULL, NULL),
(61, 'Red Velvet Cream Cheese Cookie', NULL, NULL, 150.00, NULL, 'Desserts', 0, 0, NULL, NULL, NULL),
(62, 'Almond Load Cookie', NULL, NULL, 150.00, NULL, 'Desserts', 0, 0, NULL, NULL, NULL),
(63, 'Mango Stardust', 'Mango Fruit Tea With Strawberry Popping Boba', NULL, 150.00, NULL, 'Refreshers', 0, 1, NULL, NULL, NULL),
(64, 'Peach Pink Bliss', 'Peach Fruit Tea With Watermelon Jelly', NULL, 150.00, NULL, 'Refreshers', 0, 0, NULL, NULL, NULL),
(65, 'Apple Kiss Tea', 'Green Apple Fruit Tea With Cherry On Top', NULL, 150.00, NULL, 'Refreshers', 0, 0, NULL, NULL, NULL),
(66, 'Lychee Amethyst Tea', 'Lychee Fruit Tea With Grape Jelly', NULL, 150.00, NULL, 'Refreshers', 0, 1, NULL, NULL, NULL),
(67, 'Blue Nova Pop', 'Blueberry Fruit Tea With Blueberry Popping Boba', NULL, 150.00, NULL, 'Refreshers', 0, 0, NULL, NULL, NULL),
(68, 'Ruby Jane', 'Strawberry Fruit Tea With Strawberry Popping Boba', NULL, 150.00, NULL, 'Refreshers', 0, 0, NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_category_index` (`category`),
  ADD KEY `products_best_seller_index` (`best_seller`),
  ADD KEY `products_created_at_index` (`created_at`),
  ADD KEY `products_category_best_seller_index` (`category`,`best_seller`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
