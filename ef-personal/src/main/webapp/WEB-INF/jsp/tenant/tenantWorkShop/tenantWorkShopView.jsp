<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/3
  Time: 11:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title></title>
</head>
<body>
<form action="" method="post">
  <table>
      <tr>
        <td>${productWorkShop.id}</td>
        <td>${productWorkShop.name}</td>
        <td>${productWorkShop.createDateTime}</td>
      </tr>
    <c:if test="${tenant.id != null }">
    <a href="">ddddd</a>
  </c:if>
  </table>
</form>
</body>
</html>
