-- 脚本用于建表和导入

use weibo;
drop table if EXISTS hot;
drop table if EXISTS relationship_;
drop table if EXISTS wd_bwid;
drop table if EXISTS originAndRepo;
drop table if EXISTS relationship;
CREATE TABLE `hot` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `bw_id` varchar(45) NOT NULL COMMENT '博文id',
  `user_id` varchar(45) NOT NULL COMMENT '用户id',
  `user_name` varchar(45) NOT NULL COMMENT '用户名 screen_name',
  `wd` varchar(20) NOT NULL COMMENT '检索词',
  `tag` varchar(45) DEFAULT NULL COMMENT '话题 topic',
  `bw_text` text NOT NULL COMMENT '博文内容 content',
  `created_at` char(16) NOT NULL COMMENT '转发时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `bw_id` (`bw_id`,`wd`)
) CHARSET=utf8mb4;
CREATE TABLE `relationship_` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `bw_id` varchar(45) NOT NULL COMMENT '博文id',
  `user_id` varchar(45) NOT NULL COMMENT '用户id',
  `user_name` varchar(45) NOT NULL COMMENT '用户名 screen_name',
  `origin` char(5) NOT NULL COMMENT '是否原创',
  `fans_count` char(16) NOT NULL COMMENT '被转发的人的粉丝数量',
  `reposts_count` char(10) NOT NULL COMMENT '转发次数',
  `fs_user_id` varchar(45) NOT NULL COMMENT '这条博文的用户ID',
  `fs_screen_name` varchar(64) NOT NULL COMMENT '这条微博的用户名字',
  `fs_bw_id` char(16) NOT NULL COMMENT '这条微博的博文ID',
  `fs_fans_count` char(16) NOT NULL COMMENT '这条博文的用户的粉丝数量',
  `level` char(16) NOT NULL COMMENT '第几次转发',
  `raw_text` text COMMENT '转发���带的文字',
  `created_at` char(16) NOT NULL COMMENT '转发时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fs_bw_id` (`fs_bw_id`,`bw_id`,`origin`)
) CHARSET=utf8mb4;

-- 注意linux上导入的时候换行符是不一样的，windows用\r\n，linux用\n，否则会漏掉数据

load data infile '/var/lib/mysql-files/hot_xinguan_2019-nCoV.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_COVID-19.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_保护穿山甲.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_曾光.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_防控新型冠状病毒肺炎.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_湖北通报疫情防控最新进展.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_火神山.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_聚焦新型冠状病毒肺炎.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_抗体.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_科普一下.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_雷神山.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_李兰娟.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_李文亮.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_临床营养.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_日本开始大规模调查感染后携带抗体比例.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_上海加油.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_世界单日新增13.6万例新冠肺炎.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_双黄连可抑制新型冠状病毒.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_双黄连口服液.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_停课不停学.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_武汉加油.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_新冠.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_新冠肺炎治疗性抗体已进入临床试验.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_新型冠状病毒.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_新型冠状病毒肺炎.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_新型冠状病毒肺炎最新情况.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_新型冠状病毒来源是野生动物.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_新型冠状病毒怕酒精不耐高温.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_疫情防控.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_印度一邦新冠肺炎确诊超中国.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_早安.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_战疫.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_张伯礼.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_张文宏.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_张文宏曾称最怕印度非洲疫情大流行.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_张文宏称防控目标是没有第二波疫情.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_中超7月11日开赛.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_钟南山.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_足协再次提交开赛申请.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/hot_xinguan_最美逆行者.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_2019-nCoV.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_COVID-19.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_保护穿山甲.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_曾光.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_防控新型冠状病毒肺炎.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_湖北通报疫情防控最新进展.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_火神山.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_聚焦新型冠状病毒肺炎.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_抗体.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_科普一下.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_雷神山.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_李兰娟.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_李文亮.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_临床营养.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_日本开始大规模调查感染后携带抗体比例.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_上海加油.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_世界单日新增13.6万例新冠肺炎.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_双黄连可抑制新型冠状病毒.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_双黄连口服液.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_停课不停学.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_武汉加油.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_新冠.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_新冠肺炎治疗性抗体已进入临床试验.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_新型冠状病毒.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_新型冠状病毒肺炎.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_新型冠状病毒肺炎最新情况.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_新型冠状病毒来源是野生动物.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_新型冠状病毒怕酒精不耐高温.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_疫情防控.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_印度一邦新冠肺炎确诊超中国.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_早安.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_战疫.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_张伯礼.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_张文宏.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_张文宏曾称最怕印度非洲疫情大流行.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_张文宏称防控目标是没有第二波疫情.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_中超7月11日开赛.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_钟南山.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_足协再次提交开赛申请.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

