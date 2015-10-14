<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        .add-ress-icon{width: 1.5rem;height: 1.5rem;position:absolute;right: -29px;top:8px;display: block;background: url("<c:url value="/scripts/wap/images/myorderps.png"/>")no-repeat;}
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

                            <p class="txt">${address.province.name}${address.city.name}${address.details}</p>
                            <a href="#arrow-right" class="arrow-right"></a>
                        </a>
                    </c:if>
                </c:forEach>
            </c:if>
            <c:if test="${addressList.size() == 0}">
            <a href="#btn-edit-addres" class="btn-edit-addres" style="color: #0000FF;font-size: 1.6rem;float: right">添加收货地址</a>
            </c:if>
        </div>
        <div class="bd order-address" id="order-add1" style="display: none">
            <a href="#btn-edit-addres" class="btn-edit-addres">
                <p class="title"><span id="span1">${address.consignee}</span><span id="span2">${address.phone}</span>
                </p>

                <p class="txt" id="txt">${address.province.name}${address.city.name}${address.details}</p>
                <a href="#arrow-right" class="arrow-right"></a>
            </a>
        </div>
        <c:forEach items="${tenantList}" var="tenant">
            <div class="bd order-list">
                <div class="title">${tenant.name}</div>
                <ul class="ul-list">
                    <c:forEach items="${productMap.get(tenant.id)}" var="product">
                        <c:if test="${product.isChoose==1}">
                            <li>
                                <img class="img" src="http://pro.efeiyi.com/${product.productModel.productModel_url}"
                                     alt="">

                                <div class="bd info">
                                    <p class="text">${product.productModel.name}
                                        <c:if test="${product.productModel.productPropertyValueList.size()>1}">
                                            [
                                            <c:forEach items="${product.productModel.productPropertyValueList}"
                                                       var="ppv">${ppv.projectPropertyValue.value}</c:forEach>
                                            ]
                                        </c:if>
                                    </p>

                                    <p class="price"><em>￥</em><span>${product.productModel.price}</span></p>

                                    <p class="num"><i class="iocn-x"></i><strong>${product.amount}</strong></p>
                                </div>
                            </li>
                        </c:if>
                    </c:forEach>
                </ul>
                <div class="bd ask"><textarea name="message" id="${tenant.id}Message" cols="30" rows="4"
                                              placeholder="给卖家留言(如需开具发票，请在此输入开票信息)"></textarea></div>
            </div>
        </c:forEach>

        <!-- //End--order-list-->
        <div class="bd order-total">
            <p><strong>优惠券</strong><span class="btn-coupons" id="yhq">0张券可用</span><a href="#arrow-right"
                                                                                     class="arrow-right"></a></p>

            <p><strong>商品金额</strong><span><em>￥</em>${cart.totalPrice.floatValue()}</span></p>

            <p><strong class="grey">返现</strong><span><em>￥</em>0.00</span></p>

            <p><strong>运费</strong><span><em>￥</em>0.00</span></p>
        </div>
        <!-- //End--order-total-->
        <div class="bd cart-pay">
            <div class="title">请选择支付方式</div>
            <ul class="ul-list">
                <li><a id="zhifubao" onclick="zhifubao(this)" title="支付宝" style="border: 2px solid red"><i
                        class="icon icon-zfb"></i>支 付 宝</a></li>
                <li><a id="weixin" onclick="weixin(this)" title="微信支付"><i class="icon icon-wechat"></i>微 信 支 付</a></li>
            </ul>
        </div>
    </div>
    <!-- //End--cart-order-->
    <div class="bd payment-total-bar">
        <span>总计付款</span>
    <span class="txt" id="change" style="float: none">
        ${cart.totalPrice}</span>
        <span>元</span>
        <a onclick="submitOrder('${purchaseOrder.id}')" class="btn-right">提交订单</a>
    </div>
</article>


