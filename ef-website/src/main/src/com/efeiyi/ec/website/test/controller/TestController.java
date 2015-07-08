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


    /*  �����ļ�����
        <entity name="PCProduct"
                label="��ѡ��Ʒ"
                model="com.efeiyi.ec.product.model.Product">
            <fields>
                <field name="id" label="��Ʒ" inputType="text" />
            </fields>
            <does>
                <do name="plistPCProduct"
                    label="��Ʒ�б�"
                    result="/choiceness" access="$consumer"><!--�û���ѯ-->
                    <query name="default" label="Ĭ��" type="auto" orderBy="id:desc">
                        <condition label="��Ʒ" name="id" defaultValue="0" operation="ne"/>
                    </query>
                </do>

                <do name="listPCProduct"
                    label="��Ʒ�б�"
                    result="/choiceness" access="$consumer"><!--�û���ѯ-->
                    <query name="default" label="Ĭ��" type="auto" orderBy="id:desc">
                        <condition label="��Ʒ" name="id" defaultValue="0" operation="ne"/>
                    </query>
                </do>
                <do name="saveOrUpdatePCProduct">
                    <page>
                        <fields>
                            <field name="status" label="״̬" defaultValue="1"
                                   inputType="default"></field>
                        </fields>
                    </page>
                </do>
                <do name="removePCSamplePhoto" lable="��ɾ��Ʒ" access="$photographer" result=""></do>
            </does>
        </entity>
     */


    //��ҳ���÷�
    @RequestMapping({"/test/pproducts"})
    @ResponseBody
    public List<Object> plistProduct(HttpServletRequest request) throws Exception{
        XQuery xQuery = new XQuery("plistPCProduct_default",request);
        return baseManager.listPageInfo(xQuery).getList();
    }

    //����ҳ���÷�
    @RequestMapping({"/test/products"})
    @ResponseBody
    public List<Object> listProduct(HttpServletRequest request) throws Exception{
        XQuery xQuery = new XQuery("listPCProduct_default",request);
        return baseManager.listObject(xQuery);
    }

    //����ҳ���÷�
    @RequestMapping({"/test/saveOrUpdateproduct"})
    @ResponseBody
    public void saveOrUpdateProduct(HttpServletRequest request) throws Exception{
        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate("saveOrUpdatePCProduct",request);
        baseManager.saveOrUpdate(xSaveOrUpdate);
    }

}
