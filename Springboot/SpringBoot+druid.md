在springboot+druid中遇到的问题：
1.在网站上下载SpringBoot项目的方法默认不导入yaml的jar包，所以如果全局配置文件用application.yml的话需要根据提示手动导包，导包后需要把.yml改为.yaml才能被识别为springboot的全局配置文件。
2.druid登录页面点击signin控制台显示空指针异常，设置构造方法返回的DataSource是javax.sql.DataSource，且允许访问ip地址要设置为127.0.0.1才不会报localhost的错。
3.在application.yaml中配置创建数据表的sql文件的位置时，schema可指定多个位置的文件，-classpath:和文件所在位置之间不能有空格，否则会报错。