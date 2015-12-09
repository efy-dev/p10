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
<div class="gift ae">
    <div class="card custom ae">
        <div class="btb"><h5>礼物卡片</h5></div>
        <div class="pic-page ae">
            <div class="pic-img"><img src="http://pro.efeiyi.com/${purchaseOrder.purchaseOrderProductList.get(0).productModel.productModel_url}@!product-icon" width="181" height="101"></div>
            <div class="pic-text">
                <p>${purchaseOrder.purchaseOrderProductList.get(0).productModel.product.name}</p>
                <p class="t2"><i></i><span>${purchaseOrder.purchaseOrderProductList.get(0).productModel.product.project.name}</span><em></em></p>
                <c:if test="${!empty purchaseOrder.purchaseOrderProductList.get(0).productModel.product.master}">
                <p class="t3">${purchaseOrder.purchaseOrderProductList.get(0).productModel.product.master.name}</p>
                </c:if>
            </div>
        </div>
        <c:if test="${!empty purchaseOrder.giftMessage || !empty purchaseOrder.giftMessage }">
        <div class="c-info ae" style="margin-top:0;">
            <c:if test="${!empty purchaseOrder.giftMessage}">
            <p>${purchaseOrder.giftMessage}</p>
            </c:if>
            <c:if test="${!empty purchaseOrder.giftGaverName}">
            <p>——${purchaseOrder.giftGaverName}</p>
            </c:if>
        </div>
        </c:if>
    </div>
    <!-- //End-->
    <c:if test="${!empty content}">
    <div class="logistics ae">
        <div class="part">
            <h4>感谢您收下礼物，快递小哥正在拼命配送中。</h4>
            <ul>
                <li><span>物流状态：</span><em><ming800:status name="orderStatus" dataType="PurchaseOrder.orderStatus" checkedValue="${purchaseOrder.orderStatus}" type="normal"/></em></li>
                <li><span>物流公司：</span><em><ming800:status name="logisticsCompany" dataType="PurchaseOrderDelivery.logisticsCompany" checkedValue="${lc}" type="normal"/></em></li>
                <li><span>运单编号：</span><em>${serial}</em></li>
            </ul>
        </div>
        <div class="part">
            <h5>物流跟踪</h5>
            <div style="width:100%;overflow: hidden;float:left;margin-left:-73px;"><iframe id="kuaidi100" name="kuaidi100" src="${content}" width="600" height="380" marginwidth="12" marginheight="10" hspace="11" vspace="10" frameborder="0" scrolling="no"></iframe></div>

        </div>
    </div>
</c:if>
    <div class="efi-icon ae"><i class="icon"></i></div>
</div>
</body>
</html>