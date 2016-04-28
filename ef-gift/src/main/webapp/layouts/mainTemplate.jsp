<!doctype html>
<%@ page import="com.ming800.core.util.HttpUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>--%>
<%
    if (HttpUtil.isPhone(request)) {
%>
<html lang="en">
<%
} else {
%>
<html class="no-js">
<%
    }
%>
<head>
    <title><sitemesh:write property='title'/></title>
    <sitemesh:write property='head'/>
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


</head>
<body>

<%
    if (HttpUtil.isPhone(request)) {
%>
<%--导航--%>

<%
} else {
%>
<jsp:include flush="true"
             page="/getMenu.do?jmenuId=nav&jnodeId=nav&resultPage=/common/nav&match=${requestScope['javax.servlet.forward.servlet_path']}%3F${fn:replace(pageContext.request.queryString,'&','%26')}"/>


<%
    }
%>

<%
    if (HttpUtil.isPhone(request)) {
%>
<sitemesh:write property='body'/>
<%
} else {
%>
<div class="wh">
    <sitemesh:write property='body'/>
</div>
<%
    }
%>

<%
    if (HttpUtil.isPhone(request)) {
%>
<%@include file="mobileFooter.jsp" %>
<%
} else {
%>
<%@include file="footer.jsp" %>
<%
    }
%>

</body>

</html>
