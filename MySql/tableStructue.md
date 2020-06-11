---
title:数据库表
tags:数据库
notebook:文
---

<!--
 * @Author: Lili
 * @Date: 2020-06-09 22:59:23
 * @Description:
 * @LastEditTime: 2020-06-12 00:07:37
-->

# 数据库表

## 模型组给我们提供了两种表

### hotxinguan*\*\*\*.csv

字段：uid,screen_name,**bw_id**,**wd**,topic,content,created_at

```sql
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
```

```sql
-- 注意linux上导入的时候换行符是不一样的，windows用\r\n，linux用\n，否则会漏掉数据

load data infile '/var/lib/mysql-files/hot_xinguan_2019-nCoV.csv'
ignore into table hot character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' 
ignore 1 lines(user_id,user_name,bw_id,wd,tag,bw_text,created_at);
```

### relationship\_\*\*\*.csv

字段：user_id,screen_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at

```sql
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
```

```sql
load data infile '/var/lib/mysql-files/relationship_李兰娟.csv'
ignore into table relationship_ character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' ignore 1 lines(user_id,user_name,bw_id,origin,reposts_count,fs_user_id,fs_screen_name,fs_bw_id,fans_count,fs_fans_count,level,raw_text,created_at);

```

## 数据库表结构

<!-- Version1 分表 0 wd_bwid 检索词与bw_id对应 1 originAndRepo 所有微博的信息 2 relationship bw_id与fs_bw_id对应 -->
<!-- Version2 在表1中增加一个字段prev_bw_id，以便查询 -->
<!-- Version3 今天改了太多了 我都不记得改了什么了 -->

### 表 0:检索词对应表 1bw_id 表

**bw_id** **wd**

```sql
CREATE TABLE `wd_bwid`(
`id` bigint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
`wd` varchar(20) NOT NULL COMMENT '检索词',
`bw_id`  varchar(45) NOT NULL COMMENT '博文id',
PRIMARY KEY (`id`),
UNIQUE KEY `bw_id`(`bw_id`,`wd`)
)CHARSET=utf8mb4;
```

```sql
load data infile '/var/lib/mysql-files/hot_xinguan_2019-nCoV.csv'
ignore into table wd_bwid character set utf8mb4
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\n' 
ignore 1 lines(@dummy,@dummy,bw_id,wd,@dummy,@dummy,@dummy);
```

### 表 1:微博信息表

```sql
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
```

```sql
--导入origin相关信息（同时存在于relationship_和hot中的才会被导入)

insert ignore into originAndRepo(
  bw_id,user_id,screen_name,fans_count,tag,text,created_at,reposts_count,origin,level
  )
  select h.bw_id,h.user_id,h.user_name,r.fans_count,h.tag,h.bw_text,h.created_at,r.reposts_count,r.origin,r.level
  from hot h inner join relationship_ r on r.bw_id=h.bw_id;

update ignore originAndRepo o set o.prev_bw_id=(select r.bw_id from relationship_ r where r.fs_bw_id=o.bw_id and r.bw_id!=Null);
```

```sql
-- 导入在hot但是不在relationship_中的

insert ignore into originAndRepo (bw_id,user_id,screen_name,tag,text,created_at)
select bw_id,user_id,user_name,tag,bw_text,created_at
from hot;

--因为得到的原创微博的level并不是它自己的，而是转发它的那个人的
UPDATE originAndRepo SET `level`='0' WHERE origin='True';

```

```sql
--导入repo相关信息
insert ignore into originAndRepo(
bw_id,user_id,screen_name,fans_count,text,created_at,level,prev_bw_id
)
select fs_bw_id,fs_user_id,fs_screen_name,fs_fans_count,raw_text,created_at,level,bw_id
from relationship_;

update ignore originAndRepo o set o.reposts_count=(select distinct reposts_count from relationship_ b where b.bw_id=o.bw_id);
update ignore originAndRepo o set o.origin=(select distinct origin from relationship_ b where b.bw_id=o.bw_id)

```

TODO: 出现了非连续自增主键 需要解决吗？

```a
   ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8mb4
   mysql> select count(*) from origin;
+----------+
| count(*) |
+----------+
|       64 |
+----------+
1 row in set (0.00 sec)
-->
```

### 表2:转发关系对应表

bw_id fs_bw_id （1 对多）

```sql
CREATE TABLE `relationship` (
`id` bigint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
`fs_bw_id` char(16) NOT NULL default 'Null' COMMENT '转发了这条微博的博文ID',
`bw_id` varchar(45) NOT NULL COMMENT '博文id',
PRIMARY KEY (`id`)
) CHARSET=utf8mb4;
```

```sql
--只有存在于relationship_里面的关系才会被导入
insert into relationship (bw_id,fs_bw_id) select bw_id,fs_bw_id from relationship_ ;

--导入只存在于hot但是不存在于relationship里面的关系

insert ignore into relationship (bw_id,fs_bw_id) select bw_id,prev_bw_id from originAndRepo;

```
