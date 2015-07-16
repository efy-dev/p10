<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/2
  Time: 14:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<c:forEach items="${tenantIntroductionList}" var="entity" >
    <tr>
        <td>
            <input type="button" value="查看">
            <input type="hidden" name="tenantId" value="${entity.id}">
        </td>
        <td>${entity.id}</td>
        <td>${entity.name}</td>
    </tr>
</c:forEach>
</body>
</html>
