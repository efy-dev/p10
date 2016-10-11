<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
    <title>确认订单</title>
    <style>
        .acd {
            background: #fff !important;
            color: #000 !important;
            border: 1px solid #000 !important;
        }

        .add-btn {
            background: #fff;
            height: 3rem;
            width: 100%;
            border: 1px solid #000;
            color: #000;
            display: block;
            font-size: 1.2rem
        }

        .add-address {
            width: 100%;
            line-height: 3rem;
            height: 3rem;
            text-align: center;
            border: 1px solid #000;
            display: block;
            color: #fff;
            font-size: 1.2rem;
            background: #000;
        }

        .add-ress-icon {
            width: 1.5rem;
            height: 1.5rem;
            position: absolute;
            right: -29px;
            top: 8px;
            display: block;
            background: url("<c:url value="/scripts/wap/images/myorderps.png"/>") no-repeat;
        }
    </style>
</head>
<body>
<!--//End--header-->
<article class="bd shop-cart">
    <div class="bd cart-order">
        <div class="bd order-address" id="order-add">
            <c:if test="${addressList.size() > 0}">
                <c:forEach items="${addressList}" var="address">
                    <c:if test="${address.status=='2'}">
                        <a href="#btn-edit-addres" class="btn-edit-addres">
                            <p id="hiddenId" hidden>${address.id}</p>

                            <p class="title"><span>${address.consignee}</span><span>${address.phone}</span></p>

                            <p class="txt">${address.province.name}${address.city.name}${address.district.name}${address.details}</p>
                            <a href="#arrow-right" class="arrow-right"></a>
                        </a>
                    </c:if>
                </c:forEach>
                <%--<c:if test="<%=!b%>">--%>
                    <%--<a href="#btn-edit-addres" class="btn-edit-addres">请选择一个地址</a>--%>
                <%--</c:if>--%>
            </c:if>
            <c:if test="${addressList.size() == 0}">
                <a href="#btn-edit-addres" class="btn-edit-addres"
                   style="color: #0000FF;font-size: 1.6rem;float: right">添加收货地址</a>
            </c:if>
        </div>
        <div class="bd order-address" id="order-add1" style="display: none">
            <a href="#btn-edit-addres" class="btn-edit-addres">
                <p class="title"><span id="span1">${address.consignee}</span><span id="span2">${address.phone}</span></p>
                <p class="txt" id="txt">${address.province.name}${address.city.name}${address.district.name}${address.details}</p>
                <a href="#arrow-right" class="arrow-right"></a>
            </a>
        </div>
        <c:forEach items="${tenantList}" var="tenant">
            <div class="bd order-list">
                <div class="title">${tenant.name}</div>
                <ul class="ul-list">
                    <c:forEach items="${productMap.get(tenant.id)}" var="product">
                        <li>
                            <c:if test="${product.productModel.product.type!=3}">

                                <img class="img" src="http://pro.efeiyi.com/${product.productModel.productModel_url}"
                                     alt="">

                            </c:if>
                            <c:if test="${product.productModel.product.type==3}">

                                <img class="img" src="${product.productModel.productModel_url}"
                                     alt="">

                            </c:if>
                            <div class="bd info">
                                <p class="text">${product.productModel.product.name}
                                    <c:if test="${product.productModel.product.productModelList.size()>1}">
                                        [${product.productModel.name}]
                                    </c:if>
                                </p>

                                <p class="price"><em>￥</em><span>${product.purchasePrice}</span></p>

                                <p class="num"><i class="iocn-x"></i><strong>${product.purchaseAmount}</strong></p>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
                <div class="bd ask"><textarea name="message" id="${tenant.id}Message" cols="30" rows="4"
                                              placeholder="给卖家留言(如需开具发票，请在此输入开票信息)"></textarea></div>
            </div>
        </c:forEach>
        <c:if test="${null != consumer.balance && 0<consumer.balance}">
            <div class="balance"><input type="checkbox" id="balanceCheckbox" onclick="useBalance(this);">使用余额支付<span
                    id="usefulBalance"><c:if
                    test="${consumer.balance>purchaseOrder.total}">${purchaseOrder.total}</c:if><c:if
                    test="${consumer.balance<=purchaseOrder.total}">${consumer.balance}</c:if></span>元
            </div>
        </c:if>
        <div class="bd order-total">
            <p><strong>商品金额</strong><span><em>￥</em><em id="totalPrice">${purchaseOrder.total}</em></span></p>
            <p><strong>余额</strong><span> <em>-￥</em><em id="balance">0.00</em></span></p>
        </div>

    </div>
