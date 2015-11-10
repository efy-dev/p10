<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/24
  Time: 11:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>商品详情</title>
  <!-- Set render engine for 360 browser -->
  <meta name="renderer" content="webkit">
  <!-- No Baidu Siteapp-->
  <meta http-equiv="Cache-Control" content="no-siteapp"/>
  <link rel="icon" type="image/x-icon" href="<c:url value='/scripts/assets/images/favicon.ico'/>">
  <!-- Add to homescreen for Chrome on Android -->
  <meta name="mobile-web-app-capable" content="yes">
  <link rel="icon" sizes="192x192" href="assets/i/app-icon72x72@2x.png">
  <!-- Add to homescreen for Safari on iOS -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
  <link rel="apple-touch-icon-precomposed" href="assets/i/app-icon72x72@2x.png">
  <!-- Tile icon for Win8 (144x144 + tile color) -->
  <meta name="msapplication-TileImage" content="assets/i/app-icon72x72@2x.png">
  <meta name="msapplication-TileColor" content="#0e90d2">
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/wap/css/amazeui.min.css?v=20150831'/>">
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/wap/css/app.css?v=20150831'/>">
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/wap/css/cyclopedia.css?v=20150831'/>">
  <script src="<c:url value='/resources/jquery/jquery-2.1.3.min.js'/>"></script>
</head>
<body style="position: relative;">
<div class="plwq">
  <form>
    <header class="am-header custom-header">
      <div class="am-header-left am-header-nav">
        <a href="javascript:window.opener=null;window.close();" class="fh">取消</a>
      </div>
      <!-- //End--chevron-left-->
      <h1 class="am-header-title">评论</h1>
      <!-- //End--title-->
      <div class="am-header-right am-header-nav" style="margin-top: -22px;">
        <input type="submit"  class="qd" value="确定" onclick="gotoParent()">
      </div>
      <!-- //End--chevron-left-->
    </header>
    <div class="talk">
      <textarea placeholder="没事说句(200字以内)" id="forFather"></textarea>
    </div>
  </form>
</div>

<script>
  function gotoParent(){
    window.opener.setValue( $("#forFather").val());//调用父窗口的方法进行传值
    //window.opener.getElementById("#content").trigger("click");
    //window.opener = null;
    window.returnValue = true;
    window.close();
  }

</script>
<!--[if (gte IE 9)|!(IE)]><!-->
<!--<![endif]-->
<!--[if lte IE 8 ]><![endif]-->
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value='/resources/assets/js/amazeui.ie8polyfill.min.js?v=20150831'/>"></script>

<!--自定义js--Start-->

<script src="<c:url value='/scripts/assets/wap/js/system.js?v=20150831'/>"></script>
<script src="<c:url value='/scripts/assets/wap/js/cyclopedia.js?v=20150831'/>"></script>

<!--自定义js--End-->
</body>
</html>
