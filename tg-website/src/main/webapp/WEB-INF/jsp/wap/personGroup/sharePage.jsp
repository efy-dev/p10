<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>要精品也要实惠！匠人手作非遗品，惊喜团购价，无限红包，你还等什么</title>
    <!-- Set render engine for 360 browser -->
    <meta name="renderer" content="webkit">
    <!-- No Baidu Siteapp-->
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="icon" type="image/png" href="assets/i/favicon.png">
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
    <link type="text/css" rel="stylesheet"  href="<c:url value="/scripts/wap/css/amazeui.min.css?v=20150831"/>">
    <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/wap/css/app.css?v=20150831"/>">
    <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/wap/css/myorder.css?v=20150831"/>">
    <script>src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"</script>
</head>
<body>
<div class="packet ae">
    <div class="red ae">
        <div class="pic"><span>${group.groupProduct.bonus}</span></div>
    </div>
    <div class="text ae">
        <p>1、恭喜您参团成功！</p>
        <p>2、分享该链接并成功帮好友参团，拼团成功后，您就可以得到分享红包！</p>
        <p>3、红包无上限，更多分享，更多红包！</p>
        <p>红包计算方法：</p>
        <p>分享红包总额=分享红包*有效分享次数，详情请见e飞蚁拼团协议!</p>
    </div>
    <div class="button ae"><a class="btn ad">我&nbsp;要&nbsp;呼&nbsp;朋&nbsp;唤&nbsp;友</a><a href="<c:url value="/group/joinGroup.do${url}"/>" class="btn">查&nbsp;看&nbsp;参&nbsp;团&nbsp;进&nbsp;度</a>
        <div id="cover" style="display: none;"><em class="bg"></em><img src="<c:url value="/scripts/wap/upload/guide-share.png"/>"></div>
    </div>
</div>
<script>
    var imgUrl = 'http://pro.efeiyi.com/${group.groupProduct.productModel.productModel_url}';  // 分享后展示的一张图片
    var lineLink = 'http://j.efeiyi.com/tg-website/group/joinGroup.do${url}'; // 点击分享后跳转的页面地址
    var descContent = "xx参加了团购，还差4人成团";  // 分享后的描述信息
    var shareTitle = '这是微信分享链接标题';  // 分享后的标题
    var appid = '';  // 应用id,如果有可以填，没有就留空

    function shareFriend() {
        WeixinJSBridge.invoke('sendAppMessage',{
            "appid": appid,
            "img_url": imgUrl,
            "img_width": "200",
            "img_height": "200",
            "link": lineLink,
            "desc": descContent,
            "title": shareTitle
        }, function(res) {
            //_report('send_msg', res.err_msg);  // 这是回调函数，必须注释掉
        })
    }
    function shareTimeline() {
        WeixinJSBridge.invoke('shareTimeline',{
            "img_url": imgUrl,
            "img_width": "200",
            "img_height": "200",
            "link": lineLink,
            "desc": descContent,
            "title": shareTitle
        }, function(res) {
            //_report('timeline', res.err_msg); // 这是回调函数，必须注释掉
        });
    }
    function shareWeibo() {
        WeixinJSBridge.invoke('shareWeibo',{
            "content": descContent,
            "url": lineLink,
        }, function(res) {
            //_report('weibo', res.err_msg);
        });
    }
    // 当微信内置浏览器完成内部初始化后会触发WeixinJSBridgeReady事件。
    document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
        // 发送给好友
        WeixinJSBridge.on('menu:share:appmessage', function(argv){
            alert(argy);
            shareFriend();
        });
        // 分享到朋友圈
        WeixinJSBridge.on('menu:share:timeline', function(argv){
            shareTimeline();
        });
        // 分享到微博
        WeixinJSBridge.on('menu:share:weibo', function(argv){
            shareWeibo();
        });
    }, false);
</script>
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="<c:url value="/scripts/wap/js/jquery.min.js"/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="<c:url value="/scripts/wap/js/amazeui.min.js"/>"></script>
<!--自定义js--Start-->
<script src="<c:url value="/scripts/wap/js/system.js?v=20150831"/>"></script>
<script src="<c:url value="/scripts/wap/js/myorder.js?v=20150831"/>"></script>
<!--自定义js--End-->
</body>
</html>