<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title></title>
    <style>
    </style>
</head>
<body>
<div class="am-g" style="margin-top: 30px;">
    <div class="am-u-md-12">

        <table class="am-table am-table-bordered">
            <thead>
            <tr>
                <th>支付记录</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">支付序列号</td>
                <td class="am-u-md-3">${object.serial}</td>
                <td class="am-primary am-u-md-3">订单号</td>
                <td class="am-u-md-3">${object.purchaseOrder.serial}</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">支付状态</td>
                <td class="am-u-md-3">
                    <ming800:status name="status" dataType="purchaseOrderPayment.status"
                                    checkedValue="${object.status}"
                                    type="normal"/>
                </td>
                <td class="am-primary am-u-md-3">支付金额</td>
                <td class="am-u-md-3"><fmt:formatNumber type="number" value="${object.paymentAmount}" maxFractionDigits="2" minFractionDigits="2"/></td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">支付用户</td>
                <td class="am-u-md-3">${object.user.username}</td>
                <td class="am-primary am-u-md-3">支付时间</td>
                <td class="am-u-md-3" colspan="3"><fmt:formatDate value="${object.createDateTime}" type="both"
                                                                  pattern="yyyy-MM-dd HH:mm"/></td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<div class="am-u-sm-12 am-u-md-6">
    <h4>支付记录详情</h4>
</div>
<div class="am-u-sm-12">
    <table class="am-table am-table-striped am-table-hover table-main">
        <thead>
        <tr>
            <th class="table-title">支付方式</th>
            <th class="table-title">支付金额</th>
            <th class="table-title">交易号</th>
            <th class="table-title">优惠券编号</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach items="${object.purchaseOrderPaymentDetailsList}" var="purchaseOrderPaymentDetails" >
            <tr>
                <td class="am-hide-sm-only">
                    <ming800:status name="payWay" dataType="PurchaseOrderPaymentDetails.payWay"
                                    checkedValue="${purchaseOrderPaymentDetails.payWay}"
                                    type="normal"/>
                </td>
                <td class="am-hide-sm-only"><fmt:formatNumber type="number" value="${purchaseOrderPaymentDetails.money}" maxFractionDigits="2" minFractionDigits="2"/></td>
                <td class="am-hide-sm-only">${purchaseOrderPaymentDetails.transactionNumber}</td>
                <td class="am-hide-sm-only">${purchaseOrderPaymentDetails.coupon.serial}</td>
            </tr>
        </c:forEach>
        </tbody>

    </table>
</div>

<div class="am-g">
    <div class="am-u-md-12">
        <table class="am-table am-table-bordered">
            <thead>
            <tr>
                <th>订单信息</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">订单号</td>
                <td class="am-u-md-3"><a href="<c:url value='/basic/xm.do?qm=viewPurchaseOrder&viewIdentify=${viewIdentify}&id=${object.purchaseOrder.id}'/>">${object.purchaseOrder.serial}</a></td>
                <td class="am-primary am-u-md-3">订单总价</td>
                <td class="am-u-md-3"><fmt:formatNumber type="number" value="${object.purchaseOrder.total}" maxFractionDigits="2" minFractionDigits="2"/></td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">实付金额</td>
                <td class="am-u-md-3"><fmt:formatNumber type="number" value="${object.purchaseOrder.getRealPayMoney()}" maxFractionDigits="2" minFractionDigits="2"/></td>
                <td class="am-primary am-u-md-3">下单时间</td>
                <td class="am-u-md-3"><fmt:formatDate value="${object.purchaseOrder.createDatetime}" pattern="yyyy-MM-dd HH:mm"/> </td>
            </tr>

            <tr>
                <td class="am-primary am-u-md-3">收货地址</td>
                <td class="am-u-md-3" colspan="3">${object.purchaseOrder.purchaseOrderAddress}</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
