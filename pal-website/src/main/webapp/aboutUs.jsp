<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>关于我们终</title>
  <!-- Set render engine for 360 browser -->
  <meta name="renderer" content="webkit">
  <!-- No Baidu Siteapp-->
  <meta http-equiv="Cache-Control" content="no-siteapp"/>
  <link rel="icon" type="image/png" href="<c:url value='/resources/assets/i/favicon.png'/>">
  <!-- Add to homescreen for Chrome on Android -->
  <meta name="mobile-web-app-capable" content="yes">
  <link rel="icon" sizes="192x192" href="<c:url value='/resources/assets/i/app-icon72x72@2x.png'/>">
  <!-- Add to homescreen for Safari on iOS -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
  <link rel="apple-touch-icon-precomposed" href="<c:url value='/resources/assets/i/app-icon72x72@2x.png'/>">
  <!-- Tile icon for Win8 (144x144 + tile color) -->
  <meta name="msapplication-TileImage" content="assets/i/app-icon72x72@2x.png">
  <meta name="msapplication-TileColor" content="#0e90d2">
  <link rel="stylesheet" href="<c:url value='/css/amazeui.min.css'/>">
  <link rel="stylesheet" href="<c:url value='/resources/css/pc.css'/>">
</head>
<body>
<div class="search-list">
  <div class="search-home">
    <div class="logo">
      <h1><a href="#"><img src="<c:url value='/resources/images/logo.png'/>" width="160" height="72" /></a></h1>
    </div>
    <form action="" method="post">
      <div class="title"><a class="active">真伪查询</a><span class="line"></span><a>非遗搜</a></div>
      <label for="">
        <input class="txt" type="text" name="" id="" value="" placeholder="请输入名称查询,如:”苏绣”" />
        <input class="btn" type="submit" value="查 询"/>
      </label>
    </form>
  </div>
  <meta name="msapplication-TileImage" content="<c:url value='/resources/assets/i/app-icon72x72@2x.png'/>">
  <meta name="msapplication-TileColor" content="#0e90d2">
  <link rel="stylesheet" href="<c:url value='/resources/css/amazeui.min.css'/>">
  <link rel="stylesheet" href="<c:url value='/resources/css/pc.css'/>">
</head>
<body>
<div class="search-home search-list">
  <div class="logo">
    <h1><a href="<c:url value='/'/> "><img src="<c:url value='/resources/images/logo.png'/>"/></a></h1>
  </div>
  <form id="form" action="<%=basePath%>checkLabelPc.do" method="get">
    <div class="title"><a>真伪查询</a><span class="line"></span><a>非遗搜</a></div>

    <input class="txt" type="text" name="serial" id="serial" value="">
    <input class="btn" type="button" value="查 询" id="btn">
    <input id="" onkeyup="eKeyup(event)" type="hidden">
  </form>
</div>
<!--//End--search-list-->
<div class="hd">
  <div class="about">
    <div class="menu">
      <a href="<c:url value='/aboutUs.jsp'/>">关于诚品宝</a>
      <a href="<c:url value='/aboutUs.jsp'/>">使用前必读</a>
      <a href="#">关于诚品宝</a>
      <a href="#">使用前必读</a>
    </div>
    <div class="info">
      <p class="tc t1">非遗作品真伪鉴别的防伪溯源体系</p>
      <p class="tc t2">诚品宝</p>
      <p class="tc t3">打造非遗作品有据可查“身份证”</p>
      <p class="tc t3">让非遗作品真假可辨</p>
      <p class="tc t4">诚品宝定义</p>
      <p class="t5">诚品宝是永新华韵经官方批准研发的一套防伪溯源体系从非遗作品的创作源头出发，承载作品生产、备案、物流、销售等各环节的信息，通过诚品宝的认证，每一件非遗作品将拥有唯一有据可查的“身份证”信息，为非遗作品交易双方提供可信。</p>
      <p class="tc t6">诚品宝价值</p>
      <p class="t7">1、非遗大师：由非遗大师授权认可，是大师高附加值正品的见证。</p>
      <p class="t7">2、消 费 者：在智能终端通过认证编号可查询非遗作品的真伪及出处，便于消费者了解作品上游信息，提供消费保障。</p>
      <p class="t7">3、非遗作品：收录作品的创作、生产、认证、物流、销售各环节溯源信息，为非遗作品打造一张可追溯的“身份证”。</p>
      <p class="t7">4、科技水平：集合标签、证书、二维码、防伪芯片、非遗作品DNA、物联网、云计算、移动APP等高科技手段。</p>
      <p class="t7">1.非遗大师：由非遗大师授权认可，是大师高附加值正品的见证。</p>
      <p class="t7">2.消 费  者：在智能终端通过认证编号可查询非遗作品的真伪及</p>
      <p class="t7-1">出处，便于消费者了解作品上游信息提供消费保障。</p>
      <p class="t7">3.非遗作品：收录作品的创作、生产、认证、物流、销售各环节溯</p>
      <p class="t7-1">源信息，为非遗作品打造一张可追溯的“身份证”。</p>
      <p class="t7">4.科技水平：集合标签、证书、二维码、防伪芯片、非遗作品DNA</p>
      <p class="t7-1">物联网、云计算、移动APP等高科技手段。</p>
    </div>
  </div>
  <!--//End--about-->
</div>

<div class="footer footer-list">
  <div class="hd">
    <p>
      <a href="<c:url value='/aboutUs.jsp'/>" title="关于诚品宝">关于诚品宝</a>
      <a href="<c:url value='/aboutUs.jsp'/>" title="使用前必读">使用前必读</a>
      <strong>商家入住热线</strong>
      <em>400-876-8766</em>
    </p>
    <p class="copyright">Copyright © 2012-2022 永新华韵文化发展有限公司版权所有-京ICP备15032511号-1</p>
<div class="footer">
  <div class="hd">
    <a href="" title="关于诚品宝">关于诚品宝</a>
    <a href="" title="使用前必读">使用前必读</a>
    <a href="" title="京ICP备:15032511号-1">京ICP备:15032511号-1</a>
  </div>
</div>
<!--//End--footer-->


<!--[if (gte IE 9)|!(IE)]><!-->
<%--<script src="js/jquery.min.js"></script>--%>
<script src="js/jquery.min.js"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value='/resources/assets/js/amazeui.ie8polyfill.min.js'/>"></script>
<![endif]-->
<script src="<c:url value='/js/amazeui.min.js'/>"></script>
<script src="<c:url value='resources/assets/js/amazeui.min.js'/>"></script>
<script src="<c:url value='/resources/assets/js/cpbjs.js'/>"></script>
<script>
  $(document).ready(function(){
    $("#serial").keydown(function(e){
      if(e.keyCode==13){
        $('#form').submit(); //处理事件
      }
    });
    $("#btn").click(function(){
      $('#form').submit();
    });
  });
</script>
</body>
</html>