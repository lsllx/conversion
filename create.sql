CREATE TABLE activity_recharge_lottery_chest_new_config(
  `id` int(11) NOT NULL,
  `gold_require` int(11) NOT NULL,
  `lottery_num` int(11) NOT NULL DEFAULT 0 COMMENT '宝箱,中的彩票数',
  `items` varchar(256) NOT NULL DEFAULT '[]',
  PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
