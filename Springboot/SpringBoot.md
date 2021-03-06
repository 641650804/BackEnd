# 关于SpringBoot一些要注意的地方和我遇到的bug军团

1. IDEA中的Terminal相当于该项目所在路径下的cmd命令行窗口，dir用于显示当前目录下的内容。
2. properties文件里面的编码是ASCII码，在网页上显示中文会乱码，此时需要在File->Settings搜索file encoding，勾选transparent native-to-ASCII conversion。
3. 打jar包只能打src目录下的内容，不会管项目根目录下其他目录/文件的内容。
4. SpringBoot如何打jar包？
    (1)在pom.xml中插入spring-boot-maven-plugin
    (2)在右侧Maven Projects里选择项目/LifeCycle/package
    (3)点击右上角绿色运行，在左侧target/maven-status下找到打包成功的可执行jar包 
5. 使用springboot快速向导创建SpringBoot项目的时候test目录下的自动创建的测试文件
导入@Test的包是 org.junit.jupiter.api.Test，需要改成org.junit.Test。(划重点，找了一个半小时的bug)
6. 如何知道哪些自动配置类生效了？可以在全局配置文件中添加debug=true开启springboot的debug模式，让控制台打印自动配置报告，在positive matches下面的就是启用的自动配置类。
7. 在Settings里面的设置只能设置当前项目，对所有项目的设置在Other Settings->Default Settings里。
8. 国际化设置切换页面的中英文使用IE浏览器，且需要在Internet设置中设置语言为美式英语，设置有风险，需要重启重新配置；使用谷歌浏览器时我只能切换成English一种，且在国际化配置文件中写上en_US和en_UN都不能使登录页面的label提示显示成英语。

问题：在Controller里面添加WebMvcConfigurerAdapter，里面的addViewControllers方法未能奏效，在提出/请求的时候，没有跳转到类路径下templates目录下的login.html页面，而是跳转到static/index.html文件。
