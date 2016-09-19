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
<%String path = request.getContextPath();%>
<html class="no-js">
<head>
    <title><sitemesh:write property='title'/></title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Amaze UI Admin index Examples</title>
    <meta name="description" content="这是一个 index 页面">
    <meta name="keywords" content="index">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="renderer" content="webkit">
    <link rel="icon" type="image/png" href="<c:url value='/resources/assets/i/favicon.png'/>"/>
    <link rel="apple-touch-icon-precomposed" href="<c:url value='/resources/assets/i/app-icon72x72@2x.png'/>"/>
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <link rel="stylesheet" href="http://cdn.amazeui.org/amazeui/2.7.2/css/amazeui.min.css"/>
    <link rel="stylesheet" href="<c:url value='/resources/assets/css/admin.css'/>"/>
    <script src="<c:url value='/resources/jquery/jquery-1.11.1.min.js'/>"></script>
    <script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.min.js"></script>
    <script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.ie8polyfill.min.js"></script>
    <script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.widgets.helper.min.js"></script>
    <script src="<c:url value='/resources/js/alert.js'/>"></script>

    <sitemesh:write property='head'/>
    <style>

        .efy-active {
            background-color: #9a9a9a;
        }
    </style>
</head>
<body>

<jsp:include flush="true"
             page="/getMenu.do?jmenuId=commonMenu&resultPage=/jmenu/manageTemplateHeader&match=${requestScope['javax.servlet.forward.servlet_path']}%3F${fn:replace(pageContext.request.queryString,'&','%26')}"/>

<div class="am-cf admin-main">
<%----%>
    <jsp:include flush="true"
                 page="/getMenu.do?jmenuId=commonMenu&resultPage=/jmenu/manageTemplateLeft&match=${requestScope['javax.servlet.forward.servlet_path']}%3F${fn:replace(pageContext.request.queryString,'&','%26')}"/>
<div class="admin-content" style="height: auto;">
<sitemesh:write property='body'/>
</div>

</div>
</body>

</html>
