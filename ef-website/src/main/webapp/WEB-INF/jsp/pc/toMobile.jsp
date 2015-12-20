<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/12/20 0020
  Time: 16:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<div class="error404">
    <div class="content">
        <div class="codebg" style="background: white"></div>
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
        render: "div",
        text: "${url}",
        width: "200",
        height: "200",
    })

//    $().ready(function(){
//        $("tr").css("height","3.5px");
//        $("td").css("width","4px");
//    })
    ;
</script>
</body>
</html>
