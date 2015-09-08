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
                <td class="am-u-md-3">${object.serial}</td>

                <td class="am-primary am-u-md-3">订单总额</td>
                <td class="am-u-md-3">${object.total}</td>

            </tr>
            <tr>
                <td class="am-primary am-u-md-3">订单状态</td>
                <td class="am-u-md-3">
                    <ming800:status name="orderStatus" dataType="purchaseOrder.orderStatus"
                                    checkedValue="${object.orderStatus}"
                                    type="normal"/>
                </td>
                <td class="am-primary am-u-md-3">下单时间</td>
                <td class="am-u-md-3">
                    <fmt:formatDate value="${object.createDatetime}" pattern="yyyy:MM:dd hh:mm"/>
                </td>
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
                <th>下单人</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">下单人姓名</td>
                <td class="am-u-md-3">${object.user.name}</td>
                <td class="am-primary am-u-md-3">性别</td>
                <td class="am-u-md-3">
                    <ming800:status name="sex" dataType="consumer.sex" checkedValue="${object.user.sex}" type="normal"/>
                </td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">账户余额</td>
                <td class="am-u-md-3">${object.user.deposit}</td>
                <td class="am-primary am-u-md-3">积分</td>
                <td class="am-u-md-3">${object.user.score}</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
<div class="am-g">
    <div class="am-u-sm-12 am-u-md-6">
        <%--<div class="am-panel-hd"><strong>订单商品列表</strong></div>--%>
            <h4>商品列表</h4>
    </div>
    <div class="am-u-sm-12">
        <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
            <tr>
                <th class="table-title">产品名字</th>
                <th class="table-title">购买个数</th>
                <th class="table-title">产品编号</th>
                <th class="table-title">产品单价</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${object.purchaseOrderProductList}" var="purchaseOrderProduct" varStatus="stat">
                <tr>
                    <td class="am-hide-sm-only"><a href="<c:url value='/basic/xm.do?qm=viewPurchaseOrderProduct&viewIdentify=${viewIdentify}&id=${purchaseOrderProduct.id}'/>">${purchaseOrderProduct.productModel.product.name}</a><img width="20px" src="http://pro.efeiyi.com/${purchaseOrderProduct.productModel.product.picture_url}@!product-model" alt="产品图片"></td>
                    <td class="am-hide-sm-only">${purchaseOrderProduct.purchaseAmount}</td>
                    <td class="am-hide-sm-only">${purchaseOrderProduct.productModel.product.serial}</td>
                    <td class="am-hide-sm-only">${purchaseOrderProduct.productModel.product.price}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<div class="am-g">
    <div class="am-u-sm-12 am-u-md-6">
        <h4>支付记录</h4>
    </div>
    <div class="am-u-sm-12">
        <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
            <tr>
                <th class="table-title">支付方式</th>
                <th class="table-title">支付金额</th>
                <th class="table-title">支付状态</th>
                <th class="table-title">支付者姓名</th>
                <th class="table-title">支付时间</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${object.purchaseOrderPaymentList}" var="purchaseOrderPayment" varStatus="stat">
            <tr>
                <td class="am-hide-sm-only">
                        <ming800:status name="payWay" dataType="purchaseOrderPayment.payWay"
                                        checkedValue="${purchaseOrderPayment.payWay}"
                                        type="normal"/>
                </td>
                <td class="am-hide-sm-only">${purchaseOrderPayment.paymentAmount}</td>
                <td class="am-hide-sm-only">
                    <ming800:status name="status" dataType="purchaseOrderPayment.status"
                                    checkedValue="${purchaseOrderPayment.status}"
                                    type="normal"/>
                </td>
                <td class="am-hide-sm-only">${purchaseOrderPayment.user.name}</td>
                <td class="am-hide-sm-only">
                    <fmt:formatDate value="${purchaseOrderPayment.createDateTime}"
                                    pattern="yyyy-mm-dd"/>
                </td>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<div class="am-g">
    <div class="am-u-sm-12 am-u-md-6">
        <h4>发货记录</h4>
    </div>
    <div class="am-u-sm-12">
        <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
            <tr>
                <th class="table-title">配送地址</th>
                <th class="table-title">配送状态</th>
                <th class="table-title">配送时间</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${object.purchaseOrderDeliveryList}" var="purchaseOrderDelivery" varStatus="stat">
            <tr>
                <td class="am-hide-sm-only">${purchaseOrderDelivery.consumerAddress.details}</td>
                <td class="am-hide-sm-only">
                    <ming800:status name="status" dataType="purchaseOrderDelivery.status"
                                    checkedValue="${purchaseOrderDelivery.status}"
                                    type="normal"/>
                </td>
                <td class="am-hide-sm-only">
                    <fmt:formatDate value="${purchaseOrderDelivery.createDateTime}"
                                    pattern="yyyy-mm-dd"/>
                </td>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
