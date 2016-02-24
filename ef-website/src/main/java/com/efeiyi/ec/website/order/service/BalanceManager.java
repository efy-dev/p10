package com.efeiyi.ec.website.order.service;

import com.efeiyi.ec.balance.model.BalanceRecord;

/**
 * Created by Administrator on 2016/2/16 0016.
 */
public interface BalanceManager {
    boolean checkBalance(Float banlance);
    BalanceRecord useBalance(Float balance);
}
