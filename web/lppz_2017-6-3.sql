/*
SQLyog v10.2 
MySQL - 5.7.17 : Database - lppz
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`lppz` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `lppz`;

/*Table structure for table `address` */

DROP TABLE IF EXISTS `address`;

CREATE TABLE `address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `province` varchar(20) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `us_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_address_user_info` (`us_id`),
  CONSTRAINT `fk_address_user_info` FOREIGN KEY (`us_id`) REFERENCES `user_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

/*Data for the table `address` */

insert  into `address`(`id`,`name`,`province`,`city`,`area`,`address`,`phone`,`us_id`) values (8,'大卫','云南','丽江市','玉龙纳西族自治县','还是尽快答复','15336848754',13),(13,'你好哦','云南','昭通市','绥江县','防守打法','15687495632',13),(17,'刘翔宇','北京','市辖区','朝阳区','大声道','15336848754',11);

/*Table structure for table `bigcate` */

DROP TABLE IF EXISTS `bigcate`;

CREATE TABLE `bigcate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bname` varchar(20) NOT NULL,
  `advs` varchar(50) DEFAULT NULL COMMENT '大分类首页楼层展示广告',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;

/*Data for the table `bigcate` */

insert  into `bigcate`(`id`,`bname`,`advs`) values (49,'坚果炒货','73b97967-032a-4903-9e58-69aafc2a378e.jpg'),(50,'肉脯鱼干','1ae56875-0e71-4220-8d78-41d3acc0532f.jpg'),(51,'果干果脯','b0e85263-86f3-4923-a04d-63f5da448edd.jpg'),(52,'糕点糖果','608704da-ea4b-478f-a087-98ebdb9d13ec.jpg'),(53,'素食山珍','2bd0e262-bf99-4ebd-934e-dcb7bcde5d7e.jpg'),(54,'花茶饮品','f021524c-4e44-459f-be3b-361d54cc777d.jpg'),(55,'进口食品','ccb67346-f868-4cc9-9d01-054ec27df832.jpg'),(56,'精选礼盒','92a6b8b5-7a85-48bd-a319-1f1fb3a4184a.jpg'),(57,'当季热销','cb9b0626-e4a8-48d5-9dab-7a88e8de58aa.jpg');

/*Table structure for table `cate` */

DROP TABLE IF EXISTS `cate`;

CREATE TABLE `cate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cname` varchar(50) NOT NULL,
  `b_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_bc` (`b_id`),
  CONSTRAINT `fk_bc` FOREIGN KEY (`b_id`) REFERENCES `bigcate` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

/*Data for the table `cate` */

insert  into `cate`(`id`,`cname`,`b_id`) values (22,'磕壳坚果',49),(23,'果果仁仁',49),(26,'肉食系列',50),(28,'海味系列',50),(29,'缤纷果干',51),(31,'红枣葡萄',51),(32,'糕点系列',52),(33,'饼干系列',52),(36,'美味豆干',53),(38,'其他山珍',53),(39,'养生冲调',54),(40,'进口饮品',54),(41,'进口糕点',55),(44,'零食礼盒',56),(45,'年货量贩装',56),(46,'山棕',57),(47,'糯米丸子',57);

/*Table structure for table `evalute` */

DROP TABLE IF EXISTS `evalute`;

CREATE TABLE `evalute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `econtent` varchar(255) DEFAULT NULL COMMENT '商品评价',
  `g_id` int(10) DEFAULT NULL COMMENT '商品表ID',
  `us_id` int(10) DEFAULT NULL COMMENT '用户表ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

/*Data for the table `evalute` */

insert  into `evalute`(`id`,`econtent`,`g_id`,`us_id`) values (35,'几天还有些东西没有做完',NULL,NULL);

/*Table structure for table `goods` */

DROP TABLE IF EXISTS `goods`;

CREATE TABLE `goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品编号',
  `gname` varchar(50) NOT NULL COMMENT '商品名称',
  `gbrand` varchar(50) DEFAULT '良品铺子' COMMENT '商品品牌',
  `spec` double DEFAULT NULL COMMENT '商品规格 重量',
  `pa_id` int(11) DEFAULT NULL COMMENT '包装形式id',
  `so_id` int(11) DEFAULT NULL COMMENT '产源id',
  `gprice` double(6,2) DEFAULT NULL COMMENT '商品价格',
  `gscore` int(11) DEFAULT '0' COMMENT '商品评分',
  `gnum` int(11) DEFAULT '0' COMMENT '商品数量',
  `ev_id` int(11) DEFAULT NULL COMMENT '商品评价编号',
  `c_id` int(11) DEFAULT NULL COMMENT '小分类id',
  `statu` int(1) NOT NULL DEFAULT '1' COMMENT '商品状态1.正常 2.下架',
  PRIMARY KEY (`id`),
  KEY `fk_goods_pack` (`pa_id`),
  KEY `fk_goods_source` (`so_id`),
  KEY `fk_goods_evalute` (`ev_id`),
  KEY `fk_cate` (`c_id`),
  CONSTRAINT `fk_cate` FOREIGN KEY (`c_id`) REFERENCES `cate` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `fk_goods_evalute` FOREIGN KEY (`ev_id`) REFERENCES `evalute` (`id`),
  CONSTRAINT `fk_goods_pack` FOREIGN KEY (`pa_id`) REFERENCES `pack` (`id`),
  CONSTRAINT `fk_goods_source` FOREIGN KEY (`so_id`) REFERENCES `source` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=172 DEFAULT CHARSET=utf8;

/*Data for the table `goods` */

