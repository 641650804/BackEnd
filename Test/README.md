# 测试相关

## 1. controller测试中的模拟请求

主要使用的是MockMvc：

```java
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.skyscreamer.jsonassert.JSONAssert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import com.weibo.weibo.util.loadJsonFile;
import java.io.File;

@Slf4j
@SpringBootTest()
public class WeiboControllerTest {
	
    // 声明一个MockMvc
    private MockMvc mockMvc;

    // web项目上下文（这个具体的用处还没有完全了解到）
    @Autowired
    protected WebApplicationContext wac;
    
    // 在静态文件中读取正确的结果
    @Value("classpath:static/testFiles/getWeibo01.json")
    private Resource testWeibo01;
    @Value("classpath:static/testFiles/getRelationship01.json")
    private Resource testRelationship01;

    // 在进行每个Test方法钱需要执行的方法
    @BeforeEach
    public void setup(){
        log.info("测试开始...");
        mockMvc = MockMvcBuilders.webAppContextSetup(wac).build();
    }

    @Test
    public void query() throws Exception{
        // 使用mockmvc来模拟请求并接收结果
        MvcResult mvcResult = null;
        mvcResult = mockMvc.perform(MockMvcRequestBuilders.get("/getWeibo/新冠/1")
                .contentType(MediaType.APPLICATION_JSON_UTF8))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andDo(MockMvcResultHandlers.print()).andReturn();
        // 提取结果中的字符串
        String result = mvcResult.getResponse().getContentAsString();
        // 测试希望匹配的答案（暂时不知道答案是什么就先放着，先保证代码跑通）
        File file = testWeibo01.getFile();
        String answer = loadJsonFile.parseJson(file);
        // 由于json生成字符串每次同级的顺序都不一样，因此需要用这个JSONAssert，需要导入特定依赖
        JSONAssert.assertEquals(answer, result, false);
    }
}
```



## 2. 判断json串是否与目标相等

由于json每次返回的时候同级的字段顺序不太一样，因此直接使用Assert.Equals对比json字符串就很难完全对得上，这个时候可以使用**JSONAssert**

首先引入依赖：

```xml
<dependency>
    <groupId>org.skyscreamer</groupId>
    <artifactId>jsonassert</artifactId>
    <version>1.5.0</version>
</dependency>
```

然后在测试方法中使用：

```java
JSONAssert.assertEquals(expectedStr, actualStr, false);
// 其中expectedStr为测试中的正确结果，actualStr为实际结果
// false指的是不严格的对比，即同级的字段顺序可以不用一一对上，如果使用true则与普通的Assert类似，不仅字段内容要对的上，同级字段的顺序也要对的上
```



## 3. 如何在主机上跑测试

在pom中使用相应的插件，并将skipTests的值调整为false：

```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-surefire-plugin</artifactId>
    <version>2.22.2</version>
    <configuration>
        <!-- 这里一定要使用false，不要跳过测试 -->
        <skipTests>false</skipTests>
    </configuration>
</plugin>
```

在主机上使用指令：

```
mvn test -Dtest=需要测试的类名
mvn test -Dtest=需要测试的类名#对应的方法
```

## JMockit requires a Java 6+ VM

报错：

```java
    java.lang.ExceptionInInitializerError
	at com.weibo.weibo.service.SearchServiceImplTest.searchQueryOnlyMysql(SearchServiceImplTest.java:42)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
    ......
Caused by: java.lang.IllegalStateException: JMockit requires a Java 6+ VM
	at mockit.internal.startup.AgentInitialization.loadAgentFromLocalJarFile(AgentInitialization.java:25)
	at mockit.internal.startup.Startup.verifyInitialization(Startup.java:172)
	at mockit.Invocations.<clinit>(Invocations.java:26)
	... 64 more

	at mockit.internal.startup.AgentInitialization.loadAgentFromLocalJarFile(AgentInitialization.java:25)
```

解决：由`JMockit requires a Java 6+ VM`可知是JDK版本问题，查看`mockit.internal.startup.AgentInitialization.loadAgentFromLocalJarFile`：

```java
	    static boolean loadAgentFromLocalJarFile() {
        if (!Utilities.JAVA6 && !Utilities.JAVA7 && !Utilities.JAVA8) {
            throw new IllegalStateException("JMockit requires a Java 6+ VM");
        } else {
            String jarFilePath = discoverPathToJarFile();
            return (new AgentLoader(jarFilePath)).loadAgent();
        }
    }
```

只有JDK678是可以用的。
