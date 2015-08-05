<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/21
  Time: 14:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>首页</title>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Amaze UI Admin index Examples</title>
  <meta name="description" content="这是一个 index 页面">
  <meta name="keywords" content="index">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <meta name="renderer" content="webkit">
  <meta http-equiv="Cache-Control" content="no-siteapp"/>
  <link rel="icon" type="image/png" href="<c:url value='/resources/assets/i/favicon.png'/>"/>
  <link rel="apple-touch-icon-precomposed" href="<c:url value='/resources/assets/i/app-icon72x72@2x.png'/>"/>
  <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
  <link rel="stylesheet" href="<c:url value='http://cdn.amazeui.org/amazeui/2.4.2/css/amazeui.min.css'/>"/>
  <link rel="stylesheet" href="<c:url value='/resources/assets/css/admin.css'/>"/>
  <script src="<c:url value='/resources/jquery/jquery-1.11.1.min.js'/>"></script>
  <script src="<c:url value='http://cdn.amazeui.org/amazeui/2.4.2/js/amazeui.min.js'/>"></script>
  <%--<script src="<c:url value='/base_resource/p/scripts/ckeditor/ckeditor.js'/>" charset="GB2312"></script>--%>
  <script src="<c:url value='//cdn.ckeditor.com/4.5.1/standard/ckeditor.js'/>"></script>
  <sitemesh:write property='head'/>
  <style>
    .efy-active {
      background-color: #9a9a9a;
    }
  </style>
</head>
<body>

    <sitemesh:write property='body'/>

</div>
</body>
</html>
