<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>礼物订单</title>
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
<header class="am-header custom-header">
    <div class="am-header-left am-header-nav">
        <a href="#chevron-left" class="chevron-left"></a>
    </div>
    <!-- //End--chevron-left-->
    <h1 class="am-header-title">礼物订单</h1>
    <!-- //End--title-->
    <!-- //End--chevron-left-->
</header>
<!--//End--header-->
<div class="gift ae">
    <div class="card custom ae">
        <div class="btb"><h5>礼物卡片</h5></div>
        <div class="edit-text">
            <!--确定后的样式-->
            <!-- <div class="edit-txt1">种地农民卖粮之难，并不只此而已。喜获丰收，本想多卖多赚，孰料供大于求，价格上不去甚至被恶意压低，迟迟兑换不了钞票。</div>-->
            <!--确定后的样式-->
            <a href="#" id="add-show" class="edit-txt">编辑祝福语</a>
            <!--弹出框-->


            <div style="display: none" class="add-cart">
                <textarea class="ae" id="giftMessage"></textarea>

                <div class="atext ae">
                    <a href="" class="cancel">取&nbsp;消</a>
                    <a href="" class="affirm" id="confirmGiftMessage">确&nbsp;认</a>
                </div>
            </div>


        </div>
        <div class="cupic ae"><img src="../shop2015/upload/ever1.png"></div>
        <div class="detailed">
            <div class="font-1" style="display: none">礼物清单：${productModel.name}</div>
            <div class="font-2" style="display: none">价值：${productModel.price}元</div>
        </div>
    </div>
    <div class="gift-details ae">
        <div class="btb"><h5>礼物详情</h5></div>
        <a href="#" class="gift-c-d ae"><strong>${productModel.name}</strong><i class="sj-icon"></i></a>

        <div class="chandise ae">
            <div class="cha-pic"><img src="../shop2015/upload/seckill1.jpg"></div>
            <div class="cha-box">
                <strong>${productModel.product.subName}</strong>

                <div class="money">
                    <em>${productModel.price}</em>
                    <i>元</i>
                </div>
                <span class="add-sub"></span>
            </div>
        </div>
        <div class="elect">
            <div class="left">
                <input type="checkbox" class="add-c1" id="showGiftName">
                <span>显示礼物名称</span>
            </div>
            <div class="right">
                <input type="checkbox" class="add-c2" id="showGiftPrice">
                <span>显示礼物价格</span>
            </div>
        </div>
        <div class="bd cart-pay newcart-pay">
            <div class="btb"><h5>请选择支付方式</h5></div>
            <ul class="ul-list ae">
                <li><a href="#支付宝" title="支付宝" id="zhifubao" onclick="zhifubao(this)"><i class="icon icon-zfb"></i>支 付 宝</a>
                </li>
                <li><a href="#微信支付" title="微信支付" id="weixin" onclick="weixin(this)"><i class="icon icon-wechat"></i>微 信
                    支 付</a></li>
            </ul>
        </div>
        <div class="bd payment-total-bar newpayment-total-bar">
            <span class="txt">共${purchaseOrderProduct.purchaseAmount}件礼物，总金额${purchaseOrder.total}元</span>
            <a href="#btn-right" class="btn-right" onclick="submitOrder('${purchaseOrder.id}')">结&nbsp;算</a>
        </div>
    </div>
</div>
<script>

    var payment = "1";

    $().ready(function () {
        if (!isWeiXin()) {
            $("#weixin").hide();
        } else {
            $("#zhifubao").remove();
        }
    })


    function zhifubao(element) {
        $("#zhifubao").attr("style", "border:2px solid red");
        if (isWeiXin()) {
            $("#weixin").attr("style", "");
        }

        payment = "1";
    }

    function weixin(element) {
//    $(element).attr("class", "alipay wechat-active");
        $("#weixin").attr("style", "border:2px solid red");
        $("#zhifubao").attr("style", "");

//    $("#weixin").attr("class", "paymentActive");
//    $("#zhifubao").find("i").remove();
//    $(element).append('<i class="triangle" style="display: block"></i>')
        payment = "3";
    }

    function submitOrder(orderId) {
        $.ajax({
            type: 'post',
            async: false,
            url: '<c:url value="/order/checkInventory/${purchaseOrder.id}"/>',
            dataType: 'json',
            success: function (data) {
                if (data) {
                    if (consumerAddress == "") {
                        showAlert("提示", "请选择一个收货地址！");
                    } else {

                        var isweixin = "";

                        if (isWeiXin()) {
                            isweixin = "&isWeiXin=1";
                            payment = "3"
                        }

                        var url = "<c:url value="/order/confirm/"/>";
                        url += orderId + "?payment=" + payment + "&address=" + consumerAddress + "&message=" + message + isweixin;
                        window.location.href = url;
                    }
                } else {
                    showAlert("提示", "抱歉，该商品已售罄！")
                }
            },

        });

    }

</script>
</body>
</html>