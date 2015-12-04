<%@ page import="com.efeiyi.ec.personal.AuthorizationUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<!DOCTYPE html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>大师详情页简介</title>
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
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/pc/css/amazeui.min.css?v=20150831'/>">
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/pc/css/app.css?v=20150831'/>">
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/pc/css/leader.css?v=20150831'/>">
  <script src="<c:url value='/scripts/assets/pc/js/jquery.min.js'/> "></script>

  <style>
    .pc-dy-txt .pc-dy-box .pc-dy-content .one-pic img {height:100px;}
    .master-text .mas-tx-left .publish img {}
  </style>
</head>
<body >
<div class="ae master-text">
  <div class="great-master">
    <div class="master-pic"><img src="http://tenant.efeiyi.com/${object.favicon}@!master-favicon-view" alt="传承人" class="am-img-thumbnail am-circle"></div>
    <h5>${object.fullName}</h5>
    <p>[${object.projectName}]</p>
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
      <ul class="bars" >
        <li class="active"><a href="<c:url value='/masterMessage/masterView/'/>${object.id}">主&nbsp;页</a></li>
        <li><a href="<c:url value='/masterMessage/introView/'/>${object.id}">介&nbsp;绍</a></li>
        <li><a href="<c:url value='/masterMessage/getPartWorks/'/>${object.id}">作&nbsp;品</a></li>
      </ul>
    </div>
  </div>
  </div>
  <!-- //End--master-nav-->
  <div class="homepage">
    <div class="pc-dynamic" >
      <div class="p-dy-left" style="margin-bottom: 102px;">
        <ul class="list-dynamic ae" id="pubu">
        </ul>
      </div>
      <div class="p-dy-right mas-tx-left" style="float: right;margin-top: 20px;">
        <p>${object.content}</p>
        <h5>作品</h5>
        <ul class="publish">
          <c:if test="${!empty workList && workList.size() > 1}">
            <c:forEach items="${workList}" var="work" begin="0" end="2">
            <li>
              <a href="<c:url value='/masterMessage/getWorkDetails/${work.id}'/>"><img src="http://tenant.efeiyi.com/${work.pictureUrl}@!master-intro-product"> </a>
              <p>${work.name}</p>
            </li>
            </c:forEach>
          </c:if>
        </ul>
        <div class="f-r-gd ae hpe"><a href="<c:url value='/masterMessage/getPartWorks/'/>${object.id}"><span>更多作品</span><i class="sp-icon"></i></a></div>
        <ul class="publish">
          <li>
            <c:if test="${!empty object.masterProjectList && object.masterProjectList.size() > 0}">
              <a href="#"><img src="http://tenant.oss-cn-beijing.aliyuncs.com/${object.masterProjectList.get(0).project.picture_pc_url}"> </a>
              <p>${object.masterProjectList.get(0).project.name}</p>
            </c:if>
          </li>
        </ul>
        <div class="f-r-gd ae"><a href="#"><span>查看工艺</span><i class="sp-icon"></i></a></div>
      </div>
    </div>
  </div>
