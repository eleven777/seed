package com.first.controller;

import com.first.core.result.Result;
import com.first.core.result.ResultGenerator;
import com.first.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by zhz on 2018/1/30.
 */
@RestController
public class TestController {

    @Autowired
    TestService testService;

    @RequestMapping("/")
    private Result test() {
       return ResultGenerator.genSuccessResult(testService.findAll());
    }
}
