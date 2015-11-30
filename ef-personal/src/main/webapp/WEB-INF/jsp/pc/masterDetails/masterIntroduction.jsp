<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
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
  <%--<link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/pc/css/amazeui.min.css?v=20150831'/>">--%>
  <%--<link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/pc/css/app.css?v=20150831'/>">--%>
  <%--<link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/pc/css/leader.css?v=20150831'/>">--%>
  <%--<script src="<c:url value='/scripts/assets/pc/js/jquery.min.js'/> "></script>--%>
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
        <%--<li><a href="<c:url value='/masterMessage/index.do'/>" title="传承人">大师</a></li>--%>
        <%--<li><a href="" title="展览">工艺</a></li>--%>
      <%--</ul>--%>
    <%--</div>--%>
  <%--</div>--%>
<%--</div>--%>
<!-- //End--header-->
<div class="ae">
  <div class="great-master">
    <div class="master-pic"><img src="http://tenant.efeiyi.com/${object.favicon}@!master-favicon-view" alt="传承人" class="am-img-thumbnail am-circle"></div>
    <h5>${object.fullName}</h5>
    <c:if test="${!empty object.projectName}">
      <p>[${object.projectName}]</p>
    </c:if>
    <div class="great"><em><ming800:status name='level' dataType='Tenant.level' checkedValue='${object.level}' type='normal'/>非物质文化遗产传承人</em><i class="icon-master"></i></div>
    <p class="text-great">${object.brief}</p>
    <div class="gz-master">
      <div class="mst-gz">
        <div class="pc-gz">
          <div class="bt-gz">
            <a class="btn-guan" onclick="followMaster(this,'${object.id}');">
              <div class="gz-q">
                <c:if test="${object.followStatus == '已关注'}">
                  <i class="gz-icon" style="display: none;"></i>
                </c:if>
                <c:if test="${object.followStatus == '关注'}">
                  <i class="gz-icon"></i>
                </c:if>
                <em>${object.followStatus}</em>
              </div>
            </a>
          </div>
        </div>
        <div class="mst-text"><span>${object.fsAmount}粉丝</span></div>
      </div>
    </div>
  </div>
  <div class="hd">
  <div class="great-nav">
    <div class="nav-bars ae">
      <ul class="bars">
        <li><a href="<c:url value='/masterMessage/masterView/'/>${object.id}">主&nbsp;页</a></li>
        <li class="active"><a href="<c:url value='/masterMessage/introView/'/>${object.id}">介&nbsp;绍</a></li>
        <li><a href="<c:url value='/masterMessage/getPartWorks/'/>${object.id}">作&nbsp;品</a></li>
      </ul>
    </div>
  </div>
  </div>
  <!-- //End--master-nav-->
  <div class="content-master">
    <div class="master-bnner">
      <div class="focus wh">
        <!--轮播图-->
        <ul class="slider-main">
          <c:if test="${!empty bannerList && bannerList.size() > 0}">
            <c:forEach items="${bannerList}" var="banner">
              <li style="display: block;"><a href="#"><img src="http://tenant.oss-cn-beijing.aliyuncs.com/${banner.imageUrl}"></a></li>
            </c:forEach>
          </c:if>
        </ul>
        <ul class="slider-nav">
          <li class="active"></li>
          <li></li>
          <li></li>
        </ul>
      </div>
    </div>
    <div class="master-text">
      <div class="mas-tx-left">
        <p>${object.content}</p>
        <div class="f-r-gd ae"><a href="#"><span>阅读更多</span><i class="sp-icon"></i></a></div>
        <h5>出版著作</h5>
        <ul class="publish">
          <c:if test="${!empty introductionList && introductionList.size() > 0}">
            <c:forEach items="${introductionList}" var="intro">
              <c:if test="${intro.type == '3'}">
                <c:forEach items="${intro.attachmentList}" var="attr">
                  <li>
                    <img src="http://tenant.efeiyi.com/${attr.url}@!master-intro-product">
                    <p>${attr.title}</p>
                  </li>
                </c:forEach>
              </c:if>
            </c:forEach>
          </c:if>
        </ul>
        <div class="f-r-gd ae"><a href="#"><span>查看更多</span><i class="sp-icon"></i></a></div>
      </div>
      <div class="mas-tx-right">
        <c:if test="${!empty introductionList && introductionList.size() > 0}">
          <c:forEach items="${introductionList}" var="intro">
            <c:if test="${intro.type == '5'}">
              <h5>${intro.title}</h5>
              <video style="margin-bottom:20px; " controls="controls" src="http://www.iqiyi.com/common/flashplayer/20151008/MainPlayer_5_2_28_1_c3_3_7_5.swf" width="100%" height="384"></video>
              <p>${intro.content}</p>
              <c:if test="${!empty intro.attachmentList && intro.attachmentList.size() > 0}">
                <c:forEach items="${intro.attachmentList}" var="attr">
                  <img src="${attr.videoPath}">
                </c:forEach>
              </c:if>
            </c:if>
          </c:forEach>
        <div class="honor">
          <p>获得荣誉</p>
          <ul class="gain">
            <c:forEach items="${introductionList}" var="intro">
              <c:if test="${intro.type == '2'}">
                <c:forEach items="${intro.attachmentList}" var="attr">
                  <li>
                    <div><img src="http://tenant.efeiyi.com/${attr.url}@!master-intro-honour"></div>
                    <p>${attr.title}</p>
                  </li>
                </c:forEach>
              </c:if>
            </c:forEach>
          </ul>
        </div>
        </c:if>
      </div>
    </div>
  </div>
</div>
<script>
  function followMaster(o , masterId){
    var str;
    $.ajax({
      type: "post",//设置get请求方式
      url: "<c:url value='/masterMessage/followMaster.do'/>" ,//设置请求的脚本地址
      data: "masterId="+masterId,//设置请求的数据
      async: true,
      dataType: "json",//设置请求返回的数据格式
      success: function (data) {
        var next = $(o).parent().parent().next().find("span");
        var fsAmount = parseInt($(o).parent().parent().next().find("span").html().split("粉")[0]);
        if(data == "noRole"){
          alert("您还未登录,请登录后操作!");
        }else if(data=="add"){
          str = "已关注";
          $(o).find("em").html(str);
          $(o).find(".gz-icon").hide();
          next.html((fsAmount + 1)+"粉丝");
        }else if(data=="del"){
          str = "关注";
          $(o).find("em").html(str);
          $(o).find(".gz-icon").show();
          next.html((fsAmount - 1)+"粉丝");
        }
      }
    })
  }
</script>
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value='/scripts/assets/pc/js/amazeui.ie8polyfill.min.js'/>"></script>
<![endif]-->
<script src="<c:url value='/scripts/assets/pc/js/system.js'/>"></script>
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
<script src="<c:url value='/scripts/assets/pc/js/cyclopedia.js'/>"></script>
</body>
</html>
