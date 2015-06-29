package com.ming800.core.does.service;

import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-1-18
 * Time: 下午5:05
 * To change this template use File | Settings | File Templates.
 */
public interface DoHandler {

    ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception;
}
