<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/12/14
  Time: 13:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title>物流发送失败订单</title>
</head>
<body style="height: auto">
<span style="text-align: left;margin-left: 10px;">
    <input onclick="window.history.go(-1);"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 4px;margin-bottom: 6px;margin-left:2px;height: 35px;"
           value="返回"/>
</span>
<div>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr style="text-align:left">
            <td>订单序列号</td>
            <td>商品规格</td>
            <td>商品名</td>
            <td>购买数量</td>
            <td>价格</td>
            <td>发送详情</td>
        </tr>
        <c:forEach items="${pageInfo.list}" var="purchaseOrderProduct">
            <tr>
                <td>${purchaseOrderProduct.purchaseOrder.serial}</td>
                <td>${purchaseOrderProduct.productModel.name}</td>
                <td>${purchaseOrderProduct.productModel.product.name}</td>
                <td>${purchaseOrderProduct.purchaseAmount}</td>
                <td>${purchaseOrderProduct.productModel.price}</td>
                <td>${purchaseOrderProduct.purchaseOrder.message}</td>
            </tr>
        </c:forEach>
    </table>
</div>
<div style="clear: both">
    <c:url value="/basic/xm.do" var="url"/>
    <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
        <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
        <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
    </ming800:pcPageList>
</div>
<script>
    if (${not empty msg}) {
        alert("${msg}");
    }
</script>
</body>
</html>
