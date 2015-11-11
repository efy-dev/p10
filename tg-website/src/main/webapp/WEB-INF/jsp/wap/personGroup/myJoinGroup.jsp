<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>我的参团</title>
    <!-- Set render engine for 360 browser -->
    <meta name="renderer" content="webkit">
    <!-- No Baidu Siteapp-->
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="icon" type="image/png" href="/resources/assets/i/favicon.png">
    <!-- Add to homescreen for Chrome on Android -->
    <meta name="mobile-web-app-capable" content="yes">
    <link rel="icon" sizes="192x192" href="/resources/assets/i/app-icon72x72@2x.png">
    <!-- Add to homescreen for Safari on iOS -->
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <link rel="apple-touch-icon-precomposed" href="/resources/assets/i/app-icon72x72@2x.png">
    <!-- Tile icon for Win8 (144x144 + tile color) -->
    <meta name="msapplication-TileImage" content="/resources/assets/i/app-icon72x72@2x.png">
    <meta name="msapplication-TileColor" content="#0e90d2">
    <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/wap/css/amazeui.min.css?v=20150831"/>">
    <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/wap/css/app.css?v=20150831"/>">
    <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/wap/css/myorder.css?v=20150831"/>">
</head>
<body>
<header class="am-header custom-header">
    <div class="am-header-left am-header-nav">
        <a href="javascript:history.go(-1)" class="chevron-left"></a>
    </div>
    <!-- //End--chevron-left-->
    <h1 class="am-header-title">我的参团</h1>
    <!-- //End--title-->
</header>
<!--//End--header-->
<ul class="offered ae">
    <c:forEach items="${groupJoinList}" var="member" varStatus="rec">
        <li>
            <p>${member.group.groupProduct.productModel.product.name} ${member.group.groupProduct.productModel.name}</p>
            <p>${member.group.createDateTime}</p>
            <c:if test="${member.group.status=='1'}">
                <p>${member.group.memberList.size()}人/${member.group.groupProduct.memberAmount}人成团</p>
            </c:if>
            <c:if test="${member.group.status=='3'}">
                <p>组团成功</p>
            </c:if>
            <c:if test="${member.group.status=='5'}">
                <p>组团失败</p>
            </c:if>
            <c:forEach items="${member.group.memberList}" var="memberTemp" varStatus="rec">
                <c:if test="${memberTemp.level==0}">
                    <c:set var="commander">
                        ${memberTemp.user.name}
                    </c:set>
                </c:if>
            </c:forEach>
            <p>${commander}</p>
            <c:if test="${member.group.status=='1'}">
               <span>
                进行中
               </span>
            </c:if>
            <c:if test="${member.group.status!='1'}">
               <span>
                拼团结束
               </span>
            </c:if>
        </li>
    </c:forEach>
</ul>
<!--//End--footer-->

<!--[if (gte IE 9)|!(IE)]><!-->
<script href="<c:url value="/scripts/wap/js/jquery.min.js"/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="/resources/assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script href="<c:url value="/scripts/wap/js/amazeui.min.js"/>"></script>
<!--自定义js--Start-->
<script href="<c:url value="/scripts/wap/js/system.js?v=20150831"/>"></script>
<script href="<c:url value="/scripts/wap/js/myorder.js?v=20150831"/>"></script>
<!--自定义js--End-->
</body>
</html>