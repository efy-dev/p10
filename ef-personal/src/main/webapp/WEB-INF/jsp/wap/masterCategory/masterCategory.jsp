<%@ page import="com.efeiyi.ec.personal.AuthorizationUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
</head>
<body>
<header class="am-header custom-header">
  <div class="am-header-left am-header-nav">
    <a href="javascript:history.go(-1);" class="chevron-left"></a>
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
        <li><a href="<c:url value='/masterMessage/index.do'/>" title="首页">首页</a></li>
        <li><a href="javascript:void(0);" id="acs" title="分类">消&nbsp;息</a></li>
        <li><a href="http://www.i.efeiyi.com" title="个人中心">个&nbsp;人&nbsp;中&nbsp;心</a></li>
      </ul>
    </div>
  </div>
</header>
<!--//End--header-->
<div style="display: none"  id="showMessage" class="pops-up">
  <div style="background: #fff;" data-am-widget="tabs"
       class="am-tabs am-tabs-default"
          >
    <ul class="am-tabs-nav am-cf">
      <li class="am-active"><a href="[data-tab-panel-0]"><i class="bz-icon1"></i>
        <span style="float: left;margin-left: 10px;">关注</span><i class="sod-sr"></i></a></li>
      <li class=""><a href="[data-tab-panel-1]">
        <i class="bz-icon2"></i>
        <span style="float: left;margin-left: 10px;">评论</span><i class="sod-sr"></i>
      </a></li>
      <li class=""><a href="[data-tab-panel-2]">
        <i class="bz-icon3"></i>
        <span style="float: left;margin-left: 10px;">点赞</span></i>
      </a></li>
    </ul>
    <div class="am-tabs-bd">
      <div data-tab-panel-0 class="am-tab-panel am-active">
        <div class="aboud-you">
          <div class="list-you"><span>这些人最近关注了你</span></div>
          <ul class="list-name" id="">
            <li><div class="name-img"><img class="am-circle" src="../shop2015/upload/120102-p1-11.jpg"/></div><span>Andy</span></li>
            <li><div class="name-img"><img class="am-circle" src="../shop2015/upload/120102-p1-11.jpg"/></div><span>Lily</span></li>
            <li><div class="name-img"><img class="am-circle" src="../shop2015/upload/120102-p1-11.jpg"/></div><span>wangjl</span></li>
          </ul>
          <div class="more"><a href="#"><i class="time-1"></i>查看更多评论</a></div>
        </div>
      </div>
      <div data-tab-panel-1 class="am-tab-panel ">
        <div class="discuss">
          <ul class="discuss-2">
            <li class="review">
              <div class="matter">
                <p class="text-h1"><a href="#">Andya</a>回复了你</p>
                <p class="text-time">51分钟前</p>
                <p class="text-content"><a href="#" >原来木板水印是一门高深的技艺，之前从来没
                  有关注过，真心觉得中国的非遗文化值得我们
                  去传承。</a></p>
                <div class="owner"><img class="am-circle" src="../shop2015/upload/120102-p1-11.jpg"/></div>
              </div>
            </li>
            <li class="review">
              <div class="matter">
                <p class="text-h1"><a href="#">Joe</a>回复了你</p>
                <p class="text-time">1小时前</p>
                <p class="text-content"><a href="#" >原来木板水印是一门高深的技艺，之前从来没
                  有关注过，真心觉得中国的非遗文化值得我们
                  去传承。</a></p>
                <div class="owner"><img class="am-circle" src="../shop2015/upload/120102-p1-11.jpg"/></div>
              </div>
            </li>
          </ul>
        </div>
      </div>
      <div data-tab-panel-2 class="am-tab-panel ">
        <div class="discuss">
          <ul class="discuss-2">
            <li class="review">
              <div class="matter">
                <p class="text-h1">Joe</p>
                <p class="text-time">1小时前</p>
                <p class="text-content"><a href="#" >觉得你的评论“还不错”很赞</a></p>
                <div class="owner"><img class="am-circle" src="../shop2015/upload/120102-p1-11.jpg"/></div>
              </div>
              <div class="review" style="padding-top: 0.8rem">
                <div class="matter">
                  <p class="text-h1"><a href="#">Andy</a>回复了你</p>
                  <p class="text-time">1小时前</p>
                  <p class="text-content"><a href="#" >觉得你的评论“中国的非遗文化值得我们去传
                    承”很赞</a></p>
                  <div class="owner"><img class="am-circle" src="../shop2015/upload/120102-p1-11.jpg"/></div>
                </div>
              </div>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
  <div style="background: #000;opacity: 0.5;width: 100%;height: 100%;position: absolute;"></div>
