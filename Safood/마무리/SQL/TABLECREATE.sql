CREATE TABLE `allergy` (
  `aid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

CREATE TABLE `food` (
  `code` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `supportpereat` decimal(6,2) DEFAULT NULL,
  `calory` decimal(6,2) DEFAULT NULL,
  `carbo` decimal(6,2) DEFAULT NULL,
  `protein` decimal(6,2) DEFAULT NULL,
  `fat` decimal(6,2) DEFAULT NULL,
  `sugar` decimal(6,2) DEFAULT NULL,
  `natrium` decimal(6,2) DEFAULT NULL,
  `chole` decimal(6,2) DEFAULT NULL,
  `fattyacid` decimal(6,2) DEFAULT NULL,
  `transfat` decimal(6,2) DEFAULT NULL,
  `maker` varchar(45) DEFAULT NULL,
  `material` mediumtext,
  `img` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

CREATE TABLE `food_has_allergy` (
  `faid` int(11) NOT NULL AUTO_INCREMENT,
  `food_code` int(11) NOT NULL,
  `allergy_aid` int(11) NOT NULL,
  PRIMARY KEY (`faid`),
  KEY `fk_allergy_has_food_food1_idx` (`food_code`),
  KEY `fk_allergy_has_food_allergy1_idx` (`allergy_aid`),
  CONSTRAINT `fk_allergy_has_food_allergy1` FOREIGN KEY (`allergy_aid`) REFERENCES `allergy` (`aid`),
  CONSTRAINT `fk_allergy_has_food_food1` FOREIGN KEY (`food_code`) REFERENCES `food` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

CREATE TABLE `foodlog` (
  `foodlogid` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(20) NOT NULL,
  `food_code` int(11) NOT NULL,
  PRIMARY KEY (`foodlogid`),
  KEY `fk_user_has_food_food1_idx` (`food_code`),
  KEY `fk_user_has_food_user_idx` (`user_id`),
  CONSTRAINT `fk_user_has_food_food1` FOREIGN KEY (`food_code`) REFERENCES `food` (`code`),
  CONSTRAINT `fk_user_has_food_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8;

CREATE TABLE `notice` (
  `nid` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `content` varchar(1000) NOT NULL,
  `ndate` date NOT NULL,
  `count` int(10) NOT NULL DEFAULT '0',
  `img` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

CREATE TABLE `question` (
  `qid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(10) NOT NULL,
  `title` varchar(45) NOT NULL,
  `wdate` date NOT NULL,
  `content` varchar(300) NOT NULL,
  PRIMARY KEY (`qid`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

CREATE TABLE `question_answer` (
  `aid` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(300) NOT NULL,
  `wdate` date NOT NULL,
  `qaid` int(11) DEFAULT NULL,
  PRIMARY KEY (`aid`),
  KEY `qaid` (`qaid`),
  CONSTRAINT `question_answer_ibfk_1` FOREIGN KEY (`qaid`) REFERENCES `question` (`qid`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8;

CREATE TABLE `searchlog` (
  `sid` int(10) NOT NULL AUTO_INCREMENT,
  `sdate` date NOT NULL,
  `keyword` varchar(100) DEFAULT NULL,
  `userid` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=275 DEFAULT CHARSET=utf8;

CREATE TABLE `user` (
  `id` varchar(20) NOT NULL,
  `pass` varchar(20) NOT NULL,
  `name` varchar(45) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `user_has_allergy` (
  `uaid` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(20) NOT NULL,
  `allergy_aid` int(11) NOT NULL,
  PRIMARY KEY (`uaid`),
  KEY `fk_user_has_allergy_allergy1_idx` (`allergy_aid`),
  KEY `fk_user_has_allergy_user1_idx` (`user_id`),
  CONSTRAINT `fk_user_has_allergy_allergy1` FOREIGN KEY (`allergy_aid`) REFERENCES `allergy` (`aid`),
  CONSTRAINT `fk_user_has_allergy_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

CREATE TABLE `wishfood` (
  `wishfoodid` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(20) NOT NULL,
  `food_code` int(11) NOT NULL,
  PRIMARY KEY (`wishfoodid`),
  KEY `fk_wish_food_userid` (`user_id`),
  KEY `fk_wish_food_foodcode` (`food_code`),
  CONSTRAINT `fk_wish_food_foodcode` FOREIGN KEY (`food_code`) REFERENCES `food` (`code`),
  CONSTRAINT `fk_wish_food_userid` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8