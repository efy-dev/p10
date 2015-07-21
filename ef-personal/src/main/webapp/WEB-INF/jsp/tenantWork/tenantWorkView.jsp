<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html class="no-js">
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
  <link rel="stylesheet" type="text/css" href="css/amazeui.min.css">
  <link rel="stylesheet" type="text/css" href="css/app.css">
  <link rel="stylesheet" type="text/css" href="css/style.css">
  <link href="<c:url value="/scripts/assets/css/jquery.jslides.css"/>" rel="stylesheet" type="text/css" />
  <script src="<c:url value="/scripts/assets/js/jquery.min.js"/>></script>
  <script src="<c:url value="/scripts/assets/js/jquery.jslides.js"/>></script>
</head>
<body>
<!--作品详情-->
<div id="page-nav">
  <p><a href="#">首页</a><span>作品</span></p>
</div>
<div class="border-nav"></div>
<div id="center--1">
  <div class="center-buttom-1"></div>
  <div class="center-right">
    <div class="content-border">
      <dl class="right-content">
        <dt class="right-content-img"><img src="<c:url value="${productPicture.pictureUrl}"/>"></dt>
        <dd class="right-content-p">
          ${productDescription.content}
        </dd>
      </dl>
      <div class="right-border"></div>
    </div>
  </div>
</div>
<!--其他内容-->
</body>
</html>