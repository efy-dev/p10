<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/13
  Time: 11:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<jsp:include flush="true" page="/getMenu.do?menuId=nav&jmenuName=nav&resultPage=/jmenu/nav&match=${pageContext.request.servletPath} "></jsp:include>
</body>
</html>
