<!--
 * @Author: Lili
 * @Date: 2020-06-04 16:39:00
 * @Description: 
 * @LastEditTime: 2020-06-04 16:39:02
-->

# MyBatis相关

## 非法反射报错

虽然能得到结果，但是有Warning，具体如下：

```a
WARNING: An illegal reflective access operation has occurred
WARNING: Illegal reflective access by org.apache.ibatis.reflection.Reflector (file:.../org/mybatis/mybatis/3.3.0/mybatis-3.3.0.jar) to method java.lang.Class.checkPackageAccess(java.lang.SecurityManager,java.lang.ClassLoader,boolean)
WARNING: Please consider reporting this to the maintainers of org.apache.ibatis.reflection.Reflector
WARNING: Use --illegal-access=warn to enable warnings of further illegal reflective access operations
WARNING: All illegal access operations will be denied in a future release
```

这是一个版本问题，换用更高的MyBatis版本或降低JDK版本（但是为什么要降低呢）可以解决。

将MyBatis版本由3.3.0变为3.5.3之后这个问题就消失了。
