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
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title></title>
</head>
<body>
<hr/>
<div class="am-g">
    <div class="am-u-md-12">
        <h2>订单信息</h2>
        <table class="am-table am-table-bordered">
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">订单号</td>
                <td class="am-u-md-3">${object.serial}</td>
                <td class="am-primary am-u-md-3">交易状态</td>
                <td class="am-u-md-3">
                    <ming800:status name="orderStatus" dataType="purchaseOrder.orderStatus"
                                    checkedValue="${object.orderStatus}" type="normal"/>
                </td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">总计（元）</td>
                <td class="am-u-md-3">${object.total}</td>
                <td class="am-primary am-u-md-3">收货人</td>
                <td class="am-u-md-3">
                    ${object.user.name}
                </td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">下单时间</td>
                <td class="am-u-md-3">
                    <fmt:formatDate value="${object.createDatetime}" type="both" pattern="YYYY-MM-dd HH:mm"/>
                </td>
                <td class="am-primary am-u-md-3">收货地址</td>
                <td class="am-u-md-3">${object.consumerAddress.details}</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<div class="am-g">
    <div class="am-u-md-12">
        <h2>支付信息</h2>
    </div>

    <div class="am-u-md-12">
        <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
            <tr>
                <th class="table-set">支付号</th>
                <th class="table-title">支付记录编号</th>
                <th class="table-title">支付金额(元)</th>
                <th class="table-title">支付方式</th>
                <th class="table-title">支付人</th>
                <th class="table-title">支付时间</th>
            </tr>
            </thead>
            <tbody>

            <c:forEach items="${object.purchaseOrderPaymentList}" var="purchaseOrderPayment">
                <tr>
                    <td class="am-hide-sm-only">
                            ${purchaseOrderPayment.transactionNumber}
                    </td>
                    <td class="am-hide-sm-only">${purchaseOrderPayment.serial}</td>
                    <td class="am-hide-sm-only">
                            ${purchaseOrderPayment.paymentAmount}
                    </td>
                    <td class="am-hide-sm-only">
                        <ming800:status name="payWay" dataType="purchaseOrderPayment.payWay"
                                        checkedValue="${purchaseOrderPayment.payWay}" type="normal"/>
                    </td>
                    <td class="am-hide-sm-only">${purchaseOrderPayment.user.name}</td>
                    <td class="am-hide-sm-only">
                        <fmt:formatDate value="${purchaseOrderPayment.createDateTime}" type="both"
                                        pattern="YYYY-MM-dd HH:mm"/>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<div class="am-g">
    <div class="am-u-md-12">
        <h2>发货记录</h2>
    </div>

    <div class="am-u-md-12">
        <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
            <tr>
                <th class="table-set">时间</th>
                <th class="table-title">地址</th>
                <th class="table-title">处理人</th>

            </tr>
            </thead>
            <tbody>

            <c:forEach items="${object.purchaseOrderDeliveryList}" var="purchaseOrderDelivery">
                <tr>
                    <td class="am-hide-sm-only">
                        <fmt:formatDate value="${purchaseOrderDelivery.createDateTime}" type="both"
                                        pattern="YYYY-MM-dd HH:mm"/>
                    </td>
                    <td class="am-hide-sm-only">
                            ${purchaseOrderDelivery.consumerAddress.details}
                    </td>
                    <td class="am-hide-sm-only">
                            ${purchaseOrderDelivery.consumerAddress.consumer.name}
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<div class="am-g">
    <div class="am-u-md-12">
        <h2>商品清单</h2>
    </div>
    <div class="am-u-md-12">
        <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
            <tr>
                <th class="table-set">图片</th>
                <th class="table-title">商品编号</th>
                <th class="table-title">单价(元)</th>
                <th class="table-title">数量</th>
                <th class="table-title">实付款</th>
            </tr>
            </thead>
            <tbody>

            <c:forEach var="purchaseOrderProduct" items="${object.purchaseOrderProductList}">
                <tr>
                    <td>
                        <img width="30px;"
                             src="http://tenant.efeiyi.com/${purchaseOrderProduct.productModel.product.picture_url}@!tenant-manage-photo"
                             alt="商品图片">
                        <a href="<c:url value="/basic/xm.do?qm=viewPurchaseOrderProduct&view=${view}&id=${purchaseOrderProduct.id}"/>">
                                ${purchaseOrderProduct.productModel.product.name}
                        </a>
                    </td>
                    <td>
                                ${purchaseOrderProduct.productModel.serial}
                    </td>
                    <td>
                            ${purchaseOrderProduct.productModel.price}
                    </td>
                    <td>
                            ${purchaseOrderProduct.purchaseAmount}
                    </td>
                    <td>
                            ${purchaseOrderProduct.purchasePrice}
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<!-- content end -->
<hr/>

</body>
</html>
