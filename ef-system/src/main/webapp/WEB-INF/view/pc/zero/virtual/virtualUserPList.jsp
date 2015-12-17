<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/11/25
  Time: 17:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title>虚拟数据批次</title>
</head>
<body style="height: auto">
<div style="text-align: left;margin-left: 10px;">
    <input onclick="window.history.go(-1);"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 4px;margin-bottom: 6px;margin-left:2px;height: 35px;"
           value="返回"/>
</div>
<div>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr style="text-align:left">
            <td>用户ID</td>
            <td>用户名</td>
        </tr>
        <c:forEach items="${vUserList}" var="vUser">
            <tr>
                <td>${vUser.user.id}</td>
                <td>${vUser.user.username}</td>
            </tr>
        </c:forEach>
    </table>
</div>
<div style="clear: both">
    <c:url value="/virtualPlan/getTypeObjectList.do" var="url"/>
    <ming800:pcPageList bean="${pageEntity}" url="${url}">
        <ming800:pcPageParam name="virtual" value="virtual"/>
        <ming800:pcPageParam name="id" value="${planId}"/>
        <ming800:pcPageParam name="type" value="${objectType}"/>
    </ming800:pcPageList>
</div>
</body>
</html>
