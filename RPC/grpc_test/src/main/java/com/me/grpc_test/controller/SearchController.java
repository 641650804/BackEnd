package com.me.grpc_test.controller;

import com.me.grpc_test.grpc.QueryRequest;
import com.me.grpc_test.grpc.QueryResponse;
import com.me.grpc_test.grpc.SearchServiceGrpc;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

/**
 * 用于测试客户端的调用
 */
@CrossOrigin("*")
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
