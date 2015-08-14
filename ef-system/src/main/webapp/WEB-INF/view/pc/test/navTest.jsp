<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<c:set var="match" value="${requestScope['javax.servlet.forward.servlet_path']}"/>${pageContext.request.queryString}
<jsp:include flush="true" page="/getMenu.do?jmenuId=nav&jnodeId=nav&resultPage=/jmenu/nav&match=${match} "></jsp:include>
</body>
</html>
