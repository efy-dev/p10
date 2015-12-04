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
<body style="float: left;">
<%--<div class="topbar wh" data-am-sticky>--%>
  <%--<div class="hd">--%>
    <%--<ul class="ul-item">--%>
      <%--<li>--%>
        <%--<%if(AuthorizationUtil.getMyUser()!=null && AuthorizationUtil.getMyUser().getId() != null){ %>--%>
        <%--<strong><%=AuthorizationUtil.getMyUser().getUsername()%></strong><a href="<c:url value='/j_spring_cas_security_logout'/>">退出</a></li>--%>
      <%--<% } %>--%>
      <%--<%if(AuthorizationUtil.getMyUser()==null || AuthorizationUtil.getMyUser().getId() == null){ %>--%>
      <%--<li><a href="<c:url value='http://192.168.1.57/cas/login?service=http%3A%2F%2Flocalhost:8080%2Fj_spring_cas_security_check'/>" title="登录">请登录</a></li>--%>
      <%--<li><a href="" title="快速注册">快速注册</a></li>--%>
      <%--<% } %>--%>
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
<div class="hd" style="width: 1000px;">
<div class="nav-bars ae">
  <ul class="bars">
    <li><a href="<c:url value='/masterMessage/index.do'/>">动&nbsp;态</a></li>
    <c:if test="${result == 'show'}">
      <li><a href="<c:url value='/masterMessage/forwardUrl'/>">关注</a></li>
    </c:if>
    <c:if test="${result == 'hide'}">
      <li><a href="<c:url value='/masterMessage/getFollowBeforeList'/>">关注</a></li>
    </c:if>
    <li class="active"><a href="<c:url value='/masterMessage/classify'/>">发&nbsp;现</a></li>
  </ul>
</div>
</div>
<!-- //End--header-->
<div class="list-find">
  <%--<div class="list-f-title">--%>
    <%--<p><a href="<c:url value='/masterMessage/index.do'/>">大师</a><i class="fu-icon"></i><span>发现</span></p>--%>
  <%--</div>--%>
  <div class="list-f-select">
    <div class="f-select-group">
      <div class="select-head">
        <span>分类：</span>
        <strong><a onclick="getData(this,'<c:url value="/masterCategory/getClassifyData.do?qm=plistMaster_all&pageEntity.size=6&pageEntity.index="/>')" about="1" class="active">全部</a></strong>
      </div>
      <ul class="select-list" id="projectClassify">
        <c:if test="${!empty categoryList}">
          <c:forEach items="${categoryList}" var="cate" varStatus="cat">
              <li><a about="0" onclick="getData(this,'<c:url value="/masterCategory/getClassifyData.do?qm=plistMasterProject_default&conditions=project.id:${cate.project.id};&pageEntity.size=6&pageEntity.index="/>');">${cate.project.name}</a></li>
          </c:forEach>
        </c:if>
      </ul>
    </div>
    <%--<div class="f-select-group">--%>
      <%--<div class="select-head">--%>
        <%--<span>级别：</span>--%>
        <%--<strong><a onclick="getData(this,'<c:url value="/masterCategory/getClassifyData.do?qm=plistMaster_all&pageEntity.size=6&pageEntity.index="/>')">全部</a></strong>--%>
      <%--</div>--%>
      <%--<ul class="select-list" id="levelClassify" onchange="changeCheckedStatus();">--%>
        <%--<li><a onclick="getData(this,'<c:url value="/masterCategory/getClassifyData.do?qm=plistMaster_byLevel&conditions=level:1;&pageEntity.size=6&pageEntity.index="/>');" about="0" class="">国家级</a></li>--%>
        <%--<li><a onclick="getData(this,'<c:url value="/masterCategory/getClassifyData.do?qm=plistMaster_byLevel&conditions=level:2;&pageEntity.size=6&pageEntity.index="/>');" about="0" class="">省级</a></li>--%>
        <%--<li><a onclick="getData(this,'<c:url value="/masterCategory/getClassifyData.do?qm=plistMaster_byLevel&conditions=level:3;&pageEntity.size=6&pageEntity.index="/>');" about="0" class="">市级</a></li>--%>
        <%--<li><a onclick="getData(this,'<c:url value="/masterCategory/getClassifyData.do?qm=plistMaster_byLevel&conditions=level:4;&pageEntity.size=6&pageEntity.index="/>');" about="0" class="">县级</a></li>--%>
      <%--</ul>--%>
    <%--</div>--%>
    <%--<div class="f-select-group cl-act">--%>
      <%--<div class="select-head">--%>
        <%--<span>地区：</span>--%>
        <%--<strong><a about="0" onclick="getData(this,'<c:url value="/masterCategory/getClassifyData.do?qm=plistMaster_all&pageEntity.size=6&pageEntity.index="/>')">全部</a></strong>--%>
      <%--</div>--%>
      <%--<ul class="select-list" id="cityClassify">--%>
        <%--<c:if test="${!empty cityList}">--%>
          <%--<c:forEach items="${cityList}" var="city">--%>
            <%--<li><a about="0" onclick="getData(this,'<c:url value='/masterCategory/getClassifyData.do?qm=plistMaster_byCity&conditions=originProvince.id:${city.id};&pageEntity.size=6&pageEntity.index='/>')">${city.name}</a></li>--%>
          <%--</c:forEach>--%>
        <%--</c:if>--%>
      <%--</ul>--%>
    <%--</div>--%>
  </div>
  <div class="ae">
    <div class="pc-dynamic" style="margin: 36px auto 0">
      <div class="p-dy-left" style="margin-bottom: 102px;">
        <ul class="list-dynamic ae" id="pubu">
        </ul>
      </div>
      <div class="p-dy-right">
        <div class="f-right-gy ae">
          <div class="h4"><span>新加入大师</span></div>
          <ul class="gy-grounp ae" id="newInsert">
          </ul>
          <div class="f-r-gd ae"><a onclick="moreMaster();"><span>更多大师</span><i class="sp-icon"></i></a></div>
        </div>
        <div class="f-right-gy ae">
          <div class="h4"><span>热门大师</span></div>
          <ul class="gy-grounp ae" id="hotMaster">
          </ul>
          <div class="f-r-gd ae"><a onclick="moreHotMaster();"><span>更多大师</span><i class="sp-icon"></i></a></div>
        </div>
      </div>
    </div>
  </div>
