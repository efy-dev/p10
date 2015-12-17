<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/12/14
  Time: 14:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title>企业礼品卡管理</title>
</head>
<body style="height: auto">
<div style="text-align: left;margin-left: 10px;">
    <input onclick="window.history.go(-1);"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 4px;margin-bottom: 6px;margin-left:2px;height: 35px;"
           value="返回"/>
</div>
<div>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr style="text-align:left">
            <td>礼品卡编号</td>
            <td>企业用户</td>
            <td>礼品名称</td>
            <td>礼品数量</td>
            <td>礼品卡状态</td>
            <td>礼品卡类型</td>
            <td>创建时间</td>
        </tr>
        <c:forEach items="${requestScope.pageInfo.list}" var="gift">
            <tr>
                <td>${gift.serial}</td>
                <td>${gift.companyOrderBatch.companyName}</td>
                <td>${gift.companyOrderBatch.productModel.product.name}
                    <c:if test="${not empty gift.companyOrderBatch.productModel}">[${gift.companyOrderBatch.productModel.name}]</c:if>
                </td>
                <td>1</td>
                <td>
                    <ming800:status name="orderStatus" dataType="purchaseOrder.orderStatus" checkedValue="${gift.orderStatus}" type="normal"/>
                </td>
                <td>
                    <ming800:status name="orderType" dataType="purchaseOrder.orderType" checkedValue="${gift.orderType}" type="normal"/>
                </td>
                <td>
                    <fmt:formatDate value="${gift.createDatetime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
<div style="clear: both">
    <c:url value="/basic/xm.do" var="url"/>
    <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
        <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
        <ming800:pcPageParam name="type" value="${type}"/>
        <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
    </ming800:pcPageList>
</div>
</body>
</html>
