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
    <link href="/scripts/assets/css/efeiyi-shoppingcart.css" type="text/css " rel="stylesheet">
</head>
<body>
<%--<div class="oss">--%>
<%--<span>抱歉，您购物车中的部分商品暂时缺货，您可以先选择结算其它商品。</span>--%>
<%--</div>--%>
<!--缺货-->
<c:if test="${!empty tenantList}">
    <div class="efeiyi-cart">
        <div class="title wh1">
            <table>
                <tr class="bd-gwc">
                    <td width="144">
                        <label class="active-box"><input type="checkbox" class="middle-active" value="全部"></label>
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
                            <label class="active-box pd-gwc"><input type="checkbox" class="middle-active"
                                                                    value="全部"></label>
                            <label>${tenant.name}</label>
                        </td>
                    </tr>
                    <!--一个商品-->
                    <c:forEach items="${productMap.get(tenant.id)}" var="product">


                        <tr class="bd-gwc">
                            <td width="46">
                                <label class="active-box pd-gwc"><input type="checkbox" class="middle-active"
                                                                        value="全部"></label>
                            </td>
                            <td width="437">
                                <div class="cols1">
                                    <img src="u/img-tx2.png" alt=""/>

                                    <div class="info">
                                        <p><a href="#">${product.productModel.product.project.name}</a></p>

                                        <p><a href="#">${product.productModel.product.name}
                                            <c:forEach items="${product.productModel.productPropertyValueList}" var="ppv">-${ppv.projectPropertyValue.value}</c:forEach>
                                        </a></p>
                                    </div>
                                </div>
                            </td>
                            <td width="111"><span class="moneycl">${product.productModel.price.intValue()}</span></td>
                            <td width="129">
                                <div class="control-pd">
                                    <a href="#" class="cart-btn-left" onclick="addProduct('${product.id}')">+</a>
                                    <input id="${product.id}Amount" type="text" class="cart-center" value="${product.amount}">
                                    <a href="#" class="cart-btn-right" onclick="subtractProduct('${product.id}')">-</a>
                                </div>
                                <%--<div class="control-cl">商家存货仅剩200件</div>--%>
                            </td>
                            <td width="119"><span class="moneycl">${(product.productModel.price.intValue())*product.amount}</span></td>
                            <td width="111">
                    <span>
                    <p><a href="#">删除</a></p>
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
                            <label class="active-box"><input type="checkbox" class="middle-active" value="全部"></label>
                            <label>全部</label>
                        </td>
                        <td width="128"><a href="#" class="settle-cll">删除选中商品</a></td>
                        <td width="297"><a href="#" class="settle-cll">移到我的收藏夹</a></td>
                        <td width="332">已选择一件商品，总计（免运费）<span class="moneycl" id="totalPrice">144444444444</span>元</td>
                        <td width="147"><a href="#" class="btn-settle">结算</a></td>
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
                <span><a href="#">去购物</a></span>
            </div>

        </div>
    </div>
</c:if>
<script>

    function addProduct(cartProductId){
        var param = {
            cartProductId:cartProductId
        };
        var success = function(data){
            console.log(data);
            $("#"+cartProductId+"Amount").attr("value",data["amount"]);
        }
        ajaxRequest("<c:url value="/cart/addProductCount.do"/>",param,success,function(){},"post")
    }

    function subtractProduct(cartProductId){
        var param = {
            cartProductId:cartProductId
        };
        var success = function(data){
            console.log(data);
            $("#"+cartProductId+"Amount").attr("value",data["amount"]);
        }
        ajaxRequest("<c:url value="/cart/subtractProductCount.do"/>",param,success,function(){},"post")
    }

    function chooseItem(cartProductId){
        var param = {
            cartProductId:cartProductId
        };
        var success = function(data){
            console.log(data);
            //@TODO 更新总价格
            $("#totalPrice").attr("value",data["totalPrice"]);
        }
        ajaxRequest("<c:url value="/cart/chooseProduct.do"/>",param,success,function(){},"post")
    }

    function cancelChooseItem(cartProductId){
        var param = {
            cartProductId:cartProductId
        };
        var success = function(data){
            console.log(data);
            //@TODO 更新总价格
            $("#totalPrice").attr("value",data["totalPrice"]);
        }
        ajaxRequest("<c:url value="/cart/cancelChooseProduct.do"/>",param,success,function(){},"post")
    }


</script>
</body>
</html>
