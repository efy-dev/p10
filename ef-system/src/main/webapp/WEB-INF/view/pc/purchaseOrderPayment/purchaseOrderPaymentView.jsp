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
                <th>支付记录</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">订单号</td>
                <td class="am-u-md-3">${object.purchaseOrder.serial}</td>
                <td class="am-primary am-u-md-3">支付序列号</td>
                <td class="am-u-md-3">${object.serial}</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">支付状态</td>
                <td class="am-u-md-3">
                    <ming800:status name="status" dataType="purchaseOrderPayment.status"
                                    checkedValue="${object.status}"
                                    type="normal"/>
                </td>
                <td class="am-primary am-u-md-3">支付金额</td>
                <td class="am-u-md-3">${object.paymentAmount}</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">支付用户</td>
                <td class="am-u-md-3">${object.user.username}</td>
                <td class="am-primary am-u-md-3">支付时间</td>
                <td class="am-u-md-3"><fmt:formatDate value="${object.createDateTime}" type="both" pattern="yyyy-MM-dd HH:mm"/></td>
            </tr>
            </tbody>
        </table>
    </div>

    <div class="am-g">
        <div class="am-u-md-12">
            <table class="am-table am-table-bordered">
                <thead>
                <tr>
                    <th>订单数据</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td class="am-primary am-u-md-3">订单号</td>
                    <td class="am-u-md-3">${object.purchaseOrder.serial}</td>
                    <td class="am-primary am-u-md-3">支付方式</td>
                    <td class="am-u-md-3">
                        <c:forEach items="${object.purchaseOrder.purchaseOrderPaymentList}" var="purchaseOrderPayment">
                                <span style="margin-left: 10px;">
                                <ming800:status name="payWay" dataType="purchaseOrderPayment.payWay"
                                                checkedValue="${purchaseOrderPayment.payWay}"
                                                type="normal"/>
                                </span>
                        </c:forEach>
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
                    <th>支付用户数据</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td class="am-primary am-u-md-3">用户名</td>
                    <td class="am-u-md-3">${object.user.username}</td>
                    <td class="am-primary am-u-md-3">角色</td>
                    <td class="am-u-md-3">
                        ${object.user.role.name}
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
