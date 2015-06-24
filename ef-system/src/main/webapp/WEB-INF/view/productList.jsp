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
    <title>产品列表</title>
</head>
<body>
  <table <%--class="am-table am-table-bordered am-table-striped am-table-compact"--%>>
    <%--<tr>--%>
    <%--<td>产品id</td>--%>
      <%--<td>产品名称</td>--%>
      <%--<td>图片地址</td>--%>
      <%--<td>分类</td>--%>
      <%--<td>价格</td>--%>
    <%--</tr>--%>

      <%--<c:forEach items="${objectList}" var="product">--%>
    <%--<tr>--%>
        <%--<td>${product.id}</td>--%>
        <%--<td>${product.name}</td>--%>
        <%--<td>${product.picture_url}</td>--%>
        <%--<td>${product.category}</td>--%>
        <%--<td>${product.price}</td>--%>
    <%--</tr>--%>
      <%--</c:forEach>--%>
    <%--<c:forEach items="${objectList}" var="product">--%>
      <%--<tr>--%>
        <%--<td><c:out value="${product.id}"></c:out></td>--%>
        <%--<td><c:out value="${product.name}"></c:out></td>--%>
        <%--<td><c:out value="${product.picture_url}"></c:out></td>--%>
        <%--<td><c:out value="${product.category}"></c:out></td>--%>
        <%--<td><c:out value="${product.price}"></c:out></td>--%>
      <%--</tr>--%>
    <%--</c:forEach>--%>

    <c:forEach items="${objectList}" var="product">

        ${product.name}
    </c:forEach>

  </table>
</body>
</html>
