package com.efeiyi.ec.personal.tenant.controller;

import com.efeiyi.ec.tenant.model.TenantNews;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
     * 传承人资讯列表
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/tenantInfoList.do")
    public String listTenantInfo(HttpServletRequest request,Model model) throws Exception {

//       if("0".equals(type)) {
//            queryHql.append("");
//        }else if("1".equals(type)|| "2".equals(type) ||"3".equals(type)){
//            queryParamMap.put("type",type);
//            queryHql.append(" and t.type =:type ");
//        }
        XQuery xQuery = new XQuery("plistTenantInfo_default",request);
        xQuery.addRequestParamToModel(model,request);
        List tenantInfoList = baseManager.listPageInfo(xQuery).getList();
        model.addAttribute("tenantInfoList",tenantInfoList);

       return "/tenantInfo/tenantInfoList";
    }

    /**
     * 获取传承人资讯
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/getTenantInfo.do")
    public  String getTenantInfo(HttpServletRequest request,Model model){
        String  tenantNewsId = request.getParameter("tenantNewsId");
        TenantNews tenantNews = (TenantNews) baseManager.getObject(TenantNews.class.getName(),tenantNewsId);
        model.addAttribute("teanatNews",tenantNews);
        return "";
    }
}
