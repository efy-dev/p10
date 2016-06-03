<!DocType html>
<%@ page import="com.ming800.core.util.HttpUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title><sitemesh:write property='title'/></title>
    <%
        if(HttpUtil.isPhone(request)){
    %>
    <%@include file="mobileStyle.jsp"%>
    <%
    }else{
    %>
    <%@include file="pcStyle.jsp"%>
    <%
        }
    %>
    <sitemesh:write property='head'/>
</head>
<body>
    <%
        if(HttpUtil.isPhone(request)){
    %>
    <%@include file="mobileHeader.jsp"%>
    <%
        }else{
    %>
    <%@include file="pcHeader.jsp"%>
    <%
        }
    %>
    <sitemesh:write property='body'/>
    <%
        if(HttpUtil.isPhone(request)){
    %>
    <%@include file="mobileFooter.jsp"%>
    <%
    }else{
    %>
    <%@include file="pcFooter.jsp"%>
    <%
        }
    %>
</body>
</html>
