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
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/pc/css/amazeui.min.css?v=20150831'/>">
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/pc/css/app.css?v=20150831'/>">
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/pc/css/leader.css?v=20150831'/>">
  <script src="<c:url value='/scripts/assets/js/jquery.min.js'/> "></script>
</head>
<body style="float: left">
<div class="topbar wh" data-am-sticky>
  <div class="hd">
    <ul class="ul-item">
      <li><strong>李先生8899</strong><a href="" title="退出">退出</a></li>
      <li><a href="" title="请登录">请登录</a></li>
      <li><a href="" title="快速注册">快速注册</a></li>
      <li><a href="" title="商家入驻">商家入驻</a></li>
      <li class="btn-top-wechat">
        <a title="手机e飞蚁">手机e飞蚁</a>
        <span class="top-wechat"></span>
      </li>
      <li class="cart">
        <a href="" title="购物车"><i class="icon"></i>购物车</a>
        <span class="tips"><em>0</em></span>
      </li>
    </ul>
  </div>
</div>
<!-- //End--topbar-->
<div class="header wh">
  <div class="hd">
    <div class="logo"><a class="icon" href="" target="_blank" title="e飞蚁-爱非遗"></a></div>
    <div class="nav">
      <ul>
        <li><a href="" title="首页">首页</a></li>
        <li><a href="" title="传承人">大师</a></li>
        <li><a href="" title="工艺">工艺</a></li>
      </ul>
    </div>
  </div>
</div>
<!-- //End--header-->
<div class="nav-bars ae">
  <ul class="bars">
    <li class="active"><a href="#">动&nbsp;态</a></li>
    <li><a href="#">已关注</a></li>
    <li><a href="#">发&nbsp;现</a></li>
  </ul>
</div>
<!--nav-bars-->
<div class="ae">
  <div class="pc-dynamic" >
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
<div class="footer wh">
  <div class="service wh">
    <div class="icon phone"></div>
    <div class="line"></div>
    <div class="icon platform"><a href="" target="_blank" title="平台优势">平台优势</a></div>
    <div class="line"></div>
    <div class="icon chengbao"><a href="" target="_blank" title="诚品宝">诚品宝</a></div>
    <div class="line"></div>
    <div class="icon wechat"></div>
  </div>
  <div class="links wh">
    <a href="" target="_blank" title="关于我们">关于我们</a>
    <a class="line"></a>
    <a href="" target="_blank" title="联系我们">联系我们</a>
    <a class="line"></a>
    <a href="" target="_blank" title="诚聘英才">诚聘英才</a>
    <a class="line"></a>
    <a href="" target="_blank" title="意见反馈">意见反馈</a>
    <a class="line"></a>
    <a href="" target="_blank" title="帮助中心">帮助中心</a>
    <a class="line"></a>
    <a href="" target="_blank" title="诚信保障">诚信保障</a>
    <a class="line"></a>
    <a href="" target="_blank" title="新闻资讯">新闻资讯</a>
  </div>
  <div class="copyright wh">
    <div class="phone">
      <strong>商家入住热线</strong>
      <em>400-876-8766</em>
    </div>
    <div class="frlinks">
      <span>友情链接：</span>
      <a rel="nofollow" href="http://www.unesco.org.cn/" target="_blank" title="联合国教科文组织">联合国教科文组织</a>
      <a rel="nofollow" href="http://www.mcprc.gov.cn/" target="_blank" title="中国文化部">中国文化部</a>
      <a rel="nofollow" href="" target="_blank" title="中国文化部非物质文化遗产保护司">中国文化部非物质文化遗产保护司</a>
      <a rel="nofollow" href="" target="_blank" title="中国非物质文化遗产保护中心">中国非物质文化遗产保护中心</a>
    </div>
    <div class="info">Copyright © 2012-2022 永新华韵文化发展有限公司版权所有-京ICP备15032511号-1</div>
  </div>