insert  into `goods`(`id`,`gname`,`gbrand`,`spec`,`pa_id`,`so_id`,`gprice`,`gscore`,`gnum`,`ev_id`,`c_id`,`statu`) values (64,'巧克力曲奇','良品铺子',10,2,1,20.53,4,20,NULL,32,1),(65,'糯米锅巴','良品铺子',10,8,1,2.00,4,20,NULL,32,1),(66,'蒸蛋糕','良品铺子',15,9,1,15.00,3,30,NULL,32,2),(67,'菠萝片','良品铺子',10,1,1,2.00,2,10,NULL,29,1),(68,'泰国芒果干','良品铺子',10,1,2,20.00,4,20,NULL,29,1),(69,'夹心核桃','良品铺子',30,5,1,20.00,4,50,NULL,31,1),(70,'阿胶枣片','良品铺子',12,1,1,30.00,4,12,NULL,31,1),(71,'健康枣片','良品铺子',10,2,1,20.00,4,30,NULL,31,1),(72,'速溶咖啡','良品铺子',20,8,2,90.00,4,60,NULL,40,1),(73,'香辣虾','良品铺子',100,1,1,15.00,5,100,NULL,28,1),(74,'鱿鱼花','良品铺子',500,2,1,98.00,5,100,NULL,28,1),(75,'千页豆腐烧烤味','良品铺子',10,9,2,12.00,5,8,NULL,36,1),(76,'蛋白肉素','良品铺子',21,1,1,4.00,5,8,NULL,36,1),(77,'糍粑鱼','良品铺子',298,2,1,128.00,4,60,NULL,28,1),(79,'风味豆干火辣味','良品铺子',8,1,1,2.00,3,1,NULL,36,1),(82,'鳗鱼丝','良品铺子',500,9,1,198.00,5,100,NULL,28,1),(83,'鸡蛋干麻辣味','良品铺子',500,2,1,25.00,5,2,NULL,36,1),(84,'鸡蛋干酱香味','良品铺子',500,2,1,25.00,4,2,NULL,36,1),(85,'铁板鱿鱼丝','良品铺子',200,8,1,68.00,5,60,NULL,28,1),(86,'香辣小黄鱼','良品铺子',100,8,1,58.00,5,50,NULL,28,1),(87,'千叶豆腐麻辣味','良品铺子',30,3,2,12.00,3,2,NULL,36,1),(88,'香酥小黄鱼','良品铺子',128,8,1,98.00,5,100,NULL,28,1),(89,'甜辣豆干','良品铺子',300,5,1,14.00,5,29,NULL,36,1),(90,'鳗鱼片','良品铺子',128,8,2,198.00,5,100,NULL,28,1),(91,'鱼豆腐原味','良品铺子',200,8,1,24.00,5,20,NULL,36,1),(92,'黄瓜','良品铺子',600,3,1,32.00,5,1,NULL,38,1),(94,'藕丁','良品铺子',90,8,2,10.00,4,8,NULL,38,1),(95,'风味猪肉铺自然片','良品铺子',100,9,1,68.00,5,100,NULL,26,1),(96,'零食大礼包','良品铺子',12,1,1,56.00,4,63,NULL,44,1),(97,'脆骨香辣味','良品铺子',500,9,1,68.00,5,100,NULL,26,1),(98,'微辣味卤藕','良品铺子',600,5,1,32.00,5,15,NULL,38,1),(99,'油洛果冻什锦装','良品铺子',24,1,1,89.00,3,54,NULL,44,1),(100,'鹌鹑卤蛋','良品铺子',50,1,1,14.00,3,9,NULL,38,1),(101,'牛板筋','良品铺子',100,8,1,100.00,5,50,NULL,26,1),(102,'卤藕微辣味','良品铺子',400,4,1,26.00,3,1,NULL,38,1),(103,'牛肚','良品铺子',98,9,1,98.00,5,100,NULL,26,1),(104,'端午粽处乡','良品铺子',53,5,2,43.00,4,65,NULL,45,1),(105,'牛肉豆脯','良品铺子',90,9,1,18.00,3,1,NULL,38,1),(106,'酱香味鸭舌','良品铺子',68,9,1,100.00,5,100,NULL,26,1),(107,'端午粽处乡礼','良品铺子',5,5,5,43.00,3,54,NULL,45,1),(108,'香菇拌饭酱','良品铺子',600,4,1,20.00,5,1,NULL,38,1),(109,'美人一口粽','良品铺子',54,1,1,43.00,4,65,NULL,45,1),(110,'牛肉条','良品铺子',300,9,1,100.00,5,100,NULL,26,1),(111,'鸭翅甜辣味','良品铺子',100,9,1,68.00,5,100,NULL,26,1),(112,'小土豆','良品铺子',500,2,1,25.00,1,1,NULL,38,1),(113,'盐焗鸡翅','良品铺子',100,9,1,98.00,5,50,NULL,26,1),(114,'腰果','良品铺子',200,8,1,98.00,5,65,NULL,22,1),(115,'麻辣花生','良品铺子',100,8,1,128.00,5,100,NULL,22,1),(116,'泡椒味海带结','良品铺子',40,3,1,20.00,4,1,NULL,38,1),(117,'蜂蜜扁桃仁','良品铺子',158,8,1,68.00,5,90,NULL,22,1),(118,'小花生米','良品铺子',100,8,1,98.00,5,120,NULL,22,1),(119,'菠萝果汁','良品铺子',200,4,2,50.00,4,1,NULL,40,1),(120,'小米锅巴','良品铺子',100,8,1,18.00,5,160,NULL,22,1),(121,'手剥松子','良品铺子',100,8,1,98.00,5,100,NULL,22,1),(122,'谷香乌龙茶','良品铺子',900,5,5,45.00,5,1,NULL,39,1),(123,'瓜子','良品铺子',158,8,1,16.00,5,1000,NULL,22,1),(124,'墨香莲子茶','良品铺子',500,8,1,34.00,4,1,NULL,39,1),(126,'夏威夷果','良品铺子',100,8,1,68.00,5,100,NULL,22,1),(127,'阿胶红糖','良品铺子',550,2,1,20.00,5,1,NULL,39,1),(128,'综合果仁','良品铺子',100,8,1,98.00,5,100,NULL,23,1),(129,'琥珀桃仁','良品铺子',500,9,1,68.00,5,100,NULL,23,1),(130,'唯美缤纷','良品铺子',80,5,2,55.00,3,1,NULL,39,1),(131,'桂圆红枣枸杞','良品铺子',170,8,1,70.00,3,1,NULL,39,1),(132,'甘栗','良品铺子',100,8,1,28.00,5,100,NULL,23,1),(133,'核桃黑芝麻','良品铺子',200,2,1,80.00,5,2,NULL,39,1),(134,'多味花生','良品铺子',200,9,1,18.00,5,100,NULL,23,1),(135,'紫薯花生','良品铺子',200,1,1,18.00,4,200,NULL,23,1),(136,'红豆薏仁谷味粉','良品铺子',436,1,2,90.00,1,1,NULL,39,1),(137,'蛋花玉米','良品铺子',100,8,1,18.00,3,200,NULL,23,1),(138,'红枣桂圆银耳羹','良品铺子',500,2,5,70.00,4,1,NULL,39,1),(139,'麻辣豆瓣','良品铺子',100,8,1,68.00,5,200,NULL,23,1),(140,'碧根果奶香味','良品铺子',100,8,1,68.00,5,100,NULL,23,1),(141,'方形威化饼','良品铺子',400,6,1,50.00,5,1,NULL,33,1),(142,'巧克力曲奇','良品铺子',800,2,1,45.00,1,4,NULL,33,1),(143,'皇冠丹麦曲奇','良品铺子',800,1,5,23.00,4,1,NULL,33,1),(144,'苏打饼','良品铺子',650,3,1,34.00,4,1,NULL,33,1),(145,'苏打饼芝士味','良品铺子',850,2,1,42.00,1,1,NULL,33,1),(146,'酥脆薄饼','良品铺子',900,5,1,34.00,5,1,NULL,33,1),(147,'炭烧炒面','良品铺子',900,9,1,20.00,4,1,NULL,33,1),(148,'原力水果饼干','良品铺子',980,12,2,45.00,5,1,NULL,33,1),(149,'香辣味糯米锅巴','良品铺子',890,6,1,54.00,4,1,NULL,32,2),(151,'脆冬枣','良品铺子',35,8,1,60.00,4,50,NULL,31,1),(152,'小想蒸蛋糕','良品铺子',700,6,1,34.00,4,1,NULL,32,1),(153,'啪啪啪虾片','良品铺子',80,8,2,3.00,5,1,NULL,32,1),(154,'大卫面包','良品铺子',1000,8,1,48.00,5,2,NULL,32,1),(155,'小白夹心饼干','良品铺子',670,7,2,21.00,5,1,NULL,32,1),(156,'小宇麻花','良品铺子',90,5,5,50.00,5,23,NULL,32,1),(157,'小伟椰丝球','良品铺子',80,2,2,56.00,5,1,NULL,32,1),(158,'小白果捞','良品铺子',800,3,1,39.00,5,1,NULL,29,1),(159,'黑糖话梅','良品铺子',60,9,1,4.00,4,5,NULL,29,1),(160,'小想奶糖','良品铺子',890,2,1,45.00,1,1,NULL,29,1),(161,'棉花糖','良品铺子',80,6,1,5.00,5,1,NULL,29,1),(162,'可乐糖','良品铺子',90,8,1,20.00,4,1,NULL,29,1),(163,'小卫牛奶糖','良品铺子',10,7,1,1.00,1,1,NULL,29,1),(164,'小宇米酿','良品铺子',700,2,2,20.00,2,1,NULL,29,1),(165,'想你糖果','良品铺子',500,8,2,60.00,5,1,NULL,29,1),(166,'小想布丁','良品铺子',790,2,1,15.00,5,6,NULL,29,1),(167,'咸蛋黄酥','良品铺子',900,2,2,70.00,4,2,NULL,41,1),(168,'燕麦芝士','良品铺子',80,2,2,34.00,4,1,NULL,41,1),(169,'柠檬威化饼','良品铺子',200,2,2,55.33,4,200,NULL,41,1),(170,'啦啦面面','良品铺子',700,1,2,18.00,4,400,NULL,23,1),(171,'香辣黄瓜','良品铺子',30,8,1,20.00,4,500,NULL,38,1);

/*Table structure for table `goodspic` */

DROP TABLE IF EXISTS `goodspic`;

CREATE TABLE `goodspic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pname` varchar(255) DEFAULT NULL,
  `go_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_goodspic_goods` (`go_id`),
  CONSTRAINT `fk_goodspic_goods` FOREIGN KEY (`go_id`) REFERENCES `goods` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=527 DEFAULT CHARSET=utf8;

/*Data for the table `goodspic` */

