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
  <title>大师动态-单图</title>
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
<body style="float: left">
<div class="list-find">
  <div class="list-f-title">
    <p><a href="<c:url value='/masterMessage/index.do'/>">大师</a><i class="fu-icon"></i><a href="<c:url value='/masterMessage/index.do'/>">动态</a><i class="fu-icon"></i><span>动态详情</span></p>
  </div>
  <div class="ae">
    <div class="details ae">
      <div class="detaile-left">
        <P>${msg.content}</P>
        <c:if test="${!empty msg.messageAttachmentLists}">
          <c:forEach items="${msg.messageAttachmentLists}" var="att">
            <div class="detaile-img"><a href="#"><img src="http://tenant.efeiyi.com/${att.pictureUrl}@!master-message-view-big"></a></div>
          </c:forEach>
        </c:if>
          <div class="detaile-share ae" style="height: auto">
          <!-- JiaThis Button BEGIN -->
          <div class="jiathis_style" style="background: #fff;border: 0;float: left;padding: 30px 0;">
            <a class="jiathis_button_weixin"></a>
            <a class="jiathis_button_tqq"></a>
            <a class="jiathis_button_tsina"></a>
            <a class="jiathis_button_cqq"></a>
          </div>
          <!-- JiaThis Button END -->
          <div class="thumb-up">
            <div class="thump-collect">
              <a onclick="storeMessage(this,'${msg.id}')"><i class="s-icon"></i> </a>
              <a onclick="storeMessage(this,'${msg.id}')"><em>${result}</em></a>
            </div>
            <div class="thump-assist">
              <a onclick="praiseMessage(this,'${msg.id}');"><i class="z-icon"></i> </a>
              <a onclick="praiseMessage(this,'${msg.id}');">
                  <em>
                    <c:if test="${msg.praiseNum == null}">
                        0
                    </c:if>
                  <c:if test="${msg.praiseNum != null}">
                      ${msg.praiseNum}
                  </c:if>
                  </em>
              </a>
            </div>
          </div>
        </div>
        <!--评论-->
        <div class="detaile-comment ae">
          <form>
            <h4>评论</h4>
            <ul class="comment ae" id="pubu">
            </ul>
            <div class="review ae">
              <textarea></textarea>
              <div class="btn1 ae">
                <input type="button" onclick="subMainComment(this,'${msg.id}',0);" class="btn" value="评论">
              </div>
            </div>
          </form>
        </div>
      </div>
      <div class="detaile-right">
        <div class="f-right-gy ae">
          <div class="h4"><span>传承人</span></div>
          <div class="craft-master2">
            <ul class="rf">
              <li>
                <div class="text">
                    <h4>
                        <a href="<c:url value='/masterMessage/introView/${msg.master.id}'/>">
                            ${msg.master.fullName}
                        </a>
                    </h4>
                  <p>${msg.master.projectName}</p>
                  <p><span><ming800:status name='level' dataType='Tenant.level' checkedValue='${object.level}' type='normal'/>传承人</span></p>
                  <a class="btn-guan" onclick="followMaster(this,'${msg.master.id}');">
                      <c:if test="${msg.master.followStatus == '已关注'}">
                          <i class="gz-icon" style="display: none;"></i>
                      </c:if>
                      <c:if test="${msg.master.followStatus == '关注'}">
                          <i class="gz-icon"></i>
                      </c:if>
                      <em>${msg.master.followStatus}</em></a>
                </div>
                <div class="img">
                    <a href="<c:url value='/masterMessage/introView/${msg.master.id}'/>">
                        <img src="http://tenant.efeiyi.com/${msg.master.favicon}@!master-favicon-view">
                    </a>
                </div>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<script>
  function followMaster(o,masterId){
    $.ajax({
        type: "post",//设置get请求方式
        url: "<c:url value='/masterMessage/followMaster.do'/>" ,//设置请求的脚本地址
        data: "masterId="+masterId,//设置请求的数据
        async: true,
        dataType: "json",//设置请求返回的数据格式
        success: function (data) {
            if(data == "noRole"){
                alert("您还未登录,请登录后操作!");
            }else if(data=="add"){
                $(o).find('.gz-icon').hide();
                $(o).find("em").html("已关注");
            }else if(data=="del"){
                $(o).find('.gz-icon').show();
                $(o).find("em").html("关注");
            }
        }
    })
  }
  var startNum = 1;
  var ajaxKey = true;
  $(document).ready(function(){
      getData("<c:url value='/masterMessage/getMsgComment/plistMasterComment_message/${msg.id}/10/'/>");
  })
  $(window).load(function(){
      var winH = $(window).height(); //页面可视区域高度
      $(window).scroll(function(){
          var pageH = $(document).height();
          var scrollT = $(window).scrollTop(); //滚动条top
          var aa = (pageH - winH - scrollT) / winH;
          if(aa < 0.02){
              if(ajaxKey){
                  getData("<c:url value='/masterMessage/getMsgComment/plistMasterComment_message/${msg.id}/10/'/>");
              }
          }
      });
  });
  function getData(url) {
      var msgId = '${msg.id}';
      var flag = false;
      $.ajax({
          type: "get",//设置get请求方式
          url: url+startNum,//设置请求的脚本地址
          data: "",//设置请求的数据
          async: true,
          dataType: "json",//设置请求返回的数据格式
          success: function (data) {
              var box = $("#pubu");
              if(data && data.length > 0){
                  for(var i in data){
                      var cTime = transdate(data[i].createDateTime);
                      var userName = data[i].user.username.substring(0,3)+"****"+data[i].user.username.substring(7,11);
                      var src ;
                      var amount;
                      if(data[i].favicon != null){
                          src = "http://tenant.efeiyi.com/"+data[i].favicon+"@!master-favicon-view";
                      }else{
                          src = "<c:url value='/scripts/assets/images/120102-p1-11.jpg'/>";
                      }
                      if(data[i].amount == null){
                          amount = 0;
                      }else{
                          amount = data[i].amount;
                      }
                      var sub = "<li class=\"ae\" id=\""+data[i].id+"\">"+
                            "     <div class=\"img\"><a href=\"#\"><img class=\"am-circle\" src=\""+src+"\"></a></div>"+
                            "        <div class=\"text\"><span><a href=\"#\">"+userName+" ：</a></span><span>"+data[i].content+"</span></div>"+
                            "        <div class=\"status ae\">"+
                            "            <div class=\"status-left\"><span>"+cTime+"</span></div>"+
                            "            <div class=\"status-right\">"+
                            "                <div class=\"hf\"><a onclick=\"getHfProduct(this);\">回复</a></div>"+
                            "                    <div class=\"zan\">"+
                            "                        <a onclick=\"praiseWorkComment(this,'"+data[i].id+"','"+msgId+"');\"><i class=\"icon\"></i><em>"+amount+"</em></a>"+
                            "                    </div>"+
                            "                </div>"+
                            "            </div>"+
                            "        <div class=\"review ae\" style=\"display: none;\">"+
                            "            <textarea></textarea>"+
                            "            <div class=\"btn1 ae\">"+
                              "                       <input type=\"button\" onclick=\"subOtherComment(this,'"+msgId+"','"+data[i].id+"',true);\" class=\"btn\" value=\"评论\">"+
                            "            </div>"+
                            "        </div>"+
                            " </li>";
                      box.append(sub);
                      getChildComments(data[i].id,userName,true);
                  }
              }else{
                  flag = true;
              }
          },complete:function(){
              startNum = startNum + 1;
              if(flag = true){
                  ajaxKey = false;
              }
          }
      })
  }
  function getChildComments(parent , name , flag){
      var msgId = '${msg.id}';
      $.ajax({
          type: "get",//设置get请求方式
          url: "<c:url value='/masterMessage/getSubCommentList.do?fatherId='/>" + parent,//设置请求的脚本地址
          data: "",//设置请求的数据
          async: true,
          dataType: "json",//设置请求返回的数据格式
          success: function (data) {
            var parentNode = $("#"+parent);
            if(data && data.length > 0){
                for(var i in data){
                    var cTime = transdate(data[i].createDateTime);
                    var userName = data[i].user.username.substring(0,3)+"****"+data[i].user.username.substring(7,11);
                    var src ;
                    var amount;
                    if(data[i].favicon != null){
                        src = "http://tenant.efeiyi.com/"+data[i].favicon+"@!master-favicon-view";
                    }else{
                        src = "<c:url value='/scripts/assets/images/120102-p1-11.jpg'/>";
                    }
                    if(data[i].amount == null){
                        amount = 0;
                    }else{
                        amount = data[i].amount;
                    }
                    var childNode = "<li style=\"margin: 0;border-bottom: 0;\" id=\""+data[i].id+"\" class=\"obtain\">"+
                            "           <div class=\"ae\">"+
                            "               <div class=\"img\"><a href=\"#\"><img class=\"am-circle\" src=\""+src+"\"></a></div>"+
                            "               <div class=\"text\"><span><a href=\"#\">"+userName+" 回复 "+name+"：</a></span><span>"+data[i].content+"</span></div>"+
                            "               <div class=\"status ae\">"+
                            "                   <div class=\"status-left\"><span>"+cTime+"</span></div>"+
                            "                   <div class=\"status-right\">"+
                            "                   <div class=\"ef\"><a onclick=\"getHfProduct2(this);\">回复</a></div>"+
                            "                       <div class=\"zan\">"+
                            "                        <a onclick=\"praiseWorkComment(this,'"+data[i].id+"','"+msgId+"');\"><i class=\"icon\"></i><em>"+amount+"</em></a>"+
                            "                       </div>"+
                            "                   </div>"+
                            "               </div>"+
                            "               <div class=\"review-sr ae\" style=\"display: none;\">"+
                            "                   <textarea></textarea>"+
                            "                   <div class=\"btn1 ae\">"+
                            "                       <input type=\"button\" onclick=\"subOtherComment(this,'"+msgId+"','"+data[i].id+"',false);\" class=\"btn\" value=\"评论\">"+
                            "                    </div>"+
                            "               </div>"+
                            "           </div>"+
                            "        </li>";
                    if(flag == false){
                        parentNode.after(childNode);
                    }else{
                        parentNode.append(childNode);
                    }
                    getChildComments(data[i].id,userName,false);
                }
            }
          }
      })
  }
  function subOtherComment(o,msgId,parent,flag){
      var content = $(o).parent().prev().val();
      if(content != null && content != "" && content.length > 0){
          $.ajax({
              type: "post",//设置get请求方式
              url: "<c:url value='/masterMessage/commentMsg.do'/>",//设置请求的脚本地址
              data: "content=" + content + "&fatherId=" + parent + "&msgId=" + msgId,//设置请求的数据
              async: true,
              dataType: "json",//设置请求返回的数据格式
              success: function (data) {
                  if (data == "noRole") {
                      alert("您还没有登录,请登录后操作!");
                  }else {
                      var cTime = transdate(data.createDateTime);
                      var userName = data.user.username.substring(0, 3) + "****" + data.user.username.substring(7, 11);
                      var src;
                      var amount;
                      if (data.favicon != null) {
                          src = "http://tenant.efeiyi.com/"+data[i].favicon+"@!master-favicon-view";
                      } else {
                          src = "<c:url value='/scripts/assets/images/120102-p1-11.jpg'/>";
                      }
                      if(data.amount == null){
                          amount = 0;
                      }else{
                          amount = data.amount;
                      }
                      var childNode = "<li style=\"margin: 0;border-bottom: 0;\" id=\""+data.id+"\" class=\"obtain\">"+
                              "           <div class=\"ae\">"+
                              "               <div class=\"img\"><a href=\"#\"><img class=\"am-circle\" src=\""+src+"\"></a></div>"+
                              "               <div class=\"text\"><span><a href=\"#\">"+userName+" 回复 "+name+"：</a></span><span>"+data.content+"</span></div>"+
                              "               <div class=\"status ae\">"+
                              "                   <div class=\"status-left\"><span>"+cTime+"</span></div>"+
                              "                   <div class=\"status-right\">"+
                              "                   <div class=\"ef\"><a onclick=\"getHfProduct2(this);\">回复</a></div>"+
                              "                       <div class=\"zan\">"+
                              "                        <a onclick=\"praiseWorkComment(this,'"+data.id+"','"+msgId+"');\"><i class=\"icon\"></i> <em>"+amount+"</em></a>"+
                              "                       </div>"+
                              "                   </div>"+
                              "               </div>"+
                              "               <div class=\"review-sr ae\" style=\"display: none;\">"+
                              "                   <textarea></textarea>"+
                              "                   <div class=\"btn1 ae\">"+
                              "                       <input type=\"button\" onclick=\"subOtherComment(this,'"+msgId+"','"+data.id+"',false);\" class=\"btn\" value=\"评论\">"+
                              "                    </div>"+
                              "               </div>"+
                              "           </div>"+
                              "        </li>";
                      if(flag == true){
                          $("#"+parent).append(childNode);
                      }else{
                          $("#"+parent).after(childNode);
                      }
                  }
              },complete:function(){
                  $(o).parent().prev().val("");
                  $(o).parent().parent().slideUp();
              }
          })
      }else{
          alert("您未输入任何评论信息");
      }

  }
  function subMainComment(o,msgId,parent){
      var content = $(o).parent().prev().val();
      if(content != null && content != "" && content.length > 0){
            $.ajax({
          type: "post",//设置get请求方式
          url: "<c:url value='/masterMessage/commentMsg.do'/>",//设置请求的脚本地址
          data: "content=" + content + "&fatherId=" + parent + "&msgId=" + msgId,//设置请求的数据
          async: false,
          dataType: "json",//设置请求返回的数据格式
          success: function (data) {
              if (data == "noRole") {
                  alert("您还没有登录,请登录后操作!");
              }else{
                  var cTime = transdate(data.createDateTime);
                  var userName = data.user.username.substring(0,3)+"****"+data.user.username.substring(7,11);
                  var src ;
                  var amount;
                  if(data.favicon != null){
                      src = "http://tenant.efeiyi.com/"+data[i].favicon+"@!master-favicon-view";
                  }else{
                      src = "<c:url value='/scripts/assets/images/120102-p1-11.jpg'/>";
                  }
                  if(data.amount == null){
                      amount = 0;
                  }else{
                      amount = data.amount;
                  }
                  var insertNode = $("<li class=\"ae\" id=\""+data.id+"\">"+
                          "     <div class=\"img\"><a href=\"#\"><img class=\"am-circle\" src=\""+src+"\"></a></div>"+
                          "        <div class=\"text\"><span><a href=\"#\">"+userName+" ：</a></span><span>"+data.content+"</span></div>"+
                          "        <div class=\"status ae\">"+
                          "            <div class=\"status-left\"><span>"+cTime+"</span></div>"+
                          "            <div class=\"status-right\">"+
                          "                <div class=\"hf\"><a onclick=\"getHfProduct(this);\">回复</a></div>"+
                          "                    <div class=\"zan\">"+
                          "                        <a onclick=\"praiseWorkComment(this,'"+data.id+"','"+msgId+"');\"><i class=\"icon\"></i> <em>"+amount+"</em></a>"+
                          "                    </div>"+
                          "                </div>"+
                          "            </div>"+
                          "        <div class=\"review ae\" style=\"display: none;\">"+
                          "            <textarea></textarea>"+
                          "            <div class=\"btn1 ae\">"+
                          "                <input type=\"button\" onclick=\"subOtherComment(this,'"+msgId+"','"+data.id+"',true);\" class=\"btn\" value=\"评论\">"+
                          "            </div>"+
                          "        </div>"+
                          " </li>");
                  var prevNode = $("#pubu").find("li").first();
                  if($(prevNode).length>0){
                      $(insertNode).insertBefore(prevNode);
                  }else{
                      $("#pubu").append(insertNode);
                  }
              }
          },complete:function(){
              $(o).parent().prev().val("");
          }
      })
      }else{
          alert("您未输入任何评论信息");
      }
  }
  function getHfProduct(e){
      $(e).parent().parent().parent().parent().find('.review').slideToggle();
      return false;
  }
  function getHfProduct2(e){
      $(e).parent().parent().parent().parent().find(".review-sr").slideToggle();
      return false;
  }
  function praiseWorkComment(o, commentId, workId) {
      $.ajax({
          type: "post",//设置get请求方式
          url: "<c:url value='/masterMessage/praiseMsgComment.do'/>",//设置请求的脚本地址
          data: "workId=" + workId + "&commentId=" + commentId,//设置请求的数据
          async: true,
          dataType: "json",//设置请求返回的数据格式
          success: function (data) {
              var num = $(o).find("em").html();
              if (data == "noRole") {
                  alert("您还未登录,请登录后操作!");
              } else if (data == "del") {
                  if (num != "0") {
                      $(o).find("em").html(parseInt(num) - 1);
                  } else {
                      $(o).find("em").html(0);
                  }
              } else if (data == "add") {
                  if (num != "0") {
                      $(o).find("em").html(parseInt(num) + 1);
                  } else {
                      $(o).find("em").html(1);
                  }
              }
          }
      })
  }
  function praiseMessage(o,msgId){
      $.ajax({
          type: "get",//设置get请求方式
          url: "<c:url value='/masterMessage/praiseMessage.do'/>",//设置请求的脚本地址
          data: "msgId="+msgId,//设置请求的数据
          async: true,
          dataType: "json",//设置请求返回的数据格式
          success: function (data) {
              var num = $(o).parent().find("em").html();
              if (data == "noRole") {
                  alert("您还未登录,请登录后操作!");
              } else if (data == "del") {
                  if (num != "0") {
                      $(o).parent().find("em").html(parseInt(num) - 1);
                  } else {
                      $(o).parent().find("em").html(0);
                  }
              } else if (data == "add") {
                  if (num != "0") {
                      $(o).parent().find("em").html(parseInt(num) + 1);
                  } else {
                      $(o).parent().find("em").html(1);
                  }
              }
          }
      });
  }
  function storeMessage(o,msgId){
    $.ajax({
      type: "get",//设置get请求方式
      url: "<c:url value='/masterMessage/storeMessage.do'/>",//设置请求的脚本地址
      data: "msgId="+msgId,//设置请求的数据
      async: true,
      dataType: "json",//设置请求返回的数据格式
      success: function (data) {
        if(data =="noRole"){
          alert("您还没有登录,请登录后操作!");
        }else if(data == "add"){
            $(o).parent().find("em").html("已收藏");
        }else if(data == "del"){
            $(o).parent().find("em").html("收藏");
        }
      }
    })
  }
  function transdate(endTime){
      var timestamp = Date.parse(new Date());
      var oldTime = parseInt(endTime);
      var intervalTime = (timestamp - oldTime + 1000)/1000/60;
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
</script>
<!-- //End--footer-->

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

