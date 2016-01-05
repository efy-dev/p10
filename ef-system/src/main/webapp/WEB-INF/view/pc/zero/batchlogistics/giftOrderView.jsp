<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/1/4
  Time: 10:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
  <title>订单详情</title>
  <script>
    function saveReceiver(purchaseOrderId,orderStatus){
      if(orderStatus == '7' || orderStatus == '9' || orderStatus == '13'){
        alert("订单已发货，不能修改收货人信息");
      }else if(orderStatus == '17'){
        alert("订单已取消，不能修改收货人信息");
      }else{
        jQuery.ajax({
          type: "GET",
          url: '<c:url value="/batch/updateReceiver.do"/>',
          data: {name: $('#name').val(), phone: $('#phone').val(),address:$('#address').val(),id:purchaseOrderId},
          dataType: "json",
          success: function (data) {
            if(data == true){
              alert("收货人信息修改成功");
            }
          }
        });
      }
    }
  </script>
</head>
<body>
<span style="text-align: left;margin-left: 10px;">
    <input onclick="window.history.go(-1);"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 4px;margin-bottom: 6px;margin-left:2px;height: 35px;"
           value="返回"/>
</span>

<div class="am-g" style="margin-top: 30px;">
  <div class="am-u-md-12">
    <table class="am-table am-table-bordered">
      <thead>
        <tr>
          <th>筛单信息</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td class="am-primary am-u-md-3" style="width: 100%;">${object.purchaseOrder.message}</td>
        </tr>
      </tbody>
    </table>
  </div>
</div>

<div class="am-g" style="margin-top: 30px;">
  <div class="am-u-md-12">
    <table class="am-table am-table-bordered">
      <thead>
        <tr>
          <th>礼品卡订单</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td class="am-primary am-u-md-3">订单号</td>
          <td class="am-u-md-3">${object.purchaseOrder.serial}</td>

          <td class="am-primary am-u-md-3">订单状态</td>
          <td class="am-u-md-3">
            <ming800:status name="orderStatus" dataType="purchaseOrder.orderStatus"
                            checkedValue="${object.purchaseOrder.orderStatus}"
                            type="normal"/>
          </td>
        </tr>
        <tr>
          <td class="am-primary am-u-md-3">商品规格</td>
          <td class="am-u-md-3">${object.productModel.name}</td>

          <td class="am-primary am-u-md-3">商品名称</td>
          <td class="am-u-md-3">${object.productModel.product.name}</td>
        </tr>
        <tr>
          <td class="am-primary am-u-md-3">商品价格</td>
          <td class="am-u-md-3">${object.productModel.price}</td>

          <td class="am-primary am-u-md-3">下单时间</td>
          <td class="am-u-md-3">
            <fmt:formatDate value="${object.purchaseOrder.createDatetime}" pattern="yyyy-MM-dd HH:mm"/>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</div>

<div class="am-g">
  <div class="am-u-md-12">
    <table class="am-table am-table-bordered">
      <thead>
      <tr>
        <th>收货人信息</th>
      </tr>
      </thead>
      <tbody>
      <tr>
        <td class="am-primary am-u-md-3">收货人姓名</td>
        <td class="am-u-md-3"><input type="text" id="name" value="${object.purchaseOrder.receiverName}" style="width: 100%"></td>
        <td class="am-primary am-u-md-3">电话</td>
        <td class="am-u-md-3">
          <input type="text" id="phone" value="${object.purchaseOrder.receiverPhone}" style="width: 100%">
        </td>
      </tr>
      <tr>
        <td class="am-primary am-u-md-3">收货地址</td>
        <td class="am-u-md-3">
          <input type="text" id="address" value="${object.purchaseOrder.purchaseOrderAddress}" style="width: 100%">
        </td>
        <td class="am-primary am-u-md-3">保存</td>
        <td class="am-u-md-3">
          <security:authorize ifAnyGranted="admin,operational,o_operational">
            <input type="button" value="保存" onclick="saveReceiver('${object.purchaseOrder.id}','${object.purchaseOrder.orderStatus}')">
          </security:authorize>
        </td>
      </tr>
      </tbody>
    </table>
  </div>
</div>

</body>
</html>
