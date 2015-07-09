//package com.efeiyi.ec.system.organization.service.impl;
//
//import com.ming800.core.does.service.QueryHandler;
//import com.ming800.core.does.model.XQuery;
//import com.ming800.core.util.DateUtil;
//
//import java.util.Date;
//
///**
// * Created by IntelliJ IDEA.
// * User: ming
// * Date: 12-10-30
// * Time: 上午10:30
// * To change this template use File | Settings | File Templates.
// */
//
//public class BigUserByBirthDayHandler implements QueryHandler {
//
//    @Override
//    public XQuery handle(XQuery xQuery) throws Exception {
//
//        /*今天，之后  七天*/
//        Date date = DateUtil.addOrSubDays(new Date(), 7, 1);
//        StringBuilder sb = new StringBuilder();
//        sb.append(" and date_format(s.birthDate, '%m-%d') >=").append("'").append(DateUtil.formatDateMonthDay(new Date())).append("'");
//        sb.append(" and date_format(s.birthDate, '%m-%d') <=").append("'").append(DateUtil.formatDateMonthDay(date)).append("'");
//
//
//        StringBuilder xQueryStr = xQuery.getStringBuilder();
//        xQueryStr.insert(xQueryStr.indexOf(" order by"), sb.toString());
//
//        xQuery.setStringBuilder(xQueryStr);
//
//        return xQuery;  //To change body of implemented methods use File | Settings | File Templates.
//    }
//}
