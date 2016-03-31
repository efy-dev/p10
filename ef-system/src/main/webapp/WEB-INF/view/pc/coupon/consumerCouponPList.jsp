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
    <%--<script>--%>
        <%--function removeCoupon(couponId) {--%>
            <%--jQuery.ajax({--%>
                <%--type: "GET",--%>
                <%--url: '<c:url value="/basic/xmj.do?qm=removeCoupon"/>',--%>
                <%--data: {id: couponId},--%>
                <%--dataType: "json",--%>
                <%--success: function (data) {--%>
                    <%--$("#" + couponId).remove();--%>
                <%--}--%>
            <%--});--%>
        <%--}--%>
    <%--</script>--%>
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
                    <%--<th class="table-set">操作</th>--%>
                    <th class="table-title">优惠券编号</th>
                    <th class="table-title">优惠券批次</th>
                    <th class="table-title">优惠价格</th>
                    <th class="table-title">使用限制价格</th>
                    <th class="table-title">优惠券状态</th>
                    <th class="table-title">生效日期</th>
                    <th class="table-title">失效日期</th>
                </tr>
                </thead>
                <tbody>

                <c:forEach items="${requestScope.pageInfo.list}" var="coupon">
                    <tr id="${coupon.id}">
                        <%--<td>--%>
                            <%--<div class="am-btn-toolbar">--%>
                                <%--<div class="am-btn-group am-btn-group-xs">--%>
                                    <%--<button class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"--%>
                                            <%--onclick="showConfirm('提示','是否删除',function(){removeCoupon('${coupon.id}')})"><span--%>
                                            <%--class="am-icon-trash-o">删除</span>--%>
                                    <%--</button>--%>
                                <%--</div>--%>
                            <%--</div>--%>
                        <%--</td>--%>
                        <td class="am-hide-sm-only">${coupon.serial}</td>
                        <td class="am-hide-sm-only">${coupon.couponBatch.name}</td>
                        <td class="am-hide-sm-only">${coupon.couponBatch.price}</td>
                        <td class="am-hide-sm-only">${coupon.couponBatch.priceLimit}</td>
                        <td class="am-hide-sm-only">
                            <ming800:status name="status" dataType="Coupon.status"
                                            checkedValue="${coupon.status}"
                                            type="normal"/>

                        </td>
                        <td class="am-hide-sm-only">
                            <fmt:formatDate value="${coupon.couponBatch.startDate}" pattern="yyyy:MM:dd hh:mm:ss"/>
                        </td>
                        <td class="am-hide-sm-only">
                            <fmt:formatDate value="${coupon.couponBatch.endDate}" pattern="yyyy:MM:dd hh:mm:ss"/>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div style="clear: both">
        <c:url value="/basic/xm.do" var="url"/>
        <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
            <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
            <ming800:pcPageParam name="view" value="${view}"/>
            <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
        </ming800:pcPageList>
    </div>
</div>


</body>
</html>
