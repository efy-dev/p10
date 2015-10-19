<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/15
  Time: 18:31
  To change this template use File | Settings | File Templates.
--%>
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
  <title>工艺-分类</title>
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
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/wap/css/amazeui.min.css?v=20150831'/>">
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/wap/css/app.css?v=20150831'/>">
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/wap/css/cyclopedia.css?v=20150831'/>">
  <script src="<c:url value='/resources/jquery/jquery-2.1.3.min.js'/>"></script>
</head>
<body>
<header class="am-header custom-header">
  <div class="am-header-left am-header-nav">
    <a href="javascript:window.history.go(-1);" class="chevron-left"></a>
  </div>
  <!-- //End--chevron-left-->
  <h1 class="am-header-title"></h1>
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
        <li><a href="" title="分类">分&nbsp;类</a></li>
        <li><a href="" title="传承人">传承人</a></li>
        <li><a href="<c:url value='/getPerson.do'/>" title="个人中心">个&nbsp;人&nbsp;中&nbsp;心</a></li>
      </ul>
    </div>
  </div>
</header>
<!--//End--header-->
<!--地区-->
<div class="dis-q1">
  <div class="dis-q2">
  <div data-am-widget="tabs"
       class="am-tabs am-tabs-default">
    <ul class="am-tabs-nav am-cf">
      <li class="am-active"><a href="[data-tab-panel-0]">分类</a></li>
      <li class=""><a href="[data-tab-panel-1]">级别</a></li>
      <li class=""><a href="[data-tab-panel-2]">地区</a></li>
    </ul>
    <div class="am-tabs-bd">
      <div data-tab-panel-0 class="am-tab-panel am-active">
        <div class="site">
          <div class="menu-page">
            <ul class="list-site">
              <li>
                <a href="<c:url value='/basic/xm.do?qm=plistProject_allCategory&conditions=&pageEntity.size=10&pageEntity.index=1'/>">全&nbsp;&nbsp;&nbsp;&nbsp;部</a></li>
              <c:if test="${!empty ProjectCategoryList}">
                <c:forEach var="projectcategory" items="${ProjectCategoryList}">
                  <li><a href="<c:url value='/basic/xm.do?qm=plistProject_Category&conditions=projectCategory.id:${projectcategory.id}&pageEntity.size=10&pageEntity.index=1'/>">${projectcategory.name}</a></li>
                </c:forEach>
              </c:if>
            </ul>
          </div>
        </div>
      </div>
      <div data-tab-panel-1 class="am-tab-panel ">
        <div class="site">
          <div class="menu-page">
            <ul class="list-site">
              <li><a href="<c:url value='/basic/xm.do?qm=plistProject_all&conditions=&pageEntity.size=10&pageEntity.index=1'/>">全&nbsp;&nbsp;部</a></li>
              <li><a href="<c:url value='/basic/xm.do?qm=plistProject_level&conditions=level:1&pageEntity.size=10&pageEntity.index=1'/>">国家级</a></li>
              <li><a href="<c:url value='/basic/xm.do?qm=plistProject_level&conditions=level:2&pageEntity.size=10&pageEntity.index=1'/>">省&nbsp;&nbsp;级</a></li>
              <li><a href="<c:url value='/basic/xm.do?qm=plistProject_level&conditions=level:3&pageEntity.size=10&pageEntity.index=1'/>">市&nbsp;&nbsp;级</a></li>
              <li><a href="<c:url value='/basic/xm.do?qm=plistProject_level&conditions=level:4&pageEntity.size=10&pageEntity.index=1'/>">县&nbsp;&nbsp;级</a></li>
            </ul>
          </div>
        </div>
      </div>
      <div data-tab-panel-2 class="am-tab-panel">
        <div class="site">
          <div class="menu-page">
            <ul class="list-site">
              <li><a href="<c:url value='/basic/xm.do?qm=plistProject_allDirt&conditions=&pageEntity.size=10&pageEntity.index=1'/>">全&nbsp;&nbsp;&nbsp;&nbsp;部</a></li>
              <c:if test="${!empty AddressProvinceList}">
                <c:forEach var="AddressProvince" items="${AddressProvinceList}">
                  <li><a href="<c:url value='/basic/xm.do?qm=plistProject_Dirt&conditions=addressDistrict.addressCity.addressProvince.id:${AddressProvince.id}&pageEntity.size=10&pageEntity.index=1'/>">${AddressProvince.name}</a></li>
                </c:forEach>
              </c:if>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</div>
<!--地区-->
<%--<div class="login-reg">
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
<!--//End--footer-->--%>

<script src="<c:url value='/resources/assets/js/jquery.min.js?v=20150831'/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>

<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<!--自定义js--Start-->
<script src="<c:url value='/resources/assets/js/amazeui.min.js?v=20150831'/>"></script>
<script src="<c:url value='/scripts/assets/wap/js/system.js?v=20150831'/>"></script>
<script src="<c:url value='/scripts/assets/wap/js/cyclopedia.js?v=20150831'/>"></script>
<!--自定义js--End-->
</body>
</html>
