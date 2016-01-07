<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
</head>
<body>
<!--//End--header-->
<div class="gift ae">
    <form>
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
                    <textarea id="giftMessage1" class="ae" maxlength="4"></textarea>
                    <span class="leaveword-num1"></span>

                    <div class="atext ae">
                        <a class="cancel">取&nbsp;消</a>
                        <a class="affirm" id="confirmGiftMessage1" onclick="addGaverName()">确&nbsp;认</a>
                    </div>
                </div>
                <!--//End-->
            </div>
            <!--//End-->
            <div class="hint"><input type="checkbox" id="showGiftName" onclick="giftNameStatus(this)">告诉Ta什么礼物</div>

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
                <div class="cha-pic"><img src="http://pro.efeiyi.com/${productModel.productModel_url}" height="90px"></div>
                <div class="cha-box">
                    <c:if test="${productModel.product.productModelList.size()==1}">
                        <strong>${productModel.name}</strong>
                    </c:if>
                    <c:if test="${productModel.product.productModelList.size()>1}">
                        <strong>${productModel.product.name}
                            <c:if test="${null!=productModel.name || ''!=productModel.name}">
                                [${productModel.name}]
                            </c:if>
                        </strong>
                    </c:if>
                    <p>${productModel.product.subName}</p>

                    <div class="money">
                        <em>${productModel.price}</em>
                        <i>元</i>
                        <i>X ${amount}</i>
                    </div>
                </div>
                <div class="bd order-total add-order-total">
                    <p id="btn-coupon"><strong>优惠券</strong><span id="yhq">0张券可用</span><a href="#arrow-right"
                                                                                         class="arrow-right"></a></p>

                    <p><strong>商品金额</strong><span><em>￥</em>${productModel.price*amount}</span></p>

                    <p><strong>优惠</strong><span id="couponPrice"><em>-￥</em>0</span></p>

                    <p><strong>运费</strong><span><em>￥</em>0</span></p>
                </div>
            </div>

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
                    <li class="add-btn1" id="weixin">
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
                <span class="txt" style="font-size: 16px;">总金额:<span id="change">${purchaseOrder.total}</span>元</span>
                <a href="#btn-right" class="btn-right btn-red" onclick="submitOrder('${purchaseOrder.id}')">结&nbsp;算</a>
            </div>

        </div>
    </form>
</div>
<div id="order-total" class="alert-delete yhq" style="display:none;">
    <div class="bd cart-coupons" style="position: fixed;">
        <div class="title">
            <h2>优惠券</h2>
        </div>
        <!--//ENd-->
        <ul class="ul-list" id="ul-list">
        </ul>

        <div class="bd">
            <a onclick="yhq();" class="cart-btn" id="yhq-btn" title="确定">确定</a>
        </div>
    </div>
    <div class="overbg"></div>
</div>

<script>

    var payment = "1";
    var gaverNameStats = "0";
    var totalPrice = $("#change").text();

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
            "status": status
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
                $(".edit-txt1").css({color: "#000"});
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
        $("#weixin").attr("class", "add-btn1");
        $("#zhifubao").attr("class", "");
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
        if (gaverName != "" && typeof gaverName != "undefined") {
            var success = function (data) {
                gaverNameStats = "1";
                $(".edit-txt2").css({color: "#000"});
                $(".edit-txt2").html(data)
                $(".edit-txt2").show();
                $("#addGaverName").hide();
            }
            ajaxRequest("<c:url value="/order/addGaverName.do"/>", {
                "purchaseOrderGiftId": "${purchaseOrder.id}",
                "gaverName": gaverName
            }, success, function () {
            }, "post");
        } else {
            $("#addGaverName").hide();
        }
    }

    $(function () {
        $.ajax({
            type: 'get',
            async: false,
            url: '<c:url value="/coupon/list/${purchaseOrder.id}"/>',
            dataType: 'json',
            data: {
                status: 1,
            },
            success: function (data) {
                if (data != null) {
                    var out = '';
                    $("#yhq").text(data.length + "张优惠券可用");
                    for (var i = 0; i < data.length; i++) {
                        out += '<li>' + '<input type="radio" name="radio"' + 'value="' + data[i]["couponBatch"]["price"] + '"' + 'id="cbox' + data[i]["id"] + '">';
                        if (data[i].couponBatch.type != null && data[i].couponBatch.type == 1) {
                            out += '<p>满' + data[i]["couponBatch"]["priceLimit"] + '元减' + data[i]["couponBatch"]["price"] + "元" + '</p>';
                        } else if (data[i].couponBatch.type != null && data[i].couponBatch.type == 2) {
                            out += '<p>' + data[i]["couponBatch"]["price"] + "元" + '</p>';
                        }
                        out += '<p>有效期：' + data[i]["couponBatch"]["startDateString"] + '至' + data[i]["couponBatch"]["endDateString"] + '</p>';
                        if (data[i].couponBatch.range != null && data[i].couponBatch.range == 1) {
                            out += '<p>适用范围：全网通用</p> </li>';
                        } else if (data[i].couponBatch.range != null && data[i].couponBatch.range == 2) {
                            out += '<p>适用范围：品类专用</p> </li>';
                        } else if (data[i].couponBatch.range != null && data[i].couponBatch.range == 3) {
                            out += '<p>适用范围：店铺专用</p> </li>';
                        } else if (data[i].couponBatch.range != null && data[i].couponBatch.range == 4) {
                            out += '<p>适用范围：单品专用</p> </li>';
                        }
                    }
                    $("#ul-list").html(out);
                }
            },
            error: function (data) {
                console.log(data);
            }

        });
    })

    function yhq() {
        var couponid = null;
        $("input:radio").each(function () {
            if (this.checked) {
                couponid = $(this).attr("id");
            }
        })
        var couponId = couponid.substring(4, couponid.length);
        $.ajax({
            type: 'post',
            async: false,
            url: '<c:url value="/coupon/use.do"/>',
            dataType: 'json',
            data: {
                couponId: couponId,
                orderId: "${purchaseOrder.id}"

            },
            success: function (data) {
                if (data == true) {
                    var t_price = parseFloat(totalPrice);
                    var chkobjs = document.getElementsByName("radio");
                    for (var i = 0; i < chkobjs.length; i++) {
                        if (chkobjs[i].checked) {
                            t_price = t_price - parseFloat(chkobjs[i].value);
                            $("#couponPrice").html("<em>-￥</em>"+chkobjs[i].value);
                        }
                    }
                    $("#change").text(t_price);
                    $("#order-total").hide();
                    $("body").css("overflow","scroll")
                }
            },

        });

    }

</script>
</body>
</html>