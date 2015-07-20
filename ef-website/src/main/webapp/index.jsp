<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
    <script type="text/javascript" src="<c:url value='/base_resource/p/scripts/jquery-1.8.0.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/base_resource/p/scripts/PNG.js'/>"></script>

    <link type="text/css" rel="stylesheet" href="<c:url value='/base_resource/p/assets/css/app.css'/>">
</head>
<body>

<script type="text/javascript">
    function loginOrRegister(o){
       window.location.href="/pc/forward.do?result="+o;
    }
</script>

<h2>Hello World!</h2>
<input type="button" value="登录" onclick="loginOrRegister(1);"/>
<input type="button" value="注册" onclick="loginOrRegister(2);"/>
<img alt="aa" src="<c:url value='/base_resource/p/assets/i/discount/1.jpg'/>">

</body>
</html>
