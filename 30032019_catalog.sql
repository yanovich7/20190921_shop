-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Авг 04 2019 г., 14:47
-- Версия сервера: 5.7.19
-- Версия PHP: 7.3.0beta3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `30032019_catalog`
--

-- --------------------------------------------------------

--
-- Структура таблицы `categories`
--

CREATE TABLE `categories` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `pos` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `categories`
--

INSERT INTO `categories` (`id`, `name`, `pos`) VALUES
(1, 'Верхняя одежда', 10),
(2, 'Обувь', 20),
(3, 'Джинсовая одежда', 30);

-- --------------------------------------------------------

--
-- Структура таблицы `collections`
--

CREATE TABLE `collections` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `pos` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `collections`
--

INSERT INTO `collections` (`id`, `name`, `pos`) VALUES
(1, 'Женщинам', 10),
(2, 'Мужчинам', 20),
(3, 'Детям', 30);

-- --------------------------------------------------------

--
-- Структура таблицы `items`
--

CREATE TABLE `items` (
  `id` int(11) UNSIGNED NOT NULL,
  `image` varchar(255) DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `price` float NOT NULL,
  `category_id` int(11) UNSIGNED NOT NULL,
  `collection_id` int(11) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `items`
--

INSERT INTO `items` (`id`, `image`, `name`, `description`, `price`, `category_id`, `collection_id`, `created_at`) VALUES
(1, '/images/catalog/1.jpg', 'Куртка синяя', NULL, 5400, 1, 2, '2019-07-28 13:10:12'),
(2, '/images/catalog/2.jpg', 'Кожаная куртка', NULL, 22500, 1, 2, '2019-07-28 13:12:18'),
(3, '/images/catalog/3.png', 'Куртка с карманами', NULL, 9200, 1, 2, '2019-07-28 13:13:12'),
(4, '/images/catalog/7.jpg', 'Кеды серые', NULL, 2900, 2, 2, '2019-07-28 13:14:19'),
(5, '/images/catalog/9.jpg', 'Кеды Casual', NULL, 5900, 2, 2, '2019-07-28 13:15:59'),
(6, '/images/catalog/10.jpg', 'Кеды всепогодные', NULL, 9200, 2, 2, '2019-07-28 13:16:41'),
(7, '/images/catalog/11.jpg', 'Джинсы', NULL, 4800, 3, 2, '2019-07-28 13:18:50'),
(8, '/images/catalog/12.jpg', 'Джинсы голубые', NULL, 4200, 3, 2, '2019-07-28 13:19:35');

-- --------------------------------------------------------

--
-- Структура таблицы `items_sizes`
--

CREATE TABLE `items_sizes` (
  `id` int(11) UNSIGNED NOT NULL,
  `item_id` int(11) UNSIGNED NOT NULL,
  `size_id` int(11) UNSIGNED NOT NULL,
  `pos` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `items_sizes`
--

INSERT INTO `items_sizes` (`id`, `item_id`, `size_id`, `pos`) VALUES
(1, 4, 15, 1),
(2, 4, 16, 1),
(3, 4, 17, 1),
(4, 4, 18, 1),
(5, 4, 19, 1),
(6, 1, 1, 1),
(7, 1, 2, 1),
(8, 1, 3, 1),
(9, 1, 4, 1),
(10, 1, 5, 1),
(11, 1, 6, 1),
(12, 1, 7, 1),
(13, 2, 1, 1),
(14, 2, 2, 1),
(15, 2, 3, 1),
(16, 2, 4, 1),
(17, 3, 4, 1),
(18, 3, 5, 1),
(19, 3, 6, 1),
(20, 3, 7, 1),
(21, 5, 8, 1),
(22, 5, 9, 1),
(23, 5, 11, 1),
(24, 5, 13, 1),
(25, 5, 15, 1),
(26, 5, 17, 1),
(27, 5, 19, 1),
(28, 6, 15, 1),
(29, 6, 16, 1),
(30, 6, 17, 1),
(31, 6, 18, 1),
(32, 6, 19, 1),
(33, 6, 20, 1),
(34, 6, 21, 1),
(35, 7, 25, 1),
(36, 7, 26, 1),
(37, 7, 27, 1),
(38, 7, 28, 1),
(39, 7, 29, 1),
(40, 7, 30, 1),
(41, 7, 31, 1),
(42, 8, 25, 1),
(43, 8, 26, 1),
(44, 8, 27, 1),
(45, 8, 28, 1),
(46, 8, 29, 1),
(47, 8, 30, 1),
(48, 8, 31, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `menu`
--

CREATE TABLE `menu` (
  `id` int(11) UNSIGNED NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(32) NOT NULL DEFAULT '',
  `collection_id` int(11) UNSIGNED DEFAULT NULL,
  `pos` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `menu`
--

INSERT INTO `menu` (`id`, `type`, `name`, `collection_id`, `pos`) VALUES
(1, 0, 'Женщинам', 1, 10),
(2, 0, 'Мужчинам', 2, 20),
(3, 0, 'Детям', 3, 30),
(4, 0, 'Новинки', NULL, 40),
(5, 0, 'О нас', NULL, 50),
(6, 1, 'Женщинам', 1, 10),
(7, 1, 'Мужчинам', 2, 20),
(8, 1, 'Детям', 3, 30),
(9, 1, 'Новинки', NULL, 40);

-- --------------------------------------------------------

--
-- Структура таблицы `sizes`
--

CREATE TABLE `sizes` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(32) NOT NULL DEFAULT '',
  `category_id` int(11) UNSIGNED NOT NULL,
  `pos` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `sizes`
--

INSERT INTO `sizes` (`id`, `name`, `category_id`, `pos`) VALUES
(1, 'XS', 1, 10),
(2, 'S', 1, 20),
(3, 'M', 1, 30),
(4, 'L', 1, 40),
(5, 'XL', 1, 50),
(6, 'XXL', 1, 60),
(7, 'XXXL', 1, 70),
(8, '19', 2, 10),
(9, '21', 2, 20),
(10, '23', 2, 30),
(11, '25', 2, 40),
(12, '26', 2, 50),
(13, '27', 2, 60),
(14, '28', 2, 70),
(15, '29', 2, 80),
(16, '30', 2, 90),
(17, '31', 2, 100),
(18, '32', 2, 110),
(19, '33', 2, 120),
(20, '35', 2, 140),
(21, '37', 2, 160),
(22, '39', 2, 180),
(23, '41', 2, 200),
(24, '43', 2, 220),
(25, 'XS', 3, 10),
(26, 'S', 3, 20),
(27, 'M', 3, 30),
(28, 'L', 3, 40),
(29, 'XL', 3, 50),
(30, 'XXL', 3, 60),
(31, 'XXXL', 3, 70);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) UNSIGNED NOT NULL,
  `login` varchar(32) NOT NULL DEFAULT '',
  `password` varchar(40) NOT NULL DEFAULT '',
  `name` varchar(32) NOT NULL DEFAULT '',
  `surname` varchar(32) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `login`, `password`, `name`, `surname`) VALUES
(1, 'alex', '8cb2237d0679ca88db6464eac60da96345513964', 'Алексей', 'Петров');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `collections`
--
ALTER TABLE `collections`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `collection_id` (`collection_id`);

--
-- Индексы таблицы `items_sizes`
--
ALTER TABLE `items_sizes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `size_id` (`size_id`);

--
-- Индексы таблицы `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `collection_id` (`collection_id`);

--
-- Индексы таблицы `sizes`
--
ALTER TABLE `sizes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `collections`
--
ALTER TABLE `collections`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `items`
--
ALTER TABLE `items`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT для таблицы `items_sizes`
--
ALTER TABLE `items_sizes`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT для таблицы `menu`
--
ALTER TABLE `menu`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `sizes`
--
ALTER TABLE `sizes`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `items_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `items_ibfk_2` FOREIGN KEY (`collection_id`) REFERENCES `collections` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `items_sizes`
--
ALTER TABLE `items_sizes`
  ADD CONSTRAINT `items_sizes_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `items_sizes_ibfk_2` FOREIGN KEY (`size_id`) REFERENCES `sizes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `menu`
--
ALTER TABLE `menu`
  ADD CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`collection_id`) REFERENCES `collections` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `sizes`
--
ALTER TABLE `sizes`
  ADD CONSTRAINT `sizes_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
