package com.efeiyi.ec.website.activity.group.controller;
import com.efeiyi.ec.activity.group.model.GroupMember;
import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.activity.group.model.PurchaseOrderGroup;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * Created by Administrator on 2015/10/27.
 */
@Controller
@RequestMapping("/person")
public class PersonController {
    @Autowired
    private BaseManager baseManager;

    /**
     *  我的开团
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/groupBuyStatus.do")
    public String groupBuyStatus(HttpServletRequest request, Model model) throws Exception {
//        XQuery xQuery = new XQuery("listCreateProduct_default",request);
//        List<Object> myCreateProductList = baseManager.listObject(xQuery);
        XQuery xQuery = new XQuery("listJoinGroup_default",request);
        List<Object> myCreateProductList = baseManager.listObject(xQuery);
        if(myCreateProductList!=null&&myCreateProductList.size()>0){
            Iterator<Object> sListIterator = myCreateProductList.iterator();
            while(sListIterator.hasNext()){
                GroupMember groupMember = (GroupMember)sListIterator.next();
                if("0".equals(groupMember.getLevel())==false){
                    sListIterator.remove();
                }
            }
        }
        model.addAttribute("myCreateProductList", myCreateProductList);
        return "/personGroup/myCreateGroup";
    }


    /**
     *  我的参团
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/joinGroupStatus.do")
    public String groupJoinList(HttpServletRequest request, Model model) throws Exception {
        XQuery xQuery = new XQuery("listJoinGroup_default",request);
        List<Object> groupJoinList = baseManager.listObject(xQuery);
        if(groupJoinList!=null&&groupJoinList.size()>0){
            Iterator<Object> sListIterator = groupJoinList.iterator();
            while(sListIterator.hasNext()){
                GroupMember groupMember = (GroupMember)sListIterator.next();
                if("0".equals(groupMember.getLevel())){
                    sListIterator.remove();
                }
            }
        }
        model.addAttribute("groupJoinList", groupJoinList);
        return "/personGroup/myJoinGroup";
    }
    /**
     *  我的红包
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/bonusTotal.do")
    public String groupBonusTotal(HttpServletRequest request, Model model) throws Exception {
        String id = AuthorizationUtil.getMyUser().getId();
        BigUser user = (BigUser) baseManager.getObject(BigUser.class.getName(), id);
        model.addAttribute("user", user);
        return "/personGroup/myBonus";
    }
    /**
     *  退货详情
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/returnGoods.do")
    public String returnGoods(HttpServletRequest request, Model model) throws Exception {
        return "/personGroup/returnGoods";
    }


    /**
     *  个人中心
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/personInfoView.do")
    public String personInfoView(HttpServletRequest request, Model model) throws Exception {
            return "/personGroup/personGroupInfo";
    }
    /**
     *  我的团 level = 0为团长
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/myGroup.do")
    public String getMyGroup(HttpServletRequest request, Model model) throws Exception {
        XQuery xQuery = new XQuery("listJoinGroup_default",request);
        List<Object> groupJoinList = baseManager.listObject(xQuery);
        List<Object> myCreateProductList = new ArrayList<>();
        if(!groupJoinList.isEmpty()){
            Iterator<Object> sListIterator = groupJoinList.iterator();
            while(sListIterator.hasNext()){
                GroupMember groupMember = (GroupMember)sListIterator.next();
                if("0".equals(groupMember.getLevel())){
                    myCreateProductList.add(groupMember);
                    sListIterator.remove();
                }
            }
        }
        model.addAttribute("myCreateProductList", myCreateProductList);
        model.addAttribute("groupJoinList", groupJoinList);
        return "/personGroup/myGroup";
    }

    /**
     *我的订单
     * @param request
     * @return
     * @throws Exception
     */

    @RequestMapping(value = "myPurchaseOrder.do")
    public String myPurchaseOrder(HttpServletRequest request, Model model) throws Exception{
        XQuery xQuery = new XQuery("listPurchaseOrderGroup_default",request);
        XQuery xQuery5 = new XQuery("listPurchaseOrderGroup_default5",request);
        XQuery xQuery7 = new XQuery("listPurchaseOrderGroup_default7",request);
        XQuery xQuery9 = new XQuery("listPurchaseOrderGroup_default9",request);
        List<PurchaseOrderGroup> list = baseManager.listObject(xQuery);
        List<PurchaseOrderGroup> list5 = baseManager.listObject(xQuery5);
        List<PurchaseOrderGroup> list7 = baseManager.listObject(xQuery7);
        List<PurchaseOrderGroup> list9 = baseManager.listObject(xQuery9);
        model.addAttribute("purchaseOrderGroupList",list);
        model.addAttribute("purchaseOrderGroupList5",list5);
        model.addAttribute("purchaseOrderGroupList7",list7);
        model.addAttribute("purchaseOrderGroupList9",list9);
        return "/personGroup/purchaseOrderGroupList";
    }
}
