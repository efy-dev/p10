package com.efeiyi.ec.personal.tenant.controller;

import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by AC丶man on 2015/7/17.
 */
@Controller
@RequestMapping("/tenantInfo")
public class TenantInfoController {

    @Autowired
    private BaseManager baseManager;

    /**
     * 传承人资讯
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/tenantInfoList.do")
    public ModelAndView listTenantInfo(HttpServletRequest request,ModelMap model){
        String tenantId=request.getParameter("tenantId");
        //String type=request.getParameter("type");
        StringBuffer queryHql = new StringBuffer();
        queryHql.append("from TenantNews t where t.tenant.id= :tenantId");
        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
       /* if("0".equals(type)) {
            queryHql.append("");
        }else if("1".equals(type)|| "2".equals(type) ||"3".equals(type)){
            queryParamMap.put("type",type);
            queryHql.append(" and t.type =:type ");
        }*/
        queryParamMap.put("tenantId", tenantId);
        List list = baseManager.listObject(queryHql.toString(), queryParamMap);
        model.addAttribute("tenantInfoList",list);
        return new ModelAndView("/tenantInfo/tenantInfoList",model);
    }
}
