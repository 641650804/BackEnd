<!--
 * @Author: Lili
 * @Date: 2020-06-01 15:29:30
 * @Description: 
 * @LastEditTime: 2020-06-01 15:51:31
-->

# 与Mysql相关的问题

[TOC]

## 向Mysql中导入文件

由于MySql会默认限制导入文件的目录，所以要先将.csv等文件放入`/var/lib/mysql-files/`下再进行导入。
