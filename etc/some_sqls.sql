use safood;
select * from safood.food limit 4,3 ;

select * from food;
select count(*) cnt, maker from food group by maker order by cnt desc limit 1, 10;
select sum(cnt) from (select count(*) cnt, maker from food group by maker order by cnt desc limit 1, 10) temp;

select * from food, (select count(*) cnt, maker from food group by maker order by cnt desc limit 1, 10) temp where food.maker = temp.maker;

# TABLE CREATE DDLs
CREATE TABLE `question` (
  `qid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(10) NOT NULL,
  `title` varchar(45) NOT NULL,
  `wdate` date NOT NULL,
  `content` varchar(300) NOT NULL,
  PRIMARY KEY (`qid`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

CREATE TABLE `question_answer` (
  `aid` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(300) NOT NULL,
  `wdate` date NOT NULL,
  `qaid` int(11) DEFAULT NULL,
  PRIMARY KEY (`aid`),
  KEY `qaid` (`qaid`),
  CONSTRAINT `question_answer_ibfk_1` FOREIGN KEY (`qaid`) REFERENCES `question` (`qid`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8;

CREATE TABLE `wishfood` (
  `wishfoodid` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(20) NOT NULL,
  `food_code` int(11) NOT NULL,
  PRIMARY KEY (`wishfoodid`),
  KEY `fk_wish_food_userid` (`user_id`),
  KEY `fk_wish_food_foodcode` (`food_code`),
  CONSTRAINT `fk_wish_food_foodcode` FOREIGN KEY (`food_code`) REFERENCES `food` (`code`),
  CONSTRAINT `fk_wish_food_userid` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

CREATE TABLE `notice` (
  `nid` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `content` varchar(1000) NOT NULL,
  `ndate` date NOT NULL,
  `count` int(10) NOT NULL DEFAULT '0',
  `img` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

CREATE TABLE `searchlog` (
  `sid` int(10) NOT NULL,
  `sdate` date NOT NULL,
  `keyword` varchar(100) NOT NULL,
  `userid` varchar(30) NOT NULL,
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `searchlog` (`sid`,`sdate`,`keyword`,`userid`) VALUES (1,'2019-05-14','라면','admin');
INSERT INTO `searchlog` (`sid`,`sdate`,`keyword`,`userid`) VALUES (2,'2019-05-14','라면','admin');
INSERT INTO `searchlog` (`sid`,`sdate`,`keyword`,`userid`) VALUES (3,'2019-05-14','라면','admin');
INSERT INTO `searchlog` (`sid`,`sdate`,`keyword`,`userid`) VALUES (4,'2019-05-14','아메리카노','admin');
INSERT INTO `searchlog` (`sid`,`sdate`,`keyword`,`userid`) VALUES (5,'2019-05-14','라면','admin');
INSERT INTO `searchlog` (`sid`,`sdate`,`keyword`,`userid`) VALUES (6,'2019-05-14','김치','admin');
INSERT INTO `searchlog` (`sid`,`sdate`,`keyword`,`userid`) VALUES (7,'2019-05-14','rPfks','admin');
INSERT INTO `searchlog` (`sid`,`sdate`,`keyword`,`userid`) VALUES (8,'2019-05-14','계란','admin');
INSERT INTO `searchlog` (`sid`,`sdate`,`keyword`,`userid`) VALUES (9,'2019-05-14','계란','admin');
INSERT INTO `searchlog` (`sid`,`sdate`,`keyword`,`userid`) VALUES (10,'2019-05-14','안녕','admin');
INSERT INTO `searchlog` (`sid`,`sdate`,`keyword`,`userid`) VALUES (11,'2019-05-14','된장찌개','admin');
INSERT INTO `searchlog` (`sid`,`sdate`,`keyword`,`userid`) VALUES (12,'2019-05-14','라면','admin');
INSERT INTO `searchlog` (`sid`,`sdate`,`keyword`,`userid`) VALUES (13,'2019-05-14','라면qweqweqwezxczxc','admin');
INSERT INTO `searchlog` (`sid`,`sdate`,`keyword`,`userid`) VALUES (14,'2019-05-14','라면qweqweqwezxczxc','admin');
INSERT INTO `searchlog` (`sid`,`sdate`,`keyword`,`userid`) VALUES (15,'2019-05-14','fkaus','admin');
INSERT INTO `searchlog` (`sid`,`sdate`,`keyword`,`userid`) VALUES (16,'2019-05-14','qwe','admin');
INSERT INTO `searchlog` (`sid`,`sdate`,`keyword`,`userid`) VALUES (17,'2019-05-14','asd','admin');
INSERT INTO `searchlog` (`sid`,`sdate`,`keyword`,`userid`) VALUES (18,'2019-05-14','라면','');
INSERT INTO `searchlog` (`sid`,`sdate`,`keyword`,`userid`) VALUES (21,'2019-05-14','라면','');
INSERT INTO `searchlog` (`sid`,`sdate`,`keyword`,`userid`) VALUES (22,'2019-05-14','라면','');
INSERT INTO `searchlog` (`sid`,`sdate`,`keyword`,`userid`) VALUES (23,'2019-05-14','라면','');