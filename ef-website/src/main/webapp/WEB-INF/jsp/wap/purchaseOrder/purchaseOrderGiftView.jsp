<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>礼物订单-付款后</title>
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
</head>
<body>
<!--//End--header-->
<div class="gift ae">
    <div class="card custom ae">
        <div class="btb"><h5>礼物卡片</h5></div>
        <div class="edit-text">
            <em>${order.giftMessage}</em>
        </div>
        <div class="cupic ae"><img src="${order.giftPictureUrl}"></div>
    </div>
    <div class="car-state">
        <div class="btb"><h5>礼物状态</h5><span><c:if test="${order.orderStatus=='6'}">未收礼</c:if> <c:if
                test="${order.orderStatus=='5'}">已收礼</c:if> </span></div>
        <div class="btb"><h5>送礼说明</h5></div>
        <div class="btb-text ae">
            <p>1、点击“送礼给Ta”，根据提示送礼给好友，好友通过点击收到的链接开启收礼姿势，正确填写收货信息后即可收礼。 </p>

            <p>2、点击“保存为图片”将生成图片形式的礼物卡片，保存图片后发给好友，好友通过识别图片上的二维码开启收礼姿势，正确填写收货信息后即可收礼。</p>

        </div>
    </div>
    <div class="car-fx">
        <a id="btn" class="btn-share">送礼给Ta</a>
        <div id="cover"><em class="bg"></em><img src="<c:url value="/scripts/wap/upload/guide-share.png"/>" alt="">
        <a href="<c:url value="/createGiftImage/${order.id}"/> ">保存为图片</a>
    </div>
</div>

<script>

</script>
</body>
</html>