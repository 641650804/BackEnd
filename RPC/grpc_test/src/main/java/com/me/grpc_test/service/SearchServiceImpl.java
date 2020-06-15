package com.me.grpc_test.service;

import com.me.grpc_test.grpc.QueryRequest;
import com.me.grpc_test.grpc.QueryResponse;
import com.me.grpc_test.grpc.SearchServiceGrpc;
import io.grpc.stub.StreamObserver;
import org.lognet.springboot.grpc.GRpcService;

/**
 * 模拟服务端
 */
@GRpcService  //注明这是一个grpc的接收类
public class SearchServiceImpl extends SearchServiceGrpc.SearchServiceImplBase {
    @Override
    public void searchQuery(QueryRequest request, StreamObserver<QueryResponse> responseObserver) {
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
