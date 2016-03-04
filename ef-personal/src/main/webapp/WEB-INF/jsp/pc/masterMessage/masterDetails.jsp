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
  <title>大师动态-分享</title>
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
<%--<div class="topbar wh" data-am-sticky>--%>
  <%--<div class="hd">--%>
    <%--<ul class="ul-item">--%>
      <%--<li><strong>李先生8899</strong><a href="" title="退出">退出</a></li>--%>
      <%--<!--<li><a href="" title="请登录">请登录</a></li>-->--%>
      <%--<li><a href="" title="快速注册">快速注册</a></li>--%>
      <%--<li class="btn-top-wechat">--%>
        <%--<a title="手机e飞蚁">手机e飞蚁</a>--%>
        <%--<span class="top-wechat"></span>--%>
      <%--</li>--%>
      <%--<li><a href="" title="个人中心">个人中心</a></li>--%>
    <%--</ul>--%>
  <%--</div>--%>
<%--</div>--%>
<%--<!-- //End--topbar-->--%>
<%--<div class="header wh">--%>
  <%--<div class="hd">--%>
    <%--<div class="logo"><a class="icon" href="" target="_blank" title="e飞蚁-爱非遗"></a></div>--%>
    <%--<div class="nav">--%>
      <%--<ul>--%>
        <%--<li><a href="" title="首页">e飞蚁首页</a></li>--%>
        <%--<li><a href="" title="传承人">大师</a></li>--%>
        <%--<li><a href="" title="展览">工艺</a></li>--%>
      <%--</ul>--%>
    <%--</div>--%>
  <%--</div>--%>
<%--</div>--%>
<!-- //End--header-->
<div class="hd" style="width: 1000px;">
  <div class="nav-bars ae">
    <ul class="bars">
      <li class="active"><a href="#">推&nbsp;荐</a></li>
      <%--<li class="active"><a href="#">动&nbsp;态</a></li>--%>
      <%--<c:if test="${result == 'show'}">--%>
      <%--<li><a href="<c:url value='/masterMessage/forwardUrl'/>">关注</a></li>--%>
      <%--</c:if>--%>
      <%--<c:if test="${result == 'hide'}">--%>
      <%--<li><a href="<c:url value='/masterMessage/getFollowBeforeList'/>">关注</a></li>--%>
      <%--</c:if>--%>
      <li><a href="<c:url value='/masterMessage/classify'/>">发&nbsp;现</a></li>
    </ul>
  </div>
</div>
<!--nav-bars-->
<div class="ae">
  <div class="particulars">
    <div class="p-left">
      <img src="http://tenant.efeiyi.com/${object.favicon}">
      <h5>${object.fullName}</h5>
      <h6>${object.brief}</h6>
      <p>技艺名称：<span>${object.projectName}</span></p>
      <p>技艺类别：
        <span>
          <c:choose>
            <c:when test="${object.level == '1'}">
              国家级
            </c:when>
            <c:when test="${object.level == '2'}">
              省级
            </c:when>
            <c:when test="${object.level == '3'}">
              市级
            </c:when>
            <c:otherwise>
              县级
            </c:otherwise>
          </c:choose>
          非物质文化遗产
        </span>
      </p>
    </div>
    <div class="p-right">
      ${object.content}
    </div>
  </div>
</div>
<!--//End--footernew-->
<!-- //End--footer-->
<!--[if (gte IE 9)|!(IE)]><!-->
<%--<script src="../shop2015/js/jquery.min.js"></script>--%>
<script>
  $(function(){
    $("#pages").html("大师详情 - e飞蚁");
    var txtL = $("#txt").text().length;
    if(txtL>30){
      $("#txt").text($("#txt").text().substr(0,50)).append("...")
    }
  })
</script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value='/scripts/assets/js/amazeui.ie8polyfill.min.js'/>"></script>
<![endif]-->
<script src="<c:url value='/scripts/assets/pc/js/system.js'/>"></script>
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
<script src="<c:url value='/scripts/assets/pc/js/cyclopedia.js'/>"></script>
</body>
</html>
