<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 14:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title></title>
</head>
<body>
<table>
  <tr>
    <td>purchaseOrder——id</td>
    <td>serial</td>
  </tr>

  <c:forEach items="${objectList}" var="purchaseOrder">
    <tr>
      <td>${purchaseOrder.id}</td>
      <td>${purchaseOrder.serial}</td>
    </tr>
  </c:forEach>

</table>

</body>
</html>
