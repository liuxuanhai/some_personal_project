/*
Navicat MySQL Data Transfer

Source Server         : jly
Source Server Version : 50534
Source Host           : localhost:3306
Source Database       : bysj

Target Server Type    : MYSQL
Target Server Version : 50534
File Encoding         : 65001

Date: 2016-05-28 22:07:54
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for administrator
-- ----------------------------
DROP TABLE IF EXISTS `administrator`;
CREATE TABLE `administrator` (
  `adminid` int(4) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `passwd` varchar(20) NOT NULL,
  PRIMARY KEY (`adminid`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of administrator
-- ----------------------------
INSERT INTO `administrator` VALUES ('1', 'admin', 'admin');
INSERT INTO `administrator` VALUES ('50', 'jly', 'hdfh');

-- ----------------------------
-- Table structure for keti
-- ----------------------------
DROP TABLE IF EXISTS `keti`;
CREATE TABLE `keti` (
  `ktname` varchar(50) DEFAULT NULL COMMENT '课题名称',
  `kttype` varchar(50) DEFAULT NULL COMMENT '课题类型',
  `ktcome` varchar(50) DEFAULT NULL COMMENT '课题来源',
  `ktdescr` varchar(255) DEFAULT NULL COMMENT '课题简介',
  `stuid` varchar(20) DEFAULT NULL COMMENT '申报学生',
  `status` varchar(1) DEFAULT NULL COMMENT '申报状态，0未审核，1审核通过，2审核不通过',
  `teachid` varchar(20) DEFAULT NULL COMMENT '指导老师',
  `taskpath` varchar(50) DEFAULT NULL COMMENT '任务书',
  `ktpath` varchar(50) DEFAULT NULL COMMENT '开题报告',
  `zqpath` varchar(50) DEFAULT NULL COMMENT '中期报告',
  `lwpath` varchar(50) DEFAULT NULL COMMENT '论文',
  `lastlwpath` varchar(50) DEFAULT NULL COMMENT '论文终稿',
  `score` double DEFAULT '0' COMMENT '得分'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of keti
-- ----------------------------
INSERT INTO `keti` VALUES ('基于JSP的毕业设计管理系统的开发', '毕业设计', '题目自拟', '开发设计一款毕业设计管理系统', '20141019', '1', '', null, null, null, null, null, '0');
INSERT INTO `keti` VALUES ('遗传算法求解旅行商问题的研究与实现', '算法类', '自拟', '采用GA算法设计针对TSP问题的求解过程', '20130000', '1', '20100008', null, null, null, null, null, '0');
INSERT INTO `keti` VALUES ('基于JSP的毕业设计管理系统的开发', '毕业设计', '题目自拟', '开发一款毕业设计管理系统', '20130001', '1', '20100008', null, null, null, null, null, '0');
INSERT INTO `keti` VALUES ('在线购物网站的设计与实现', '毕业设计', '自拟', '在线购物网站的设计与实现', '20130002', '1', '20100008', null, null, null, null, null, '0');
INSERT INTO `keti` VALUES ('在线购物系统', '毕业设计', '题目自拟', '设计一款在线网站购物系统', '20130003', '1', '', '', null, null, null, null, '0');
INSERT INTO `keti` VALUES ('旅行商信息管理系统', '毕业设计', '自拟', '旅行商信息管理系统', '20130006', '1', '20100008', 'a539da71-7660-49bc-8bf8-2a2d87bf4cfb.pdf', '11ca2673-6711-4462-b5ad-5dbada6257e1.pdf', 'b4eb0a0e-bbd7-4b49-820f-39caa5743ba7.pdf', '7bbad6a3-421f-49b9-85d7-3f9dca87dc3f.pdf', '', '90');
INSERT INTO `keti` VALUES ('日志管理系统', '毕业设计', '题目自拟', '设计一款日志管理系统，使用C#', '20141013', '2', '', '', '', '', '', '', '0');
INSERT INTO `keti` VALUES ('物业管理系统', '系统类', '自拟', '物业管理系统', '20130008', '1', '20100008', '9fc69909-4b6b-4bf7-ab68-f8d5b7fe2509.pdf', '02968b0e-19f1-4c7a-a890-30a8a1c24a7b.pdf', '80cf880d-c93c-4630-90f6-2ef086177947.pdf', 'bbe7684d-1400-434e-ad21-f137bca436b1.pdf', '791ba192-4f82-427c-bb82-0fb75594807b.pdf', '95');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `stuid` varchar(20) NOT NULL,
  `username` varchar(30) NOT NULL,
  `passwd` varchar(30) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `gender` varchar(4) DEFAULT NULL,
  `school` varchar(60) DEFAULT NULL,
  `cls` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`stuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('20130000', '20130000', '20130000', '刘星', '男', null, '计算机科学1班');
INSERT INTO `student` VALUES ('20130001', '20130001', '20130001', '曲健莹', '男', null, '计算机科学1班');
INSERT INTO `student` VALUES ('20130002', '20130002', '20130002', '任皓', '女', null, '计算机科学1班');
INSERT INTO `student` VALUES ('20130003', '20130003', '20130003', '童怡', '男', null, '计算机科学1班');
INSERT INTO `student` VALUES ('20130004', '20130004', '20130004', '王维', '男', null, '计算机科学1班');
INSERT INTO `student` VALUES ('20130005', '20130005', '20130005', '王晓', '女', null, '计算机科学1班');
INSERT INTO `student` VALUES ('20130006', '20130006', '20130006', '夏圣轩', '女', null, '通信工程1班');
INSERT INTO `student` VALUES ('20130007', '20130007', '20130007', '徐浪', '男', null, '通信工程1班');
INSERT INTO `student` VALUES ('20130008', '20130008', '20130008', '杨晓龙', '女', null, '通信工程1班');
INSERT INTO `student` VALUES ('20130009', '20130009', '20130009', '翟继鹏', '男', null, '通信工程1班');
INSERT INTO `student` VALUES ('20130010', '20130010', '20130010', '张海', '女', null, '通信工程1班');
INSERT INTO `student` VALUES ('20141001', '20141001', '20141001', '何宇', '女', null, '物联网工程1班');
INSERT INTO `student` VALUES ('20141002', '20141002', '20141002', '何志明', '女', null, '物联网工程1班');
INSERT INTO `student` VALUES ('20141003', '20141003', '20141003', '胡卓', '男', null, '物联网工程1班');
INSERT INTO `student` VALUES ('20141004', '20141004', '20141004', '华维', '女', null, '物联网工程1班');
INSERT INTO `student` VALUES ('20141005', '20141005', '20141005', '黄帅华', '男', null, '物联网工程1班');
INSERT INTO `student` VALUES ('20141006', '20141006', '20141006', '李金涛', '男', null, '物联网工程1班');
INSERT INTO `student` VALUES ('20141007', '20141007', '20141007', '李湃', '女', null, '物联网工程1班');
INSERT INTO `student` VALUES ('20141008', '20141008', '20141008', '刘泊荣', '女', null, '物联网工程1班');
INSERT INTO `student` VALUES ('20141009', '20141009', '20141009', '刘星', '男', null, '物联网工程1班');
INSERT INTO `student` VALUES ('20141010', '20141010', '20141010', '曲健莹', '男', null, '嵌入式开发');
INSERT INTO `student` VALUES ('20141011', '20141011', '20141011', '任皓', '男', null, '嵌入式开发');
INSERT INTO `student` VALUES ('20141012', '20141012', '20141012', '童怡', '男', null, '嵌入式开发');
INSERT INTO `student` VALUES ('20141013', '20141013', '20141013', '王维', '男', null, '嵌入式开发');
INSERT INTO `student` VALUES ('20141014', '20141014', '20141014', '王晓', '女', null, '嵌入式开发');
INSERT INTO `student` VALUES ('20141015', '20141015', '20141015', '夏圣轩', '女', null, '嵌入式开发');
INSERT INTO `student` VALUES ('20141016', '20141016', '20141016', '徐浪', '女', null, '外语1班');
INSERT INTO `student` VALUES ('20141017', '20141017', '20141017', '杨晓龙', '女', null, '外语1班');
INSERT INTO `student` VALUES ('20141018', '20141018', '20141018', '翟继鹏', '女', null, '外语1班');
INSERT INTO `student` VALUES ('20141019', '20141019', '55555', '张海', '男', null, '外语1班');

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `teachid` varchar(20) NOT NULL,
  `username` varchar(30) NOT NULL,
  `passwd` varchar(20) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `gender` varchar(4) DEFAULT NULL,
  `school` varchar(60) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`teachid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('20100000', '20100000', '20100000', '李冬寅', '男', null, '智能搜索算法');
INSERT INTO `teacher` VALUES ('20100001', '20100001', '20100001', '刘勇先', '男', null, '编程语言开发');
INSERT INTO `teacher` VALUES ('20100002', '20100002', '20100002', '王龙', '男', null, '人工智能');
INSERT INTO `teacher` VALUES ('20100008', '20100008', '20100008', '高岩', '女', null, '网站建设');
INSERT INTO `teacher` VALUES ('20100009', '20100009', '20100009', '梁果', '男', null, '模式识别');
INSERT INTO `teacher` VALUES ('20100010', '20100010', '20100010', '欧阳剑瑛', '女', null, '数据结构与算法');
INSERT INTO `teacher` VALUES ('20100011', '20100011', '20100011', '彭小涛', '女', null, '大数据');
INSERT INTO `teacher` VALUES ('20100012', '20100012', '20100012', '唐新国', '男', null, '嵌入式');
INSERT INTO `teacher` VALUES ('20100019', '20100019', '20100019', '肖剑飞', '男', null, '图形识别');
INSERT INTO `teacher` VALUES ('20100020', '20100020', '1234', '杨佳梁', '女', null, '自然语言处理');

-- ----------------------------
-- Table structure for teachselect
-- ----------------------------
DROP TABLE IF EXISTS `teachselect`;
CREATE TABLE `teachselect` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stuid` varchar(20) DEFAULT NULL COMMENT '学号',
  `teachid1` varchar(20) DEFAULT NULL COMMENT '第一志愿',
  `teachid2` varchar(20) DEFAULT NULL,
  `teachid3` varchar(30) DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL COMMENT '状态,0',
  `flag` varchar(1) DEFAULT NULL COMMENT '0第一志愿待选，1第二志愿待选，2第三志愿赛选，3导师互选已完成',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teachselect
-- ----------------------------
INSERT INTO `teachselect` VALUES ('1', '20130000', '20100008', '20100011', '20100010', '导师已互选，导师为高岩', '3');
INSERT INTO `teachselect` VALUES ('2', '20130001', '20100008', '20100001', '20100019', '导师已互选，导师为肖剑飞', '3');
INSERT INTO `teachselect` VALUES ('3', '20130002', '20100019', '20100009', '20100008', '导师已互选，导师为肖剑飞', '3');
INSERT INTO `teachselect` VALUES ('4', '20141019', '20100008', '20100010', '20100011', '志愿一导师已拒绝', '1');
INSERT INTO `teachselect` VALUES ('5', '20130003', '20100001', '20100010', '20100011', '志愿一导师已拒绝', '1');
INSERT INTO `teachselect` VALUES ('6', '20130006', '20100008', '20100010', '20100019', '导师已互选，导师为高岩', '3');
INSERT INTO `teachselect` VALUES ('7', '20130008', '20100008', '20100010', '20100019', '导师已互选，导师为高岩', '3');
