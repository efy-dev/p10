package com.ming800.core.does.service;

import com.ming800.core.does.model.Do;
import org.springframework.ui.ModelMap;
import org.springframework.web.multipart.MultipartRequest;

import javax.servlet.http.HttpServletRequest;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-1-18
 * Time: 下午5:05
 * To change this template use File | Settings | File Templates.
 */
public interface MultipartHandler {

    ModelMap handleMultipart(Do tempDo, ModelMap modelMap, HttpServletRequest request, MultipartRequest multipartRequest) throws Exception;


}
