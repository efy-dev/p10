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
<div class="wh">
    <div class="add-null">
        <!--添加购物车成功-->
        <div class="efeiyi-null">
            <div class="cart-null">
                <div class="null-shop">
                    <span class="bg-cart"></span>
                    <p>商&nbsp;品&nbsp;已&nbsp;成&nbsp;功&nbsp;加&nbsp;入&nbsp;购&nbsp;物&nbsp;车！</p>
                    <div class="join">
                        <a href="<c:url value="/cart/view"/> " class="gc-left">去购物车结算</a>
                        <a href="<c:url value="/?redirect=${redirect}"/> " class="gc-right">继续购物</a>
                    </div>
                </div>

            </div>
        </div>
        <!-- //End--添加购物车成功-->
    </div>
</div>
</body>
</html>
