/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50509
Source Host           : 127.0.0.1:3306
Source Database       : world

Target Server Type    : MYSQL
Target Server Version : 50509
File Encoding         : 65001

Date: 2018-06-28 07:29:34
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for ayasecore_questionsystem
-- ----------------------------
DROP TABLE IF EXISTS `ayasecore_questionsystem`;
CREATE TABLE `ayasecore_questionsystem` (
  `text` char(255) DEFAULT NULL,
  `a` char(255) DEFAULT NULL,
  `b` char(255) DEFAULT NULL,
  `c` char(255) DEFAULT NULL,
  `d` char(255) DEFAULT NULL,
  `ok` char(2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ayasecore_questionsystem
-- ----------------------------
INSERT INTO `ayasecore_questionsystem` VALUES ('what is the wow?', 'World of Warcraft', 'World Warcraft', 'Warcraft World', 'Warcraft of World', 'a');
INSERT INTO `ayasecore_questionsystem` VALUES ('Who is the author of this script?', 'ayase', 'trinity', 'mangos', 'ascent', 'a');
