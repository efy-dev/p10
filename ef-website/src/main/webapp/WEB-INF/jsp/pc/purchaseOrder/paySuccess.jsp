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
            <p>您已成功付款<span> ￥${order.total}</span></p>

            <p>
                <a href="<c:url value="/cart/view"/> ">返回购物车</a>
                <a href="<c:url value="/"/> ">首页</a>
            </p>
        </div>

    </div>
</div>
</body>
</html>
