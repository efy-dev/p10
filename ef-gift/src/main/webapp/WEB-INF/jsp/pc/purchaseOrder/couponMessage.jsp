<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/10/15
  Time: 11:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<table>
  <tr>
    <td>用户id</td>
    <td>优惠券批次id</td>
  </tr>
  <c:forEach items="${list}" var="coupon">
    <tr>
      <td>
          ${coupon.consumer.id}
      </td>
      <td>
          ${coupon.couponBatch.id}
      </td>
    </tr>
  </c:forEach>
</table>
<br>
<br>
<h1>共计添加优惠券 ${list.size()}个</h1>
</body>
</html>
