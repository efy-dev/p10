<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
            <label name="serial" class="am-u-sm-3 am-form-label">订单号</label>
            <div class="am-u-sm-9">
                <div style="margin-top: 9px;">${object.serial}</div>
                <!--<small>必填项*</small>-->
            </div>
        </div>
        <div class="am-form-group">
        <label name="createDatetime" class="am-u-sm-3 am-form-label">下单时间</label>
        <div class="am-u-sm-9">
            <div style="margin-top: 9px;">
             <fmt:formatDate value="${object.createDatetime}" type="both" pattern="YYYY-MM-dd HH:mm" />
            </div>
            <!-- <small>必填项*</small>-->
        </div>
    </div>
        <div class="am-form-group">
            <label name="createDatetime" class="am-u-sm-3 am-form-label">购买物品</label>
            <div class="am-u-sm-9">
                <div style="margin-top: 9px;">
                <c:forEach items="${object.purchaseOrderProductList}" var="purchaseOrderProduct">
                    <span style="margin-left: 5px;">${purchaseOrderProduct.product.name}</span>
                </c:forEach>
                </div>
                <!-- <small>必填项*</small>-->
            </div>
        </div>
        <div class="am-form-group">
            <label name="userName"  class="am-u-sm-3 am-form-label">收货人</label>
            <div class="am-u-sm-9">
                <div style="margin-top: 9px;">${object.user.name}</div>
                <!-- <small>必填项*</small>-->
            </div>
        </div>
        <div class="am-form-group">
            <label name="payWay"  class="am-u-sm-3 am-form-label">支付方式</label>
            <div class="am-u-sm-9">
                <c:if test="${object.payWay==1}">
                    <div style="margin-top: 9px;">支付宝支付</div>
                </c:if>
                <c:if test="${object.payWay==2}">
                <div style="margin-top: 9px;">微信支付</div>
                </c:if>
                <!-- <small>必填项*</small>-->
            </div>
        </div>
        <div class="am-form-group">
            <label name="userAddress" class="am-u-sm-3 am-form-label">用户地址</label>
            <div class="am-u-sm-9" >
               <div style="margin-top: 9px;">${object.consumerAddress.details}</div>
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
