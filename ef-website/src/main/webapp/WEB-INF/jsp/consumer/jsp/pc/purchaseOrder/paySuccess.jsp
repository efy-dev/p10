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
                <a href="<c:url value="/order/myEfeiyi/view/${order.id}"/> ">查看订单</a>
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
</script>
</body>
</html>
