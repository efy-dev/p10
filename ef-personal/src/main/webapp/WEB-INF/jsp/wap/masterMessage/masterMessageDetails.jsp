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
  <h1 class="am-header-title">${object.fullName}<input type="hidden" id="baseBrief" value="${baseBrief}"/></h1>
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
        <li><a href="" id="acs" title="分类">消&nbsp;息</a></li>
        <li><a href="" title="个人中心">个&nbsp;人&nbsp;中&nbsp;心</a></li>
      </ul>
    </div>
  </div>
</header>
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
          <ul class="list-name" id="toFollows">
            <li><div class="name-img"><img class="am-circle" src="../shop2015/upload/120102-p1-11.jpg"/></div><span>Andy</span></li>
            <li><div class="name-img"><img class="am-circle" src="../shop2015/upload/120102-p1-11.jpg"/></div><span>Lily</span></li>
            <li><div class="name-img"><img class="am-circle" src="../shop2015/upload/120102-p1-11.jpg"/></div><span>wangjl</span></li>
          </ul>
          <div class="more"><a href="#"><i class="time-1"></i>查看更多评论</a></div>
        </div>
      </div>
      <div data-tab-panel-1 class="am-tab-panel ">
        <div class="discuss">
          <ul class="discuss-2" id="toComments">
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
          <ul class="discuss-2" id="toPraises">
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
<!--//End--header-->
<div class="master-works">
  <div class="user" style="height: 480px;">
    <img class="img-user"  src="http://tenant.efeiyi.com/${object.favicon}@!tenant-mobile-view-icon" alt=""/>
    <img class="img-bg"  src="http://tenant.efeiyi.com/${object.backgroundUrl}@!tenant-mobile-view-background" alt=""/>
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
  <input id="content" value="" name="" type="hidden" />
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
                  <img src="/scripts/assets/images/images/header1.png">
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
              <a onclick="collected(this,'${message.id}');" class="ft-a"> <i class="good-3"></i><em>${message.storeStatus}</em></a>
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
          var type = "2";
          var brief = $("#baseBrief").val();
          getIntroduction(masterId,type,brief);
        }
        if($(this).attr("title")=="3"){
          getMasterProjectList(masterId);
          getAllMasterWork(masterId);
        }
      }
    });
  }
  $(document).ready(function(){
    var masterId = '${object.id}';
    $("#userNav li").each(function(){
      if($(this).attr("class")=="active"){
        if($(this).attr("title")=="1"){
          getMasterMessageList(masterId);
        }
      }
    });
  })
  var startNum = 1;
  var startNumber = 1;
  $(function(){
    getComments("<c:url value='/masterMessage/userComments/plistMasterComment_byAuthor/2/'/>");
    getPraises("<c:url value='/masterMessage/userPraises/plistMasterCommentPraise_byAuthor/2/'/>");
  })
  function getComments(url){
    $.ajax({
      type: "POST",
      url: url + startNum,
      async: false,
      data: "",
      dataType: "json",
      error: function () {
        alert('出错了,请联系系统管理员!');
      },
      success: function (data) {
        var box = $("#toComment");
        var sub = "";
        if(data && data.length > 0){
          for(var i in data){
            var ctime = transdate(data[i].createDateTime);
            var userName = data[i].user.username.substring(0, 3) + "****" + data[i].user.username.substring(7, 11);
            sub += "<li class=\"review\">"+
                    "              <div class=\"matter\">"+
                    "                <p class=\"text-h1\"><a href=\"#\">"+userName+"</a>回复了你</p>"+
                    "                <p class=\"text-time\">"+ctime+"</p>"+
                    "                <p class=\"text-content\"><a href=\"#\" >"+data[i].content+"</a></p>"+
                    "                <div class=\"owner\"><img class=\"am-circle\" src=\"<c:url value='/scripts/assets/images/120102-p1-11.jpg'/>\"/></div>"+
                    "              </div>"+
                    "            </li>";
          }
          box.append(sub);
        }
      },complete:function(){
        startNum = startNum + 1;
      }
    })
  }
  function moreComments(){
    getComments("<c:url value='/masterMessage/userComments/plistMasterComment_byAuthor/2/'/>");
  }
  function morePraises(){
    getPraises("<c:url value='/masterMessage/userPraises/plistMasterCommentPraise_byAuthor/2/'/>");
  }
  function getPraises(url){
    $.ajax({
      type: "POST",
      url: url + startNumber,
      async: false,
      data: "",
      dataType: "json",
      error: function () {
        alert('出错了,请联系系统管理员!');
      },
      success: function (data) {
        var box = $("#toPraise");
        var sub = "";
        if(data && data.length > 0){
          for(var i in data){
            var ctime = transdate(data[i].createDateTime);
            var userName = data[i].user.username.substring(0, 3) + "****" + data[i].user.username.substring(7, 11);
            sub += "<li class=\"review\">"+
                    "              <div class=\"matter\">"+
                    "                <p class=\"text-h1\">"+userName+"</p>"+
                    "                <p class=\"text-time\">"+ctime+"</p>"+
                    "                <p class=\"text-content\"><a href=\"#\" >觉得你的评论“"+data[i].comment.content+"”很赞</a></p>"+
                    "                <div class=\"owner\"><img class=\"am-circle\" src=\"../shop2015/upload/120102-p1-11.jpg\"/></div>"+
                    "              </div>"+
                    "            </li>";
          }
          box.append(sub);
        }
      },complete:function(){
        startNumber = startNumber + 1;
      }
    })
  }
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
                    "<a href=\"<c:url value='/masterBrief/getMasterWork.do?workId='/>"+data[i].id+"\"><img src=\"http://tenant.efeiyi.com/"+data[i].pictureUrl+"@!master-intro-product\"></a>" +
                    "<div class=\"txt\"><div class=\"name\">"+data[i].name+"</div><div class=\"txt-info\">" +
                    "<a href=\"#\" onclick=\"praiseWork(this,'"+data[i].id+"');\"><i class=\"icon good-1\"></i><em>"+data[i].praiseStatus+"</em></a>"+
                    "<a href=\"<c:url value='/masterBrief/getMasterWork.do?workId='/>"+data[i].id+"\"><i class=\"icon good-2\"></i><em>"+data[i].amount+"</em></a></div></div></li>";
          }
        }
        sub += "</ul>";
        box.append(sub);
      }
    })
  }
  function praiseWork(o,workId){
    $.ajax({
      type: "POST",
      url: "<c:url value='/masterBrief/masterWorkPraise.do'/>",
      async: false,
      data: "workId=" + workId,
      dataType: "json",
      error: function () {
        alert('出错了,请联系系统管理员!');
      },
      success: function (data) {
        $(o).find("em").html(data);
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
                    "<a href=\"<c:url value='/masterBrief/getMasterWork.do?workId='/>"+data[i].id+"\"><img src=\"http://tenant.efeiyi.com/"+data[i].pictureUrl+"@!master-intro-product\"></a>" +
                    "<div class=\"txt\"><div class=\"name\">"+data[i].name+"</div><div class=\"txt-info\">" +
                    "<a href=\"#\"><i class=\"icon good-1\"></i><em>"+data[i].praiseStatus+"</em></a>"+
                    "<a href=\"#\"><i class=\"icon good-2\"></i><em>9999</em></a></div></div></li>";
          }
          box.append(sub);
        }
      }
    })
  }
  function getIntroduction(masterId,type,brief){
    $.ajax({
      type: "POST",
      url: "<c:url value='/masterBrief/getMasterBrief.do'/>",
      async:false ,
      data:"masterId="+masterId +"&type="+type,
      dataType:"json",
      error: function(){alert('出错了,请联系系统管理员!');},
      success: function(data) {
        var box = $("#changeType");
//        box.removeClass();
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
                  if (type == "2" && type == data[i].type) {
                    sub += "<div class=\"h-c-img\"><img src=\"http://tenant.efeiyi.com/"+obj[j].url+"@!master-intro-product\"></div><p>"+obj[j].title+"</p>";
                  }else if(type == "3" && type == data[i].type){
                    sub += "<div class=\"h-c-img\"><img src=\"http://tenant.efeiyi.com/"+obj[j].url+"@!master-intro-product\"></div><p>"+obj[j].title+"</p>";
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
                    sub += "<div class=\"h-c-img\"><img src=\"http://tenant.efeiyi.com/"+obj[j].url+"@!master-intro-product\"></div><p>"+obj[j].title+"</p>";
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
    oParent.find('.user').css('height',oParent.find('.img-bg').height()+'480px');
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
      type: "post",
      url: "<c:url value='/masterMessage/getMasterDetails.do?masterId='/>"+masterId,
      async:false ,
      data:"",
      dataType:"json",
      error: function(){alert('出错了,请联系系统管理员!');},
      success: function(data){
        var box = $("#changeType");
        box.removeClass();
        box.addClass("great");
        box.empty();
        var sub = "<div class=\"suit\">";
        for(var i = 0 ;i < data.length ;i++){
          var cTime = transdate(data[i].createDateTime);
          sub += "<div class=\"dynamic\">" +
          "<div class=\"dynamic-hd\"></div>" +
          "<div class=\"dynamic-st\">" +
          "<div class=\"suit-st-text\">" +
          "<p><span>"+data[i].content+"</span></p>" +
          "</div>" ;
          if(data[i].messageAttachmentLists != null && data[i].messageAttachmentLists.length > 0){
            var obj = data[i].messageAttachmentLists;
            for(var j in obj){
              sub += "<div class=\"suit-st-img\">" +
                      "<a href=\"<c:url value='/masterMessage/getMasterMessage.do?messageId='/>"+data[i].id+"\">" +
                      "<img src=\"http://tenant.oss-cn-beijing.aliyuncs.com/"+obj[j].pictureUrl+"\">" +
                      "</a>" +
                      "</div>" ;
            }
          }
          sub += "<div class=\"suit-st-ft\">" +
          "<div class=\"suit-ft-left\"><span>"+data[i].dataSource+"</span></div>" +
          "<div class=\"suit-ft-right\"><span>"+cTime+"</span></div>" +
          "</div>" +
          "</div>" +
          "<div class=\"dynamic-ft\">" +
          "<a onclick=\"changePraiseStatus(this,'"+data[i].id+"');\" class=\"ft-a\"> <i class=\"good-1\"></i><em>"+data[i].praiseStatus+"</em></a> <i class=\"s-solid ft-a\"></i>"+
          "<a onclick=\"showModel('"+data[i].id+"');\" name=\""+data[i].id+"\" class=\"ft-a\"> <i class=\"good-2\"></i><em>"+data[i].amount+"</em></a><i class=\"s-solid ft-a\"></i>" +
          "<a onclick=\"collected(this,'"+data[i].id+"');\" class=\"ft-a\"> <i class=\"good-3\"></i><em>"+data[i].storeStatus+"</em></a>" +
          "</div>"+
          "</div>";
        }
        sub += "</div>";
        box.append(sub);
      }
    })
  }
  function showModel(msgId){
    $("#content").attr("name",msgId);
    window.open("<c:url value='/comment.jsp?msgId='/>"+msgId);
  }
  function setValue(data){
    var msgId = $("#content").attr("name");
    var ret =document.getElementById("content").value = data;
    if(ret && ret.toString().length>=1) {
      var CommentValue = $("#content").val();
      if (CommentValue == null || CommentValue == "" || CommentValue == "undefined") {
        alert("你未发表任何评论，请评论");
        return false;
      }
    }
    $.ajax({
      type: "POST",
      url:"<c:url value='/masterMessage/commentMsg.do?msgId='/>"+msgId,
      data:"content="+CommentValue+"&fatherId=0",
      async: false,
      dataType:"json",
      error: function () {
        alert('出错了,请联系系统管理员!');
      },
      success: function (msg) {
        if(msg=="noRole"){
          alert("您还未登陆，请登录后再操作！！！");
          return false;
        }else if(msg=="undefined"){
          alert("您未发表任何评论，请评论！！！");
          return false;
        }else{
          alert("评论成功!");
          var next = $("a[name='"+msgId+"']").find("em");
          var num = parseInt(next.html());
          next.html(num + 1);
        }
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