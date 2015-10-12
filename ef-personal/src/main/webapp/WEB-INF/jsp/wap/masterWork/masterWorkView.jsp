<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>12010703大师分类-地区</title>
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
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/css/amazeui.min.css?v=20150831'/>">
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/css/app.css?v=20150831'/>">
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/css/cyclopedia.css?v=20150831'/>">
  <script src="<c:url value='/resources/jquery/jquery-1.11.1.min.js'/>"></script>
  <script src="<c:url value='/scripts/assets/js/jquery.min.js'/>"></script>
</head>
<body style="position: relative;">
<header class="am-header custom-header">
  <div class="am-header-left am-header-nav">
    <a href="javascript:history.go(-1);" class="chevron-left"></a>
  </div>
  <!-- //End--chevron-left-->
  <h1 class="am-header-title">${work.project.name}</h1>
  <!-- //End--title-->
  <div class="am-header-right am-header-nav">
    <a href="#chevron-right" class="chevron-right" id="menu">
      <i class="line"></i>
    </a>
  </div>
  <!-- //End--chevron-left-->
  <div class="menu-list">
    <div class="menu-page">
      <ul class="bd">
        <li><a href="" title="首页">首页</a></li>
        <li><a href="" title="分类">消&nbsp;息</a></li>
        <li><a href="" title="个人中心">个&nbsp;人&nbsp;中&nbsp;心</a></li>
      </ul>
    </div>
  </div>
</header>
<div class="work-details" id="work-details">
  <p class="ptext1">${work.name}</p>
  <div class="pimg1"><img src="../shop2015/upload/120115-8.jpg"></div>
  <p class="ptext2"> &nbsp;&nbsp;&nbsp;&nbsp;${work.productDescription.content}</p>
  <div class="inheritor ">

    <div class="inheritor-text">
      <p class="itor-text-1">${work.master.fullName}</p>

      <p class="itor-text-2">${work.project.name}</p>

      <p class="itor-text-3"><ming800:status name='level' dataType='Tenant.level' checkedValue='${object.level}' type='normal'/>非遗传承人</p>

      <p class="itor-text-4">工笔勾画浓淡皆相宜</p>
      <a class="gz-fd-icon" href="#">关注</a>

      <div class="gz-fd-img"><a href="#"><img src="../shop2015/upload/master-0.jpg"></a>
      </div>
    </div>
  </div>
  <!--评论-->
  <div class="review">
    <div class="dialogue">
      <h4 class="pl-name">评论</h4>
      <!--评论状态-->
      <div class="matter">
        <p class="text-h1">Joe</p>
        <p class="text-time">10分钟前</p>
        <p class="text-content"><a href="#" >还不错，真是涨知识了。之前只是知道，现
          在对景泰蓝了解了这么多，真是棒极了。过
          段时间我也入手一件景泰蓝工艺品。</a></p>
        <div class="owner"><img class="am-circle" src="../shop2015/upload/120102-p1-11.jpg"/></div>
        <div class="owner-good"><a href="#"><i class="good-1"></i><em>9999</em></a></div>
        <!--回复状态-->
        <div class="respond">
          <p><span class="txt-name"><a href="#"> Andya：</a></span><span class="txt-content">购买就去e飞蚁呀，最专业的非遗商品网购平台。</span></p>
        </div>
      </div>
      <!--评论状态-->
      <div class="matter">
        <p class="text-h1">Andya</p>
        <p class="text-time">5分钟前</p>
        <p class="text-content"><a href="#" >中国文化博大精深，中国的老艺人把手艺能
          坚持到现在真不容易，我们不能那老祖宗的
          手艺丢掉啊。</a></p>
        <div class="owner"><img class="am-circle" src="../shop2015/upload/120102-p1-11.jpg"/></div>
        <div class="owner-good"><a href="#"><i class="good-1"></i><em>9999</em></a></div>
        <!--回复状态-->
        <div class="respond">
          <p><span class="txt-name"><a href="#"> Bob：</a></span><span class="txt-content">说的不错，赞。</span></p>
          <p><span class="txt-name"><a href="#">我爱非遗：</a></span><span class="txt-content">科技不断的发达，很多手艺都失
传了，悲哀。</span></p>
        </div>
      </div>
      <div class="more"><a href="#"><i class="time-1"></i>查看更多评论</a></div>
    </div>
  </div>
  <!--评论-->
</div>
<!--悬浮-->
<div class="suspend">
  <div class="great">
    <div class="dynamic-ft">
      <a href="#" class="ft-a"> <i class="good-1"></i> <em>9999</em></a>
      <i class="s-solid ft-a"></i>
      <a href="#" class="ft-a"> <i class="good-2"></i> <em>9999</em> </a>
      <i class="s-solid ft-a"></i>
      <a href="#" class="ft-a"> <i class="good-3"></i> </a>
      <i class="s-solid ft-a"></i>
      <a href="#" class="ft-a"> <i class="good-4"></i> </a>
    </div>
  </div>
</div>
</div>
<!--悬浮-->
<!--地区-->
<div class="login-reg">
  <div class="bd logined">李先生8899，<a class="btn-exit" href="#退出">退出</a></div>
  <a href="#login" class="btn-login" title="登录">登&nbsp;&nbsp;&nbsp;&nbsp;录</a>
  <a href="#reg" class="btn-reg">注&nbsp;&nbsp;&nbsp;&nbsp;册</a>
</div>
<!--//End--login-reg-->
<footer class="bd footer">
  <div class="bd info">
    <a class="icon"></a>

    <div class="txt">中&nbsp;&nbsp;国&nbsp;&nbsp;非&nbsp;&nbsp;遗&nbsp;&nbsp;电&nbsp;&nbsp;商&nbsp;&nbsp;平&nbsp;&nbsp;台</div>
    <div class="wechat"></div>
    <div class="txt">关注微信公众号</div>
    <div class="txt">领取超值代金券</div>
  </div>
  <div class="bd copyright">京ICP备15032511号-1</div>
</footer>
<!--//End--footer-->
</div>
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value='/scripts/assets/js/amazeui.ie8polyfill.min.js'/>"></script>
<![endif]-->
<script src="<c:url value='/scripts/assets/js/amazeui.min.js'/>"></script>
<!--自定义js--Start-->
<script src="<c:url value='/scripts/assets/js/system.js?v=20150831'/>"></script>
<script src="<c:url value='/scripts/assets/js/cyclopedia.js?v=20150831'/>"></script>

<!--自定义js--End-->
</body>
</html>
