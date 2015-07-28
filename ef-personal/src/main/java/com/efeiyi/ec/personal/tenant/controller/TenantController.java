package com.efeiyi.ec.personal.tenant.controller;

import com.efeiyi.ec.master.model.Master;
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
public class TenantController extends BaseTenantController {

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
        Master master = getTenantfromDomain(request);
        if (master ==null){
            return new ModelAndView("redirect:/index");
        }
        String queryHql = "from MasterWork t where t.master.id = :tenantId";
        LinkedHashMap<String , Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("tenantId", master.getId());
        List list = baseManager.listObject(queryHql,queryParamMap);
        XQuery xQuery = new XQuery("listTenantBanner_default",request);
        xQuery.put("tenant_id", master.getId());
        model.addAttribute("bannerList",baseManager.listObject(xQuery));
        model.addAttribute("tenantWorkList",list);
        model.addAttribute("tenant", master);
        return new ModelAndView("/master/tenantView");
    }



    @ResponseBody
    @RequestMapping("/getTenant.do")
    public Object getTenant(HttpServletRequest request) throws Exception{
        return getTenantfromDomain(request);
    }


}
