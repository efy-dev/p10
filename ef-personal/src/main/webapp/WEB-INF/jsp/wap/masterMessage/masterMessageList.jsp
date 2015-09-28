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
  <script src="<c:url value='/scripts/assets/js/jquery-2.1.3.min.js'/>" type="text/javascript"></script>
  <script type="text/javascript" src="<c:url value='/scripts/assets/js/pubu.js'/>"></script>
</head>
<body>
<div class="great">
  <header class="am-header custom-header">
    <div class="am-header-left am-header-nav"> <a href="javascript:history.go(-1);" class="chevron-left"></a> </div>
    <h1 class="am-header-title">大师</h1>
    <div class="am-header-right am-header-nav am-header-right1"> <a href="#chevron-right" class="chevron-right" id="menu"> <i class="icon icon-user"></i> </a> </div>
  </header>
  <!--//End--header-->
  <!--地区-->
  <div class="dis-q1">
    <div class="dis-q1-tabs">
      <ul class="tabs-nav tabs-nav-1" id="dynamic" onclick="changePage(this);">
        <li class="item active" title="1">动态</li>
        <li class="item" title="2">关注</li>
        <li class="item-class"><a href="<c:url value='/masterCategory/CategoryList.do'/>">分类</a></li>
      </ul>
      <ul class="tabs-nav tabs-nav-2">
        <li class="item active" title="1">分类</li>
        <li class="item" title="2">级别</li>
        <li class="item" title="3">地区</li>
      </ul>
      <div class="tabs-bd">
        <div class="am-tab-panel am-active">
          <!--大师动态-->
          <div class="suit" id="pubu">
            <c:forEach items="${messageList}" var="msg">
            <div class="dynamic">
              <div class="dynamic-hd">
                <a class="suit-tx" href="<c:url value='/masterMessage/getOnlyMasterMessageList.do'/>"><img class="am-circle" src="/scripts/assets/upload/120101-p1-1.jpg"></a>
                <div class="suit-name" ><span>${msg.master.fullName}</span></div>
                <a class="suit-gz"><span>关注</span></a> </div>
              <div class="dynamic-st">
                <div class="suit-st-text">
                  <p><span>${msg.content}</span></p>
                </div>
                <div class="suit-st-img"> <img src="/scripts/assets/upload/120101-p1-2.jpg"> </div>
                <div class="suit-st-ft">
                  <div class="suit-ft-left"><span>${msg.dataSource}</span></div>
                  <div class="suit-ft-right"><span>1小时前</span></div>
                </div>
              </div>
              <div class="dynamic-ft"> <a href="#" class="ft-a"> <i class="good-1"></i> <em>9999</em> </a> <i class="s-solid ft-a"></i> <a href="#" class="ft-a"> <i class="good-2"></i> <em>9999</em> </a> <i class="s-solid ft-a"></i> <a href="#" class="ft-a"> <i class="good-3"></i> </a> </div>
            </div>
            </c:forEach>
          </div>
        </div>
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
  function changePage(){
    $("#dynamic li").each(function(){
      if($(this).attr("class")=="item active"){
        if($(this).attr("title")=="1"){
          getData();
        }
        if($(this).attr("title")=="2"){
          getAttentionList();
        }
      }
    });
  }
  var flag = false;
  $(window).load(function(){
    $("#dynamic li").each(function(){
      if($(this).attr("class")=="item active"){
        if($(this).attr("title")=="1"){
          getData();
        }
        if($(this).attr("title")=="2"){
          getAttentionList();
        }
      }
    });
  });
  function getData(){
    $.ajax({
      type: "POST",
      url: "<c:url value='/masterMessage/masterMessageList.do'/>",
      async:false ,
      error: function(){alert('出错了,请联系系统管理员!');},
      success: function(data){
        var obj = eval(data);
        var box = $("#pubu");
        box.empty();
        for(var i = 0 ;i < obj.length ;i++){
          var masterId = obj[i].masterId;
          var masterName = obj[i].masterName;
          getAttentionStatus(masterId);
          var attention = "";
          if(flag == true){
            attention = "已关注";
          }else{
            attention = "关注";
          }
          var sub = "<div class=\"dynamic\">"
                  +"<div class=\"dynamic-hd\">"
                  +"<a class=\"suit-tx\" href=\"<c:url value='/masterMessage/getOnlyMasterMessageList.do?masterId='/>"+masterId+"\"><img class=\"am-circle\" src=\"/scripts/assets/upload/120101-p1-1.jpg\"></a>"
                  +"<div class=\"suit-name\"><a href=\"#\"><span>"+masterName+"</span></a></div>"
                  +"<a class=\"suit-gz\" onclick=\"changeStatus(this,'"+masterId+"');\"><input type=\"hidden\" name='"+masterId+"'><span>"+attention+"</span></a> </div>"
                  +"<div class=\"dynamic-st\">"
                  +"<div class=\"suit-st-text\">"
                  +"<p><span>"+obj[i].content+"</span></p>"
                  +"</div>"
                  +"<div class=\"suit-st-img\"><a href=\"<c:url value='/masterMessage/getMasterMessage.do?messageId='/>"+obj[i].id+"\"><img src=\"/scripts/assets/upload/120101-p1-2.jpg\"></a> </div>"
                  +"<div class=\"suit-st-ft\">"
                  +"<div class=\"suit-ft-left\"><span>"+obj[i].dataSource+"</span></div>"
                  +"<div class=\"suit-ft-right\"><span>1小时前</span></div>"
                  +"</div></div>"
                  +"<div class=\"dynamic-ft\"> "
                  +"<a href=\"#\" class=\"ft-a\"> <i class=\"good-1\"></i><em>9999</em></a><i class=\"s-solid ft-a\"></i> "
                  +"<a href=\"#\" class=\"ft-a\"> <i class=\"good-2\"></i><em>9999</em></a><i class=\"s-solid ft-a\"></i> "
                  +"<a href=\"#\" class=\"ft-a\"> <i class=\"good-3\"></i></a></div></div>";
          box.append(sub);
        }
      }
    });
  }
  function getAttentionStatus(masterId){
    $.ajax({
      type: "POST",
      url: "<c:url value='/masterFollow/masterFollowed.do'/>",
      data:"masterId="+masterId,
      async:false,
      dataType:"json",
      error: function(){alert('操作失败,请联系系统管理员!');},
      success: function(msg){
        if(msg == true){
          flag = true;
          return flag;
        }else{
          flag = false;
          return flag;
        }
      }
    })
  }

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
      error:function(){alert("出错了.请联系系统管理员!")},
      success:function(msg){
        $("input[name='"+masterId+"']").each(function(){
          if(msg == "1"){
            $(this).next().html("关注");
          }else if(msg == "2"){
            $(this).next().html("已关注");
          }
        })
      }
    })
  }

  <!-- getData1(); -->

  function getAttentionList(){
    $.ajax({
      type: "POST",
      url: "<c:url value='/masterFollow/masterFollowedList.do'/>",
      async:false ,
      dataType:"json",
      error: function(){alert('出错了,请联系系统管理员!');},
      success: function(data){
        var box = $("#pubu");
        box.empty();
        if(data.length > 0 && data.length < 5){
            $.ajax({
              type: "POST",
              url: "<c:url value='/masterFollow/getMasterRecommendList.do'/>",
              async:false ,
              error: function(){alert('出错了,请联系系统管理员!');},
              success: function(objList){
                var recommendList = eval("("+objList+")");
                var sub = "<div class=\"dynamic\"><div class=\"attention\"><p>目前您还没有关注任何大师，下面是我们为您推荐的几位大师</p></div><ul class=\"dynamic-list-suit\">";
                for(var i = 0 ;i < recommendList.length ;i++){
                    sub += "<li><div class=\"suit-list-bt\">"+
                          "<a href=\"#\"><img src=\"/scripts/assets/upload/box-tx-3-4-7.jpg\"></a>"+
                          "<a class=\"gz-fd-icon\" id=\"isOrNot\" onclick=\"changeFollowedStatus(this,'"+recommendList[i].id+"')\">关注</a></div></li>";
                }
                sub += "</ul><a href=\"#\" class=\"state-btn\">查看更多大师<span class=\"gd-icon\"></span></a> </div>";
                box.append(sub);
              }
            });
        }else{
          var sub = "";
          for(var i = 0 ;i < data.length ;i++){
            sub += "<div class=\"dynamic\">" +
                    "<div class=\"dynamic-hd\"> <a class=\"suit-tx\"><img class=\"am-circle\" src=\"/scripts/assets/upload/120101-p1-1.jpg\"></a>" +
                    "<div class=\"suit-name\"><a href=\"#\"><span>蔡水况</span></a></div>" +
                    "<a class=\"suit-gz\"><span>已关注</span></a> </div>" +
                    "<div class=\"dynamic-st\">" +
                    "<div class=\"suit-st-text\">" +
                    "<p><span>"+data[i].content+"</span></p>" +
                    "</div>" +
                    "<div class=\"suit-st-img\"> <img src=\"/scripts/assets/upload/120101-p1-2.jpg\"> </div>" +
                    "<div class=\"suit-st-ft\">" +
                    "<div class=\"suit-ft-left\"><span>"+data[i].dataSource+"</span></div>" +
                    "<div class=\"suit-ft-right\"><span>1小时前</span></div>" +
                    "</div></div>" +
                    "<div class=\"dynamic-ft\"> <a href=\"#\" class=\"ft-a\"> <i class=\"good-1\"></i> <em>9999</em> </a>  " +
                    "<i class=\"s-solid ft-a\"></i> <a href=\"#\" class=\"ft-a\"> <i class=\"good-2\"></i> <em>9999</em> </a>"+
                    "<i class=\"s-solid ft-a\"></i> <a href=\"#\" class=\"ft-a\"> <i class=\"good-3\"></i> </a> </div>";
          }
          box.append(sub);
        }
      }
    });
  }
  function changeFollowedStatus(o,masterId){
    var status = "";
    var str = $(o).html();
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
            $(o).html("关注");
          }else if(msg == "2"){
            $(o).html("已关注");
          }
      }
    })
  }

</script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value='/scripts/assets/js/amazeui.ie8polyfill.min.js'/>"></script>
<script src="<c:url value='/scripts/assets/js/amazeui.min.js'/>"></script>
<!--自定义js--Start-->
<script src="<c:url value='/scripts/assets/js/system.js?v=20150831'/>"></script>
<script src="<c:url value='/scripts/assets/js/cyclopedia.js?v=20150831'/>"></script>
<!--自定义js--End-->
</body>
</html>