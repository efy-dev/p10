<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/18
  Time: 14:41
  To change this template use File | Settings | File Templates.
--%>
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
  <title>爆款推荐</title>
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
  <link type="text/css" rel="stylesheet" href="<c:url value='/resources/css/amazeui.min.css?v=20150831'/>">
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/css/app.css?v=20150831'/>">
</head>
<body>
<!-- //End--topbar-->
<div class="hd explosion">
  <div class="details wh">
    <div class="img"><a href="<c:url value="/product/productModel/${productModel.id}"/>" target="_blank" title=""><img class="imgfilter" src="http://pro.efeiyi.com/${productModel.productModel_url}@!product-model" width="500" height="350"/></a></div>
    <%--<div class="img"><a href="<c:url value=''/>" target="_blank" title=""><img class="imgfilter" src="" width="500" height="350"/></a></div>--%>
    <div class="info">
      <h1>${productModel.product.master.fullName}.${map.get(productModel)}</h1>
      <div class="p-img"><a target="_blank" title=""><img class="imgfilter" src="http://tenant.efeiyi.com/${productModel.product.master.favicon}@!tenant-pc-tenant-list" width="286" height="206" alt=""/></a></div>
      <div class="item p-text">${productModel.product.master.content}</div>
      <div class="item p-price"><em>￥</em>${productModel.price}</div>
      <div class="item p-btn">
        <a class="cart" href="<c:url value="/cart/addProduct.do?id=${productModel.id}"/>" title="加入购物车"><i class="icon"></i>加入购物车</a>
        <a class="buy"  href="<c:url value="/order/easyBuy/${productModel.id}"/>"} title="立即购买">立即购买</a>
      </div>
    </div>
  </div>
  <!-- //End--details-->
  <div class="shop-sort wh">
    <ul class="link1">
      <li><a href="" title="推荐商品">推荐商品</a></li>
    </ul>
  </div>
  <!-- //End--shop-sort-->
<c:if test="${productModelList.size()>0}">
  <div class="category">
    <div class="list-pro">
      <ul class="ul-item">
        <c:forEach items="${productModelList}" var="productModel" varStatus="rec">
        <li>
          <a href="<c:url value='/product/hot/${productModel.id}'/>" target="_blank" title="">
            <img class="imgfilter" src="http://pro.efeiyi.com/${productModel.productModel_url}" alt="">
            <p class="wh name">${map.get(productModel)}
            </p>
            <p class="wh price">￥${productModel.price}</p>
          </a>
        </li>
        </c:forEach>
      </ul>
    </div>
    </c:if>
    <!-- //End--list-pro-->
<%--    <div class="page wh">
      <ul class="am-pagination am-pagination-centered">
        <li class="bigRound"><a href="">«</a></li>
        <li><a href="">1</a></li>
        <li class="am-active"><a href="#">2</a></li>
        <li class="am-disabled bigRound"><a href="#">»</a></li>
      </ul>
    </div>--%>
    <!-- //End--page-->
  </div>
  <!-- //End---->

</div>
<!-- //End--footer-->

<!--[if (gte IE 9)|!(IE)]><!-->
<script href="<c:url value='/scripts/js/jquery.min.js'/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script href="<c:url value='http://libs.baidu.com/jquery/1.11.3/jquery.min.js'/>"></script>
<script href="<c:url value='http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js'/>"></script>
<script href="<c:url value='/scripts/js/amazeui.ie8polyfill.min.js'/>"></script>
<![endif]-->
<script href="<c:url value='/scripts/js/amazeui.min.js'/>"></script>
<script href="<c:url value='/scripts/js/system.js'/>"></script>
</body>
</html>
