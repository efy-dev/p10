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
        <strong class="am-text-primary am-text-lg">标签详情</strong> / <small>Label Information</small>
    </div>
</div>

<div am-panel am-panel-default admin-sidebar-panel>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr>
            <td align="right">序列号：</td>
            <td>${object.serial}</td>
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
<%--<script type="text/javascript">--%>
<%--//    $.post()--%>
<%--//    $("art").html();--%>
<%--//    $("art").innerHTML();--%>
<%--/basic/xm.do?qm=plistLabelCheckRecord_default&conditions=label.id:${label.id}--%>
<%--</script>--%>
<%--<c:if test="${object.checkCount != '0' || object.checkCount != 0 }">--%>
    <%--<div class="am-cf am-padding">--%>
        <%--<div class="am-fl am-cf">--%>
            <%--<strong class="am-text-primary am-text-lg">标签查询记录</strong> / <small>Anti-counterfeiting inquiry Record</small>--%>
        <%--</div>--%>
    <%--</div>--%>
    <%--<div  class="am-g">--%>
        <%--<table class="am-table am-table-bordered am-table-radius am-table-striped">--%>
            <%--<tr>--%>
                <%--<td>标签序列号</td>--%>
                <%--<td>标签批次</td>--%>
                <%--<td>商品名称</td>--%>
                <%--<td>商户名称</td>--%>
                <%--<td>防伪验证IP</td>--%>
                <%--<td>验证时间</td>--%>
            <%--</tr>--%>
            <%--<c:forEach items="${object.labelCheckRecordList}" var="record">--%>
                <%--<tr>--%>
                    <%--<td><a href="<c:url value='/basic/xm.do?qm=viewLabel&id=${record.label.id}'/>">${record.label.serial}</a></td>--%>
                    <%--<td><a href="<c:url value='/basic/xm.do?qm=viewLabelBatch&id=${record.label.labelBatch.id}'/>">${record.label.labelBatch.setting}</a></td>--%>
                    <%--<td><a href="<c:url value='/basic/xm.do?qm=viewProduct&id=${record.product.id}'/>">${record.product.name}</a></td>--%>
                    <%--<td><a href="<c:url value='/basic/xm.do?qm=viewTenant&id=${record.product.tenant.id}'/>">${record.product.tenant.name}</a></td>--%>
                    <%--<td>${record.IP}</td>--%>
                    <%--<td><fmt:formatDate value="${record.createDatetime}" pattern="yyyy-MM-dd HH:mm"/> </td>--%>
                <%--</tr>--%>
            <%--</c:forEach>--%>
        <%--</table>--%>
    <%--</div>--%>
<%--</c:if>--%>

</body>
</html>
