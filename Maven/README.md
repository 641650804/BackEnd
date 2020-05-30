# Maven项目相关处理

==================== updated by Legion003 on 2020-05-29 ===================

#### 1. 报错：Failed to read artifact descriptor for org.apache.commons:commons-pool2 ####
##### 详细描述： #####
idea中点开右侧的maven选项卡，可以看到里面所有的dependencies都带红色波浪线，且左侧相应的libraris位置为空，pom文件的命名空间位置“<project”一处底下有红色波浪线，但pom文件中所写的依赖坐标并没有报红。

鼠标指向“<project”后显示**Failed to read artifact descriptor for org.apache.commons:commons-pool2**

##### 出现原因： #####

不明。

##### 解决方案： #####
打开本地maven的repository仓库，把报错中相应的依赖文件夹删除，然后回到项目文件中刷新maven，maven自动重新下载相应的依赖。同时需要把本来写上去的依赖全部注释掉，刷新maven，再把全部依赖放出来，刷新maven，就可以解决问题。



#### 2. 手动导入依赖(jar)至Maven仓库 ####
##### 详细描述： #####
一些特殊的依赖在pom中找不到坐标（如百度家的mcpack），下载无效，需要手动将依赖添加至maven仓库。
##### 解决方案： #####
打开cmd或者idea的Terminal，输入以下指令：

    mvn install:install-file -Dfile=下载路径\jar包名称.jar -DgroupId=相应的groupid -DartifactId=jar包名称 -Dversion=版本号 -Dpackaging=jar
##### 使用样例： #####

    mvn install:install-file -Dfile=D:\mcpack-1.0.0.9.jar -DgroupId=com.baidu -DartifactId=mcpack -Dversion=1.0.0.9 -Dpackaging=jar
注意：请不要使用含中文的路径！




#### 3. 配置文件的相对路径 ####
(new update on 2020-05-30)
##### 不使用类加载器时： #####
相对路径的根目录是项目根目录（并不是src根目录）。而且好像只有在一部分IDE里可以使用，打包之后运行会找不到……（已证实）
##### 使用类加载器： #####
resource中的文件最终会位于classpath根目录下，使用方式：

    InputStream is = xxx.class.getResourceAsStream("/yyy");  //其中xxx为该java（class）文件的名字，yyy为相应的配置文件
    Properties pro = new Properties();
    pro.load(is);

注意：由于需要项目打包，最好使用流的方式来读取配置文件，应避免使用File类、getResource()方法等，难以定位到配置文件；getResourceAsStream()方法中的路径以 / 开头的话是从classes文件夹根目录开始算的（通常编译后src和resource中的文件都会归并到target/classes之下，所以平时配置文件放resource底下就行）。
