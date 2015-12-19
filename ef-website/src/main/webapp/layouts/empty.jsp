<%@ page import="com.ming800.core.util.HttpUtil" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/12/18 0018
  Time: 10:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title><sitemesh:write property='title'/></title>
    <%
        if (HttpUtil.isPhone(request)) {
    %>
    <%@include file="mobileMainHeader.jsp" %>
    <%
    } else {
    %>
    <%@include file="pcMainHeader.jsp" %>
    <%
        }
    %>
    <sitemesh:write property='head'/>
</head>
<body>
<div style="text-align: center">
    <sitemesh:write property='body'/>
</div>
</body>
</html>
