/*
Navicat MySQL Data Transfer

Source Server         : jly
Source Server Version : 50534
Source Host           : localhost:3306
Source Database       : lvec

Target Server Type    : MYSQL
Target Server Version : 50534
File Encoding         : 65001

Date: 2016-05-28 22:44:03
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
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of administrator
-- ----------------------------
INSERT INTO `administrator` VALUES ('1', 'admin', 'admin');
INSERT INTO `administrator` VALUES ('52', 'jly', '5555555');
INSERT INTO `administrator` VALUES ('53', '555', 'dsafsa');
INSERT INTO `administrator` VALUES ('55', '欢欢', 'gfdg');

-- ----------------------------
-- Table structure for goodcomment
-- ----------------------------
DROP TABLE IF EXISTS `goodcomment`;
CREATE TABLE `goodcomment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '评论id',
  `goodid` int(11) DEFAULT NULL COMMENT '酒店id',
  `userid` int(11) DEFAULT NULL COMMENT '评论用户id',
  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
  `content` varchar(255) DEFAULT NULL COMMENT '评论内容',
  `addtime` datetime DEFAULT NULL COMMENT '评论时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goodcomment
-- ----------------------------
INSERT INTO `goodcomment` VALUES ('1', '2', '1', 'jly', '质量不错', '2016-05-20 16:21:43');
INSERT INTO `goodcomment` VALUES ('2', '2', '2', '江林燕', '蛮好看的', '2016-05-21 16:22:04');
INSERT INTO `goodcomment` VALUES ('3', '4', '1', 'jly', '不错', '2016-05-22 00:21:22');

-- ----------------------------
-- Table structure for goodinfo
-- ----------------------------
DROP TABLE IF EXISTS `goodinfo`;
CREATE TABLE `goodinfo` (
  `goodid` int(11) NOT NULL AUTO_INCREMENT,
  `goodname` varchar(50) DEFAULT NULL COMMENT '产品名称',
  `gooddescr` varchar(255) DEFAULT NULL COMMENT '商品描述',
  `goodprice` decimal(10,2) DEFAULT NULL COMMENT '产品单价',
  `goodnum` int(11) DEFAULT NULL COMMENT '商品数量',
  `typeid` int(11) DEFAULT NULL COMMENT '所属分类',
  `goodimage` varchar(2048) DEFAULT NULL COMMENT '商品图片',
  PRIMARY KEY (`goodid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goodinfo
-- ----------------------------
INSERT INTO `goodinfo` VALUES ('1', '毛主席头像', '毛主席头像', '10.00', '50', '1', '858727d2-fdf8-4f1b-9400-93b11b6a7feb.jpg#0140fbb1-0b68-4dc4-9f0a-fcdc0b3f1c5b.jpg#5d59c74c-d15c-4914-aa9d-ea1dddf9d0fe.jpg#');
INSERT INTO `goodinfo` VALUES ('2', '兵马俑一套', '秦始皇兵马俑一套', '50.00', '30', '1', 'f244bd5e-8b20-4616-834d-f61cb099fccc.jpg#d429503f-8add-4c17-ae45-03f511986fa2.jpg#3c8e91a3-a67f-4111-9be0-8ff2550680c0.jpg#5f5c3356-dafd-428c-a284-a3bc6d86116d.jpeg#');
INSERT INTO `goodinfo` VALUES ('3', '长沙臭豆腐', '长沙臭豆腐', '20.00', '200', '2', '310854ad-c771-432f-ac49-c0c6b97c2a47.jpg#2ba155c8-55c1-4840-bb6b-efd0c27abfd8.jpg#');
INSERT INTO `goodinfo` VALUES ('4', '北京烤鸭', '北京烤鸭', '50.00', '199', '3', '1fe6061f-6b10-43de-ba11-d617c0d57a84.jpg#90ed0a24-8f2f-4f95-9af3-55601ec90d1e.jpg#65ce0d61-226a-4325-bec6-8892f2406dce.jpg#2eec2cfb-4eba-404f-962b-88c874a52218.jpg#b1e26a6e-6ba4-406b-b9b4-35115c3e4bcc.jpg#');

-- ----------------------------
-- Table structure for goodorder
-- ----------------------------
DROP TABLE IF EXISTS `goodorder`;
CREATE TABLE `goodorder` (
  `orderid` varchar(25) NOT NULL,
  `username` varchar(25) DEFAULT NULL COMMENT '用户名称',
  `totalprice` decimal(10,2) DEFAULT NULL COMMENT '订单总额',
  `ordertime` datetime DEFAULT NULL COMMENT '下单时间',
  `orderstatus` varchar(1) DEFAULT NULL COMMENT '订单状态0提交1付款',
  `name` varchar(25) DEFAULT NULL COMMENT '收货姓名',
  `phone` varchar(25) DEFAULT NULL COMMENT '收货地址',
  `addr` varchar(50) DEFAULT NULL COMMENT '收货地址',
  PRIMARY KEY (`orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goodorder
-- ----------------------------
INSERT INTO `goodorder` VALUES ('20160521201731', 'jly', '20.00', '2016-05-21 20:17:31', '0', '江林燕', '43643643', '个的复合弓');
INSERT INTO `goodorder` VALUES ('20160521232034', 'jly', '110.00', '2016-05-21 23:20:34', '0', '江林燕', '13451312312', '长沙');

-- ----------------------------
-- Table structure for goodorderinfo
-- ----------------------------
DROP TABLE IF EXISTS `goodorderinfo`;
CREATE TABLE `goodorderinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '详单id',
  `orderid` varchar(25) DEFAULT NULL COMMENT '所属订单',
  `goodid` int(11) DEFAULT NULL COMMENT '商品id',
  `goodname` varchar(50) DEFAULT NULL COMMENT '商品名称',
  `goodprice` decimal(10,2) DEFAULT NULL COMMENT '商品价格',
  `nums` int(11) DEFAULT NULL COMMENT '购买数量',
  `totalprice` decimal(10,2) DEFAULT NULL COMMENT '购买总额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goodorderinfo
-- ----------------------------
INSERT INTO `goodorderinfo` VALUES ('1', '35', '1', '积分', '11.00', '2', '22.00');
INSERT INTO `goodorderinfo` VALUES ('2', '35', '2', '回复', '2.00', '2', '4.00');
INSERT INTO `goodorderinfo` VALUES ('3', '20160521201731', '3', '长沙臭豆腐', '20.00', '1', '20.00');
INSERT INTO `goodorderinfo` VALUES ('4', '20160521232034', '4', '北京烤鸭', '50.00', '2', '100.00');
INSERT INTO `goodorderinfo` VALUES ('5', '20160521232034', '1', '毛主席头像', '10.00', '1', '10.00');

-- ----------------------------
-- Table structure for goodtype
-- ----------------------------
DROP TABLE IF EXISTS `goodtype`;
CREATE TABLE `goodtype` (
  `typeid` int(11) NOT NULL AUTO_INCREMENT,
  `typename` varchar(25) DEFAULT NULL COMMENT '分类名称',
  `typedescr` varchar(255) DEFAULT NULL COMMENT '类型描述',
  PRIMARY KEY (`typeid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goodtype
-- ----------------------------
INSERT INTO `goodtype` VALUES ('1', '纪念品', '景区特色纪念品');
INSERT INTO `goodtype` VALUES ('2', '小吃', '出名小吃');
INSERT INTO `goodtype` VALUES ('3', '特产类', '风味特产');

-- ----------------------------
-- Table structure for hotel
-- ----------------------------
DROP TABLE IF EXISTS `hotel`;
CREATE TABLE `hotel` (
  `hotelid` int(11) NOT NULL AUTO_INCREMENT COMMENT '酒店id',
  `hotelname` varchar(25) DEFAULT NULL COMMENT '酒店名称',
  `hotelcity` varchar(20) DEFAULT NULL COMMENT '酒店城市',
  `hoteladdr` varchar(50) DEFAULT NULL COMMENT '详细地址',
  `hoteldescr` text COMMENT '酒店描述',
  `hotelremark` text,
  `hotelprice` decimal(10,2) DEFAULT NULL COMMENT '预定价格',
  `hotelimage` varchar(1024) DEFAULT NULL COMMENT '图片路径',
  PRIMARY KEY (`hotelid`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hotel
-- ----------------------------
INSERT INTO `hotel` VALUES ('5', '7天酒店桂林火车站店', '桂林', '桂林市象山区中山南路55号', '        “水作青罗带，山如碧玉簪。洞穴幽且深，处处呈奇观。”这就是“山水甲天下”之桂林，--7天连锁酒店桂林火车站店坐落在风景如画的桂林市区内，交通便捷，位于桂林火车站与汽车客运总站之间。毗邻著名的西城步行街和中心广场。国家5A景区---漓江景区，4A景区----象山景区、七星景区、两江四湖景区等近在咫尺，均在约15分钟的车程内；火车站店周围配套设施齐备，美食城、商场、银行、学校等一应俱全，7天连锁酒店桂林火车站店将秉承7天连锁酒店的传统文化，为您提供高品质的睡眠保障。桂林火车站店全体同仁诚挚的邀请您，相信您在火车站店的每一天都能“天天睡好觉”！\r\n        ', '        \r\n        ', '80.00', '75bb9d3a-735a-4c30-8099-58f195b591ec.jpg#f09efd87-1292-4a5b-8b13-9b2e3ab549ba.jpg#8fa86c0e-9775-4759-9573-2f8aaab5bc08.jpg#53e6ac2c-6c78-410a-a5ef-ad6e6a7e1524.jpg#');
INSERT INTO `hotel` VALUES ('6', '阳朔嘻尹客栈', '桂林', '桂林阳朔县城抗战路进士路18号（近西街，十里画廊，印象刘三姐）', '        \r\n\r\n    各位亲们，咱们客栈是普通的民宿，不是豪华的酒店，客栈是小罗姐和小贺哥自己设计装修的，要求高的朋友，咱们只能说声抱歉了，希望亲们在预订房间之前看看介绍和图片，或者参考入住过咱们客栈亲们的评价。\r\n    亲们到了阳朔（大村门）汽车北站，可以乘坐5路公交车到进士路口下车，往进士路里面走50米，右手边就是咱们客栈，如不清楚，请拨打订房电话咨询小罗姐。进士路走到抗战路往左步行大约10分钟到西街，往右便是去十里画廊和遇龙河，往东1.2公里就是印象刘三姐。\r\n    客栈每间客房均设有独立淋浴间和窗户（所有房间没有阳台）。客栈所有床上用品均已换新，希望能让亲们享受“家”的温馨和热情服务，能有旅途美好心情。（注：客栈房间最高7楼，无电梯）      \r\n        ', '                \r\n        ', '70.00', 'c8357ed4-225a-464b-881c-bfc17f6a8f6d.jpg#dabf6f38-014a-4012-a6b3-384287917b1c.jpg#9e20c955-16b5-4a2c-bfe6-84b1478ab4e2.jpg#363ee8d9-5071-4764-a5cf-a010a0db21ff.jpg#');
INSERT INTO `hotel` VALUES ('7', '三亚大东海美人鱼海景公寓', '三亚', '三亚市大东海海花路88号金茂海景花园小区（银泰酒店旁）', '        酒店位于风景迷人的大东海国家4A旅游区，银泰酒店旁金茂海景花园，离大东海海滩100米左右，周边环境优美，蔚蓝大海和翠绿青山让人陶醉忘返，听听海浪，看潮起潮落，让您心旷神怡地回归大自然。酒店装修明快，温馨，舒适，每个房间设施新，房间面积大，干净卫生，会给您的旅途带来最贴心，最优质的服务。且交通方便，让您轻松到达三亚市区、三亚湾、亚龙湾、蜈支洲，南山、天涯海角、大小洞天等各个景点。周围配套设施齐全，是您来三亚旅游理想的下榻之地。从住宿到旅游，没有繁琐的购物，也没有刻意的行程，您来三亚就是一次浪漫悠然的度假之旅！    \r\n        ', '            公共区域和部分房间提供wifi       \r\n        ', '73.00', '8fa4a110-8e19-428c-8d22-4ce29c8bcffa.jpg#9c3e5e62-aeab-44b8-9f24-a9841ce226d0.jpg#856a53e6-14bf-4565-ad96-dde89986ed4f.jpg#504dfb3f-d745-4756-8846-66506e2bf0f1.jpg#');
INSERT INTO `hotel` VALUES ('8', '三亚丽景海湾酒店大东海店', '三亚', '三亚市吉阳区大东海旅游风景区海韵路23号 ( 大东海)', '            丽景海湾酒店位于风景旖旎的大东海旅游风景区。酒店建筑面积为二万多平方米，背山面海，所有房间均带阳台、落地玻璃窗户设计、提供免费无限时宽带上网接口，楼体结构一字排开，海景房观海效果为180度震撼型超级无敌海景，与沙滩无任何隔离带，零距离接触大海。整体建筑高低错落、造型别致，与青山、碧海、蓝天和谐统一，浑然一体，具有浓郁热带滨海风情。酒店并拥有富丽堂皇的中餐厅、高雅温馨的西餐厅，舒适豪华的KTV包厢、酒吧、桑拿、游泳池、会议厅、棋牌室、商务中心、美容美发、商场、烧烤园及各类沙滩娱乐运动设施一应俱全。酒店大堂采用开放式设计风格，可穿堂望海，直达游泳池和沙滩。\r\n\r\n        ', '        酒店提供免费停车位       \r\n        ', '198.00', '1131b482-6f9d-4a41-8e62-51891353ed13.jpg#0efba329-96ea-4ffd-ba14-c37ee7fee19f.jpg#27c04670-4001-44e9-a886-7c227b54d9b4.jpg#d3438f21-d03b-4805-835f-a8c2cf424803.jpg#');
INSERT INTO `hotel` VALUES ('9', '三亚薇薇海岸精品客栈三亚湾店', '三亚', '三亚市三亚湾老铁路东巷21号（临近胜利购物广场）', '        三亚薇薇海岸精品客栈（三亚湾店）位于海南省三亚市老铁路东巷（老铁路与团结路交叉路口）处，属于三亚市中心地段，步行至美丽三亚湾海边约2分钟，酒店步行约150米即到椰，距离解放路步行街约5分钟路程，凤凰机场乘坐公交车到团结街站下车即是交通极为便利，客栈门前多路公交路线分别直达主要景区，毗邻三亚最大的购物广场胜利购物广场，步行至春园海鲜加工广场约15分钟，周边配套设施丰富，餐饮、小吃、旅游咨询、商场均尽在咫尺，各式客房宽敞舒适，设施齐全，是您度假、旅游首选。愿您在本店度过温馨、愉快的假期生活。    \r\n        ', '        酒店提供免费停车位\r\n        ', '79.00', '0630899a-0307-49cf-8d4e-4c7aa3873860.jpg#3461e0cf-6ac1-45ad-91c8-b60e7f2cb920.jpg#744b29ab-5c47-45e2-aada-6dfd714c3fab.jpg#2dc8a416-3290-4b97-b984-d2109491c79c.jpg#');
INSERT INTO `hotel` VALUES ('10', '99旅馆连锁北京崇文门北京站店', '北京', '北京东城区东花市北里东区1号 ( 广渠门地区)', '        99旅馆定位于具备独立的卫生间、在当地性价比较高的酒店，干净、实惠、舒适、便捷，充满人性化的休闲氛围，并将会在一两年内坚持“全国平均房价99元”政策不变。99客房还具备智能化的工作环境，实现无线WiFi上网。99旅馆连锁推广自助机等方便快捷的入住方式，使您的入住时间节省至1分钟。温馨提示：低碳环保，守护家园，请减少对一次性用品的使用。店客房内不配备一次性用品，如有需要请到前台领取。特别提示：近期发现在车站等交通枢纽地区有人冒充店工作人员招揽客人，以低价引诱，到地方后抬高价格等手段蒙骗客人。店不会在车站、地铁站附近安排接待人员，请各位选择店入住的客人保护好自身财产及人身安全。咨询请拨打店前台电话！\r\n        ', '                \r\n        ', '69.00', 'cc100568-b75e-45f4-8372-04e678a709be.jpg#647837ab-b440-4fb8-bd74-92f45249fa27.jpg#744eb726-8676-451c-ae66-862bbe9f71d5.jpg#0b18dfc9-9fe9-427a-a965-783b853e740e.jpg#');
INSERT INTO `hotel` VALUES ('11', '北京通州运河苑温泉度假村', '北京', '北京通州区宋庄镇白庙村 (通州区) ', '        北京运河苑渡假村2010年被评为四叶级中国绿色饭店及央采政采会议中标单位，2010年11月通过ISO9000国际质量管理体系认证,2010年12月中标中央党政机关北京地区会议定点协议单位。 这里拥有251套不同类型的豪华客房，15栋风格各异的欧式别墅，备有享有声誉的府膳佳肴，鲜活生猛的海鲜大餐和南北风味的家常菜。渡假村内有功能齐全的大、中、小型会议室，KTV歌舞厅包间，以及游泳、台球、保龄球、棋牌、迪吧、游戏机、沙狐球、室内羽毛球场、室内乒乓球场及其他健身设备和各种综合娱乐项目。取自地下1800米蕴藏了上万年的温泉含有多种矿物质，让您无不感到物有所值，超值享受。水上世界有雪橇落水、三彩滑梯、儿童乐园冲浪等多种娱乐项目。 另外，渡假村还有六千平米的垂钓园，可满足宾客的不同需求。 这里宁静清新的空气，以及远离都市的喧嚣返朴归真近似原生态的花园式度假环境，是一个集商务、娱乐、休闲、度假、美食、会议、会展、旅游等多种功能于一体的理想的商务和休养场所。 温馨提示：酒店部分客房非四星级，详情请预定前咨询酒店。   \r\n        ', '                \r\n        ', '187.00', '8af277c6-c1c0-4966-b214-3a67f08d81b3.jpg#c929339f-6d93-4271-9847-c1cc0c302b18.jpg#2925dcdd-8432-419b-a7d4-39c4dbe7d9c5.jpg#630519ec-a32f-4d32-8956-6cdbc0e680ef.jpg#9297dd59-467c-4c63-9b57-c43550d6e5bf.jpg#');

-- ----------------------------
-- Table structure for hotelcomment
-- ----------------------------
DROP TABLE IF EXISTS `hotelcomment`;
CREATE TABLE `hotelcomment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '评论id',
  `hotelid` int(11) DEFAULT NULL COMMENT '酒店id',
  `userid` int(11) DEFAULT NULL COMMENT '评论用户id',
  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
  `content` varchar(255) DEFAULT NULL COMMENT '评论内容',
  `addtime` datetime DEFAULT NULL COMMENT '评论时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hotelcomment
-- ----------------------------
INSERT INTO `hotelcomment` VALUES ('1', '8', '1', 'jly', '蛮好玩的，推荐大家去', '2016-05-20 16:21:43');
INSERT INTO `hotelcomment` VALUES ('2', '8', '2', '江林燕', '不错不错，山水好呀', '2016-05-21 16:22:04');
INSERT INTO `hotelcomment` VALUES ('3', '6', '1', 'jly', '住的还好了啊', '2016-05-22 00:23:14');

-- ----------------------------
-- Table structure for hotelorder
-- ----------------------------
DROP TABLE IF EXISTS `hotelorder`;
CREATE TABLE `hotelorder` (
  `orderid` varchar(25) NOT NULL COMMENT '订单id',
  `hotelid` int(11) DEFAULT NULL COMMENT '酒店id',
  `hotelname` varchar(25) DEFAULT NULL COMMENT '酒店名称',
  `roomid` int(11) DEFAULT NULL COMMENT '房型',
  `roomname` varchar(50) DEFAULT NULL COMMENT '房型名称',
  `roomprice` decimal(10,2) DEFAULT NULL COMMENT '酒店房型价格',
  `username` varchar(25) DEFAULT NULL COMMENT '预订用户',
  `name` varchar(20) DEFAULT NULL COMMENT '入住联系人',
  `phone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `nums` int(11) DEFAULT NULL COMMENT '入住天数',
  `totalprice` decimal(10,2) DEFAULT NULL COMMENT '预订总额',
  `ordertime` datetime DEFAULT NULL COMMENT '订票日期',
  `checkintime` datetime DEFAULT NULL COMMENT '入住日期',
  `orderstatus` varchar(1) DEFAULT NULL COMMENT '订单状态,0提交,1付款',
  PRIMARY KEY (`orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hotelorder
-- ----------------------------
INSERT INTO `hotelorder` VALUES ('20160520084514', '6', '阳朔嘻尹客栈', '9', '情侣大床房', '130.00', 'jly', '江林燕', '1478956323', '2', '260.00', '2016-05-20 20:45:14', '2016-05-26 00:00:00', '0');

-- ----------------------------
-- Table structure for luntanhuati
-- ----------------------------
DROP TABLE IF EXISTS `luntanhuati`;
CREATE TABLE `luntanhuati` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL COMMENT '公告题目',
  `content` text,
  `addtime` datetime DEFAULT NULL,
  `looknum` int(11) DEFAULT NULL,
  `filepath` varchar(255) DEFAULT NULL COMMENT '文件路径',
  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of luntanhuati
-- ----------------------------
INSERT INTO `luntanhuati` VALUES ('5', '杭州，小住三日已忘家 ', '<p>西湖是一个很奇妙的存在，人文和地理巧妙融合。这里是<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10156.html\" class=\"link _j_keyword_mdd\" data-kw=\"杭州\" target=\"_blank\">杭州</a>人的故乡，也是文化先贤的精神家园。<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10156.html\" class=\"link _j_keyword_mdd\" data-kw=\"杭州\" target=\"_blank\">杭州</a>，因为有西湖的存在，如诗如画。在这里旅行，就如同在唐诗宋词的韵律中游走，信手拈来的都是历史的吉光片羽。西湖的部分，就从你镜头中的我开始吧，纪念终于成行的旅行。</p><p>西湖的形成要从白垩纪时期说起。那时，火山喷发岩浆四处流淌，火<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/65820.html\" class=\"link _j_keyword_mdd\" data-kw=\"山口\" target=\"_blank\">山口</a>成\r\n为洼地，也就是西湖现在的基础。之后，海潮带来的泥沙不断沉积，加之人类的不断改造，形成了西湖现在的模样。虽非天造地设的美景，但西湖的美在于人文与地\r\n理的绝妙融合。苏小小的香车经过这里，李慧娘遇见翩翩少年，还有千古传唱的白娘子和许仙的爱情，是这些故事一点一点地构建出那个虚无的西湖。<br/>&nbsp;<br/><a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10156.html\" class=\"link _j_keyword_mdd\" data-kw=\"杭州\" target=\"_blank\">杭州</a>和西湖密不可分。<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10156.html\" class=\"link _j_keyword_mdd\" data-kw=\"杭州\" target=\"_blank\">杭州</a>的出现源于海潮起落，所以，在相当漫长的时间，居民的生活用水依赖于储存<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/26088.html\" class=\"link _j_keyword_mdd\" data-kw=\"淡水\" target=\"_blank\">淡水</a>的西湖。唐代李泌开六井，井下水道与西湖水相通，解决了居民用水的困难。生活用水解决，农业灌溉依然是问题，此后四十年，白居易任<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10156.html\" class=\"link _j_keyword_mdd\" data-kw=\"杭州\" target=\"_blank\">杭州</a>刺史。他是失意的江州司马，是当时一流的诗人。白居易开始了三年的整治工程，修筑了一道长长的堤坝。虽然现在这堤坝已经消失，但断桥所在的白堤，确为纪念他而命名。<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10156.html\" class=\"link _j_keyword_mdd\" data-kw=\"杭州\" target=\"_blank\">杭州</a>太守苏东坡上任那年，遇到大旱，次年，洪涝成灾。他决意浚治西湖，20万民工参与当中，满湖的淤泥得以妥善清理，淤泥最佳的用处，也就是筑成长长的苏堤。<br/>&nbsp;<br/>小时候背苏东坡的诗“欲把西湖比西子，浓妆淡抹总相宜”，未觉此句之妙。直到自己看过秋天的西湖，再对照夏季的西湖，开始有点明白西湖季节转换之妙。山水\r\n是宋代画家最擅长的题材，按北宋的传统，山水画作都必须有简洁，但又一语中的的题目。于是，在马远等画家的画卷上，就出现了<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/18715.html\" class=\"link _j_keyword_mdd\" data-kw=\"南屏\" target=\"_blank\">南屏</a>晚钟，<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/63585.html\" class=\"link _j_keyword_mdd\" data-kw=\"双峰\" target=\"_blank\">双峰</a>插云等题名，也就是最初西湖十景的由来。而我们那几天游览的顺序，几乎也是按着西湖十景（下面地图中的红色标注部分），按图索骥。</p>', '2016-05-21 21:29:09', '2', '1babd6ed-3ed5-492c-b611-8081e5a8e51b.jpeg#4cff2c30-ea13-4cfb-a73c-c7ee0d3c9b62.jpeg#b20f1b70-4da6-47ec-be98-c32bc5462cf2.jpeg#', 'jly');
INSERT INTO `luntanhuati` VALUES ('6', '重游千岛湖之体验——梅地亚君澜和滨江希尔顿度假酒店（淡季度假体验）', '<p>&nbsp;<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10445.html\" class=\"link _j_keyword_mdd\" data-kw=\"千岛湖\" target=\"_blank\">千岛湖</a>——江浙沪人的“后花园”，无论你是旅游还是度假，都是好去处，好选择。因为这里风景秀丽，设施齐全。风光自不必多说，设施齐全指的是餐饮，道路，住宿这些旅游中必须看中的几大要素（吃、住、行、游、沟、娱）都是很完善的。<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;这篇游记纪念下今年的两次之行，一次是带上父母的，一次是我们夫妻连个的度假之旅。给各位朋友们简单介绍下，方便以后去的人选择自己的需要的东西。<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;这2次出行由于没有带单反，相片均出自苹果手机5S，还请见谅......<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;叙述自己旅游之前介绍下当地旅游可能用到的东西，希望对朋友们有帮助。</p><h2 style=\"text-align: center;\" class=\"t2\"><span class=\"_j_anchor\">千岛湖之住宿</span></h2><p class=\"_j_note_content _j_seqitem\" data-seq=\"119547410\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;来<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10445.html\" class=\"link _j_keyword_mdd\" data-kw=\"千岛湖\" target=\"_blank\">千岛湖</a>，两个旅游APP可以帮上你，一个是携程，一个是艺龙，这两个是可以帮助你预定<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10445.html\" class=\"link _j_keyword_mdd\" data-kw=\"千岛湖\" target=\"_blank\">千岛湖</a>各种房间的APP。我都用过，都还不错。<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;关于<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10445.html\" class=\"link _j_keyword_mdd\" data-kw=\"千岛湖\" target=\"_blank\">千岛湖</a>的住宿，你可以选择比较低端的旅馆（小旅馆或者名宿之类），可以选择好一点的度假公寓，也可以选择纯粹的度假酒店，就在酒店里面玩两天。看你的心理价位和需求。<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;旅游方式游玩：&nbsp;你按安排了2天满满的活动，<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/63538.html\" class=\"link _j_keyword_mdd\" data-kw=\"比如\" target=\"_blank\">比如</a>去游湖（中心湖区和东南湖区两条路线各自有个很不错的岛屿，可惜有点坑，后面讲述），<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/63538.html\" class=\"link _j_keyword_mdd\" data-kw=\"比如\" target=\"_blank\">比如</a>你要去森林氧吧，<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/63538.html\" class=\"link _j_keyword_mdd\" data-kw=\"比如\" target=\"_blank\">比如</a>要去马术公园或者其他地方游玩，这样的行程的话，建议你就住在公寓式酒店（<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/63538.html\" class=\"link _j_keyword_mdd\" data-kw=\"比如\" target=\"_blank\">比如</a><a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10445.html\" class=\"link _j_keyword_mdd\" data-kw=\"千岛湖\" target=\"_blank\">千岛湖</a>丽景酒店或者绿城度假酒店之类的，这两个看出去湖景挺不错）。<br/>&nbsp;&nbsp;&nbsp;&nbsp;度假方式游玩：在度假酒店，可以游泳，观光，喝茶，健身等，这样休闲的方式的话，建议你选择好的度假酒店——洲际、希尔顿、喜来登、君澜、润和建国、开元等很高端的五星级酒店。我开头说的<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10445.html\" class=\"link _j_keyword_mdd\" data-kw=\"千岛湖\" target=\"_blank\">千岛湖</a>的旅游开发很好，基础设施完善这就是体现，每个好酒店都各自占领了一篇湖区，满足你对<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10445.html\" class=\"link _j_keyword_mdd\" data-kw=\"千岛湖\" target=\"_blank\">千岛湖</a>观光的需求，其实有的酒店看到的湖景真的并不去游湖看到的差，甚至更好，更加舒服。<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/63538.html\" class=\"link _j_keyword_mdd\" data-kw=\"比如\" target=\"_blank\">比如</a>，洲际，独占羡山半岛，整个酒店就是公园式设计，很过婚纱摄影拍摄基地，可想而知他的风光。你即使不住，去游览一下也要花上2个小时，舒舒服服在那休息会也是极好的。<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/63538.html\" class=\"link _j_keyword_mdd\" data-kw=\"比如\" target=\"_blank\">比如</a>：喜来登，虽然在闹市区，可是湖景是一绝，能拍出山水画大片哦，喜欢摄影的也是很不错的地方。<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/63538.html\" class=\"link _j_keyword_mdd\" data-kw=\"比如\" target=\"_blank\">比如</a>：希尔顿，异域风情的设计就够你欣赏的，湖区的美景更是不在话下，去年没有去体验，今年果断在淡季的时候去，节省了很多银子，哈哈。<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10445.html\" class=\"link _j_keyword_mdd\" data-kw=\"千岛湖\" target=\"_blank\">千岛湖</a>出行，住宿往往是大头，所以，旺季和淡季看你自己的选择。旺季的话，其实应该是9月到11月是<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10445.html\" class=\"link _j_keyword_mdd\" data-kw=\"千岛湖\" target=\"_blank\">千岛湖</a>旅游最佳季节，因为这是时候气候最适宜，不是很热，个人认为9月最合适，11月又偏冷了，已经是慢慢淡季出现了。但是由于暑假等原因，暑假也是旺季，不过房价贵的离谱，基本是平时价格的2到3倍。所以可以像我们一样，11月去，我明年打算9月份去一次，呵呵。<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;旺季：&nbsp;夏季天高云淡，适合远眺，此时到梅峰岛上俯视300多个群岛，能见度最佳。当然东南湖区<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10440.html\" class=\"link _j_keyword_mdd\" data-kw=\"黄山\" target=\"_blank\">黄山</a>尖的“天下为公”也最为清晰。红叶湾色彩斑斓，小岛上瓜果飘香，硕果累累，湖<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/145826.html\" class=\"link _j_keyword_mdd\" data-kw=\"水里\" target=\"_blank\">水里</a>鱼肥味美。这时也正是<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10445.html\" class=\"link _j_keyword_mdd\" data-kw=\"千岛湖\" target=\"_blank\">千岛湖</a>玩水的最佳时节，从湖面上的<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/64932.html\" class=\"link _j_keyword_mdd\" data-kw=\"水上\" target=\"_blank\">水上</a>运动，到周边河溪上的各条漂流，清爽、刺激。<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;淡季：岛湖的冬季，是旅游的淡季，湖水较凉，不适合亲水活动而且此时旅游门票也会是淡季的价格，酒店的客房也相对便宜，适合轻松、休闲，但如遇冷空气南下，气温可降至零度左右，加上空气潮湿，手脚冰冷，此时出游需带棉衣。<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;冬季游船会因游客少，可能会抬高价格或干脆不开。但大可不必为难觅游船而担心，<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10445.html\" class=\"link _j_keyword_mdd\" data-kw=\"千岛湖\" target=\"_blank\">千岛湖</a>至<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10440.html\" class=\"link _j_keyword_mdd\" data-kw=\"黄山\" target=\"_blank\">黄山</a>的交通船全年无休，一样可以起到游湖的效果，没必要买80元的<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10445.html\" class=\"link _j_keyword_mdd\" data-kw=\"千岛湖\" target=\"_blank\">千岛湖</a>门票，船票也仅需12元，比游船便宜得多。冬至过后的<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10445.html\" class=\"link _j_keyword_mdd\" data-kw=\"千岛湖\" target=\"_blank\">千岛湖</a>水最清澈见底，此时游湖可谓神清气爽，绝不会因人多嘈杂而烦恼，而且100多元就能拿下一间标准房，比旺季时便宜2/3。</p><h2 style=\"text-align: center;\" class=\"t2\"><span class=\"_j_anchor\">千岛湖之游——骑行</span></h2><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;除了游湖，也是一个骑行的好地方，公路边都设有观景台，不进湖却能从另一角度领略<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10445.html\" class=\"link _j_keyword_mdd\" data-kw=\"千岛湖\" target=\"_blank\">千岛湖</a>的美。<br/>&nbsp;&nbsp;&nbsp;&nbsp;我们没有骑下全程，但在我这短短的骑行经历中，发现<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10445.html\" class=\"link _j_keyword_mdd\" data-kw=\"千岛湖\" target=\"_blank\">千岛湖</a>是骑行者的天堂啊，风景优美，已经被开发的就有好几条路线，配套设施极其完善，政府比较重视，所以有“<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/64134.html\" class=\"link _j_keyword_mdd\" data-kw=\"龙川\" target=\"_blank\">龙川</a>湾赛道”这种国际标准的山地自行车赛道。<br/>旅行Tips：<br/>路段：环<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10445.html\" class=\"link _j_keyword_mdd\" data-kw=\"千岛湖\" target=\"_blank\">千岛湖</a>自行车绿道由四段组成，风情不一<br/>第一段：千汾线绿道<br/>从<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10445.html\" class=\"link _j_keyword_mdd\" data-kw=\"千岛湖\" target=\"_blank\">千岛湖</a>大桥出发，沿千纷公路建设，全长70多公里，是建设最早、也最先被大家熟知的。红色的自行车道跨桥、穿村、钻隧道，沿途经过<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/66243.html\" class=\"link _j_keyword_mdd\" data-kw=\"小金\" target=\"_blank\">小金</a>山营地、界首桔园、姜家风情小镇、房车营地、水下古城——狮城博物馆、<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/64134.html\" class=\"link _j_keyword_mdd\" data-kw=\"龙川\" target=\"_blank\">龙川</a>湾景区、芹川古村落、浪川<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10301.html\" class=\"link _j_keyword_mdd\" data-kw=\"大连\" target=\"_blank\">大连</a>岭、汾口中华鳖基地等，是最为成熟的一条骑游线路。2014年，千汾线获封<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/14575.html\" class=\"link _j_keyword_mdd\" data-kw=\"浙江\" target=\"_blank\">浙江</a>“最美公路”<br/>第二段：淳杨线绿道<br/>从汾口镇出发，沿新淳杨公路建设，全程52公里，80%路段都沿湖而建，沿途经过<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/14383.html\" class=\"link _j_keyword_mdd\" data-kw=\"欧洲\" target=\"_blank\">欧洲</a>风情般的茶园、风情小镇——<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/82234.html\" class=\"link _j_keyword_mdd\" data-kw=\"枫树岭\" target=\"_blank\">枫树岭</a>镇、习近平主席曾经的农村联系点——下姜、葡萄采摘园、<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10445.html\" class=\"link _j_keyword_mdd\" data-kw=\"千岛湖\" target=\"_blank\">千岛湖</a>大峡谷、<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10165.html\" class=\"link _j_keyword_mdd\" data-kw=\"石林\" target=\"_blank\">石林</a>景区、上江埠大桥<br/>第三段：排岭半岛绿道<br/>从上江埠大桥出发，全程7.3公里，分成红、绿、蓝、紫四种颜色，代表春、夏、秋、冬四个季节，还建有鹅卵石路段、起伏路段等趣味体验路段，全程有路灯照射，可体验夜骑，终点是排岭半岛自行车营地<br/>第四段：城市绿道<br/>从<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10445.html\" class=\"link _j_keyword_mdd\" data-kw=\"千岛湖\" target=\"_blank\">千岛湖</a>客运码头出发，沿中心湖区景观飘带建设，全程近10公里，到<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10445.html\" class=\"link _j_keyword_mdd\" data-kw=\"千岛湖\" target=\"_blank\">千岛湖</a>大桥与千汾线衔接，可边骑车边体验城市风情<br/>驿站：<br/>140公里的绿道，对我们一般的骑行体验者来说，绝对太过挑战。于是沿途建设了许多<a href=\"http://zuche.mafengwo.cn/jump_landing_page.php?keyword=%E8%87%AA%E9%A9%BE\" class=\"link\" data-kw=\"自驾\" target=\"_blank\">自驾</a>骑行驿站，现在已经投入使用的共有18个，淳杨线贯通后将会有更多驿站投入建设<br/>这些驿站风格不一、功能变化多样，适合各种不同的需求<br/>综合型：如排岭半岛骑行营地，又称慢生活广场，可提供自行车租赁、急救、露营、烧烤，功能最齐全，适合团体活动<br/>食宿型：如小方农庄、<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/66243.html\" class=\"link _j_keyword_mdd\" data-kw=\"小金\" target=\"_blank\">小金</a>山驿站，有房间、饭店、简单的娱乐设施、自行车租赁等，适合过夜歇息<br/>农家型：如桐子坞驿站，由农家乐组成，可吃农家饭、干农家活，体验乡村乐趣<br/>观景型：如竹里摄影点、三潭驿站，提供观景平台，可以在这里摄影、观景、野餐等<br/>茶室型：如贝欧驿站，除了住宿吃饭，还可以在临湖小屋里喝茶、喝咖啡，享受惬意时光<br/>认证：<br/>环<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10445.html\" class=\"link _j_keyword_mdd\" data-kw=\"千岛湖\" target=\"_blank\">千岛湖</a>骑行是可以认证的。在排岭半岛营地、<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/66243.html\" class=\"link _j_keyword_mdd\" data-kw=\"小金\" target=\"_blank\">小金</a>山驿站和城区8个旅游咨询亭，骑行爱好者可以免费领取一本环<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10445.html\" class=\"link _j_keyword_mdd\" data-kw=\"千岛湖\" target=\"_blank\">千岛湖</a>骑游认证书，认证书上共有11个认证点，参与骑行体验的朋友可以沿着绿道找到指定地点盖章，集齐所有印章就证明自己完成环湖挑战<br/>服务：<br/>环<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10445.html\" class=\"link _j_keyword_mdd\" data-kw=\"千岛湖\" target=\"_blank\">千岛湖</a>骑游有一套非常完善的服务体系<br/>租赁：目前，<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10445.html\" class=\"link _j_keyword_mdd\" data-kw=\"千岛湖\" target=\"_blank\">千岛湖</a>共有4个驿站、8个旅游咨询亭和16个酒店可以提供自行车租赁，租赁网点遍布各角落，十分便捷；安全保障：凡是正规自行车租赁网点，都会为每位<a href=\"http://zuche.mafengwo.cn/jump_landing_page.php?keyword=%E7%A7%9F%E8%BD%A6\" class=\"link\" data-kw=\"租车\" target=\"_blank\">租车</a>体验客人自动购买一份人身意外保险，保障大家的权益<br/>救助：在骑行过程中，如果遇到车辆故障、意外受伤等，<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10445.html\" class=\"link _j_keyword_mdd\" data-kw=\"千岛湖\" target=\"_blank\">千岛湖</a>自行车俱乐部还提供及时救助服务。明年，环<a href=\"http://www.mafengwo.cn/travel-scenic-spot/mafengwo/10445.html\" class=\"link _j_keyword_mdd\" data-kw=\"千岛湖\" target=\"_blank\">千岛湖</a>自行车租赁“通借通还”将纳入议程，未来，体验者想把车还哪里就还哪里，不再受哪里借还哪里的困扰，骑行游也将变得更加顺畅<br/>注意：<br/>记得带雨披，得电子产品防水工作做好<br/>戴头盔，做好防晒措施</p><p><br/></p>', '2016-05-21 21:37:03', '2', 'cd188c18-9fd0-43f1-9dbe-78c4e94ff454.jpeg#b274ae97-0b18-4dd8-8160-f98673cc2408.jpeg#18f86981-9f57-4f63-9fad-e311640a803f.jpeg#', 'jly');

-- ----------------------------
-- Table structure for roomtype
-- ----------------------------
DROP TABLE IF EXISTS `roomtype`;
CREATE TABLE `roomtype` (
  `roomid` int(11) NOT NULL AUTO_INCREMENT COMMENT '房型id',
  `hotelid` int(11) DEFAULT NULL COMMENT '酒店id',
  `roomname` varchar(50) DEFAULT NULL COMMENT '房型类别',
  `roomdescr` varchar(1024) DEFAULT NULL COMMENT '房型描述',
  `roomprice` decimal(10,2) NOT NULL COMMENT '房型预订单价',
  PRIMARY KEY (`roomid`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of roomtype
-- ----------------------------
INSERT INTO `roomtype` VALUES ('1', '1', '迷你单人间', '有热水供应，wifi', '85.00');
INSERT INTO `roomtype` VALUES ('3', '5', '自主双床房', ' 面积20㎡双床(不可以加床)，独立卫浴有窗 ，24小时wifi，热水', '118.00');
INSERT INTO `roomtype` VALUES ('4', '5', '自主大床房', ' 面积16㎡独立卫浴有窗 ，wifi，空调，电视', '124.00');
INSERT INTO `roomtype` VALUES ('5', '5', '经济房（无窗）', ' 位于3-7层独立卫浴 ，24小时wifi', '113.00');
INSERT INTO `roomtype` VALUES ('6', '5', '传统大床房', 'wifi， 面积16㎡独立卫浴有窗 ', '134.00');
INSERT INTO `roomtype` VALUES ('7', '6', '迷你单人间', ' 位于2-7层独立卫浴有窗 ，wifi', '79.00');
INSERT INTO `roomtype` VALUES ('8', '6', '标准双人间', ' 面积18㎡位于2-7层双床(不可以加床)独立卫浴有窗 ，24小时wifi', '95.00');
INSERT INTO `roomtype` VALUES ('9', '6', '情侣大床房', ' 面积20㎡位于2-4层大床(不可以加床)独立卫浴有窗 ，fiwi', '130.00');
INSERT INTO `roomtype` VALUES ('10', '7', '特价小房', ' 面积9㎡位于6-15层大床(不可以加床)独立卫浴无窗 ', '73.00');
INSERT INTO `roomtype` VALUES ('11', '7', '美景大床房', ' 面积10㎡位于6-15层大床(不可以加床)独立卫浴有窗 ', '150.00');
INSERT INTO `roomtype` VALUES ('12', '7', '美景阳台大床房', ' 面积15㎡位于6-15层大床(不可以加床)独立卫浴有窗 ', '200.00');
INSERT INTO `roomtype` VALUES ('13', '7', '海景阳台大床房', ' 面积15㎡位于5-15层大床(不可以加床)独立卫浴有窗 ', '250.00');
INSERT INTO `roomtype` VALUES ('14', '8', '高级丽景双人房', ' 面积33㎡位于1-3层大床/双床独立卫浴有窗\n', '198.00');
INSERT INTO `roomtype` VALUES ('15', '8', '高级丽景大床房', ' 面积33㎡位于1-3层大床(不可以加床)独立卫浴有窗 ', '250.00');
INSERT INTO `roomtype` VALUES ('16', '8', '豪华丽景双人房', ' 面积33㎡位于1-3层大床/双床(不可以加床)独立卫浴有窗 ', '300.00');
INSERT INTO `roomtype` VALUES ('17', '9', '特价房', ' 面积20㎡位于1层双床独立卫浴有窗 ', '79.00');
INSERT INTO `roomtype` VALUES ('18', '9', '高级双床房', ' 面积25㎡位于1-7层双床(不可以加床)独立卫浴有窗 ', '150.00');
INSERT INTO `roomtype` VALUES ('19', '9', '高级大床房', ' 面积25㎡位于1-7层大床(不可以加床)独立卫浴有窗 ', '150.00');
INSERT INTO `roomtype` VALUES ('20', '9', '豪华大床房', '面积25㎡位于1-7层大床(可以加床)独立卫浴有窗 ', '200.00');
INSERT INTO `roomtype` VALUES ('21', '10', '单人房', ' 面积15㎡位于1层大床(不可以加床) ', '69.00');
INSERT INTO `roomtype` VALUES ('22', '10', '大床房', ' 面积15㎡位于2层大床(不可以加床)独立卫浴 ', '130.00');
INSERT INTO `roomtype` VALUES ('23', '10', '家庭房', ' 面积20㎡位于2层双床(不可以加床)独立卫浴 ', '199.00');
INSERT INTO `roomtype` VALUES ('24', '11', 'C座客房', ' 独立卫浴有窗 ', '187.00');
INSERT INTO `roomtype` VALUES ('25', '11', 'A座客房', '双床(可以加床)独立卫浴', '235.00');
INSERT INTO `roomtype` VALUES ('26', '11', 'C座套房', '大床独立卫浴', '235.00');

-- ----------------------------
-- Table structure for spotcomment
-- ----------------------------
DROP TABLE IF EXISTS `spotcomment`;
CREATE TABLE `spotcomment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '评论id',
  `spotid` int(11) DEFAULT NULL COMMENT '景点id',
  `userid` int(11) DEFAULT NULL COMMENT '评论用户id',
  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
  `content` varchar(255) DEFAULT NULL COMMENT '评论内容',
  `addtime` datetime DEFAULT NULL COMMENT '评论时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of spotcomment
-- ----------------------------
INSERT INTO `spotcomment` VALUES ('1', '8', '1', 'jly', '蛮好玩的，推荐大家去', '2016-05-20 16:21:43');
INSERT INTO `spotcomment` VALUES ('2', '8', '2', '江林燕', '不错不错，山水好呀', '2016-05-21 16:22:04');
INSERT INTO `spotcomment` VALUES ('3', '8', '1', 'jly', '象鼻山，不错额景点', '2016-05-22 00:22:52');

-- ----------------------------
-- Table structure for spotorder
-- ----------------------------
DROP TABLE IF EXISTS `spotorder`;
CREATE TABLE `spotorder` (
  `orderid` varchar(25) NOT NULL COMMENT '订单id',
  `spotid` int(11) DEFAULT NULL COMMENT '景点id',
  `spotname` varchar(25) DEFAULT NULL COMMENT '景点名称',
  `spotprice` decimal(10,2) DEFAULT NULL COMMENT '景点门票',
  `username` varchar(25) DEFAULT NULL COMMENT '订票用户',
  `name` varchar(20) DEFAULT NULL COMMENT '取票人',
  `phone` varchar(20) DEFAULT NULL COMMENT '取票电话',
  `nums` int(11) DEFAULT NULL COMMENT '门票数目',
  `totalprice` decimal(10,2) DEFAULT NULL COMMENT '门票总额',
  `ordertime` datetime DEFAULT NULL COMMENT '订票日期',
  `tratime` datetime DEFAULT NULL COMMENT '游玩日期',
  `orderstatus` varchar(1) DEFAULT NULL COMMENT '订单状态,0提交,1付款',
  PRIMARY KEY (`orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of spotorder
-- ----------------------------
INSERT INTO `spotorder` VALUES ('20160520071324', '8', '象鼻山4A景区', '98.00', 'jly', '江林燕', '136456121', '2', '196.00', '2016-05-20 19:13:24', '2016-05-28 00:00:00', '0');

-- ----------------------------
-- Table structure for spotuser
-- ----------------------------
DROP TABLE IF EXISTS `spotuser`;
CREATE TABLE `spotuser` (
  `userid` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` varchar(25) DEFAULT NULL,
  `userpwd` varchar(25) DEFAULT NULL COMMENT '密码',
  `name` varchar(20) DEFAULT NULL COMMENT '会员姓名',
  `phone` varchar(25) DEFAULT NULL COMMENT '联系电话',
  `addr` varchar(50) DEFAULT NULL COMMENT '联系地址',
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of spotuser
-- ----------------------------
INSERT INTO `spotuser` VALUES ('1', 'jly', '55555', '江林燕', '147815154', '长沙');
INSERT INTO `spotuser` VALUES ('2', 'jly1', '55555', '', '', '');

-- ----------------------------
-- Table structure for viewspot
-- ----------------------------
DROP TABLE IF EXISTS `viewspot`;
CREATE TABLE `viewspot` (
  `spotid` int(11) NOT NULL AUTO_INCREMENT COMMENT '景点id',
  `spotname` varchar(50) DEFAULT NULL COMMENT '景点名称',
  `spotcity` varchar(25) DEFAULT '' COMMENT '经典城市',
  `spotaddr` varchar(50) DEFAULT NULL COMMENT '景点详细地址',
  `spotdescr` text COMMENT '经典详细介绍',
  `spotprice` decimal(10,2) DEFAULT '0.00' COMMENT '经典单价',
  `spotremark` text COMMENT '经典备注，预订须知之类的',
  `sportimage` varchar(1024) DEFAULT NULL COMMENT '景点图片url',
  PRIMARY KEY (`spotid`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of viewspot
-- ----------------------------
INSERT INTO `viewspot` VALUES ('8', '象鼻山4A景区', '桂林', '广西壮族自治区桂林市民主路52号', '        景区因有一座酷似大象的象鼻山而得名，象鼻山位于桂林市漓江与桃花江的汇流处，以其独特的山形和悠久的历史成为桂林城徽标志。位于象鼻与象身之间的水月洞内留存摩崖石刻50余件，是广西重点文物保护单位，唐代著名诗人韩愈的名句：“江作青罗带，山如碧玉簪”镌刻洞中。水月洞与水中倒影宛如一轮明月，自古有象山水月的美誉，宋代蓟北处士有诗赞：“水底有明月，水上明月浮，水流月不去，月去水还流。”2013年9月象山景区获央视新闻频道网络评选的“中国最美赏月地”称号。\r\n        ', '98.00', '        开放时间：\r\n12月~3月：07:00~21:30；\r\n4月~11月：06:30~21:30；      \r\n        ', 'bb2e29e6-cfcf-4d5c-91a7-5f7dc37c0a62.jpg#2abebae6-a559-47c4-96e1-7a37f2ea9289.jpg#93accacf-b5ae-47b6-af8d-a510367eb466.jpg#2c9fc122-d504-4459-bb27-1ed97dd35a95.jpg#');
INSERT INTO `viewspot` VALUES ('9', '漓江5A景区', '桂林', '广西壮族自治区桂林市阳朔县', '        我们常说的“漓江”，指的是由溶江镇汇灵渠水，流经灵川、桂林、阳朔，至平乐一段，兼有“山青、水秀、洞奇、石美”四绝，还有“洲绿、滩险、潭深、瀑飞”之胜。主要景点有九龙山、螺蛳山、兴坪、黄布倒影、九马画山、下龙风光、浪石风光、杨堤风光、冠岩、大圩古镇等，是桂林山水精华之所在。漓江两岸的山峰伟岸挺拔，形态万千，石峰上多长有茸茸的灌木和小花，远远看去，若美女身上的衣衫。江岸的堤坝上，终年碧绿的凤尾竹，似少女的裙裾，随风摇曳，婀娜多姿。最可爱是山峰倒影，几分朦胧，几分清晰。江面渔舟几点，红帆数页，从山峰倒影的画面上流过，真有“船在青山顶上行”的意境。百里漓江的每一处景致，都是如此的诗情画意。唐代大诗人韩愈曾以“江作青罗带，山如碧玉簪”的诗句来赞美这条如诗似画的漓江。乘竹筏泛游漓江，可观奇峰倒影、碧水青山、牧童悠歌、渔翁闲钓、古朴的田园人家，享受“舟行碧波上，人在画中游”的美好情境。而游览漓江，还有一个绝妙之处，景观不因时、因地、因气候受影响，而会各有独特之处。不同的天气漓江更是别有一番风味：晴天，青峰倒影；阴天，漫山云雾；雨天，漓江烟雨。甚至是阴雨天，但见江上烟波浩渺，群山若隐若现，浮云穿行于奇峰之间，雨幕似轻纱笼罩江山之上，活像一幅幅千姿百态的泼墨水彩画。大漓江：就是现在很多朋友说的漓江全程游，就是从桂林的磨盘山--阳朔，全程游览的时间为4个半小时左右。小漓江：就是从桂林开车到阳朔兴坪镇，从兴坪码头上下船，游览的时间为1个半小时左右。那么到底大漓江好，还是小漓江好呢，这个问题很难说了，主要还是看个人喜欢，假如你觉得坐船的时间长了点，那就选择游小漓江，假如喜欢坐船，多欣赏一下漓江风光，那就选择大漓江，当然价格也贵一点，这个问题，还是根据个人来定。       \r\n        ', '120.00', '        开放时间：\r\n12月~3月：08:40~21:40；\r\n4月~11月：08:40~22:40；      \r\n        ', 'e064bc77-6ced-4f65-be30-44b0e2a939cd.jpg#7bf05626-376d-454f-adeb-ebf5f7fe0c1c.jpg#764f2a87-e55b-443a-83da-69f6790ba5a9.jpg#88c70ab2-21d1-4be1-81cf-2d250c6ac7a5.jpg#');
INSERT INTO `viewspot` VALUES ('10', '印象刘三姐', '桂林', '广西壮族自治区桂林市阳朔县田园路1号', '        大型桂林山水实景演出《印象·刘三姐》是中国·漓江山水剧场之核心工程，由桂林广维文华旅游文化产业有限公司投资建设、我国著名导演张艺谋、王潮歌、樊跃出任总导演，国家一级编剧、中国实景演出创始人、山水文化机构董事长梅帅元任总策划、制作人，历时五年半努力制作完成。它集漓江山水、广西少数民族文化及中国精英艺术家创作之大成，是全国第一部全新概念的“山水实景演出”。演出集唯一性、艺术性、震撼性、民族性、视觉性于一身，是一次演出的革命、一次视觉的革命。\r\n        ', '90.00', '                \r\n        ', '7a03e6fd-29cb-4e59-8dea-ca1f6906d8f7.jpg#adc9a1d7-1dcf-4c89-947c-ba05fca5c031.jpg#cbcd5577-d51b-4966-9f13-cd662bd3aa71.jpg#2f0e5df4-8c88-4850-aff3-b765d73f4797.jpg#');
INSERT INTO `viewspot` VALUES ('11', '桂林漓江竹筏精华漂流', '桂林', '广西壮族自治区桂林市阳朔县杨堤乡杨堤码头', '        离画山之南不远，便是黄布滩。漓江山色之美，美在倒影中；漓江倒影之美，就数黄布滩倒影最为醉人。这里江流清澈，碧绿透底，从水面上可以看到江底有块米黄色的大石板，长、宽各数丈，恰似一匹黄布平铺在河床之上，黄布滩由此得名。人民大会厅的展示厅里挂着两幅图，一幅是代表人文景观的中国万里长城，而另一幅代表自然景观的则是漓江上的黄布倒影！\r\n\r\n黄布滩左右两岸，有七个大小不一的山峰浴水而出，亭亭玉立，好像七位娴静的少女，人们称她们为“七仙下凡”。传说，有一天天宫中的七位小姐妹，来到漓江游玩，被这里的山光水色所迷，流连忘返，天帝知道后，命令她们返回天宫，众姐妹迷恋漓江景色，宁可长留人间，也不愿返回天庭，于是各人吹了一口仙气，将自己化作石峰。\r\n\r\n看倒影与天气有关：雨天，倒影被雨点打碎；雾天，倒影有被浓雾吞没。只有碧空如洗的晴日，倒影最为清晰。七仙女才肯在人前显露其艳丽的姿容。看黄布倒影的最佳角度，是在游船驶入蚂蝗洲的拐弯处，那山峦、翠竹、蓝天、白云倒影在碧水之中，只见水映山青，山浮水秀。山水连成一体，水天溶为一色，简直不分江中山是影，难辨水上影为山，这就是经常进入摄影佳作的名景——黄布倒影。古今多少名人文土，无不陶醉在这“分明看见青山顶，船在青山顶上行”。       \r\n        ', '120.00', '        开放时间：\r\n每天06:30~17:00\r\n\r\n        ', '2dbadbb4-febf-4625-85be-45b747a4476b.jpg#bdf5c949-d90c-4793-bef6-2146a31de523.jpg#674b77d2-4648-4d78-a601-5e36fe19c91c.jpg#29cb3685-b501-4b78-b1e7-da57515f39c7.jpg#');
INSERT INTO `viewspot` VALUES ('12', '天涯海角4A景区', '三亚', '海南省三亚市沿海滨西行26公里天涯镇马岭', '        天涯海角风景区位于三亚市区约23公里的天涯镇下马岭山脚下，前海后山，风景独特。步入游览区，沙滩上那一对拔地而起的高10多米，长60多米的青灰色巨石赫然入目。两石分别刻有“天涯”和“海角”字样,意为天之边缘，海之尽头。“天涯海角”就是由此得名。奇石“天涯海角”和“南天一柱”各都流传着一个动人的故事。 这里融碧水、蓝天于一色，烟波浩瀚，帆影点点。椰林婆娑，奇石林立，如诗如画。那刻有“天涯”、“海角”、“南天一柱”、“海判南天”的巨石雄峙南海之滨，为海南一绝。 \r\n        ', '60.00', '        开放时间：\r\n每天07:30~18:30，停止入园时间：18:00\r\n        \r\n        ', '16e5459f-e1aa-4352-8e54-48db9c6f0027.jpg#5f784cf4-90f2-46cd-aa2b-59d3025e6ab6.jpg#a294ca21-8cda-44de-864c-c320a08e74ca.jpg#b403158f-3ad3-42de-b7ac-e213da90de17.png#');
INSERT INTO `viewspot` VALUES ('13', '亚龙湾4A景区', '三亚', '海南省三亚市亚龙湾国家旅游度假区', '                亚龙湾气候温和、风景如画，这里不仅有蓝蓝的天空、明媚温暖的阳光、清新湿润的空气、连绵起伏的青山、千姿百态的岩石、原始幽静的红树林、波平浪静的海湾、清澈透明的海水，洁白细腻的沙滩以及五彩缤纷的海底景观等，而且八公里长的海岸线上椰影婆裟，生长着众多奇花异草和原始热带植被，各具特色的度假酒店错落有致的分布于此，又恰似一颗颗璀璨的明珠，把亚龙湾装扮的风情万种、光彩照人。 \r\n        \r\n        ', '150.00', '                开放时间：\r\n每天07:30~18:00\r\n\r\n        \r\n        ', '38213c97-2624-477a-860c-dbe9caae38c9.jpg#9c095501-ffd7-4518-b9ff-b08eb8b86d27.jpg#dcd8bd68-b691-4ed2-b1d1-80ad49d5855e.jpg#0c95c340-7d82-4bfc-8b50-bf4f2eb81f4b.jpg#');
INSERT INTO `viewspot` VALUES ('14', '呀诺达热带雨林5A景区', '三亚', '海南省保亭黎族苗族自治县三道农场呀诺达雨', '        “呀诺达”是形声词，在海南本土方言中表示一、二、三。景区赋予它新的内涵，“呀”表示创新，“诺”表示承诺，“达”表示践行，同时“呀诺达”又被意为欢迎、你好，表示友好和祝福。\r\n海南呀诺达雨林文化旅游区位于三亚市西南部海南省保亭县三道农场，沿海榆中线（224国道）三亚往五指山/保亭方向，距三亚市中心仅35公里，三亚凤凰机场52公里，三亚火车站40公里，为中国唯一地处北纬18度的热带雨林，是海南岛五大热带雨林精品的浓缩，堪称中国钻石级雨林景区。景区总体规划面积45平方公里，计划总投资100亿元人民币，集观光度假、体验参与、休闲娱乐为一体、可持续发展的文化中心，是“大三亚旅游圈”的“金三角”地区。\r\n \r\n        ', '118.00', '        开放时间：\r\n每天08:00~18:00，停止入园时间：17:30\r\n\r\n        ', '32abba9a-f79e-46a6-bc8c-1dd2551f4c5b.png#275ad1d3-0997-435a-be3f-0bb1586dc78f.jpg#36118478-3971-480a-bf34-da298bdb78cc.jpg#c2db7019-0006-4e13-a041-a846e10f8958.jpg#');
INSERT INTO `viewspot` VALUES ('15', '故宫5A景区', '北京', '北京市东城区景山前街4号', '        北京故宫，旧称紫禁城，是中国明、清两代24位皇帝的皇宫，现在指位于北京的故宫博物院，位于北京市中心，是无与伦比的古代建筑杰作，也是世界现存最大、最完整的木质结构的古建筑群。\r\n故宫宫殿建筑均是木结构、黄琉璃瓦顶、青白石底座，饰以金碧辉煌的彩画。建筑整体沿着一条南北向中轴线排列并向两旁展开，南北取直，左右对称。依据其布局与功用分为“外朝”与“内廷”两大部分，以乾清门为界，乾清门以南为外朝，以北为内廷。外朝、内廷的建筑气氛迥然不同。外朝以太和殿、中和殿、保和殿三大殿为中心，其中三大殿中的\"太和殿”俗称“金銮殿”，是皇帝举行朝会的地方，也称为“前朝”。此外两翼东有文华殿、文渊阁、上驷院、南三所；西有武英殿、内务府等建筑。建筑造型宏伟壮丽，庭院明朗开阔，象征封建政权至高无上。内廷以乾清宫、交泰殿、坤宁宫后三宫为中心，两翼为养心殿、东六宫、西六宫、斋宫、毓庆宫，后有御花园。是封建帝王与后妃居住之所。\r\n     \r\n        ', '60.00', '        开放时间：\r\n11月~3月：08:30~16:30，停止入园时间：15:40；\r\n4月~10月：08:30~17:00，停止入园时间：16:00；\r\n最佳观赏时间：\r\n体验宫廷：1月至12月。\r\n \r\n        ', 'a44bb871-77ef-4cd8-8ae3-fd8e078d8f78.jpg#ffff4912-043b-4b57-b2a3-5696de05f451.jpg#c49e2216-5264-4969-bae0-65abb58da121.png#c490ca76-27d2-454f-929d-ad7f6cfe68d2.jpg#d6162d48-96e0-40d7-b283-580c4f2f0aab.jpg#');
INSERT INTO `viewspot` VALUES ('16', '天安门广场', '北京', '北京市东城区天安门', '        饱经500余年风雨沧桑的天安门广场是当今世界上最大的城市广场。它不仅见证了中国人民一次次要民主、争自由，反抗外国侵略和反动统治的斗争，更是共和国举行重大庆典、盛大集会和外事迎宾的神圣重地。建国后的天安门广场经历了三次大规模改、扩建工程，使古老的广场更加宏伟壮观，成为中华民族凝聚力和祖国繁荣昌盛的象征。\r\n改造后的天安门广场发生了巨大变化，整个广场东西宽500米，南北长880米，总面积达44万平方米。其中，铺筑水泥板块20公项，周围路面30万平方米。广场中心干道上铺砌由桔黄、蓝青色花岗石组成的“人”字型路面，长达390米，宽80米，共用花岗石石料3.12万平方米。中心干道可同时通过120列游行队伍，宽阔的广场可容纳100万人游行集会。\r\n旧日作为宫廷前卫的正阳门和天安门，尽管位置依旧，然而功能一新。这两座巍峨的建筑，已成为新的人民广场南北边界的标志。人民大会堂和革命历史博物馆分列东西两厢，新老建筑物十分和谐地融合在一起，形成具有极大民族特色的轮廓线。透过蔚为壮观的古今建筑群，我们不难看出悠久历史文化的延续、发展和显示出的社会主义新时代精神的主题。\r\n\r\n        ', '60.00', '        开放时间：\r\n每天05:00~22:00\r\n\r\n        ', '2a4e863d-f4d6-445b-ae74-b8baa51f7da5.jpg#cfcc883b-c4ee-4b13-9c8e-b77e94f64a20.jpg#4e59be31-a4f1-4528-a7b8-c6e3e9c68ef8.jpg#aa7f41b1-750c-4ce0-b09f-06b60829f347.jpg#');
INSERT INTO `viewspot` VALUES ('17', '八达岭长城5A景区', '北京', '北京市延庆县军都山关沟古道北口216省道', '        八达岭长城史称天下九塞之一，是万里长城的精华，在明长城中，独具代表性。八达岭长城是万里长城向游人开得最早的地段，八达岭景区以八达岭长城为主，兴建了八达岭饭店、全周影院和由江泽民主席亲笔题名的中国长城博物馆等功能齐全的现代化旅游服务设施。八达岭景区以其宏伟的景观、完善的设施和深厚的文化历史内涵而著称于世。八达岭是在明长城中保存最好、也最具代表性的地段，古称“居庸之险不在关而在八达岭”。该段长城地势险峻，居高临下，集巍峨险峻、秀丽苍翠于一体。八达岭是历史上许多重大事件的见证。第一帝王秦始皇东临碣石后，从八达岭取道大同，再驾返咸阳；肖太后巡幸、元太祖入关、元代皇帝每年两次往返北京和上都之间、明代帝王北伐、李自成攻陷北京、清代天子亲征……八达岭都是必经之地。近代史上，慈禧西逃泪洒八达岭、詹天佑在八达岭主持修筑中国自力修建的第一条铁路——京张铁路、孙中山先生登临八达岭长城等，都留下了许多历史典故和珍贵的历史回忆。八达岭长城驰名中外，誉满全球。它是万里长城向游人开放最早的地段。“不到长城非好汉”。迄今。八达岭已接待中外游人一亿三千万，先后有尼克松、里根、撒切尔、戈尔巴乔夫、伊丽莎白、希思等372位外国首脑和众多的世界风云人物，登上八达岭观光游览。     \r\n        ', '76.00', '        开放时间：\r\n11月~3月：07:00~18:00；\r\n4月~10月：06:30~18:00；   \r\n        ', '8ca059a8-e30f-4353-9077-cd8bab371b7d.jpg#6fc5cfc2-555a-4864-9292-2813de749811.jpg#d6005d24-f298-4c8c-b441-90ef90a32eeb.jpg#d4383649-518b-4b76-8346-69221b8dbe78.png#77673f01-a17d-4ceb-8a7c-9577418da856.jpg#');
INSERT INTO `viewspot` VALUES ('18', '颐和园5A景区', '北京', '北京市海淀区新建宫门路19号', '        颐和园，北京市古代皇家园林，前身为清漪园，坐落在北京西郊，距城区十五公里，占地约二百九十公顷，与圆明园毗邻。它是以昆明湖、万寿山为基址，以杭州西湖为蓝本，汲取江南园林的设计手法而建成的一座大型山水园林，也是保存最完整的一座皇家行宫御苑，被誉为“皇家园林博物馆”，也是国家重点景点。颐和园整个园林以万寿山上高达41米的佛香阁为中心，根据不同地点和地形，配置了殿、堂、楼、阁、廊、亭等精致的建筑。山脚下一条长达728米的长廊，犹如一条彩虹把多种多样的建筑物以及青山、碧波连缀在一起。\r\n清朝乾隆皇帝继位以前，在北京西郊一带，建起了四座大型皇家园林。乾隆十五年（1750年），乾隆皇帝为孝敬其母孝圣皇后动用448万两百银在这里改建为清漪园，形成了从现清华园到香山长达二十公里的皇家园林区。咸丰十年（1860年），清漪园被英法联军焚毁。光绪十四年（1888年）重建，改称颐和园，作消夏游乐地。光绪二十六年（1900年），颐和园又遭“八国联军”的破坏，珍宝被劫掠一空。清朝灭亡后，颐和园在军阀混战和国民党统治时期，又遭破坏。\r\n\r\n        ', '55.00', '        开放时间：\r\n11月~3月：07:00~19:00，停止入园时间：17:00；\r\n4月~10月：06:30~20:00，停止入园时间：18:00；\r\n        ', 'e253aae3-113e-46d2-bd9d-be779ccef74e.jpg#6928f1be-fc71-49fc-ab76-f49e7a41d750.jpg#46426416-4f76-4c65-8597-3fa93a0c44b6.jpg#09798536-46bf-416f-a29d-5e1fb88cd47b.jpg#78e1bd95-ebd5-46c7-966e-e3eb32b0cca6.jpg#');
INSERT INTO `viewspot` VALUES ('19', '外滩', '上海', '上海市黄埔区', '        白渡桥至金陵东路的一段黄浦滩，因位于上海县城厢之外的浦滩，被习称为“外滩”。它是上海都市的最初轮廓线，曾被称作黄浦路、扬子路、黄浦滩路，1945年改名为中山东一路。现在外滩大楼大都经过改建，但基本风格不变。1992年国庆节前，又完成了外滩综合改造一期工程。现在的外滩防汛墙呈厢廊式，高6.9米，宽15.4米，可抵御千年一遇的潮水。厢内能停放300多辆汽车，厢面是绿化景点和沿江步行道。路面比先前拓宽一倍，有8快2慢10个车道，外滩历来是上海的旅游热点，除能观赏中外罕见的“万国建筑博览”外，还可领略外白渡桥与吴淞路闸桥的丰姿，黄浦公园的俊巧，防洪墙的设计匠心，以及大楼与江水交相辉映的胜景。浦江夜游更有一番情趣。加之这里交通发达，购物方便，历史掌故丰富，旅游设施完备，使人留连忘返。    \r\n        ', '27.00', '                \r\n        ', '8ec2d7b0-2529-4b4e-be6a-1f7c13e426fc.jpg#239dcedc-0959-47f6-919b-8d9b13a47b4d.jpg#de5fc9ad-6c26-4aca-87d7-586f8ce56f00.jpg#');
INSERT INTO `viewspot` VALUES ('20', '上海杜莎夫人蜡像馆4A景区', '上海', '上海市南京西路2-68号新世界商厦10楼', '        上海从全球三十几个候选城市中脱颖而出，成为全球第6座杜莎夫人蜡像馆的落脚地，杜莎集团看中的是巨大的本土明星优势和广阔的市场前景。通过详细精确的市场调查，在冗长的候选名人名单中精挑细选，每位入选者都是大多数中国人渴望见到的名人。据介绍，首批纳入馆藏的名人蜡像既有贝克汉姆、乔丹、爱因斯坦、戴安娜王妃等海外名人，也涵盖了“中国特色”，中国首位航天员杨利伟、诺贝尔奖获得者杨振宁以及成龙、刘德华、周杰伦等，总共有20多位名人首批入围馆藏。为此，馆内专门设置了“体育明星”、“影视明星”、“在幕后”等展览区域，而在人物的设置上，也将充分发挥人物的“成就光辉”，如姚明在篮下运球，刘翔则站在奥运的领奖台上。\r\n除了名人外，互动性也将是上海蜡像馆的一个特色。该馆不但专门设立一个“在幕后”的展区，现场解说如何制作蜡像，而且游客前来参观，也可以当场要求工作人员以自己为摹本，制作蜡像。\r\n      \r\n        ', '120.00', '        开放时间：\r\n每天10:00~21:00\r\n\r\n        ', '416d105c-4a9e-40a8-abb9-7d38b4770307.jpg#3f35b661-69d0-4c49-acbb-813289ec0642.jpg#25176b8f-94e9-492b-ba21-ecac03035112.jpg#907db739-9c13-4965-9879-96b6cb0229e0.jpg#');
INSERT INTO `viewspot` VALUES ('21', '上海欢乐谷4A景区', '上海', '上海市浦东新区世纪大道1号', '        这里有被誉为“过山车界始祖”的木质过山车、享有“过山车之王”美誉的跌落式过山车、国际领先级4K高清飞行影院等先进的游乐设备。还有多个大型室内场馆：其中包括可容纳4500人的、带给游客至高艺术享受的华侨城大剧场；集宴会、餐饮、展览等功能于一体的大型多功能厅亚瑟宫。这里荟萃世界各地的精彩演艺活动：大型影视特技实景表演《新上海滩风云》；大型马战影视实景史诗《满江红》；大型多媒体服饰歌舞秀《欢乐之旅》；原创魔术剧《奇幻之门》……\r\n        \r\n        ', '104.00', '                        \r\n        \r\n        ', 'c12062e9-a1fd-47f2-be64-cc9c0c460336.jpg#de9dc746-72c4-40df-83e6-c2f75de93f0c.jpg#4bb1dd00-9ab5-4219-ae92-ae26ffbe08db.jpg#563dcd35-056a-4957-8728-86a13260fba0.jpg#');
INSERT INTO `viewspot` VALUES ('22', '东方明珠5A景区', '上海', '上海市浦东新区世纪大道1号', '        东方明珠塔集都市观光、时尚餐饮、购物娱乐、历史陈列、浦江游览、会展演出等多功能于一体，为人们全方位的展现了上海风貌。设计者富于幻想地将十一个大小不一、高低错落的球体从蔚蓝的空中串联到如茵的绿色草地上，两个巨大球体宛如两颗红宝石，晶莹夺目，与塔下新落成的世界一流的上海国际会议中心的两个地球球体，构成了充满“大珠小珠落玉盘”诗情画意的壮美景观。\r\n        ', '104.00', '        开放时间：\r\n每天08:00~21:30\r\n \r\n        ', '537550fb-1293-4fc8-9255-762d01d9222d.jpg#f052e3b3-370d-4aac-ba79-28174cc01042.jpg#ab866f70-bb32-4814-a2f4-529f0a80ace7.jpg#2617e2fa-bea3-409f-8355-8c315b769b47.jpg#02ffc13b-682b-4509-b622-cb33e4ea9fa8.png#');
