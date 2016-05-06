package com.efeiyi.ec.system.basic.controller;

import com.efeiyi.ec.annotation.HttpServiceModel;
import com.ming800.core.does.model.StatusType;
import com.ming800.core.does.model.StatusTypeItem;
import com.ming800.core.does.service.ModuleManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2016/5/3 0003.
 */
@Controller
public class BaseBannerController {

    @Autowired
    private ModuleManager moduleManager;

    /**
     * 获得轮播图所有平台的配置列表
     *
     * @return
     */
    @RequestMapping({"/banner/platform.do"})
    @ResponseBody
    public List<List<String>> listStatusType() {
        String key = "Banner.group";
        List<StatusType> statusTypeList = moduleManager.listStatusType(key);
        List<List<String>> result = new ArrayList<>();
        for (StatusType statusType : statusTypeList) {
            List<String> statusTypeValue = new ArrayList<>();
            statusTypeValue.add(statusType.getFieldName());
            statusTypeValue.add(statusType.getLabel());
            result.add(statusTypeValue);
        }
        return result;
    }

    /**
     * 获得轮播图对应位置的配置列表
     *
     * @return
     */
    @RequestMapping({"/banner/position.do"})
    @ResponseBody
    public List<List<String>> listStatusTypeItem(HttpServletRequest request) {
        String platformName = request.getParameter("platform");
        String key = "Banner.group." + platformName;
        List<StatusTypeItem> statusTypeItemList = moduleManager.listStatusTypeItem(key);
        List<List<String>> result = new ArrayList<>();
        for (StatusTypeItem statusTypeItem : statusTypeItemList) {
            List<String> statusTypeItemValue = new ArrayList<>();
            statusTypeItemValue.add(statusTypeItem.getValue());
            statusTypeItemValue.add(statusTypeItem.getLabel());
            result.add(statusTypeItemValue);
        }
        return result;
    }

}
