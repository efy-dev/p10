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
<div class="win-payment ae">
    <span><i class="winicon"></i></span>
    <span>您已成功提交付款</span>
    <div class="login-reg nawlogin-reg win-add">
        <a href="http://i.efeiyi.com/order/myEfeiyi/view/${order.id}" class="btn-login" title="查看订单">查&nbsp;看&nbsp;订&nbsp;单</a>
        <a href="http://mall.efeiyi.com" class="btn-reg">首&nbsp;&nbsp;&nbsp;&nbsp;页</a>
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
        'eventLabel': '移动',
        'eventValue': parseInt(${payAmount * 100}),
        'hitCallback': function () {
        <%--window.location.href = "http://i.efeiyi.com/order/myEfeiyi/view/${order.purchaseOrderPayment.purchaseOrder.id}";--%>
        }
    });
</script>
</body>
</html>
