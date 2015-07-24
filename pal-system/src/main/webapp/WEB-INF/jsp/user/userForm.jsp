<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title></title>
</head>
<body>
<c:if test="${empty object || object.id == null || object.id==''}">
    <div align="center">
        <h3>新建用户</h3>
    </div>
</c:if>
<c:if test="${!empty object && object.id != null && object.id != '' }">
    <div align="center">
        <h3>修改用户信息</h3>
    </div>
</c:if>
<div align="center">
    <form action="/basic/xm.do" method="post">
        <table>
            <tr>
                <td colspan="2"><input type="hidden" name="id" id="id" value="${object.id}"></td>
            </tr>
            <tr>
                <td>用户姓名：</td>
                <td><input type="text" name="name" id="name" value="${object.name}"></td>
            </tr>
            <tr>
                <td>用户密码：</td>
                <td><input type="text" name="password" id="password" value="${object.password}"></td>
            </tr>
            <tr>
                <td>状态：</td>
                <td><input type="text" name="status" id="status" value="${object.status}"></td>
            </tr>
            <tr>
                <td>大师ID：</td>
                <td><input type="text" name="tenant.id" id="tenant.id" value="${object.tenant.id}"></td>
            </tr>
            <tr>
                <td colspan="2"><input type="hidden" value="saveOrUpdateUser" name="qm"></td>
            </tr>
            <tr>
                <td align="center" colspan="2"><input type="submit" value="保存"></td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>
