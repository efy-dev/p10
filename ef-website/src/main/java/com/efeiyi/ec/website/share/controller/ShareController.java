package com.efeiyi.ec.website.share.controller;

import com.efeiyi.ec.balance.model.BalanceRecord;
import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.purchase.model.Coupon;
import com.efeiyi.ec.purchase.model.CouponBatch;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.rebate.model.Rebate;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.model.WxCalledRecord;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.util.HttpUtil;
import com.ming800.core.util.JsonUtil;
import com.ming800.core.util.StringUtil;
import org.apache.http.HttpRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/1/12.
 */
@Controller
public class ShareController {
    @Autowired
    private BaseManager baseManager;
    @Autowired
    private AutoSerialManager autoSerialManager;
    /**分享页面
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/sharePage/productShare/{orderId}"})
    public String sharePage(@PathVariable String orderId,HttpServletRequest request,Model model) throws Exception{
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(),orderId);
        ProductModel productModel = purchaseOrder.getPurchaseOrderProductList().get(0).getProductModel();
        String userId = purchaseOrder.getUser().getId();
        model.addAttribute("productModel",productModel);
        model.addAttribute("purchaseOrderId",purchaseOrder.getId());
        model.addAttribute("userId",userId);
        model.addAttribute("order",purchaseOrder);
        return "/share/sharePage";
    }


    /**其他人打开页面
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/sharePage/openShare/{purchaseOrderId}"})
    public String openPage(@PathVariable String purchaseOrderId,HttpServletRequest request,Model model) throws Exception{
        String callback = URLEncoder.encode("www2.efeiyi.com/sharePage/saveWXInfo.do?purchaseOrderId="+purchaseOrderId,"UTF-8");
        return "redirect:http://www.efeiyi.com/wx/getUserBaseInfo.do?dataKey=nickname;headimgurl"+"&callback="+callback;
    }
    /**分享后返利
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/sharePage/resultProfits.do"})
    public Boolean sharerProfits(HttpServletRequest request,Model model) throws Exception{
        BalanceRecord balanceRecord = new BalanceRecord();
        String userId = request.getParameter("userId");
        Consumer consumer = (Consumer) baseManager.getObject(Consumer.class.getName(),userId);
        BigDecimal  currentBalance = consumer.getBalance();
        if(currentBalance==null){
            currentBalance = new BigDecimal("0");
        }
        BigDecimal  changeBalance = new BigDecimal("5");
        BigDecimal  resultBalance = currentBalance.add(changeBalance);
        balanceRecord.setCurrentBalance(currentBalance);
        balanceRecord.setChangeBalance(changeBalance);
        balanceRecord.setResultBalance(resultBalance);
        balanceRecord.setType("3");
        balanceRecord.setStatus("2");
        balanceRecord.setKey(balanceRecord.getId());
        balanceRecord.setCreateDateTime(new Date());
        balanceRecord.setConsumer(consumer);
        consumer.setBalance(resultBalance);
        baseManager.saveOrUpdate(Consumer.class.getName(),consumer);
        baseManager.saveOrUpdate(BalanceRecord.class.getName(),balanceRecord);
        return true;
    }
    /**保存朋友圈头像信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/sharePage/saveWXInfo.do")
    public String saveWXInfo(HttpServletRequest request,Model model) throws Exception {
        String purchaseOrderId = request.getParameter("purchaseOrderId");
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(),purchaseOrderId);
        String userId = purchaseOrder.getUser().getId();
        Rebate rebate = new Rebate();
        ProductModel productModel = purchaseOrder.getPurchaseOrderProductList().get(0).getProductModel();
        User sharerUser = (User) baseManager.getObject(User.class.getName(),userId);
        CouponBatch couponBatch = (CouponBatch) baseManager.getObject(CouponBatch.class.getName(),"iilsik60373zsqx4");
        String nickname = URLDecoder.decode(request.getParameter("nickname"),"UTF-8");
        String unionid = URLDecoder.decode(request.getParameter("unionid"),"UTF-8");
        String headImgUrl = URLDecoder.decode(request.getParameter("headimgurl"),"UTF-8");
        String queryHqlRebate = "from " + Rebate.class.getName() + " r where r.unionid ='"+unionid+"' and r.status = 1 ";
        List<Object> rebateList = baseManager.listObject(queryHqlRebate);
        if(rebateList==null||rebateList.size()==0){
        //从rebate表中判断是否领取优惠券
        rebate.setUserId(userId);
        rebate.setUnionid(unionid);
        rebate.setNickname(nickname);
        rebate.setHeadurl(headImgUrl);
        rebate.setCreateDateTime(new Date());
        rebate.setStatus("1");
        baseManager.saveOrUpdate(Rebate.class.getName(),rebate);
        }
        String queryHql = "from " + Rebate.class.getName() + " r where r.userId ='"+userId+"' and r.status = 1 ";
        //取得朋友圈信息
        List<Object> list = baseManager.listObject(queryHql);
        XQuery xQuery = new XQuery("listPurchaseOrder_default13", request);
        xQuery.put("user_id",userId);
        //取用户购物清单
        List<Object> orderList =  baseManager.listObject(xQuery);
        model.addAttribute("productModel",productModel);
        model.addAttribute("orderList",orderList);
        model.addAttribute("couponBatch",couponBatch);
        model.addAttribute("userList",list);
        model.addAttribute("purchaseOrder",purchaseOrder);
        model.addAttribute("sharerUser",sharerUser);
        return "/share/shareProfits";
    }
    @RequestMapping("/getUserInfo.do")
    public ModelAndView getUserInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //用code取accessToken
        String result = HttpUtil.getHttpResponse("https://api.weixin.qq.com/sns/oauth2/access_token?appid=wx7f6aa253b75466dd&secret=04928de13ab23dca159d235ba6dc19ea&code=" + request.getParameter("code") + "&grant_type=authorization_code", null);
        System.out.println(result);
        Map map = JsonUtil.parseJsonStringToMap(result.toString());
        String accessToken = (String) map.get("access_token");
        String openid = (String) map.get("openid");
        System.out.println("acess_token: " + accessToken + "\n" + "openid: " + openid);
        //用accessToken取Info
        result = HttpUtil.getHttpResponse("https://api.weixin.qq.com/sns/userinfo?access_token=" + accessToken + "&openid=" + openid, null);
        System.out.println(result);
        map = JsonUtil.parseJsonStringToMap(result.toString());
        String nickname = (String) map.get("nickname");
        String headimgurl = (String) map.get("headimgurl");
        System.out.println("nickname: " + nickname + "\n" + "headimgurl: " + headimgurl);
        //保存用户
        Consumer consumer = new Consumer();
        consumer.setUnionid((String) map.get("unionid"));
        baseManager.saveOrUpdate(Consumer.class.getName(), consumer);
        WxCalledRecord wxCalledRecord = new WxCalledRecord();
        wxCalledRecord.setConsumerId(consumer.getId());
        wxCalledRecord.setDataKey("wxqaopenid");
        wxCalledRecord.setData(openid);
        wxCalledRecord.setAccessToken((String) map.get("refreshToken"));
        wxCalledRecord.setCreateDatetime(new Date());
        //头像暂放callback
        wxCalledRecord.setCallback(headimgurl);
        //名字暂放请求来源
        wxCalledRecord.setRequestSource(nickname);
        baseManager.saveOrUpdate(WxCalledRecord.class.getName(), wxCalledRecord);

        return new ModelAndView("redirect:.do?openid=" + openid);
    }
}
