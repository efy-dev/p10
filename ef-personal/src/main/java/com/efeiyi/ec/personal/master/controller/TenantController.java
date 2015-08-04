package com.efeiyi.ec.personal.master.controller;

import com.efeiyi.ec.tenant.model.Tenant;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by AC丶man on 2015/6/29.
 */
@Controller
public class TenantController extends BaseMasterController {

    @Autowired
    BaseManager baseManager;

    /**
     * 获取某传承人的详情页
     * @param
     *
     * @return
     */
    @RequestMapping("/home.do")
    public ModelAndView getTenant( HttpServletRequest request  , Model model)throws Exception{
        Tenant tenant = getTenantfromDomain(request);
        if (tenant==null){
            return new ModelAndView("redirect:/index");
        }
        String queryHql = "from MasterWork t where t.master.id = :tenantId and t.status !='0' order by t.sort desc";
        LinkedHashMap<String , Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("tenantId",tenant.getId());
        List list = baseManager.listObject(queryHql,queryParamMap);
        XQuery xQuery = new XQuery("listMasterBanner_default",request);
        xQuery.put("master_id",tenant.getId());
        model.addAttribute("bannerList",baseManager.listObject(xQuery));
        model.addAttribute("tenantWorkList",list);
        model.addAttribute("tenant", tenant);
        model.addAttribute("pageMsg","1");
        return new ModelAndView("/tenant/tenantView");
    }



    @ResponseBody
    @RequestMapping("/getTenant.do")
    public Object getTenant(HttpServletRequest request) throws Exception{
        return getTenantfromDomain(request);
    }


}
