<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/23
  Time: 16:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title></title>
</head>
<body>
<div align="center" style="margin-top: 8px">
    非物质文化遗产保护政策文件
</div>
<hr/>
<div class="am-g">

    <c:forEach items="${documentList}" var="document">
        <ul>
            <li class="admin-parent">
                <a >${document.title}</a>
            </li>
        </ul>
    </c:forEach>
</div>
</body>
</html>
