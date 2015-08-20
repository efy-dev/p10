package com.efeiyi.ec.system.purchaseOrder.service.impl;

import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.system.organization.OrganizationConst;
import com.efeiyi.ec.system.organization.dao.UserDao;
import com.efeiyi.ec.system.organization.service.UserManager;
import com.efeiyi.ec.system.purchaseOrder.dao.PurchaseOrderDao;
import com.efeiyi.ec.system.purchaseOrder.service.PurchaseOrderManager;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.taglib.PageEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: 下午5:02
 * To change this template use File | Settings | File Templates.
 */

@Service
@Transactional
public class PurchaseOrderManagerImpl implements PurchaseOrderManager {

    @Autowired
    private PurchaseOrderDao purchaseOrderDao;

    @Override
    public String updateOrderStatus(PurchaseOrder purchaseOrder) {
        return purchaseOrderDao.updateOrderStatus(purchaseOrder);
    }
}
