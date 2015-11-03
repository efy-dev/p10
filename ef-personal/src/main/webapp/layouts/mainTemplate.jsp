<!DocType html>
<%@ page import="com.ming800.core.util.HttpUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <%
        if(HttpUtil.isPhone(request)){
    %>
    <%@include file="mobileStyleMaster.jsp"%>
    <%
    }else{
    %>
    <%@include file="pcStyleMaster.jsp"%>
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
    <%@include file="pcHeaderMaster.jsp"%>
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
    <%@include file="pcFooterMaster.jsp"%>
    <%
        }
    %>
</body>
</html>
