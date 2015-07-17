<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title></title>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">订单详情</strong> / <small>Order Details</small></div>
</div>
<hr/>

<div class="am-g">
    <form action="/basic/xm.do" method="post"  class="am-form am-form-horizontal">
        <input type="hidden" name="qm" value="">
        <div class="am-form-group">
            <label name="serial" for="user-name" class="am-u-sm-3 am-form-label">购买物品</label>
            <div class="am-u-sm-9">
                <input type="text" name="serial" id="user-name" placeholder="购买物品" value="${object.serial}" readonly="readonly">
                <!--<small>必填项*</small>-->
            </div>
        </div>
        <div class="am-form-group">
            <label name="createDatetime" for="createDatetime" class="am-u-sm-3 am-form-label">下单时间</label>
            <div class="am-u-sm-9">
                <input type="text" name="createDatetime" id="createDatetime" placeholder="下单时间" value="${object.createDatetime}" readonly="readonly">
               <!-- <small>必填项*</small>-->
            </div>
        </div>
        <div class="am-form-group">
            <label name="userName" for="userName" class="am-u-sm-3 am-form-label">用户姓名</label>
            <div class="am-u-sm-9">
                <input type="text" name="userName" id="userName" placeholder="用户姓名" value="${object.user.name}" readonly="readonly">
                <!-- <small>必填项*</small>-->
            </div>
        </div>
        <div class="am-form-group">
            <label name="payWay" for="payWay" class="am-u-sm-3 am-form-label">支付方式</label>
            <div class="am-u-sm-9">
                <c:if test="${object.payWay==1}">
                    <input type="text" name="payWay" id="payWay" placeholder="支付方式" value="支付宝支付" readonly="readonly">
                </c:if>
                <c:if test="${object.payWay==2}">
                    <input type="text" name="payWay" id="payWay" placeholder="支付方式" value="微信支付" readonly="readonly">
                </c:if>
                <!-- <small>必填项*</small>-->
            </div>
        </div>
        <div class="am-form-group">
            <label name="userAddress" for="userAddress" class="am-u-sm-3 am-form-label">用户地址</label>
            <div class="am-u-sm-9">
                <input type="text" name="userAddress" id="userAddress" placeholder="用户地址" value="${object.consumerAddress.details}" readonly="readonly">
                <!-- <small>必填项*</small>-->
            </div>
        </div>
       <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="button" onclick="window.location.href='/basic/xm.do?qm=plistPurchaseOrder_default'" class="am-btn am-btn-primary" value="返回"/>
            </div>
        </div>
    </form>
</div>
<!-- content end -->
<hr/>

</body>
</html>
