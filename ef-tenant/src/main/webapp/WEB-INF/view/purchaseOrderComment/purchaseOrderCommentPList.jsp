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
 <script>
 </script>

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
                    <th class="table-title">评价商品</th>
                    <th class="table-title">商品规格</th>
                    <th class="table-title">评论用户</th>
                    <th class="table-title">星数</th>
                    <th class="table-title">评价日期</th>
                    <th class="table-title">评价内容</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${requestScope.pageInfo.list}" var="purchaseOrderComment">
                    <tr>
                        <td class="am-hide-sm-only"><a
                                href="<c:url value='/basic/xm.do?qm=viewPurchaseOrderProduct&view=${view}&id=${purchaseOrderComment.purchaseOrderProduct.id}'/>">${purchaseOrderComment.purchaseOrderProduct.productModel.product.name}</a>
                        </td>
                        <td class="am-hide-sm-only">${purchaseOrderComment.purchaseOrderProduct.productModel.name}</td>
                        <td class="am-hide-sm-only">${purchaseOrderComment.purchaseOrderProduct.purchaseOrder.user.username}</td>
                        <td class="am-hide-sm-only">${purchaseOrderComment.starts}</td>
                        <td class="am-hide-sm-only"><fmt:formatDate value="${purchaseOrderComment.createDatetime}"
                                                                    type="both" pattern="yyyy-MM-dd HH:mm:ss"/></td>

                        <td class="am-hide-sm-only">${purchaseOrderComment.content}</td>
                    </tr>
                    <c:if test="${ !empty(purchaseOrderComment.subPurchaseOrderComment)}">
                        <tr>
                            <td class="am-hide-sm-only"><a
                                    href="<c:url value='/basic/xm.do?qm=viewPurchaseOrderProduct&id=${purchaseOrderComment.purchaseOrderProduct.id}'/>">${purchaseOrderComment.purchaseOrderProduct.productModel.product.name}</a>
                            </td>
                            <td class="am-hide-sm-only">${purchaseOrderComment.subPurchaseOrderComment.purchaseOrderProduct.productModel.name}</td>
                            <td class="am-hide-sm-only">${purchaseOrderComment.subPurchaseOrderComment.purchaseOrderProduct.purchaseOrder.user.username}</td>
                            <td class="am-hide-sm-only">${purchaseOrderComment.subPurchaseOrderComment.starts}</td>
                            <td class="am-hide-sm-only"><fmt:formatDate value="${purchaseOrderComment.subPurchaseOrderComment.createDatetime}"
                                                                        type="both" pattern="yyyy-MM-dd HH:mm:ss"/></td>

                            <td class="am-hide-sm-only">${purchaseOrderComment.subPurchaseOrderComment.content}</td>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div style="clear: both">
        <c:url value="/basic/xm.do" var="url"/>
        <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
            <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
            <ming800:pcPageParam name="view" value="delivery"/>
            <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
        </ming800:pcPageList>
    </div>
</div>
</body>
</html>
