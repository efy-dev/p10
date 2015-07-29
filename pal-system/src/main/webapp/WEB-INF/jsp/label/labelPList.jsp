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
<div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">标签列表</strong> / <small>LabelList</small></div>
</div>
<table class="am-table am-table-bordered am-table-radius am-table-striped">
    <tr>
        <td>labelId</td>
        <td>序列号</td>
        <td>卷批次</td>
        <td>商品</td>
        <td>商户</td>
        <td>状态</td>
        <td>使用时间</td>
    </tr>

    <c:forEach items="${requestScope.pageInfo.list}" var="label">
        <tr>
            <td>${label.id}</td>
            <td>${label.serial}</td>
            <td>${label.labelBatch.setting}</td>
            <td>${label.product.name}</td>
            <td>${label.seller.name}</td>
            <td>
                <c:if test="${label.status == '0'}">
                    <font color="red">已验证</font>
                </c:if>
                <c:if test="${label.status == '1'}">
                    <font color="green">未验证</font>
                </c:if>
            </td>
            <td><fmt:formatDate value="${label.usedDate}" pattern="yyyy-MM-dd HH:mm"/></td>
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
