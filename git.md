# git相关的问题

## 如何不clone而下载zip并完成同步

1. 在github下载相应的zip压缩包
2. 解压到本地
3. 在目录下使用`git init`初始化
4. `git remote add origin https://github.com/对应用户名/对应仓库名.git`使用该指令连接到远程仓库
5. `git pull origin master`把远端的东西拉过来，如果报错`fatal: refusing to merge unrelated histories`，那么使用`git pull origin master --allow-unrelated-histories`更新本地仓库
6. 更新好之后做自己想做的修改，按流程add commit push就可以了

好处：如果文件多的话用这个比clone快很多（我是这样）
