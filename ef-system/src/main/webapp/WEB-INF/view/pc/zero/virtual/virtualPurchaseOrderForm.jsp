<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/1/7
  Time: 18:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
  <title>虚拟订单详情</title>
  <script src="<c:url value="/resources/plugins/My97DatePicker/WdatePicker.js"/>"></script>
</head>
<body>
<div style="text-align: left;margin-left: 10px;">
  <input onclick="window.history.go(-1);"
         type="button" class="am-btn am-btn-default am-btn-xs"
         style="margin-top: 4px;margin-bottom: 6px;margin-left:2px;height: 35px;"
         value="返回"/>
</div>
<div class="am-cf am-padding">
  <div class="am-fl am-cf">
    <strong class="am-text-primary am-text-lg">虚拟订单-评价</strong>
  </div>
</div>
<hr/>
<div class="am-g">
  <form action="<c:url value='/virtualPlan/saveOrderProductContent.do?'/>"
        method="post" enctype="multipart/form-data" class="am-form am-form-horizontal">
    <input type="hidden" name="id" value="${object.id}">
    <input type="hidden" name="planId" value="${planId}">

    <div class="am-form-group">
      <label for="username" class="am-u-sm-3 am-form-label">用户<small>*</small></label>
      <div class="am-u-sm-9">
        <input type="text" name="username" id="username"
               title="用户" placeholder="用户"
               value="${object.purchaseOrder.user.username}" readonly>
      </div>
    </div>

    <div class="am-form-group">
      <label for="serial" class="am-u-sm-3 am-form-label">商品编号<small>*</small></label>
      <div class="am-u-sm-9">
        <input type="text" name="serial" id="serial"
               title="商品编号" placeholder="商品编号"
               value="${object.productModel.serial}" readonly>
      </div>
    </div>

    <div class="am-form-group">
      <label for="pName" class="am-u-sm-3 am-form-label">商品名称<small>*</small></label>
      <div class="am-u-sm-9">
        <input type="text" name="pName" id="pName"
               title="商品名称" placeholder="商品名称"
               value="${object.productModel.product.name}[${object.productModel.name}]" readonly>
      </div>
    </div>

    <div class="am-form-group">
      <label for="orderCost" class="am-u-sm-3 am-form-label">订单金额<small>*</small></label>
      <div class="am-u-sm-9">
        <input type="text" name="orderCost" id="orderCost"
               title="订单金额" placeholder="订单金额"
               value="${object.purchasePrice}" readonly>
      </div>
    </div>

    <div class="am-form-group">
      <label for="datetime" class="am-u-sm-3 am-form-label">下单时间<small>*</small></label>
      <div class="am-u-sm-9">
        <input type="text" name="datetime" id="datetime"
               title="下单时间" placeholder="下单时间"
               value="<fmt:formatDate value="${object.purchaseOrder.createDatetime}" pattern="yyyy-MM-dd HH:mm:ss"/>" readonly>
      </div>
    </div>

    <div class="am-form-group">
      <label for="content" class="am-u-sm-3 am-form-label">评价<small>*</small></label>
      <div class="am-u-sm-9">
        <textarea name="content" id="content"
                  title="评价" placeholder="评价"
                  required>${object.purchaseOrderComment.content}</textarea>
      </div>
    </div>

    <div class="am-form-group">
      <div class="am-u-sm-9 am-u-sm-push-3">
        <input type="submit" class="am-btn am-btn-primary" value="保存"/>
      </div>
    </div>

  </form>
</div>

</body>
</html>
