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
  <script src="<c:url value="/scripts/jquery-1.11.1.min.js"/>"></script>
  <title></title>
</head>
<body>
<table>
  <tr>
    <td>产品id</td>
    <td>产品名字</td>
  </tr>

  <c:forEach items="${product}" var="productRecommended">
    <tr>
      <td>${productRecommended.id}</td>
      <td>${productRecommended.name}</td>
    </tr>
  </c:forEach>

</table>

</body>
</html>
