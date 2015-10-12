<%@ page import="com.efeiyi.ec.personal.AuthorizationUtil" %>
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
  <title>120102大师动态-图-文</title>
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
<div class="great">
  <header class="am-header custom-header">
    <div class="am-header-left am-header-nav"> <a href="javascript:history.go(-1);" class="chevron-left"></a> </div>
    <!-- //End--chevron-left-->
    <h1 class="am-header-title">大师</h1>
    <!-- //End--title-->
    <div class="am-header-right am-header-nav am-header-right1"> <a href="#chevron-right" class="chevron-right" id="menu"> <i class="icon icon-user"></i> </a> </div>
  </header>
  <!--//End--header-->
  <!--地区-->
  <div class="dis-q1">
    <div class="tabs-bd">
      <div class="am-tab-panel am-active">
        <!--大师动态-->
        <div class="suit">
          <div class="dynamic">
            <div class="dynamic-hd"> <a class="suit-tx"><img class="am-circle" src="/scripts/assets/upload/120102-p1-1.jpg"></a>
              <div class="suit-name"><a href="#"><span>${object.master.fullName}</span></a></div>
              <a class="suit-gz" onclick="changeStatus(this,'${object.master.id}');"><span>${object.master.followStatus}</span></a> </div>
            <div class="dynamic-st">
              <div class="dynamic-suit-st-img">
                <p><img src="/scripts/assets/upload/120102-p1-2.jpg"></p>
                <p class="txt">${object.content}</p>
                <p><img src="/scripts/assets/upload/120102-p1-3.jpg"></p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="review">
  <div class="dialogue">
    <h4 class="pl-name">评论</h4>
    <!--评论状态-->
    <div class="matter">
      <p class="text-h1">Joe</p>
      <p class="text-time">10分钟前</p>
      <p class="text-content"><a href="#">还不错，真是涨知识了。之前只是知道，现
        在对景泰蓝了解了这么多，真是棒极了。过
        段时间我也入手一件景泰蓝工艺品。</a></p>
      <div class="owner"><img class="am-circle" src="/scripts/assets/upload/120102-p1-11.jpg"></div>
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
      <p class="text-content"><a href="#">中国文化博大精深，中国的老艺人把手艺能
        坚持到现在真不容易，我们不能那老祖宗的
        手艺丢掉啊。</a></p>
      <div class="owner"><img class="am-circle" src="/scripts/assets/upload/120102-p1-11.jpg"></div>
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
  <div class="bd info"> <a class="icon"></a>
    <div class="txt">中&nbsp;&nbsp;国&nbsp;&nbsp;非&nbsp;&nbsp;遗&nbsp;&nbsp;电&nbsp;&nbsp;商&nbsp;&nbsp;平&nbsp;&nbsp;台</div>
    <div class="wechat"></div>
    <div class="txt">关注微信公众号</div>
    <div class="txt">领取超值代金券</div>
  </div>
  <div class="bd copyright">京ICP备15032511号-1</div>
</footer>
<!--//End--footer-->
</div>
<script>
  function changeStatus(o,masterId){
    var status = "";
    var str = $(o).find("span").html();
    if(str == "已关注"){
      status = "2";
    }else if(str == "关注"){
      status = "1";
    }
    $.ajax({
      type: "POST",
      url: "<c:url value='/masterFollow/followed.do'/>",
      data:"masterId="+masterId+"&status="+status,
      async:false,
      dataType:"json",
      error:function(){alert("操作失败.请联系系统管理员!")},
      success:function(msg){
        if(msg == "1"){
          $(o).find("span").html("关注");
        }else if(msg == "2"){
          $(o).find("span").html("已关注");
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
</body>
</html>