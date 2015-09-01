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
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title></title>
</head>
<body style="height: auto">
<div style="text-align: left;margin-left: 10px;" >
    <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=formPurchaseOrder&order=order"/>'"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;"
           value="新建订单" />
</div>
<jsp:include page="/layouts/myConfirm.jsp"/>
<div>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr>
            <td>操作</td>
            <td>订单编号</td>
            <td>商户名称</td>
            <td>状态</td>
            <td>创建时间</td>
        </tr>
        <c:forEach items="${requestScope.pageInfo.list}" var="order">
            <tr style="text-align: left">
                <td>
                    <div class="am-btn-toolbar">
                        <div class="am-btn-group am-btn-group-xs" style="width: 100%;" >
                            <c:if test="${order.status == '1' || order.status == '2'}">
                                <button onclick="myConfirm('<c:url value="/basic/xm.do?qm=removePurchaseOrder&order=remove&id=${order.id}"/>', 'D')"
                                        class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 删除</button>
                            </c:if>
                        </div>
                    </div>
                </td>
                <td><a href="<c:url value="/basic/xm.do?qm=viewPurchaseOrder&order=view&id=${order.id}"/>">${order.serial}</a></td>
                <td>${order.tenant.name}</td>
                <td>
                    <ming800:status name="status" dataType="PCPurchaseOrder.status" checkedValue="${order.status}" type="normal" />
                </td>
                <td><fmt:formatDate value="${order.createDatetime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            </tr>
        </c:forEach>
    </table>
</div>
<div style="clear: both">
    <c:url value="/basic/xm.do" var="url" />
    <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
        <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
        <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
    </ming800:pcPageList>
</div>
</body>
</html>
