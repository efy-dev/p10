package com.efeiyi.ec.system.purchaseOrderDelivery.controller;

import com.efeiyi.ec.purchase.model.PurchaseOrderDelivery;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.p.service.CommonManager;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.HashMap;

/**
 * Created by Administrator on 2015/9/10.
 */
@Controller
@RequestMapping("/purchaseOrderDelivery")
public class PurchaseOrderDeliveryController extends BaseController {

    @Autowired
    private CommonManager commonManager;

    @Autowired
    @Qualifier("sessionFactory")
    private SessionFactory sessionFactory;

    /**
     * 得到所有的物流公司
     * */
    @RequestMapping("/getLogisticsCompany.do")
    @ResponseBody
    public HashMap getLogisticsCompany() throws Exception {
        return commonManager.getLogisticsCompany();
    }

    /**
     * 修改发货记录的物流公司或者物流单号
     */
    @RequestMapping("/updatePurchaseOrderDelivery.do")
    @ResponseBody
    public void updatePurchaseOrderDelivery(PurchaseOrderDelivery purchaseOrderDelivery) {
        String hql = "update PurchaseOrderDelivery set logisticsCompany=?,serial=? where id=?";
        Query query = this.sessionFactory.getCurrentSession().createQuery(hql)
                .setParameter(0, purchaseOrderDelivery.getLogisticsCompany())
                .setParameter(1, purchaseOrderDelivery.getSerial())
                .setParameter(2, purchaseOrderDelivery.getId());
        query.executeUpdate();
    }

    /**
     * 通过快递100查询相关的物流信息
     */
    @RequestMapping("/logisticsTracking.do")
    @ResponseBody
    public String logisticsTracking(HttpServletRequest request){
        String company = request.getParameter("company");
        String serial = request.getParameter("serial");
        String content = "";
        try
        {
            URL url = new URL("http://www.kuaidi100.com/applyurl?key=f8e96a50d49ef863&com=" + company
                    + "&nu=" + serial);
            URLConnection con = url.openConnection();
            con.setAllowUserInteraction(false);
            InputStream urlStream = url.openStream();
            byte b[] = new byte[10000];
            int numRead = urlStream.read(b);
            content = new String(b, 0, numRead);
            while (numRead != -1)
            {
                numRead = urlStream.read(b);
                if (numRead != -1)
                {
                    // String newContent = new String(b, 0, numRead);
                    String newContent = new String(b, 0, numRead, "UTF-8");
                    content += newContent;
                }
            }
            urlStream.close();
        }
        catch (Exception e)
        {
            e.printStackTrace();
            //log.error("快递查询错误");
        }
        return content;
    }
}

