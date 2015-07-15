<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/9
  Time: 16:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<table width="95%" align="center" cellpadding="10" cellspacing="0" border="1">
<c:forEach items="${list}" var="project">
  <tr>
    <td>${project.id}</td>
    <td>${project.name}</td>
    <td>${project.createDateTime}</td>
  </tr>
</c:forEach>
</table>
</body>
</html>