insert  into `goodspic`(`id`,`pname`,`go_id`) values (60,'CghmzFdslS-AXDdfAAI_3XI7FaU729.jpg',64),(61,'CghmzFdslTCAKdtuAADfglIgevU236.jpg',64),(62,'CghmzVdslS6AeL-HAAITgE2TVzI343.jpg',64),(63,'CghmzVdslS-AVTakAAEFF8MZSZA073.jpg',64),(64,'CghmQlgIYLqABx_dAAHj4Xa_PtE651.jpg',65),(65,'CghmQ1gIYLiAPGDkAAJzUoHhIbk070.jpg',65),(66,'CghmQ1gIYLqAQNriAADtcHzrWB4687.jpg',65),(67,'CghmQlgIYLeAIaAQAAHRJQ8wKbY320.jpg',65),(68,'CghmQlgIYLiAPMGDAAHHO49c7QM032.jpg',65),(69,'f0effb7f-9783-485f-a9c4-35b8841ee5fb-large.jpg',66),(70,'64b95eef-803b-4d9a-9f62-93e4e7018b8a-large.jpg',66),(71,'757907d1-edd7-4373-a1c8-81ef34f25453-large.jpg',66),(72,'adcf1bee-88b0-464b-8994-89945cc22782-large.jpg',66),(73,'eae7539d-f451-4d52-ad16-1f3343a5fa92-large.jpg',66),(74,'6ea87ee8-ac3d-4a43-9002-a3c2f746f5d9-large.jpg',67),(75,'09da1649-7199-417a-80a1-e29afdf16a1b-large.jpg',67),(76,'10973b4e-1c41-4ec3-ae6c-170627cc9d9f-large.jpg',67),(82,'0b77e9e3-57e8-4c10-9fe7-7f0d2ba4fdb0-large.jpg',68),(83,'1f04f80e-5da1-4d41-ad45-8cb53431349a-large.jpg',68),(84,'2bc80ef7-794e-4f91-9482-5d57786968cc-large.jpg',68),(85,'74def990-1f54-44a2-a35e-95c6de32a71a-large.jpg',68),(86,'c51485b5-b15c-413b-9d06-c2d72adafac2-large.jpg',68),(87,'CghmQ1do_gmAOhtHAAHu_0ax55Y289.jpg',69),(88,'CghmQ1do_gSAZghdAAHyUvzlrLM925.jpg',69),(89,'CghmQldo_gaAQIQhAAEL8hPUHig065.jpg',69),(90,'CghmQldo_giABc_dAAEhVR4zcp0777.jpg',69),(91,'CghmQldo_gKAXLURAAGpVtkWIGQ983.jpg',69),(92,'15342c89-7e0e-40bc-8039-450deb44e012-large.jpg',70),(93,'9c76fe08-15d4-4b89-bfdf-816bc589a42d-large.jpg',70),(94,'319c42ad-6fd5-41f8-91b2-844dfae76d94-large.jpg',70),(95,'CghmzVdsoQ-AYn-qAAG2WvWuiV4536.jpg',71),(96,'CghmzFdsoQ-ASj4PAAINKFzxn5U716.jpg',71),(97,'CghmzFdsoRCAU_JOAAFSNDg3aes352.jpg',71),(98,'CghmzVdsoQ6AcCKOAAGiRyVNUDY542.jpg',71),(99,'CghmQ1fjkcaAfgF0AAFPcISkhck336.jpg',72),(100,'CghmQ1fjkceAfIOiAAHqJ2uPF7Q972.jpg',72),(101,'CghmQ1fjkcSAD35MAAIFRYYpudg703.jpg',72),(102,'CghmQ1fjkcSAdapXAAIIU2nFLCQ975.jpg',72),(103,'CghmQlfjkcaAb281AAKKnwrZFk0936.jpg',72),(104,'1cbde80b-25bb-4ab9-ab48-16ef2de30b75-large.jpg',73),(105,'04e6d167-4082-4ede-ab53-9af9fe3ad0f0-large.jpg',73),(106,'08ba9ff0-6719-4186-8308-ae7f8a7d47d5-large.jpg',73),(107,'fa0efd11-9703-495b-ae1c-137868a23d4b-large.jpg',73),(108,'4abb5b80-84c8-47c3-a933-7bfc7b6fb5b4-large.jpg',74),(109,'6d6e805e-50b7-4117-a4f8-43ad1a092534-large.jpg',74),(110,'37dd4f93-2494-4427-bfe5-1bacb3f5d5a9-large.jpg',74),(111,'bebb37ba-9df8-4c6a-9663-9697e849c348-large.jpg',74),(112,'c90660cb-957a-4e6b-8d7b-34cd908d6070-large.jpg',74),(113,'32d7a1f0-7d09-41ad-bec4-ae5e16d0200b-large.jpg',75),(114,'CghmzFdL9rOAL2X9AAGg-8xeedQ195.jpg',75),(115,'df27ac86-5662-45b8-8d81-c138f863feba-large.jpg',75),(116,'CghmzFdsmB-AAr2YAAH_nK_1OBQ873.jpg',76),(117,'CghmzFdsmCKASfEoAAF_mDN4mY8118.jpg',76),(118,'CghmzVdsmCCAEBvtAAI17j4rjVM849.jpg',76),(119,'CghmzVdsmCGALSo1AAFb9V1eng4176.jpg',76),(120,'CghmQlcbFj6AKyJDAAJM5nXYQ80559.jpg',77),(121,'20acbbaf-3be9-4905-bfa1-1c8e75861607-large.jpg',79),(122,'69feb31a-b5f7-4594-9d0e-7eb45d74442b-large.jpg',79),(123,'70c851b4-2187-438b-8b24-66173254bfc6-large.jpg',79),(124,'5057e9f3-c103-4fcc-af09-7767d02911b5-large.jpg',79),(125,'c2a9c099-cfdf-42a9-ab08-81a1f6e9592a-large.jpg',79),(126,'CghmzFdSTqKATXVgAAH33Z7Nu7M229.jpg',82),(127,'CghmzFdSTqSAVGPdAAIS9LWtRMk174.jpg',82),(128,'CghmzFdSTqWAOn21AAF516RU-vM555.jpg',82),(129,'CghmzVdSTqOAfIpJAAIDXAprsI4246.jpg',82),(130,'233a990a-2c0a-4873-baeb-79a4174e696e-large.jpg',83),(131,'CghmzVdLqJ-AUE__AAGeTF6TJvA267.jpg',83),(132,'wKggn1TUtqWADGBfAAEQry7sbfY696.jpg',83),(133,'4a1787d2-6657-4bcc-95ff-eaf2ba766e94-large.jpg',84),(134,'09661ed6-a8bd-4e19-8e35-c2aa7bf7c873-large.jpg',84),(135,'71534316-9911-4f33-931a-22f7daa5dd10-large.jpg',84),(136,'CghmzFdsoE2AWg1_AAFFUjP4jgo024.jpg',84),(137,'CghmzVdsoEyAR7DVAAEZoiHnG5w589.jpg',84),(138,'CghmzFdHp6SADLZZAAHBPp7Xzok551.jpg',85),(139,'CghmzFexkyeANSQEAAI15U_PcXc051.jpg',85),(140,'CghmzFexkyiAeDViAAEgxblJOr0193.jpg',85),(141,'CghmzVexkyaABNsoAAHDaS82tyo316.jpg',85),(142,'CghmzVexkyeAGwmsAAEgOWDG0N8770.jpg',85),(143,'CghmzFfOmImAGMdFAAIfegOtt30150.jpg',86),(144,'wKggnFTe6aiAHWaIAAIbcp4cexc540.jpg',86),(145,'wKggnFTe6aiAIwJYAAIDSlMuF8Q465.jpg',86),(146,'wKggnFTe6amACxxuAAFTNq-OUVM992.jpg',86),(147,'wKggnFTe6amAWYtdAAC6tiZFlzI054.jpg',86),(148,'5f058ae2-39dc-4dab-9b52-a4782714ebd5-large.jpg',87),(149,'495b0970-6a00-4c5c-b9eb-5317e58173c1-large.jpg',87),(150,'e491d300-809a-4056-99a0-e610a035208d-large.jpg',87),(151,'CghmzFaJ3xiAA_KIAAFlk2RZ0PI657.jpg',88),(152,'CghmzFaJ3xWAdyanAAJcfFYmFUM017.jpg',88),(153,'CghmzFdU8daAJhrmAAIfegOtt30716.jpg',88),(154,'CghmzVaJ3xeAKwNFAAEmHVJMMiI097.jpg',88),(155,'CghmzVaJ3xOAQr14AAIGrMMQj6o643.jpg',88),(156,'56204424-91fa-41b1-b2ed-a9fae93a74db-large.jpg',89),(157,'56204424-91fa-41b1-b2ed-a9fae93a74db-small.jpg',89),(158,'wKggnFTtaGOABJhXAAItE-R_Ul0142.jpg',89),(159,'wKggnFTtaGOAfvvVAAFDh_X1RWw462.jpg',89),(160,'wKggnFTtaGOAfY2wAAEkAQgQEf0355.jpg',89),(161,'CghmzFd06V2AI89DAAK0TcNaEtk102.jpg',90),(162,'CghmzFd06VmASPUSAAI6fLOgRT4024.jpg',90),(163,'CghmzFd06WGAbTDvAAGKte8RM2E927.jpg',90),(164,'CghmzVd06V-AHmNtAAId6VtJ_yM495.jpg',90),(165,'CghmzVd06VuAZ-QXAAKJZaVZ2Ks671.jpg',90),(166,'wKggllTtRgCAYQqaAAGR01Go-jM620.jpg',91),(167,'wKggllTtRgGAYooGAAGmi0jVxyY758.jpg',91),(168,'wKggllTtRgGAZ39pAAECNEeb3lc729.jpg',91),(169,'wKggllTtRgKAMQtxAAE6ZDqOSzI542.jpg',91),(170,'4e4dc38b-ca61-4c6f-9378-70f339424917-medium.jpg',92),(171,'CghmQ1b2FxGAexmhAAGaptDOzh4815.jpg',92),(172,'CghmQ1b2FxOACAV7AAHnADJ58HY041.jpg',92),(173,'CghmQlb2FxiAesVQAAI_MQOivuQ241.jpg',92),(174,'CghmQlb2FxWAbsz1AAF97br9ZGA363.jpg',92),(180,'12cd6879-d184-476d-b3ed-308786a4c2a0-large.jpg',94),(181,'984e5b54-4261-40c4-b5db-7e417dff980e-large.jpg',94),(182,'5217f4ff-b9d6-4e52-8eeb-417885df5ab9-large.jpg',94),(183,'50793314-7a16-4f69-90c2-66f91d8a5a29-large.jpg',94),(184,'CghmzVaYvJaAMUYvAAEPvlvljrA028.jpg',95),(185,'CghmzFaYvJeAcBpkAAEDjGKzOtk843.jpg',95),(186,'CghmzFaYvJKACcQ9AAMKP3crOgc758.jpg',95),(187,'CghmzFdL5X-AWH0lAAHbYXIqyoE611.jpg',95),(188,'CghmzVaYvI6AT6l2AALRq7_ciJg659.jpg',95),(189,'CghmQ1fRCemAQQFZAAJ2YIb9czI166.jpg',96),(190,'CghmQ1fRCeqAL3hDAAHz2RXOesY562.jpg',96),(191,'CghmQlfRCeiAamJ7AAKOqVoPlao873.jpg',96),(192,'CghmQlfRCeqATiT9AAPoZ1OIFSk622.jpg',96),(193,'CghmQlfRCeuAQMQpAAKI9AHgN9g395.jpg',96),(194,'CghmzFexjueAH2sdAADbIbIVqv4060.jpg',97),(195,'CghmzFexjuWABOfaAAINDL89KDM559.jpg',97),(196,'CghmzVexjuaAMnlpAAHqzQ4KAwM133.jpg',97),(197,'CghmzVexjueAah5jAAE3GkAORII630.jpg',97),(198,'CghmzVexjuSAJLiRAAFtjGpkZR4372.jpg',97),(199,'CghmzFYoSZ2APqBtAAEN9_tjyVg824.jpg',98),(200,'CghmzFYoSZqADue0AAGriM-Db6s726.jpg',98),(201,'CghmzVYoSZuAD6vTAAGJbKWqEI4774.jpg',98),(202,'CghmzVYoSZyABVtWAAD90zf9hFg531.jpg',98),(203,'CghmzFdSUgeARjCsAAGAIac2c60060.jpg',99),(204,'CghmzFdSUgSAD2PoAAC5UB4vvyA506.jpg',99),(205,'CghmzFdSUgWATdOOAAEDv_REX4c770.jpg',99),(206,'CghmzVdSUgaAe3iuAAEQ_1F0t3I338.jpg',99),(207,'CghmzVdSUgSAKDZ5AAENhqeXdmg929.jpg',99),(208,'48ca6847-8014-4105-8087-32dc40dae7cf-large.jpg',100),(209,'85d73391-00f5-4dba-a2f7-bf2d1255d13c-large.jpg',100),(210,'CghmzFdU8sWAMVE6AAI3ZL6S7jo641.jpg',101),(211,'CghmzFYnRnaAH_G4AANJ1O2rIbo031.jpg',101),(212,'CghmzVUmRi2ABEcrAAMKLS9QAWw247.jpg',101),(213,'CghmzVUmRi2AciBTAAFc3ieXkRs578.jpg',101),(214,'0a72512b-285d-4e8f-91af-1e90bf492374-large.jpg',102),(215,'2bd6bdb6-40d0-491a-ab8d-cf6cf33d4de3-large.jpg',102),(216,'CghmzFdg9geAMf2iAAGHKiwqKp0367.jpg',102),(217,'CghmzFdX3S2AU4WNAAH73rmogpo614.jpg',103),(218,'CghmzFdX3S-AXwgGAAEvKU3BBCE398.jpg',103),(219,'CghmzFdX3SuAesZVAAHZv2dljx4664.jpg',103),(220,'CghmzVdX3S6AIM3yAAHdz_QTFiQ486.jpg',103),(221,'CghmzVdX3SyAYNmCAAIUxQNpBlw545.jpg',103),(222,'3f262726-1c92-4d53-a4f5-04ebb86cc1e0-large.jpg',104),(223,'51bc0bb4-1262-4609-a70b-7542820311d6-large.jpg',104),(224,'7517cd2f-0eb3-46af-81d2-ee3ee15edc40-large.jpg',104),(225,'7428342c-8ab5-4cfc-9c2c-8cd6388863b4-large.jpg',104),(226,'d47dd04c-535d-43a2-89a4-471231631061-large.jpg',104),(227,'159b7b18-717f-48f1-b331-16b2aa47deef-large.jpg',105),(228,'b58d6b2f-20f6-4d92-8994-e1871309f7e7-large.jpg',105),(229,'d5635e30-46f7-4b8f-a0bc-f984402b534b-large.jpg',105),(230,'38e5cb3f-1f5a-482d-a1cd-de59b110f3c2-large.jpg',106),(231,'662e3550-b780-4dae-88c9-8a05cde509a9-large.jpg',106),(232,'5167078e-060e-4299-ac07-bc3427812193-large.jpg',106),(233,'e6707690-1bd5-4677-995e-76802b600cba-large.jpg',106),(234,'2bb16832-c08f-47ef-9335-3b61b03839fa-large.jpg',107),(235,'b268ce76-31e7-4f19-bb11-31dce36b1efa-large.jpg',107),(236,'24d44d2c-3a3c-4057-9aa1-74ef49a2fdbf-large.jpg',108),(237,'5323b189-4eb2-4499-91f2-d10c63953a03-large.jpg',108),(238,'e68d01bd-2d2c-4ec8-bef1-39b7e1bc2b24-large.jpg',108),(239,'405a0818-3004-4835-aa74-c6aa60bc63c3-large.jpg',109),(240,'df778905-8622-447b-80e1-493629c62283-large.jpg',109),(241,'0f877c92-0f83-4bc3-b418-65aff7c29015-large.jpg',110),(242,'39e49bda-3793-4634-8b97-68bac63b6ea6-large.jpg',110),(243,'743f0487-e9f3-44f7-b729-8f0956e93c12-large.jpg',110),(244,'981c3044-89b9-449a-b645-35111f249757-large.jpg',110),(245,'f4f4f33e-eab0-4850-a4ce-ce2abd105c84-large.jpg',110),(246,'CghmzVZG07yAClF0AAE7CwKaTKo013.jpg',111),(247,'CghmzFZG07uAMhhWAAHa6Ls0o6I877.jpg',111),(248,'CghmzFZG07yAabbEAAFRKRcliko781.jpg',111),(249,'CghmzVZG07mATqdnAAJBjpTM0P4653.jpg',111),(250,'CghmzVZG07qAPUkYAAKprgwMwUA147.jpg',111),(251,'CghmzFekYq2AS3hYAAGKrNAKK-U697.jpg',112),(252,'CghmzFekYqqAUoH0AAEmqHR4WTg179.jpg',112),(253,'CghmzFekYquAHBMyAAJYHD1_e9c794.jpg',112),(254,'CghmzVekYquAQhlRAAGyXJLntiY705.jpg',112),(255,'CghmzVekYqyAQEFZAAIW01Hr0C0968.jpg',112),(256,'CghmzVdL1cuAa0UNAAGOUWGyUgo683.jpg',113),(257,'CghmzVWDyViAdMo9AAJtwfwsvkk869.jpg',113),(258,'CghmzVWDyViAenRRAAFK4eBQm9Q106.jpg',113),(259,'CghmzVWDyViAZUibAAHYBf_J_jo815.jpg',113),(260,'CghmzVWHbXaARyXrAAJRyJ6530U239.jpg',113),(261,'934b0342-d77f-449b-aa11-0aba6df38d4f-large.jpg',114),(262,'029599a3-87f8-4e61-bff6-207d6660b527-large.jpg',114),(263,'3995980f-4493-4a1d-98e2-d1576a171e88-large.jpg',114),(264,'a1adf2ea-ba1c-46e0-b48e-961d390aceae-large.jpg',114),(265,'f41a7110-ee8e-4d70-b8a1-58952e4af12d-large.jpg',114),(266,'CghmzVexkO-AE2rHAAEPJCqDSgM837.jpg',115),(267,'938afec8-8ad3-4cda-8faa-60a2b294874e-large.jpg',115),(268,'CghmzFexkO6ANh2BAAEojrU9kg0453.jpg',115),(269,'CghmzFexkOyAd6P0AAHrb9NTKXk686.jpg',115),(270,'CghmzVexkO2AQWNiAAKC4LMybZE339.jpg',115),(271,'CghmzFdSTViAcXGDAAEMp1tRQE4892.jpg',116),(272,'CghmzFdSTVWAH-OrAAFqtrTxyo8484.jpg',116),(273,'CghmzVdSTVaAJHPBAAFhsgAwBTA902.jpg',116),(274,'CghmzVdSTVmAJFfTAAE4Rju30F4271.jpg',116),(275,'CghmzVdSTVSABo-oAAEU-He0A3Y424.jpg',116),(276,'CghmzFdiFK2ACSxDAAMu356RLRw807.jpg',117),(277,'CghmzFdiFK6ABFN8AAIcwVV3Cpc653.jpg',117),(278,'CghmzVdiFK2AFJu0AAJtvOQJKEA464.jpg',117),(279,'CghmzVdiFK-AW4V8AAE6WsdHMeY651.jpg',117),(280,'CghmzVdiFKyAUdOiAAIpyv-cgrU166.jpg',117),(281,'CghmzFeNooeAdvpVAAIaDdf2Yw0272.jpg',118),(282,'CghmzFeNooqAEYsNAAEwTBYA1vY099.jpg',118),(283,'CghmzVeNoo2AND9DAAEpXq0fV9Q668.jpg',118),(284,'CghmzVeNooaAExHQAAF2l0z6xYw432.jpg',118),(285,'CghmzVeNooiAQ-0UAAI7rREK6o0162.jpg',118),(286,'CghmzFdSTJeAY-5PAAE16xj8yW4454.jpg',119),(287,'CghmzFdSTJSASkj-AAGNi_wOV1Q147.jpg',119),(288,'CghmzVdspVGAUbuEAAHKMFDhaE8460.jpg',119),(289,'CghmzVdSTJiAPvuKAAIypIW3Dcc024.jpg',119),(290,'CghmzVdSTJWARenUAAFXGMFqYT4015.jpg',119),(291,'CghmQ1dqM3-ACzhaAAG5J73gTho608.jpg',120),(292,'CghmQ1dqM4CAOtHaAAIpQGxXd2k083.jpg',120),(293,'CghmQ1dqM4KACl2eAAGnMmqwhCc113.jpg',120),(294,'CghmQldqM4GAHPzEAAHX-c5UKHc369.jpg',120),(295,'CghmQldqM4GALBbUAAHtSLu4Xxo307.jpg',120),(296,'3cadeb0b-ce1c-4a90-bbd6-048099b64117-large.jpg',121),(297,'36e1327b-8c97-4306-b89a-8c0ed30da44d-large.jpg',121),(298,'82f1270e-9662-4ff3-89b6-7528a2db195e-large.jpg',121),(299,'9349a2a3-74e1-41ad-a378-af29668cc9ba-large.jpg',121),(300,'d3c59983-6983-4af6-bd33-532093ed6afb-large.jpg',121),(301,'1f993779-45b5-4108-ad5c-68cf75ee6bd8-large.jpg',122),(302,'2d78975e-ef07-4768-8392-74645e47a9fd-large.jpg',122),(303,'65784f7f-de91-4477-a513-71db41143e74-large.jpg',122),(304,'98670413-4ac8-499e-b58f-1caa5ebd2794-large.jpg',122),(305,'d32ec29c-368b-4204-a2ae-6b59382b95d9-large.jpg',122),(306,'CghmzFexkIOACzXJAANcjlDLomc742.jpg',123),(307,'CghmzFexkISAR0zPAAF68rf_BQM254.jpg',123),(308,'CghmzVdJDQeAAfrMAAItkfoa3nI597.jpg',123),(309,'CghmzVexkIKAbKA8AAJVItoM_pA086.jpg',123),(310,'CghmzVexkISAZwZ3AAI9MUF1FFU246.jpg',123),(311,'21ca0438-5aa5-45ee-8fd7-9d80f2910580-large.jpg',124),(312,'238f6d84-481a-45a3-9e2a-3ef156ec473e-large.jpg',124),(313,'984f2b15-5261-41fa-bd7e-7be6a0a61532-large.jpg',124),(314,'4900ace6-94c0-4687-913e-e668ca23f4c2-large.jpg',124),(315,'f16b7734-5319-481c-a871-20206588e67a-large.jpg',124),(316,'CghmzFexhsiAKdueAAGYlLsFbPY552.jpg',126),(317,'CghmzFYwkX2AGoN8AAGtqJepHRM027.jpg',126),(318,'CghmzFYwkYKAV_OQAAEaCB3FbU4559.jpg',126),(319,'CghmzVYwkX-AFuQ1AAHSnZfqfzw891.jpg',126),(320,'CghmzVYwkYSAe2e1AAEDYqGK04g414.jpg',126),(321,'CghmzFdGpY6ARBJBAAG-vpFes2M918.jpg',127),(322,'CghmzFdGpZGAKh6mAAFfqd_WSl0166.jpg',127),(323,'CghmzVdGpY2AKNdDAAHgqZGUCTY130.jpg',127),(324,'CghmzVdGpZCAKlb0AAFtZLYU3y8987.jpg',127),(325,'CghmzVdGpZOAELFSAAI8z9jjG4k096.jpg',127),(326,'CghmzFe3tzGASmUbAAISNMKBHN0234.jpg',128),(327,'CghmzFe3tzmAZ0g2AAEyDX8YE3Q655.jpg',128),(328,'CghmzFe3tzWAHihwAAG6DUQb93Y848.jpg',128),(329,'CghmzVe3tzeAK5V0AAIN-Mw_T6Y402.jpg',128),(330,'CghmzVe3tzOAfAd3AAMgTP1AzZo249.jpg',128),(331,'3e1c6ea9-b13e-46b9-a6b5-36aeb7f06c1b-large.jpg',129),(332,'5b77f009-fcc1-462b-b507-5df88bcee839-large.jpg',129),(333,'0041c24a-25db-4b4d-89ec-fa1292e54b94-large.jpg',129),(334,'187d6e5f-a825-4ea2-8684-bf09a04cec1f-large.jpg',129),(335,'a339acb5-7958-4a68-abde-89fed6785615-large.jpg',129),(336,'4a4e2326-16c4-424f-8695-c7615d259ff2-large.jpg',130),(337,'60dbcbb2-bcf2-486b-93ae-f442eaa28098-large.jpg',130),(338,'9119d162-55d4-420f-92a2-d95f22772c28-large.jpg',130),(339,'e41f5aa0-ddb8-4815-9e13-b4639832e5a2-large.jpg',130),(340,'e4845070-a97c-422d-86a4-c7fc63026f88-large.jpg',130),(341,'0c3ac6c0-efd9-4e8c-b24e-2bb3088521ab-large.jpg',131),(342,'80b03632-9df0-4b04-9ea8-74a378650542-large.jpg',131),(343,'d84498fc-eb1b-4ae9-ac6e-20a655cc4e72-large.jpg',131),(344,'ef79fb57-a0d9-4e64-aa7a-41880710c113-large.jpg',131),(345,'16253bf6-b720-4ae1-9c19-ece04b971676-large.jpg',132),(346,'CghmzFexkA2AQpnzAAERPbxlWmk883.jpg',132),(347,'CghmzFexkAuAfz-mAAI5EARDexk304.jpg',132),(348,'CghmzVexkA6AZJTTAAEAXTgH_Xk433.jpg',132),(349,'CghmzVexkAyAOhESAADpHKMrEXE671.jpg',132),(350,'16759355-33e5-4cba-8c65-61b146603d58-large.jpg',133),(351,'debe3362-02f3-4dd2-ad90-63043a3a9d16-large.jpg',133),(352,'ff4479ef-e674-4949-a972-68b9586027c9-large.jpg',133),(353,'CghmzVUk7bOAeAp4AALB_DKN3Rk180.jpg',134),(354,'CghmzVUk7bOATvtlAAH9Jbj29uA148.jpg',134),(355,'CghmzVUk7bSAUnUtAAEa6mNkjlU886.jpg',134),(356,'CghmzVUk7bSAXb63AAJZa82zddw824.jpg',134),(357,'CghmzVUk7bWAGfO2AAEq7HSu6hk120.jpg',134),(358,'CghmzVY0fCSAdjShAAIAd8n1Z88089.jpg',135),(359,'CghmzFY0fCCAU0szAALC6Rb1dCo948.jpg',135),(360,'CghmzFY0fCmAIDIxAAEa01HqpW4306.jpg',135),(361,'CghmzVdMAwCAR-eCAAHxdpDdWm0690.jpg',135),(362,'CghmzVY0fCeAGrPMAAEHDZCMC6M919.jpg',135),(363,'4879927b-946a-469b-b95a-485a2b68e61c-large.jpg',136),(364,'5609388a-6900-44a5-a6ed-e2f2e6001d56-large.jpg',136),(365,'a516dac3-1699-4e05-b5c6-3c5c8e8bb731-large.jpg',136),(366,'fbb32249-f906-46a9-aa3d-ece0cbc08476-large.jpg',136),(367,'CghmQ1dFOwOAHcn3AAE9j6u8F70930.jpg',137),(368,'CghmQ1dFOwWAEsGlAAJu29MWim4898.jpg',137),(369,'CghmQldFOyOAF3i8AAHB9Av9UPU619.jpg',137),(370,'CghmQldFOyWASP5fAAFsp7zvF24663.jpg',137),(371,'CghmzVdLulWAJ0cgAAFoZUSZBl4295.jpg',137),(372,'5fbd4931-5cce-4a08-b66c-814e84e52152-large.jpg',138),(373,'7f95a7a0-0f7e-41e7-a348-e3e455e52917-large.jpg',138),(374,'8e0a7906-6a3f-4a64-bfe2-bb1a757f618e-large.jpg',138),(375,'9b1b72d8-34ae-41de-91f0-8ba67a6c59f6-large.jpg',138),(376,'83a76642-98a8-4073-89d0-4eb92466fe62-large.jpg',138),(377,'0bbe6e9e-3da1-4a7d-bfed-982a94d6a2f7-large.jpg',139),(378,'4e8d5e40-e40d-4306-85ce-c59c9edc35e3-large.jpg',139),(379,'49ca0c48-ef09-41e4-b843-07f47dab8579-large.jpg',139),(380,'62f6f46f-84e1-4dcb-81cf-2fe02324882c-large.jpg',139),(381,'a68ed447-e8f9-4be4-be7d-787f719fb801-large.jpg',139),(382,'CghmzFXlXi2AJnGmAADjXmRazqQ530.jpg',140),(383,'CghmzFXlXimAKK4xAAH5LNrhtyk832.jpg',140),(384,'CghmzFXlXiqAS_BwAAK95J3C-1c784.jpg',140),(385,'CghmzFXlXiyAPt47AADwvCuxAc8967.jpg',140),(386,'CghmzVdMAtqAMxJ7AAHb5y_WzG4638.jpg',140),(387,'39f9720b-2ec3-43d3-a297-fac81f71157a-big.jpg',141),(388,'39f9720b-2ec3-43d3-a297-fac81f71157a-large.jpg',141),(389,'CghmQ1fRCsGATF1oAAGqMQtZuBo590.jpg',141),(390,'CghmQlfRCr-AShYIAAHtxK7JiMQ725.jpg',141),(391,'CghmQlfRCsCAMX4vAAK6gEs4oL0619.jpg',141),(392,'CghmzFdslS-AXDdfAAI_3XI7FaU729.jpg',142),(393,'CghmzFdslTCAKdtuAADfglIgevU236.jpg',142),(394,'CghmzVdslS6AeL-HAAITgE2TVzI343.jpg',142),(395,'CghmzVdslS-AVTakAAEFF8MZSZA073.jpg',142),(396,'7dcdf6ca-7a82-4d7a-b95d-99c44962b450-large.jpg',143),(397,'18a6d7bb-fcaf-4241-b275-35d699e1dd62-large.jpg',143),(398,'60592036-dd77-4ad7-a110-0f51028032eb-large.jpg',143),(399,'b9edc0d4-1480-432e-8baf-e015c621f29d-large.jpg',143),(400,'CghmzFdfegiAdFLpAABqY0TS1fU666.jpg',144),(401,'CghmzFdfegmAGA3vAAIIeTDH1nM447.jpg',144),(402,'CghmzFdfeguAZ6UhAAEGVZw1MG4458.jpg',144),(403,'CghmzVdfeg2AbqdNAAD3dFUe5Kk086.jpg',144),(404,'CghmzVdfegmAfbPvAAG5xPfhCmU204.jpg',144),(405,'CghmzFdfejaAO_EdAAGZnQX5XJo366.jpg',145),(406,'CghmzFdfejqAI9KlAAD2bAAjIQ0827.jpg',145),(407,'CghmzFdfejSAZ9JCAAFdWLqkSvs637.jpg',145),(408,'CghmzVdfejiARYQOAAD4PUBgGnQ782.jpg',145),(409,'CghmzFdSUO6ADBnvAAFzpruca0A070.jpg',146),(410,'CghmzFdSUPGAYSWXAAElsGc5aPY713.jpg',146),(411,'CghmzVdSUPCAAldIAAD2XxKizH8681.jpg',146),(412,'CghmzFebGi2AcqqbAADX1xSMvR8716.jpg',147),(413,'CghmzFebGiiAfOrmAAHpFR-Y0iw930.jpg',147),(414,'CghmzVebGiaAFTH0AAFOPRuP9k8093.jpg',147),(415,'CghmzVebGiuAeo3IAAGTzlvh-lo891.jpg',147),(416,'CghmzVebGjCAXEP0AAEON5x4lT4637.jpg',147),(417,'2bb716a3-5d79-4a15-a2c5-8ba199dab4d4-large.jpg',148),(418,'601a0417-3f81-4fe3-a904-1db03386835c-large.jpg',148),(419,'75413381-e31f-479f-8dea-b7105225aeae-large.jpg',148),(420,'CghmQ1gIYLiAPGDkAAJzUoHhIbk070.jpg',149),(421,'CghmQ1gIYLqAQNriAADtcHzrWB4687.jpg',149),(422,'CghmQlgIYLeAIaAQAAHRJQ8wKbY320.jpg',149),(423,'CghmQlgIYLiAPMGDAAHHO49c7QM032.jpg',149),(424,'CghmQlgIYLqABx_dAAHj4Xa_PtE651.jpg',149),(425,'64b95eef-803b-4d9a-9f62-93e4e7018b8a-large.jpg',NULL),(426,'757907d1-edd7-4373-a1c8-81ef34f25453-large.jpg',NULL),(427,'adcf1bee-88b0-464b-8994-89945cc22782-large.jpg',NULL),(428,'eae7539d-f451-4d52-ad16-1f3343a5fa92-large.jpg',NULL),(429,'f0effb7f-9783-485f-a9c4-35b8841ee5fb-large.jpg',NULL),(435,'CghmzVdL_I2ATMo8AAGGJ-7EA7M871.jpg',151),(436,'CghmzVdL_I-ACVpcAAFdyLrekNw975.jpg',151),(437,'CghmzVdL_JKAVp3-AAEabyrE96s059.jpg',151),(438,'CghmzVdL_JSAedvmAADq_NBOsyI418.jpg',151),(439,'CghmzVdSLU6AUhf7AAE-5awQhzM225.jpg',151),(440,'bf88e08f-ebb3-461c-bb41-ea455ab988ab-large.jpg',152),(441,'d8c04210-2bd9-4521-9fe8-9931170eb427-large.jpg',152),(442,'d531d007-26ce-4ad4-bf12-d8480dcf1941-large.jpg',152),(443,'d4682b95-31d4-4904-b9ea-27713675bb0a-large.jpg',152),(444,'CghmzFebFE2Afy1aAAEuMBGw6fk025.jpg',153),(445,'CghmzFebFE6AJGp1AAG9SJVI0-A308.jpg',153),(446,'CghmzFebFFCAJLDwAAFm-5H8_CM628.jpg',153),(447,'CghmzVebFE6AfAIWAAH19pDjBuA055.jpg',153),(448,'CghmzVebFE-AXOrfAAKrhoOE5aU854.jpg',153),(449,'CghmQ1bjs_KAMHCBAAHLS07memY409.jpg',154),(450,'CghmQ1fM4_2AZjCCAAF3akBtT6I846.jpg',154),(451,'CghmQlbjs_CAUggWAAFz2edU9To926.jpg',154),(452,'CghmQlbjs-6AFHwXAAIJJx5ajYQ663.jpg',154),(453,'CghmzVdspXuAR51UAAHRo0IEKeg862.jpg',154),(454,'011e1c0a-2255-4d70-94d6-4829b89f860f-large.jpg',155),(455,'80a8e3e8-27c3-45fa-b408-90a10c77f086-large.jpg',155),(456,'6697032f-18ee-4995-aa14-078400aab53b-large.jpg',155),(457,'a56ad7fa-af26-4a01-93cf-30b854624857-large.jpg',155),(458,'d720e78b-10ce-4670-bb97-6c5d8b6acf99-large.jpg',155),(459,'1da2db12-ca8a-4835-9623-18c8549f1473-large.jpg',156),(460,'1f0ebf4c-cc14-42c5-8072-591141f21b4d-large.jpg',156),(461,'96813f5d-d3f9-4870-92e2-8279f369b096-large.jpg',156),(462,'b3337ead-2123-442f-8276-69775ad2c073-large.jpg',156),(463,'CghmQ1dhDCuALSX8AAFCqNABeCw662.jpg',157),(464,'CghmzVY9coeADIojAAFl-tHZX34572.jpg',157),(465,'CghmzVY9coyADonkAAFZ8UaOp9Q395.jpg',157),(466,'CghmzVY9cpGAKeUuAAC3Rl9O8CA738.jpg',157),(467,'6d4793ba-8236-4de2-aafb-5f06d3066e41-large.jpg',158),(468,'30e3619c-e8f3-4e99-84ea-cb1d4f7311fe-large.jpg',158),(469,'fa7e699f-6c76-4ac6-bd3e-a6ba40f50fa3-large.jpg',158),(470,'CghmzFdiGl-AEw9UAAFTIQDdoU8823.jpg',159),(471,'CghmzVdiGl6AQcIIAAE_IPL-IKM084.jpg',159),(472,'CghmzVdiGmCAdRoZAAG5skOZZW8591.jpg',159),(473,'CghmzVdiGmGAFeWPAAFDbzsWR4A377.jpg',159),(474,'7bf3b905-fce5-4406-b748-b92297a78bd3-large.jpg',160),(475,'226c42e0-527a-4700-940f-0b0ef3d3072e-large.jpg',160),(476,'945d691f-efe2-4828-ade7-f19786ded311-large.jpg',160),(477,'bea2638d-cf48-4611-805a-eb73b7e3ef1a-large.jpg',160),(478,'CghmzFdkx2eAOs9tAAEdF-MLASM811.jpg',161),(479,'CghmzFdkx2iAJqDYAAFbQdxNF1A701.jpg',161),(480,'CghmzFdkx2OAQVWhAADVHm_3hpM760.jpg',161),(481,'CghmzVdkx2WATXLkAAEQPY3DgQ4404.jpg',161),(482,'CghmzFfZDX2ACSffAAEWWEscz3c183.jpg',162),(483,'CghmzFfZDXmAQ1TeAAE6oogDj9M846.jpg',162),(484,'CghmzFfZDXuAFgtTAAIdBRt1_XY814.jpg',162),(485,'CghmzVfZDXqAYHsEAAGVK_Gewzg015.jpg',162),(486,'CghmzVfZDXyARMjSAAIbCNGIIAc269.jpg',162),(487,'6d9de9a1-82fe-48c1-9324-694d8228b06b-large.jpg',163),(488,'37c19cb3-0282-41b4-a6f5-dc9ea4c10015-large.jpg',163),(489,'8094d07a-6681-43a9-8236-6d8171443df1-large.jpg',163),(490,'d5ea9b1e-0273-4f4b-bd20-052726947ce2-large.jpg',163),(491,'f8ab3ee8-f874-4887-9504-8135f2dc423a-large.jpg',163),(492,'CghmzVeVyk2AMhk8AADUEWrUIag081.jpg',164),(493,'CghmzVeVykeAXszkAAF_Kdta6z8243.jpg',164),(494,'CghmzVeVylCAHx2TAAG5EhkibNY710.jpg',164),(495,'CghmzFduASeAVHg2AAInLKWy9V8226.jpg',165),(496,'CghmzFduASiAN5HQAAJIWWZcxyA343.jpg',165),(497,'CghmzVduASiAe40fAAGKXW16EDA317.jpg',165),(498,'CghmzVduASmAQdS1AAFMpfIcSyU013.jpg',165),(499,'CghmzFfM3RGAWJIdAADfQ7ViauE692.jpg',166),(500,'wKggnFT6VoKAPG87AAEKpykccts605.jpg',166),(501,'wKggnFT6VoKAZLmhAAFYAmlkXEE886.jpg',166),(502,'wKggnFT6VoOAXZpyAAE0HP1xNw4333.jpg',166),(503,'98e683e2-f71f-430e-8611-b9ffe6a15a72-large.jpg',167),(504,'149bf343-06e0-4e37-ac41-9e97d76556f4-large.jpg',167),(505,'417d59c2-bdfc-4ad7-8caf-8f5a67fde3d0-large.jpg',167),(506,'577ddbd6-d59d-44c3-8f85-deddff601ac4-large.jpg',167),(507,'aea7516f-91a5-4e08-be21-eeb626cd6673-large.jpg',167),(508,'30cb0190-8218-4257-97a8-22c1f1d40d79-large.jpg',168),(509,'92d3ec41-4b5f-4ed1-8e77-0811d02ca349-large.jpg',168),(510,'451a3d48-a4c5-4d5e-b8bc-4a86fb9fd9f9-large.jpg',168),(511,'0805bc06-b98c-44df-86e5-9a67ddce38dd-large.jpg',168),(512,'b89be948-c0d0-487a-9333-3cfa8eaa4ce8-large.jpg',168),(513,'CghmzFdL96aAB7P9AAFQlgJP5BQ667.jpg',169),(514,'CghmzFZpK_KADrY2AAFQVmTOvao137.jpg',169),(515,'CghmzFZpK-6AQiHhAAFzcDJxdiI529.jpg',169),(516,'CghmzVZ6QFqAGfAnAAHkWOFi8Xk516.jpg',169),(517,'CghmzVZpK_CAXnQGAAGIqD-B0xQ954.jpg',169),(518,'6f9388b3-3834-4590-a611-cc654c9194ad-large.jpg',170),(519,'6fc4210a-8ce6-4a56-b0e8-cd5f55afa568-large.jpg',170),(520,'84fe72bd-eb94-4a26-bff2-8de777edadfc-large.jpg',170),(521,'4589e005-8609-45fb-aee8-a846a42f5243-large.jpg',170),(522,'b67e9f7a-558a-4a1c-a8e8-55dfaf2a263c-large.jpg',170),(523,'CghmQ1b2FxGAexmhAAGaptDOzh4815.jpg',171),(524,'CghmQ1b2FxOACAV7AAHnADJ58HY041.jpg',171),(525,'CghmQlb2FxiAesVQAAI_MQOivuQ241.jpg',171),(526,'CghmQlb2FxWAbsz1AAF97br9ZGA363.jpg',171);

