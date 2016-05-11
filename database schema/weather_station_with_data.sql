-- phpMyAdmin SQL Dump
-- version 4.6.2deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 23, 2016 at 12:39 PM
-- Server version: 5.6.30-1
-- PHP Version: 5.6.22-1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `weather_station`
--

-- --------------------------------------------------------

--
-- Table structure for table `stations`
--

CREATE TABLE `stations` (
  `id` int(11) NOT NULL,
  `name` text COLLATE utf8_unicode_ci NOT NULL,
  `location` text COLLATE utf8_unicode_ci NOT NULL,
  `date_of_creation` text COLLATE utf8_unicode_ci NOT NULL,
  `last_received` text COLLATE utf8_unicode_ci,
  `status` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `stations`
--

INSERT INTO `stations` (`id`, `name`, `location`, `date_of_creation`, `last_received`, `status`) VALUES
(1, 'Test Station 1', 'University of Buea Campus', '13-12-11 8:9:10', '2016-6-11 13:19:9', 0);

-- --------------------------------------------------------

--
-- Table structure for table `weather_data`
--

CREATE TABLE `weather_data` (
  `id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `temperature` decimal(10,0) NOT NULL,
  `humidity` decimal(10,0) NOT NULL,
  `heat_index` decimal(10,0) NOT NULL,
  `amt_of_rain` decimal(10,0) NOT NULL,
  `wind_speed` decimal(10,0) NOT NULL,
  `wind_direction` text COLLATE utf8_unicode_ci NOT NULL,
  `datetime` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `weather_data`
--

INSERT INTO `weather_data` (`id`, `station_id`, `temperature`, `humidity`, `heat_index`, `amt_of_rain`, `wind_speed`, `wind_direction`, `datetime`) VALUES
(319, 1, 26, 33, 26, 0, 0, '-1', '2016-6-7 18:15:0'),
(320, 1, 26, 33, 26, 0, 0, '-1', '2016-6-7 18:15:0'),
(321, 1, 26, 33, 26, 0, 0, '-1', '2016-6-7 18:15:15'),
(322, 1, 26, 33, 26, 0, 0, '-1', '2016-6-7 18:15:15'),
(323, 1, 26, 33, 26, 0, 0, '-1', '2016-6-7 18:15:15'),
(324, 1, 26, 33, 26, 0, 0, '-1', '2016-6-7 18:15:31'),
(325, 1, 26, 33, 26, 0, 0, '-1', '2016-6-7 18:15:31'),
(326, 1, 26, 32, 25, 0, 0, '-1', '2016-6-7 18:15:46'),
(327, 1, 26, 32, 25, 0, 0, '-1', '2016-6-7 18:15:46'),
(328, 1, 26, 32, 25, 0, 0, '-1', '2016-6-7 18:15:46'),
(329, 1, 27, 31, 26, 0, 0, '-1', '2016-6-7 18:16:1'),
(330, 1, 27, 31, 26, 0, 0, '-1', '2016-6-7 18:16:1'),
(331, 1, 26, 32, 25, 0, 0, '-1', '2016-6-7 18:16:17'),
(332, 1, 26, 32, 25, 0, 0, '-1', '2016-6-7 18:16:17'),
(333, 1, 26, 32, 25, 0, 0, '-1', '2016-6-7 18:16:17'),
(334, 1, 26, 32, 25, 0, 0, '-1', '2016-6-7 18:16:17'),
(335, 1, 27, 31, 26, 0, 0, '-1', '2016-6-7 18:18:19'),
(336, 1, 27, 30, 26, 0, 0, '-1', '2016-6-7 18:18:34'),
(337, 1, 27, 30, 26, 0, 0, '-1', '2016-6-7 18:18:50'),
(338, 1, 27, 30, 26, 0, 0, '-1', '2016-6-7 18:18:50'),
(339, 1, 27, 30, 26, 0, 0, '-1', '2016-6-7 18:19:5'),
(340, 1, 27, 30, 26, 0, 0, '-1', '2016-6-7 18:19:20'),
(341, 1, 27, 30, 26, 0, 0, '-1', '2016-6-7 18:19:36'),
(342, 1, 27, 30, 26, 0, 0, '-1', '2016-6-7 18:19:51'),
(343, 1, 26, 42, 26, 0, 0, 'EAST', '2000-0-0 0:23:59'),
(344, 1, 26, 42, 26, 0, 0, 'EAST', '2000-0-0 0:24:15'),
(345, 1, 25, 42, 25, 0, 0, 'EAST', '2000-0-0 0:24:31'),
(346, 1, 25, 42, 25, 0, 0, 'EAST', '2000-0-0 0:24:47'),
(347, 1, 25, 42, 25, 0, 0, 'EAST', '2000-0-0 0:25:3'),
(348, 1, 25, 43, 25, 0, 0, 'EAST', '2000-0-0 0:25:19'),
(349, 1, 25, 42, 25, 0, 0, 'EAST', '2000-0-0 0:25:35'),
(350, 1, 25, 42, 25, 0, 0, 'EAST', '2000-0-0 0:25:51'),
(351, 1, 25, 42, 25, 0, 0, 'EAST', '2000-0-0 0:26:7'),
(352, 1, 25, 42, 25, 0, 0, 'EAST', '2000-0-0 0:26:17'),
(353, 1, 25, 43, 25, 0, 0, 'EAST', '2000-0-0 0:26:33'),
(354, 1, 25, 42, 25, 0, 0, 'EAST', '2165-165-165 165:165:85'),
(355, 1, 25, 42, 25, 0, 0, 'EAST', '2165-165-165 165:165:85'),
(356, 1, 25, 43, 25, 0, 0, 'EAST', '2000-0-0 0:27:21'),
(357, 1, 25, 42, 25, 0, 0, 'EAST', '2000-0-0 0:27:27'),
(358, 1, 25, 42, 25, 0, 0, 'EAST', '2000-0-0 0:27:27'),
(359, 1, 25, 42, 25, 0, 0, 'EAST', '2000-0-0 0:27:27'),
(360, 1, 25, 42, 25, 0, 0, 'EAST', '2000-0-0 0:27:27'),
(361, 1, 25, 42, 25, 0, 0, 'EAST', '2000-0-0 0:27:27'),
(362, 1, 25, 42, 25, 0, 0, 'EAST', '2000-0-0 0:27:27'),
(363, 1, 26, 38, 26, 0, 0, 'EAST', '2016-6-11 13:18:43'),
(364, 1, 26, 37, 26, 0, 0, 'EAST', '2016-6-11 13:18:53'),
(365, 1, 26, 37, 26, 0, 0, 'EAST', '2016-6-11 13:19:9'),
(366, 1, 26, 37, 26, 0, 0, 'EAST', '2016-6-11 13:19:9'),
(367, 1, 26, 37, 26, 0, 0, 'EAST', '2016-6-11 13:19:9'),
(368, 1, 26, 37, 26, 0, 0, 'EAST', '2016-6-11 13:19:9'),
(369, 1, 26, 37, 26, 0, 0, 'EAST', '2016-6-11 13:19:9'),
(370, 1, 26, 37, 26, 0, 0, 'EAST', '2016-6-11 13:19:9'),
(371, 1, 26, 37, 26, 0, 0, 'EAST', '2016-6-11 13:19:9'),
(372, 1, 26, 37, 26, 0, 0, 'EAST', '2016-6-11 13:19:9'),
(373, 1, 26, 37, 26, 0, 0, 'EAST', '2016-6-11 13:19:9'),
(374, 1, 26, 37, 26, 0, 0, 'EAST', '2016-6-11 13:19:9'),
(375, 1, 26, 37, 26, 0, 0, 'EAST', '2016-6-11 13:19:9'),
(376, 1, 26, 37, 26, 0, 0, 'EAST', '2016-6-11 13:19:9'),
(377, 1, 26, 37, 26, 0, 0, 'EAST', '2016-6-11 13:19:9'),
(378, 1, 26, 37, 26, 0, 0, 'EAST', '2016-6-11 13:19:9'),
(379, 1, 26, 37, 26, 0, 0, 'EAST', '2016-6-11 13:19:9'),
(380, 1, 26, 37, 26, 0, 0, 'EAST', '2016-6-11 13:19:9'),
(381, 1, 26, 37, 26, 0, 0, 'EAST', '2016-6-11 13:19:9'),
(382, 1, 26, 37, 26, 0, 0, 'EAST', '2016-6-11 13:19:9'),
(383, 1, 26, 37, 26, 0, 0, 'EAST', '2016-6-11 13:19:9'),
(384, 1, 26, 37, 26, 0, 0, 'EAST', '2016-6-11 13:19:9'),
(385, 1, 26, 37, 26, 0, 0, 'EAST', '2016-6-11 13:19:9'),
(386, 1, 26, 37, 26, 0, 0, 'EAST', '2016-6-11 13:19:9'),
(387, 1, 26, 37, 26, 0, 0, 'EAST', '2016-6-11 13:19:9'),
(388, 1, 26, 37, 26, 0, 0, 'EAST', '2016-6-11 13:19:9'),
(389, 1, 26, 37, 26, 0, 0, 'EAST', '2016-6-11 13:19:9'),
(390, 1, 26, 37, 26, 0, 0, 'EAST', '2016-6-11 13:19:9'),
(391, 1, 26, 37, 26, 0, 0, 'EAST', '2016-6-11 13:19:9'),
(392, 1, 26, 37, 26, 0, 0, 'EAST', '2016-6-11 13:19:9');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `stations`
--
ALTER TABLE `stations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- Indexes for table `weather_data`
--
ALTER TABLE `weather_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`),
  ADD KEY `id` (`station_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `stations`
--
ALTER TABLE `stations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `weather_data`
--
ALTER TABLE `weather_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=393;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `weather_data`
--
ALTER TABLE `weather_data`
  ADD CONSTRAINT `weather_data_ibfk_1` FOREIGN KEY (`station_id`) REFERENCES `stations` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