load data infile '/var/lib/mysql-files/relationship_最美逆行者.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);



CREATE TABLE `wd_bwid`(
`id` bigint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
`wd` varchar(20) NOT NULL COMMENT '检索词',
`bw_id`  varchar(45) NOT NULL COMMENT '博文id',
PRIMARY KEY (`id`),
UNIQUE KEY `bw_id`(`bw_id`,`wd`)
)CHARSET=utf8mb4;

load data infile '/var/lib/mysql-files/hot_xinguan_2019-nCoV.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_COVID-19.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_保护穿山甲.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_曾光.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_防控新型冠状病毒肺炎.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_湖北通报疫情防控最新进展.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_火神山.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_聚焦新型冠状病毒肺炎.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_抗体.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_科普一下.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_雷神山.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_李兰娟.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_李文亮.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_临床营养.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_日本开始大规模调查感染后携带抗体比例.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_上海加油.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_世界单日新增13.6万例新冠肺炎.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_双黄连可抑制新型冠状病毒.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_双黄连口服液.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_停课不停学.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_武汉加油.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_新冠.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_新冠肺炎治疗性抗体已进入临床试验.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_新型冠状病毒.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_新型冠状病毒肺炎.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_新型冠状病毒肺炎最新情况.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_新型冠状病毒来源是野生动物.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_新型冠状病毒怕酒精不耐高温.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_疫情防控.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_印度一邦新冠肺炎确诊超中国.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_早安.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_战疫.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_张伯礼.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_张文宏.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_张文宏曾称最怕印度非洲疫情大流行.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_张文宏称防控目标是没有第二波疫情.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_中超7月11日开赛.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_钟南山.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_足协再次提交开赛申请.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);

load data infile '/var/lib/mysql-files/hot_xinguan_最美逆行者.cs'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);





CREATE TABLE `originAndRepo` (
  `id` bigint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `user_id` varchar(45) NOT NULL COMMENT '这条博文的用户ID',
  `screen_name` varchar(64) NOT NULL COMMENT '这条微博的用户名字',
  `bw_id` char(16) NOT NULL COMMENT '这条微博的博文ID',
  `fans_count` char(16) NOT NULL COMMENT '这条博文的用户的粉丝数量',
  `level` char(16) NOT NULL COMMENT '第几次转发',
  `text` text COMMENT 'raw_text or bw_text',
  `tag` varchar(45) DEFAULT NULL COMMENT '话题 topic',
  `created_at` char(16) NOT NULL COMMENT '转发时间or创造时间',
  `reposts_count` char(10) NOT NULL COMMENT '转发次数',
  `origin` char(5) NOT NULL COMMENT '是否原创',
  `prev_bw_id` char(16) NOT NULL default 'Null' COMMENT '其上一层微博or没有上一层微博',
  PRIMARY KEY (`id`),
  UNIQUE KEY `bw_id` (`bw_id`)
) CHARSET=utf8mb4;



insert ignore into originAndRepo(
  bw_id,user_id,screen_name,fans_count,tag,text,created_at,reposts_count,origin,level
  )
  select h.bw_id,h.user_id,h.user_name,r.fans_count,h.tag,h.bw_text,h.created_at,r.reposts_count,r.origin,r.level
  from hot h inner join relationship_ r on r.bw_id=h.bw_id;

update ignore originAndRepo o set o.prev_bw_id=(select r.bw_id from relationship_ r where r.fs_bw_id=o.bw_id and r.bw_id!=Null);

insert ignore into originAndRepo (bw_id,user_id,screen_name,tag,text,created_at)
select bw_id,user_id,user_name,tag,bw_text,created_at
from hot;

insert ignore into originAndRepo(
bw_id,user_id,screen_name,fans_count,text,created_at,level,prev_bw_id
)
select fs_bw_id,fs_user_id,fs_screen_name,fs_fans_count,raw_text,created_at,level,bw_id
from relationship_;

update ignore originAndRepo o set o.reposts_count=(select distinct reposts_count from relationship_ b where b.bw_id=o.bw_id);
update ignore originAndRepo o set o.origin=(select distinct origin from relationship_ b where b.bw_id=o.bw_id)

UPDATE originAndRepo SET `level`='0' WHERE origin='True';

CREATE TABLE `relationship` (
`id` bigint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
`fs_bw_id` char(16) NOT NULL default 'Null' COMMENT '转发了这条微博的博文ID',
`bw_id` varchar(45) NOT NULL COMMENT '博文id',
PRIMARY KEY (`id`)
) CHARSET=utf8mb4;

insert into relationship (bw_id,fs_bw_id) select bw_id,fs_bw_id from relationship_ ;

insert ignore into relationship (bw_id,fs_bw_id) select bw_id,prev_bw_id from originAndRepo;