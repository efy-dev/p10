<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
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
    <title>礼物订单-物流信息</title>
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
            <em>${purchaseOrder.giftMessage}</em>
        </div>
        <div class="cupic ae"><img src="${purchaseOrder.giftPictureUrl}"></div>
        <div class="efi-icon ae"><i class="icon"></i></div>
    </div>
    <div class="logistics ae">
        <div class="btb"><h5>物流详情</h5></div>
        <div class="p-text ae">
            <div class="txt">
                <div class="pic"><a href="#"><img src="../shop2015/upload/box-hd-2-2.jpg"> </a></div>
                <p>物流状态：<ming800:status name="orderStatus" dataType="PurchaseOrder.orderStatus"
                                        checkedValue="${purchaseOrder.orderStatus}" type="normal"/></p>
                <c:if test="${purchaseOrder.orderStatus==7}">

                    <p>物流公司：<ming800:status name="logisticsCompany" dataType="PurchaseOrderDelivery.logisticsCompany"
                                            checkedValue="${purchaseOrderDelivery.logisticsCompany}" type="normal"/></p>

                    <p>运单编号：${purchaseOrderDelivery.serial}</p>

                    <%--<p>官方电话：95123</p>--%>
                </c:if>
            </div>
        </div>
        <c:if test="${purchaseOrder.orderStatus==7}">
            <div class="btb"><h5>物流跟踪</h5></div>
            <!--用的时候去掉高-->
            <div class="ae" style="height: 100px;"></div>
        </c:if>
    </div>
</div>

</body>
</html>