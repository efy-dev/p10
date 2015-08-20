<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/17
  Time: 9:34
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>品类首页新</title>
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
  <meta name="msapplication-TileImage" content="/scripts/assets/i/app-icon72x72@2x.png">
  <meta name="msapplication-TileColor" content="#0e90d2">
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/css/amazeui.min.css'/>">
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/css/app.css'/>">
</head>
<body>
<!-- //End--header-->
<div class="hd category">
  <div class="breadcrumb wh">
    <ol class="am-breadcrumb">
      <li><a href="#">首页</a></li>
      <li class="am-active">歙砚</li>
    </ol>
  </div>
  <!-- //End--breadcrumb-->
  <div class="explain">
    <div class="title">
      <p class="wh"><span class="zh">she</span><span class="cn">${proName[0]}</span></p>
      <p class="wh"><span class="zh">yan</span><span class="cn">${proName[1]}</span></p>
      <p class="wh"><span class="zh">yan</span><span class="cn">${proName[1]}</span></p>
      <p class="wh"><span class="zh">yan</span><span class="cn">${proName[1]}</span></p>
    </div>
    <div class="info">${project.description}</div>
    <a href="" class="more" title="了解更多"><i class="icon"></i>了解更多</a>
  </div>
  <!-- //End--explain-->
  <div class="shop-sort wh">
    <ul class="link1">
      <li class="active"><a href="" title="价  格">价  格</a></li>
      <li><a href="" title="销  售">销  售</a></li>
      <li><a href="" title="新  品">新  品</a></li>
      <li><a href="" title="人  气">人  气</a></li>
    </ul>
  </div>
  <!-- //End--shop-sort-->

  <c:if test="${productModelList.size()>0}">

      <div class="list-pro">

        <ul class="ul-item">
          <c:forEach items="${productModelList}" var="productModel" varStatus="rec">
          <li>
            <a href="" target="_blank" title="">
              <%--<img  class="imgfilter" src="http://pro.efeiyi.com/${productModel.product.pictureUrl}@!tenant-mobile-work" alt=""/>--%>
              <img  class="imgfilter" src="/scripts/assets/upload/category-1.jpg" alt=""/>
              <p class="wh name">${productModel.product.name}</p>
              <p class="wh price">${productModel.product.price}</p>
            </a>
          </li>
          </c:forEach>
        </ul>
        <!-- //End-->

      </div>

  </c:if>

  <!-- //End--list-pro-->
  <div class="page wh">
    <ul class="am-pagination am-pagination-centered">
      <li class="bigRound"><a href="">«</a></li>
      <li><a href="">1</a></li>
      <li class="am-active"><a href="#">2</a></li>
      <li class="am-disabled bigRound"><a href="#">»</a></li>
    </ul>
  </div>
  <!-- //End--footer-->
</div>
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="scripts/assets/js/jquery.min.js"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="scripts/assets/js/amazeui.min.js"></script>
<script src="scripts/assets/js/system.js"></script>
</body>
</html>
