package com.efeiyi.ec.website.order.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/7/31.
 */
@Controller
public class ConsumerAddressController {

    @Autowired
    private BaseManager baseManager;

//    @RequestMapping()
//    public List<Object> listConsumerAddress(HttpServletRequest request) throws Exception{
//        XQuery xQuery = new XQuery("listConsumerAddress_default",request);
//        List<Object> objectList = baseManager.listObject(xQuery);
//        return objectList;
//    }
//
//    @RequestMapping()
//    public List<Object> saveOrUpdateConsumerAddress(HttpServletRequest request) throws Exception{
//        XQuery xQuery = new XQuery("listConsumerAddress_default",request);
//        List<Object> objectList = baseManager.listObject(xQuery);
//        return objectList;
//    }


}
