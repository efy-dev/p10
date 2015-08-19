<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/19
  Time: 14:58
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
        <td>productSeriesId</td>
        <td>name</td>
        <td>serial</td>
    </tr>

    <c:forEach items="${objectList}" var="productSeries">
        <tr>
            <td>${productSeries.id}</td>
            <td>${productSeries.name}</td>
            <td>${productSeries.serial}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
