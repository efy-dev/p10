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
<table class="am-table am-table-bordered am-table-radius am-table-striped">
    <tr style="text-align: center">
        <td>操作</td>
        <td>订单号</td>
        <td>购买物品</td>
        <td>收货人</td>
        <td>下单时间</td>
    </tr>

    <c:forEach items="${requestScope.pageInfo.list}" var="purchaseOrder">
        <tr style="text-align: center">
            <td width="20%">
                <div class="am-btn-toolbar">
                    <div class="am-btn-group am-btn-group-xs" style="width: 100%" >
                        <button style="margin-left: 30%;" onclick="window.location.href='/basic/xm.do?qm=viewPurchaseOrder&id=${purchaseOrder.id}'"  class="am-btn am-btn-default am-btn-xs am-text-secondary"><span class="am-icon-book"></span> 详情</button>
                        <button onclick="window.location.href='/basic/xm.do?qm=removePurchaseOrder&id=${purchaseOrder.id}'" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 删除</button>
                    </div>
                </div>
            </td>
            <td width="20%">${purchaseOrder.serial}</td>
            <td width="20%">
            <c:forEach items="${purchaseOrder.purchaseOrderProductList}" var="purchaseOrderProduct">
                <span style="margin-left: 2px;"><a href="#"> ${purchaseOrderProduct.product.name}</a></span>
            </c:forEach>
            </td>
            <td width="10%">${purchaseOrder.user.name}</td>
            <td width="10%">
                <fmt:formatDate value="${purchaseOrder.createDatetime}" type="both" pattern="YYYY-MM-dd HH:mm" />
            </td>
        </tr>
    </c:forEach>
</table>
<div style="clear: both">
    <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="/basic/xm.do">
        <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
        <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
    </ming800:pcPageList>
</div>

</body>
</html>
