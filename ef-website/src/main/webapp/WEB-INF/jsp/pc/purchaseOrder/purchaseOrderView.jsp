<%--
  Created by IntelliJ IDEA.
  User: Jia Yankun
  Date: 2015/7/9
  Time: 17:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<form action="" method="post">
  <table border="1">
    <tr>
      <td>${order.id}</td>
      <td>${order.serial}</td>
      <td>${order.createDatetime}</td>
      <td>${order.payWay}</td>
      <td>${order.user.id}</td>
      <td>${order.consumerAddress.id}</td>
    </tr>
  </table>
</form>
</body>
</html>
