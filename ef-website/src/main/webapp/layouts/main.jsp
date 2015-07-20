<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/24
  Time: 17:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>首页</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Amaze UI Admin index Examples</title>
    <meta name="keywords" content="index">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="icon" type="image/png" href="../scripts/assets/i/favicon.png">
    <link rel="apple-touch-icon-precomposed" href="../scripts/assets/i/app-icon72x72@2x.png">
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <link rel="stylesheet" href="../scripts/assets/css/amazeui.min.css"/>
    <link rel="stylesheet" href="../scripts/assets/css/admin.css">
    <script src="<c:url value='../scripts/assets/js/jquery.min.js'/>"></script>
    <script src="<c:url value='../scripts/assets/js/amazeui.min.js'/>"></script>
    <sitemesh:head/>
    <style>
        .efy-active {
            background-color: #9a9a9a;
        }
    </style>
</head>
<body>
<jsp:include flush="true" page="/getMenu.do?jmenuId=webMenu&resultPage=/jmenu/manageTemplateHeader&match=${requestScope['javax.servlet.forward.servlet_path']}
"/>
<div class="am-cf admin-main">

    <%--<jsp:include flush="true" page="/getMenu.do?jmenuId=webMenu&resultPage=/jmenu/manageTemplateLeft&match=${requestScope['javax.servlet.forward.servlet_path']}"/>--%>
    <div class="admin-content">
        <sitemesh:body/>
    </div>

</div>
<%@ include file="/layouts/footer.jsp"%>
</body>

</html>