/*Table structure for table `lunbo` */

DROP TABLE IF EXISTS `lunbo`;

CREATE TABLE `lunbo` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `byname` varchar(30) DEFAULT NULL,
  `statu` int(11) DEFAULT '0' COMMENT '0.显示 1. 不显示',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;

/*Data for the table `lunbo` */

insert  into `lunbo`(`id`,`name`,`byname`,`statu`) values (96,'684b5d8a-2a33-4555-87b9-2a39b951d4e4.jpg','饼干',0),(98,'2673f2b8-5105-4b49-bba8-65dbb8f719da.jpg','粽子',1),(100,'7303f613-d01d-434e-9e07-8d721396e46e.jpg','零食',0);

/*Table structure for table `message` */

DROP TABLE IF EXISTS `message`;

CREATE TABLE `message` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  `time` varchar(100) DEFAULT NULL,
  `econtent` varchar(2550) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;

/*Data for the table `message` */

insert  into `message`(`id`,`name`,`time`,`econtent`) values (63,'root','2017-05-30 15:44:43','<p>今天天气还好<img src=\"http://img.baidu.com/hi/tsj/t_0002.gif\"/></p>'),(64,'root','2017-06-03 10:05:26','<p>项目完善</p>');

/*Table structure for table `order` */

DROP TABLE IF EXISTS `order`;

