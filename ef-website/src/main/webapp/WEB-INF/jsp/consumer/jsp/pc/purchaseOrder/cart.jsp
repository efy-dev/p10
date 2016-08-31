<%@ page import="com.efeiyi.ec.website.base.util.AuthorizationUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/19
  Time: 10:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <link href="<c:url value="/scripts/css/myorder.css"/>" type="text/css " rel="stylesheet">
</head>
<body>
<%--<div class="oss">--%>
<%--<span>抱歉，您购物车中的部分商品暂时缺货，您可以先选择结算其它商品。</span>--%>
<%--</div>--%>
<!--缺货-->
<c:if test="${!empty tenantList}">
    <div class="efeiyi-cart">
        <div class="title wh1" style="padding-bottom:200px;">
            <table>
                <tr class="bd-gwc">
                    <td width="144">
                        <label class="active-box"><input onclick="chooseAll(this,'${cart.id}')" type="checkbox"
                                                         class="middle-active" value="全部"></label>
                        <label>全部</label>
                    </td>
                    <td width="377">商品名称</td>
                    <td width="141">单价</td>
                    <td width="104">数量</td>
                    <td width="119">小计（元）</td>
                    <td width="111">操作</td>
                </tr>
            </table>
            <!--一个店铺-->
            <c:forEach items="${tenantList}" var="tenant">

                <table>
                    <tr>
                        <td colspan="6">
                            <label class="active-box pd-gwc"><input id="${tenant.id}" type="checkbox"
                                                                    class="middle-active" value="全部"
                                                                    onclick="tenantAll(this,'${cart.id}','${tenant.id}')"></label>
                            <label>${tenant.name}</label>
                        </td>
                    </tr>
                    <!--一个商品-->
                    <c:forEach items="${productMap.get(tenant.id)}" var="product">


                        <tr class="bd-gwc">
                            <td width="46">
                                <label class="active-box pd-gwc">
                                    <c:if test="${product.isChoose=='1'}">
                                        <input id="${tenant.id}:${product.id}" type="checkbox"
                                               class="middle-active"
                                               onclick="productItem(this,'${product.id}')"
                                               value="全部" checked="checked">
                                    </c:if>
                                    <c:if test="${product.isChoose=='0'}">
                                        <input id="${tenant.id}:${product.id}" type="checkbox"
                                               class="middle-active"
                                               onclick="productItem(this,'${product.id}')"
                                               value="全部">
                                    </c:if>
                                </label>
                            </td>
                            <td width="437">
                                <div class="cols1">
                                    <img src="http://pro.efeiyi.com/${product.productModel.productModel_url
                                    }@!product-icon" alt=""/>

                                    <div class="info">
                                        <p><a href="#">${product.productModel.product.project.name}</a></p>

                                        <p><a href="#">${product.productModel.name}
                                            <c:if test="${product.productModel.productPropertyValueList.size()>1}">
                                                [
                                                <c:forEach items="${product.productModel.productPropertyValueList}"
                                                           var="ppv">${ppv.projectPropertyValue.value}</c:forEach>
                                                ]
                                            </c:if>
                                            </a></p>
                                    </div>
                                </div>
                            </td>
                            <td width="111"><span class="moneycl">${product.productModel.price}</span></td>
                            <td width="129">
                                <div class="control-pd">
                                    <a href="#" class="cart-btn-right"
                                       onclick="subtractProduct('${product.id}')">-</a>
                                    <input id="${product.id}Amount" type="text" class="cart-center"
                                           value="${product.amount}" onblur="changeProduct('${product.id}',this)"
                                           onkeydown="if(event.keyCode==13)changeProduct('${product.id}',this)">
                                        <%--<c:if test="${product.amount>1}">--%>
                                    <a href="#" class="cart-btn-left" onclick="addProduct('${product.id}')">+</a>
                                        <%--</c:if>--%>
                                        <%--<c:if test="${product.amount<=1}">--%>
                                        <%--<a href="#" class="cart-btn-right">-</a>--%>
                                        <%--</c:if>--%>

                                </div>
                                    <%--<div class="control-cl">商家存货仅剩200件</div>--%>
                            </td>
                            <td width="119"><span class="moneycl"
                                                  id="${product.id}Price">${(product.productModel.price)*product.amount}</span>
                            </td>
                            <td width="111">
                    <span>
                    <p><a onclick="showConfirm('提示','是否确认删除',function(){
                        window.location.href = '<c:url value="/cart/removeProduct.do?cartProductId=${product.id}"/>';
                    })">删除</a></p>
                    <%--<p><a href="#">移到我的收藏</a></p>--%>
                    </span>
                            </td>
                        </tr>
                    </c:forEach>
                    <!--一个商品-->
                </table>
            </c:forEach>
            <!--一个店铺-->
            <div class="settle">
                <table>
                    <tr class="bd-gwc settle-hd">
                        <td width="100">
                            <label class="active-box"><input onclick="chooseAll(this,'${cart.id}')" type="checkbox"
                                                             class="middle-active" value="全部"></label>
                            <label>全部</label>
                        </td>
                            <%--<td width="128"><a href="#" class="settle-cll">删除选中商品</a></td>--%>
                            <%--<td width="297"><a href="#" class="settle-cll">移到我的收藏夹</a></td>--%>
                        <td width="332">总计（免运费）<span class="moneycl" id="totalPrice">${cart.totalPrice}</span>元</td>
                        <%
                            if (AuthorizationUtil.getMyUser().getId() != null) {
                        %>
                        <td id="hiddenCoupon"></td>
                        <td>
                            <div class="coupon" id="cart-coupon">
                                <a class="btn-coupon" href="#优惠券" onclick="openCoupon()" target="_blank" title="">优惠券<i class="icon"></i></a>
                                <ul class="ul-list">
                                </ul>
                            </div>
                        </td>
                        <%
                            }
                        %>
                        <td width="147"><a onclick="submit()"
                                           class="btn-settle">结算</a></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</c:if>
