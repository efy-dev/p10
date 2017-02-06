package com.efeiyi.ec.website.order.controller;


import com.efeiyi.ec.purchase.model.PrepaidCard;
import com.efeiyi.ec.purchase.model.PrepaidCardRecord;
import com.efeiyi.ec.website.order.service.PrepaidCardManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;

@Controller
public class PrepaidCardController {

    private PrepaidCardManager prepaidCardManager;

    @Autowired
    public PrepaidCardController(PrepaidCardManager prepaidCardManager) {
        this.prepaidCardManager = prepaidCardManager;
    }

    //@TODO
    @RequestMapping({"/prepaid/check"})
    @ResponseBody
    public BigDecimal checkPrepaidCard(HttpServletRequest request) {
        String id = request.getParameter("id");
        PrepaidCard prepaidCard = prepaidCardManager.getPrepaidCardById(id);
        return prepaidCard.getBalance();
    }


    @RequestMapping({"/prepaidRecord/create"})
    @ResponseBody
    public PrepaidCardRecord createPrepaidRecord(HttpServletRequest request) {
        String code = request.getParameter("code");
        String purchaseOrderId = request.getParameter("purchaseOrderId");

        PrepaidCard prepaidCard = prepaidCardManager.getPrepaidCardByCode(code);
        PrepaidCardRecord prepaidCardRecord = prepaidCardManager.createPrepaidCardRecord(purchaseOrderId, prepaidCard);
        return prepaidCardRecord;
    }


}
