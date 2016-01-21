<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>个人中心-我的参团</title>
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
<ul class="offered ae" style="margin-bottom: 66px;">
    <c:forEach items="${groupJoinList}" var="member" varStatus="rec">
        <a href="<c:url value='/group/shareGroup.do'/>?groupProductId=${member.myGroup.groupProduct.id}&groupId=${member.myGroup.id}&memberId=${member.id}">
            <c:if test="${not empty member.myGroup.groupProduct.productModel.product.name}">
            <li>
                <c:if test="${fn:length(member.myGroup.groupProduct.productModel.product.productModelList)>1}">
                    <p>${member.myGroup.groupProduct.productModel.product.name}${member.myGroup.groupProduct.productModel.name}</p>
                </c:if>
                <c:if test="${fn:length(member.myGroup.groupProduct.productModel.product.productModelList)<=1}">
                    <p>${member.myGroup.groupProduct.productModel.product.name}</p>
                </c:if>
                <p>${fn:substring(member.myGroup.createDateTime,0 ,19)}</p>
                <c:if test="${member.myGroup.status=='1'}">
                    <p>${member.myGroup.groupMemberList.size()}人/${member.myGroup.groupProduct.memberAmount}人成团</p>
                </c:if>
                <c:if test="${member.myGroup.status=='3'}">
                    <p>组团成功</p>
                </c:if>
                <c:if test="${member.myGroup.status=='5'}">
                    <p>组团失败</p>
                </c:if>
                <c:forEach items="${member.myGroup.groupMemberList}" var="memberTemp" varStatus="rec">
                    <c:if test="${memberTemp.level==0}">
                        <c:set var="user">
                            ${memberTemp.user.getUsername()}
                        </c:set>
                    </c:if>
                </c:forEach>
                <p>团长:${fn:substring(user, 0,3 )}****${fn:substring(user,7,11)}</p>
                <c:if test="${member.myGroup.status=='1'||member.myGroup.status=='4'}">
                <span>
                进行中
                </span>
                </c:if>
            </li>
            </c:if>
        </a>
    </c:forEach>
</ul>
<!--//End--footer-->
<!--悬浮订单-->
<div class="met-nav ae">
    <a href="<c:url value="/tuan.do"/>"><p><i class="met-1con m-icon"></i></p><p>团购首页</p></a>
    <a href="<c:url value="/person/myGroup.do"/>"><p><i class="met-2con m-icon"></i></p><p>我的团</p></a>
    <a href="<c:url value="/person/myPurchaseOrder.do"/>"><p><i class="met-3con m-icon"></i></p><p>我的订单</p></a>
    <a href="<c:url value="/person/personInfoView.do"/>"><p><i class="met-4con m-icon"></i></p><p>个人中心</p></a>
</div>
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
<script>
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "//hm.baidu.com/hm.js?99fa5c9048e30c9dada20ea390329f89";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>

<script>
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
            m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

    ga('create', 'UA-70397028-1', 'auto');
    ga('send', 'pageview');

</script>
</body>
</html>