</article>

<div class="gift ae">
    <div class="gift-details ae">
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
            <span class="txt">总金额<span id="change">${purchaseOrder.total+freight}</span>元</span>
            <a href="#btn-right" class="btn-right btn-red" onclick="submitOrder('${purchaseOrder.id}')">结&nbsp;算</a>
        </div>

    </div>
</div>

<!--Start--弹出地址-->
<div id="order-address" class="alert-delete or-address" style="display:none;">
    <div class="bd cart-address">
        <div class="bd list-adress" id="list-order">
            <ul class="ul-list" id="address">
                <c:forEach items="${addressList}" var="address">

                    <li class="cart-btn acd"
                        onclick="chooseAddress('${address.id}','${address.consignee}','${address.phone}','${address.province.name}','${address.city.name}','${address.district.name}','${address.details}')">
                        <p class="bd title">${address.consignee} ${address.phone}</p>

                        <p class="bd des">${address.province.name}${address.city.name}${address.district.name}${address.details}</p>

                        <p class="bd btns">
                                <%--<input type="radio" name="address" id="address" onclick="chooseAddress('${address.id}','${address.consignee}','${address.phone}','${address.province.name}','${address.details}')">--%>
                        </p>
                    </li>
                    <br>
                </c:forEach>
            </ul>
            <div class="bd">
                <a href="#" style="color:white " id="add" class="add-address" onclick="addAddress()" title="新增收货地址">新增收货地址</a>
            </div>
        </div>
        <div class="bd list-adress" id="adddiv" style="display: none;">
            <div class="pop-up" style="position: relative">
                <a class="add-ress-icon" href="#" onclick="closeAll()"></a>

                <div class="pop-h">新增收货人信息
                    <i class="clase" title="关闭"></i>
                </div>
                <div class="m-form">
                    <form id="newAddress" style="height:276px;overflow-y:scroll" method="post"
                          class="am-form">

                        <input type="hidden" name="productModel" value="${productModel.id}">
                        <c:if test="${amount != null}">
                            <input type="hidden" name="amount" value="${amount}">
                        </c:if>
                        <input type="hidden" name="callback" value="${callback}">
                        <input type="hidden" name="groupProductId" value="${groupProductId}">

                        <div class="am-form-group">
                            <label>收货人</label>
                            <input type="text" class="txt" name="consignee" value="" required>
                        </div>
                        <div class="am-form-group">
                            <label>手机号</label>
                            <input type="text" class="txt" name="phone" value="" size="11" maxlength="11" required>
                        </div>
                        <div class="am-form-group">
                            <label>所在地区</label>
                            <select id="provinceVal" class="cars" name="province.id" onchange="provinceChange(this);"
                                    required>
                            </select>
                            <select id="cityVal" class="car1" name="city.id" onchange="cityChange(this);" required>
                            </select>
                            <select id="districtVal" class="car1" name="district.id" required>
                            </select>
                        </div>
                        <div class="am-form-group">
                            <label>具体地址</label>
                            <textarea name="details" id="doc-vld-ta-2-1" class="text-act" required></textarea>
                        </div>
                        <input type="hidden" name="cartId" value="${cart.id}">
                        <label></label>

                        <p>
                            <button onclick="submitNewAddress()" type="button" class="am-btn am-btn-default add-btn">
                                保存收货人信息
                            </button>
                            <input type="reset" id="reset" style="display: none">
                        </p>
                        <span id="ts" style="border: 0"></span>
                    </form>
                </div>
                <div class="sh-bg"></div>
            </div>
        </div>
    </div>
    <div class="overbg"></div>
</div>
<!--//End--弹出地址-->

