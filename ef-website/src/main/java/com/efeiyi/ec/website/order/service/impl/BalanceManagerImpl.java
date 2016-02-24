package com.efeiyi.ec.website.order.service.impl;

import com.efeiyi.ec.balance.model.BalanceRecord;
import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.website.base.util.AuthorizationUtil;
import com.efeiyi.ec.website.order.service.BalanceManager;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by Administrator on 2016/2/16 0016.
 * 余额的Manager主要处理相对于余额的一些操作，比如 加余额，减余额 ，查余额，余额记录的操作都在该类中完成
 */
@Service
public class BalanceManagerImpl implements BalanceManager {

    @Autowired
    private BaseManager baseManager;

    @Override
    public boolean checkBalance(Float banlance) {
        String userid = AuthorizationUtil.getMyUser().getId();
        Consumer consumer = (Consumer) baseManager.getObject(Consumer.class.getName(),userid);
        int r = new BigDecimal(banlance).compareTo(consumer.getBalance());
        if(r == -1 || r == 0){
            return true;
        }else {
            return false;
        }
    }

    @Override
    public BalanceRecord useBalance(Float balance) {
        String userId = AuthorizationUtil.getMyUser().getId();
        Consumer consumer = (Consumer) baseManager.getObject(Consumer.class.getName(),userId);
        BigDecimal currentBalance = consumer.getBalance();
        consumer.setBalance(currentBalance.subtract(new BigDecimal(balance)));
        baseManager.saveOrUpdate(Consumer.class.getName(), consumer);

        BalanceRecord balanceRecord = new BalanceRecord();
        balanceRecord.setCreateDateTime(new Date());
        balanceRecord.setChangeBalance(new BigDecimal(balance));
        balanceRecord.setCurrentBalance(currentBalance);
        balanceRecord.setResultBalance(consumer.getBalance().subtract(new BigDecimal(balance)));
        balanceRecord.setConsumer(consumer);
        balanceRecord.setStatus("3");
        balanceRecord.setType("4");
        baseManager.saveOrUpdate(BalanceRecord.class.getName(), balanceRecord);

        return balanceRecord;
    }
}
