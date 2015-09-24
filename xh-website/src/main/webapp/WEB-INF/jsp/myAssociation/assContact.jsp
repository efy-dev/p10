<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/18
  Time: 10:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title></title>
</head>
<body>
<div align="center">
    中国非物质文化遗产保护协会-<ming800:status name="group" dataType="document.group" checkedValue='${group}' type="normal"/>
</div>
<hr/>
<div>
    <div align="center">
        ${document.documentContent.content}
    </div>
    <div align="center">
        <label>地&nbsp;&nbsp;址<small>*</small></label>
        ${document.sampleContent}
    </div>
    <div align="center">
        <label>邮&nbsp;&nbsp;编<small>*</small></label>
        ${document.documentOrder}
    </div>
    <div align="center">
        <label>电&nbsp;&nbsp;话<small>*</small></label>
        ${document.name}
    </div>
    <div align="center">
        <label>E-mail<small>*</small></label>
        ${document.title}
    </div>
    <div align="center">
        <label>在线客服<small>*</small></label>
        ${document.keywords}
    </div>
</div>
</body>
</html>
