<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/25
  Time: 14:20
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
    <script type="text/javascript" src="<c:url value='/resources/jquery/jquery-1.11.1.min.js'/>"></script>
</head>
<body style="height: auto">
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">标签防伪查询记录</strong> / <small>Anti-counterfeiting inquiry Record</small>
    </div>
</div>
<div  class="am-g">
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr>
            <td>标签序列号</td>
            <td>标签批次</td>
            <td>商品名称</td>
            <td>商户名称</td>
            <td>防伪验证IP</td>
            <td>验证时间</td>
        </tr>
        <c:forEach items="${requestScope.pageInfo.list}" var="record">
            <tr>
                <td><a href="<c:url value='/basic/xm.do?qm=viewLabel&id=${record.label.id}'/>">${record.label.serial}</a></td>
                <td><a href="<c:url value='/basic/xm.do?qm=viewLabelBatch&id=${record.label.labelBatch.id}'/>">${record.label.labelBatch.setting}</a></td>
                <td><a href="<c:url value='/basic/xm.do?qm=viewProduct&id=${record.product.id}'/>">${record.product.name}</a></td>
                <td><a href="<c:url value='/basic/xm.do?qm=viewTenant&id=${record.product.tenant.id}'/>">${record.product.tenant.name}</a></td>
                <td>${record.IP}</td>
                <td><fmt:formatDate value="${record.createDatetime}" pattern="yyyy-MM-dd HH:mm"/> </td>
            </tr>
        </c:forEach>
    </table>
</div>
<div style="clear: both">
    <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="/basic/xm.do">
        <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
        <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
    </ming800:pcPageList>
</div>
</body>
</html>
