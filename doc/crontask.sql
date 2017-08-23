-- phpMyAdmin SQL Dump
-- version phpStudy 2014
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Aug 23, 2017 at 07:19 AM
-- Server version: 5.5.53
-- PHP Version: 7.0.12

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `crontask`
--

-- --------------------------------------------------------

--
-- Table structure for table `agents`
--

CREATE TABLE IF NOT EXISTS `agents` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `alias` varchar(64) NOT NULL COMMENT '别名',
  `ip` varchar(20) NOT NULL,
  `status` tinyint(5) NOT NULL DEFAULT '0' COMMENT '0 正常 1暂停',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `agents`
--

INSERT INTO `agents` (`id`, `alias`, `ip`, `status`) VALUES
(1, 'Crontab服务', '127.0.0.1', 0);

-- --------------------------------------------------------

--
-- Table structure for table `agent_group`
--

CREATE TABLE IF NOT EXISTS `agent_group` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `gid` int(10) NOT NULL,
  `aid` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `agent_group`
--

INSERT INTO `agent_group` (`id`, `gid`, `aid`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `crongroup`
--

CREATE TABLE IF NOT EXISTS `crongroup` (
  `gid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `gname` varchar(32) NOT NULL,
  `manager` varchar(255) DEFAULT NULL COMMENT '负责人',
  PRIMARY KEY (`gid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `crongroup`
--

INSERT INTO `crongroup` (`gid`, `gname`, `manager`) VALUES
(1, '本机', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `crontab`
--

CREATE TABLE IF NOT EXISTS `crontab` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `gid` int(10) NOT NULL,
  `taskname` varchar(64) NOT NULL,
  `rule` varchar(256) NOT NULL COMMENT '规则 可以是crontab规则也可以是启动的间隔时间',
  `runnumber` tinyint(5) NOT NULL DEFAULT '0' COMMENT '并发任务数 0不限制  其他表示限制的数量',
  `execute` varchar(512) NOT NULL COMMENT '运行命令行',
  `status` tinyint(5) NOT NULL DEFAULT '0' COMMENT ' 0正常 1 暂停',
  `runuser` varchar(32) NOT NULL COMMENT '进程运行时用户',
  `manager` varchar(255) DEFAULT NULL COMMENT '负责人',
  `agents` varchar(1024) DEFAULT NULL,
  `createtime` datetime NOT NULL,
  `updatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `crontab`
--

INSERT INTO `crontab` (`id`, `gid`, `taskname`, `rule`, `runnumber`, `execute`, `status`, `runuser`, `manager`, `agents`, `createtime`, `updatetime`) VALUES
(3097968986801831941, 1, '测试任务', '* * * * *', 0, '/bin/echo &#039;hello swoole-crontab&#039;', 0, 'nobody', 'admin', '1', '2016-10-23 12:45:27', '2017-08-23 06:29:35');

-- --------------------------------------------------------

--
-- Table structure for table `group_user`
--

CREATE TABLE IF NOT EXISTS `group_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=26 ;

--
-- Dumping data for table `group_user`
--

INSERT INTO `group_user` (`id`, `gid`, `uid`) VALUES
(25, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `rbac_group`
--

CREATE TABLE IF NOT EXISTS `rbac_group` (
  `gid` int(11) NOT NULL AUTO_INCREMENT,
  `gname` varchar(32) NOT NULL COMMENT '分组名',
  `status` tinyint(5) NOT NULL COMMENT '状态 0 正常 1不正常',
  `lastupdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`gid`),
  UNIQUE KEY `gname` (`gname`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `rbac_group`
--

INSERT INTO `rbac_group` (`gid`, `gname`, `status`, `lastupdate`) VALUES
(1, '管理员', 0, '2016-10-23 04:37:55');

-- --------------------------------------------------------

--
-- Table structure for table `rbac_node`
--

CREATE TABLE IF NOT EXISTS `rbac_node` (
  `idx` int(11) NOT NULL AUTO_INCREMENT,
  `gid` int(11) NOT NULL COMMENT '分组id',
  `node` varchar(255) NOT NULL,
  PRIMARY KEY (`idx`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `rbac_node`
--

INSERT INTO `rbac_node` (`idx`, `gid`, `node`) VALUES
(1, 1, 'App\\Controller\\Crontab'),
(2, 1, 'App\\Controller\\Auth'),
(3, 1, 'App\\Controller\\User'),
(4, 1, 'App\\Controller\\Crongroup'),
(5, 1, 'App\\Controller\\Runtimetask'),
(6, 1, 'App\\Controller\\Agent'),
(7, 1, 'App\\Controller\\Termlog');

-- --------------------------------------------------------

--
-- Table structure for table `rbac_user`
--

CREATE TABLE IF NOT EXISTS `rbac_user` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `password` varchar(128) NOT NULL,
  `nickname` varchar(32) NOT NULL,
  `lastlogin` datetime DEFAULT NULL,
  `lastip` varchar(20) DEFAULT NULL,
  `blocking` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否禁用 0 未禁用1禁用',
  `createtime` datetime NOT NULL,
  `lastupdate` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `rbac_user`
--

INSERT INTO `rbac_user` (`id`, `username`, `password`, `nickname`, `lastlogin`, `lastip`, `blocking`, `createtime`, `lastupdate`) VALUES
(1, 'admin', 'dd94709528bb1c83d08f3088d4043f4742891f4f', 'Admin管理员', '2016-10-23 12:51:22', '192.168.244.2', 0, '2016-09-18 22:13:40', '2016-10-23 12:51:27');

-- --------------------------------------------------------

--
-- Table structure for table `rbac_user_group`
--

CREATE TABLE IF NOT EXISTS `rbac_user_group` (
  `idx` int(11) NOT NULL AUTO_INCREMENT,
  `userid` bigint(20) NOT NULL,
  `gid` int(11) NOT NULL,
  PRIMARY KEY (`idx`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `rbac_user_group`
--

INSERT INTO `rbac_user_group` (`idx`, `userid`, `gid`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `term_logs`
--

CREATE TABLE IF NOT EXISTS `term_logs` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `taskid` bigint(20) NOT NULL,
  `runid` bigint(20) NOT NULL,
  `explain` varchar(64) NOT NULL,
  `msg` longtext,
  `createtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `taskid` (`taskid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
