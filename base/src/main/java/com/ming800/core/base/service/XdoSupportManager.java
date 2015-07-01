package com.ming800.core.base.service;

import com.ming800.core.does.model.Do;
import org.springframework.ui.ModelMap;
import org.springframework.web.multipart.MultipartRequest;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-1-23
 * Time: 上午10:01
 * To change this template use File | Settings | File Templates.
 */
public interface XdoSupportManager {


    void generateTempPageConditions(String url, Map map, String tempIndex, String tempSize) throws Exception;


    ModelMap execute(Do tempDo, ModelMap modelMap, HttpServletRequest request) throws Exception;

    ModelMap executeMultipart(Do tempDo, ModelMap modelMap, HttpServletRequest request, MultipartRequest multipartRequest) throws Exception;

}
