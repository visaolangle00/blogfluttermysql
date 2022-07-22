-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th9 15, 2021 lúc 02:17 PM
-- Phiên bản máy phục vụ: 10.4.21-MariaDB
-- Phiên bản PHP: 8.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `flutter_blog`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `create_date` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `category`
--

INSERT INTO `category` (`id`, `name`, `create_date`) VALUES
(3, 'Java ', '04/07/2021 06:20'),
(4, 'C++', ''),
(5, 'Android', ''),
(6, 'React', ''),
(16, 'Go', '03/07/2021'),
(17, 'New Def', '04/07/2021'),
(19, 'Flutter 2', '04/07/2021'),
(20, 'Flutter 3', '05/07/2021'),
(21, 'Android 3', '05/07/2021');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `charts`
--

CREATE TABLE `charts` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `price` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `charts`
--

INSERT INTO `charts` (`id`, `name`, `price`) VALUES
(1, 'Flutter', 10),
(2, 'Java', 30);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `comment` text NOT NULL,
  `user_email` text NOT NULL,
  `post_id` int(11) NOT NULL,
  `comments_date` text NOT NULL,
  `isSeen` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `comments`
--

INSERT INTO `comments` (`id`, `comment`, `user_email`, `post_id`, `comments_date`, `isSeen`) VALUES
(59, 'asdasd', 'test', 1, '09/07/2021', 0),
(60, 'asdsad', 'test', 1, '09/07/2021', 0),
(61, 'sadsad', 'test', 1, '09/07/2021', 1),
(62, 'sadasdasd', 'test', 15, '09/07/2021', 1),
(63, '', '', 1, '19/07/2021', 1),
(64, '', 'test', 1, '19/07/2021', 1),
(65, 'chang doi nhi hic', 'test', 1, '19/07/2021', 0),
(66, 'sadsadsad', 'test', 1, '19/07/2021', 1),
(67, 'asdsadasd', 'test', 1, '19/07/2021', 1),
(68, 'asd', 'test', 2, '19/07/2021', 1),
(69, 'thoi khong doi 1', 'test', 1, '20/07/2021', 0),
(70, 'thoi khong doi 2', 'test', 1, '20/07/2021', 0),
(71, 'thoi khong doi', 'test', 1, '20/07/2021', 0),
(72, 'thoi khong doi 2', 'test', 1, '20/07/2021', 0),
(73, 'ngaythangdantroi', 'user@gmail.com', 1, '12/09/2021', 0),
(74, 'chan', 'user@gmail.com', 1, '12/09/2021', 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `login_register`
--

CREATE TABLE `login_register` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `status` varchar(100) NOT NULL DEFAULT 'User'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `login_register`
--

INSERT INTO `login_register` (`id`, `name`, `username`, `password`, `status`) VALUES
(1, 'minhhiep', 'hiepminh0123@gmail.com', '123', 'Admin'),
(6, 'huyculy', 'sadsad', 'sadsad', 'Admin'),
(12, 'hoangdog', 'test', 'test', 'User'),
(13, 'nhunghuyen', 'asdasd@gmail.com', 'asdasd', 'User'),
(53, 'user', 'user@gmail.com', 'pass', 'User'),
(54, 'useruser', 'user96@gmail.com', 'pass', 'User'),
(56, 't1', 't1', 't1', 'User'),
(57, '', '', '', 'User');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `post_likes`
--

CREATE TABLE `post_likes` (
  `id` int(11) NOT NULL,
  `user_email` text NOT NULL,
  `post_id` int(11) NOT NULL,
  `islike` int(11) NOT NULL,
  `cur_date` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `post_likes`
--

INSERT INTO `post_likes` (`id`, `user_email`, `post_id`, `islike`, `cur_date`) VALUES
(12, 'test', 12, 1, '23213213'),
(19, 'test', 4, 1, '19/07/2021'),
(22, 'user@gmail.com', 1, 1, '12/09/2021');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `post_table`
--

CREATE TABLE `post_table` (
  `id` int(11) NOT NULL,
  `image` text NOT NULL,
  `author` text NOT NULL,
  `post_date` text NOT NULL,
  `comments` text NOT NULL,
  `total_like` text NOT NULL,
  `title` text NOT NULL,
  `body` text NOT NULL,
  `category_name` text NOT NULL,
  `create_date` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `post_table`
--

INSERT INTO `post_table` (`id`, `image`, `author`, `post_date`, `comments`, `total_like`, `title`, `body`, `category_name`, `create_date`) VALUES
(1, '846383_MINHHIEP_1.jpg', 'NotDev', '15/5/2021', '50', '144', 'Post title XYZ', 'Post body', 'Flutter', '15/5/2021'),
(2, '846383_MINHHIEP_1.jpg', 'NotDev', '15/5/2021', '44', '123', 'Post title', 'Post body', 'Android', '15/5/2021'),
(3, '846383_MINHHIEP_1.jpg', 'NotDev', '15/5/2021', '44', '123', 'Post title', 'Post body', 'Java', '15/5/2021'),
(4, '846383_MINHHIEP_1.jpg', 'NotDev', '15/5/2021', '44', '124', 'Post title', 'Post body', 'Flutter', '15/5/2021'),
(15, 'image_picker884376553.jpg', '', '', '', '', 'test', 'test', 'React', ''),
(16, 'image_picker-1445280222.jpg', '', '', '', '', 'New Def', 'asdasd', 'C++', ''),
(17, 'image_picker-774247572.jpg', 'Guest', '04/07/2021', '', '', 'test', 'test', 'Android', ''),
(39, '846383_MINHHIEP_1.jpg', 'huyculy', '05/07/2021', '', '', 'abcd', '', 'Flutter', ''),
(41, '846383_MINHHIEP_1.jpg', 'huyculy', '05/07/2021', '', '', 'abcd', '', 'Android', ''),
(43, '17202756_833301066832738_8403370620881639107_n.jpg', 'huyculy', '05/07/2021', '', '', 'doi de', 'doi de', 'Android 6', ''),
(44, '846383_MINHHIEP_1.jpg', 'huyculy', '05/07/2021', '', '', 'abcd', 'acd', 'Go Lang', ''),
(45, 'image_picker1425941907.jpg', 'huyculy', '05/07/2021', '', '', 'Flutter Programing', 'Flutter harding', 'Flutter 2', ''),
(46, 'image_picker-630722478.jpg', 'huyculy', '05/07/2021', '', '', 'Flutter +++', 'Flutter +++', 'Go', ''),
(47, 'image_picker1230586284.jpg', 't1', '05/07/2021', '', '', 'New Post', 'New Test', 'Flutter 2', '');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `charts`
--
ALTER TABLE `charts`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `login_register`
--
ALTER TABLE `login_register`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `post_likes`
--
ALTER TABLE `post_likes`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `post_table`
--
ALTER TABLE `post_table`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT cho bảng `charts`
--
ALTER TABLE `charts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT cho bảng `login_register`
--
ALTER TABLE `login_register`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT cho bảng `post_likes`
--
ALTER TABLE `post_likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT cho bảng `post_table`
--
ALTER TABLE `post_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
