<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>个人中心-我的红包</title>
    <!-- Set render engine for 360 browser -->
    <meta name="renderer" content="webkit">
    <!-- No Baidu Siteapp-->
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="icon" type="image/png" href="/resources/assets/i/favicon.png">
    <!-- Add to homescreen for Chrome on Android -->
    <meta name="mobile-web-app-capable" content="yes">
    <link rel="icon" sizes="192x192" href="/resources/assets/i/app-icon72x72@2x.png">
    <!-- Add to homescreen for Safari on iOS -->
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <link rel="apple-touch-icon-precomposed" href="/resources/assets/i/app-icon72x72@2x.png">
    <!-- Tile icon for Win8 (144x144 + tile color) -->
    <meta name="msapplication-TileImage" content="/resources/assets/i/app-icon72x72@2x.png">
    <meta name="msapplication-TileColor" content="#0e90d2">
    <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/wap/css/amazeui.min.css?v=20150831"/>">
    <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/wap/css/app.css?v=20150831"/>">
    <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/wap/css/myorder.css?v=20150831"/>">
</head>
<body>
<header class="am-header custom-header">
    <div class="am-header-left am-header-nav">
        <a href="javascript:history.go(-1)" class="chevron-left"></a>
    </div>
    <!-- //End--chevron-left-->
    <h1 class="am-header-title">我的红包</h1>
    <!-- //End--title-->
</header>
<!--//End--header-->
<div class="my-packet ae">
    <div class="top ae">
        <div class="pic"><a href="#"><img src="<c:url value="/scripts/wap/upload/yonghm.jpg"/>"></a></div>
        <div class="text">
            <p>用户名：${user.username}</p>
            <c:if test="${empty user.redPacket}">
            <c:set var="bonus">
                   0
            </c:set>
            </c:if>
            <c:if test="${not empty user.redPacket}">
                <c:set var="bonus">
                    ${user.redPacket}
                </c:set>
            </c:if>
            <p>红包总额：${bonus}元</p>
        </div>
    </div>
    <div class="page ae">
        <p>红包使用方法：</p>
        <P>快到开团/参团页面联系在线客服吧，我们会直接给你发红包呦~</P>
    </div>
</div>
<!--//End--footer-->

<!--[if (gte IE 9)|!(IE)]><!-->
<script href="<c:url value="/scripts/js/jquery.min.js"/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="/resources/assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script href="<c:url value="/scripts/wap/js/amazeui.min.js"/>"></script>
<!--自定义js--Start-->
<script href="<c:url value="/scripts/wap/js/system.js?v=20150831"/>"></script>
<script href="<c:url value="/scripts/wap/js/myorder.js?v=20150831"/>"></script>
<!--自定义js--End-->
</body>
</html>