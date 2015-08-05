<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/18
  Time: 14:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--<script type="text/javascript" src="<c:url value='/scripts/assets/js/amazeui.js'/>"/>--%>
<link href="/script/assets/css/amazeui.css">
<html>
<head>
    <title>字典列表</title>
</head>
<body>
  <table <%--class="am-table am-table-bordered am-table-striped am-table-compact"--%>>
    <tr>
      <td>字典id</td>
      <td>字典代码</td>
      <td>字典名称</td>
    </tr>
      <c:forEach items="${objectList}" var="wordValue">
    <tr>
        <td>${wordValue.id}</td>
        <td>${wordValue.group}</td>
        <td>${wordValue.value}</td>
    </tr>
      </c:forEach>
    <%--<c:forEach items="${objectList}" var="product">--%>
      <%--<tr>--%>
        <%--<td><c:out value="${product.id}"></c:out></td>--%>
        <%--<td><c:out value="${product.name}"></c:out></td>--%>
        <%--<td><c:out value="${product.picture_url}"></c:out></td>--%>
        <%--<td><c:out value="${product.category}"></c:out></td>--%>
        <%--<td><c:out value="${product.price}"></c:out></td>--%>
      <%--</tr>--%>
    <%--</c:forEach>--%>

    <%--<c:forEach items="${objectList}" var="product">--%>

        <%--${product.name}--%>
    <%--</c:forEach>--%>

  </table>
</body>
</html>
