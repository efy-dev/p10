package com.efeiyi.ec.website.shippingAddress.controller;

import com.efeiyi.ec.organization.model.ConsumerAddress;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
    public boolean addAddress(HttpServletRequest request){
        String addressId=request.getParameter("addressId");
        ConsumerAddress consumerAddress = (ConsumerAddress) baseManager.getObject(ConsumerAddress.class.getName(), addressId);
        baseManager.saveOrUpdate(ConsumerAddress.class.getName(),consumerAddress);
        return true;

    }

    /**
     * ɾ���ջ���ַ
     * @param request
     * @return
     */
    @RequestMapping({"/removeAddress"})
    public boolean deleteAddress(HttpServletRequest request){
        String addressId=request.getParameter("addressId");
        baseManager.remove(ConsumerAddress.class.getName(),addressId);
        return true;

    }

}
