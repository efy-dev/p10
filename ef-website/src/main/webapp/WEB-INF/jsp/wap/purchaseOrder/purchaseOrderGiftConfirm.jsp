<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
</head>
<body>
<!--//End--header-->
<div class="gift ae">
    <div class="card custom ae ">
        <div class="btb"><h5>礼物卡片</h5></div>
        <div class="ae imgb">
            <img src="http://pro.efeiyi.com/${productModel.productModel_url}" style="width: 100%;">
        </div>
        <!--//End-->
        <div class="edit-text">
            <div class="edit-txt1">点击此处即可编辑祝福语</div>
            <!--//End-->
            <div style="display: none" id="addMessage" class="add-cart">
                <textarea id="giftMessage" class="ae" maxlength="50"></textarea>
                <span id="leaveword-num" class="leaveword-num1"><em>50</em>/50</span>

                <div class="atext ae">
                    <a class="cancel">取&nbsp;消</a>
                    <a class="affirm" id="confirmGiftMessage" onclick="updateGiftMessage()">确&nbsp;认</a>
                </div>
            </div>
            <!--//End-->
        </div>
        <div class="edit-text">
            <div class="edit-txt2">送礼人姓名</div>
            <!--//End-->
            <div style="display: none" id="addGaverName" class="add-cart">
                <textarea id="giftMessage1" class="ae" maxlength="50"></textarea>
                <span class="leaveword-num1"></span>

                <div class="atext ae">
                    <a class="cancel">取&nbsp;消</a>
                    <a class="affirm" id="confirmGiftMessage1" onclick="addGaverName()">确&nbsp;认</a>
                </div>
            </div>
            <!--//End-->
        </div>
        <!--//End-->


        <div class="detailed">
            <div class="font-1" style="display: none">礼物清单：安格尔-公爵夫人像</div>
            <div class="font-2" style="display: none">价值：5000000元</div>
        </div>

    </div>
    <div class="gift-details ae">
        <%--<div class="btb"><h5>礼物详情</h5></div>--%>
        <%--<a class="gift-c-d ae"><strong>${productModel.name}</strong><i class="sj-icon"></i></a>--%>

        <%--<div class="chandise ae">--%>
        <%--<div class="cha-pic"><img src="http://pro.efeiyi.com/${productModel.productModel_url}"></div>--%>
        <%--<div class="cha-box">--%>
        <%--<strong>${productModel.product.subName}</strong>--%>

        <%--<div class="money">--%>
        <%--<em>${productModel.price}</em>--%>
        <%--<i>元</i>--%>
        <%--</div>--%>
        <%--<span class="add-sub"></span>--%>
        <%--</div>--%>
        <%--</div>--%>

        <div class="btb"><h5>礼物详情</h5></div>
        <div class="chandise ae">
            <div class="cha-pic"><img src="http://pro.efeiyi.com/${productModel.productModel_url}"></div>
            <div class="cha-box">
                <c:if test="${productModel.product.productModelList.size()==1}">
                <strong>${productModel.name}</strong>
                </c:if>
                <c:if test="${productModel.product.productModelList.size()>1}">
                    <strong>${productModel.product.name}[${productModel.name}]</strong>
                </c:if>
                <p>${productModel.product.subName}</p>

                <div class="money">
                    <em>${productModel.price}</em>
                    <i>元</i>
                </div>
            </div>
        </div>

        <%--<div class="bd cart-pay newcart-pay">--%>
        <%--<div class="btb"><h5>请选择支付方式</h5></div>--%>
        <%--<ul class="ul-list ae">--%>
        <%--<li><a href="#支付宝" title="支付宝" id="zhifubao1" onclick="zhifubao(this)"><i class="icon icon-zfb"></i>支 付--%>
        <%--宝</a>--%>
        <%--</li>--%>
        <%--<li><a href="#微信支付" title="微信支付" id="weixin1" onclick="weixin(this)"><i class="icon icon-wechat"></i>微 信--%>
        <%--支 付</a></li>--%>
        <%--</ul>--%>
        <%--</div>--%>
        <%--<div class="bd payment-total-bar newpayment-total-bar">--%>
        <%--<span class="txt">共${purchaseOrderProduct.purchaseAmount}件礼物，总金额${purchaseOrder.total}元</span>--%>
        <%--<a href="#btn-right" class="btn-right" onclick="submitOrder('${purchaseOrder.id}')">结&nbsp;算</a>--%>
        <%--</div>--%>

        <div class="bd cart-pay newcart-pay new-yierqiu">
            <div class="btb"><h5>请选择支付方式</h5></div>
            <ul class="ul-list ae">
                <li class="add-btn1" id="zhifubao"><a href="#支付宝" onclick="zhifubao(this)" title="支付宝">
                    <i class="icon icon-zfb"></i>

                    <div class="zfb-page">
                        <p>支付宝支付</p>

                        <p>推荐有支付宝账号的用户使用</p>
                    </div>
                    <span class="add-zfb"></span>
                </a></li>
                <li id="weixin">
                    <a href="#微信支付" onclick="weixin(this)" title="微信支付">
                        <i class="icon icon-wechat"></i>

                        <div class="zfb-page">
                            <p>微信支付</p>

                            <p>推荐安装微信5.0及以上的版本使用</p>
                        </div>
                        <span class="add-zfb"></span>
                    </a>
                </li>
            </ul>
        </div>
        <div class="bd payment-total-bar newpayment-total-bar">
            <span class="txt">共一件礼物，总金额${purchaseOrder.total}元</span>
            <a href="#btn-right" class="btn-right btn-red" onclick="submitOrder('${purchaseOrder.id}')">结&nbsp;算</a>
        </div>

    </div>
