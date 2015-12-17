package com.efeiyi.ec.system.zero.company.handler;

import com.ming800.core.does.service.DoHandler;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/12/17.
 * 企业礼品卡分页列表 Handler 导航菜单匹配
 */
public class PurchaseOrderGiftPListHandler implements DoHandler {
    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        String type = request.getParameter("type");
        modelMap.put("type", type);
        return modelMap;
    }
}
