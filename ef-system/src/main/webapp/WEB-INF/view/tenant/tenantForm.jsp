<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
  <form action="/basic/xm.do?qm=saveOrUpdateTenant&id=${object.id}" method="post">
    <input type="hidden" value="${object.id}"name=id" id="id">
    姓名：<input type="text" name="name" id="name" value="${object.name}">
    <input type="submit" value="保存">
  </form>

</body>
</html>
