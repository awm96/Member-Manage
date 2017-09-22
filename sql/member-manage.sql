/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50626
Source Host           : localhost:3306
Source Database       : member-manage

Target Server Type    : MYSQL
Target Server Version : 50626
File Encoding         : 65001

Date: 2017-09-22 19:23:40
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL COMMENT '0:普通管理员，1:超级管理员',
  `create_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` bigint(20) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updater_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_admin_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', '李国庆', '3da541559918a808c2402bba5012f6c60b27661c', '1', '2017-09-20 11:45:27', '1', '2017-09-20 11:45:30', '1');

-- ----------------------------
-- Table structure for bill
-- ----------------------------
DROP TABLE IF EXISTS `bill`;
CREATE TABLE `bill` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `master_id` bigint(20) NOT NULL,
  `member_id` bigint(20) NOT NULL,
  `trans_type` tinyint(4) NOT NULL COMMENT '0:储值, 1:储值充正, 2:消费, 3:消费充正, 4:积分, 5:积分充正',
  `amount` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_bill_member_id` (`member_id`),
  KEY `idx_bill_create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bill
-- ----------------------------
INSERT INTO `bill` VALUES ('1', '1', '1', '1', '100', '2017-09-20 11:44:31', '1');
INSERT INTO `bill` VALUES ('2', '1', '1', '2', '100', '2017-09-21 09:23:46', '1');
INSERT INTO `bill` VALUES ('24', '24', '1', '3', '100', '2017-09-21 09:56:25', '1');
INSERT INTO `bill` VALUES ('25', '24', '1', '5', '100', '2017-09-21 09:56:27', '1');

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `id_card_no` varchar(20) DEFAULT NULL,
  `mobile` varchar(15) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `sex` tinyint(4) DEFAULT NULL COMMENT '0:女, 1:男',
  `birthday` date DEFAULT NULL,
  `level` tinyint(4) DEFAULT NULL COMMENT '0:无, 1:银牌会员, 2:金牌会员, 3:钻石会员',
  `stored_amount` int(11) DEFAULT NULL,
  `consume_amount` int(11) DEFAULT NULL,
  `integral_amount` int(11) DEFAULT NULL,
  `last_trans_time` datetime DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `updater_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_member_id_card_no` (`id_card_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES ('1', 'lgq', '2222', '18601149097', '3da541559918a808c2402bba5012f6c60b27661c', '1', '1984-10-01', '1', '0', '0', '0', null, '2017-09-19 19:09:52', '1', '2017-09-19 19:09:58', '1');
