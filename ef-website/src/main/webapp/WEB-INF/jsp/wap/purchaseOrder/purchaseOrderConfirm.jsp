<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
  <title>020106订单页</title>
</head>
<body>
<header class="am-header custom-header">
  <div class="am-header-left am-header-nav">
    <a href="#chevron-left" class="chevron-left"></a>
  </div>
  <!-- //End--chevron-left-->
  <h1 class="am-header-title">确认订单</h1>
  <!-- //End--title-->
  <div class="am-header-right am-header-nav">
    <a href="#chevron-right" class="chevron-right" id="menu">
      <i class="line"></i>
    </a>
  </div>
  <!-- //End--chevron-left-->
  <div class="menu-list">
    <ul class="bd">
      <li><a href="" title="首页">首页</a></li>
      <li><a href="" title="分类">分&nbsp;类</a></li>
      <li class="active"><a href="" title="购物车">购&nbsp;物&nbsp;车</a></li>
      <li><a href="" title="传承人">传承人</a></li>
      <li><a href="" title="个人中心">个&nbsp;人&nbsp;中&nbsp;心</a></li>
    </ul>
  </div>
</header>
<!--//End--header-->
<article class="bd shop-cart">
  <div class="bd cart-order">
    <div class="bd order-address">
      <c:forEach items="${addressList}" var="address">
        <c:if test="${address.status=='2'}">
          <p class="title"><span>${address.consignee}</span><span>${address.phone}</span></p>
          <p class="txt">${address.province.name}${address.details}</p>
        </c:if>
      </c:forEach>
      <a href="#arrow-right" class="arrow-right"></a>
    </div>
    <c:forEach items="${tenantList}" var="tenant">
      <div class="bd order-list">
        <div class="title">${tenant.name}</div>
        <ul class="ul-list">
          <c:forEach items="${productMap.get(tenant.id)}" var="product">
            <li>
              <img class="img" src="${product.productModel.product.picture_url}" alt="">
              <div class="bd info">
                <p class="text">${product.productModel.product.name}</p>
                <p class="price"><em>￥</em><span>${product.productModel.price}</span></p>
                <p class="num"><i class="iocn-x"></i><strong>${product.amount}</strong></p>
              </div>
            </li>
          </c:forEach>
        </ul>
        <div class="bd ask"><textarea name="" id="" cols="30" rows="4" placeholder="给卖家留言"></textarea></div>
      </div>
    </c:forEach>
    <div class="bd order-total">
      <p><strong>优惠券</strong><span>2张券可用</span><a href="#arrow-right" class="arrow-right"></a></p>
      <p><strong>商品金额</strong><span><em>￥</em>2000</span></p>
      <p><strong class="grey">返现</strong><span><em>￥</em>0</span></p>
      <p><strong>运费</strong><span><em>￥</em>30</span></p>
    </div>
    <!-- //End--order-total-->
  </div>
  <!-- //End--cart-order-->
  <div class="bd payment-total-bar">
    <span class="txt">共${purchaseOrder.purchaseOrderProductList.size()}件，总计付款${cart.totalPrice.intValue()}元</span>
    <a href="#btn-right" class="btn-right">提交订单</a>
  </div>
</article>
</body>
</html>