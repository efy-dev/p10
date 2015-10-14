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
        <h2>商家用户详情</h2>
        <table class="am-table am-table-bordered">
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">用户名</td>
                <td class="am-u-md-3">${object.username}</td>
                <td class="am-primary am-u-md-3">电话</td>
                <td class="am-u-md-3">${object.phone}</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">邮箱</td>
                <td class="am-u-md-3">${object.email}</td>
                <td class="am-primary am-u-md-3">性别</td>
                <td class="am-u-md-3">
                    <ming800:status name="sex" dataType="Professional.sex" checkedValue="${object.sex}" type="normal"/>
                </td>
            </tr>
            <%--<tr>--%>
                <%--<td class="am-primary am-u-md-3">生日</td>--%>
                <%--<td class="am-u-md-3">--%>
                    <%--<fmt:formatDate value="${object.birthDate}" pattern="yyyy:MM:dd hh:mm" type="both"/>--%>
                <%--</td>--%>
                <%--<td class="am-primary am-u-md-3">身份证号码</td>--%>
                <%--<td class="am-u-md-3">${object.identity}</td>--%>
            <%--</tr>--%>
            <tr>
                <td class="am-primary am-u-md-3">注册日期</td>
                <td class="am-u-md-3">
                    <fmt:formatDate value="${object.createDatetime}" pattern="yyyy:MM:dd hh:mm:ss" type="both"/>
                </td>
                <td class="am-primary am-u-md-3">最后一次登录时间</td>
                <td class="am-u-md-3">
                    <fmt:formatDate value="${object.lastLoginDatetime}" pattern="yyyy:MM:dd hh:mm:ss" type="both"/>
                </td>
            </tr>

            </tbody>
        </table>
    </div>
</div>
</body>
</html>