<c:if test="${empty tenantList}">
    <div class="efeiyi-null">
        <div class="cart-null">
            <div class="null-shop">
                <span class="bg-cart"></span>

                <p>您的购物车还是空空的，去看看心仪的商品吧~</p>
                <span><a href="<c:url value="/"/> ">去购物</a></span>
            </div>

        </div>
    </div>
</c:if>
<script>
    var couponId = null;
    function openCoupon() {
        var param = {
        };
        var success = function (data) {
            if(data != null){
                var out = '';
                for (var i = 0; i < data.length; i++) {
                    out += '<li>' + '<img src="http://pro.efeiyi.com/' + data[i]["couponBatch"]["pictureUrl"] + '"  alt=""/>' + '<p>满' + data[i]["couponBatch"]["priceLimit"] +
                            '立减' + data[i]["couponBatch"]["price"] + '</p>' + '<p>全场通用</p>' + '<a class="btn-draw" id="' + data[i]["id"] + '|' + data[i]["couponBatch"]["priceLimit"] + '|' + data[i]["couponBatch"]["price"] + '"' + 'onclick="chooseCoupon(this)" title="使用">使用' + '</a>' + '</li>';
                }
                $(".ul-list").html(out);
            }
        }
        ajaxRequest("<c:url value="/coupon/listCoupon"/>", param, success, function () {
        }, "post")
    }

    function chooseCoupon(o){

        var id = $(o).attr("id");
        couponId = id.split("|")[0];
        var priceLimit = id.split("|")[1];
        var price = id.split("|")[2];
        var out = '';
        out = '满' + priceLimit +'立减' +price;
        $("#hiddenCoupon").html(out);
        $("#totalPrice").text($("#totalPrice").text()-price);
        $(".ul-list").hide();

    }

    function submit(){

        var param = {cartId:'${cart.id}'}

        var success = function(data){
            if(data){
                window.location.href = "<c:url value="/order/saveOrUpdateOrder.do?cartId=${cart.id}&couponId="/>"+couponId;
            }else{
                showAlert("提示","请选中一件商品!");
            }
        }
        ajaxRequest("<c:url value="/cart/cartCheck.do"/>", param, success, function () {
        }, "post")
    }

    function addProduct(cartProductId) {
        var param = {
            cartProductId: cartProductId
        };
        var success = function (data) {
            $("#" + cartProductId + "Amount").val(data["amount"]);
            $("#totalPrice").html(data["cart"]["totalPrice"]);
            $("#" + cartProductId + "Price").html(data["productModel"]["price"] * data["amount"]);

        }
        ajaxRequest("<c:url value="/cart/addProductCount.do"/>", param, success, function () {
        }, "post")
    }

    function changeProduct(cartProductId, element) {
        var param = {
            cartProductId: cartProductId,
            amount: $(element).val()
        };
        var success = function (data) {
            console.log(data);
            $("#" + cartProductId + "Amount").val(data["amount"]);
            $("#totalPrice").html(data["cart"]["totalPrice"]);
            $("#" + cartProductId + "Price").html(data["productModel"]["price"] * data["amount"]);

        }
        ajaxRequest("<c:url value="/cart/changeProductCount.do"/>", param, success, function () {
        }, "post")
    }

    function subtractProduct(cartProductId) {
        var param = {
            cartProductId: cartProductId
        };
        var success = function (data) {
            console.log(data);
            $("#" + cartProductId + "Amount").val(data["amount"]);
            $("#totalPrice").html(data["cart"]["totalPrice"]);
            $("#" + cartProductId + "Price").html(data["productModel"]["price"] * data["amount"]);
        }
        ajaxRequest("<c:url value="/cart/subtractProductCount.do"/>", param, success, function () {
        }, "post")
    }


    function productItem(element, cartProductId) {
        if (element.checked == true) {
            chooseItem(cartProductId);
        } else if (element.checked == false) {
            cancelChooseItem(cartProductId);
        }
    }

    function chooseItem(cartProductId) {
        var param = {
            cartProductId: cartProductId
        };
        var success = function (data) {
            $("#totalPrice").html(data["totalPrice"]);
        }
        ajaxRequest("<c:url value="/cart/chooseProduct.do"/>", param, success, function () {
        }, "post")
    }

    function cancelChooseItem(cartProductId) {
        var param = {
            cartProductId: cartProductId
        };
        var success = function (data) {
            $("#totalPrice").html(data["totalPrice"]);
        }
        ajaxRequest("<c:url value="/cart/cancelChooseProduct.do"/>", param, success, function () {
        }, "post")
    }


    function tenantAll(element, cartId, tenantId) {
        if (element.checked == true) {
            chooseTenant(cartId, tenantId);
        } else if (element.checked == false) {
            cancelChooseTenant(cartId, tenantId);
        }
    }

    function chooseTenant(cartId, tenantId) {
        var param = {
            tenantId: tenantId,
            cartId: cartId
        };
        var success = function (data) {
            data = JSON.parse(data);
            $("input").each(function () {
                var inputId = $(this).attr("id") + "";
                if (inputId.indexOf(data["tenantId"]) >= 0) {
                    this.checked = true;
                }
            })
            $("#totalPrice").html(data["totalPrice"]);
        }
        ajaxRequest("<c:url value="/cart/chooseTenant.do"/>", param, success, function () {
        }, "post")
    }

    function cancelChooseTenant(cartId, tenantId) {
        var param = {
            tenantId: tenantId,
            cartId: cartId
        };
        var success = function (data) {
            data = JSON.parse(data);
            $("input").each(function () {
                var inputId = $(this).attr("id") + "";
                if (inputId.indexOf(data["tenantId"]) >= 0) {
                    this.checked = false;
                }
            })
            $("#totalPrice").html(data["totalPrice"]);
        }
        ajaxRequest("<c:url value="/cart/cancelChooseTenant.do"/>", param, success, function () {
        }, "post")
    }


    function chooseAll(element, cartId) {
        var chooseType = "1";
        if (element.checked == true) {
            chooseType = "1";
        } else if (element.checked == false) {
            chooseType = "0";
        }

        var param = {
            cartId: cartId,
            chooseType: chooseType
        };
        var success = function (data) {
            data = JSON.parse(data);
            $("input").each(function () {
                if (data["chooseType"] == "1") {
                    this.checked = true;
                } else {
                    this.checked = false;
                }
            });
            $("#totalPrice").html(data["totalPrice"]);
        }
        ajaxRequest("<c:url value="/cart/chooseAll.do"/>", param, success, function () {
        }, "post")


    }


</script>
</body>
</html>
