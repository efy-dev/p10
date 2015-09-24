<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/22
  Time: 16:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title></title>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">用户${object.name}详细信息</strong>
    </div>
</div>
<div am-panel am-panel-default admin-sidebar-panel>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr>
            <td>用户姓名</td>
            <td>${object.name}</td>
        </tr>
        <tr>
            <td>用户密码</td>
            <td>**** **** **** ****</td>
        </tr>
        <tr>
            <td>状态</td>
            <td>
                <c:if test="${object.status == '0'}">
                    <font color="red">已删除</font>
                </c:if>
                <c:if test="${object.status == '1'}">
                    <font color="green">正常</font>
                </c:if>
            </td>
        </tr>
        <tr>
            <td>商户名称</td>
            <td>${object.tenant.name}</td>
        </tr>
    </table>
</div>
</body>
</html>
