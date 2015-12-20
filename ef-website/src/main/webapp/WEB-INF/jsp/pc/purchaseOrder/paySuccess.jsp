<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/24
  Time: 10:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <link href="<c:url value="/scripts/css/myorder.css"/>" type="text/css " rel="stylesheet">
</head>
<body>
<div class="wr wh">
    <div class="success">
        <div class="success-shop">
            <p>您已成功提交付款</p>

            <p>
                <a href="http://i.efeiyi.com/order/myEfeiyi/view/${order.id}">查看订单</a>
                <a href="<c:url value="/"/> ">首页</a>
            </p>
        </div>

    </div>
</div>
<script>
    <%--showChooseConfirm("提示","是否支付成功？",function(){--%>
    <%--window.location.href = "<c:url value="/order/myEfeiyi/view/${order.id}"/>"--%>
    <%--},function(){--%>
    <%--window.location.href = "<c:url value="/order/myEfeiyi/view/${order.id}"/>"--%>
    <%--})--%>
    <c:set var="payAmount" value="0" scope="page" />
    <c:forEach items="${order.purchaseOrderPaymentList}" var="payment">
    <c:set var="payAmount" value="${payAmount = payment.paymentAmount + payAmount}" scope="page"/>
    </c:forEach>
    //加入GA追踪
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
            m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
    ga('create', 'UA-70772829-1', 'auto');
    ga('send', 'event', {
        'eventCategory': '支付成功',
        'eventAction': '支付宝',
        'eventLabel': 'PC',
        'eventValue': ${payAmount},
        'hitCallback': function () {
            <%--window.location.href = "http://i.efeiyi.com/order/myEfeiyi/view/${order.purchaseOrderPayment.purchaseOrder.id}";--%>
        }
    });
</script>
</body>
</html>
