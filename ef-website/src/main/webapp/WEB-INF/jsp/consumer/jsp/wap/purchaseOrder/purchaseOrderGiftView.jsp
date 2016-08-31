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
            <em>我精心为你准备了礼物，希望你能收下。</em>
        </div>
        <div class="cupic ae"><img src="${order.giftPictureUrl}"></div>
    </div>
    <div class="car-state">
        <div class="btb"><h5>礼物卡片</h5><span><c:if test="${order.orderStatus=='6'}">未收礼</c:if> <c:if
                test="${order.orderStatus=='5'}">已收礼</c:if> </span></div>
        <div class="btb"><h5>送礼说明</h5></div>
        <div class="btb-text ae">
            <p>1、点击“送礼给Ta”，选择“发送给微信好友”，即可将礼物链接发送给好友。 </p>

            <p>2、好友通过点击你发送的链接进入收礼页面，正确填写收货信息后即可成功收礼。</p>

            <p>3、也可点击“保存为图片”将本页面保存为带有二维码的礼物卡片，然后把图片发给好友。</p>

            <p>4、好友通过识别图片上的二维码就可以进入收礼页面，正确填写收货信息后也可以收礼啦!</p>
        </div>
    </div>
    <div class="car-fx">
        <p  style="display: none"  id="receiveUrl">http://www.efeiyi.com/order/giftReceive/${order.id}</p>
        <a onclick="weixinSendAppMessage()">送礼给Ta</a>
        <a href="<c:url value="/order/createGiftImage/${order.id}"/> ">保存为图片</a>
    </div>
</div>

<script>
    function copyUrl() {
        var url = document.getElementById("receiveUrl");
        url.select();
        document.execCommand("Copy");
        showAlert("提示","链接复制成功，直接发送给好友即可")
    }



    function weixinSendAppMessage() {
        var sendAppMessage = function (theData) {
            WeixinJSBridge.invoke('sendAppMessage', {
                "appid":"wx7f6aa253b75466dd",
                "link":"http://www.efeiyi.com/order/giftReceive/${order.id}",
                "img_url":"",
                "desc":"${order.giftMessage}",
                "title":"礼物到",
                "img_width":"640",
                "img_height":"640"
            }, function (resp) {
                switch (resp.err_msg) {
                    // send_app_msg:cancel 用户取消
                    case 'send_app_msg:cancel':
//                        callbacks.cancel && callbacks.cancel(resp);
                        break;
                    // send_app_msg:confirm 发送成功
                    case 'send_app_msg:confirm':
                    case 'send_app_msg:ok':
//                        callbacks.confirm && callbacks.confirm(resp);
                        break;
                    // send_app_msg:fail　发送失败
                    case 'send_app_msg:fail':
                    default:
//                        callbacks.fail && callbacks.fail(resp);
                        break;
                }
                // 无论成功失败都会执行的回调
//                callbacks.all && callbacks.all(resp);
            });
        };
        WeixinJSBridge.on('menu:share:appmessage', function (argv) {
                sendAppMessage()
        });
    }

    $().ready(function(){
        weixinSendAppMessage();
    })
</script>
</body>
</html>