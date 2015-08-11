<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title></title>
    <style>
    </style>
</head>
<body>
<div class="am-g">
    <div class="am-u-md-12">
        <table class="am-table am-table-bordered">
            <thead>
            <tr>
                <th>优惠券批次</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">名字</td>
                <td class="am-u-md-3">${object.name}</td>
                <td class="am-primary am-u-md-3">数量</td>
                <td class="am-u-md-3">${object.amount}</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">生效日期</td>
                <td class="am-u-md-3">
                    <fmt:formatDate value="${object.startDate}" pattern="yyyy-mm-dd"/>
                </td>
                <td class="am-primary am-u-md-3">失效日期</td>
                <td class="am-u-md-3">
                    <fmt:formatDate value="${object.endDate}" pattern="yyyy-mm-dd"/>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>


<div class="am-g">
    <div class="am-u-sm-12 am-u-md-6">
        <h4>优惠券</h4>
    </div>
    <div class="am-u-sm-12">
        <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
            <tr>
                <th class="table-title">优惠券id</th>
                <th class="table-title">优惠券状态</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${object.couponList}" var="coupon" varStatus="stat">
            <tr>
                <td class="am-hide-sm-only">${coupon.id}</td>
                <td class="am-hide-sm-only">
                    <ming800:status name="status" dataType="coupon.status"
                                    checkedValue="${coupon.status}"
                                    type="normal"/>
                </td>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