<!--Start--弹出地址-->
<div id="order-address" class="alert-delete or-address" style="display:none;">
    <div class="bd cart-address" style="width: 90%;left: 5%;overflow: scroll;top: 2%">
        <div class="bd list-adress" id="list-order">
            <ul class="ul-list">
                <c:forEach items="${addressList}" var="address">

                    <li class="cart-btn acd"
                        onclick="chooseAddress('${address.id}','${address.consignee}','${address.phone}','${address.province.name}','${address.city.name}','${address.details}')">
                        <p class="bd title">${address.consignee} ${address.phone}</p>

                        <p class="bd des">${address.province.name}${address.city.name}${address.details}</p>

                        <p class="bd btns">
                                <%--<input type="radio" name="address" id="address" onclick="chooseAddress('${address.id}','${address.consignee}','${address.phone}','${address.province.name}','${address.details}')">--%>
                        </p>
                    </li>
                    <br>
                </c:forEach>
            </ul>
            <div class="bd">
                <a href="#" id="add" class="add-address" onclick="add_Address()" title="新增收货地址">新增收货地址</a>
            </div>
        </div>
        <div class="bd list-adress" id="adddiv" style="display: none;">
            <div class="pop-up" style="position: relative">
                <a class="add-ress-icon" href="#" onclick="closeAll()"></a>
                <div class="pop-h">新增收货人信息
                    <i class="clase" title="关闭"></i>
                </div>
                <div class="m-form">
                    <form id="addAddress" action="<c:url value="/myEfeiyi/addAddressOfMob1.do"/>" method="post"
                          class="am-form">

                        <input type="hidden" name="productModel" value="${productModel.id}">

                        <div class="am-form-group">
                            <label>收货人</label>
                            <input type="text" class="txt" name="consignee" value="" required>
                        </div>
                        <div class="am-form-group">
                            <label>手机号</label>
                            <input type="text" class="txt" name="phone" value="" size="11" maxlength="11">
                        </div>
                        <div class="am-form-group">
                            <label>所在地区</label>
                            <select id="provinceVal" class="cars" name="province.id"
                                    onclick="province(this);" required>
                            </select>
                            <select id="cityVal" class="car1" name="city.id" onclick="city(this);" required>
                            </select>
                        </div>
                        <div class="am-form-group">
                            <label>具体地址</label>
                            <textarea name="details" id="doc-vld-ta-2-1" class="text-act" required></textarea>
                        </div>
                        <%--<div class="am-form-group">
                            <p>
                                <input type="checkbox" id="checkbox" onclick="putVal(this);" name="checkbox"
                                       value="">
                                <strong>设为默认地址</strong>
                                <span>（注：每次下单时都使用该地址）</span>
                            </p>
                        </div>--%>
                        <input type="hidden" name="cartId" value="${cart.id}">
                        <label></label>
                        <%--<input type="submit" class="dj-btn" value="保存收货人信息">--%>

                        <p>
                            <button type="submit" class="am-btn am-btn-default add-btn">保存收货人信息</button>
                        </p>
                    </form>
                </div>
                <div class="sh-bg"></div>
            </div>
        </div>

    </div>

    <div class="overbg"></div>
</div>
<!--//End--弹出地址-->

