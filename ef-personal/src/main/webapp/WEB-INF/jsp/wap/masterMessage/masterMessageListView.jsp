<%@ page import="com.efeiyi.ec.personal.AuthorizationUtil" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
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
</head>
<body>
<header class="am-header custom-header">
  <div class="am-header-left am-header-nav">
    <a href="javascript:history.go(-1);" class="chevron-left"></a>
  </div>
  <!-- //End--chevron-left-->
  <h1 class="am-header-title">${object.fullName}</h1>
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
        <li><a href="" title="分类">消&nbsp;息</a></li>
        <li><a href="" title="个人中心">个&nbsp;人&nbsp;中&nbsp;心</a></li>
      </ul>
    </div>
  </div>
</header>
<!--//End--header-->
<div class="master-works">
  <div class="user">
    <img class="img-user" src="http://tenant.efeiyi.com/${object.favicon}" alt=""/>
    <img class="img-bg" src="http://tenant.efeiyi.com/${object.backgroundUrl}" alt=""/>
    <div class="user-info">
      <p class="user-name">${object.fullName}</p>
      <p class="project-name">徽派竹刻</p>
      <p class="level-name"><ming800:status name='level' dataType='Tenant.level' checkedValue='${object.level}' type='normal'/>非物质文化遗产传承人
        <i class="icon icon-v"></i>
      </p>
    </div>
    <div class="user-nav">
      <ul>
        <li class="active">
          <i class="icon icon-user-1"></i>
          <strong>动态</strong>
          <i class="user-arrow-up"></i>
        </li>
        <li>
          <i class="icon icon-user-2"></i>
          <strong>简介</strong>
        </li>
        <li>
          <i class="icon icon-user-3"></i>
          <strong>作品</strong>
        </li>
      </ul>
    </div>
  </div>
  <!-- //End---->
  <div class="great">
    <!--大师动态-->
    <div class="suit">
      <c:forEach items="${objectList}" var="message">
      <div class="dynamic">
        <div class="dynamic-st">
          <div class="suit-st-text">
            <p><span>${message.content}</span></p>
          </div>
          <!--图片效果1！-->
          <div class="suit-st-img"> <img src="/scripts/assets/upload/120101-p1-2.jpg"> </div>

          <!--图片效果2！定死9张图片-->
          <div class="suit-st-ft">
            <div class="suit-ft-left"><span>${message.dataSource}</span></div>
            <div class="suit-ft-right"><span>1小时前</span></div>
          </div>
        </div>
        <div class="dynamic-ft">
          <a href="#" onclick="changePraiseStatus(this,'${message.id}');" class="ft-a"> <i class="good-1"></i>
              <em><c:if test="${empty message.praiseStatus}">赞</c:if><c:if test="${message.praiseStatus != null}">${message.praiseStatus}</c:if></em>
          </a> <i class="s-solid ft-a"></i> <a href="#" class="ft-a"> <i class="good-2"></i> <em>9999</em> </a> <i class="s-solid ft-a"></i>
          <a onclick="collected(this,'${message.id}');" class="ft-a"> <i class="good-3"></i> </a> </div>
      </div>
      </c:forEach>
    </div>
  </div>
</div>
<!--地区-->
<div class="login-reg">
  <%if(AuthorizationUtil.getMyUser()!=null && AuthorizationUtil.getMyUser().getId() != null){ %>
  <div class="bd logined"><%=AuthorizationUtil.getMyUser().getUsername()%><a class="btn-exit" href="<c:url value='/j_spring_cas_security_logout'/>">退出</a></div>
  <% } %>
  <%if(AuthorizationUtil.getMyUser()==null || AuthorizationUtil.getMyUser().getId() == null){ %>
  <a href="<c:url value='http://192.168.1.57/cas/login?service=http%3A%2F%2Flocalhost:8080%2Fj_spring_cas_security_check'/>" class="btn-login" title="登录">登&nbsp;&nbsp;&nbsp;&nbsp;录</a>
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
<!--//End--footer-->
<script>

  function collected(o,messageId){
    $.ajax({
      type: "get",//设置get请求方式
      url: "<c:url value='/masterMessage/storeMessage.do'/>",//设置请求的脚本地址
      data: "msgId="+messageId,//设置请求的数据
      async: true,
      dataType: "json",//设置请求返回的数据格式
      success: function (data) {
        if(data =="noRole"){
          alert("您还没有登录,请登录后操作!");
        }else if(data == "add"){
          $(o).find("em").html("已收藏");
        }else if(data == "del"){
          $(o).find("em").html("收藏");
        }
      }
    })
  }

  function changePraiseStatus(o,messageId){
    $.ajax({
      url:"<c:url value='/masterMessagePraise/changePraiseNum.do'/>",
      data:"messageId="+messageId,
      type:"POST",
      async:false,
      dataType:"json",
      error:function(){},
      success:function(msg){
        if(msg == "noRole"){
          alert("您还未登录,请登录后操作");
        }else if(msg == "add"){
          $(o).find("em").html("取消赞");
        }else if(msg == "del"){
          $(o).find("em").html("赞");
        }
      }
    })
  }
</script>

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
<script>
  $
</script>
</body>
</html>