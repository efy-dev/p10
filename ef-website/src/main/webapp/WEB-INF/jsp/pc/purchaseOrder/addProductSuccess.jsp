<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/24
  Time: 15:42
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
            <p>添加购物车成功</p>

            <p>
                <a href="<c:url value="/cart/view"/> ">去购物车结算</a>
                <a href="<c:url value="/"/> ">继续购物</a>
            </p>
        </div>

    </div>
</div>
</body>
</html>