<!--Start--弹出地址-->
<div id="order-total" class="alert-delete yhq" style="display:none;">
    <div class="bd cart-coupons">
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
    var consumerAddress = $("#hiddenId").text();
    var totalPrice = $("#change").text();
    var orderId = "${purchaseOrder.id}";

    $(function () {

        if(!isWeiXin()){
            $("#weixin").hide();
        }

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
                        out += '<li>' + '<input type="radio" name="radio"' + 'value="' + data[i]["couponBatch"]["price"] + '"' + 'id="cbox' + data[i]["id"] + '">' + '<p>满' + data[i]["couponBatch"]["priceLimit"] + '元减' + data[i]["couponBatch"]["price"] + "元" + '</p>'
                                + '<p>有效期：' + formatDate(data[i]["couponBatch"]["startDate"]) + '至' + formatDate(data[i]["couponBatch"]["endDate"]) + '</p>' + '<p>适用范围：全网通用</p> </li>';
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
        $("input:radio").each(function(){
            if(this.checked){
                couponid = $(this).attr("id");
            }
        })
        var couponId = couponid.substring(4,couponid.length);
        $.ajax({
            type: 'post',
            async: false,
            url: '<c:url value="/coupon/use.do"/>',
            dataType: 'json',
            data: {
                couponId: couponId,
                orderId: orderId

            },
            success: function (data) {
                if (data == true) {
                    var t_price = parseInt(totalPrice);
                    var chkobjs = document.getElementsByName("radio");
                    for (var i = 0; i < chkobjs.length; i++) {
                        if (chkobjs[i].checked) {
                            t_price = t_price - parseInt(chkobjs[i].value);
                        }
                    }
                    $("#change").text(t_price);
                    $(".yhq").hide();
                }
            },

        });

    }

    function add_Address() {
        $("#adddiv").attr("style", "display:block;background: #fff;z-index:9999;width: 90%;left: 5%");
        $("#list-order").attr("style", "display:none");
    }

    function closeAll(){
        $(".or-address").attr("style", "display:none");
        $("#adddiv").attr("style", "display:none");
        $("#list-order").attr("style", "");
    }

    function zhifubao(element) {
        $("#zhifubao").attr("style", "border:2px solid red");
        if(isWeiXin()){
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
        var messageObject = new Object();
        $("input[name=message]").each(function () {
            messageObject[$(this).attr("id")] = $(this).val();
        })
        var message = "";
        for (var key in messageObject) {
            message += key + ":" + messageObject[key] + ";"
        }

        if (consumerAddress == "") {
            showAlert("提示", "请选择一个收货地址！");
        } else {

            var isweixin = "";

            if (isWeiXin()) {
                isweixin = "&isWeiXin=1";
            }

            var url = "<c:url value="/order/confirm/"/>";
            url += orderId + "?payment=" + payment + "&address=" + consumerAddress + "&message=" + message + isweixin;
            window.location.href = url;
        }
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


    function provinceChange(element) {
        var provinceId = $(element).val();
        ajaxRequest("<c:url value="/myEfeiyi/address/listCity.do"/>", {provinceId: provinceId}, function (data) {
            var out = '<option value="">请选择</option>';
            for (var i = 0; i < data.length; i++) {
                out += '<option value="' + data[i]["id"] + '">' + data[i]["name"] + '</option>';
            }
            $("#city").html(out);
        }, function () {
        }, "post")
    }

    function newAddress(it) {
        var out = ' <div class="page-default"> <span> <div id="' + (it.id) + '" class="default-text" name="addressItem" onclick="chooseAddress(this,\'' + it.id + '\')"> <strong>' + (it.consignee) + ' ' + (it.province.name) + '</strong> </a> </div> </span> <span>' + (it.consignee) + '</span> <span>' + (it.province.name) + '</span> <span>' + (it.city.name) + '</span> <span>' + (it.details) + '</span> <span>' + (it.phone) + '</span> </div>';
        return out;
    }

    function submitNewAddress() {
        var param = $("#newAddress").serialize();
        var success = function (data) {
            console.log(data)
            var html = newAddress(data);
            $("#address").append(html);
            $(".active-pop").hide();
        }
        ajaxRequest("<c:url value="/order/addAddress.do"/>", param, success, function () {
        }, "post")
    }

    function chooseAddress(addressId, consignee, phone, province,city, details) {
        consumerAddress = addressId;
        var conConsignee = consignee;
        var conPhone = phone;
        var conProvince = province;
        var conCity = city;
        var conDetails = details;

        console.log(consumerAddress);
        $("#order-add").attr("style", "display:none");
        $("#order-add1").attr("style", "display:block");
        $("#span1").text(conConsignee);
        $("#span2").text(conPhone);
        $("#txt").text(conProvince + conCity + conDetails);

    }

    function putVal(o) {
        var ele = document.getElementById("checkbox");
        if (ele.checked) {
            $(o).val("1");
        } else {
            $(o).val("0");
        }
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
    function df(id) {
        $.ajax({
            type: 'post',
            async: false,
            url: '<c:url value="/myEfeiyi/defaultAddress.do"/>',
            dataType: 'json',
            data: {
                status: 2,
                id: id

            },
            success: function (data) {
                if (data == true) {
                    window.location.reload();
                }
            },

        });
    }
    function city(obj) {
        var pid = $("#provinceVal").val();
        var v = $(obj).val();
        $("#cityVal").empty();
        $.ajax({
            type: 'post',
            async: false,
            url: '<c:url value="/myEfeiyi/address/listCity.do"/>',
            dataType: 'json',
            data: {
                provinceId: pid
            },
            success: function (data) {
                var obj = eval(data);
                var rowHtml = "";
                rowHtml += "<option value='请选择'>请选择</option>";
                for (var i = 0; i < obj.length; i++) {
                    rowHtml += "<option value='" + obj[i].id + "'>" + obj[i].name + "</option>";
                }
                $("#cityVal").append(rowHtml);
                $("#cityVal option[value='" + v + "']").attr("selected", "selected");

            },
        });
    }

    function province(obj) {
        var v = $(obj).val();
        $("#provinceVal").empty();
        $.ajax({
            type: 'post',
            async: false,
            url: '<c:url value="/myEfeiyi/address/listProvince.do"/>',
            dataType: 'json',
            success: function (data) {
                var obj = eval(data);
                var rowHtml = "";
                rowHtml += "<option value='请选择'>请选择</option>";
                for (var i = 0; i < obj.length; i++) {
                    rowHtml += "<option value='" + obj[i].id + "'>" + obj[i].name + "</option>";

                }
                $("#provinceVal").append(rowHtml);
                $("#provinceVal option[value='" + v + "']").attr("selected", "selected");
                city(v);
            },

        });
    }

    function provinceChange(element, o, callback) {
        $("#citys" + o).empty();
        var provinceId = $(element).val();
        ajaxRequest("<c:url value="/myEfeiyi/address/listCity.do"/>",
                {provinceId: provinceId},
                function (data) {
                    var out = '<option value="">请选择</option>';
                    for (var i = 0; i < data.length; i++) {
                        out += '<option value="' + data[i]["id"] + '">' + data[i]["name"] + '</option>';
                    }
                    $("#citys" + o).append(out);
                    if (typeof callback != "undefined") {
                        callback();
                    }
                }
        )
    }

    function chooseCity(element, provinceId, cityId, o) {
        $(element).val(provinceId);
        var callback = function () {
            $("#citys" + o).val(cityId);
        }
        provinceChange(element, o, callback);
    }

    <c:forEach items="${addressList}" var="address">
    chooseCity($("${address.id}"), "${address.province.id}", "${address.city.id}", "${address.id}");
    </c:forEach>

    /*  $().ready(function () {
     $("#addAddress").validate({
     rules: {
     consignee: "required",
     details: "required",
     name: "required",
     phone: "required",
     },
     });
     $("#updateAddress").validate({
     rules: {
     consignee: "required",
     details: "required",
     name: "required",
     phone: "required",
     },
     });
     });*/
    function formatDate(now) {
        return new Date(parseInt(now)).toLocaleString().replace(/:\d{1,2}$/, ' ');
    }


</script>
</body>
</html>