<script>
    var payment = "1";
    var consumerAddress = $("#hiddenId").text();
    var totalPrice = $("#totalPrice").text();
    var orderId = "${purchaseOrder.id}";

    $(function () {

        ajaxRequest("<c:url value="/myEfeiyi/address/listProvince.do"/>", {}, function (data) {
            var out = '<option value="">请选择所在省市</option>';
            var out1 = "";
            for (var i = 0; i < data.length; i++) {
                out += '<option value="' + data[i]["id"] + '">' + data[i]["name"] + '</option>';
                out1 += '<option value="' + data[i]["id"] + '">' + data[i]["name"] + '</option>';
            }
            $("#province").html(out);
            $("#provinceVal").html(out1);
        }, function () {
        }, "post");

        if (!isWeiXin()) {
            $("#weixin").hide();
        } else {
            $("#zhifubao").remove();
        }

    });

    function submitNewAddress() {
        var consignee = $(":input[name='consignee']").val();
        var phone = $(":input[name='phone']").val();
        var details = $(":input[name='details']").val();
        if (consignee == "" || phone == "" || details == "") {
            $("#ts").text("请完善您的新增地址");
        } else {
            var param = $("#newAddress").serialize();

            var success = function (data) {
//                window.location.href=window.location.href;
                var html = newAddress(data);
                $("#address").append(html);
                $(".active-pop").hide();
                $("#reset").click();
                $("#order-address").hide();
                $("#adddiv").hide();
                $("#list-order").show();
                $("#" + data.id).click();
            }
            ajaxRequest("<c:url value="/order/addAddress.do"/>", param, success, function () {
            }, "post")
        }
    }

    //打开添加收货地址的弹窗
    function addAddress() {
        $("#adddiv").attr("style", "display:block;background: #fff;z-index:9999;width: 90%;left: 5%");
        $("#list-order").attr("style", "display:none");
    }

    //关闭弹出的窗口
    function closeAll() {
        $(".or-address").attr("style", "display:none");
        $("#adddiv").attr("style", "display:none");
        $("#list-order").attr("style", "");
    }

    //支付宝支付
    function zhifubao(element) {
        $("#zhifubao").attr("class", "add-btn1");
//        if (isWeiXin()) {
        $("#weixin").attr("class", "");
//        }

        payment = "1";
    }

    //微信支付
    function weixin(element) {
        $("#weixin").attr("class", "add-btn1");
        $("#zhifubao").attr("class", "");
        payment = "3";
    }

    function submitOrder(orderId) {
        var messageObject = new Object();
        var balance = $("#balance").text();
        var couponId = "";
        var freight = $("#freight").text();
        $("input:radio").each(function () {
            if (this.checked) {
                var couponid = $(this).attr("id");
                couponId = couponid.substring(4, couponid.length);
            }
        });
        $("textarea[name=message]").each(function () {
            messageObject[$(this).attr("id")] = $(this).val();
        });
        var message1 = "";
        for (var key in messageObject) {
            message1 += key + ":" + messageObject[key] + ";"
        }
        var message = encodeURIComponent(message1);
        $.ajax({
            type: 'post',
            async: false,
            url: '<c:url value="/order/checkInventory/${purchaseOrder.id}"/>',
            dataType: 'json',
            success: function (data) {
                <c:if test="${purchaseOrder.orderType=='2'}">
                data = true;
                </c:if>
                if (data) {
                    if (consumerAddress == "") {
                        showAlert("提示", "请选择一个收货地址！");
                    } else {
                        $.ajax({
                            type: 'post',
                            async: false,
                            url: '<c:url value="/order/checkBalance"/>' + '?balance=' + balance,
                            dataType: 'json',
                            success: function (data1) {
                                if (data1) {
                                    var isweixin = "";

                                    if (isWeiXin()) {
                                        isweixin = "&isWeiXin=1";
                                        payment = "3"
                                    }

                                    var url = "<c:url value="/order/confirm/"/>";
                                    url += orderId + "?payment=" + payment + "&address=" + consumerAddress + "&message=" + message + isweixin + "&balance=" + balance + "&couponId=" + couponId + "&freight=" + freight;
                                    window.location.href = url;
                                } else {
                                    showAlert("提示", "抱歉，余额不足！");
                                }
                            }
                        });


                    }
                } else {
                    showAlert("提示", "抱歉，该商品已售罄！")
                }
            },

        });

    }

    $(function () {
        $('.clearing-site span a').click(function () {
            $(this).siblings('.active-pop').show();
            $('.clase, .sh-bg').click(function () {
                $(this).parents('.active-pop').hide();
            })
            return false;
        })

        //网页加载的时候把城市的数据取回来
        ajaxRequest("<c:url value="/myEfeiyi/address/listProvince.do"/>", {}, function (data) {
            var out = '<option value="">请选择</option>';
            for (var i = 0; i < data.length; i++) {
                out += '<option value="' + data[i]["id"] + '">' + data[i]["name"] + '</option>';
            }
            $("#province").html(out);
        }, function () {
        }, "post")

    })

    //新收货地址的模板
    function newAddress(it) {
        var out2 = '<li id="' + it.id + '" class="cart-btn acd" onclick="chooseAddress(\'' + it.id + '\',\'' + it.consignee + '\',\'' + it.phone + '\',\'' + it.province.name + '\',\'' + it.city.name + '\',\'' + it.district.name + '\',\'' + it.details + '\')"><p class="bd title">' + it.consignee + '  ' + it.phone + '</p><p class="bd des">' + it.province.name + it.city.name + it.details + '</p><p class="bd btns"></p></li><br>';
        return out2;
    }

    //选择收货地址
    function chooseAddress(addressId, consignee, phone, province, city, district, details) {
        consumerAddress = addressId;
        var conConsignee = consignee;
        var conPhone = phone;
        var conProvince = province;
        var conCity = city;
        var conDistrict = district;
        var conDetails = details;

        console.log(consumerAddress);
        $("#order-add").attr("style", "display:none");
        $("#order-add1").attr("style", "display:block");
        $("#span1").text(conConsignee);
        $("#span2").text(conPhone);
        $("#txt").text(conProvince + conCity + conDistrict + conDetails);

        $.ajax({
            type: 'post',
            async: false,
            url: '<c:url value="/order/getFreight.do"/>',
            dataType: 'json',
            data: {
                addressId: addressId,
                purchaseOrderId: orderId,

            },
            success: function (data) {
                $("#freight").text(data);
                var couponPrice = $("#couponPrice").text();
                var totalPrice = $("#totalPrice").text();
                var finalPrice = parseFloat(totalPrice - couponPrice) + parseFloat(data);
                //$("#change").html(finalPrice.toFixed(2));
                if (finalPrice < parseFloat(${consumer.balance})) {
                    $("#usefulBalance").html(finalPrice.toFixed(2));
                    if ($("#balanceCheckbox").is(':checked') == true) {
                        $("#balance").html(finalPrice.toFixed(2));
                        $("#change").html("0.00");
                    } else {
                        $("#balance").html("0.00");
                        $("#change").html(finalPrice.toFixed(2));
                    }
                } else {
                    $("#usefulBalance").html((${consumer.balance}).toFixed(2));
                    if ($("#balanceCheckbox").is(':checked') == true) {
                        $("#balance").html((${consumer.balance}).toFixed(2));
                        var finalPrice1 = finalPrice - ${consumer.balance};
                        $("#change").html(finalPrice1.toFixed(2));
                    } else {
                        $("#balance").html("0.00");
                        $("#change").html(finalPrice.toFixed(2));
                    }
                }
            },

        });

    }

    $(function () {
        $("#add").click(function () {
            $(this).siblings('.active-pop').show();
            province();
            $('.my-order .clase, .my-order .sh-bg').click(function () {
                $(this).parents('.active-pop').hide();
            })
            return false;
        })
    });

    $(function () {
        $(".hideDiv").click(function () {
            $(this).siblings('.active-pop').show();
            $('.my-order .clase, .my-order .sh-bg').click(function () {
                $(this).parents('.active-pop').hide();
            })
            return false;
        });
    });

    function provinceChange(element) {
        var provinceId = $(element).val();
        ajaxRequest("<c:url value="/myEfeiyi/address/listCity.do"/>", {provinceId: provinceId}, function (data) {
            var out = '<option value="">请选择所在市</option>';
            for (var i = 0; i < data.length; i++) {
                out += '<option value="' + data[i]["id"] + '">' + data[i]["name"] + '</option>';
            }
            $("#city").html(out);
            $("#cityVal").html(out);
        }, function () {
        }, "post")
    }

    function cityChange(element) {
        var cityId = $(element).val();
        ajaxRequest("<c:url value="/myEfeiyi/address/listDistrict.do"/>", {cityId: cityId}, function (data) {
            var out = '<option value="">请选择所在区县</option>';
            for (var i = 0; i < data.length; i++) {
                out += '<option value="' + data[i]["id"] + '">' + data[i]["name"] + '</option>';
            }
            $("#district").html(out);
            $("#districtVal").html(out);
        }, function () {
        }, "post")
    }

    //使用余额
    function useBalance(element) {
        var totalPrice = $("#totalPrice").text();
        var couponPrice = $("#couponPrice").text();
        var balance = $("#usefulBalance").text();
        var freight = $("#freight").text();
        if ($(element).is(':checked') == true) {
            $("#balance").html(balance);
            var change = parseFloat(totalPrice - balance - couponPrice) + parseFloat(freight);
            $("#change").html(change.toFixed(2));
        } else if ($(element).is(':checked') == false) {
            $("#balance").html("0.00");
            var change = parseFloat(totalPrice - couponPrice) + parseFloat(freight);
            $("#change").html(change.toFixed(2));
        }
    }

    <c:forEach items="${addressList}" var="address">
    chooseCity($("${address.id}"), "${address.province.id}", "${address.city.id}", "${address.id}");
    </c:forEach>


</script>
</body>
</html>