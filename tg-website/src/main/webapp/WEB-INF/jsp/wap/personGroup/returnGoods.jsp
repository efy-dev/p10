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
    <title>个人中心-申请退货</title>
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
    <h1 class="am-header-title">申请退货</h1>
    <!-- //End--title-->
</header>
<!--//End--header-->
<div class="sales-return ae">
    <p>申请退货请拨打客服电话</p>
    <p>400—876—8766</p>
</div>
<!--悬浮订单-->
<div class="met-nav ae">
    <a href="<c:url value="/tuan.do"/>"><p><i class="met-1con m-icon"></i></p><p>团购首页</p></a>
    <a href="<c:url value="/person/myGroup.do"/>"><p><i class="met-2con m-icon"></i></p><p>我的团</p></a>
    <a href="<c:url value="/person/myPurchaseOrder.do"/>"><p><i class="met-3con m-icon"></i></p><p>我的订单</p></a>
    <a href="<c:url value="/person/personInfoView.do"/>"><p><i class="met-4con m-icon"></i></p><p>个人中心</p></a>
</div>
<!--//End--footer-->
<!--[if (gte IE 9)|!(IE)]><!-->
<script href="<c:url value="/scripts/js/jquery.min.js"/>"></script>
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
<style type="text/css">
    #MEIQIA-BTN-HOLDER {
        right: 0;bottom: 145px;}
    #MEIQIA-BTN {
        background: #000;
        width: 33px;
        height:53px;
        -webkit-border-radius: 5px;
        -moz-border-radius: 5px;
        border-radius: 5px;
    }
    #MEIQIA-BTN-LINE {
        display: none;}
    #MEIQIA-BTN-TEXT {
        width:48px;
        font-size: 12px;
        position: absolute;
        left:-28px;
        top:20px;
        display: none;
    }
    .MEIQIA-ICON {
        background:url(http://a.efeiyi.com/scripts/wap/images/qq.png) no-repeat -176px -143px;
    }
    #MEIQIA-BTN-ICON {
        width: 23px;
        height: 28px;
        margin: 0;
        float: left;
        margin-left:5px;
        margin-top: 6px;
    }
</style>
<script type='text/javascript'>
    (function(m, ei, q, i, a, j, s) {
        m[a] = m[a] || function() {
                    (m[a].a = m[a].a || []).push(arguments)
                };
        j = ei.createElement(q),
                s = ei.getElementsByTagName(q)[0];
        j.async = true;
        j.src = i;
        s.parentNode.insertBefore(j, s)
    })(window, document, 'script', '//eco-api.meiqia.com/dist/meiqia.js', '_MEIQIA');
    _MEIQIA('entId', 486);
</script>

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