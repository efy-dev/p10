<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/24
  Time: 16:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录成功页面</title>
</head>
<body>
登录成功~~
${user.id}-----
${user.username}
<form action="">
    <a href="<c:url value="/product/product/plist.do"/>">商品列表</a>
    <a href="<c:url value="/purchaseOrder/listOrder.do"/> ">订单列表</a>
    <a href="<c:url value="/project/listProject.do"/> ">品类列表</a>
</form>

</body>
</html>
