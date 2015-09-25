<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/18
  Time: 16:48
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
    ${document.documentContent.content}
</div>
</body>
</html>