CREATE TABLE `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `num` int(3) DEFAULT NULL COMMENT '商品数量',
  `ordmny` double(6,2) DEFAULT NULL COMMENT '商品金额',
  `date` date DEFAULT NULL COMMENT '订单日期',
  `us_id` int(11) DEFAULT NULL COMMENT '用户id',
  `go_id` int(11) DEFAULT NULL COMMENT '商品id',
  `addr_id` int(11) DEFAULT NULL COMMENT '地址编号',
  `statu` int(1) NOT NULL DEFAULT '1' COMMENT '状态1.代付款2.待收货3.已完成',
  PRIMARY KEY (`id`),
  KEY `fk_order_user_info` (`us_id`),
  KEY `fk_order_goods` (`go_id`),
  CONSTRAINT `fk_order_goods` FOREIGN KEY (`go_id`) REFERENCES `goods` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `fk_order_user_info` FOREIGN KEY (`us_id`) REFERENCES `user_info` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

/*Data for the table `order` */

insert  into `order`(`id`,`num`,`ordmny`,`date`,`us_id`,`go_id`,`addr_id`,`statu`) values (35,3,61.59,'2017-06-04',11,64,12,1),(36,3,36.00,'2017-06-03',11,87,12,1),(39,3,300.00,'2017-06-04',NULL,101,NULL,1);

/*Table structure for table `order_info` */

DROP TABLE IF EXISTS `order_info`;

CREATE TABLE `order_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(20) NOT NULL COMMENT '订单流水号',
  `money` double(6,2) DEFAULT NULL COMMENT '商品金额',
  `date` date DEFAULT NULL COMMENT '订单日期',
  `us_id` int(11) DEFAULT NULL COMMENT '用户id',
  `go_id` varchar(50) DEFAULT NULL COMMENT '商品id',
  `addr_id` int(11) DEFAULT NULL COMMENT '地址编号',
  `statu` int(1) NOT NULL DEFAULT '1' COMMENT '状态1.代付款2.待收货3.已完成',
  PRIMARY KEY (`id`),
  KEY `fk_order_user_info` (`us_id`),
  KEY `fk_order_goods` (`go_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

/*Data for the table `order_info` */

insert  into `order_info`(`id`,`number`,`money`,`date`,`us_id`,`go_id`,`addr_id`,`statu`) values (48,'DW201706034262',66.53,'2017-06-03',11,'64,87',17,2),(49,'DW201706042242',107.59,'2017-06-04',11,'64,87',17,1),(51,'DW201706040046',418.00,'2017-06-04',13,'97',8,1);

/*Table structure for table `pack` */

DROP TABLE IF EXISTS `pack`;

CREATE TABLE `pack` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `paname` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `pack` */

insert  into `pack`(`id`,`paname`) values (1,'散装'),(2,'盒装'),(3,'罐装'),(4,'瓶装'),(5,'礼盒装'),(6,'趣味装'),(7,'手抓包'),(8,'小袋装'),(9,'大袋装'),(10,'单粒装'),(11,'单个装'),(12,'中袋装');

/*Table structure for table `source` */

DROP TABLE IF EXISTS `source`;

CREATE TABLE `source` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `soname` varchar(50) DEFAULT '国产',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `source` */

insert  into `source`(`id`,`soname`) values (1,'国产'),(2,'原装进口'),(5,'国外原料国内分装');

/*Table structure for table `user_info` */

DROP TABLE IF EXISTS `user_info`;

CREATE TABLE `user_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(50) NOT NULL COMMENT '用户密码',
  `uname` varchar(50) DEFAULT NULL COMMENT '用户昵称',
  `realname` varchar(5) DEFAULT NULL COMMENT '真实姓名',
  `gender` varchar(2) DEFAULT NULL COMMENT '性别',
  `birthday` date DEFAULT NULL COMMENT '出生日期',
  `phone` varchar(11) DEFAULT NULL,
  `ustime` date NOT NULL COMMENT '注册时间',
  `go_id` int(11) DEFAULT NULL COMMENT '所拥有的商品id',
  `statu` int(1) DEFAULT '1' COMMENT '账号状态  1.活跃 2.冻结',
  PRIMARY KEY (`id`),
  KEY `fk_user_info_goods` (`go_id`),
  CONSTRAINT `fk_user_info_goods` FOREIGN KEY (`go_id`) REFERENCES `goods` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

/*Data for the table `user_info` */

insert  into `user_info`(`id`,`username`,`password`,`uname`,`realname`,`gender`,`birthday`,`phone`,`ustime`,`go_id`,`statu`) values (10,'david','7e5ad122fb435e8ac09d3f286fa343fd','david',NULL,NULL,NULL,NULL,'2017-05-29',NULL,1),(11,'aaaa','247dbb162614ada76b1da6f62c8cf2ad','David','大卫','女','2016-02-01',NULL,'2017-05-29',NULL,1),(12,'lxy0211','6b3a1cf19987eff1eefa61c181393dac','lxy0211',NULL,NULL,NULL,'15890971207','2017-05-29',NULL,1),(13,'aaaaa','e3bf1a3b6b9b1ea70a616692b2f89e88','aaaaa','历次','保密','2017-06-01',NULL,'2017-05-31',NULL,2),(14,'admin','dcf4773102d53acbb149c9ba3de36565','admin',NULL,NULL,NULL,'13044755874','2017-06-03',NULL,1);

/*Table structure for table `userhead` */

DROP TABLE IF EXISTS `userhead`;

CREATE TABLE `userhead` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uhname` varchar(50) DEFAULT NULL,
  `us_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_userheard_user_info` (`us_id`),
  CONSTRAINT `fk_userheard_user_info` FOREIGN KEY (`us_id`) REFERENCES `user_info` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `userhead` */

insert  into `userhead`(`id`,`uhname`,`us_id`) values (1,NULL,NULL);

/*Table structure for table `vip` */

DROP TABLE IF EXISTS `vip`;

CREATE TABLE `vip` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `account` varchar(50) NOT NULL,
  `pass` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `vip` */

insert  into `vip`(`id`,`account`,`pass`) values (1,'root','root'),(2,'admin','admin');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