</div>
<script>

    var payment = "1";
    var gaverNameStats = "0"

    function giftNameStatus(element) {
        var status = ""
        if (element.checked == true) {
            status = "1"
        } else {
            status = "0"
        }
        var success = function (data) {
            if (!data) {
                showAlert("提示", "修改状态失败");
                $(element).attr("checked", false);
            }
        }
        ajaxRequest("<c:url value="/order/giftBuy/showNameStatus.do"/>", {
            "purchaseOrderId": "${purchaseOrder.id}",
            "nameStatus": status
        }, success, function () {
        }, "post");
    }

    function giftPriceStatus(element) {
        var status = ""
        if (element.checked == true) {
            status = "1"
        } else {
            status = "0"
        }
        var success = function (data) {
            if (!data) {
                showAlert("提示", "修改状态失败");
                $(element).attr("checked", false);
            }
        }
        ajaxRequest("<c:url value="/order/giftBuy/showPriceStatus.do"/>", {
            "purchaseOrderId": "${purchaseOrder.id}",
            "priceStatus": status
        }, success, function () {
        }, "post");
    }

    function updateGiftMessage() {
        var message = $("#giftMessage").val();
        if (message != "") {
            var success = function (data) {
                console.log("保存成功");
                $(".edit-txt1").html(data)
                $(".edit-txt1").show();
                $("#addMessage").hide();
            }
            ajaxRequest("<c:url value="/order/giftBuy/saveOrUpdateGiftMessage.do"/>", {
                "purchaseOrderId": "${purchaseOrder.id}",
                "giftMessage": message
            }, success, function () {
            }, "post");
        }
    }


    $().ready(function () {
//
//        $('#slider').flexslider('pause');
//        $("#confirmGiftMessage").click(function () {
//            updateGiftMessage();
//        });

        if (!isWeiXin()) {
            $("#weixin").hide();
            payment = 1;
        } else {
            $("#zhifubao").remove();
            payment = 3;
        }
    })


    function zhifubao(element) {
        $("#zhifubao").attr("class", "add-btn1");
//        if (isWeiXin()) {
        $("#weixin").attr("class", "");
//        }

        payment = "1";
    }

    function weixin(element) {
//    $(element).attr("class", "alipay wechat-active");
        $("#weixin").attr("class", "add-btn1");
        $("#zhifubao").attr("class", "");

//    $("#weixin").attr("class", "paymentActive");
//    $("#zhifubao").find("i").remove();
//    $(element).append('<i class="triangle" style="display: block"></i>')
        payment = "3";
    }

    function getCurrentImg() {

        var imgId = "";

        var elements = $("ol").find("li");

        for (var i = 0; i < elements.length; i++) {
            var clazz = $($(elements[i]).find("a")).attr("class");
            if (clazz == "am-active") {
                imgId = $($(elements[i]).find("a")).html()
            }
//            if(elements.find("a").html()=="1"){
//                imgId = "1";
//            }else if (elements.find("a").html()=="2"){
//                imgId = "2";
//            }else if (elements.find("a").html()=="3"){
//                imgId = "3"
//            }else if (elements.find("a").html()=="4"){
//                imgId = "4";
//            }
        }
        return $("#" + imgId).attr("src");
    }

    function submitOrder(orderId) {

        if (gaverNameStats == "0") {
            showAlert("提示", "请填写送礼人姓名！");
        } else {


            ajaxRequest("<c:url value="/order/giftBuy/updateImg.do"/>", {
                "imageUrl": getCurrentImg(),
                "purchaseOrderId": "${purchaseOrder.id}"
            }, function () {
                $.ajax({
                    type: 'post',
                    async: false,
                    url: '<c:url value="/order/checkInventory/${purchaseOrder.id}"/>',
                    dataType: 'json',
                    success: function (data) {
                        if (data) {
                            var isweixin = "";

                            if (isWeiXin()) {
                                isweixin = "&isWeiXin=1";
                                payment = "3"
                            }

                            var url = "<c:url value="/order/confirm/"/>";
                            url += orderId + "?payment=" + payment + "&message=" + isweixin + "&imageUrl=" + getCurrentImg();
                            window.location.href = url;
                        } else {
                            showAlert("提示", "抱歉，该商品已售罄！")
                        }
                    },

                });
            }, function () {
            }, "post");
        }
    }

    function addGaverName() {
        var gaverName = $("#giftMessage1").val();
        var success = function (data) {
            gaverNameStats = "1";
            $(".edit-txt2").html(data)
            $(".edit-txt2").show();
            $("#addGaverName").hide();
        }
        ajaxRequest("<c:url value="/order/addGaverName.do"/>", {
            "purchaseOrderGiftId": "${purchaseOrder.id}",
            "gaverName": gaverName
        }, success, function () {
        }, "post");
    }
</script>
</body>
</html>