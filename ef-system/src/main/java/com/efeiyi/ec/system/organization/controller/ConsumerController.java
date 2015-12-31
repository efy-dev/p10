package com.efeiyi.ec.system.organization.controller;

import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.dao.hibernate.XdoDaoSupport;
import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Administrator on 2015/12/31.
 */
@Controller
@RequestMapping("/consumer")
public class ConsumerController extends BaseController{

    @Autowired
    private XdoDaoSupport xdoDaoSupport;

    @RequestMapping(value = "/remove.do")
    public void removeConsumer(String id){

        SQLQuery sqlQuery = xdoDaoSupport.getSession().createSQLQuery("update organization_user set status=0 where id='" + id + "'");
        sqlQuery.executeUpdate();
    }

}
