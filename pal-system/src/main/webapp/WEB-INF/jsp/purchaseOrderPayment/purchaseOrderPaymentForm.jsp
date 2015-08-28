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
<html>
<head>
    <title></title>
    <script type="text/javascript">
        function formOnSubmit(){
            var payWayDiv = document.getElementById("payWayDiv");
            var payWay = payWayDiv.firstElementChild.value;
            if(payWay == null || payWay == ""){
                alert("请选择支付方式");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">订单支付</strong>
    </div>
</div>
<hr/>
<div class="am-g">
    <form action="<c:url value='/purchaseOrderPayment/savePurchaseOrderPayment.do'/>" onsubmit="return formOnSubmit()" method="post" class="am-form am-form-horizontal">
        <input type="hidden" name="id" value="${object.id}">
        <input type="hidden" name="status" value="${object.status}" />
        <div class="am-form-group">
            <label name="purchaseOrder.idName" for="purchaseOrder.idName" class="am-u-sm-3 am-form-label">订单编号 <small>*</small></label>
            <div class="am-u-sm-9">
                <c:if test="${empty object || object.id == null || object.id==''}">
                    <input type="text" name="purchaseOrder.idName" id="purchaseOrder.idName" placeholder="订单编号" value="${purchaseOrder.serial}" readonly>
                    <input type="hidden" name="purchaseOrder.id" value="${purchaseOrder.id}" readonly>
                </c:if>
                <c:if test="${not empty object && object.id != null && object.id != '' }">
                    <input type="text" name="purchaseOrder.idName" id="purchaseOrder.idName" placeholder="订单编号" value="${object.purchaseOrder.serial}" readonly>
                    <input type="hidden" name="purchaseOrder.id" value="${object.purchaseOrder.id}" readonly>
                </c:if>
            </div>
        </div>
        <div class="am-form-group">
            <label name="payWay" for="payWay" class="am-u-sm-3 am-form-label">支付方式 <small>*</small></label>
            <div class="am-u-sm-9" id="payWayDiv">
                <ming800:status name="payWay" dataType="PCPurchaseOrderPayment.payWay" checkedValue="${object.payWay}" type="select"/>
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
