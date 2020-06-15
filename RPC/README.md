# RPC相关

======================= updated by Legion on 2020-06-15 ======================

## Grpc-Protobuf

以下内容是翻阅csdn和学长们的代码得出的其中一种实现方法，不一定最优，请搭配demo一起食用

本文档食用前需要有springboot基础



### 环境准备

idea安装插件Protobuf Support



### 代码分析

#### 一、客户端

（触发端对于grpc来说是客户端）

1. 导入依赖

```xml
    <properties>
        <java.version>1.8</java.version>
        <io.grpc.version>1.23.0</io.grpc.version>
        <os-maven-plugin.version>1.6.2</os-maven-plugin.version>
        <protobuf-maven-plugin.version>0.6.1</protobuf-maven-plugin.version>
        <grpc-starter-version>3.4.1</grpc-starter-version>
    </properties>

    <dependencies>
        <!-- web starter -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>

        <!-- grpc相关 -->
        <dependency>
            <groupId>io.github.lognet</groupId>
            <artifactId>grpc-spring-boot-starter</artifactId>
            <version>${grpc-starter-version}</version>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
            <exclusions>
                <exclusion>
                    <groupId>org.junit.vintage</groupId>
                    <artifactId>junit-vintage-engine</artifactId>
                </exclusion>
            </exclusions>
        </dependency>
    </dependencies>

    <build>
        <!-- grpc需要用到的插件 -->
        <extensions>
            <extension>
                <groupId>kr.motd.maven</groupId>
                <artifactId>os-maven-plugin</artifactId>
                <version>1.4.1.Final</version>
            </extension>
        </extensions>
        <plugins>
            <plugin>
                <groupId>org.xolstice.maven.plugins</groupId>
                <artifactId>protobuf-maven-plugin</artifactId>
                <version>0.5.0</version>
                <configuration>
                    <protocArtifact>com.google.protobuf:protoc:3.0.0:exe:${os.detected.classifier}</protocArtifact>
                    <pluginId>grpc-java</pluginId>
                    <pluginArtifact>io.grpc:protoc-gen-grpc-java:1.0.0:exe:${os.detected.classifier}</pluginArtifact>
                </configuration>
                <executions>
                    <execution>
                        <goals>
                            <goal>compile</goal>
                            <goal>compile-custom</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
<!--            <plugin>-->
<!--                <groupId>org.springframework.boot</groupId>-->
<!--                <artifactId>spring-boot-maven-plugin</artifactId>-->
<!--            </plugin>-->
        </plugins>
    </build>

</project>
```



2. 编写全局配置文件（application.properties），加入以下配置

```properties
# 注意：属性名是自定义的，待会会用配置类导入
# grpc的server ip
app-config.grpc-server-name=localhost
# grpc的port
app-config.grpc-server-port=8280
```



3. 编写.proto文件

在main目录下新建一个proto文件夹（与java文件夹同级），在proto文件夹中编写.proto文件

以下是.proto文件样例

```protobuf
//SearchService.proto
syntax = "proto3";  //proto版本
option java_multiple_files = true;
package com.searchproject.pubmed.grpc;  //注意package结构，结构参考学长的代码

//定义数据
message QueryRequest {
    string query = 1;  //定义该数据中有一个String类型的变量
}

//定义数据
message QueryResponse {
    string response = 1;
}

//调用
service SearchService {  //其中SearchService与文件名一致
	//方法名为searchQuery，传入一个QueryRequest数据，返回一个QueryResponse数据（与上面对应）
    rpc searchQuery(QueryRequest) returns (QueryResponse); 
}
```

**然后双击maven中install，生成target，之后可以在target中的generated-sources里看到proto生成的java类和接口**



4. 编写配置类，导入配置

```java
//GrpcConfig.java
@Configuration  //标明配置类
public class GrpcConfig {
    @Bean  //加入容器
    //提取配置，参数名字和配置文件一致
    ManagedChannel channel(@Value("${app-config.grpc-server-name}") String name,  
                           @Value("${app-config.grpc-server-port}") Integer port){
        return ManagedChannelBuilder.forAddress(name, port)
                .usePlaintext()
                .build();
    }
    
    /**
     * 将proto生成的可用于调用的方法放入容器中，方便调用
     */
    @Bean
    SearchServiceGrpc.SearchServiceBlockingStub searchServiceBlockingStub(ManagedChannel channel){
        return SearchServiceGrpc.newBlockingStub(channel);
    }
}
```



5. 在controller中使用grpc

```java
//SearchController.java
/**
 * 用于测试客户端的调用
 */
@CrossOrigin("*")  //用于跨域
@RestController
public class SearchController {
    //从容器中获取调用grpc的东西
    @Autowired
    SearchServiceGrpc.SearchServiceBlockingStub searchServiceBlockingStub;

    @GetMapping("/search/{keyword}")
    public String testSearch(@PathVariable("keyword") String keyword){
        QueryResponse response = this.searchServiceBlockingStub.searchQuery(QueryRequest.newBuilder().setQuery(keyword).build());
        return response.getResponse();
    }

}
```



#### 二、服务器端

（就是相当于192这种server）

1. 导入依赖

与客户端相同，这里省略



2. 编写全局配置文件

```properties
# grpc server端端口（与客户端传送）
grpc.port=8280
```



3. 编写.proto文件

应与客户端保持一致，此处略



4. 编写service层代码

主要用于控制dao层的方法调用，此处略



5. 编写接收grpc的代码

主要用于接收客户端发过来的信息，以及调用service里的方法

```java
//searchServiceImpl.java
@GRpcService  //表明这是一个用于接收grpc request的类
//注意：要继承SearchServiceGrpc.SearchServiceImplBase，其中SearchService与proto中的组件对应的
public class searchServiceImpl extends SearchServiceGrpc.SearchServiceImplBase  {
    //传入service层组件
    @Autowired
    SearchPubmed searchPubmed;

    @Override
    public void searchQuery(QueryRequest request,
                            StreamObserver<QueryResponse> responseObserver) {
        //获取传入的keyword
        System.out.println(request.getQuery());
        //模拟查询结果
        String result = "protobuf成功啦"+request.getQuery();
        //把结果放入response
        QueryResponse response = QueryResponse.newBuilder().setResponse(result).build();
        //放入response，传回客户端
        responseObserver.onNext(response);
        //表示此次连接结束
        responseObserver.onCompleted();
    }
}
```

