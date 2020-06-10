<!--
 * @Author: Lili
 * @Date: 2020-06-01 15:29:30
 * @Description: 
 * @LastEditTime: 2020-06-10 03:46:03
-->

# 与Mysql相关的问题

[TOC]

## 向Mysql中导入csv文件

### 导入文件路径问题

由于MySql会默认限制导入文件的目录，所以要先将.csv等文件放入`/var/lib/mysql-files/`下再进行导入。

### 导入语句正确，csv文件不为空，受影响记录却为0

信息如下：

```a
Query OK, 0 rows affected (0.00 sec)
Records: 0  Deleted: 0  Skipped: 0  Warnings: 0
```

请检查文件编码（utf8/gbk等），包括字符集编码以及Windows(CR LF)/Unix(LF)/Macintosh(CR)，此信息使用Notepad++可以在右下角看到。我在把文件从Unix(LF)转变为Window(CR LF)之后成功导入。

```a
Query OK, 240 rows affected (0.17 sec)
Records: 240  Deleted: 0  Skipped: 0  Warnings: 0
```
