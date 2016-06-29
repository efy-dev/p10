<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/1/12
  Time: 10:17
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>分享页面-移动端</title>
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
</head>
<body>
<header class="am-header custom-header">
  <div class="am-header-left am-header-nav">
    <a href="#chevron-left" class="chevron-left"></a>
  </div>
  <!-- //End--chevron-left-->
  <h1 class="am-header-title">分享领现金</h1>
  <!-- //End--title-->
</header>
<!--//End--header-->
<div class="colonel-pic ae"><img src="http://pro.efeiyi.com/${productModel.productModel_url}@!wap-rebate-picture"><div class="c-page"><span>${productModel.product.name}[${productModel.name}]</span></div></div>
<!--//End--colonel-pic-->
<div class="packet ae">
  <ul class="pac-text ae">
    <li>分&nbsp;享&nbsp;宝&nbsp;贝</li>
    <c:set var="shareUser">
      ${order.getUser().getUsername()}
    </c:set>
    <li>领&nbsp;取&nbsp;<em>5</em>&nbsp;元&nbsp;现&nbsp;金&nbsp;红&nbsp;包!</li>
  </ul>
  <a class="pac-btn ae" id="share">去&nbsp;分&nbsp;享</a>
  <div id="cover" style="display: none;"><em class="bg"></em><img src="/scripts/wap/upload/guide-share.png" class="share-picture"
                                                                  alt=""></div>
  <div class="link ae">
    <a href="http://i.efeiyi.com/myEfeiyi/getBalanceDetailsList.do">查看余额<i class="pac-icon"></i></a>
    <a href="http://mall.efeiyi.com">首页<i class="pac-icon"></i></a>
  </div>
</div>
<!--//End--colonel-packet-->
<div class="activity ae">
  <h5>活动说明</h5>
  <p>1、分享宝贝到朋友圈，即可领取5元现金，你的好友也可领取大额代金券。</p>
  <p>2、该现金将直接存入个人账户，用户可在购物时直接抵现金使用，无任何使用门槛。</p>
  <p>3、用户可到 <strong>个人中心>余额</strong> 中查看余额，本活动最终解释权归e飞蚁所有。</p>
</div>
<script type='text/javascript'>
  $().ready(function () {
    $("#header").hide();
  })
  $().ready(function () {
    $("#share").click(function () {
      if (isWeiXin()) {
        $("#cover").show();
        $(".custom-header").css("z-index", "0");
      }else {
        $("#cover").show();
        $(".custom-header").css("z-index", "0");
      }
    })
    $("#cover").click(function () {
      $(this).hide();
    })
  })

</script>

<script>
  var wx_share_title = "${fn:substring(shareUser, 0,3 )}****${fn:substring(shareUser,7,11)}豪掷${order.total}入手了一批好宝贝"; //分享标题
  var wx_share_des = "${productModel.product.name}${productModel.name}";  //分享描述
  var wx_share_link = "http://mall.efeiyi.com/sharePage/openShare/${purchaseOrderId}"; //分享的链接地址  //需要动态获取，而不是直接填写静态值
  var wx_share_imgUrl = "http://pro.efeiyi.com/${productModel.productModel_url}"; //分享图片的url
  var wx_share_type = '';   //分享的类型   分享类型,music、video或link，不填默认为link
  var wx_share_dataUrl = ""; // 如果type是music或video，则要提供数据链接，默认为空
  var wx_api_list = ['onMenuShareAppMessage', 'onMenuShareTimeline'];    //需要使用的JS接口列表
</script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="<c:url value="/scripts/wap/js/weixin.js"/>"></script>
<script>
  initWx("http://mall.efeiyi.com/wx/init.do");
</script>
</body>
</html>
</body>
</html>