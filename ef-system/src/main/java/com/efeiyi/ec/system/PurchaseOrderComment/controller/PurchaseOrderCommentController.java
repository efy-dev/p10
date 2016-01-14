package com.efeiyi.ec.system.PurchaseOrderComment.controller;


import com.efeiyi.ec.purchase.model.*;
import com.efeiyi.ec.system.purchaseOrder.service.PurchaseOrderManager;
import com.efeiyi.ec.system.purchaseOrder.service.SmsCheckManager;
import com.efeiyi.ec.system.util.HTTPParam;
import com.efeiyi.ec.system.util.HTTPSend;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.PConst;
import com.ming800.core.p.service.AutoSerialManager;
import net.sf.json.JSONObject;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Administrator on 2015/6/18.
 */
@Controller
@RequestMapping("/PurchaseOrderComment")
public class PurchaseOrderCommentController extends BaseController {



    @Autowired
    private BaseManager baseManager;



    @RequestMapping("/reply.do")
    @ResponseBody
    public String reply(String reply,HttpServletRequest request){
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm");
        String date = format.format(new Date());
        String [] ids = request.getParameterValues("ids[]");
        try {
            for(int i=0;i<ids.length;i++){
                PurchaseOrderComment purchaseOrderComment =(PurchaseOrderComment) baseManager.getObject(PurchaseOrderComment.class.getName(),ids[i]);
                PurchaseOrderBusinessReply purchaseOrderBusinessReply = new PurchaseOrderBusinessReply();

                purchaseOrderBusinessReply.setReply(reply);
                purchaseOrderBusinessReply.setPurchaseOrderComment(purchaseOrderComment);
                purchaseOrderBusinessReply.setCreateDatetime(format.parse(date));
                baseManager.saveOrUpdate(PurchaseOrderBusinessReply.class.getName(),purchaseOrderBusinessReply);
                purchaseOrderComment.setPurchaseOrderBusinessReply(purchaseOrderBusinessReply);
                baseManager.saveOrUpdate(PurchaseOrderComment.class.getName(),purchaseOrderComment);
            }

        }catch (Exception e){
            e.printStackTrace();
        }

        return date;
    }
}
