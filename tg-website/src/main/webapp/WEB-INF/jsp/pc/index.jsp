<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/10/22
  Time: 15:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>hello</title>
</head>
<body>
hello
<c:forEach items="${groupProductList}" var="groupProduct">
  ${groupProduct.id}
  <img src="http://pro.efeiyi.com/${groupProduct.product.picture_url}"/>
</c:forEach>

</body>
</html>
