<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/3
  Time: 11:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<%--${redirect}--%>

<script type="text/javascript" src="<c:url value="/scripts/wxjsapi.js"/>"></script>
<script>callpay("${jsonObject}");</script>
</body>
</html>
