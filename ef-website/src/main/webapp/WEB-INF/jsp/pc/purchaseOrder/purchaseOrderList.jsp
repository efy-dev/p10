<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Jia Yankun
  Date: 2015/7/9
  Time: 16:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title></title>
  <script type="text/javascript" src="<c:url value='/scripts/jquery-1.11.1.min.js'/>"></script>
  <script type="text/javascript" >
    function orderView(o){
      var orderId = $(o).next().val();
      window.location.href="/order.xml/getOrder.do?id="+orderId;
    }
  </script>
</head>
<body>
  <table border="1">
    <tr>
      <th>id</th>
      <th>serial</th>
      <th>create_datetime</th>
      <th>payWay</th>
      <th>user_id</th>
      <th>user_address_id</th>
      <th>详细信息</th>
    </tr>
    <c:forEach items="${list}" var="order">
      <tr>
        <td>${order.id}</td>
        <td>${order.serial}</td>
        <td>${order.createDatetime}</td>
        <td>${order.payWay}</td>
        <td>${order.user.id}</td>
        <td>${order.consumerAddress.id}</td>
        <td>
          <input type="button" value="查看" onclick="orderView(this);">
          <input type="hidden" value="${order.id}">
        </td>
      </tr>
    </c:forEach>
  </table>
</body>
</html>
