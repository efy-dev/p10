<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>个人中心</title>
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
<div class="list-pro wh1">
  <table></table>
</div>
<div class="list-pro wh1" id="orderNum">
<c:forEach items="${orderList}" var="order">
  <c:if test="${order.subPurchaseOrder !=null && order.subPurchaseOrder.size() >0}">
    <c:forEach  items="${order.subPurchaseOrder}" var="subOrder">
      <table class="list-pro-table">
        <tr>
          <th colspan="6">
            <span>${order.createDatetime}</span>
            <span>订单号：<strong>${order.serial}</strong></span>
            <span>瓷器之都</span>
          </th>
        </tr>
        <tr>
          <td width="618">
            <c:forEach items="${subOrder.purchaseOrderProductList}" var="op">
              <table class="item">
                <td width="237">
                  <div class="cols1">
                    <img src="../shop2015/upload/img-tx2.png" alt="">
                    <div class="info">
                      <p><a href="#">${op.productModel.product.category.name}</a></p>
                      <p><a href="#">${op.productModel.product.name}</a></p>
                    </div>
                  </div>
                </td>
                <td width="174">￥${subOrder.total}</td>
                <td width="107">x<span>1</span></td>
                <td width="100">${subOrder.payWay}</td>
              </table>
            </c:forEach>
          </td>
          <td class="rowspan" width="130" rowspan='2' style="border-left:1px solid #ccc;">
            <p><a href="#">待收货</a></p>
            <p><a href="#">订单跟踪</a></p>
          </td>
          <td class="rowspan" width="139" rowspan='2' style="border-left:1px solid #ccc;border-right:1px solid #ccc">
            <p><a href="#">查看</a></p>
            <p><a href="#">再次购买</a></p>
          </td>
        </tr>
      </table>
    </c:forEach>
  </c:if>
  <c:if test="${order.subPurchaseOrder == null || order.subPurchaseOrder.size() == 0}">
    <table class="list-pro-table">
      <tr>
        <th colspan="6">
          <span>${order.createDatetime}</span>
          <span>订单号：<strong>${order.serial}</strong></span>
          <span>瓷器之都</span>
        </th>
      </tr>
      <tr>
        <td width="618">
          <c:forEach items="${order.purchaseOrderProductList}" var="op">
            <table class="item">
              <td width="237">
                <div class="cols1">
                  <img src="../shop2015/upload/img-tx2.png" alt="">
                  <div class="info">
                    <p><a href="#">${op.productModel.product.category.name}</a></p>
                    <p><a href="#">${op.productModel.product.name}</a></p>
                  </div>
                </div>
              </td>
              <td width="174">￥${order.total}</td>
              <td width="107">x<span>1</span></td>
              <td width="100">${order.payWay}</td>
            </table>
          </c:forEach>
        </td>
        <td class="rowspan" width="130" rowspan='2' style="border-left:1px solid #ccc;">
          <p><a href="#">待收货</a></p>
          <p><a href="#">订单跟踪</a></p>
        </td>
        <td class="rowspan" width="139" rowspan='2' style="border-left:1px solid #ccc;border-right:1px solid #ccc">
          <p><a href="#">查看</a></p>
          <p><a href="#">再次购买</a></p>
        </td>
      </tr>
    </table>
  </c:if>
</c:forEach>
</div>
</div>
</div>

<style>

</style>


<!--content-->
<!-- //End--footer-->


<!--[if (gte IE 9)|!(IE)]><!-->
<script src="/scripts/assets/js/jquery.min.js"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="/scripts/assets/js/amazeui.min.js"></script>
<script src="/scripts/assets/js/system.js"></script>
</body>
</html>