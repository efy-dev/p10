<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="no-js">
<head>
    <script type="text/javascript" >
        function forward(){
            window.location.href="/tenant/getTenant.do?tenantId=1";
        }
    </script>
</head>
<body>
<!--内容-->
<div id="header">
    <input type="button" value="传承人首页" onclick="forward();">
</div>
</body>
</html>
