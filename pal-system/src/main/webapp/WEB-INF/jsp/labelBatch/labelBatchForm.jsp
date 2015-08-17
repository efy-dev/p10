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
    <%--<script type="text/javascript" src="<c:url value='/resources/jquery/jquery-1.11.1.min.js'/>"></script>--%>
    <script type="text/javascript">
        function openProduct(id, name, type){
            var tenantId = document.getElementById("tenant_id").value;
            if(tenantId == null || tenantId == ""){
                alert("请先选择商户!");
            }else {
                var url = "/tenant/one/json?tenantId=" + tenantId;
                $.ajax({
                    type: "post",
                    url: url,
                    cache: false,
                    dataType: "json",
                    success: function (data) {
                        m8uDialog.openDialog(id, name, type, data);
                    }
                });
            }
        }
    </script>
</head>
<body>
<div class="am-cf am-padding">
    <c:if test="${empty object || object.id == null || object.id==''}">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">新建标签批次</strong> / <small>New LabelBatch</small>
        </div>
    </c:if>
    <c:if test="${!empty object && object.id != null && object.id != '' }">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">编辑标签批次</strong> / <small>Edit LabelBatch</small>
        </div>
    </c:if>
</div>
<hr/>

<div class="am-g">
    <form action="<c:url value='/basic/xm.do'/>" method="post" class="am-form am-form-horizontal">
        <input type="hidden" name="qm" value="saveOrUpdateLabelBatch">
        <input type="hidden" name="id" value="${object.id}">
        <c:if test="${empty object || object.id == null || object.id==''}">
            <input type="hidden" name="status" value="1" />
        </c:if>
        <c:if test="${!empty object && object.id != null && object.id != '' }">
            <input type="hidden" name="status" value="${object.status}" />
        </c:if>

        <div class="am-form-group">
            <label name="setting" for="setting" class="am-u-sm-3 am-form-label">标签批次 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="setting" id="setting" placeholder="标签批次" value="${object.setting}" required>
            </div>
        </div>
        <div class="am-form-group">
            <label name="amount" for="amount" class="am-u-sm-3 am-form-label">数量 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="amount" id="amount" placeholder="数量" value="${object.amount}" required>
            </div>
        </div>
        <%--<div class="am-form-group">--%>
            <%--<label name="tenant_id" for="tenant_idName" class="am-u-sm-3 am-form-label">商户名称 <small>*</small></label>--%>
            <%--<div class="am-u-sm-9">--%>
                <%--<input id="tenant_idName" placeholder="商户名称" onclick="m8uDialog.openDialog('tenant_id','tenant_idName','tenant', null)" value="${object.tenant.name}" required>--%>
                <%--<input type="hidden" id="tenant_id"  name="tenant.id" value="${object.tenant.id}">--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="am-form-group">--%>
            <%--<label name="product_id" for="product_idName" class="am-u-sm-3 am-form-label">商品名称 <small>*</small></label>--%>
            <%--<div class="am-u-sm-9">--%>
                <%--<input id="product_idName" placeholder="商品名称" onclick="openProduct('product_id', 'product_idName', 'product2')" required>--%>
                <%--<input type="hidden" id="product_id"  name="product.id">--%>
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
