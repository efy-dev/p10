package com.efeiyi.ec.system.product.controller;

import com.ming800.core.does.service.DoHandler;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/7/16.
 */
public class ProductHandler implements DoHandler {

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        System.out.println("---------------------handler==========================");
        return modelMap;
    }
}
