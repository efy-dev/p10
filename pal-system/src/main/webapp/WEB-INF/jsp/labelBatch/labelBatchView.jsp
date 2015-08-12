<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/22
  Time: 16:17
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
<div align="center" am-panel am-panel-default admin-sidebar-panel>
    <h1>标签批次${object.setting}详情</h1>
</div>
<div am-panel am-panel-default admin-sidebar-panel>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr>
            <td align="right">标签批次：</td>
            <td>${object.setting}</td>
        </tr>
        <tr>
            <td align="right">开始：</td>
            <td>${object.start}</td>
        </tr>
        <tr>
            <td align="right">数量：</td>
            <td>${object.amount}</td>
        </tr>
        <tr>
            <td align="right">创建时间：</td>
            <td><fmt:formatDate value="${object.createDate}" pattern="yyyy-MM-dd"/> </td>
        </tr>
        <tr>
            <td align="right">状态：</td>
            <td>
                <c:if test="${object.status == '0'}">
                    已删除
                </c:if>
                <c:if test="${object.status == '1'}">
                    <font color="green">待生成</font>
                </c:if>
                <c:if test="${object.status == '2'}">
                    <font color="#a52a2a">已生成</font>
                </c:if>
            </td>
        </tr>
        <tr>
            <td align="right">商品名称：</td>
            <td>${object.product.name}</td>
        </tr>
        <tr>
            <td align="right">商户：</td>
            <td>${object.tenant.name}</td>
        </tr>
        <tr>
            <td align="right">订单序列号：</td>
            <td>${object.purchaseOrder.serial}</td>
        </tr>
    </table>
</div>
</body>
</html>
