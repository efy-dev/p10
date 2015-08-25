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
    <script src="<c:url value="/META-INF/resources/resources/jquery/jquery-1.11.1.min.js"/>"></script>
    <title></title>
</head>
<body>
<div>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr>
            <td>标签序列号</td>
            <td>商品</td>
            <td>防伪验证IP</td>
            <td>验证时间</td>
        </tr>
        <c:forEach items="${requestScope.pageInfo.list}" var="record">
            <tr>
                <td>${record.label.serial}</td>
                <td>${record.product.name}</td>
                <td>${record.IP}</td>
                <td><fmt:formatDate value="${record.createDatetime}" pattern="yyyy-MM-dd HH:mm"/> </td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>
