<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
    <title>购物车</title>
</head>
<body>
<!--//End--header-->
<c:if test="${!empty tenantList}">
    <article class="bd shop-cart">
        <div class="bd cart-list">
            <c:forEach items="${tenantList}" var="tenant">
                <ul class="ul-list">
                    <li class="first">
                        <input id="${tenant.id}" type="checkbox"
                               class="checkbox" value="option1"
                               onclick="tenantAll(this,'${cart.id}','${tenant.id}')">

                        <div class="bd info">
                            <div class="title">${tenant.name}</div>
                            <div class="txt">已购满120元，已减18元</div>
                            <a href="#arrow-right" class="arrow-right"></a>
                        </div>
                    </li>
                    <c:forEach items="${productMap.get(tenant.id)}" var="product">
                        <li>
                            <c:if test="${product.isChoose=='1'}">
                                <input id="${tenant.id}:${product.id}" type="checkbox"
                                       class="checkbox"
                                       onclick="productItem(this,'${product.id}')"
                                       value="option1" checked="checked">
                            </c:if>
                            <c:if test="${product.isChoose=='0'}">
                                <input id="${tenant.id}:${product.id}" type="checkbox"
                                       class="checkbox"
                                       onclick="productItem(this,'${product.id}')"
                                       value="option1">
                            </c:if>
                            <img class="img" src="<c:url value="${product.productModel.product.picture_url}"/>" alt=""/>

                            <div class="bd info">
                                <p class="title">${product.productModel.product.name}</p>

                                <p class="info-opt">
                                    <a class="sub" href="#" onclick="subtractProduct('${product.id}')" title="减"></a>
                                    <input id="${product.id}Amount" class="ipt-txt" type="text"
                                           value="${product.amount}" onblur="changeProduct('${product.id}',this)"
                                           onkeydown="if(event.keyCode==13)changeProduct('${product.id}',this)"/>
                                    <a class="add" href="#" onclick="addProduct('${product.id}')" title="加"></a>
                                </p>

                                <p class="info-price"><em>￥</em><span class="moneycl"
                                                                      id="${product.id}Price">${(product.productModel.price.intValue())*product.amount}</span>
                                </p>
                                <a href="<c:url value="/cart/removeProduct.do?cartProductId=${product.id}"/>"
                                   class="icon icon-delete"></a>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </c:forEach>
        </div>
        <!-- //End--cart-list-->
        <div class="bd payment-total-bar">
            <input type="checkbox" class="checkbox" onclick="chooseAll(this,'${cart.id}')"/>
            <span class="txt" id="totalPrice">${cart.totalPrice}</span>
            <a onclick="submit()"
               class="btn-right btn-settle">结算<em></em></a>
        </div>

    </article>
    <div class="alert-delete" style="display:none">
        <div class="content">
            <div class="bd title">提示</div>
            <div class="bd info">您确定要删除？</div>
            <div class="bd btns">
                <a class="btn-true" href="#确定" title="确定">确定</a>
                <a class="btn-false" href="#取消" title="取消">取消</a>
            </div>
        </div>
        <div class="overbg"></div>
    </div>
</c:if>
<c:if test="${empty tenantList}">
    <article class="bd shop-cart">
        <div class="bd cart-list-no">
            <div class="bd prompt-txt">
                <p class="bd"><i class="icon"></i></p>

                <p class="bd">你的购物车还是空空的，</p>

                <p class="bd">去看看心仪的商品吧。</p>
            </div>
            <!-- //End--prompt-txt-->
            <%--<div class="bd pro-rec">
                <h2>精品推荐</h2>
                <ul class="ul-list">
                    <li>
                        <img src="<c:url value="/scripts/wap/upload/cart-exp-1.jpg"/>" alt=""/>

                        <p class="name">这是商品这是商品</p>

                        <p class="price"><em>￥</em><span>2000</span></p>
                    </li>
                    <li>
                        <img src="<c:url value="/scripts/wap/upload/cart-exp-1.jpg"/>" alt=""/>

                        <p class="name">这是商品这是商品</p>

                        <p class="price"><em>￥</em><span>2000</span></p>
                    </li>
                    <li>
                        <img src="<c:url value="/scripts/wap/upload/cart-exp-1.jpg"/>" alt=""/>

                        <p class="name">这是商品这是商品</p>

                        <p class="price"><em>￥</em><span>2000</span></p>
                    </li>
                    <li>
                        <img src="<c:url value="/scripts/wap/upload/cart-exp-1.jpg"/>" alt=""/>

                        <p class="name">这是商品这是商品</p>

                        <p class="price"><em>￥</em><span>2000</span></p>
                    </li>
                    <li>
                        <img src="<c:url value="/scripts/wap/upload/cart-exp-1.jpg"/>" alt=""/>

                        <p class="name">这是商品这是商品</p>

                        <p class="price"><em>￥</em><span>2000</span></p>
                    </li>
                    <li>
                        <img src="<c:url value="/scripts/wap/upload/cart-exp-1.jpg"/>" alt=""/>

                        <p class="name">这是商品这是商品</p>

                        <p class="price"><em>￥</em><span>2000</span></p>
                    </li>
                </ul>
            </div>--%>
            <!-- //End--products-->
        </div>
        <!-- //End--cart-list-no-->
    </article>
</c:if>
<script>
    function submit(){

        var param = {cartId:'${cart.id}'}

        var success = function(data){
            if(data){
                window.location.href = "<c:url value="/order/saveOrUpdateOrder.do?cartId=${cart.id}"/>"
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
            console.log(data);
            console.log($("#" + cartProductId + "Amount"));
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