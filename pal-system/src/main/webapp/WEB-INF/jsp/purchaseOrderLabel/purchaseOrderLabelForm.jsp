<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@include file="/layouts/public.jsp" %>
<html>
<head>
    <title></title>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">订单商品选择</strong>
    </div>
</div>
<hr/>
<div class="am-g">
    <form id="productLabelForm" onsubmit="return selectObjectSubmit('POType')" action="<c:url value='/purchaseOrderLabel/savePurchaseOrderLabel.do'/>" method="post" class="am-form am-form-horizontal">
        <input type="hidden" name="id" value="${object.id}">
        <input type="hidden" name="status" value="${object.status}" />
        <div class="am-form-group">
            <label name="purchaseOrder.idName" for="purchaseOrder.idName" class="am-u-sm-3 am-form-label">订单编号 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="purchaseOrder.idName" id="purchaseOrder.idName" placeholder="订单编号" value="${object.purchaseOrder.serial}" readonly>
                <input type="hidden" name="purchaseOrder.id" value="${object.purchaseOrder.id}" readonly>
            </div>
        </div>
        <div class="am-form-group">
            <label name="product_id" for="product_idName" class="am-u-sm-3 am-form-label">商品名称 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" id="product_idName" placeholder="商品名称"
                       onclick="m8uDialog.openDialog('product_id', 'product_idName', 'product2', '${object.purchaseOrder.tenant.id}','<%=path%>')"
                       value="${object.product.name}" required readonly>
                <input type="hidden" id="product_id"  name="product.id" value="${object.product.id}">
            </div>
        </div>
        <div class="am-form-group">
            <label name="amount" for="amount" class="am-u-sm-3 am-form-label">数量 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="number" name="amount" id="amount" min="1" placeholder="数量" value="${object.amount}" required>
            </div>
        </div>
        <div class="am-form-group">
            <label for="type" class="am-u-sm-3 am-form-label">标签类型 <small>*</small></label>
            <div class="am-u-sm-9" id="POType">
                <ming800:status name="type" dataType="PCLabelBatch.type" checkedValue="${object.type}" type="select"/>
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
