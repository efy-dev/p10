<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/24
  Time: 17:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>--%>
<html>
<head>
    <title>首页</title>
    <meta charset="utf-8">
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <meta name="renderer" content="webkit">
    <!-- No Baidu Siteapp-->
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="icon" type="image/png" href="<c:url value="/resources/assets/i/favicon.png"/>">
    <!-- Add to homescreen for Chrome on Android -->
    <meta name="mobile-web-app-capable" content="yes">
    <link rel="icon" sizes="192x192" href="<c:url value="/resources/assets/i/app-icon72x72@2x.png"/>">
    <!-- Add to homescreen for Safari on iOS -->
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <link rel="apple-touch-icon-precomposed" href="<c:url value="/resources/assets/i/app-icon72x72@2x.png"/>">
    <!-- Tile icon for Win8 (144x144 + tile color) -->
    <meta name="msapplication-TileImage" content="<c:url value="/resources/assets/i/app-icon72x72@2x.png"/>">
    <meta name="msapplication-TileColor" content="#0e90d2">
    <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/assets/css/amazeui.min.css"/>">
    <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/assets/css/app.css"/>">
    <script src="<c:url value='/resources/jquery/jquery-1.11.1.min.js'/>"></script>
    <!--[if (gte IE 9)|!(IE)]><!-->
    <script src="<c:url value="/resources/jquery/jquery.min.js"/>"></script>
    <!--<![endif]-->
    <script src="<c:url value='/resources/js/alert.js'/>"></script>
    <script src="<c:url value="/resources/assets/js/amazeui.min.js"/>"></script>
    <script src="<c:url value="/scripts/assets/js/ef.util.js"/>"></script>

    <%--<script src="<c:url value='/base_resource/p/scripts/ckeditor/ckeditor.js'/>" charset="GB2312"></script>--%>
    <sitemesh:write property='head'/>
</head>
<body <sitemesh:write property='body.class'/>>

<%--导航--%>
<jsp:include flush="true"
             page="/getMenu.do?jmenuId=nav&jnodeId=nav&resultPage=/common/nav&match=${requestScope['javax.servlet.forward.servlet_path']}%3F${fn:replace(pageContext.request.queryString,'&','%26')}"/>

<div class="wh" style="">
    <sitemesh:write property='body'/>
</div>

<%@include file="footer.jsp" %>

<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value="/scripts/assets/js/amazeui.ie8polyfill.min.js"/>"></script>
    <![endif]-->
<script src="<c:url value="/resources/js/system.js"/>"></script>
</body>

</html>
