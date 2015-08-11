<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: jacsonzhou
  Date: 2015/8/4
  Time: 15:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的订单</title>
   <script>
    function func(o){
      var pid = $(o).next().val();
      window.location=("/order/list.do?id="+pid);
    }
/*    function cancelOrder(o){
        var pid = $(o).next().val();
        window.location=("/order/list.do?id="+pid);
    }*/

  </script>
</head>
<body>

<h1>商品列表</h1>
<form name="product"  method="post">
  <table width="95%" align="center" cellpadding="10" cellspacing="0" border="1">
  <tr>
      <td>
        <input type="button" value="全部订单" onclick="func(this);">
        <input type="hidden" id="allOrders" value="0">
      </td>
      <td>
        <input type="button" value="待付款" onclick="func(this);">
        <input type="hidden" id="noPay" value="1">
      </td>
    <td>
      <input type="button" value="待收货" onclick="func(this);">
      <input type="hidden" id="noReceipt" value="5">
    </td>
    <td>
      <input type="button" value="未评价" onclick="func(this);">
      <input type="hidden" id="noComment" value="9">
      </td>
    <td>
      <input type="button" value="已完成" onclick="func(this);">
      <input type="hidden" id="finish" value="13">
    </td>
    <td>
      <input type="button" value="已取消" onclick="func(this);">
      <input type="hidden" id="cancel" value="17">
    </td>
  </tr>
    <tr>
      <td>商品名</td>
      <td>单价（元）</td>
      <td>数量</td>
      <td>总计（元）</td>
      <td>提交时间</td>
      <td>交易状态</td>
      <td>操作</td>
    </tr>

    <c:forEach items="${orderList}" var="list">
    <tr>
      <p>
          ${list.serial}
      </p>
      <c:forEach items="${list.purchaseOrderProductList}" var="productList">
      <td>
          ${productList.productModel.product.name}
      </td>
      <td>
          ${productList.productModel.product.price}
      </td>
      <td>
          ${productList.purchaseAmount}
      </td>
      <td>
          ${productList.purchasePrice}
      </td>
      <td>
          ${list.createDatetime}
      </td>
      <td>
          ${list.orderStatus}
      </td>
    </tr>
      </c:forEach>
    </c:forEach>
    <p>
      <input type="button" value="取消订单" onclick="func(this);">
      <input type="hidden" id="cancelOrder" value="10002">
    </p>
  </table>
</body>
</html>