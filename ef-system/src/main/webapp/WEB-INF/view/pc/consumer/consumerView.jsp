<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title></title>
    <style>
    </style>
</head>
<body>
<div class="am-g" style="margin-top: 30px;">
    <div class="am-u-md-12">
        <table class="am-table am-table-bordered">
            <thead>
            <tr>
                <th>详细信息</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">用户名</td>
                <td class="am-u-md-3">${object.username}</td>
                <td class="am-primary am-u-md-3">编号</td>
                <td class="am-u-md-3">${object.serial}</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">电话</td>
                <td class="am-u-md-3">${object.phone}</td>
                <td class="am-primary am-u-md-3">邮箱</td>
                <td class="am-u-md-3">${object.email}</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">账户余额</td>
                <td class="am-u-md-3"><fmt:formatNumber type="number" value="${object.deposit}" maxFractionDigits="2" minFractionDigits="2"/></td>
                <td class="am-primary am-u-md-3">积分</td>
                <td class="am-u-md-3">${object.score}</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
