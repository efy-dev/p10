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
<script type="text/javascript" src="<c:url value="/script/assets/js/amazeui.js"/>"/>
<link href="/scripts/assets/css/amazeui.css">
<html>
<head>
    <title>产品列表</title>
</head>
<body>
  <table class="am-table am-table-bordered am-table-striped am-table-compact">
    <thead>
      <th>产品名称</th>
      <th>图片地址</th>
      <th>分类</th>
      <th>价格</th>
    </thead>
    <tr>
      <c:forEach items="${listProduct}" var="product">
        <td>product.name</td>
        <td>product.picture_url</td>
        <td>product.category</td>
        <td>product.price</td>
      </c:forEach>
    </tr>
  </table>
</body>
</html>
