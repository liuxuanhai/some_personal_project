/*
Navicat MySQL Data Transfer

Source Server         : jly
Source Server Version : 50534
Source Host           : localhost:3306
Source Database       : kehusys

Target Server Type    : MYSQL
Target Server Version : 50534
File Encoding         : 65001

Date: 2016-05-28 22:39:14
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL COMMENT '客户电话',
  `addr` varchar(255) DEFAULT NULL COMMENT '客户地址',
  `totalmoney` decimal(10,2) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `yuangongid` int(11) DEFAULT NULL COMMENT '员工id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES ('3', '张三', '1364941561', '江苏南京', '220.00', 'hi诶嘿IE', '1');
INSERT INTO `customer` VALUES ('5', '李四', '13964512415', '江苏南京', '6570.00', '', '1');
INSERT INTO `customer` VALUES ('7', '胡志', '43643', '', '280.00', '', '3');
INSERT INTO `customer` VALUES ('9', '陈杰', '165413132', '安徽', '110.00', '', '3');

-- ----------------------------
-- Table structure for fankui
-- ----------------------------
DROP TABLE IF EXISTS `fankui`;
CREATE TABLE `fankui` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `personname` varchar(255) DEFAULT NULL,
  `content` text,
  `remark` varchar(255) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  `yuangongid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fankui
-- ----------------------------
INSERT INTO `fankui` VALUES ('1', null, '张峰', '5', null, '2016-05-10 03:20:20', '1');
INSERT INTO `fankui` VALUES ('3', null, '李四', '哈哈哈哈哈哈哈    	', null, '2016-05-12 00:16:47', '1');
INSERT INTO `fankui` VALUES ('5', null, '刘三', '产品需要优化', null, '2016-05-21 02:13:42', '3');

-- ----------------------------
-- Table structure for jiaoyi
-- ----------------------------
DROP TABLE IF EXISTS `jiaoyi`;
CREATE TABLE `jiaoyi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `khid` int(11) DEFAULT NULL COMMENT '客户姓名',
  `kename` varchar(255) DEFAULT NULL,
  `money` decimal(10,2) DEFAULT NULL,
  `info` varchar(1024) DEFAULT NULL COMMENT '交易详情',
  `ygname` varchar(255) DEFAULT NULL COMMENT '员工姓名',
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jiaoyi
-- ----------------------------
INSERT INTO `jiaoyi` VALUES ('1', '3', '张三', '500.00', '业务咨询', '江林燕', '2016-05-10 23:06:57');
INSERT INTO `jiaoyi` VALUES ('2', '5', '李四', '200.00', '业务了解。', '张丹', '2016-05-10 23:11:02');
INSERT INTO `jiaoyi` VALUES ('5', '3', '张三', '500.00', '完成交易', '江林燕', '2016-05-11 00:01:33');

-- ----------------------------
-- Table structure for orderdetail
-- ----------------------------
DROP TABLE IF EXISTS `orderdetail`;
CREATE TABLE `orderdetail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ordernum` varchar(25) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `nums` int(11) DEFAULT NULL,
  `totalprice` decimal(10,2) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orderdetail
-- ----------------------------
INSERT INTO `orderdetail` VALUES ('1', '20160521034542', '加多宝', '20.00', '4', '80.00', '凉茶', '2016-05-21 04:57:07');
INSERT INTO `orderdetail` VALUES ('2', '20160521034542', '充电宝', '48.00', '10', '480.00', '充电宝10只', '2016-05-21 04:58:02');
INSERT INTO `orderdetail` VALUES ('4', '20160521051832', 'A产品', '20.00', '5', '100.00', '', '2016-05-21 05:18:47');
INSERT INTO `orderdetail` VALUES ('5', '20160521051832', 'B产品', '10.00', '10', '100.00', '', '2016-05-21 05:18:59');
INSERT INTO `orderdetail` VALUES ('6', '20160521052135', 'A', '10.00', '5', '50.00', '', '2016-05-21 05:21:50');
INSERT INTO `orderdetail` VALUES ('8', '20160521052855', 'A产品', '55.00', '3', '165.00', '', '2016-05-21 05:29:09');
INSERT INTO `orderdetail` VALUES ('9', '20160521052855', 'B产品', '10.00', '3', '30.00', '', '2016-05-21 05:29:23');
INSERT INTO `orderdetail` VALUES ('10', '20160521052855', 'C产品', '5.00', '5', '25.00', '', '2016-05-21 05:29:33');
INSERT INTO `orderdetail` VALUES ('11', '20160521052135', 'B', '20.00', '3', '60.00', '', '2016-05-21 05:40:34');
INSERT INTO `orderdetail` VALUES ('12', '20160521054110', '王老吉', '4.00', '20', '80.00', '', '2016-05-21 05:41:30');
INSERT INTO `orderdetail` VALUES ('13', '20160521034542', '产品1', '55.00', '20', '1100.00', '少量进货', '2016-05-21 14:17:28');
INSERT INTO `orderdetail` VALUES ('14', '20160521034542', '产品2', '35.00', '30', '1050.00', '', '2016-05-21 14:17:28');
INSERT INTO `orderdetail` VALUES ('15', '20160521034542', '产品3', '19.00', '180', '3420.00', '大量进货', '2016-05-21 14:17:28');
INSERT INTO `orderdetail` VALUES ('17', '20160521034542', '产品4', '8.00', '55', '440.00', '尝试进货', '2016-05-21 14:17:55');

-- ----------------------------
-- Table structure for ordermana
-- ----------------------------
DROP TABLE IF EXISTS `ordermana`;
CREATE TABLE `ordermana` (
  `ordernum` varchar(25) DEFAULT NULL COMMENT '订单id',
  `customerid` int(11) DEFAULT NULL COMMENT '客户id',
  `yuangongid` int(11) DEFAULT NULL COMMENT '员工id',
  `totalprice` decimal(10,2) DEFAULT NULL COMMENT '订货总额',
  `ordertime` datetime DEFAULT NULL COMMENT '订货日期',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ordermana
-- ----------------------------
INSERT INTO `ordermana` VALUES ('20160521034542', '5', '1', '6570.00', '2016-05-18 00:00:00', '嘿嘿');
INSERT INTO `ordermana` VALUES ('20160521051832', '7', '3', '200.00', '2016-05-21 00:00:00', '');
INSERT INTO `ordermana` VALUES ('20160521052135', '9', '3', '110.00', '2016-05-13 00:00:00', '');
INSERT INTO `ordermana` VALUES ('20160521052855', '3', '1', '220.00', '2016-05-06 00:00:00', '嘿嘿');
INSERT INTO `ordermana` VALUES ('20160521054110', '7', '3', '80.00', '2016-05-20 00:00:00', '');

-- ----------------------------
-- Table structure for tousu
-- ----------------------------
DROP TABLE IF EXISTS `tousu`;
CREATE TABLE `tousu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `personname` varchar(255) DEFAULT NULL,
  `content` text,
  `remark` varchar(255) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  `yuangongid` int(11) DEFAULT NULL COMMENT '负责员工id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tousu
-- ----------------------------
INSERT INTO `tousu` VALUES ('2', null, '张敏', '无 ', null, '2016-05-12 00:17:45', '1');
INSERT INTO `tousu` VALUES ('3', null, '张敏', '服务态度非常差        	', null, '2016-05-21 02:14:23', '3');

-- ----------------------------
-- Table structure for yuangong
-- ----------------------------
DROP TABLE IF EXISTS `yuangong`;
CREATE TABLE `yuangong` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `idcard` varchar(255) DEFAULT NULL,
  `addr` varchar(255) DEFAULT NULL,
  `pwd` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `type` varchar(1) DEFAULT NULL COMMENT '员工类型，0店长和1业务员',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yuangong
-- ----------------------------
INSERT INTO `yuangong` VALUES ('1', '江林燕', '147894656', '', '长沙岳麓区', '55555', 'jly', '0');
INSERT INTO `yuangong` VALUES ('2', '张丹', '13645445151', '', '长沙', '55555', 'zhangd', '1');
INSERT INTO `yuangong` VALUES ('3', '张三', '136465155', '', '江苏', '55555', 'zhang', '1');
