<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="">
<meta name="keywords" content="">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<!-- Set render engine for 360 browser -->
<meta name="renderer" content="webkit">
<!-- No Baidu Siteapp-->
<meta http-equiv="Cache-Control" content="no-siteapp"/>
<link rel="icon" type="image/png" href="assets/i/favicon.png">
<!-- Add to homescreen for Chrome on Android -->
<meta name="mobile-web-app-capable" content="yes">
<link rel="icon" sizes="192x192" href="assets/i/app-icon72x72@2x.png">
<!-- Add to homescreen for Safari on iOS -->
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-title" content="Amaze UI"/>
<link rel="apple-touch-icon-precomposed" href="assets/i/app-icon72x72@2x.png">
<!-- Tile icon for Win8 (144x144 + tile color) -->
<meta name="msapplication-TileImage" content="assets/i/app-icon72x72@2x.png">
<meta name="msapplication-TileColor" content="#0e90d2">
<script src="<c:url value='/resources/jquery/jquery-1.11.1.min.js'/>"></script>
<c:if test="${init!=true}">
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/assets/css/amazeui.min.css"/>">
<link type="text/css" rel="stylesheet" href="<c:url value="/scripts/wap/css/app.css"/>">
<link type="text/css" rel="stylesheet" href="<c:url value="/scripts/wap/css/myorder.css"/>">
</c:if>
<script src="<c:url value="/scripts/js/ef.util.js"/>"></script>
<script src="<c:url value='/resources/js/alert.js'/>"></script>