<!DocType html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="apple-touch-icon-precomposed" href="<c:url value="/scripts/images/favicon.ico"/>">
<link rel="shortcut icon" type="image/x-icon" href="<c:url value="/scripts/images/favicon.ico"/>" media="screen" />
<!-- Tile icon for Win8 (144x144 + tile color) -->
<meta name="msapplication-TileImage" content="<c:url value="/scripts/images/favicon.ico"/>">
<meta name="msapplication-TileColor" content="#0e90d2">
<meta http-equiv="Content-Type" contect="text/html";charset=utf-8">
<%--<META HTTP-EQUIV="Pragma" CONTENT="">--%>
<META HTTP-EQUIV="Cache-Control" CONTENT="max-age=1920600">

<link type="text/css" rel="stylesheet" href="<c:url value="/resources/assets/css/amazeui.min.css"/>">
<link type="text/css" rel="stylesheet" href="<c:url value="/scripts/css/app.css?v=929"/>">
<link type="text/css" rel="stylesheet" href="<c:url value="/scripts/css/myorder.css?v=929"/>">

<script src="<c:url value='/resources/jquery/jquery-1.11.1.min.js'/>"></script>
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="<c:url value="/resources/jquery/jquery.min.js"/>"></script>
<!--<![endif]-->
<script src="<c:url value='/resources/js/alert.js'/>"></script>
<script src="<c:url value="/resources/assets/js/amazeui.min.js"/>"></script>
<script src="<c:url value="/scripts/js/ef.util.js"/>"></script>
<script src="<c:url value="/scripts/js/myorder.js?v=929"/>"></script>
<html>
<head>
  <title></title>
  <script src="<c:url value="/resources/jquery/jquery.qrcode.min.js"/>"></script>
  <style>
    table {
      display: inline-block;
    }

    tr {
      height: 4px;
    }
  </style>
</head>
<body>
<div class="error404" style="text-align: center">
  <div class="content">
    <div class="codebg" style="background: white;height: 220px;width: 220px;" ></div>
    <h2>您访问的页面只能在移动端显示哦！</h2>

    <h1>手机扫码试试吧</h1>
  </div>
</div>
<div class="max-four">
  <div class="five-max">
    <div class="five-4"></div>
    <div class="logo-four"></div>
  </div>
</div>
<script>

  $('.codebg').qrcode({
    text: "${url}",
    width: "220",
    height: "220",
  })

//    $().ready(function(){
//        $("tr").css("height","3.5px");
//        $("td").css("width","4px");
//    })
  ;
</script>
</body>
</html>
