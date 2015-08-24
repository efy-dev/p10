<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title></title>
    <script type="text/javascript">
        function TimeToString(date){
            var year = date.getFullYear();
            var month = date.getMonth() + 1;
            var day = date.getDate();
            var hour = date.getHours();
            var min = date.getMinutes();
            var sec = date.getSeconds();

            var dateStr = year + "";
            if ( month >= 10 ) {
                dateStr = dateStr + month + "";
            } else {
                dateStr = dateStr + "0" + month + "";
            }
            if ( day >= 10 ) {
                dateStr = dateStr + day + "";
            } else {
                dateStr = dateStr + "0" + day + "";
            }
            if ( hour >= 10 ) {
                dateStr = dateStr + hour + "";
            } else {
                dateStr = dateStr + "0" + hour + "";
            }
            if ( min >= 10 ) {
                dateStr = dateStr + min + "";
            } else {
                dateStr = dateStr + "0" + min + "";
            }
            if ( sec >= 10 ) {
                dateStr = dateStr + sec + "";
            } else {
                dateStr = dateStr + "0" + sec + "";
            }

            return dateStr;
        }
    </script>
</head>
<body>
<div class="am-cf am-padding">
    <c:if test="${empty object || object.id == null || object.id==''}">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">新建订单</strong>
        </div>
    </c:if>
    <c:if test="${!empty object && object.id != null && object.id != '' }">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">编辑订单</strong>
        </div>
    </c:if>
</div>
<hr/>

<div class="am-g">
    <%--<form action="<c:url value='/order/savePurchaseOrder.do'/>" method="post" class="am-form am-form-horizontal">--%>
    <form action="<c:url value='/basic/xm.do'/>" method="post" class="am-form am-form-horizontal">
        <input type="hidden" name="qm" value="saveOrUpdatePurchaseOrder">
        <input type="hidden" name="id" value="${object.id}">
        <c:if test="${empty object || object.id == null || object.id==''}">
            <input type="hidden" name="status" value="1" />
        </c:if>
        <c:if test="${!empty object && object.id != null && object.id != '' }">
            <input type="hidden" name="status" value="${object.status}" />
        </c:if>

        <div class="am-form-group">
            <label name="serial" for="serial" class="am-u-sm-3 am-form-label">订单编号 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="serial" id="serial" placeholder="订单编号" value="${object.serial}" required readonly>
            </div>
            <script type="text/javascript">
                var date = new Date();
                document.getElementById("serial").value = TimeToString(date);
            </script>
        </div>

        <div class="am-form-group">
            <label name="tenant_id" for="tenant_idName" class="am-u-sm-3 am-form-label">商户名称 <small>*</small></label>
            <div class="am-u-sm-9">
                <input id="tenant_idName" placeholder="商户名称" onclick="m8uDialog.openDialog('tenant_id','tenant_idName','tenant', null)" value="${object.tenant.name}" required>
                <input type="hidden" id="tenant_id"  name="tenant.id" value="${object.tenant.id}">
            </div>
        </div>

        <%--<div class="am-form-group">--%>
            <%--<label name="user_id" for="user_idName" class="am-u-sm-3 am-form-label">用户名称 <small>*</small></label>--%>
            <%--<div class="am-u-sm-9">--%>
                <%--<input id="user_idName" placeholder="用户名称" onclick="m8uDialog.openDialog('user_id','user_idName','user', null)" value="${object.user.name}" required>--%>
                <%--<input type="hidden" id="user_id"  name="user.id" value="${object.user.id}">--%>
            <%--</div>--%>
        <%--</div>--%>

        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="submit" class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>

    </form>
</div>

</body>
</html>
