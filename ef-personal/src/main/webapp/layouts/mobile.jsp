<!DocType html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>传承人</title>

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

    <link rel="stylesheet" href="<c:url value="/scripts/assets/wap/css/amazeui.min.css"/> ">
    <link rel="stylesheet" href="<c:url value="/scripts/assets/wap/css/app.css"/>">
    <link rel="stylesheet" href="<c:url value="/scripts/assets/wap/css/style.css"/>">
    <script src="<c:url value="/scripts/assets/wap/js/amazeui.min.js"/>"></script>
    <script src="<c:url value="/scripts/assets/wap/js/jquery.min.js"/>"></script>
    <sitemesh:write property='head'/>
</head>
<body>
<header data-am-widget="header" class="am-header am-header-default">
    <div class="am-header-left am-header-nav">
        <a href="#left-link" class="">
        </a>
    </div>
    <h1 class="am-header-title">
        <a href="#title-link" class="">e飞蚁—传承人官网</a>
    </h1>
    <div class="am-header-right am-header-nav">
        <a href="#right-link" class="">
        </a>
    </div>
</header>
<div class="am-border-1"></div>
<nav id="am-nav-1">
    <div class="am-bg-tp "><img src="images/logo3_02.jpg"></div>
    <div class="am-xu-nav">
        <img src="images/logo4_03.jpg" alt="传承人" class="am-img-thumbnail am-circle">
        <p id="am-mg-14">魏立中</p>
        <p>木板水印</p>
        <p >国家级非物质文化遗产传承人<img src="images/logo2.gif" class="am-page-img"></p>
        <p id="am-bd-2"><a href="#" class="p-a" id="p-a">首页<span class="am-bd-2"></span><span id="am-sj-i"></span></a><a href="#" class="p-a">简介<span class="am-bd-2"></span></a><a href="#" class="p-a">作品<span class="am-bd-2"></span></a><a href="#" class="p-a">咨询<span  class="am-bd-2"></span></a><a href="#" class="p-a">工作坊</a></p>
    </div>
</nav>
<sitemesh:write property='body'/>
<footer data-am-widget="footer" class="am-footer am-footer-default" data-am-footer="{  }">
    <div class="am-footer-switch">
        <span class="am-footer-ysp" data-rel="mobile" data-am-modal="{target: '#am-switch-mode'}"><a href="#"><img src="images/logo.gif" width="61" height="23"></a></span>
    </div>
    <div class="am-footer-miscs ">
        <p>中国非遗电商平台·传承人官网</p>
    </div>
</footer>
<div id="am-footer-modal" class="am-modal am-modal-no-btn am-switch-mode-m am-switch-mode-m-default">
    <div class="am-modal-dialog">
        <div class="am-modal-hd am-modal-footer-hd">
            <a href="javascript:void(0)" data-dismiss="modal" class="am-close am-close-spin "
               data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd">
            <span class="am-switch-mode-owner"></span>
            <span class="am-switch-mode-slogan">中国非遗电商平台·传承人官网</span>
        </div>
    </div>
</div>
</body>
</html>
