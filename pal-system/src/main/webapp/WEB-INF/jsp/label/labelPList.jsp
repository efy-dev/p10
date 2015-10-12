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
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">标签列表</strong>
    </div>
</div>
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
<jsp:include page="/layouts/myConfirm.jsp"/>
<div>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr>
            <td>
                <div id="thDiv">
                    操作
                    <c:if test="${not empty requestScope.pageInfo.list}">
                        <button onclick="myConfirm('<c:url value="/Label/cancelLabelListAjax.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>', 'CL')"
                                style="margin-right:2px;height: 30px"
                                class="am-btn am-btn-default am-btn-xs am-text-danger">全部作废</button>
                    </c:if>
                </div>
            </td>
            <td>序列号</td>
            <td>防伪码</td>
            <td>批次序号</td>
            <td>标签类型</td>
            <td>商品</td>
            <td>商户</td>
            <td>状态</td>
            <td>第一次查询时间</td>
            <td>最近一次查询时间</td>
            <td>查询次数</td>
        </tr>

        <c:forEach items="${requestScope.pageInfo.list}" var="label">
            <tr>
                <td>
                    <div class="am-btn-toolbar">
                        <div class="am-btn-group am-btn-group-xs" style="width: 100%;" >
                            <button onclick="window.location.href='<c:url value="/basic/xm.do?qm=plistLabelCheckRecord_label&conditions=label.serial:${label.serial}"/>'"
                                    class="am-btn am-btn-default am-btn-xs">查询记录</button>
                            <c:if test="${label.status != '4'}">
                                <button onclick="myConfirm('<c:url value="/Label/cancelLabelAjax.do?id=${label.id}"/>', 'CA')"
                                        class="am-btn am-btn-default am-btn-xs am-text-danger">作废</button>
                            </c:if>
                        </div>
                    </div>
                </td>
                <td><a href="<c:url value='/basic/xm.do?qm=viewLabel&label=view&id=${label.id}'/>">${label.serial}</a></td>
                <td>${label.code}</td>
                <td>${label.labelBatch.serial}</td>
                <td>
                    <ming800:status name="type" dataType="PCLabelBatch.type" checkedValue="${label.labelBatch.type}" type="normal"/>
                </td>
                <td>
                    <c:if test="${label.purchaseOrderLabel != null && not empty label.purchaseOrderLabel}">
                        <c:if test="${label.purchaseOrderLabel.product != null && not empty label.purchaseOrderLabel.product}">
                            ${label.purchaseOrderLabel.product.name}
                        </c:if>
                    </c:if>
                </td>
                <td>
                    <c:if test="${label.seller != null && !empty label.seller}">
                        ${label.seller.name}
                    </c:if>
                </td>
                <td>
                    <ming800:status name="status" dataType="PCLabel.status" checkedValue="${label.status}" type="normal"/>
                </td>
                <td><fmt:formatDate value="${label.firstCheckDateTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                <td><fmt:formatDate value="${label.lastCheckDateTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                <td>${label.checkCount} 次</td>
            </tr>
        </c:forEach>
    </table>
    <div style="clear: both">
        <c:url value="/basic/xm.do" var="url" />
        <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
            <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
            <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
        </ming800:pcPageList>
    </div>
</div>
</body>
</html>
