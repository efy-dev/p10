<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/29
  Time: 11:01
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>商品详情</title>
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
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/css/amazeui.min.css?v=20150831'/>">
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/css/app.css?v=20150831'/>">
</head>
<body>
<!-- //End--header-->
<div class="hd product-intro">
  <div class="wh">
    <ol class="am-breadcrumb">
      <li><a href="/">首页</a></li>
      <li><a href="#">分类</a></li>
      <li class="am-active">内容</li>
    </ol>
  </div>
  <!-- //End--面包屑-->
  <div class="wh itemInfo">
    <div class="preview">
      <%--<div class="collect"><i class="icon"></i><span class="hover">收藏</span><span class="active">已收藏</span></div>--%>
      <div class="slider-img">
        <ul>
          <c:forEach items="${product.productPictureList}" var="productPicture" varStatus="rec">
            <c:if test="${productPicture.status=='1'}">
              <li class="active"><img src="http://pro.efeiyi.com/${productPicture.pictureUrl}" width="60" height="60"
                                      alt=""/></li>
            </c:if>
          </c:forEach>
        </ul>
      </div>
      <!-- //End--sliderimg-->
      <div class="slider-main">
        <ul>
          <c:forEach items="${product.productPictureList}" var="productPicture" varStatus="rec">
            <c:if test="${productPicture.status=='1'}">
            <li><img src="http://pro.efeiyi.com/${productPicture.pictureUrl}" width="" height="643" alt=""/></li>
            </c:if>
          </c:forEach>
        </ul>
      </div>
      <!-- //End--slider-main-->
    </div>
    <!-- //End--des-focus-->
    <div class="itme-ext">
      <div class="name">
        <p>${product.master.fullName}</p>
        <p><strong>${product.name}</strong></p>
      </div>
      <!-- //End-->
      <div class="des">
        <ul class="ul-list">
          <c:forEach items="${productModelList}" var="productModelTmp" varStatus="rec">
            <c:if test="${productModel.id == productModelTmp.id}">
              <li class="active">
            </c:if>
            <c:if test="${productModel.id != productModelTmp.id}">
              <li class="">
            </c:if>
            <a href="/product/productModel/${productModelTmp.id}">
                <c:forEach items="${productModelTmp.productPropertyValueList}" var="productPropertyValue" varStatus="rec">
                  ${productPropertyValue.projectPropertyValue.value}
                </c:forEach>
                  ${product.name}</a>
            </li>

          </c:forEach>
        </ul>
      </div>
      <!-- //End-->
      <%--<div class="amount">--%>
        <%--<div class="ipt">--%>
          <%--<input class="txt" type="text" value="1"/><em class="ge">个</em>--%>
        <%--</div>--%>
        <%--<div class="btns">--%>
          <%--<a href="#btn-add" class="btn-add" title="加">+</a>--%>
          <%--<a href="#btn-sub" class="btn-sub" title="减">-</a>--%>
        <%--</div>--%>
      <%--</div>--%>
      <!-- //End-->
      <div class="price">
        <div class="p-text">飞蚁价：</div>
        <div class="p-price"><em>￥</em><span>${productModel.price}</span></div>
        <div class="m-price">市场价：￥${productModel.marketPrice}</div>
      </div>
      <!-- //End-->
      <div class="choose-btns">
        <a id ="modelId" class="btn btn-append"  href="<c:url value="/cart/addProduct.do?id=${productModel.id}"/>" title="放入购物车">放入购物车</a>
        <a class="btn btn-buy" href="/order/easyBuy/${productModel.id}" title="立即购买">立即购买</a>

        <!-- JiaThis Button BEGIN -->
        <div class="jiathis_style">
          <span class="jiathis_txt">分享到</span>
          <a class="jiathis_button_weixin"></a>
          <a class="jiathis_button_tqq"></a>
          <a class="jiathis_button_tsina"></a>
          <a class="jiathis_button_cqq"></a>
        </div>
        <!-- JiaThis Button END -->
      </div>
      <!-- //End-->
    </div>
    <!-- //End--itme-ext-->
  </div>
  <!-- //End--itemInfo-->
  <div class="wh">
    <div class="tab-wrap">
      <!-- JiaThis Button BEGIN -->
      <div class="jiathis_style">
        <span class="jiathis_txt">分享到</span>
        <a class="jiathis_button_weixin"></a>
        <a class="jiathis_button_tqq"></a>
        <a class="jiathis_button_tsina"></a>
        <a class="jiathis_button_cqq"></a>
      </div>
      <!-- JiaThis Button END -->
      <div class="tab-items">
        <ul>
          <li><a href="#detail" title="商品详情">商 品 详 情</a></li>
          <%--<li><a href="#feeling" title="大师感悟">大 师 感 悟<i class="icon"></i></a></li>--%>
          <%--<li><a href="#" title="商品评价">商 品 评 价<i class="icon"></i></a></li>--%>
          <%--<li><a href="#" title="服务保障">服 务 保 障<i class="icon"></i></a></li>--%>
          <%--<li><a href="#" title="同店精品">同 店 精 品</a></li>--%>
        </ul>
      </div>
      <!-- //End-->
      <div class="btns">
        <a class="buy" href="<c:url value="/cart/addProduct.do?id=${productModel.id}"/>" title="立即购买">立 即 购 买</a>
        <a class="append" href="/order/easyBuy/${productModel.id}" title="放入购物车"><i class="icon"></i>放 入 购 物 车</a>
      </div>
    </div>
    ${product.productDescription.content}
  </div>
</div>
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="/scripts/js/jquery.min.js"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="/scripts/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="/scripts/js/amazeui.min.js"></script>
<script src="/scripts/js/system.js"></script>
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js?uid=" charset="utf-8"></script>

</body>
</html>