</div>
<!-- //End--footer-->
<script>
  //存储开始请求数据条数的位置
  var StartMessageNum = 1;
  var StartMasterNum = 1;
  var StartRecommendNum = 1;
  $(document).ready(function(){
    getData("<c:url value='/masterMessage/mainData.do?qm=plistMasterMessage_default&pageEntity.size=4&pageEntity.index='/>");
    getData2("<c:url value='/masterMessage/subMaster.do?qm=plistMaster_default&pageEntity.size=6&pageEntity.index='/>");
    getData3("<c:url value='/masterMessage/hotMaster.do?qm=plistMasterRecommend_group&pageEntity.size=6&pageEntity.index='/>");
  });
  $(window).load(function(){
      var winH = $(window).height(); //页面可视区域高度
      $(window).scroll(function(){
        var pageH = $(document.body).height();
        var scrollT = $(window).scrollTop(); //滚动条top
          var aa = (pageH - winH - scrollT) / winH;
        if(aa < 0.02){
          if(ajaxkey){
                getData("<c:url value='/masterMessage/mainData.do?qm=plistMasterMessage_default&pageEntity.size=4&pageEntity.index='/>");
              }
          }
      });
  });
  function getData(url){
    var flag = false;
    $.ajax({
      type: "get",//设置get请求方式
      url: url + StartMessageNum,//设置请求的脚本地址
      data: "",//设置请求的数据
      async: true,
      dataType: "json",//设置请求返回的数据格式
      success: function (data) {
        StartMessageNum = StartMessageNum + 1;
        console.log(data);
        var pubu = $("#pubu");
        if(data && data != null) {
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
            var box = $("<li><div class=\"pc-dy-txt ae\"><div class=\"pc-dy-pic\"><div class=\"pc-d-pic\"><a href=\"#\"><img  class=\"am-circle\"  src=\""+data[i].favicon+"\"></a></div>" +
                      "<div class=\"pc-gz gz-pc\"><div class=\"bt-gz act-1\"><a class=\"btn-guan\" name=\"masterFollow"+data[i].masterId+"\" onclick=\"followMaster('"+data[i].masterId+"');\"><div class=\"gz-q\"><i class=\"gz-icon\"></i><em>"+data[i].followStatus+"</em></div></a></div></div></div>" +
                      "<div class=\"pc-dy-box\"><h5>"+data[i].masterName+"</h5><p>"+data[i].projectName+"</p><p>"+levelName+"非遗传承人</p><div class=\"pc-dy-content\"><p>"+data[i].content+"</p>" +
                      "<div class=\"one-pic\"><a href=\"#\"><img src=\""+data[i].favicon+"\"></a></div><div class=\"one-tiem\"><span>9-13</span><span>12:30</span><span>来自&nbsp;"+data[i].dataSource+"</span></div>" +
                      "</div></div></div><div class=\"one-state\"><ul class=\"state\"><li><a onclick=\"praiseMessage(this,'"+data[i].id+"');\"><span class=\"pos\"><span class=\"line\"><i class=\"dnc-icon zq\"></i>" +
                      "<em>赞"+data[i].praiseNum+"</em></span></span></a></li><li><a href=\"<c:url value='/masterMessage/getMessageView.do?msgId='/>"+data[i].id+"\"><span class=\"pos\"><span class=\"line\"><i class=\"dnc-icon-2 zq\"></i><em>评论"+data[i].amount+"</em>" +
                      "</span></span></a></li><li><a href=\"#\"><span class=\"pos\"><span class=\"line\"><i class=\"dnc-icon-3 zq\"></i><em>收藏</em></span></span></a></li>" +
                      "<li style=\"position: relative\"><a href=\"#\"><span class=\"pos\"><span class=\"line\"><i class=\"dnc-icon-4 zq\"></i><em>分享</em></span></span></a>" +
                      "<div style=\"display: none\" class=\"nr-share\"><div class=\"nr-bg\"><div class=\"jiathis_style\"><a class=\"jiathis_button_weixin\"></a><a class=\"jiathis_button_tqq\"></a>" +
                      "<a class=\"jiathis_button_tsina\"></a><a class=\"jiathis_button_cqq\"></a></div></div></div></li></ul></div></li>");
              pubu.append(box);
          }
        }else{
          flag = true;
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
        console.log(data);
        var rightUp = $("#newInsert");
        if(data && data != null) {
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
            var box = $("<li>"+
            "            <div class=\"text\">"+
            "              <p class=\"p1\">"+data[i].masterName+"</p>"+
            "              <p class=\"p2\">"+data[i].projectName+"</p>"+
            "              <p class=\"p2\">"+levelName+"非物质文化遗产</p>"+
            "            </div>"+
            "            <div class=\"bt-gz\">"+
            "              <a class=\"btn-guan\" name=\"masterFollow"+data[i].id+"\" onclick=\"followMaster('"+data[i].id+"');\">"+
            "                <div class=\"gz-q\">"+
            "                  <i class=\"gz-icon\"></i>"+
            "                  <em>"+data[i].followStatus+"</em>"+
            "                </div>"+
            "              </a>"+
            "            </div>"+
            "            <div class=\"img-q\">"+
            "              <a href=\"#\"><img src=\""+data[i].favicon+"\"></a>"+
            "            </div>"+
            "          </li>");
            rightUp.append(box);
          }
        }else{
          flag = true;
        }
      }
    })
  }
  function moreMaster(){
    var url = "<c:url value='/masterMessage/subMaster.do?qm=plistMaster_default&pageEntity.size=6&pageEntity.index='/>";
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
        console.log(data);
        var rightDown = $("#hotMaster");
        if(data && data != null) {
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
            var box = $("<li>"+
                    "            <div class=\"text\">"+
                    "              <p class=\"p1\">"+data[i].masterName+"</p>"+
                    "              <p class=\"p2\">"+data[i].projectName+"</p>"+
                    "              <p class=\"p2\">"+levelName+"非物质文化遗产</p>"+
                    "            </div>"+
                    "            <div class=\"bt-gz\">"+
                    "              <a class=\"btn-guan\" name=\"masterFollow"+data[i].id+"\" onclick=\"followMaster('"+data[i].id+"');\">"+
                    "                <div class=\"gz-q\">"+
                    "                  <i class=\"gz-icon\"></i>"+
                    "                  <em>"+data[i].followStatus+"</em>"+
                    "                </div>"+
                    "              </a>"+
                    "            </div>"+
                    "            <div class=\"img-q\">"+
                    "              <a href=\"#\"><img src=\""+data[i].favicon+"\"></a>"+
                    "            </div>"+
                    "          </li>");
            rightDown.append(box);
          }
        }else{
          flag = true;
        }
      }
    })
  }
  function moreHotMaster(){
    var url = "<c:url value='/masterMessage/hotMaster.do?qm=plistMasterRecommend_group&pageEntity.size=6&pageEntity.index='/>";
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
        if(data =="noRole"){
          alert("您还没有登录,请登录后操作!");
        }else if(data == "add"){
          alert("成功!");
        }else if(data == "del"){
          alert("已取消点赞");
        }
      }
    })
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

<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value='/scripts/assets/js/amazeui.ie8polyfill.min.js'/>"></script>
<![endif]-->
<script src="<c:url value='/scripts/assets/js/system.js'/>"></script>
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
<script src="<c:url value='/scripts/assets/js/cyclopedia.js'/>"></script>
</body>
</html>

