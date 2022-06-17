-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2022-06-17 14:37:34
-- 服务器版本： 5.7.26
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
-- 数据库： `shoes`
--

-- --------------------------------------------------------

--
-- 表的结构 `shoes_activity`
--

CREATE TABLE `shoes_activity` (
  `id` int(11) NOT NULL,
  `activity_name` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='相关活动表';

--
-- 转存表中的数据 `shoes_activity`
--

INSERT INTO `shoes_activity` (`id`, `activity_name`) VALUES
(1, '今日上新'),
(2, '促销商品'),
(3, '无活动');

-- --------------------------------------------------------

--
-- 表的结构 `shoes_address`
--

CREATE TABLE `shoes_address` (
  `id` int(11) NOT NULL,
  `consignee_name` varchar(255) NOT NULL,
  `consignee_address` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `uid` int(11) NOT NULL COMMENT '用户id'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `shoes_address`
--

INSERT INTO `shoes_address` (`id`, `consignee_name`, `consignee_address`, `phone`, `uid`) VALUES
(1, '柳龙辉', '河北省石家庄市河北工程技术学院', '18032198647', 1),
(3, '柳龙辉', '北京市通州区宋庄镇尹各庄', '18032198647', 1),
(4, '张三', '河北省邯郸市临漳县杜村乡', '156987463254', 4),
(5, '李四', '河北省邯郸市临漳县杜村乡', '13598745632', 3),
(7, '柳龙辉', '北京市朝阳区北辰世纪中心A座', '18032198647', 1),
(8, '张三', '山东省菏泽市小猪村', '15910394182', 5),
(11, '薛之谦', '北京市朝阳区远洋别墅', '18963547896', 12),
(12, '姚明', '上海市浦东新区临沂北路210弄1-13号', '13654229966', 12),
(13, '柳龙辉', '北京市朝阳区孙河乡前苇沟', '15910394182', 2);

-- --------------------------------------------------------

--
-- 表的结构 `shoes_banner`
--

CREATE TABLE `shoes_banner` (
  `id` int(11) NOT NULL COMMENT 'id',
  `imgurl` varchar(255) NOT NULL COMMENT 'banner路径',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `shoes_banner`
--

INSERT INTO `shoes_banner` (`id`, `imgurl`, `create_time`, `update_time`) VALUES
(1, '/imgs/banner.png', '2021-10-18 14:38:39', '2021-10-18 14:38:39'),
(2, '/imgs/banner02.png', '2021-10-18 14:38:48', '2021-10-18 14:38:48'),
(3, '/imgs/banner03.png', '2021-10-18 14:56:08', '2021-10-18 14:56:08');

-- --------------------------------------------------------

--
-- 表的结构 `shoes_brand`
--

CREATE TABLE `shoes_brand` (
  `id` int(11) NOT NULL,
  `brand_name` varchar(255) NOT NULL,
  `imgurlb` varchar(255) NOT NULL,
  `cid` int(11) NOT NULL COMMENT '分类id'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='品牌表';

--
-- 转存表中的数据 `shoes_brand`
--

INSERT INTO `shoes_brand` (`id`, `brand_name`, `imgurlb`, `cid`) VALUES
(1, '鸿星尔克', '/imgs/brand02.png', 1),
(2, '安踏', '/imgs/brand03.png', 1),
(3, '耐克', '/imgs/brand01.png', 1),
(4, '李宁', '/imgs/brand05.png', 1),
(5, '乔丹', '/imgs/brand06.png', 1),
(6, '阿迪达斯', '/imgs/brand07.png', 1),
(7, '纽巴伦', '/imgs/brand08.png', 1),
(8, 'SWITCH', '/imgs/sale_one.png', 3),
(9, '北面', '/imgs/sale_one.png', 4),
(10, '施华洛世奇', '/imgs/new_three.png', 5),
(11, '李维斯', '/imgs/new_one.png', 4),
(12, 'SSUR', '/imgs/brand05.png', 5),
(13, 'CLIMAX', '/imgs/brand06.png', 4),
(14, 'ewrwrwe', '/imgs/sale_one.png', 2),
(15, 'qewqewqe', '/imgs/sale_one.png', 2),
(16, 'adadwad', '/imgs/sale_one.png', 2),
(17, 'erge', '/imgs/sale_one.png', 2),
(18, 'bcfbcfb', '/imgs/sale_one.png', 3),
(19, 'bbcbgcnc', '/imgs/sale_one.png', 3),
(20, 'jgjgjhgjhg', '/imgs/sale_one.png', 3),
(21, 'mmjmjmjmj', '/imgs/sale_one.png', 3),
(22, 'oioioioioi', '/imgs/sale_one.png', 4),
(23, 'plplplpoi', '/imgs/sale_one.png', 4),
(24, 'fgfgfgfg', '/imgs/sale_one.png', 5),
(25, 'jhjhjhjhjh', '/imgs/sale_one.png', 5),
(26, '回力', '/imgs/huili.jpg', 1);

-- --------------------------------------------------------

--
-- 表的结构 `shoes_cart`
--

CREATE TABLE `shoes_cart` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `goods_id` int(11) NOT NULL COMMENT '商品id',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '勾选状态'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='购物车表';

--
-- 转存表中的数据 `shoes_cart`
--

INSERT INTO `shoes_cart` (`id`, `user_id`, `goods_id`, `status`) VALUES
(175, 1, 1, 1),
(176, 1, 7, 1),
(6, 2, 0, 1),
(7, 3, 8, 1),
(8, 3, 4, 1),
(28, 5, 1, 1),
(29, 5, 7, 1),
(164, 2, 8, 1),
(163, 2, 1, 0);

-- --------------------------------------------------------

--
-- 表的结构 `shoes_category`
--

CREATE TABLE `shoes_category` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `imgurlc` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='分类表';

--
-- 转存表中的数据 `shoes_category`
--

INSERT INTO `shoes_category` (`id`, `name`, `imgurlc`) VALUES
(1, '潮鞋', '/headpicture/20211118/baaebff6c250d8240fc4ed8d81d79b09.png'),
(2, '包袋', '/headpicture/20211118/282ec0b336947995bfeaea4a863e6343.png'),
(3, '腕表', '/headpicture/20211118/4f87f9c3403e7f8f0066c179762130de.png'),
(4, '服饰', '/headpicture/20211118/408043bdec4135383c0dd117e2b940e4.png'),
(5, '配饰', '/headpicture/20211118/6d97816534a9697c0d9f54e3241bf88e.png');

-- --------------------------------------------------------

--
-- 表的结构 `shoes_condition`
--

CREATE TABLE `shoes_condition` (
  `id` int(11) NOT NULL,
  `condition_name` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='成色表';

--
-- 转存表中的数据 `shoes_condition`
--

INSERT INTO `shoes_condition` (`id`, `condition_name`) VALUES
(1, '99成新'),
(2, '98成新'),
(3, '95成新'),
(4, '9成新'),
(5, '85成新'),
(6, '8成新');

-- --------------------------------------------------------

--
-- 表的结构 `shoes_discount`
--

CREATE TABLE `shoes_discount` (
  `id` int(11) NOT NULL,
  `discount_price` int(11) NOT NULL COMMENT '优惠价格',
  `discount_name` varchar(255) NOT NULL COMMENT '满减',
  `image` varchar(255) NOT NULL,
  `num` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='优惠卷表';

--
-- 转存表中的数据 `shoes_discount`
--

INSERT INTO `shoes_discount` (`id`, `discount_price`, `discount_name`, `image`, `num`) VALUES
(1, 20, '满200减20', '/imgs/sale_img_one.png', 6),
(2, 50, '满500减50', '/imgs/sale_img_two.png', 34),
(3, 80, '满800减80', '/imgs/sale_img_three.png', 41);

-- --------------------------------------------------------

--
-- 表的结构 `shoes_freeshipping`
--

CREATE TABLE `shoes_freeshipping` (
  `id` int(11) NOT NULL,
  `freeShipping_name` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='是否包邮表';

--
-- 转存表中的数据 `shoes_freeshipping`
--

INSERT INTO `shoes_freeshipping` (`id`, `freeShipping_name`) VALUES
(1, '是'),
(2, '否');

-- --------------------------------------------------------

--
-- 表的结构 `shoes_goods`
--

CREATE TABLE `shoes_goods` (
  `id` int(11) NOT NULL,
  `goods_name` varchar(255) NOT NULL,
  `newprice` int(11) NOT NULL,
  `oldprice` int(11) NOT NULL,
  `imgurl` varchar(255) NOT NULL,
  `size` varchar(255) DEFAULT NULL COMMENT '尺码',
  `cid` int(11) NOT NULL DEFAULT '0' COMMENT '分类id',
  `bid` int(11) NOT NULL DEFAULT '0' COMMENT '品牌id',
  `aid` int(11) NOT NULL DEFAULT '3' COMMENT '活动id',
  `coid` int(11) NOT NULL DEFAULT '0' COMMENT '成色id',
  `tid` int(11) NOT NULL DEFAULT '0' COMMENT '发货时间id',
  `fsid` int(11) NOT NULL DEFAULT '0' COMMENT '是否包邮id',
  `rid` int(1) NOT NULL DEFAULT '0' COMMENT '推荐id',
  `uid` int(11) DEFAULT NULL COMMENT '用户id'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='商品表';

--
-- 转存表中的数据 `shoes_goods`
--

INSERT INTO `shoes_goods` (`id`, `goods_name`, `newprice`, `oldprice`, `imgurl`, `size`, `cid`, `bid`, `aid`, `coid`, `tid`, `fsid`, `rid`, `uid`) VALUES
(1, 'Air Jordan 1 Low Shadow黑白灰 影子', 529, 729, '/headpicture/20211116/e7592e7bb3ac80419b9337bff12a2997.png', '38码', 1, 5, 1, 1, 1, 1, 0, NULL),
(2, 'Air Jordan 1 Mid HyperRoyal 皇家蓝', 599, 679, '/headpicture/20211116/9f3ed75e1df896dc865a08f8edcbb3be.png', '39码', 1, 5, 3, 2, 2, 1, 0, NULL),
(3, 'SWITCH瑞士手表', 149, 439, '/headpicture/20211116/1a5b9540c85c044a9477b1ecc5d1947c.png', 'large', 3, 8, 2, 5, 2, 2, 1, NULL),
(4, 'NIKE AIR MAX 720-818鞋', 409, 539, '/headpicture/20211116/e699012706d800884c018da921055caa.png', '43码', 1, 9, 2, 4, 2, 2, 1, NULL),
(5, 'NIKE 跑步鞋', 439, 499, '/headpicture/20211116/6a9149eb6ff7d26e40da220b39db4b94.png', '44码', 1, 3, 2, 1, 1, 1, 1, NULL),
(6, 'AJ1 倒勾 好看的', 3809, 4999, '/headpicture/20211116/de25e674bcbb89a3e21652e764fa3db7.png', '39码', 1, 5, 3, 3, 2, 1, 0, NULL),
(7, 'THE NORTH FACE联名款', 469, 599, '/headpicture/20211116/045f664770a7d9998f5271e8b45dbe6b.png', 'L', 4, 9, 1, 2, 2, 1, 1, NULL),
(8, 'SSUR PLUSxICONSLAB项链', 329, 599, '/headpicture/20211116/cdb71a7f3bb113c5250f2708d4bd865b.png', 'large', 5, 12, 1, 3, 1, 1, 1, NULL),
(9, 'CLIMAX VISION西裤装', 338, 438, '/headpicture/20211116/0ed840d0612eba9b4a0c7306b258c6d4.jpg', 'XL', 4, 13, 1, 2, 1, 2, 1, NULL),
(10, 'hahahahahha', 299, 300, '/headpicture/20211116/1aa7281851eea2f05b6b0fef07131833.jpg', '45码', 1, 1, 1, 1, 1, 1, 0, NULL),
(11, 'lalalalalala', 399, 599, '/headpicture/20211116/f6ad427ea92454df5e5e483bf7e550e1.jpg', 'medium', 2, 2, 2, 2, 2, 2, 1, NULL),
(12, 'qqqqqwqewqeqweqw', 2000, 3999, '/headpicture/20211116/2ff2bf072459ac6d685f470f87f35aaa.png', 'medium', 3, 3, 3, 3, 3, 1, 0, NULL),
(16, 'PRADA手提包', 399, 599, '/headpicture/20211116/1df7928f1575ba92c9fc1706c90990da.jpg', 'medium ', 2, 2, 2, 2, 2, 2, 0, NULL),
(20, 'k;kkjkl', 898, 1233, '/headpicture/20211116/4ed3dc6e16b3c32bf5217b3557c2a37a.jpg', 'large', 2, 16, 3, 1, 2, 2, 0, NULL),
(17, '鸿星尔克蓝色跑步鞋', 199, 499, '/headpicture/20211116/e07291e61e4e8b0b37a8b6650167d472.png', '45码', 1, 1, 3, 1, 1, 1, 1, NULL),
(18, 'NIKE黑色跑步鞋', 499, 599, '/headpicture/20211116/9ba76e7dccb0dae92e1b717ccefc0981.png', '43码', 1, 3, 3, 2, 2, 2, 1, NULL),
(38, '乌拉乌拉', 699, 999, '/uploads/20211117/c4833ee833b69a9ef2e4ab818f77ab31.jpg', '45码', 1, 4, 3, 6, 4, 1, 0, NULL),
(21, '啊德瓦达达娃', 122, 313, '/uploads/20211110/c3312d96c99690fc4ff0a7079f36ba3d.jpg', NULL, 1, 3, 3, 3, 3, 2, 0, NULL),
(43, '白蓝色画布', 20, 20, '/uploads/20220313/06174cfcd093d665fc92902689447f6e.jpg', '小', 1, 3, 3, 3, 2, 2, 0, 1),
(23, '啦啦啦啦啦', 1111, 2222, '/uploads/20211110/6c0dc349476c3e63dcc05b1339a4e93c.jpg', NULL, 1, 0, 3, 0, 0, 0, 0, NULL),
(24, '呃呃呃呃呃', 222, 1111, '/uploads/20211110/4705c9d0c37a8b74ba8b6f97879a3c29.png', NULL, 1, 0, 3, 0, 0, 0, 0, NULL),
(25, '浪琴好表666', 2999, 3999, '/uploads/20211110/27390c44c5bf526e924145ff4ea0a78b.jpg', NULL, 3, 19, 3, 3, 4, 1, 1, 1),
(26, '那么那么那么那么那么那么', 1212, 12122, '/uploads/20211110/48fcbae77de7af50b0d57408d6f3ada8.PNG', NULL, 3, 20, 3, 6, 4, 2, 1, 1),
(27, '政策支持下支持下在', 212, 2321, '/uploads/20211110/63764f191ca7a3fd5e0167f4dacd39ea.png', NULL, 3, 19, 3, 3, 2, 2, 0, 1),
(28, '小金猪项链999金', 212, 1312, '/uploads/20211110/35fc4b7e4a419bf2193fdbed93b9c256.png', NULL, 5, 24, 3, 3, 3, 2, 0, 1),
(29, '啊哒哒哒我', 111, 1212, '/uploads/20211110/2a752a0bff7638578195ed105c1f742b.jpg', NULL, 5, 25, 3, 5, 4, 2, 1, NULL),
(42, '哈哈哈', 69, 89, '/uploads/20220213/d34338c2348a0635aa363e7cbdbf6e83.jpg', '无', 1, 26, 3, 3, 1, 2, 0, 2),
(31, 'Air Jordan 11 北卡蓝', 1099, 1399, '/uploads/20211112/8f3dd99c8f5d0602754cde858a087c9a.jpg', '45码', 1, 4, 3, 3, 2, 1, 0, NULL),
(34, 'Air Jordan 1黑棕色', 1999, 2399, '/uploads/20211113/c8a0efd98278e1180975c0a1ebb34f16.png', '43码', 1, 5, 3, 1, 2, 1, 0, NULL),
(37, '哈哈哈哈哈', 3999, 5999, '/uploads/20211116/cc120da46a04b2a49859e5a19a2c6f2c.png', 'L', 2, 16, 3, 2, 2, 2, 0, NULL),
(44, '111', 222, 1212, '/uploads/20220420/bbf31e3b7a783585f627a45668465f30.jpg', 's', 1, 4, 3, 3, 3, 2, 0, 1),
(40, 'erge包包蓝色女性', 6999, 8999, '/uploads/20211125/cf8c69a175e41d5bd0a3ac4fb29cc46b.jpg', '正常码', 2, 17, 3, 2, 4, 1, 0, 1);

-- --------------------------------------------------------

--
-- 表的结构 `shoes_manager`
--

CREATE TABLE `shoes_manager` (
  `id` int(11) NOT NULL COMMENT 'id',
  `username` varchar(255) NOT NULL COMMENT '管理员账户',
  `password` varchar(255) NOT NULL COMMENT '管理员密码',
  `imgurl` varchar(255) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='管理员表';

--
-- 转存表中的数据 `shoes_manager`
--

INSERT INTO `shoes_manager` (`id`, `username`, `password`, `imgurl`, `create_time`, `update_time`) VALUES
(1, 'admin', '123456', '/headpicture/20211116/8dbd8301c880346ddc79fed82f41ac34.jpg', '2021-11-16 04:24:07', '2021-11-16 04:24:07'),
(2, 'liulonghui', '123456', '/headpicture/20211116/2e097403cd191f7a7a96006708de4ee7.jpg', '2021-11-16 04:24:54', '2021-11-16 04:24:54'),
(3, 'zhangsan', '666666', '/headpicture/20211116/8544af7696a49a1cba9d163b5ce99bbf.jpg', '2021-11-16 04:28:47', '2021-11-16 04:28:47'),
(8, 'likui', '123456', '/headpicture/20211116/47c96d19e23765be4ffcd17aa0d42d87.jpg', '2021-11-16 04:32:52', '2021-11-16 04:32:52'),
(7, 'sunquan', '111111', '/headpicture/20211116/97310eaee8e108023cd558edba405f8f.jpg', '2021-11-16 03:53:31', '2021-11-16 03:53:31'),
(12, 'wangwu', '888888', '/headpicture/20211116/208acf24c37a4add5d3c1bc6c18a5edb.jpg', '2021-11-16 03:46:35', '2021-11-16 03:46:35');

-- --------------------------------------------------------

--
-- 表的结构 `shoes_order`
--

CREATE TABLE `shoes_order` (
  `id` int(11) NOT NULL,
  `order_sn` varchar(255) NOT NULL COMMENT '订单编号',
  `order_amount` int(11) NOT NULL COMMENT '订单金额',
  `user_id` int(11) NOT NULL COMMENT '下单用户id',
  `consignee_name` varchar(255) DEFAULT NULL COMMENT '收货人姓名',
  `consignee_phone` varchar(11) DEFAULT NULL COMMENT '收货人手机号',
  `consignee_address` varchar(255) DEFAULT NULL COMMENT '收货人地址'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='订单表';

--
-- 转存表中的数据 `shoes_order`
--

INSERT INTO `shoes_order` (`id`, `order_sn`, `order_amount`, `user_id`, `consignee_name`, `consignee_phone`, `consignee_address`) VALUES
(40, 'Shoes20211121231123040827812', 1287, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(37, 'Shoes20211120215440954699059', 4887, 1, '柳龙辉', '18032198647', '北京市朝阳区北辰世纪中心A座'),
(38, 'Shoes20211120215532071390673', 1297, 1, '柳龙辉', '18032198647', '北京市通州区宋庄镇尹各庄'),
(39, 'Shoes20211120215856267013517', 1018, 5, '张三', '15910394182', '山东省菏泽市小猪爪村'),
(41, 'Shoes20211121232105179850447', 1317, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(42, 'Shoes20211127224528017224917', 658, 1, '柳龙辉', '18032198647', '北京市朝阳区北辰世纪中心A座'),
(43, 'Shoes20211127230817386971939', 748, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(44, 'Shoes20211127230930637350584', 479, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(45, 'Shoes20211127231031196172646', 159, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(46, 'Shoes20211127231207122266648', 399, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(47, 'Shoes20211127231250666013927', 1920, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(48, 'Shoes20211127231419984666322', 419, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(49, 'Shoes20211127231459053776103', 399, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(50, 'Shoes20211127231606054030911', 449, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(51, 'Shoes20211127231753864574485', 549, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(52, 'Shoes20211127232124798013926', 489, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(53, 'Shoes20211127232216862754424', 399, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(54, 'Shoes20211127235150255921486', 309, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(55, 'Shoes20211127235909480010677', 389, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(56, 'Shoes20211128000347000708220', 649, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(57, 'Shoes20211128000444150255288', 309, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(58, 'Shoes20211128000540382113601', 309, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(59, 'Shoes20211128000622377846286', 309, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(60, 'Shoes20211128000751524852670', 2919, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(61, 'Shoes20211128000834574660004', 549, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(62, 'Shoes20211128000901426446412', 549, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(63, 'Shoes20211128001046083443395', 2919, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(64, 'Shoes20211128001227138205140', 1919, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(65, 'Shoes20211128001405095256184', 1077, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(66, 'Shoes20211128001519585090166', 918, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(67, 'Shoes20211128001731949904852', 918, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(68, 'Shoes20211128001828518328900', 778, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(69, 'Shoes20211128001937638229468', 868, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(70, 'Shoes20211128002139882573131', 1017, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(71, 'Shoes20211128122359170387527', 419, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(72, 'Shoes20211128123535621363733', 329, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(73, 'Shoes20211128123739312383660', 449, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(74, 'Shoes20211128123856506535525', 479, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(75, 'Shoes20211128123956695023590', 479, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(76, 'Shoes20211128124001535766417', 479, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(77, 'Shoes20211128124243653708745', 449, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(78, 'Shoes20211128124424387496992', 479, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(79, 'Shoes20211128124941391632978', 580, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(80, 'Shoes20211128133103725074499', 828, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(81, 'Shoes20211128133126286544795', 449, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(82, 'Shoes20211128133138239254881', 479, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(83, 'Shoes20211128133206996728585', 479, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(84, 'Shoes20211128133303021087180', 479, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(85, 'Shoes20211128133325037305524', 3729, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(86, 'Shoes20211128133401441842651', 3729, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(87, 'Shoes20211128133632085521837', 3729, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(88, 'Shoes20211128133711015411106', 309, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(89, 'Shoes20211128133833940859805', 309, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(90, 'Shoes20211128134116190120825', 309, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(91, 'Shoes20211128134209467671243', 3729, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(92, 'Shoes20211128134304063581116', 479, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(93, 'Shoes20211128134357762309034', 3729, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(94, 'Shoes20211128134423033805840', 309, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(95, 'Shoes20211128134452997013071', 479, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(96, 'Shoes20211128134515247719003', 3729, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(97, 'Shoes20211128184532416359640', 399, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(98, 'Shoes20211128190230170448902', 439, 1, '柳龙辉', '18032198647', '北京市朝阳区北辰世纪中心A座'),
(99, 'Shoes20211128212449788297984', 489, 12, '姚明', '13654229966', '上海市浦东新区临沂北路210弄1-13号'),
(100, 'Shoes20211128215824703411841', 578, 12, '姚明', '13654229966', '上海市浦东新区临沂北路210弄1-13号'),
(101, 'Shoes20211128223018124691871', 1142, 12, '薛之谦', '18963547896', '北京市朝阳区远洋别墅'),
(102, 'Shoes20211223064941480809788', 0, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(103, 'Shoes20211223065402296612040', 0, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(104, 'Shoes20211225112207645442147', 479, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(105, 'Shoes20220213152816855684917', 479, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(106, 'Shoes20220213153245219302187', 479, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(107, 'Shoes20220213154239997164557', 29, 1, '柳龙辉', '18032198647', '河北省石家庄市河北工程技术学院'),
(108, 'Shoes20220213161138366233174', 99, 2, '柳龙辉', '15910394182', '北京市朝阳区孙河乡前苇沟'),
(109, 'Shoes20220213175145116538946', 79, 2, '柳龙辉', '15910394182', '北京市朝阳区孙河乡前苇沟'),
(110, 'Shoes20220213222011608421938', 449, 2, '柳龙辉', '15910394182', '北京市朝阳区孙河乡前苇沟'),
(111, 'Shoes20220213223923239076712', 549, 2, '柳龙辉', '15910394182', '北京市朝阳区孙河乡前苇沟'),
(112, 'Shoes20220213224111375393847', 279, 2, '柳龙辉', '15910394182', '北京市朝阳区孙河乡前苇沟'),
(113, 'Shoes20220213225350020686763', 419, 2, '柳龙辉', '15910394182', '北京市朝阳区孙河乡前苇沟'),
(114, 'Shoes20220213225626944412463', 937, 2, '张三太帅', '15910394182', '北京市朝阳区孙河乡前苇沟'),
(115, 'Shoes20220313214228847691966', 30, 1, '柳龙辉', '18032198647', '北京市通州区宋庄镇尹各庄');

-- --------------------------------------------------------

--
-- 表的结构 `shoes_order_goods`
--

CREATE TABLE `shoes_order_goods` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL COMMENT '订单id',
  `goods_id` int(11) NOT NULL COMMENT '商品id',
  `goods_price` int(11) NOT NULL COMMENT '商品价格'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='订单商品表';

--
-- 转存表中的数据 `shoes_order_goods`
--

INSERT INTO `shoes_order_goods` (`id`, `order_id`, `goods_id`, `goods_price`) VALUES
(52, 47, 12, 2000),
(51, 46, 4, 409),
(50, 45, 3, 149),
(49, 44, 1, 529),
(48, 43, 7, 469),
(47, 43, 8, 329),
(46, 42, 18, 499),
(45, 42, 17, 199),
(44, 41, 20, 898),
(43, 41, 11, 399),
(42, 40, 2, 599),
(41, 40, 3, 149),
(40, 40, 1, 529),
(39, 39, 7, 469),
(38, 39, 1, 529),
(37, 38, 2, 599),
(36, 38, 3, 149),
(35, 38, 1, 529),
(34, 37, 4, 409),
(33, 37, 7, 469),
(32, 37, 37, 3999),
(53, 48, 5, 439),
(54, 49, 4, 409),
(55, 50, 7, 469),
(56, 51, 2, 599),
(57, 52, 18, 499),
(58, 53, 4, 409),
(59, 54, 8, 329),
(60, 55, 11, 399),
(61, 56, 38, 699),
(62, 57, 8, 329),
(63, 58, 8, 329),
(64, 59, 8, 329),
(65, 60, 25, 2999),
(66, 61, 2, 599),
(67, 62, 2, 599),
(68, 63, 25, 2999),
(69, 64, 34, 1999),
(70, 65, 3, 149),
(71, 65, 7, 469),
(72, 65, 1, 529),
(73, 66, 7, 469),
(74, 66, 1, 529),
(75, 67, 1, 529),
(76, 67, 7, 469),
(77, 68, 8, 329),
(78, 68, 1, 529),
(79, 69, 4, 409),
(80, 69, 1, 529),
(81, 70, 5, 439),
(82, 70, 3, 149),
(83, 70, 4, 409),
(84, 71, 5, 439),
(85, 72, 8, 329),
(86, 73, 7, 469),
(87, 74, 1, 529),
(88, 75, 1, 529),
(89, 76, 1, 529),
(90, 77, 7, 469),
(91, 78, 1, 529),
(92, 79, 21, 122),
(93, 79, 17, 199),
(94, 79, 10, 299),
(95, 80, 20, 898),
(96, 81, 7, 469),
(97, 82, 1, 529),
(98, 83, 1, 529),
(99, 84, 1, 529),
(100, 85, 6, 3809),
(101, 86, 6, 3809),
(102, 87, 6, 3809),
(103, 88, 8, 329),
(104, 89, 8, 329),
(105, 90, 8, 329),
(106, 91, 6, 3809),
(107, 92, 1, 529),
(108, 93, 6, 3809),
(109, 94, 8, 329),
(110, 95, 1, 529),
(111, 96, 6, 3809),
(112, 97, 4, 409),
(113, 98, 5, 439),
(114, 99, 18, 499),
(115, 100, 3, 149),
(116, 100, 7, 469),
(117, 101, 26, 1212),
(118, 104, 1, 529),
(119, 105, 1, 529),
(120, 106, 1, 529),
(121, 107, 41, 19),
(122, 108, 39, 99),
(123, 109, 42, 69),
(124, 110, 7, 469),
(125, 111, 2, 599),
(126, 112, 10, 299),
(127, 113, 5, 439),
(128, 114, 1, 529),
(129, 114, 3, 149),
(130, 114, 8, 329),
(131, 115, 43, 20);

-- --------------------------------------------------------

--
-- 表的结构 `shoes_time`
--

CREATE TABLE `shoes_time` (
  `id` int(11) NOT NULL,
  `time_name` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='发货时间表';

--
-- 转存表中的数据 `shoes_time`
--

INSERT INTO `shoes_time` (`id`, `time_name`) VALUES
(1, '当天发货'),
(2, '1-3天'),
(3, '4-6天'),
(4, '大于一周');

-- --------------------------------------------------------

--
-- 表的结构 `shoes_user`
--

CREATE TABLE `shoes_user` (
  `id` int(11) NOT NULL COMMENT 'id',
  `username` varchar(255) NOT NULL COMMENT '用户名',
  `phone` varchar(255) NOT NULL COMMENT '手机号码',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `discount_price` varchar(255) DEFAULT NULL COMMENT '优惠价格',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户表';

--
-- 转存表中的数据 `shoes_user`
--

INSERT INTO `shoes_user` (`id`, `username`, `phone`, `password`, `discount_price`, `create_time`, `update_time`) VALUES
(1, 'liulonghui', '18032198647', '123456', '20,50,80', '2022-04-20 08:09:54', '2022-04-20 08:09:54'),
(2, 'zhangsan', '13520666935', '666666', '', '2022-04-20 08:05:25', '2022-04-20 08:05:25'),
(3, 'lisi', '15698563247', '999999', NULL, '2021-11-21 04:22:55', '2021-11-21 04:22:55'),
(4, 'wangwu', '18963258746', '963258', NULL, '2021-11-16 14:38:54', '2021-11-16 14:38:54'),
(5, 'zhaoliu', '15910394182', '123456', NULL, '2021-11-21 04:23:02', '2021-11-21 04:23:02'),
(12, 'wangsang', '18032198644', '111111', '80', '2021-11-28 13:58:24', '2021-11-28 13:58:24'),
(13, 'qwert', '18032198645', '123456', NULL, '2021-11-21 13:12:49', '2021-11-21 13:12:49');

--
-- 转储表的索引
--

--
-- 表的索引 `shoes_activity`
--
ALTER TABLE `shoes_activity`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `shoes_address`
--
ALTER TABLE `shoes_address`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `shoes_banner`
--
ALTER TABLE `shoes_banner`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `shoes_brand`
--
ALTER TABLE `shoes_brand`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `shoes_cart`
--
ALTER TABLE `shoes_cart`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `shoes_category`
--
ALTER TABLE `shoes_category`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `shoes_condition`
--
ALTER TABLE `shoes_condition`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `shoes_discount`
--
ALTER TABLE `shoes_discount`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `shoes_freeshipping`
--
ALTER TABLE `shoes_freeshipping`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `shoes_goods`
--
ALTER TABLE `shoes_goods`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `shoes_manager`
--
ALTER TABLE `shoes_manager`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `shoes_order`
--
ALTER TABLE `shoes_order`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `shoes_order_goods`
--
ALTER TABLE `shoes_order_goods`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `shoes_time`
--
ALTER TABLE `shoes_time`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `shoes_user`
--
ALTER TABLE `shoes_user`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `shoes_activity`
--
ALTER TABLE `shoes_activity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- 使用表AUTO_INCREMENT `shoes_address`
--
ALTER TABLE `shoes_address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- 使用表AUTO_INCREMENT `shoes_banner`
--
ALTER TABLE `shoes_banner`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id', AUTO_INCREMENT=4;

--
-- 使用表AUTO_INCREMENT `shoes_brand`
--
ALTER TABLE `shoes_brand`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- 使用表AUTO_INCREMENT `shoes_cart`
--
ALTER TABLE `shoes_cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=178;

--
-- 使用表AUTO_INCREMENT `shoes_category`
--
ALTER TABLE `shoes_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- 使用表AUTO_INCREMENT `shoes_condition`
--
ALTER TABLE `shoes_condition`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- 使用表AUTO_INCREMENT `shoes_discount`
--
ALTER TABLE `shoes_discount`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- 使用表AUTO_INCREMENT `shoes_freeshipping`
--
ALTER TABLE `shoes_freeshipping`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用表AUTO_INCREMENT `shoes_goods`
--
ALTER TABLE `shoes_goods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- 使用表AUTO_INCREMENT `shoes_manager`
--
ALTER TABLE `shoes_manager`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id', AUTO_INCREMENT=14;

--
-- 使用表AUTO_INCREMENT `shoes_order`
--
ALTER TABLE `shoes_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=116;

--
-- 使用表AUTO_INCREMENT `shoes_order_goods`
--
ALTER TABLE `shoes_order_goods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=132;

--
-- 使用表AUTO_INCREMENT `shoes_time`
--
ALTER TABLE `shoes_time`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `shoes_user`
--
ALTER TABLE `shoes_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id', AUTO_INCREMENT=14;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
