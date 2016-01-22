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
    <title>${purchaseOrder.giftGaverName}送您礼物了，快快点击去收礼吧</title>
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
            <div class="pic-img">
                <c:if test="${purchaseOrder.showGiftNameStatus=='1'}">
                   <a  href="<c:url value="/product/productModel/${purchaseOrder.purchaseOrderProductList.get(0).productModel.id}"/>">
                     <img src="http://pro.efeiyi.com/${purchaseOrder.purchaseOrderProductList.get(0).productModel.productModel_url}@!gift-card-picture" width="181">
                    </a>
                    </c:if>
                        <c:if test="${purchaseOrder.showGiftNameStatus=='0'}">
                        <a>
                            <img src="http://pro.efeiyi.com/${purchaseOrder.purchaseOrderProductList.get(0).productModel.productModel_url}@!gift-card-picture" width="181">
                        </a>
                            </c:if>
            </div>
            <div class="pic-text">
                <p>
                    <c:if test="${purchaseOrder.showGiftNameStatus=='1'}">
                        <a  href="<c:url value="/product/productModel/${purchaseOrder.purchaseOrderProductList.get(0).productModel.id}"/>" style="color: #000">
                                ${purchaseOrder.purchaseOrderProductList.get(0).productModel.product.name}
                        </a>
                    </c:if>

                        <c:if test="${purchaseOrder.showGiftNameStatus=='0'}">
                        <a  style="color: #000">
                            ${purchaseOrder.purchaseOrderProductList.get(0).productModel.product.name}
                        </a>
                        </c:if>
                </p>
                <p class="t2"><i></i><span>${purchaseOrder.purchaseOrderProductList.get(0).productModel.product.project.name}</span><em></em></p>
                <p class="t4">数量：<span>${purchaseOrder.purchaseOrderProductList.get(0).purchaseAmount}</span>个</p>
                <!--<p class="t3">朱炳仁</p>-->
            </div>
        </div>
        <c:if test="${not empty purchaseOrder.giftGaverName}">
        <div class="c-info ae" style="margin-top:0;">
            <p>${purchaseOrder.giftMessage}</p>
            <p>——${purchaseOrder.giftGaverName}</p>
        </div>
        </c:if>
    </div>
    <form action="<c:url value="/giftConfirm.do"/>" method="post" id="formId">
        <input name="purchaseOrderId" value="${purchaseOrder.id}" type="hidden">
        <div class="btb"><h5>
        <c:if test="${empty purchaseOrder.giftGaverName}">
            快填写您的收货信息吧！
        </c:if>
            <c:if test="${not empty purchaseOrder.giftGaverName}">
                ${purchaseOrder.giftGaverName}送您礼物了，快填写您的收货信息吧！
            </c:if></h5></div>
        <ul class="profile ae">
            <li>
                <strong>姓名：</strong>
                <label class="label"><input id = "name" name="receiveName" required="" type="text" class="dtxt" placeholder="请填写收货人姓名"></label>
            </li>
            <li>
                <strong>手机号码：</strong>
                <label><input name="receivePhone"  id= "phoneNumber" type="text" required="" class="dtxt" placeholder="请填写手机号码"></label>
            </li>
            <li>
                <strong>配送地区：</strong>
                <select  name="province.id" class="cars  am-selected am-dropdown am-selected-btn"
                         id="province" onchange="provinceChange(this)">
                    <%--<option value="110000">北京市</option>--%>
                </select>
                <select  name="city.id" class="car1  am-selected am-dropdown am-selected-btn" required="" id="city"><option value="">请选择</option></select>
                <%--<select  name="city.id" class="car1  am-selected am-dropdown am-selected-btn" required=""><option value="">请选择</option></select>--%>
            </li>
            <li>
                <strong>详细地址：</strong>
                <label><input type="text" class="dtxt add-dext"  name="receiveDetail" id = "addressDetail"  placeholder="填写具体街道、门牌号"></label>

            </li>
        </ul>
        <div class="btnq ae"><input type="button" value="确&nbsp;认" onclick="check()"></div>
        <div class="efi-icon ae"><i class="icon"></i></div>
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
    function check() {
        var name=$("#name").val();
        var phoneNumber=$("#phoneNumber").val();
        var addressDetail = $("#addressDetail").val();
        var province = $("#province").val();
        var city = $("#city").val();
        var success = function (data) {
            if (!data) {
                showAlert("提示", "非法输入");
            }else{
                $("#formId").submit();
            }
        }
        if(name=="" || phoneNumber=="" || addressDetail==""||province==""||city==""){
            showAlert("提示", "您填写的信息不完整");
        }else{
            ajaxRequest("<c:url value="/giftReceive/checkAddress.do"/>", {
                "addressDetail": addressDetail,
            }, success, function () {
            }, "post");
//            if(reg.test(email)){
//                $("#personalInfo").submit();
//                $("#yx").html("");
//                $("#tj").html("");
//
//            }else{
//                $("#yx").html("您的邮箱格式不正确");
//                $("#tj").html("");
//            }

        }

    }

//        if(addressDetail==""){
//            alert("您的信息不完整");
////            $("#tj").html("您填写的信息不完整");
//        }else{
//            if(reg.test(addressDetail)){
//
//            }else{
//                alert("非法字符");
//            }
//
//        }


</script>
</body>
</html>