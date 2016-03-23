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
                <th>发货记录</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">发货记录编号</td>
                <td class="am-u-md-3">${object.serial}</td>
                <td class="am-primary am-u-md-3">发货状态</td>
                <td class="am-u-md-3">
                    <ming800:status name="status" dataType="purchaseOrderDelivery.status"
                                    checkedValue="${object.status}"
                                    type="normal"/>
                </td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">物流公司</td>
                <td class="am-hide-sm-only">
                    <ming800:status name="logisticsCompany" dataType="purchaseOrderDelivery.logisticsCompany"
                                    checkedValue="${object.logisticsCompany}"
                                    type="normal"/>
                </td>
                <td class="am-primary am-u-md-3">发货时间</td>
                <td class="am-u-md-3"><fmt:formatDate value="${object.createDateTime}" type="both" pattern="yyyy-MM-dd HH:mm"/></td>

            </tr>
            <tr>
                <td class="am-primary am-u-md-3">发货地址</td>
                <td class="am-u-md-3" colspan="3">${object.purchaseOrder.purchaseOrderAddress}</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<div class="am-g">
    <div class="am-u-md-12">
        <table class="am-table am-table-bordered">
            <thead>
            <tr>
                <th>订单</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">订单号</td>
                <td class="am-u-md-3"><a href="<c:url value='/basic/xm.do?qm=viewPurchaseOrder&view=delivery&viewIdentify=orderDelivery&id=${object.purchaseOrder.id}'/>">${object.purchaseOrder.serial}</a></td>
                <td class="am-primary am-u-md-3">支付方式</td>
                <td class="am-u-md-3">
                     <ming800:status name="payWay" dataType="purchaseOrderPaymentDetails.payWay"
                              checkedValue="${object.purchaseOrder.payWay}"
                               type="normal"/>
                </td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">订单总额</td>
                <td class="am-u-md-3"><fmt:formatNumber type="number" value="${object.purchaseOrder.total}" maxFractionDigits="2" minFractionDigits="2"/></td>

                <td class="am-primary am-u-md-3">实付金额</td>
                <td class="am-u-md-3"><fmt:formatNumber type="number" value="${object.purchaseOrder.getRealPayMoney()}" maxFractionDigits="2" minFractionDigits="2"/></td>

            </tr>
            <tr>
                <td class="am-primary am-u-md-3">订单状态</td>
                <td class="am-u-md-3">
                    <ming800:status name="orderStatus" dataType="PurchaseOrder.orderStatus"
                                    checkedValue="${object.purchaseOrder.orderStatus}"
                                    type="normal"/>
                </td>
                <td class="am-primary am-u-md-3">下单人</td>
                <td class="am-hide-sm-only">${object.purchaseOrder.user.username}</td>

            </tr>
            <tr>
                <td class="am-primary am-u-md-3">下单时间</td>
                <td class="am-u-md-3" colspan="3">
                    <fmt:formatDate value="${object.purchaseOrder.createDatetime}" pattern="yyyy-MM-dd HH:mm"/>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<%--<div class="am-g">--%>
    <%--<div class="am-u-md-12">--%>
        <%--<th>商家产品信息</th>--%>
        <%--<jsp:include flush="true"--%>
                     <%--page="/basic/xm.do?qm=listProduct_tenant&conditions=tenant.id:${object.purchaseOrder.tenant.id}"/>--%>
    <%--</div>--%>
<%--</div>--%>
</body>
</html>
