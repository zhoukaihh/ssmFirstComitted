/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : sshdemo

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2018-08-15 08:56:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_dept`
-- ----------------------------
DROP TABLE IF EXISTS `t_dept`;
CREATE TABLE `t_dept` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(100) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `no` varchar(20) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKgy98oheen3yx1l9qmdrn7nri1` (`parent_id`),
  CONSTRAINT `FKgy98oheen3yx1l9qmdrn7nri1` FOREIGN KEY (`parent_id`) REFERENCES `t_dept` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_dept
-- ----------------------------

-- ----------------------------
-- Table structure for `t_dictionary`
-- ----------------------------
DROP TABLE IF EXISTS `t_dictionary`;
CREATE TABLE `t_dictionary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `value` varchar(30) DEFAULT NULL,
  `params` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_dictionary
-- ----------------------------
INSERT INTO `t_dictionary` VALUES ('1', null, '男', 'gender', '1', '123');
INSERT INTO `t_dictionary` VALUES ('2', null, '女', 'gender', '2', null);

-- ----------------------------
-- Table structure for `t_menu`
-- ----------------------------
DROP TABLE IF EXISTS `t_menu`;
CREATE TABLE `t_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `icon` varchar(50) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `no` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4paxqyebl0scq6ur9osr0f56k` (`parent_id`),
  CONSTRAINT `FK4paxqyebl0scq6ur9osr0f56k` FOREIGN KEY (`parent_id`) REFERENCES `t_menu` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_menu
-- ----------------------------
INSERT INTO `t_menu` VALUES ('1', 'fa-gears', '系统管理', null, null, '00');
INSERT INTO `t_menu` VALUES ('2', 'fa-user', '用户', '/user', '1', '0001');
INSERT INTO `t_menu` VALUES ('3', 'fa-users', '角色', '/role', '1', '0010');
INSERT INTO `t_menu` VALUES ('4', 'fa-user', '菜单', '/menu', '1', '0020');
INSERT INTO `t_menu` VALUES ('5', 'fa-sitemap', '部门管理', null, null, '10');
INSERT INTO `t_menu` VALUES ('6', 'fa-sitemap', '部门', '/dept', '5', '1001');
INSERT INTO `t_menu` VALUES ('13', 'fa-bookmark-o', '数据字典', '/dictionary', '1', '0030');
INSERT INTO `t_menu` VALUES ('14', 'fa-male', '职务', '/position', '5', '1010');
INSERT INTO `t_menu` VALUES ('15', 'fa-male', '人员', '/staff', '5', '1020');

-- ----------------------------
-- Table structure for `t_position`
-- ----------------------------
DROP TABLE IF EXISTS `t_position`;
CREATE TABLE `t_position` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(100) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `dept_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKavwt9egaeq6ec6rs733w6vb` (`dept_id`),
  CONSTRAINT `FKavwt9egaeq6ec6rs733w6vb` FOREIGN KEY (`dept_id`) REFERENCES `t_dept` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_position
-- ----------------------------

-- ----------------------------
-- Table structure for `t_role`
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_bkpm7njy2ort1yoiddc7jg8gj` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES ('1', 'admin', null);
INSERT INTO `t_role` VALUES ('5', 'manager', 'manager');

-- ----------------------------
-- Table structure for `t_role_menu`
-- ----------------------------
DROP TABLE IF EXISTS `t_role_menu`;
CREATE TABLE `t_role_menu` (
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  KEY `FKhayg4ib6v7h1wyeyxhq6xlddq` (`menu_id`),
  KEY `FKsonb0rbt2u99hbrqqvv3r0wse` (`role_id`),
  CONSTRAINT `FKhayg4ib6v7h1wyeyxhq6xlddq` FOREIGN KEY (`menu_id`) REFERENCES `t_menu` (`id`),
  CONSTRAINT `FKsonb0rbt2u99hbrqqvv3r0wse` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role_menu
-- ----------------------------
INSERT INTO `t_role_menu` VALUES ('5', '5');
INSERT INTO `t_role_menu` VALUES ('5', '6');
INSERT INTO `t_role_menu` VALUES ('5', '14');
INSERT INTO `t_role_menu` VALUES ('5', '15');

-- ----------------------------
-- Table structure for `t_staff`
-- ----------------------------
DROP TABLE IF EXISTS `t_staff`;
CREATE TABLE `t_staff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `birthday` date DEFAULT NULL,
  `gender` varchar(5) DEFAULT NULL,
  `headImage` varchar(255) DEFAULT NULL,
  `mobile` varchar(30) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKlbxihux3m3cnci1cj4mja6t2o` (`user_id`),
  CONSTRAINT `FKlbxihux3m3cnci1cj4mja6t2o` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_staff
-- ----------------------------

-- ----------------------------
-- Table structure for `t_staff_position`
-- ----------------------------
DROP TABLE IF EXISTS `t_staff_position`;
CREATE TABLE `t_staff_position` (
  `staff_id` int(11) NOT NULL,
  `position_id` int(11) NOT NULL,
  KEY `FK6jcly7la529gm89vu3krlxyiv` (`position_id`),
  KEY `FKaft8e6aibf1pxe12gskguudq9` (`staff_id`),
  CONSTRAINT `FK6jcly7la529gm89vu3krlxyiv` FOREIGN KEY (`position_id`) REFERENCES `t_position` (`id`),
  CONSTRAINT `FKaft8e6aibf1pxe12gskguudq9` FOREIGN KEY (`staff_id`) REFERENCES `t_staff` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_staff_position
-- ----------------------------

-- ----------------------------
-- Table structure for `t_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loginName` varchar(20) NOT NULL,
  `name` varchar(20) NOT NULL,
  `password` varchar(50) NOT NULL,
  `createTime` datetime DEFAULT NULL,
  `gender` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_bmngciqbcrw3yqdcfdwh8ysu7` (`loginName`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', 'admin', 'admin', '2cfd4560539f887a5e420412b370b361', '2018-08-01 09:07:03', '1');
INSERT INTO `t_user` VALUES ('14', 'manager', 'manager', 'b09007d46d54f6bb4166f7d582a3f5d9', '2018-11-11 11:01:00', null);

-- ----------------------------
-- Table structure for `t_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `t_user_role`;
CREATE TABLE `t_user_role` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  KEY `FKa9c8iiy6ut0gnx491fqx4pxam` (`role_id`),
  KEY `FKq5un6x7ecoef5w1n39cop66kl` (`user_id`),
  CONSTRAINT `FKa9c8iiy6ut0gnx491fqx4pxam` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`id`),
  CONSTRAINT `FKq5un6x7ecoef5w1n39cop66kl` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user_role
-- ----------------------------
INSERT INTO `t_user_role` VALUES ('1', '1');
INSERT INTO `t_user_role` VALUES ('14', '5');
