package com.ming800.core.p.service;

import java.io.IOException;

/**
 * Created by Administrator on 2014/11/20.
 */

public interface MessageVerifyManager {

    boolean sendVerificationCode(String cellPhoneNumber, String params) throws IOException;

    boolean sendSaleCode(String cellPhoneNumber, String params) throws IOException;

}
