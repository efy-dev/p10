<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/29
  Time: 9:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>移动端详情页真伪-伪</title>
  <!-- Set render engine for 360 browser -->
  <meta name="renderer" content="webkit">
  <!-- No Baidu Siteapp-->
  <meta http-equiv="Cache-Control" content="no-siteapp"/>
  <link rel="icon" type="image/png" href="<c:url value='resources/assets/i/favicon.png'/>">
  <!-- Add to homescreen for Chrome on Android -->
  <meta name="mobile-web-app-capable" content="yes">
  <link rel="icon" sizes="192x192" href="<c:url value='resources/assets/i/app-icon72x72@2x.png'/>">
  <!-- Add to homescreen for Safari on iOS -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
  <link rel="apple-touch-icon-precomposed" href="<c:url value='resources/assets/i/app-icon72x72@2x.png'/>">
  <!-- Tile icon for Win8 (144x144 + tile color) -->
  <meta name="msapplication-TileImage" content="<c:url value='resources/assets/i/app-icon72x72@2x.png'/>">
  <meta name="msapplication-TileColor" content="#0e90d2">
  <link rel="stylesheet" href="<c:url value='resources/assets/css/amazeui.min.css'/>">
  <link rel="stylesheet" href="<c:url value='resources/assets/css/app.css'/>">
</head>
<body class="bgf7">
<header data-am-widget="header" class="am-header am-header-default">
  <h1 class="am-header-title">诚品宝-非遗商品防伪溯源系统</h1>
</header>

<!--//End--header-->
<article class="eslite">
  <div class="am-paragraph-default">
    <div class="imglogo"><img src="${result.logo}"/></div>
    <div class="tips">${result.msg}</div>
  </div>
  <!--//End-->
  <div class="am-paragraph-default">
    <div class="title">${product.name}</div>
    <div class="infolist">
      <ul>
        <li><strong>传承项目：</strong><p>${product.productSeries.name}</p></li>
        <li><strong>制  作  人：</strong><p>${product.productSeries.tenant.name}</p></li>
        <li><strong>创作时间：</strong><p>2006年</p></li>
      </ul>
    </div>
  </div>
  <!--//End-->

  <div class="am-paragraph-default">
    <div class="infoitem">
      <ul>
        <li><a href="http://www.baidu.com">认证信息</a></li>
        <li><a href="http://www.baidu.com">商品信息</a></li>
        <li><a href="http://www.baidu.com">溯源信息</a></li>
        <li><a href="http://www.baidu.com">DNA鉴定信息</a></li>
      </ul>
    </div>
  </div>
  <!--//End-->
  <div class="am-list-news-ft"><a class="am-list-news-more am-btn am-btn-default" href="###">立即购买</a></div>
</article>




<script src="<c:url value='resources/assets/js/jquery.min.js'/>"></script>
<script src="<c:url value='resources/assets/js/amazeui.min.js'/>"></script>
<script type="text/javascript">
  $(function() {
    $('.am-slider-manual').flexslider({
      // options
    });
  });
</script>
</body>
</html>
