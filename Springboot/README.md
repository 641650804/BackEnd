# Springboot相关

##### ===================== updated on 2020-05-30 by Legion ======================

#### 1. 修改spring-boot-starter-parent中管理的版本

进入spring-bootstarter-parent中，再进入spring-boot-dependencies中可以看到springboot管理的各种依赖的版本号。2.1.7版本的mysql是8.x，如果想将其改为5.x可以用以下方式：

> ```xml
> <!-- 用于修改springframework中的mysql版本 -->
> <dependencyManagement>
>     <dependencies>
>         <dependency>
>             <groupId>mysql</groupId>
>             <artifactId>mysql-connector-java</artifactId>
>             <version>5.1.30</version>
>         </dependency>
>     </dependencies>
> </dependencyManagement>
> 
> <dependencies>
>     <!-- 由于更换了mysql版本，需要重新写依赖坐标 -->
>     <dependency>
>         <groupId>mysql</groupId>
>         <artifactId>mysql-connector-java</artifactId>
>     </dependency>
> </dependencies>
> ```