</div>
<script>
//  function forwardCraft(workId){
//
//  }
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
        $(o).find("em").html("已收藏");
      }else if(data == "del"){
        $(o).find("em").html("收藏");
      }
    }
  })
}

  function praiseMessage(o,msgId){
//    var num = $(o).find("em").html().split("(")[1];
//    var numlen = num.substr(0,num.length -1);
    $.ajax({
      type: "get",//设置get请求方式
      url: "<c:url value='/masterMessage/praiseMessage.do'/>",//设置请求的脚本地址
      data: "msgId="+msgId,//设置请求的数据
      async: true,
      dataType: "json",//设置请求返回的数据格式
      success: function (data) {
        var next = $(o).find("em");
        var amount = parseInt(next.html().substring(1,next.html().length));
        console.log(next.html()+"----"+amount);
        if(data =="noRole"){
          alert("您还没有登录,请登录后操作!");
        }else if(data == "add"){
          next.html("赞"+(amount + 1));
        }else if(data == "del"){
          next.html("赞"+(amount - 1));
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

  function valiDate(nowDate){
    var newDate = Date.parse(new Date());
    var otherDate = Date.parse(new Date(nowDate));
    var intervalTime = (newDate - otherDate)/1000/60;
    var result ;
    if((intervalTime/60)>24){
      var month = new Date(nowDate).getMonth() + 1;
      var day = new Date(nowDate).getDate();
      if(month.length == 1){
        month = num2chinese(month);
      }else{
        month = n2c(month);
      }
      if(day.length == 1){
        day = num2chinese(day);
      }else{
        day = n2c(day);
      }
      result = month + ":" + day;
    }else{
      result = "今天";
    }
    return result;
  }
  var chinese = ['零','一','二','三','四','五','六','七','八','九'];
  var len = ['十'];
  var ydm =['年','月','日'];
  function num2chinese(s)
  {
    //将单个数字转成中文.
    s=""+s;
    slen = s.length;
    var result="";
    for(var i=0;i<slen;i++)
    {
      result+=chinese[s.charAt(i)];
    }
    return result;
  }
  function n2c(s)
  {
    //对特殊情况进行处理.
    s=""+s;
    var result="";
    if(s.length==2)
    {
      if(s.charAt(0)=="1")
      {
        if(s.charAt(1)=="0")return len[0];
        return len[0]+chinese[s.charAt(1)];
      }
      if(s.charAt(1)=="0")
        return chinese[s.charAt(0)]+len[0];
      return chinese[s.charAt(0)]+len[0]+chinese[s.charAt(1)];
    }
    return num2chinese(s)
  }


  $(window).load(function(){
    var winH = $(window).height(); //页面可视区域高度
    $(window).scroll(function(){
      var pageH = $(document).height();
      var scrollT = $(window).scrollTop(); //滚动条top
      var aa = (pageH - winH - scrollT) / winH;
      if(aa < 0.02){
        if(ajaxkey){
          getData("<c:url value='/masterMessage/mainData/plistMasterMessage_default1/master.id:${object.id}/4/'/>");
        }
      }
    });
  });

  var StartMessageNum = 1;
  var StartProductNum = 1;
  $(document).ready(function(){
    $("#pages").html("主页 - ${object.fullName} - e飞蚁");
    getData("<c:url value='/masterMessage/mainData/plistMasterMessage_default1/master.id:${object.id}/4/'/>");
  })
  function getData(url){
    var flag = false;
    $.ajax({
      type: "get",//设置get请求方式
      url: url + StartMessageNum,//设置请求的脚本地址
      data: "",//设置请求的数据
      async: true,
      dataType: "json",//设置请求返回的数据格式
      success: function (data) {
        console.log(data);
        StartMessageNum = StartMessageNum + 1;
        var pubu = $("#pubu");
        if(data != null && data.length > 0) {
          for (var i in data) {
            var cTime = transdate(data[i].createDateTime);
            var time = valiDate(data[i].createDateTime);

            var box = "<li>"+
                    "                        <div class=\"pc-dy-txt ae\">"+
                    "                            <div class=\"pc-dy-pic \">";
            if(time != null && time != "今天"){
              var month = time.split(":")[0].toString();
              var day = time.split(":")[1].toString();
              box += "<ul class=\"text-date\">"+
                      "                                        <li class=\"date-day\">"+
                      "                                            <span>"+day+"</span>"+
                      "                                        </li>"+
                      "                                        <li class=\"dx\"></li>"+
                      "                                        <li class=\"date-luna\">"+
                      "                                            <span>"+month+"月</span>"+
                      "                                        </li>"+
                      "                                        <li class=\"dx\"></li>"+
                      "                                    </ul>";
            }else{
              box +="                                <div class=\"text-today\">"+
                      "                                    <span>今天</span>"+
                      "                                </div>";
            }
                box +=    "                            </div>"+
                    "                            <div class=\"pc-dy-box\">"+
                    "                                <div class=\"pc-dy-content\">"+
                    "                                    <p><a href=\"<c:url value='/masterMessage/getMessageView/'/>"+data[i].id+"\">"+data[i].remark+"</a></p>";
            var attr = data[i].messageAttachmentLists;
            if(attr != null && attr.length > 1 ){
              box += "<div class=\"two-pic\"><ul class=\"sudoku\">";
              for(var j in attr){
                box += "<li><a href=\"<c:url value='/masterMessage/getMessageView/'/>"+data[i].id+"\"><img src=\"http://tenant.efeiyi.com/"+attr[j].pictureUrl+"@!master-message-little-more\"></a> </li>";
              }
              box += "</ul></div>";
            }else if(attr != null && attr.length == 1){
              box +="<div class=\"one-pic\"><a href=\"#\"><img src=\"http://tenant.efeiyi.com/"+attr[0].pictureUrl+"@!master-message-only-little\"></a></div>"
            }
              box += "  <div class=\"one-tiem\"><span>"+cTime+"</span><span>来自&nbsp;"+data[i].dataSource+"</span></p></div>"+
                    "                                </div>"+
                    "                            </div>"+
                    "                        </div>"+
                    "                        <div class=\"one-state\">"+
                    "                            <ul class=\"state\">"+
                    "                                <li>"+
                    "                                    <a onclick=\"praiseMessage(this,'"+data[i].id+"');\">"+
                    "                                    <span class=\"pos\">"+
                    "                                        <span class=\"line\">"+
                    "                                            <i class=\"dnc-icon zq\"></i>"+
                    "                                            <em>"+data[i].praiseStatus+data[i].praiseNum+"</em>"+
                    "                                        </span>"+
                    "                                    </span>"+
                    "                                    </a>"+
                    "                                </li>"+
                    "                                <li>"+
                    "                                    <a href=\"<c:url value='/masterMessage/getMessageView/'/>"+data[i].id+"\">"+
                    "                                    <span class=\"pos\">"+
                    "                                        <span class=\"line\">"+
                    "                                            <i class=\"dnc-icon-2 zq\"></i>"+
                    "                                            <em>评论("+data[i].amount+")</em>"+
                    "                                        </span>"+
                    "                                    </span>"+
                    "                                    </a>"+
                    "                                </li>"+
                    "                                <li>"+
                    "                                    <a onclick=\"storeMessage(this,'"+data[i].id+"');\">"+
                    "                                    <span class=\"pos\">"+
                    "                                        <span class=\"line\">"+
                    "                                            <i class=\"dnc-icon-3 zq\"></i>"+
                    "                                            <em>"+data[i].storeStatus+"</em>"+
                    "                                        </span>"+
                    "                                    </span>"+
                    "                                    </a>"+
                    "                                </li>"+
                    "                                <li style=\"position: relative\">"+
                    "                                    <a onclick=\"showJiathis(this);\">"+
                    "                                      <span class=\"pos\">"+
                    "                                        <span class=\"line\">"+
                    "                                            <i class=\"dnc-icon-4 zq\"></i>"+
                    "                                            <em>分享</em>"+
                    "                                        </span>"+
                    "                                      </span>"+
                    "                                    </a>"+
                      "                                  <div style='display: none;' class=\"nr-share\">"+
                      "                                    <div class=\"nr-bg\">"+
                      "                                        <div class=\"jiathis_style\">"+
                      "                                            <a class=\"jiathis_button_weixin\"></a>"+
                      "                                            <a class=\"jiathis_button_tqq\"></a>"+
                      "                                            <a class=\"jiathis_button_tsina\"></a>"+
                      "                                            <a class=\"jiathis_button_cqq\"></a>"+
                      "                                        </div>"+
                      "                                    </div>"+
                      "                                  </div><script type=\"text/javascript\" src=\"http://v3.jiathis.com/code/jia.js\" charset=\"utf-8\"/>"+
                    "                                </li>"+
                    "                            </ul>"+
                    "                        </div>"+
                    "                    </li>";
            pubu.append(box);
          }
        }else{
          flag = true;
        }
      },complete:function(){
        if(flag == true){
          ajaxkey = false;
        }
      }
    })
  }

function showJiathis(o){
  var next = $(o).next();
  if($(next).is(":hidden")){
    $(next).show();
  }else{
    $(next).hide();
  }
}

  //判断请求数据的开关
  function getDataCheck(){
    var pubu = $("#pubu");
    var box = $("#box");
    var lastboxHeight = $(box[box.length-1]).offset().top+Math.floor($(box[box.length-1]).outerHeight()/2);
    var documentHeight = $(window).height();
    var scrollTop = $(document).scrollTop();
    return lastboxHeight<documentHeight+scrollTop?true:false;
  }

  var ajaxkey = true;//设置ajax请求的开关,如需动态加载、需要打开这个开关
  var ajaxkey2 = true;
  var isAttention = false;
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