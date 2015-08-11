<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/25
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>

<html>
<head>
    <title></title>
    <script type="text/javascript" src="<c:url value='/scripts/jquery-1.11.1.min.js'/>"></script>
</head>
<body>
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
<div class="admin-content">
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-6">
        </div>
        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
                    <th class="table-title">发货记录编号</th>
                    <th class="table-title">订单号</th>
                    <th class="table-title">发送日期</th>
                    <th class="table-title">发送地址</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${requestScope.pageInfo.list}" var="purchaseOrderDelivery">
                    <tr>
                        <%--<td class="am-hide-sm-only"><a href="<c:url value='/basic/xm.do?qm=viewPurchaseOrderDelivery&id=${purchaseOrderDelivery.id}'/>">${purchaseOrderDelivery.serial}</a></td>--%>
                        <td class="am-hide-sm-only"><a href="<c:url value='/basic/xm.do?qm=viewPurchaseOrderDelivery&id=${purchaseOrderDelivery.id}'/>">${purchaseOrderDelivery.serial}</a></td>
                        <td class="am-hide-sm-only"><a href="<c:url value='/basic/xm.do?qm=viewPurchaseOrder&id=${purchaseOrderDelivery.purchaseOrder.id}'/>">${purchaseOrderDelivery.purchaseOrder.serial}</a></td>
                        <td class="am-hide-sm-only"><fmt:formatDate value="${purchaseOrderDelivery.createDateTime}" type="both" pattern="yyyy-MM-dd HH:mm"/></td>
                        <td class="am-hide-sm-only">${purchaseOrderDelivery.consumerAddress.province.name}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div style="clear: both">
        <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="/basic/xm.do">
            <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
            <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
        </ming800:pcPageList>
    </div>
</div>
</body>
</html>
