<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/11/22 0022
  Time: 18:21
  To change this template use File | Settings | File Templates.
--%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>礼物卡片</title>
    <%--<link type="text/css" rel="stylesheet" src="<c:url value="/scripts/wap/css/amazeui.min.css?v=20150831"/>">--%>
    <%--<link type="text/css" rel="stylesheet" src="<c:url value="/scripts/wap/css/app.css?v=20150831"/>">--%>
    <%--<link type="text/css" rel="stylesheet" src="<c:url value="/scripts/wap/css/myorder.css?v=20150831"/>">--%>
    <style>
        .gift-img {
            width: 100%;
            height: 100%;
            float: left;
            text-align: center;
            background: #000;
        }
        .gift-img h1 {
            line-height: 58px;
            color: #fff;
            font-size: 12px;
            font-weight: bolder;
        }
        .gift-img h2 {
            font-size: 15px;
            line-height: 50px;
            font-weight: normal;
            border-bottom:2px solid #000;
            background: #fff;
        }
        .gift-img img {width: 100%;}
    </style>
</head>
<body>
<div class="gift-img">
    <h1>长按下方图片，选择保存图片，再将其发送给您的好友</h1>

    <div class="img"><img src="http://pro.efeiyi.com/${url}" alt=""></div>
</div>
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="<c:url value="/scripts/wap/js/jquery.min.js"/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value="/scripts/wap/js/amazeui.ie8polyfill.min.js"/>"></script>
<![endif]-->
<script src="<c:url value="/scripts/wap/js/amazeui.min.js"/>"></script>
<script src="<c:url value="/scripts/wap/js/system.js"/>"></script>
</body>


</html>

