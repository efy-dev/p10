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
  <title>大师分类-地区</title>
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
  <script src="<c:url value='/scripts/assets/js/system.js?v=20150831'/>"></script>
  <script type="text/javascript" src="<c:url value='/scripts/assets/js/pubu.js'/>"></script>
</head>
<body>
<div class="great">
  <header class="am-header custom-header">
    <div class="am-header-left am-header-nav">
      <a href="javascript:history.go(-1);" class="chevron-left"></a>
    </div>
    <h1 class="am-header-title">大师</h1>
    <div class="am-header-right am-header-nav am-header-right1">
      <a href="#chevron-right" class="chevron-right" id="menu"> <i class="icon icon-user"></i> </a> </div>
  </header>
  <!--//End--header-->
  <!--地区-->
  <div class="dis-q1">
    <div class="dis-q1-tabs">
      <ul class="tabs-nav tabs-nav-1" id="dynamic" onclick="changePage(this);">
        <li class="item active" title="1">动态</li>
        <c:if test="${'show' == result}">
          <li class="item" about="${result}" title="2">关注</li>
        </c:if>
        <c:if test="${'hide' == result}">
          <li class="item" about="${result}" title="2">关注</li>
        </c:if>
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
          <input id="content" value="" name="" type="hidden" />
          <div class="suit" id="pubu">

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
    <a href="<c:url value='/sso.do'/>" class="btn-login" title="登录">登&nbsp;&nbsp;&nbsp;&nbsp;录</a>
    <a href="http://passport.efeiyi.com/register?service=http://master.efeiyi.com/ef-person//sso.do" class="btn-reg">注&nbsp;&nbsp;&nbsp;&nbsp;册</a>
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
  var startNum = 1;
  var startNum1 = 1;
  var ajaxKey = true;
  $(document).ready(function(){
    getData("<c:url value='/masterMessage/masterMessageList/plistMasterMessage_default/6/'/>");
  });
  $(window).load(function(){
    var winH = $(window).height(); //页面可视区域高度
    $(window).scroll(function(){
      var pageH = $(document).height();
      var scrollT = $(window).scrollTop(); //滚动条top
      var aa = (pageH - winH - scrollT) / winH;
      if(aa < 0.02){
        if(ajaxKey){
          $("#dynamic li").each(function(){
            if($(this).attr("class")=="item active"){
              if($(this).attr("title")=="1"){
                getData("<c:url value='/masterMessage/masterMessageList/plistMasterMessage_default/6/'/>");
              }
              if($(this).attr("title")=="2"){
                var result = $(this).attr("about");
                getAttentionList(result);
              }
            }
          });
        }
      }
    });
  });
  function changePage(){
    $("#dynamic li").each(function(){
      if($(this).attr("class")=="item active"){
        $("#pubu").empty();
        if($(this).attr("title")=="1"){
          startNum = 1;
          getData("<c:url value='/masterMessage/masterMessageList/plistMasterMessage_default/6/'/>");
        }
        if($(this).attr("title")=="2"){
          startNum1 = 1;
          getAttentionList();
        }
      }
    });
  }
  function getData(url){
    var flag = false;
    $.ajax({
      type: "POST",
      url: url + startNum,
      async:false ,
      error: function(){alert('出错了,请联系系统管理员!');},
      success: function(data){
        var obj = eval(data);
        var box = $("#pubu");
        console.log(obj);
        if(obj != null && obj.length > 0){
          for(var i = 0 ;i < obj.length ;i++){
            var masterId = obj[i].masterId;
            var masterName = obj[i].masterName;
            var cTime = transdate(obj[i].createDateTime);
            var sub = "<div class=\"dynamic\">"
                    +"<div class=\"dynamic-hd\">"
                    +"<a class=\"suit-tx\" href=\"<c:url value='/masterMessage/forwardMasterDetails.do?masterId='/>"+masterId+"\"><img class=\"am-circle\" src=\"http://tenant.oss-cn-beijing.aliyuncs.com/"+obj[i].favicon+"\"></a>"
                    +"<div class=\"suit-name\"><a href=\"#\"><span>"+masterName+"</span></a></div>"
                    +"<a class=\"suit-gz\" onclick=\"changeStatus(this,'"+masterId+"');\"><input type=\"hidden\" name='"+masterId+"'><span>"+obj[i].followStatus+"</span></a> </div>"
                    +"<div class=\"dynamic-st\">"
                    +"<div class=\"suit-st-text\">"
                    +"<p><span>"+obj[i].remark+"</span></p>"
                    +"</div>";
            var attr = obj[i].messageAttachmentLists;
            if(attr != null && attr.length > 0 ){
              for(var j in attr){
                sub += "<div class=\"suit-st-img\"><a href=\"<c:url value='/masterMessage/getMasterMessage.do?messageId='/>"+obj[i].id+"\"><img src=\"http://tenant.oss-cn-beijing.aliyuncs.com/"+attr[j].pictureUrl+"\"></a> </div>";
              }
            }
              sub += "<div class=\"suit-st-ft\">"
                    +"<div class=\"suit-ft-left\"><span>"+obj[i].dataSource+"</span></div>"
                    +"<div class=\"suit-ft-right\"><span>"+cTime+"</span></div>"
                    +"</div></div>"
                    +"<div class=\"dynamic-ft\"> "
                    +"<a onclick=\"changePraiseStatus(this,'"+obj[i].id+"');\" class=\"ft-a\"> <i class=\"good-1\"></i><em>"+obj[i].praiseStatus+"</em></a><i class=\"s-solid ft-a\"></i> "
                    +"<a onclick=\"showModel('"+obj[i].id+"');\" name=\""+obj[i].id+"\" class=\"ft-a\"> <i class=\"good-2\"></i><em>"+obj[i].amount+"</em></a><i class=\"s-solid ft-a\"></i> "
                    +"<a onclick=\"collected(this,'"+obj[i].id+"');\" class=\"ft-a\"> <i class=\"good-4\"></i><em>"+obj[i].storeStatus+"</em></a></div></div>";
            box.append(sub);
          }
        }else{
          flag = true;
        }
        startNum = startNum + 1;
      },complete:function(){
        if(flag == true){
          ajaxkey = false;
        }
      }
    });
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
        console.log(msg);
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
        if(msg == "noRole"){
          alert("您还未登录,请登录后操作");
        }
        $("input[name='"+masterId+"']").each(function(){
          if(msg == "del"){
            $(this).next().html("关注");
          }else if(msg == "add"){
            $(this).next().html("已关注");
          }
        })
      }
    })
  }
  function bindClick(){
      var leaderUl=$('.great .suit-focus .div-list ul');
      var leaderLi=leaderUl.find('li');
      var leaderLiW=leaderLi.eq(0).outerWidth(true);
      var cur=0;
      leaderUl.css('width',leaderLiW*leaderLi.length+'px')
      //向右移动
      $('.great .bot-btn').click(function(){
        cur++;
        $(this).siblings('.btn-gz').animate({'opacity':'1'},0);
        if(leaderLi.length%2==0){
          if(cur<=leaderLi.length/(cur+1)+1){
            leaderUl.stop(true,true).animate({'margin-left':-(leaderLiW*2)*cur+'px'},500);
          }
          if(cur==leaderLi.length/(cur+1)+1){
            cur=leaderLi.length/2-1;
            $(this).parents('.suit-focus').append('<a href="#上一页" title="上一页" class="btn-gz bot-btn opa02"></a>');
            $(this).animate({'opacity':'0'},0);

          }
        }else{
          if(cur<=(leaderLi.length+1)/(cur+1)+1){
            leaderUl.stop(true,true).animate({'margin-left':-(leaderLiW*2)*cur+'px'},500);
          }
          if(cur==(leaderLi.length+1)/(cur+1)+1){
            $(this).hide();
          }
        }
        return false;
      });
      //向左移动
      $('.great .top-btn').click(function(){
        cur--;
        $(this).siblings('.btn-gz').animate({'opacity':'1'},0);
        $(this).siblings('.opa02').remove();
        if(cur>0){
          leaderUl.stop(true,true).animate({'margin-left':-(leaderLiW*2)*cur+'px'},500);
        }
        if(cur<=0){
          cur=0;
          $(this).animate({'opacity':'0.2'},0);
          leaderUl.stop(true,true).animate({'margin-left':-(leaderLiW*2)*cur+'px'},500);
        }
        return false;
      })
  }
  function getAttentionList(result){
    $.ajax({
      type: "POST",
      url: "<c:url value='/masterFollow/masterFollowedList.do'/>",
      data:"result="+result,
      async:false ,
      dataType:"json",
      error: function(){alert('出错了,请联系系统管理员!');},
      success: function(data){
        var box = $("#pubu");
        box.empty();
        var sub = "";
        console.log(data);
        if(data.mrModelList != null && data.mrModelList.length > 0){
          sub +="<div class=\"dynamic\" style=\"border-bottom:0;\">"+
          "                    <div class=\"suit-focus\">"+
          "                        <div class=\"title\">您可能喜欢的大师:</div>"+
          "                        <div class=\"div-list\">"+
          "                            <ul>";
          var attr = data.mrModelList;
          for(var i in attr){
            sub +="                                <li>"+
                    "                                    <p class=\"tb\">"+
                    "                                        <a href=\"<c:url value='/masterMessage/forwardMasterDetails.do?masterId='/>"+attr[i].id+"\"><img src=\"http://tenant.oss-cn-beijing.aliyuncs.com/"+attr[i].favicon+"\"></a>"+
                    "                                        <a class=\"icon-guanzu\" name=\"yesOrNo"+attr[i].id+"\" onclick=\"changeFollowedStatus(this,'"+attr[i].id+"');\"><span>"+attr[i].followStatus+"</span></a>"+
                    "                                    </p>"+
                    "                                    <P>"+attr[i].masterName+"</P>"+
                    "                                </li>";
          }
          sub +="                       </ul>"+
          "                        </div>"+
          "                        <a href=\"#上一页\" title=\"上一页\" class=\"btn-gz top-btn\"></a>"+
          "                        <a href=\"#下一页\" title=\"下一页\" class=\"btn-gz bot-btn\"></a>"+
          "                    </div>"+
          "                </div>";
          if(data.msgModelList != null && data.msgModelList.length > 0){
            var obj = data.msgModelList;
            for(var i in obj){
              var ctime = transdate(obj[i].createDateTime);
              sub += "<div class=\"dynamic\">"+
                      "                    <div class=\"dynamic-hd\"> <a class=\"suit-tx\" href=\"<c:url value='/masterMessage/forwardMasterDetails.do?masterId='/>"+obj[i].masterId+"\"><img class=\"am-circle\" src=\"http://tenant.oss-cn-beijing.aliyuncs.com/"+obj[i].favicon+"\"></a>"+
                      "                        <div class=\"suit-name\"><a href=\"<c:url value='/masterMessage/forwardMasterDetails.do?masterId='/>"+obj[i].masterId+"\"><span>"+obj[i].masterName+"</span></a></div>"+
                      "                        <a class=\"suit-gz\" name=\"yesOrNo"+obj[i].masterId+"\" onclick=\"changeFollowedStatus(this , '"+obj[i].masterId+"');\"><span>已关注</span></a> </div>"+
                      "                    <div class=\"dynamic-st\">"+
                      "                        <div class=\"suit-st-text\">"+
                      "                            <p><span>"+obj[i].content+"</span></p>"+
                      "                        </div>";
                var attr = obj[i].messageAttachmentLists;
                if(attr != null && attr.length > 0){
                    for(var j in attr){
                      sub += "<div class=\"suit-st-img\"> <img src=\"http://tenant.oss-cn-beijing.aliyuncs.com/"+attr[j].pictureUrl+"\"> </div>";
                    }
                }
                      sub +="                  <div class=\"suit-st-ft\">"+
                      "                            <div class=\"suit-ft-left\"><span>来自"+obj[i].dataSource+"</span></div>"+
                      "                            <div class=\"suit-ft-right\"><span>"+ctime+"</span></div>"+
                      "                        </div>"+
                      "                    </div>"+
                      "                    <div class=\"dynamic-ft\"> <a onclick=\"changePraiseStatus(this,'"+obj[i].id+"');\" class=\"ft-a\"> <i class=\"good-1\"></i> <em>"+obj[i].fsAmount+"</em> </a> <i class=\"s-solid ft-a\"></i> <a onclick=\"showModel('"+obj[i].id+"')\" class=\"ft-a\"> <i class=\"good-2\"></i> <em>"+obj[i].amount+"</em> </a> <i class=\"s-solid ft-a\"></i> <a onclick=\"collected(this,'"+obj[i].id+"')\" class=\"ft-a\"> <i class=\"good-3\"></i><em>"+obj[i].storeStatus+"</em></a> </div>"+
                      "                </div>";
            }
          }
          box.append(sub);
          bindClick();
        }else{
          if(data.msgModelList != null && data.msgModelList.length > 0){
            var obj = data.msgModelList;
            for(var j in obj){
              var ctime = transdate(obj[j].createDateTime);
              sub += "<div class=\"dynamic\">"+
                      "                    <div class=\"dynamic-hd\"> <a class=\"suit-tx\"><img class=\"am-circle\" src=\"http://tenant.oss-cn-beijing.aliyuncs.com/"+obj[j].favicon+"\"></a>"+
                      "                        <div class=\"suit-name\"><a href=\"<c:url value='/masterMessage/forwardMasterDetails.do?masterId='/>"+obj[j].masterId+"\"><span>"+obj[j].masterName+"</span></a></div>"+
                      "                        <a class=\"suit-gz\" name=\"yesOrNo"+obj[j].masterId+"\" onclick=\"changeFollowedStatus(this,'"+obj[j].masterId+"');\"><span>"+obj[j].followStatus+"</span></a> </div>"+
                      "                    <div class=\"dynamic-st\">"+
                      "                        <div class=\"suit-st-text\">"+
                      "                            <p><span>"+obj[j].content+"</span></p>"+
                      "                        </div>";
              if(obj[j].messageAttachmentLists != null){
                  var attr = obj[j].messageAttachmentLists;
                for(var e in attr){
                  sub += "<div class=\"suit-st-img\"> <img src=\"http://tenant.oss-cn-beijing.aliyuncs.com/"+attr[e].pictureUrl+"\"> </div>";
                }
              }
              sub +="                  <div class=\"suit-st-ft\">"+
                      "                            <div class=\"suit-ft-left\"><span>来自"+obj[j].dataSource+"</span></div>"+
                      "                            <div class=\"suit-ft-right\"><span>"+ctime+"</span></div>"+
                      "                        </div>"+
                      "                    </div>"+
                      "                 <div class=\"dynamic-ft\"> <a onclick=\"changePraiseStatus(this,'"+obj[j].id+"');\" class=\"ft-a\"> <i class=\"good-1\"></i> <em>"+obj[j].fsAmount+"</em> </a> <i class=\"s-solid ft-a\"></i> <a onclick=\"showModel('"+obj[j].id+"')\" class=\"ft-a\"> <i class=\"good-2\"></i> <em>"+obj[j].amount+"</em> </a> <i class=\"s-solid ft-a\"></i> <a onclick=\"collected(this,'"+obj[j].id+"')\" class=\"ft-a\"> <i class=\"good-3\"></i><em>"+obj[j].storeStatus+"</em></a> </div>"+
                      "                </div>";
            }
            box.append(sub);
          }
        }
      }
    });
  }
  function changeFollowedStatus(o,masterId){
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
        if(msg == "noRole"){
          alert("您还未登录,请登录后操作");
        }
        $("a[name='yesOrNo"+masterId+"']").each(function(){
          if(msg == "del"){
            $(this).find("span").html("关注");
          }else if(msg == "add"){
            $(this).find("span").html("已关注");
          }
        })
      }
    })
  }
</script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value='/scripts/assets/js/amazeui.ie8polyfill.min.js'/>"></script>
<script src="<c:url value='/scripts/assets/js/amazeui.min.js'/>"></script>
<!--自定义js--Start-->

<script src="<c:url value='/scripts/assets/js/cyclopedia.js?v=20150831'/>"></script>
<!--自定义js--End-->
</body>
</html>