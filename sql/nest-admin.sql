-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2022-06-19 20:48:16
-- 服务器版本： 8.0.12
-- PHP 版本： 7.3.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `nest-admin`
--

-- --------------------------------------------------------

--
-- 表的结构 `sys_config`
--

CREATE TABLE `sys_config` (
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `id` int(11) NOT NULL,
  `key` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- 转存表中的数据 `sys_config`
--

INSERT INTO `sys_config` (`created_at`, `updated_at`, `id`, `key`, `name`, `value`, `remark`) VALUES
('2021-09-28 03:14:05.256120', '2021-09-28 03:14:05.256120', 1, 'sys_user_initPassword', '初始密码', '123456', '创建管理员账号的初始密码');

-- --------------------------------------------------------

--
-- 表的结构 `sys_data`
--

CREATE TABLE `sys_data` (
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `psalt` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `nick_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `head_img` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `sys_data_role`
--

CREATE TABLE `sys_data_role` (
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `sys_department`
--

CREATE TABLE `sys_department` (
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `order_num` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- 转存表中的数据 `sys_department`
--

INSERT INTO `sys_department` (`created_at`, `updated_at`, `id`, `parent_id`, `name`, `order_num`) VALUES
('2020-08-27 03:33:19.000000', '2021-12-11 02:07:42.895409', 1, NULL, '阿里巴巴', 0),
('2020-09-08 05:31:32.426851', '2020-10-07 04:25:31.000000', 2, 1, '管理部门', 0),
('2021-12-07 08:33:18.087878', '2021-12-07 08:33:18.087878', 4, NULL, '草帽海贼团', 0),
('2021-12-07 08:33:45.485870', '2021-12-07 08:58:06.000000', 5, 4, '射手部', 0);

-- --------------------------------------------------------

--
-- 表的结构 `sys_departmentdata`
--

CREATE TABLE `sys_departmentdata` (
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `order_num` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `sys_login_log`
--

CREATE TABLE `sys_login_log` (
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `ua` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- 转存表中的数据 `sys_login_log`
--

INSERT INTO `sys_login_log` (`created_at`, `updated_at`, `id`, `user_id`, `ip`, `time`, `ua`) VALUES
('2021-12-06 14:45:36.324605', '2021-12-06 14:45:36.324605', 1, 1, '192.168.31.150', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.9 Safari/537.36'),
('2021-12-06 14:48:46.906611', '2021-12-06 14:48:46.906611', 2, 1, '192.168.31.150', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.9 Safari/537.36'),
('2021-12-07 02:18:35.739111', '2021-12-07 02:18:35.739111', 3, 1, '192.168.31.150', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.9 Safari/537.36'),
('2021-12-07 02:18:57.701988', '2021-12-07 02:18:57.701988', 4, 1, '192.168.31.150', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.9 Safari/537.36'),
('2021-12-07 02:22:07.016460', '2021-12-07 02:22:07.016460', 5, 1, '192.168.31.150', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.9 Safari/537.36'),
('2021-12-07 02:33:08.577999', '2021-12-07 02:33:08.577999', 6, 4, '192.168.31.150', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.9 Safari/537.36'),
('2021-12-07 02:33:46.958192', '2021-12-07 02:33:46.958192', 7, 4, '192.168.31.150', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.9 Safari/537.36'),
('2021-12-07 02:37:09.126871', '2021-12-07 02:37:09.126871', 8, 4, '192.168.31.150', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.9 Safari/537.36'),
('2021-12-07 02:41:26.419586', '2021-12-07 02:41:26.419586', 9, 4, '192.168.31.150', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.9 Safari/537.36'),
('2021-12-07 02:41:37.841978', '2021-12-07 02:41:37.841978', 10, 4, '192.168.31.150', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.9 Safari/537.36'),
('2021-12-07 03:01:31.587688', '2021-12-07 03:01:31.587688', 11, 4, '192.168.31.150', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.9 Safari/537.36'),
('2021-12-07 03:01:58.392093', '2021-12-07 03:01:58.392093', 12, 4, '192.168.31.150', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.9 Safari/537.36'),
('2021-12-07 03:05:10.021246', '2021-12-07 03:05:10.021246', 13, 4, '192.168.31.150', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.9 Safari/537.36'),
('2021-12-07 03:05:42.745985', '2021-12-07 03:05:42.745985', 14, 4, '192.168.31.150', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.9 Safari/537.36'),
('2021-12-07 06:35:06.455041', '2021-12-07 06:35:06.455041', 15, 4, '192.168.31.150', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.9 Safari/537.36'),
('2021-12-07 06:42:30.551542', '2021-12-07 06:42:30.551542', 16, 1, '192.168.31.150', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.9 Safari/537.36'),
('2021-12-07 06:43:46.054325', '2021-12-07 06:43:46.054325', 17, 4, '192.168.31.150', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.9 Safari/537.36'),
('2021-12-07 06:44:16.620960', '2021-12-07 06:44:16.620960', 18, 4, '192.168.31.150', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.9 Safari/537.36'),
('2021-12-07 06:44:40.031773', '2021-12-07 06:44:40.031773', 19, 1, '192.168.31.150', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.9 Safari/537.36'),
('2021-12-08 07:11:22.066005', '2021-12-08 07:11:22.066005', 20, 6, '192.168.31.150', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.9 Safari/537.36'),
('2021-12-08 07:12:54.619039', '2021-12-08 07:12:54.619039', 21, 1, '192.168.31.150', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.9 Safari/537.36'),
('2021-12-09 07:18:01.418631', '2021-12-09 07:18:01.418631', 22, 1, '192.168.31.150', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.9 Safari/537.36'),
('2021-12-10 07:24:04.789272', '2021-12-10 07:24:04.789272', 23, 1, '192.168.31.150', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.9 Safari/537.36'),
('2021-12-10 09:18:23.281810', '2021-12-10 09:18:23.281810', 24, 1, '192.168.31.150', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.9 Safari/537.36'),
('2021-12-11 01:50:36.837912', '2021-12-11 01:50:36.837912', 25, 1, '127.0.0.1', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36'),
('2021-12-11 01:58:56.413154', '2021-12-11 01:58:56.413154', 26, 1, '127.0.0.1', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36'),
('2022-03-10 16:35:00.563373', '2022-03-10 16:35:00.563373', 27, 1, '192.168.135.73', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36'),
('2022-03-16 16:55:09.932471', '2022-03-16 16:55:09.932471', 28, 1, '127.0.0.1', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36'),
('2022-03-28 19:11:56.411868', '2022-03-28 19:11:56.411868', 29, 6, '127.0.0.1', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.9 Safari/537.36'),
('2022-03-28 19:37:11.793517', '2022-03-28 19:37:11.793517', 30, 6, '127.0.0.1', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.9 Safari/537.36'),
('2022-03-28 22:53:28.078204', '2022-03-28 22:53:28.078204', 31, 6, '127.0.0.1', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36'),
('2022-03-28 22:54:01.073764', '2022-03-28 22:54:01.073764', 32, 1, '127.0.0.1', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36');

-- --------------------------------------------------------

--
-- 表的结构 `sys_menu`
--

CREATE TABLE `sys_menu` (
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `router` varchar(255) DEFAULT NULL,
  `perms` varchar(255) DEFAULT NULL,
  `type` tinyint(4) NOT NULL DEFAULT '0',
  `icon` varchar(255) DEFAULT NULL,
  `order_num` int(11) DEFAULT '0',
  `view_path` varchar(255) DEFAULT NULL,
  `keepalive` tinyint(4) DEFAULT '1',
  `is_show` tinyint(4) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- 转存表中的数据 `sys_menu`
--

INSERT INTO `sys_menu` (`created_at`, `updated_at`, `id`, `parent_id`, `name`, `router`, `perms`, `type`, `icon`, `order_num`, `view_path`, `keepalive`, `is_show`) VALUES
('2020-08-28 10:09:26.322745', '2021-12-08 14:51:06.321615', 1, NULL, '系统', '/sys', NULL, 0, 'icon-shezhi', 255, NULL, 1, 1),
('2020-08-01 00:00:00.000000', '2021-12-08 14:52:50.706798', 3, 1, '权限管理', '/sys/permssion', NULL, 0, 'icon-quanxian', 0, '', 1, 1),
('2020-08-08 00:00:00.000000', '2021-12-08 14:53:35.058763', 4, 3, '用户列表', '/sys/permssion/user', NULL, 1, 'icon-yonghu', 0, 'views/system/permission/user', 1, 1),
('2020-08-15 00:00:00.000000', '2020-09-11 06:11:52.000000', 5, 4, '新增', NULL, 'sys:user:add', 2, NULL, 0, NULL, 1, 1),
('2020-08-15 00:00:00.000000', '2020-09-11 06:13:03.000000', 6, 4, '删除', NULL, 'sys:user:delete', 2, NULL, 0, NULL, 1, 1),
('2020-08-08 00:00:00.000000', '2021-12-08 15:05:56.443267', 7, 3, '菜单列表', '/sys/permssion/menu', NULL, 1, 'icon-tiaoxingtu', 0, 'views/system/permission/menu', 1, 1),
('2020-08-15 00:00:00.000000', '2020-08-15 00:00:00.000000', 8, 7, '新增', NULL, 'sys:menu:add', 2, NULL, 0, NULL, 1, 0),
('2020-08-15 00:00:00.000000', '2020-08-15 00:00:00.000000', 9, 7, '删除', NULL, 'sys:menu:delete', 2, NULL, 0, NULL, 1, 1),
('2020-09-02 08:22:27.548410', '2020-09-02 08:22:27.548410', 10, 7, '查询', NULL, 'sys:menu:list,sys:menu:info', 2, NULL, 0, NULL, 1, 1),
('2020-09-04 06:26:36.408290', '2020-09-04 07:13:30.000000', 17, 16, '测试', '', 'sys:menu:list,sys:menu:update,sys:menu:info,sys:menu:add', 2, '', 0, '', 1, 1),
('2020-09-04 08:08:53.621419', '2020-09-04 08:08:53.621419', 19, 7, '修改', '', 'sys:menu:update', 2, '', 0, '', 1, 1),
('2021-04-12 04:28:03.312443', '2021-04-20 10:18:22.000000', 20, 4, '部门移动排序', NULL, 'sys:dept:move', 2, NULL, 255, NULL, 1, 1),
('2020-09-04 09:41:43.133191', '2021-12-08 15:05:56.465526', 23, 3, '角色列表', '/sys/permission/role', '', 1, 'icon-jiaosequanxian', 0, 'views/system/permission/role', 1, 1),
('2020-09-07 02:44:27.663925', '2020-09-07 08:51:18.000000', 25, 23, '删除', '', 'sys:role:delete', 2, '', 0, '', 1, 1),
('2020-09-07 07:08:18.106272', '2020-09-14 10:26:58.000000', 28, 23, '新增', '', 'sys:role:add', 2, '', 0, '', 1, 1),
('2020-09-07 08:51:48.319938', '2020-09-07 08:51:58.000000', 29, 23, '修改', '', 'sys:role:update', 2, '', 0, '', 1, 1),
('2020-09-07 10:39:50.396350', '2020-09-09 06:34:13.000000', 32, 23, '查询', '', 'sys:role:list,sys:role:page,sys:role:info', 2, '', 0, '', 1, 1),
('2020-09-08 05:29:40.117403', '2020-09-11 06:03:43.000000', 33, 4, '部门查询', '', 'sys:dept:list,sys:dept:info', 2, '', 0, '', 1, 1),
('2020-09-09 07:10:08.435753', '2020-09-10 03:41:32.000000', 34, 4, '查询', '', 'sys:user:page,sys:user:info', 2, '', 0, '', 1, 1),
('2020-09-10 05:09:31.904519', '2020-09-10 05:09:31.904519', 35, 4, '更新', '', 'sys:user:update', 2, '', 0, '', 1, 1),
('2020-09-10 08:02:29.853643', '2020-09-10 08:02:40.000000', 36, 4, '部门转移', '', 'sys:dept:transfer', 2, '', 0, '', 1, 1),
('2020-09-11 04:34:00.379002', '2021-12-08 15:07:26.598749', 37, 1, '系统监控', '/sys/monitor', '', 0, 'icon-jiankong1', 0, '', 1, 1),
('2020-09-11 06:12:14.621531', '2020-09-11 06:12:14.621531', 39, 4, '部门新增', '', 'sys:dept:add', 2, '', 0, '', 1, 1),
('2020-09-11 06:13:23.752133', '2020-09-11 06:13:23.752133', 40, 4, '部门删除', '', 'sys:dept:delete', 2, '', 0, '', 1, 1),
('2020-09-11 06:29:52.437621', '2020-09-11 06:29:52.437621', 41, 4, '部门更新', '', 'sys:dept:update', 2, '', 0, '', 1, 1),
('2020-10-12 10:00:49.463487', '2021-12-08 15:07:26.612982', 51, 37, '在线用户', '/sys/monitor/online', NULL, 1, 'icon-zaixianyonghujiankong', 0, 'views/system/monitor/online', 1, 1),
('2020-10-13 03:01:13.787832', '2020-10-13 03:01:13.787832', 52, 51, '查询', '', 'sys:online:list', 2, '', 0, '', 1, 1),
('2020-10-13 03:01:51.480667', '2020-10-13 03:01:51.480667', 53, 51, '下线', '', 'sys:online:kick', 2, '', 0, '', 1, 1),
('2020-10-13 09:52:08.932501', '2021-12-08 15:13:05.157628', 55, 37, '登录日志', '/sys/monitor/login-log', NULL, 1, 'icon-guide', 0, 'views/system/monitor/login-log', 1, 1),
('2020-10-13 09:56:13.285772', '2020-10-13 09:56:13.285772', 56, 55, '查询', '', 'sys:log:login:page', 2, '', 0, '', 1, 1),
('2020-10-19 03:07:18.221647', '2021-12-08 15:13:46.373858', 57, 1, '任务调度', '/sys/schedule', NULL, 0, 'icon-rizhi1', 0, '', 1, 1),
('2020-10-19 03:08:15.925726', '2021-12-08 15:13:05.188350', 58, 57, '定时任务', '/sys/schedule/task', NULL, 1, 'icon-dingshirenwuguanli', 0, 'views/system/schedule/task', 1, 1),
('2020-10-19 03:08:36.247678', '2020-10-19 03:08:36.247678', 59, 58, '查询', '', 'sys:task:page,sys:task:info', 2, '', 0, '', 1, 1),
('2020-10-19 03:09:09.436949', '2020-10-19 03:09:09.436949', 60, 58, '新增', '', 'sys:task:add', 2, '', 0, '', 1, 1),
('2020-10-19 03:09:42.895534', '2020-10-19 03:09:42.895534', 61, 58, '更新', '', 'sys:task:update', 2, '', 0, '', 1, 1),
('2020-10-19 05:45:30.512641', '2020-10-19 05:45:30.512641', 62, 58, '执行一次', '', 'sys:task:once', 2, '', 0, '', 1, 1),
('2020-10-19 05:46:01.910857', '2020-10-19 05:46:01.910857', 63, 58, '运行', '', 'sys:task:start', 2, '', 0, '', 1, 1),
('2020-10-19 05:46:23.694028', '2020-10-19 05:46:23.694028', 64, 58, '暂停', '', 'sys:task:stop', 2, '', 0, '', 1, 1),
('2020-10-19 06:25:52.225518', '2020-10-19 06:25:52.225518', 65, 58, '删除', '', 'sys:task:delete', 2, '', 0, '', 1, 1),
('2020-10-19 07:30:18.456330', '2021-12-08 15:16:03.187915', 66, 57, '任务日志', '/sys/schedule/log', NULL, 1, 'icon-rizhi1', 0, 'views/system/schedule/log', 1, 1),
('2020-10-19 08:09:49.063343', '2020-10-19 08:09:49.063343', 67, 66, '查询', '', 'sys:log:task:page', 2, '', 0, '', 1, 1),
('2021-04-21 08:54:41.018924', '2021-04-21 08:54:41.018924', 68, 4, '更改密码', NULL, 'sys:user:password', 2, NULL, 255, NULL, 1, 1),
('2022-03-11 01:20:42.194253', '2022-03-11 01:26:46.340768', 69, 37, '服务监控', '/sys/monitor/serve', NULL, 1, 'zaixianyonghujiankong', 255, 'views/system/monitor/serve', 1, 1),
('2022-03-11 01:22:47.542216', '2022-03-11 01:26:46.351888', 70, 37, '请求日志', '/sys/schedule/req-log', NULL, 1, 'zhexiantu', 255, 'views/system/monitor/req-log', 1, 1),
('2021-05-16 01:40:03.423681', '2021-05-16 01:40:03.423681', 74, 73, '查询', NULL, 'netdisk:manage:list', 2, NULL, 255, NULL, 1, 1),
('2021-05-16 01:40:27.605473', '2021-05-16 01:40:27.605473', 75, 73, '创建文件夹', NULL, 'netdisk:manage:mkdir', 2, NULL, 255, NULL, 1, 1),
('2021-05-16 01:40:42.986572', '2021-05-16 01:40:42.986572', 76, 73, '上传', NULL, 'netdisk:manage:token', 2, NULL, 255, NULL, 1, 1),
('2021-05-16 01:40:57.687251', '2021-05-16 01:41:36.000000', 77, 73, '重命名', NULL, 'netdisk:manage:rename,netdisk:manage:check', 2, NULL, 255, NULL, 1, 1),
('2021-05-16 01:41:15.070191', '2021-05-16 01:41:15.070191', 78, 73, '下载', NULL, 'netdisk:manage:download', 2, NULL, 255, NULL, 1, 1),
('2021-05-16 01:41:56.637858', '2021-05-16 01:41:56.637858', 79, 73, '删除', NULL, 'netdisk:manage:delete,netdisk:manage:check', 2, NULL, 255, NULL, 1, 1),
('2021-05-16 01:42:17.793185', '2021-05-16 01:42:17.793185', 80, 73, '预览', NULL, 'netdisk:manage:info', 2, NULL, 255, NULL, 1, 1),
('2021-05-16 23:42:36.775883', '2021-05-16 23:42:36.775883', 81, 73, '备注', NULL, 'netdisk:manage:mark', 2, NULL, 255, NULL, 1, 1),
('2021-05-20 21:53:56.574672', '2021-05-20 21:53:56.574672', 82, 73, '复制', NULL, 'netdisk:manage:check,netdisk:manage:copy', 2, NULL, 255, NULL, 1, 1),
('2021-05-20 21:54:18.770632', '2021-05-20 21:54:18.770632', 83, 73, '剪切', NULL, 'netdisk:manage:check,netdisk:manage:cut', 2, NULL, 255, NULL, 1, 1),
('2021-09-28 03:26:27.243134', '2021-09-28 07:55:44.000000', 87, 86, '查询', NULL, 'sys:param-config:page,sys:param-config:info', 2, NULL, 255, NULL, 1, 1),
('2021-09-28 07:56:03.132765', '2021-09-28 07:56:03.132765', 88, 86, '新增', NULL, 'sys:param-config:add', 2, NULL, 255, NULL, 1, 1),
('2021-09-28 07:56:26.180445', '2021-09-28 07:56:26.180445', 89, 86, '删除', NULL, 'sys:param-config:delete', 2, NULL, 255, NULL, 1, 1),
('2021-09-28 07:56:47.269451', '2021-09-28 07:56:47.269451', 90, 86, '更新', NULL, 'sys:param-config:update', 2, NULL, 255, NULL, 1, 1),
('2021-10-11 09:53:38.305927', '2021-10-12 07:20:18.000000', 91, 37, '服务监控', '/sys/monitor/serve', NULL, 1, 'serve', 255, 'views/system/monitor/serve', 1, 1),
('2022-06-19 20:41:53.014756', '2022-06-19 20:41:53.014756', 92, NULL, '数据库', '/xianlu/data', NULL, 1, 'jiankong1', 255, 'views/xianlu/data', 1, 1),
('2022-06-19 20:42:44.810886', '2022-06-19 20:42:44.810886', 93, 92, '数据库权限', NULL, 'sys:data:add,sys:data:page,sys:data:info,sys:data:update,sys:data:delete,sys:data:password,sys:deptdata:list,sys:deptdata:move,sys:deptdata:update,sys:deptdata:delete,sys:deptdata:add,sys:deptdata:info,sys:deptdata:transfer', 2, NULL, 255, NULL, 1, 1);

-- --------------------------------------------------------

--
-- 表的结构 `sys_req_log`
--

CREATE TABLE `sys_req_log` (
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `id` int(11) NOT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `params` text,
  `action` varchar(100) DEFAULT NULL,
  `method` varchar(15) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `consume_time` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- 表的结构 `sys_role`
--

CREATE TABLE `sys_role` (
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `id` int(11) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `label` varchar(50) NOT NULL,
  `remark` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- 转存表中的数据 `sys_role`
--

INSERT INTO `sys_role` (`created_at`, `updated_at`, `id`, `user_id`, `name`, `label`, `remark`) VALUES
('2020-08-27 03:35:05.000000', '2020-08-27 03:35:05.000000', 1, 'root', 'root', '超级管理员', NULL),
('2021-12-07 02:22:35.593511', '2021-12-07 02:22:35.593511', 2, '1', '海贼王', 'hzw', '草帽路飞'),
('2021-12-10 08:48:04.813126', '2021-12-10 08:48:04.813126', 3, '1', '火影忍者', 'hyrz', '火影村当村长'),
('2021-12-10 08:52:34.057427', '2021-12-10 08:52:34.057427', 4, '1', '王者荣耀', 'wzry', '敌军还有30秒到达战场');

-- --------------------------------------------------------

--
-- 表的结构 `sys_role_department`
--

CREATE TABLE `sys_role_department` (
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- 转存表中的数据 `sys_role_department`
--

INSERT INTO `sys_role_department` (`created_at`, `updated_at`, `id`, `role_id`, `department_id`) VALUES
('2021-12-07 02:22:35.614418', '2021-12-07 02:22:35.614418', 1, 2, 1),
('2021-12-07 02:22:35.614418', '2021-12-07 02:22:35.614418', 2, 2, 2),
('2021-12-10 08:51:47.333155', '2021-12-10 08:51:47.333155', 14, 3, 1),
('2021-12-10 08:51:47.333155', '2021-12-10 08:51:47.333155', 15, 3, 2),
('2021-12-10 08:51:47.333155', '2021-12-10 08:51:47.333155', 16, 3, 4),
('2021-12-10 08:51:47.333155', '2021-12-10 08:51:47.333155', 17, 3, 5),
('2021-12-10 08:52:34.066897', '2021-12-10 08:52:34.066897', 18, 4, 1),
('2021-12-10 08:52:34.066897', '2021-12-10 08:52:34.066897', 19, 4, 2),
('2021-12-10 08:52:34.066897', '2021-12-10 08:52:34.066897', 20, 4, 4),
('2021-12-10 08:52:34.066897', '2021-12-10 08:52:34.066897', 21, 4, 5);

-- --------------------------------------------------------

--
-- 表的结构 `sys_role_departmentdata`
--

CREATE TABLE `sys_role_departmentdata` (
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `sys_role_menu`
--

CREATE TABLE `sys_role_menu` (
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- 转存表中的数据 `sys_role_menu`
--

INSERT INTO `sys_role_menu` (`created_at`, `updated_at`, `id`, `role_id`, `menu_id`) VALUES
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 1, 2, 1),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 2, 2, 3),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 3, 2, 4),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 4, 2, 5),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 5, 2, 6),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 6, 2, 20),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 7, 2, 33),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 8, 2, 34),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 9, 2, 35),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 10, 2, 36),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 11, 2, 39),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 12, 2, 40),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 13, 2, 41),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 14, 2, 68),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 15, 2, 7),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 16, 2, 8),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 17, 2, 9),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 18, 2, 10),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 19, 2, 19),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 20, 2, 23),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 21, 2, 25),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 22, 2, 28),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 23, 2, 29),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 24, 2, 32),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 25, 2, 37),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 31, 2, 57),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 32, 2, 58),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 33, 2, 59),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 34, 2, 60),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 35, 2, 61),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 36, 2, 62),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 37, 2, 63),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 38, 2, 64),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 39, 2, 65),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 40, 2, 66),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 41, 2, 67),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 42, 2, 44),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 43, 2, 26),
('2021-12-07 02:22:35.600066', '2021-12-07 02:22:35.600066', 44, 2, 27),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 45, 3, 1),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 46, 3, 3),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 47, 3, 37),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 48, 3, 57),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 49, 3, 4),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 50, 3, 7),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 51, 3, 23),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 52, 3, 51),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 53, 3, 55),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 54, 3, 58),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 55, 3, 66),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 56, 3, 5),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 57, 3, 6),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 58, 3, 20),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 59, 3, 33),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 60, 3, 34),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 61, 3, 35),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 62, 3, 36),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 63, 3, 39),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 64, 3, 40),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 65, 3, 41),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 66, 3, 68),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 67, 3, 8),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 68, 3, 9),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 69, 3, 10),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 70, 3, 19),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 71, 3, 25),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 72, 3, 28),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 73, 3, 29),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 74, 3, 32),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 75, 3, 52),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 76, 3, 53),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 77, 3, 56),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 78, 3, 59),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 79, 3, 60),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 80, 3, 61),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 81, 3, 62),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 82, 3, 63),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 83, 3, 64),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 84, 3, 65),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 85, 3, 67),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 86, 3, 44),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 87, 3, 26),
('2021-12-10 08:48:04.821154', '2021-12-10 08:48:04.821154', 88, 3, 27),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 89, 4, 3),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 90, 4, 57),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 91, 4, 4),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 92, 4, 7),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 93, 4, 23),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 94, 4, 51),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 95, 4, 58),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 96, 4, 66),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 97, 4, 5),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 98, 4, 6),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 99, 4, 20),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 100, 4, 33),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 101, 4, 34),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 102, 4, 35),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 103, 4, 36),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 104, 4, 39),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 105, 4, 40),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 106, 4, 41),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 107, 4, 68),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 108, 4, 8),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 109, 4, 9),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 110, 4, 10),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 111, 4, 19),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 112, 4, 25),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 113, 4, 28),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 114, 4, 29),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 115, 4, 32),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 116, 4, 52),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 117, 4, 53),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 118, 4, 59),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 119, 4, 60),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 120, 4, 61),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 121, 4, 62),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 122, 4, 63),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 123, 4, 64),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 124, 4, 65),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 125, 4, 67),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 126, 4, 44),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 127, 4, 26),
('2021-12-10 08:52:34.061582', '2021-12-10 08:52:34.061582', 128, 4, 27),
('2022-03-28 22:55:14.797600', '2022-03-28 22:55:14.797600', 150, 2, 55),
('2022-03-28 22:55:14.797600', '2022-03-28 22:55:14.797600', 151, 2, 56),
('2022-03-28 22:55:14.797600', '2022-03-28 22:55:14.797600', 152, 2, 70),
('2022-03-28 22:55:35.026831', '2022-03-28 22:55:35.026831', 153, 2, 69),
('2022-03-28 22:57:03.949897', '2022-03-28 22:57:03.949897', 154, 2, 84);

-- --------------------------------------------------------

--
-- 表的结构 `sys_task`
--

CREATE TABLE `sys_task` (
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `service` varchar(255) NOT NULL,
  `type` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `limit` int(11) DEFAULT '0',
  `cron` varchar(255) DEFAULT NULL,
  `every` int(11) DEFAULT NULL,
  `data` text,
  `job_opts` text,
  `remark` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- 转存表中的数据 `sys_task`
--

INSERT INTO `sys_task` (`created_at`, `updated_at`, `id`, `name`, `service`, `type`, `status`, `start_time`, `end_time`, `limit`, `cron`, `every`, `data`, `job_opts`, `remark`) VALUES
('2020-10-19 08:54:42.760785', '2022-06-19 20:37:16.000000', 2, '定时清空登录日志', 'SysLogClearJob.clearLoginLog', 0, 1, NULL, NULL, 0, '0 0 3 ? * 1', 0, '', '{\"count\":1,\"key\":\"__default__:2:::0 0 3 ? * 1\",\"cron\":\"0 0 3 ? * 1\",\"jobId\":2}', ''),
('2020-10-19 08:55:06.050711', '2022-06-19 20:37:16.000000', 3, '定时清空任务日志', 'SysLogClearJob.clearTaskLog', 0, 1, NULL, NULL, 0, '0 0 3 ? * 1', 0, '', '{\"count\":1,\"key\":\"__default__:3:::0 0 3 ? * 1\",\"cron\":\"0 0 3 ? * 1\",\"jobId\":3}', '');

-- --------------------------------------------------------

--
-- 表的结构 `sys_task_log`
--

CREATE TABLE `sys_task_log` (
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `detail` text,
  `consume_time` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- 表的结构 `sys_user`
--

CREATE TABLE `sys_user` (
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nick_name` varchar(255) DEFAULT NULL,
  `head_img` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `psalt` varchar(32) NOT NULL,
  `status` tinyint(4) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- 转存表中的数据 `sys_user`
--

INSERT INTO `sys_user` (`created_at`, `updated_at`, `id`, `department_id`, `name`, `username`, `password`, `nick_name`, `head_img`, `email`, `phone`, `remark`, `psalt`, `status`) VALUES
('2020-08-27 03:38:30.000000', '2022-03-28 22:52:11.845930', 1, 1, '路飞', 'rootadmin', 'ccdb5f7e5be14fe0c0528974428f79f9', '', 'https://buqiyuan.gitee.io/img/logo.jpg', 'qa894178522@qq.com', '15622472425', NULL, 'xQYCspvFb8cAW6GG1pOoUGTLqsuUSO3d', 1),
('2021-12-07 09:29:18.844687', '2021-12-10 13:24:34.000000', 6, 2, '路飞', 'luffyfe', 'a201c32f60232acaf95d9eb74926c8aa', '草帽小子', NULL, '1687646846@qq.com', '1355355646', '嘿嘿嘿', 'WdE7MrslDYt02ZNkGo4asBhpXXY57wzi', 1),
('2022-03-28 19:58:49.997872', '2022-03-28 23:07:08.880455', 7, 4, '娜美', 'nameife', '633564908884bf807c4fcbf260f711d2', NULL, NULL, NULL, NULL, NULL, 'U2KPLYZcUWqpghjRHy07YbPt2A8WV285', 1);

-- --------------------------------------------------------

--
-- 表的结构 `sys_user_role`
--

CREATE TABLE `sys_user_role` (
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- 转存表中的数据 `sys_user_role`
--

INSERT INTO `sys_user_role` (`created_at`, `updated_at`, `id`, `user_id`, `role_id`) VALUES
('2020-09-14 04:10:34.371646', '2020-09-14 04:10:34.371646', 1, 1, 1),
('2021-12-07 09:29:18.848535', '2021-12-07 09:29:18.848535', 16, 6, 2),
('2022-03-28 19:58:50.002528', '2022-03-28 19:58:50.002528', 17, 7, 2);

--
-- 转储表的索引
--

--
-- 表的索引 `sys_config`
--
ALTER TABLE `sys_config`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `IDX_2c363c25cf99bcaab3a7f389ba` (`key`);

--
-- 表的索引 `sys_data`
--
ALTER TABLE `sys_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `IDX_4a33c047d8eacc0964e6b8adc4` (`username`);

--
-- 表的索引 `sys_data_role`
--
ALTER TABLE `sys_data_role`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `sys_department`
--
ALTER TABLE `sys_department`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `sys_departmentdata`
--
ALTER TABLE `sys_departmentdata`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `sys_login_log`
--
ALTER TABLE `sys_login_log`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `sys_menu`
--
ALTER TABLE `sys_menu`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `sys_req_log`
--
ALTER TABLE `sys_req_log`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `sys_role`
--
ALTER TABLE `sys_role`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `IDX_223de54d6badbe43a5490450c3` (`name`),
  ADD UNIQUE KEY `IDX_f2d07943355da93c3a8a1c411a` (`label`);

--
-- 表的索引 `sys_role_department`
--
ALTER TABLE `sys_role_department`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `sys_role_departmentdata`
--
ALTER TABLE `sys_role_departmentdata`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `sys_role_menu`
--
ALTER TABLE `sys_role_menu`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `sys_task`
--
ALTER TABLE `sys_task`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `IDX_ef8e5ab5ef2fe0ddb1428439ef` (`name`);

--
-- 表的索引 `sys_task_log`
--
ALTER TABLE `sys_task_log`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `sys_user`
--
ALTER TABLE `sys_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `IDX_9e7164b2f1ea1348bc0eb0a7da` (`username`);

--
-- 表的索引 `sys_user_role`
--
ALTER TABLE `sys_user_role`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `sys_config`
--
ALTER TABLE `sys_config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `sys_data`
--
ALTER TABLE `sys_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `sys_data_role`
--
ALTER TABLE `sys_data_role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `sys_department`
--
ALTER TABLE `sys_department`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- 使用表AUTO_INCREMENT `sys_departmentdata`
--
ALTER TABLE `sys_departmentdata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `sys_login_log`
--
ALTER TABLE `sys_login_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- 使用表AUTO_INCREMENT `sys_menu`
--
ALTER TABLE `sys_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;

--
-- 使用表AUTO_INCREMENT `sys_req_log`
--
ALTER TABLE `sys_req_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `sys_role`
--
ALTER TABLE `sys_role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `sys_role_department`
--
ALTER TABLE `sys_role_department`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- 使用表AUTO_INCREMENT `sys_role_departmentdata`
--
ALTER TABLE `sys_role_departmentdata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `sys_role_menu`
--
ALTER TABLE `sys_role_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=155;

--
-- 使用表AUTO_INCREMENT `sys_task`
--
ALTER TABLE `sys_task`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- 使用表AUTO_INCREMENT `sys_task_log`
--
ALTER TABLE `sys_task_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `sys_user`
--
ALTER TABLE `sys_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- 使用表AUTO_INCREMENT `sys_user_role`
--
ALTER TABLE `sys_user_role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
