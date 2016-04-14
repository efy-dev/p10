<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/12
  Time: 17:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <script src="<c:url value="/META-INF/resources/resources/jquery/jquery.qrcode.min.js"/>"></script>
    <title></title>
</head>
<body>
<div id="native"></div>
<script>
    $('#native').qrcode({
        render: "div",
        text: "${codeUrl}"
    });
</script>
</body>
</html>