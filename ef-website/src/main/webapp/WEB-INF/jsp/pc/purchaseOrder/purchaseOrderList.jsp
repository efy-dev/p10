<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>个人中心</title>
  <!-- Set render engine for 360 browser -->

</head>

<body>

<!-- //End--header-->
<!--content-->

    <div class="layout-col">
      <div class="mt wh1">
        <div class="extra-l">
          <strong>我的订单</strong>
          <a href="#">待付款(<span>3</span>)</a>
          <a href="#">待收货</a>
          <a href="#">待评价</a>
          <a href="#">已完成</a>
          <a href="#">订单回收站</a>
        </div>
        <div class="extra-r">
          <a href="">合并</a>
          <a href="">付款</a>
        </div>
      </div>
      <!-- //End--mt-->
      <div class="title wh1">
        <table>
          <tr>
            <th width="237">商品名称</th>
            <th width="174">单价</th>
            <th width="107">数量</th>
            <th width="100">总计</th>
            <th width="130">交易状态</th>
            <th width="139">操作</th>
          </tr>
        </table>
      </div>
      <!-- //End--title-->
      <c:forEach items="${orderList}" var="order">
      <div class="list-pro wh1">
        <table>
          <tr>
            <th colspan="6">
              <span>${order.createDatetime}</span>
              <span>订单号：<strong>${order.serial}</strong></span>
              <span>瓷器之都</span>
            </th>
          </tr>
        <c:forEach items="${order.purchaseOrderProductList}" var="op">
          <tr>
            <td width="237" >
              <div class="cols1">
                <img src="../../../../scripts/assets/images/img-tx2.png" alt=""/>
                <div class="info">
                  <p><a href="#">${op.productModel.product.name}</a></p>
                  <p><a href="#">${op.productModel.product.project.type}</a></p>
                </div>
              </div>
            </td>
            <td width="174">￥${order.total}</td>
            <td width="107">x<span>1</span></td>
            <td width="100">在线支付</td>
            <td width="130">${order.orderStatus}</td>
            <td width="139">
              <p><a href="#">付款</a></p>
              <p><a href="/myEfeiyi/order/view/${order.id}">查看</a></p>
              <p><a href="#">取消订单</a></p>
            </td>
          </tr>
        </c:forEach>
        </table>
      </div>
        </c:forEach>
      <!-- //End--two-->
      <div class="list-pro wh1"></div>
      <!-- //End--3-->
      <div class="list-pro wh1"></div>
    </div>
</div>
</div>
<!-- //End--footer-->
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="../../../../scripts/assets/js/jquery.min.js"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="../../../../scripts/assets/http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="../../../../scripts/assets/http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="../../../../scripts/assets/assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="../../../../scripts/assets/js/amazeui.min.js"></script>
<script src="../../../../scripts/assets/js/system.js"></script>





</body>
</html>
