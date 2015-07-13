package com.efeiyi.ec.website.test.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.model.XSaveOrUpdate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/7/6.
 */
@Controller
public class TestController {

    @Autowired
    private BaseManager baseManager;


    /*  配置文件样例
        <entity name="PCProduct"
                label="精选作品"
                model="com.efeiyi.ec.product.model.Product">
            <fields>
                <field name="id" label="作品" inputType="text" />
            </fields>
            <does>
                <do name="plistPCProduct"
                    label="作品列表"
                    result="/choiceness" access="$consumer"><!--用户查询-->
                    <query name="default" label="默认" type="auto" orderBy="id:desc">
                        <condition label="作品" name="id" defaultValue="0" operation="ne"/>
                    </query>
                </do>
                <do name="listPCProduct"
                    label="作品列表"
                    result="/choiceness" access="$consumer"><!--用户查询-->
                    <query name="default" label="默认" type="auto" orderBy="id:desc">
                        <condition label="作品" name="id" defaultValue="0" operation="ne"/>
                    </query>
                </do>
                <do name="saveOrUpdatePCProduct">
                    <page>
                        <fields>
                            <field name="status" label="状态" defaultValue="1"
                                   inputType="default"></field>
                        </fields>
                    </page>
                </do>
                <do name="removePCSamplePhoto" lable="假删作品" access="$photographer" result=""></do>
            </does>
        </entity>
     */


    //分页的用法
    @RequestMapping({"/test/pproducts"})
    @ResponseBody
    public List<Object> plistProduct(HttpServletRequest request) throws Exception{
        XQuery xQuery = new XQuery("plistPCProduct_default",request);
        return baseManager.listPageInfo(xQuery).getList();
    }

    //不分页的用法
    @RequestMapping({"/test/products"})
    @ResponseBody
    public List<Object> listProduct(HttpServletRequest request) throws Exception{
        XQuery xQuery = new XQuery("listPCProduct_default",request);
        return baseManager.listObject(xQuery);
    }

    //不分页的用法
    @RequestMapping({"/test/saveOrUpdateproduct"})
    @ResponseBody
    public void saveOrUpdateProduct(HttpServletRequest request) throws Exception{
        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate("saveOrUpdatePCProduct",request);
        baseManager.saveOrUpdate(xSaveOrUpdate);
    }


    @RequestMapping({"/test/jmenutest"})
    public String testJmenu(){
        return "/view/test/jmenuTest";
    }


    @RequestMapping({"/test/saveOrUpdateBigUser"})
    @ResponseBody
    public void saveOrUpdateBigUser(HttpServletRequest request) throws Exception{
        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate("saveOrUpdatePCBigUser",request);
        baseManager.saveOrUpdate(xSaveOrUpdate);
    }


}