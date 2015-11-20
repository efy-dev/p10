<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <link type="text/css" rel="stylesheet" href="../shop2015/css/amazeui.min.css?v=20150831">
    <link type="text/css" rel="stylesheet" href="../shop2015/css/app.css?v=20150831">
    <link type="text/css" rel="stylesheet" href="../shop2015/css/myorder.css?v=20150831">
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
    <form action="<c:url value="/order/giftConfirm.do"/>" method="post">

        <input name="purchaseOrderId" value="${purchaseOrder.id}">

        <div class="btb"><h5>感谢您收下礼物，快填写您的收货信息吧！</h5></div>
        <ul class="profile ae">
            <li>
                <strong>收货人：</strong>
                <label class="label"><input name="receiveName" type="text" class="dtxt" placeholder="请填写收货人姓名"></label>
            </li>
            <li>
                <strong>手机号码：</strong>
                <label><input type="text" name="receivePhone" class="dtxt" placeholder="请填写手机号码"></label>
            </li>
            <li>
                <strong>配送地区：</strong>
                <label id="add-dext"><p type="text" class="dtxt" placeholder="">点击选择配送地区</p></label>

                <div class="add-ress" style="display: none">
                    <div class="add-text shipping-address ae">
                        <span>配送地区</span>
                        <select name="province.id" class="cars  am-selected am-dropdown am-selected-btn" required
                                id="province" onchange="provinceChange(this)">
                            <option value="">请选择省</option>
                        </select>
                        <select name="city.id" class="car1  am-selected am-dropdown am-selected-btn" required id="city">
                            <option value="">请选择市</option>
                        </select>
                        <%--<select  name="city.id" class="car1  am-selected am-dropdown am-selected-btn" required=""><option value="">请选择</option></select>--%>
                        <div class="addbqt"><a onclick="$('.add-ress').hide()" class="bqtn"
                                               value="确&nbsp;认&nbsp;选&nbsp;择"></a></div>
                    </div>
                    <div class="bg"></div>
                </div>
            </li>
            <li>
                <strong>详细地址：</strong>
                <label><input type="text" name="receiveDetail" class="dtxt add-dext" placeholder="填写具体街道、门牌号"></label>
            </li>
        </ul>
        <div class="btnq ae"><input type="submit" value="确&nbsp;认&nbsp;提&nbsp;交"></div>
    </form>
</div>

<script>

    $().ready(function () {
        ajaxRequest("<c:url value="/myEfeiyi/address/listProvince.do"/>", {}, function (data) {
            var out = '<option value="">请选择所在省市</option>';
            for (var i = 0; i < data.length; i++) {
                out += '<option value="' + data[i]["id"] + '">' + data[i]["name"] + '</option>';
            }
            $("#province").html(out);
        }, function () {
        }, "post")
    });

    function provinceChange(element) {
        var provinceId = $(element).val();
        ajaxRequest("<c:url value="/myEfeiyi/address/listCity.do"/>", {provinceId: provinceId}, function (data) {
            var out = '<option value="">请选择所在区县</option>';
            for (var i = 0; i < data.length; i++) {
                out += '<option value="' + data[i]["id"] + '">' + data[i]["name"] + '</option>';
            }
            $("#city").html(out);
        }, function () {
        }, "post")
    }

</script>
</body>
</html>