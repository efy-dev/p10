<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
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
                <th>订单数据</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">订单号</td>
                <td class="am-u-md-3">${object.serial}</td>
                <td class="am-primary am-u-md-3">支付方式</td>
                <td class="am-u-md-3">${object.payWay}</td>
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
                <th>下单人数据</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">下单人姓名</td>
                <td class="am-u-md-3">${object.user.name}</td>
                <td class="am-primary am-u-md-3">性别</td>
                <td class="am-u-md-3">${object.user.sex}</td>
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
    <div class="am-u-md-12">
        <table class="am-table am-table-bordered">
            <thead>
            <tr>
                <th>订单产品数据</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${object.purchaseOrderProductList}" var="purchaseOrderProduct" varStatus="stat">
                <tr>
                    <td class="am-primary am-u-md-3">产品名字</td>
                    <td class="am-u-md-3">${purchaseOrderProduct.product.name}</td>
                    <td class="am-primary am-u-md-3">购买个数</td>
                    <td class="am-u-md-3">${purchaseOrderProduct.purchaseAmount}</td>
                </tr>
                <tr>
                    <td class="am-primary am-u-md-3">产品编号</td>
                    <td class="am-u-md-3">${purchaseOrderProduct.product.serial}</td>
                    <td class="am-primary am-u-md-3">产品单价</td>
                    <td class="am-u-md-3">${purchaseOrderProduct.product.price}</td>
                </tr>
                <tr>
                    <td class="am-primary am-u-md-3">产品描述</td>
                    <td class="am-u-md-3">${purchaseOrderProduct.product.productDescription.content}</td>
                    <td class="am-primary am-u-md-3">产品图片</td>
                    <td class="am-u-md-3"><img src="${purchaseOrderProduct.product.picture_url}" alt="产品图片"></td>
                </tr>
                <c:if test="${!stat.last}">
                    <tr><td colspan="4"></td></tr>
                </c:if>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<div class="am-g">
    <div class="am-u-md-12">
        <table class="am-table am-table-bordered">
            <thead>
            <tr>
                <th>支付记录</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${object.purchaseOrderPaymentList}" var="purchaseOrderPayment" varStatus="stat">
                <tr>
                    <td class="am-primary am-u-md-3">支付方式</td>
                    <td class="am-u-md-3">${purchaseOrderPayment.payWay}</td>
                    <td class="am-primary am-u-md-3">支付者姓名</td>
                    <td class="am-u-md-3">${purchaseOrderPayment.user.name}</td>
                    <td class="am-primary am-u-md-3">支付时间</td>
                    <%--<td class="am-u-md-3"><fmt:formatDate value="${purchaseOrderPayment.createDateTime}" type="both" pattern="yyyy-MM-dd HH:mm"/></td>--%>
                    <td class="am-u-md-3">${purchaseOrderPayment.createDateTime}</td>
                </tr>
                <c:if test="${!stat.last}">
                    <tr><td colspan="4"></td></tr>
                </c:if>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<div class="am-g">
    <div class="am-u-md-12">
        <table class="am-table am-table-bordered">
            <thead>
            <tr>
                <th>配送记录</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${object.purchaseOrderDeliveryList}" var="purchaseOrderDelivery" varStatus="stat">
                <tr>
                    <td class="am-primary am-u-md-3">配送地址</td>
                    <td class="am-u-md-3">${purchaseOrderDelivery.consumerAddress.details}</td>
                    <td class="am-primary am-u-md-3">配送时间</td>
                    <td class="am-u-md-3">${purchaseOrderDelivery.createDateTime}</td>
                </tr>
                <c:if test="${!stat.last}">
                    <tr><td colspan="4"></td></tr>
                </c:if>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<%--<div class="am-g">--%>
    <%--<div class="am-u-md-12">--%>
        <%--<h2>支付记录</h2>--%>
    <%--</div>--%>

    <%--<div class="am-u-md-12">--%>
        <%--<jsp:include flush="true"--%>
                     <%--page="/basic/xm.do?qm=viewPurchaseOrderPayment&id=${object.id}"/>--%>
    <%--</div>--%>
<%--</div>--%>
</body>
</html>