</div>
<!--地区-->
<div class="dis-q1">
  <div class="dis-q2">
    <div data-am-widget="tabs" class="am-tabs am-tabs-default am-no-layout">
      <ul class="am-tabs-nav am-cf" id="category">
        <li class="am-active" title="1"><a href="[data-tab-panel-0]">分类</a></li>
        <li class="" title="2"><a href="[data-tab-panel-1]">级别</a></li>
        <li class="" title="3"><a href="[data-tab-panel-2]">地区</a></li>
      </ul>
      <div class="am-tabs-bd" style="touch-action: pan-y; -webkit-user-select: none; -webkit-user-drag: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);">
        <div data-tab-panel-0="" class="am-tab-panel am-active">
          <div class="site">
            <div class="menu-page">
              <ul class="list-site" id="classify">
                <li><a href="<c:url value='/masterCategory/forwardPage'/>">全部</a></li>
                <c:if test="${!empty categoryList}">
                    <c:forEach items="${categoryList}" var="cate">
                        <li><a href="<c:url value='/masterCategory/getProjectNameList.do?projectId='/>${cate.project.id}">${cate.project.name}</a></li>
                    </c:forEach>
                </c:if>
              </ul>
            </div>
          </div>
        </div>
        <!-- //End--分类-->
        <div data-tab-panel-1="" class="am-tab-panel ">
          <div class="site">
            <div class="menu-page">
              <ul class="list-site" id="level">
                <li><a href="<c:url value='/masterCategory/forwardPage'/>">全部</a></li>
                <li><a href="<c:url value='/masterCategory/getLevelList.do?level=1'/>">国家级</a></li>
                <li><a href="<c:url value='/masterCategory/getLevelList.do?level=2'/>">省级</a></li>
                <li><a href="<c:url value='/masterCategory/getLevelList.do?level=3'/>">市级</a></li>
                <li><a href="<c:url value='/masterCategory/getLevelList.do?level=4'/>">县级</a></li>
              </ul>
            </div>
          </div>
        </div>
        <!-- //End--级别-->
        <div data-tab-panel-2="" class="am-tab-panel">
          <div class="site">
            <div class="menu-page">
              <ul class="list-site" id="city">
                <li><a href="<c:url value='/masterCategory/forwardPage'/>">全部</a></li>
                <c:if test="${!empty cityList}">
                  <c:forEach items="${cityList}" var="city">
                    <li><a href="<c:url value='/masterCategory/getCityList.do?cityId='/>${city.id}">${city.name}</a></li>
                  </c:forEach>
                </c:if>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!--地区-->
</div>
<!--地区-->
<div class="login-reg">
  <%if(AuthorizationUtil.getMyUser()!=null && AuthorizationUtil.getMyUser().getId() != null){ %>
  <div class="bd logined"><%=AuthorizationUtil.getMyUser().getUsername()%><a class="btn-exit" href="<c:url value='/j_spring_cas_security_logout'/>">退出</a></div>
  <% } %>
  <%if(AuthorizationUtil.getMyUser()==null || AuthorizationUtil.getMyUser().getId() == null){ %>
  <a href="<c:url value='/sso.do'/>" class="btn-login" title="登录">登&nbsp;&nbsp;&nbsp;&nbsp;录</a>
  <a href="#reg" class="btn-reg">注&nbsp;&nbsp;&nbsp;&nbsp;册</a>
  <% } %>

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
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="<c:url value='/scripts/assets/js/jquery.min.js'/>"></script>
<!--<![endif]-->
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