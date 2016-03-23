<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
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
                <th>优惠券信息</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">优惠券编码</td>
                <td class="am-u-md-3">${object.serial}</td>
                <td class="am-primary am-u-md-3">优惠券批次名</td>
                <td class="am-u-md-3">${object.couponBatch.name}</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">关联订单</td>
                <td class="am-u-md-3">
                    <c:choose>
                        <c:when test="${havePurchaseOrder == 'No'}">
                            没有关联订单
                        </c:when>
                        <c:otherwise>
                            <a href="<c:url value='/basic/xm.do?qm=viewPurchaseOrder&id=${purchaseOrder.id}'/>">${purchaseOrder.serial}</a>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td class="am-primary am-u-md-3">订单状态</td>
                <td class="am-u-md-3">
                    <c:choose>
                        <c:when test="${havePurchaseOrder == 'No'}">
                            没有关联订单
                        </c:when>
                        <c:otherwise>
                            <ming800:status name="orderStatus" dataType="PurchaseOrder.orderStatus"
                                            checkedValue="${purchaseOrder.orderStatus}"
                                            type="normal"/>
                        </c:otherwise>
                    </c:choose>

                </td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">订单金额</td>
                <td class="am-u-md-3" colspan="3">

                    <c:choose>
                        <c:when test="${havePurchaseOrder == 'No'}">
                            没有关联订单
                        </c:when>
                        <c:otherwise>
                            ${purchaseOrder.total}
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>

            </tbody>
        </table>
    </div>
</div>
</body>
</html>
