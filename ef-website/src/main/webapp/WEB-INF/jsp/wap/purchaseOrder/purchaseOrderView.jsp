<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/29
  Time: 16:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>订单详情</title>
</head>
<body>
<!--//End--header-->
<c:if test="${order.orderStatus == 1 or order.orderStatus == 17}">
  <div class="line-item">
    <div class="address">
      <p><span>${order.consumerAddress.consignee}</span><span>${order.consumerAddress.phone}</span></p>
      <p>${order.consumerAddress.province.name}${order.consumerAddress.city.name}${order.consumerAddress.details}</p>
    </div>
    <div class="order-content">
      <div class="order-header">
        <p>订单号：<span>${order.serial}</span></p>
      </div>
      <!--一个商品-->
      <c:forEach items="${order.purchaseOrderProductList}" var="purchaseOrderProduct">
        <div class="order-js-list">
          <h1>${order.tenant.name}</h1>
          <div><hr data-am-widget="divider" style="" class=" am-divider-default" /></div>
          <div class="am-g am-intro-bd">
            <div class="am-intro-left am-u-sm-5 item-act"><a href="#"><img class="am-u-sm-12 item-act" src="<c:url value="http://pro.efeiyi.com/${purchaseOrderProduct.productModel.productPicture.pictureUrl}"/>" alt="产品" /></a></div>
            <div class="am-intro-right am-u-sm-7 item-act">
              <p class="item-acr">${purchaseOrderProduct.productModel.name}</p>
              <p class="item-rmb">￥${purchaseOrderProduct.purchasePrice}<span>x${purchaseOrderProduct.purchaseAmount}</span></p>
            </div>
          </div>
          <div class="am-form-group">
            <p></p>
          </div>
        </div>
      </c:forEach>
      <!--一个商品-->
      <!--一个商品-->
    </div>
    <div class="btn-payment">
      <a href="#" >
        <span>支付方式 <strong class="sp-active">
          <c:if test="${order.payWay=='1'}">
            支付宝
          </c:if>
          <c:if test="${order.payWay=='2'}">
            银行卡
          </c:if>
          <c:if test="${order.payWay=='3'}">
            微信
          </c:if>
        </strong></span>

      </a>
    </div>
  </div>
</c:if>
<c:if test="${order.orderStatus == 5 or order.orderStatus == 9 or order.orderStatus == 13}">
  <div class="line-item">
    <div class="address">
      <p><span>${order.consumerAddress.consignee}</span><span>${order.consumerAddress.phone}</span></p>
      <p>${order.consumerAddress.province.name}${order.consumerAddress.city.name}${order.consumerAddress.details}</p>
    </div>
    <div class="order-content">
      <div class="order-header">
        <p>订单号：<span>${order.serial}</span></p>
      </div>
      <!--订单状态为已付款-->
      <div class="order-js-list">
        <h1>
          <p>${purchaseOrderDelivery.logisticsCompany}</p>
          <p>快递单号：<span>${purchaseOrderDelivery.serial}</span></p>
        </h1>
        <div><hr data-am-widget="divider" style="" class=" am-divider-default" /></div>
        <iframe id="kuaidi100" name="kuaidi100" src="${content}" width="600" height="380" marginwidth="12" marginheight="10" hspace="11" vspace="10" frameborder="0" scrolling="no"></iframe>
<%--        <div class="express-address">
          <div class="an-address">
            <div class="address-time">
              <p>2015-08-01</p>
              <p>17:32:19 </p>
            </div>
            <div class="address-logo">
              <p><span class="dot"></span></p>
              <p><span class="rectangle"></span></p>
            </div>
            <div class="address-page">
              <p>北京西城区申通物流公司 已收件</p>
            </div>
          </div>
          <div class="an-address">
            <div class="address-time">
              <p>2015-08-01</p>
              <p>17:32:19 </p>
            </div>
            <div class="address-logo">
              <p><span class="dot"></span></p>
              <p><span class="rectangle"></span></p>
            </div>
            <div class="address-page">
              <p>北京西城区申通物流公司 已收件</p>
            </div>
          </div>
          <div class="an-address">
            <div class="address-time">
              <p>2015-08-01</p>
              <p>17:32:19 </p>
            </div>
            <div class="address-logo">
              <p><span class="dot-j"></span></p>
            </div>
            <div class="address-page">
              <p>北京西城区申通物流公司 已收件</p>
            </div>
          </div>
        </div>--%>
      </div>
      <!--订单状态为已付款-->
      <!--一个商品-->
      <div class="order-js-list">
        <h1>${order.tenant.name}</h1>
        <div><hr data-am-widget="divider" style="" class=" am-divider-default" /></div>
        <c:forEach items="${order.purchaseOrderProductList}" var="purchaseOrderProduct">
        <div class="am-g am-intro-bd">
          <div class="am-intro-left am-u-sm-5 item-act"><a href="#"><img class="am-u-sm-12 item-act" src="<c:url value="http://pro.efeiyi.com/${purchaseOrderProduct.productModel.productPicture.pictureUrl}"/>" alt="产品" /></a></div>
          <div class="am-intro-right am-u-sm-7 item-act">
            <p class="item-acr">${purchaseOrderProduct.productModel.name}</p>
            <p class="item-rmb">￥${purchaseOrderProduct.purchasePrice}<span>x${purchaseOrderProduct.purchaseAmount}</span></p>
          </div>
        </div>
        </c:forEach>
        <div class="am-form-group">
          <div class="am-form-group">
            <p></p>
          </div>
        </div>
      </div>
      <!--一个商品-->
    </div>
    <div class="btn-payment">
      <a href="#" >
        <span>支付方式 <strong class="sp-active">
          <c:if test="${order.payWay=='1'}">
            支付宝
          </c:if>
          <c:if test="${order.payWay=='2'}">
            银行卡
          </c:if>
          <c:if test="${order.payWay=='3'}">
            微信
          </c:if>
        </strong></span>
      </a>
    </div>
  </div>
</c:if>
</body>
</html>
