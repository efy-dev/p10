package com.efeiyi.ec.website.shippingAddress.controller;

import com.efeiyi.ec.organization.model.ConsumerAddress;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.model.XSaveOrUpdate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/8/4.
 */
@Controller
@RequestMapping("/address")
public class ShippingAddressController {

    @Autowired
    private BaseManager baseManager;
    /**
     * ��ѯ���û����е��ջ���ַ
     */
    @RequestMapping({"/list"})
    public String listAddress(HttpServletRequest request,Model model) throws Exception {
        XQuery xQuery = new XQuery("pListAddress_default",request);
        xQuery.addRequestParamToModel(model,request);
        List addressList = baseManager.listPageInfo(xQuery).getList();
        model.addAttribute("addressList",addressList);
        return "/shippingAddress";
    }

    /**
     * ���ӣ��༭�ջ���ַ
     * @param request
     * @return
     */
    @RequestMapping({"/addAddress"})
    @ResponseBody
    public boolean addAddress(HttpServletRequest request)throws Exception{

        XSaveOrUpdate  xSaveOrUpdate =new XSaveOrUpdate("saveOrUpdateAddress",request);
        xSaveOrUpdate.getParamMap().put("consumer_id", AuthorizationUtil.getMyUser().getId());
        baseManager.saveOrUpdate(xSaveOrUpdate);

        return true;

    }

    /**
     * ɾ���ջ���ַ
     * @param request
     * @return
     */
    @RequestMapping({"/removeAddress"})
    @ResponseBody
    public boolean removeAddress(HttpServletRequest request)throws Exception{
        String addressId=request.getParameter("addressId");
        baseManager.remove(ConsumerAddress.class.getName(),addressId);
        return true;

    }

}
