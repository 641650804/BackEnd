package com.me.grpc_test.config;

import com.me.grpc_test.grpc.SearchServiceGrpc;
import io.grpc.ManagedChannel;
import io.grpc.ManagedChannelBuilder;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class GrpcConfig {
    /**
     * 配置需要连接的server的ip:port
     */
    @Bean
    ManagedChannel channel(@Value("${app-config.grpc-server-name}")String name,
                           @Value("${app-config.grpc-server-port}") Integer port){
        return ManagedChannelBuilder.forAddress(name,port)
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
