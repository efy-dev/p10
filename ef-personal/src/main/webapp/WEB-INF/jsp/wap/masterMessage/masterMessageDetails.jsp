<%@ page import="com.efeiyi.ec.personal.AuthorizationUtil" %>
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
<body>
<header class="am-header custom-header">
  <div class="am-header-left am-header-nav">
    <a href="javascript:history.go(-1);" class="chevron-left"></a>
  </div>
  <!-- //End--chevron-left-->
  <h1 class="am-header-title">${object.fullName}<input type="hidden" id="objText" value="${object.content}"/></h1>
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
<!--//End--header-->
<div class="master-works">
  <div class="user" style="height: 480px;">
    <img class="img-user" src="../shop2015/upload/master-0.jpg" alt=""/>
    <img class="img-bg" src="../shop2015/upload/master-1.jpg" alt=""/>
    <div class="user-info">
      <p class="user-name">${object.fullName}</p>
      <p class="project-name">${object.projectName}</p>
      <p class="level-name"><ming800:status name='level' dataType='Tenant.level' checkedValue='${object.level}' type='normal'/>非物质文化遗产传承人<i class="icon icon-v"></i></p>
    </div>
    <div class="user-nav">
      <ul id="userNav" onclick="changeType(this);">
        <li class="active" title="1">
          <i class="icon icon-user-1"></i>
          <strong>动态</strong>
          <i class="user-arrow-up"></i>
        </li>
        <li title="2">
          <i class="icon icon-user-2"></i>
          <strong>简介</strong>
        </li>
        <li title="3">
          <i class="icon icon-user-3"></i>
          <strong>作品</strong>
        </li>
      </ul>
    </div>
  </div>
  <!-- //End---->
  <div class="great" id="changeType">
    <!--大师动态-->
    <div class="suit">
      <c:if test="${!empty messageList}">
        <c:forEach items="${messageList}" var="message">
          <div class="dynamic">
            <div class="dynamic-hd"></div>
            <div class="dynamic-st">
              <div class="suit-st-text">
                <p><span>${message.content}</span></p>
              </div>
              <!--图片效果1！-->
              <div class="suit-st-img">
                <a href="<c:url value='/masterMessage/getMasterMessage.do?messageId='/>${message.id}">
                  <img src="../shop2015/upload/120101-p1-2.jpg">
                </a>
              </div>

              <!--图片效果2！定死9张图片-->
              <div class="suit-st-ft">
                <div class="suit-ft-left"><span>${message.dataSource}</span></div>
                <div class="suit-ft-right"><span>1小时前</span></div>
              </div>
            </div>
            <div class="dynamic-ft">
              <a href="#" onclick="changePraiseStatus(this,'${message.id}');" class="ft-a"> <i class="good-1"></i><em><c:if test="${empty message.praiseStatus}">赞</c:if><c:if test="${message.praiseStatus != null}">${message.praiseStatus}</c:if></em></a> <i class="s-solid ft-a"></i>
              <a href="#" class="ft-a"> <i class="good-2"></i> <em>9999</em> </a> <i class="s-solid ft-a"></i>
              <a onclick="collected('${message.id}');" class="ft-a"> <i class="good-3"></i> </a>
            </div>
          </div>
        </c:forEach>
      </c:if>
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
  function changeType(){
    $("#userNav li").each(function(){
      if($(this).attr("class")=="active"){
        var masterId = "${object.id}";
        if($(this).attr("title")=="1"){
          getMasterMessageList(masterId);
        }
        if($(this).attr("title")=="2"){
          var brief = $("#objText").val();
          var type = "2";
          getIntroduction(masterId,type ,brief);
        }
        if($(this).attr("title")=="3"){
          getMasterProjectList(masterId);
          getAllMasterWork(masterId);
        }
      }
    });
  }
  $(document).ready(function(){
    $("#userNav li").each(function(){
      if($(this).attr("class")=="active"){
        var masterId = "${object.id}";
        if($(this).attr("title")=="1"){
          getMasterMessageList(masterId);
        }
//        if($(this).attr("title")=="2"){
//          var type = "2";
//          var brief = $("#objText").val();
//          getIntroduction(masterId,type,brief);
//        }
//        if($(this).attr("title")=="3"){
//          getMasterProjectList(masterId);
//        }
      }
    });
  })

  function getMasterProjectList(masterId){
    $.ajax({
      type: "POST",
      url: "<c:url value='/masterBrief/getMasterProjectList.do'/>",
      async: false,
      data: "masterId=" + masterId,
      dataType: "json",
      error: function () {
        alert('出错了,请联系系统管理员!');
      },
      success: function (data) {
        var box = $("#changeType");
        box.removeClass();
        box.addClass("works-list");
        box.empty();
        if(data != null && data.length > 0){
          var sub = "<ul class=\"list-nav\" id=\"allProducts\" title=\""+masterId+"\"><li title='0' class=\"active\">全部</li>";
          for(var i = 0;i<data.length;i++){
            sub += "<li title=\""+data[i].project.id+"\">"+data[i].project.name+"</li>";
          }
          sub += "</ul>";
          box.append(sub);
        }
      }
    })
  }

  function getAllMasterWork(masterId){
    $.ajax({
      type: "POST",
      url: "<c:url value='/masterBrief/getMasterWorkList.do'/>",
      async: false,
      data: "masterId=" + masterId ,
      dataType: "json",
      error: function () {
        alert('出错了,请联系系统管理员!');
      },
      success: function (data) {
        var box = $("#changeType");
        var sub = "<ul class=\"list-con\" style=\"padding: 0\" id=\"worksList\" title=\""+masterId+"\">";
        if(data != null && data.length > 0){
          for(var i = 0;i<data.length;i++){
            sub += "<li class=\"item\" title=\""+data[i].project.id+"\">"+data[i].project.name +
                    "<a href=\"http://www.baidu.com\"><img src=\""+data[i].pictureUrl+"\"></a>" +
                    "<div class=\"txt\"><div class=\"name\">"+data[i].name+"</div><div class=\"txt-info\">" +
                    "<a href=\"#\"><i class=\"icon good-1\"></i><em>9999</em></a>"+
                    "<a href=\"#\"><i class=\"icon good-2\"></i><em>9999</em></a></div></div></li>";
          }
        }
        sub += "</ul>";
        box.append(sub);
      }
    })
  }

  function getMasterWorkListByProjectName(projectId , masterId){
    $.ajax({
      type: "POST",
      url: "<c:url value='/masterBrief/getMasterWorkList.do'/>",
      async: false,
      data: "masterId=" + masterId + "&projectId=" + projectId ,
      dataType: "json",
      error: function () {
        alert('出错了,请联系系统管理员!');
      },
      success: function (data) {
        var box = $("#worksList");
        box.empty();
        if(data != null && data.length > 0){
          var sub = "";
          for(var i = 0;i<data.length;i++){
            sub += "<li class=\"item\" title=\""+data[i].project.id+"\">"+data[i].project.name +
                    "<a href=\"http://www.baidu.com\"><img src=\""+data[i].pictureUrl+"\"></a>" +
                    "<div class=\"txt\"><div class=\"name\">"+data[i].name+"</div><div class=\"txt-info\">" +
                    "<a href=\"#\"><i class=\"icon good-1\"></i><em>9999</em></a>"+
                    "<a href=\"#\"><i class=\"icon good-2\"></i><em>9999</em></a></div></div></li>";
          }
          box.append(sub);
        }
      }
    })
  }

  function getIntroduction(masterId,type ,brief){
    $.ajax({
      type: "POST",
      url: "<c:url value='/masterBrief/getMasterBrief.do'/>",
      async:false ,
      data:"masterId="+masterId +"&type="+type,
      dataType:"json",
      error: function(){alert('出错了,请联系系统管理员!');},
      success: function(data) {
        var box = $("#changeType");
        box.removeClass();
        box.empty();
        var sub = "<div class=\"synopsis\"><p class=\"texp\">" + brief + "</p>" +
                "<a href=\"#\" class=\"unwind\"><i class=\"texp-active\"></i><span id=\"zk\">展开</span></a></div>" +
                "<div class=\"honor\"><ul class=\"honor-1\" id=\"changeTypeValue\" title=\""+masterId+"\"><li class=\"active\" title='2'>大师荣誉</li><li title='3'>出版著作</li>" +
                "<li title='4'>艺术年表</li><li title='5'>工作坊</li></ul><div class=\"honor-content\" id='noRefresh'>";
        if(data != null && data.length > 0){
          for (var i = 0; i < data.length; i++) {
            var obj = data[i].attachmentList;
            if(obj != null && obj.length > 0){
              for (var j = 0; j < obj.length; j++) {
                if (type != "5") {
                  if ((type == "2" && type == data[i].type) || (type == "3" && type == data[i].type)) {
                    sub += "<div class=\"h-c-img\"><img src=\""+obj[j].url+"\"></div><p>"+obj[j].title+"</p>";
                  }else if(type == "4" && type == data[i].type){
                    sub += "<p class=\"tx-q1\">"+obj[j].title+"</p>";
                  }
                }else if(type == "5" && type == data[i].type){
                  sub += "<video controls=\"controls\" src=\""+obj[j].videoPath+"\" width=\"100%\" height=\"200\"></video><p>"+obj[j].title+"</p>" +
                          "<div class=\"h-c-img\"><img src=\""+obj[j].url+"\"></div><p>"+data[i].content+"</p>";
                }
              }
            }else{
              sub += "该大师暂无此项信息!";
            }
            sub += "</div></div>";
            box.append(sub);
          }
        }
        if(data == null || data.length <= 0){
          sub += "该大师暂无此项信息!</div></div>";
          box.append(sub);
        }
      }
    })
  }
  function noRefresh(masterId,type){
    $.ajax({
      type: "POST",
      url: "<c:url value='/masterBrief/getMasterBrief.do'/>",
      async:false ,
      data:"masterId="+masterId +"&type="+type,
      dataType:"json",
      error: function(){alert('出错了,请联系系统管理员!');},
      success: function(data) {
        console.log(data);
        var box = $("#noRefresh");
        box.empty();
        var sub = "";
        if(data != null && data.length > 0){
          for (var i = 0; i < data.length; i++) {
            var obj = data[i].attachmentList;
            if(obj != null && obj.length > 0){
              for (var j = 0; j < obj.length; j++) {
                if (type != "5") {
                  if ((type == "2" && type == data[i].type) || (type == "3" && type == data[i].type)) {
                    sub += "<div class=\"h-c-img\"><img src=\""+obj[j].url+"\"></div><p>"+obj[j].title+"</p>";
                  }else if(type == "4" && type == data[i].type){
                    sub += "<p class=\"tx-q1\">"+obj[j].title+"</p>";
                  }
                }else if(type == "5" && type == data[i].type){
                  sub += "<video controls=\"controls\" src=\""+obj[j].videoPath+"\" width=\"100%\" height=\"200\"></video><p>"+obj[j].title+"</p>" +
                          "<div class=\"h-c-img\"><img src=\""+obj[j].url+"\"></div><p>"+data[i].content+"</p>";
                }
              }
            }else{
              sub += "该大师暂无此项信息!";
            }
            sub += "</div></div>";
            box.append(sub);
          }
        }
        if(data == null || data.length <= 0){
          sub += "该大师暂无此项信息!</div></div>";
          box.append(sub);
        }
      }
    })
  }
  $(function(){
    var oParent=$('.master-works');
    oParent.find('.user').css('height',/*oParent.find('.img-bg').height()+*/'480px');
    oParent.find('.user-nav li').click(function(){
      $(this).addClass('active').siblings('li').removeClass('active');
      $(this).append('<i class="user-arrow-up"></i>').siblings('li').find('.user-arrow-up').remove();
      $(document).on("click", ".honor-1 li,.list-nav li", function() {
        $(this).addClass('active').siblings('li').removeClass('active');
        if($(this).hasClass("active")){
          var type = $(this).attr("title");
          var masterId = $(this).parent().attr("title");
          if(type ==2 || type == 3 || type == 4 || type == 5){
            noRefresh(masterId,type);
          }else{
            getMasterWorkListByProjectName(type,masterId);
          }
        }
        return false;
      });
    });
  })


  function getMasterMessageList(masterId){
    $.ajax({
      type: "POST",
      url: "<c:url value='/masterMessage/getMasterDetails.do'/>",
      async:false ,
      data:"masterId="+masterId,
      dataType:"json",
      error: function(){alert('出错了,请联系系统管理员!');},
      success: function(data){
        var box = $("#changeType");
        box.empty();
        var sub = "<div class=\"suit\">";
        for(var i = 0 ;i < data.length ;i++){
          var cTime = transdate(data[i].createDateTime);
          sub += "<div class=\"dynamic\">" +
          "<div class=\"dynamic-hd\"></div>" +
          "<div class=\"dynamic-st\">" +
          "<div class=\"suit-st-text\">" +
          "<p><span>"+data[i].content+"</span></p>" +
          "</div>" +
          "<div class=\"suit-st-img\">" +
          "<a href=\"<c:url value='/masterMessage/getMasterMessage.do?messageId='/>"+data[i].id+"\">" +
          "<img src=\"../shop2015/upload/120101-p1-2.jpg\">" +
          "</a>" +
          "</div>" +
          "<div class=\"suit-st-ft\">" +
          "<div class=\"suit-ft-left\"><span>"+data[i].dataSource+"</span></div>" +
          "<div class=\"suit-ft-right\"><span>"+cTime+"</span></div>" +
          "</div>" +
          "</div>" +
          "<div class=\"dynamic-ft\">" +
          "<a onclick=\"changePraiseStatus(this,'"+data[i].id+"');\" class=\"ft-a\"> <i class=\"good-1\"></i><em>"+data[i].praiseStatus+"</em></a> <i class=\"s-solid ft-a\"></i>"+
          "<a href=\"#\" class=\"ft-a\"> <i class=\"good-2\"></i> <em>9999</em> </a> <i class=\"s-solid ft-a\"></i>" +
          "<a onclick=\"collected('"+data[i].id+"');\" class=\"ft-a\"> <i class=\"good-3\"></i> </a>" +
          "</div>"+
          "</div>";
        }
        sub += "</div>";
        box.append(sub);
      }
    })
  }

  function transdate(endTime){
    var timestamp = Date.parse(new Date());
    var oldTime = parseInt(endTime);
    var intervalTime = (timestamp - oldTime)/1000/60;
    var showTime = "";
    if(intervalTime<=59){
      showTime=intervalTime.toFixed(0)+"分钟前";
    }else if(1<=(intervalTime/60) && (intervalTime/60)<24){
      showTime=(intervalTime/60).toFixed(0)+"小时前";
    }else if(1<=(intervalTime/60/24) && (intervalTime/60/24)<=30){
      showTime=(intervalTime/60/24).toFixed(0)+"天前";
    }else{
      showTime=new Date(oldTime).toLocaleString().replace(/:\d{1,2}$/,' ');
    }
    return showTime;
  }
  function collected(messageId){
    $.ajax({
      url:"<c:url value='/masterMessage/collected.do'/>",
      data:"messageId="+messageId,
      type:"POST",
      dataType:"json",
      error:function(){},
      success:function(msg){
        if(true == msg){
          alert("收藏成功!");
        }else{
          alert("收藏已移除!");
        }
      }
    });
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
        $(o).find("em").html(msg);
      }
    })
  }
</script>
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

</script>
</body>
</html>