</div>
<script>

  //判断:当前元素是否是被筛选元素的子元素
  $.fn.isChildOf = function(b){
    return (this.parents(b).length > 0);
  };
  //判断:当前元素是否是被筛选元素的子元素或者本身
  $.fn.isChildAndSelfOf = function(b){
    return (this.closest(b).length > 0);
  };

  // 判断是否属于统一标签
  function judgeStartNum(o,url){
    if($(o).isChildAndSelfOf(object)){

    }else{
      ajaxKey=true;
      BaseUrl =url;
      $("#pubu").empty();
      StartMasterNum = 1;
      $(object).attr("about","0");
      $(object).attr("class","");
      $(o).attr("about","1");
      $(o).attr("class","active");
      object = o;
    }
  }

  $(document).ready(function(){
    $("#pages").html("发现大师 - e飞蚁");
    getData(object,"<c:url value="/masterCategory/getClassifyData.do?qm=plistMaster_all&pageEntity.size=6&pageEntity.index="/>");
    getData2("<c:url value='/masterMessage/subMaster/plistMaster_default/6/'/>");
    getData3("<c:url value='/masterMessage/hotMaster/plistMasterRecommend_group/6/'/>");
  })
  var StartMessageNum = 1;
  var StartMasterNum = 1;
  var StartRecommendNum = 1;
  var ajaxKey = true;//设置ajax请求的开关,如需动态加载、需要打开这个开关
  var BaseUrl = "<c:url value="/masterCategory/getClassifyData.do?qm=plistMaster_all&pageEntity.size=6&pageEntity.index="/>";
  var  object = $("a[about='1']");
  $(window).load(function(){
    var winH = $(window).height(); //页面可视区域高度
    $(window).scroll(function(){
      var pageH = $(document).height();
      var scrollT = $(window).scrollTop(); //滚动条top
      var aa = (pageH - winH - scrollT) / winH;
      if(aa < 0.02){
        if(ajaxKey){
          getData($("a[about='1']"),BaseUrl);
        }
      }
    });
  });
  function getData(e , url){
    judgeStartNum(e,url);
    var flag = false;
    $.ajax({
      type: "get",//设置get请求方式
      url: url + StartMasterNum,//设置请求的脚本地址
      data: "",//设置请求的数据
      async: true,
      dataType: "json",//设置请求返回的数据格式
      success: function (data) {
        StartMasterNum = StartMasterNum + 1;
        var pubu = $("#pubu");
        if(data != null && data.length > 0){
//          pubu.empty();
          for(var i in data){
            var levelName="";
            switch(data[i].level)
            {
              case "1":levelName="国家级"+data[i].projectName+"代表性传承人";break;
              case "2":levelName="省级"+data[i].projectName+"代表性传承人";break;
              case "3":levelName="市级"+data[i].projectName+"代表性传承人";break;
              default:levelName="县级"+data[i].projectName+"代表性传承人";
            }
            var box = "<li>"+
                    "                        <div class=\"pc-dy-txt ae master-list\">"+
                    "                            <div class=\"pc-dy-pic \">"+
                    "                                <div class=\"pc-d-pic\"><a href=\"<c:url value='/masterMessage/introView/'/>"+data[i].id+"\"><img  class=\"am-circle\"  src=\"http://tenant.oss-cn-beijing.aliyuncs.com/"+data[i].favicon+"\"></a></div>"+
                    "                                <!--关注组建-->"+
                    "                                <div class=\"pc-gz gz-pc\">"+
                    "                                    <div class=\"bt-gz act-1\">"+
                    "                                        <a class=\"btn-guan\" name=\"masterFollow"+data[i].id+"\" onclick=\"followMaster('"+data[i].id+"');\">"+
                    "                                            <div class=\"gz-q\">";
                      if(data[i].followStatus == "已关注"){
                        box += "<i class=\"gz-icon\" style='display: none'></i>";
                      }else{
                        box += "<i class=\"gz-icon\"></i>";
                      }
                    box += "                                                <em>"+data[i].followStatus+"</em>"+
                    "                                            </div>"+
                    "                                        </a>"+
                    "                                    </div>"+
                    "                                </div>"+
                    "                            </div>"+
                    "                            <div class=\"pc-dy-box \">"+
                    "                                <h6>"+data[i].masterName+"<span>"+data[i].cityName+"</span></h6>"+
                    "                                <p><span>"+levelName+"</span></p>"+
                    "                                <p>"+data[i].content+"</p>"+
                    "                                <div class=\"pc-dy-content\">"+
                    "                                    <ul class=\"list-pic\">";
                            if(data[i].works != null && data[i].works.length > 0){
                              var obj = data[i].works;
                              for(var j in obj){
                                if(j >= 0 && j < 4){
                                  box += "<li><a href=\"<c:url value='/masterMessage/getWorkDetails/'/>"+obj[j].id+"\"><img src=\"http://tenant.efeiyi.com/"+obj[j].pictureUrl+"@!master-message-view\"></a> </li>";
                                }
                              }
                            }
                    box +="                                    </ul>"+
                    "                                    <!--一张图-->"+
                    "                                </div>"+
                    "                            </div>"+
                    "                        </div>"+
                    "                    </li>";
            pubu.append(box);
          }
        }else{
          flag = true;
        }
      },
      complete:function(){
        if(flag==true) {
          ajaxKey = false;
        }
      }
    })
  }

  function getData2(url){
    var flag = false;
    $.ajax({
      type: "get",//设置get请求方式
      url: url + StartMasterNum,//设置请求的脚本地址
      data: "",//设置请求的数据
      async: true,
      dataType: "json",//设置请求返回的数据格式
      success: function (data) {
        StartMasterNum = StartMasterNum + 1;
        var rightUp = $("#newInsert");
        if(data != null && data.length > 0) {
          for (var i in data) {
            var levelName = "";
            if(data[i].level == "1"){
              levelName = "国际级";
            }else if(data[i].level == "2"){
              levelName = "国家级";
            }else if(data[i].level == "3"){
              levelName = "省级";
            }else if(data[i].level == "4"){
              levelName = "市级";
            }else if(data[i].level == "5"){
              levelName = "县级";
            }
            var box = "<li>"+
                    "            <div class=\"text\">"+
                    "              <p class=\"p1\"><a href=\"<c:url value='/masterMessage/introView/'/>"+data[i].id+"\">"+data[i].masterName+"</a></p>"+
                    "              <p class=\"p2\">"+data[i].projectName+"</p>"+
                    "              <p class=\"p2\">"+levelName+"非物质文化遗产</p>"+
                    "            </div>"+
                    "            <div class=\"bt-gz\">"+
                    "              <a class=\"btn-guan\" name=\"masterFollow"+data[i].id+"\" onclick=\"followMaster('"+data[i].id+"');\">"+
                    "                                            <div class=\"gz-q\">";
                      if(data[i].followStatus == "已关注"){
                        box += "<i class=\"gz-icon\" style='display: none'></i>";
                      }else{
                        box += "<i class=\"gz-icon\"></i>";
                      }
                      box += "  <em>"+data[i].followStatus+"</em>"+
                    "                </div>"+
                    "              </a>"+
                    "            </div>"+
                    "            <div class=\"img-q\">"+
                    "              <a href=\"<c:url value='/masterMessage/introView/'/>"+data[i].id+"\"><img src=\"http://tenant.oss-cn-beijing.aliyuncs.com/"+data[i].favicon+"\"></a>"+
                    "            </div>"+
                    "          </li>";
            rightUp.append(box);
          }
        }else{
          flag = true;
        }
      }
    })
  }
  function moreMaster(){
    var url = "<c:url value='/masterMessage/subMaster/plistMaster_default/6/'/>";
    getData2(url);
  }

  function getData3(url){
    var flag = false;
    $.ajax({
      type: "get",//设置get请求方式
      url: url + StartRecommendNum,//设置请求的脚本地址
      data: "",//设置请求的数据
      async: true,
      dataType: "json",//设置请求返回的数据格式
      success: function (data) {
        StartRecommendNum = StartRecommendNum + 1 ;
        var rightDown = $("#hotMaster");
        if(data != null && data.length > 0) {
          for (var i in data) {
            var levelName = "";
            if(data[i].level == "1"){
              levelName = "国际级";
            }else if(data[i].level == "2"){
              levelName = "国家级";
            }else if(data[i].level == "3"){
              levelName = "省级";
            }else if(data[i].level == "4"){
              levelName = "市级";
            }else if(data[i].level == "5"){
              levelName = "县级";
            }
            var box = "<li>"+
                    "            <div class=\"text\">"+
                    "              <p class=\"p1\">"+data[i].masterName+"</p>"+
                    "              <p class=\"p2\">"+data[i].projectName+"</p>"+
                    "              <p class=\"p2\">"+levelName+"非物质文化遗产</p>"+
                    "            </div>"+
                    "            <div class=\"bt-gz\">"+
                    "              <a class=\"btn-guan\" name=\"masterFollow"+data[i].id+"\" onclick=\"followMaster('"+data[i].id+"');\">"+
                    "                                            <div class=\"gz-q\">";
                      if(data[i].followStatus == "已关注"){
                        box += "<i class=\"gz-icon\" style='display: none'></i>";
                      }else{
                        box += "<i class=\"gz-icon\"></i>";
                      }
                      box += "<em>"+data[i].followStatus+"</em>"+
                    "                </div>"+
                    "              </a>"+
                    "            </div>"+
                    "            <div class=\"img-q\">"+
                    "              <a href=\"<c:url value='/masterMessage/introView/'/>"+data[i].id+"\"><img src=\"http://tenant.oss-cn-beijing.aliyuncs.com/"+data[i].favicon+"\"></a>"+
                    "            </div>"+
                    "          </li>";
            rightDown.append(box);
          }
        }else{
          flag = true;
        }
      }
    })
  }
  function moreHotMaster(){
    var url = "<c:url value='/masterMessage/hotMaster/plistMasterRecommend_group/6/'/>";
    getData3(url);
  }

  function followMaster(masterId){
    var str;
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
          str = "已关注";
          changeFollowStatus(masterId,str);
        }else if(data=="del"){
          str = "关注";
          changeFollowStatus(masterId,str);
        }
      }
    })
  }
  function changeFollowStatus(masterId,str){
    $("a[name='masterFollow"+masterId+"']").each(function(){
      $(this).find("em").html(str);
      if(str == "关注"){
        $(this).find('.gz-icon').show();
      }else if(str == "已关注"){
        $(this).find('.gz-icon').hide();
      }
    })
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


