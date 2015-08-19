<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@include file="/layouts/public.jsp"%>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>移动端详情-认证信息终</title>
  <!-- Set render engine for 360 browser -->
  <meta name="renderer" content="webkit">
  <!-- No Baidu Siteapp-->
  <meta http-equiv="Cache-Control" content="no-siteapp"/>
  <link rel="icon" type="image/png" href="<c:url value='/resources/assets/i/favicon.png'/>">
  <!-- Add to homescreen for Chrome on Android -->
  <meta name="mobile-web-app-capable" content="yes">
  <link rel="icon" sizes="192x192" href="<c:url value='/resources/assets/i/app-icon72x72@2x.png'/>">
  <!-- Add to homescreen for Safari on iOS -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
  <link rel="apple-touch-icon-precomposed" href="<c:url value='/resources/assets/i/app-icon72x72@2x.png'/>">
  <!-- Tile icon for Win8 (144x144 + tile color) -->
  <meta name="msapplication-TileImage" content="assets/i/app-icon72x72@2x.png">
  <meta name="msapplication-TileColor" content="#0e90d2">
  <link rel="stylesheet" href="<c:url value='/css/amazeui.min.css'/>">
  <link rel="stylesheet" href="<c:url value='/resources/css/app.css'/>">
</head>
<body class="bgf7">
<header data-am-widget="header" class="am-header am-header-default">
  <div class="am-header-left am-header-nav"> <a href="javascript:history.back()" class="" title="返回上一步">返回</a> </div>
  <h1 class="am-header-title">认证信息</h1>
  <div class="am-header-right am-header-nav">购买</div>
  <!--  <em class="line"></em>-->
</header>
<!--//End--header-->
<div data-am-widget="slider" class="am-slider am-slider-a1" data-am-slider='{"directionNav":false}'>
  <ul class="am-slides">
    <li><img src="<%=imgBasePath%>${product.tenantCertification.imgUrl}"></li>
  </ul>
</div>
<!--//End--轮播图-->
<div data-am-widget="list_news" class="am-list-news am-list-news-default cuslist">
  <!--列表标题-->
  <div class="am-list-news-bd">
    <ul class="am-list">
      <li class="am-g am-list-item-dated">
        <strong class="am-list-info">证书证书:</strong>
        <span class="am-list-info2">${product.tenantCertification.name}</span>
      </li>
      <li class="am-g am-list-item-dated">
        <strong class="am-list-info">认证机构:</strong>
        <span class="am-list-info2">${product.tenantCertification.org}</span>
      </li>
      <li class="am-g am-list-item-dated">
        <strong class="am-list-info">认证时间:</strong>
        <span class="am-list-info2"> <fmt:formatDate value="${product.tenantCertification.theDate}" pattern="yyyy年MM月"/></span>
      </li>
      <li class="am-g am-list-item-dated">
        <strong class="am-list-info">认证结果:</strong>
        <span class="am-list-info2"><ming800:status name="level" dataType="PCTenantCertification.level" checkedValue="${product.tenantCertification.level}" type="normal" /></span>
      </li>
    </ul>
  </div>
</div>
<%--<script src="js/jquery.min.js"></script>--%>
<script src="<c:url value='/js/amazeui.min.js'/>"></script>
<script type="text/javascript">
  $(function() {
    $('.am-slider-manual').flexslider({
      // options
    });
  });
</script>
</body>
</html>
