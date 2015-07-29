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
</head>
<body>
<div class="am-cf am-padding">
    <c:if test="${empty object || object.id == null || object.id==''}">
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">新建标签批次</strong> / <small>New LabelBatch</small></div>
    </c:if>
    <c:if test="${!empty object && object.id != null && object.id != '' }">
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">编辑标签批次</strong> / <small>Edit LabelBatch</small></div>
    </c:if>
</div>
<hr/>

<div class="am-g">
    <form action="/basic/xm.do" method="post" class="am-form am-form-horizontal">
        <input type="hidden" name="qm" value="saveOrUpdateLabelBatch">
        <input type="hidden" name="id" value="${object.id}">
        <input type="hidden" name="status" value="1" />

        <div class="am-form-group">
            <label name="setting" for="setting" class="am-u-sm-3 am-form-label">标签批次 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="setting" id="setting" placeholder="标签批次" value="${object.setting}">
            </div>
        </div>
        <div class="am-form-group">
            <label name="start" for="start" class="am-u-sm-3 am-form-label">开始 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="start" id="start" placeholder="开始" value="${object.start}">
            </div>
        </div>
        <div class="am-form-group">
            <label name="amount" for="amount" class="am-u-sm-3 am-form-label">数量 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="amount" id="amount" placeholder="数量" value="${object.amount}">
            </div>
        </div>
        <%--<div class="am-form-group">--%>
            <%--<label name="amount" for="" class="am-u-sm-3 am-form-label">商品名称 <small>*</small></label>--%>
            <%--<div class="am-u-sm-9">--%>
                <%--<input type="text" name="amount" id="" placeholder="商品名称" value="${object.amount}">--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="am-form-group">--%>
            <%--<label name="amount" for="" class="am-u-sm-3 am-form-label">商户名称 <small>*</small></label>--%>
            <%--<div class="am-u-sm-9">--%>
                <%--<input type="text" name="" id="" placeholder="数量" value="${object.amount}">--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="am-form-group">--%>
            <%--<label name="type" for="type" class="am-u-sm-3 am-form-label">项目类型 <small>*</small></label>--%>
            <%--<div class="am-u-sm-9">--%>
                <%--<ming800:status name="type" dataType="Project.type" checkedValue="${object.type}" type="select"/>--%>
            <%--</div>--%>
        <%--</div>--%>
        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="submit" class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>

        <table>
            <tr>
                <td>商品：</td>
                <%--<td><input type="text" name="product.id" id="product.id" value="${object.product.id}"></td>--%>
                <td>
                    <select name="product.id" id="product.id1">
                        <c:forEach items="${productList}" var="product">
                            <c:if test="${product.id.equals(object.product.id)}">
                                <option value="${product.id}" selected="selected">${product.name}</option>
                            </c:if>
                            <c:if test="${!product.id.equals(object.product.id)}">
                                <option value="${product.id}">${product.name}</option>
                            </c:if>
                        </c:forEach>
                    </select>
                </td>
            </tr>

            <tr>
                <td>商品：</td>
                <%--<td><input type="text" name="product.id" id="product.id" value="${object.product.id}"></td>--%>
                <td>
                    <input id="product_idName" onclick="m8uDialog.openDialog('product_id','product_idName','product',callback)">
                    <input type="hidden" id="product_id"  name="product.id">
                </td>
            </tr>


            <tr>
                <td>商户：</td>
                <%--<td><input type="text" name="tenant.id" id="tenant.id" value="${object.tenant.id}"></td>--%>
                <td>
                    <select name="tenant.id" id="tenant.id">
                        <c:forEach items="${tenantList}" var="tenant">
                            <c:if test="${tenant.id.equals(object.tenant.id)}">
                                <option value="${tenant.id}" selected="selected">${tenant.name}</option>
                            </c:if>
                            <c:if test="${!tenant.id.equals(object.product.id)}">
                                <option value="${tenant.id}">${tenant.name}</option>
                            </c:if>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td>订单：</td>
                <td><input type="text" name="purchaseOrder.id" id="purchaseOrder.id" value="${object.purchaseOrder.id}"></td>
            </tr>
        </table>
    </form>
</div>

<script>
    function callback(id){

    }
</script>
</body>
</html>
