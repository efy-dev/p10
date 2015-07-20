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
<html>
<head>
    <title></title>
    <script src="<c:url value='/scripts/ckeditor/ckeditor.js'/>"></script>
    <script src="<c:url value='/scripts/ckeditor/config.js'/>"></script>
    <script src="<c:url value='/scripts/jquery-1.11.1.min.js'/>"></script>
    <script src="<c:url value='/scripts/ckeditor/adapters/jquery.js'/>"></script>
    <script src="<c:url value='/scripts/m8u/jquery.m8u2.min.js'/>"></script>
</head>
<body>
<form action="/basic/xm.do" method="post">
    username：<input type="text" name="username" id="username">
    <input type="submit" value="保存">
    <input type="hidden" value="saveOrUpdateUser" name="qm">
</form>

</body>
</html>
