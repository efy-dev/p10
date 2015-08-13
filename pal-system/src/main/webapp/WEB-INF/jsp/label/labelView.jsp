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
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">标签详情</strong>
    </div>
</div>

<div am-panel am-panel-default admin-sidebar-panel>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr>
            <td align="right">序列号：</td>
            <td>${object.serial}</td>
        </tr>
        <tr>
            <td align="right">防伪码：</td>
            <td>${object.code}</td>
        </tr>
        <tr>
            <td align="right">所属批次：</td>
            <td>${object.labelBatch.setting}</td>
        </tr>
        <tr>
            <td align="right">所属商品：</td>
            <td>${object.product.name}</td>
        </tr>
        <tr>
            <td align="right">商户名称：</td>
            <td>${object.seller.name}</td>
        </tr>
        <tr>
            <td align="right">第一次查询时间：</td>
            <td><fmt:formatDate value="${object.firstCheckDateTime}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
        </tr>
        <tr>
            <td align="right">最近一次查询时间：</td>
            <td><fmt:formatDate value="${object.lastCheckDateTime}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
        </tr>
        <tr>
            <td align="right">查询次数：</td>
            <td>
                <c:if test="${object.checkCount != '0' || object.checkCount != 0 }">
                    <a href="<c:url value='/basic/xm.do?qm=plistLabelCheckRecord_default&conditions=label.id:${object.id}'/>">${object.checkCount}次</a>
                </c:if>
                <c:if test="${object.checkCount == '0' || object.checkCount == 0 }">
                    ${object.checkCount}次
                </c:if>
            </td>
        </tr>
        <tr>
            <td align="right">状态：</td>
            <td>
                <c:if test="${object.status == '2'}">
                    <font color="red">已验证</font>
                </c:if>
                <c:if test="${object.status == '1'}">
                    <font color="green">未验证</font>
                </c:if>
            </td>
        </tr>
    </table>
</div>

</body>
</html>
