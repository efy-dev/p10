<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/20
  Time: 8:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

  <title>My JSP 'index.jsp' starting page</title>
  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="cache-control" content="no-cache">
  <meta http-equiv="expires" content="0">
  <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
  <meta http-equiv="description" content="This is my page">
  <!--
  <link rel="stylesheet" type="text/css" href="styles.css">
  -->
  <script type="text/javascript" src="<c:url value='/base_resource/p/scripts/jquery-1.8.0.min.js'/>"></script>
  <script type="text/javascript" src="<c:url value='/base_resource/p/scripts/PNG.js'/>"></script>

  <link type="text/css" rel="stylesheet" href="<c:url value='/base_resource/p/assets/css/app.css'/>">
</head>

<body>
This is my JSP page. <br>
<img alt="aa" src="<c:url value='/base_resource/p/assets/i/discount/1.jpg'/>">
</body>
</html>

