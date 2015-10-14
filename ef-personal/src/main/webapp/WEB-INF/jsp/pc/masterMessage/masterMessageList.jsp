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
<body>
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
        <ul class="gy-grounp ae">
          <li>
            <div class="text">
              <p class="p1">魏立中</p>
              <p class="p2">木板水印</p>
              <p class="p2">国家级非物质文化遗产</p>
            </div>
            <div class="bt-gz">
              <a class="btn-guan" href="#">
                <div class="gz-q">
                  <i class="gz-icon"></i>
                  <em>关注</em>
                </div>
              </a>
            </div>
            <div class="img-q">
              <a href="#"><img src="../shop2015/upload/pep-2.jpg"></a>
            </div>
          </li>
        </ul>
        <div class="f-r-gd ae"><a href="#"><span>更多大师</span><i class="sp-icon"></i></a></div>
      </div>
      <div class="f-right-gy ae">
        <div class="h4"><span>热门大师</span></div>
        <ul class="gy-grounp ae">
          <li>
            <div class="text">
              <p class="p1">魏立中</p>
              <p class="p2">木板水印</p>
              <p class="p2">国家级非物质文化遗产</p>
            </div>
            <div class="bt-gz">
              <a class="btn-guan" href="#">
                <div class="gz-q">
                  <i class="gz-icon"></i>
                  <em>关注</em>
                </div>
              </a>
            </div>
            <div class="img-q">
              <a href="#"><img src="../shop2015/upload/pep-2.jpg"></a>
            </div>
          </li>
        </ul>
        <div class="f-r-gd ae"><a href="#"><span>更多大师</span><i class="sp-icon"></i></a></div>
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
      getData("<c:url value='/basic/xmj.do?qm=plistMasterMessage_default&pageEntity.size=4&pageEntity.index='/>");
  });
  $(window).load(function(){
      var winH = $(window).height(); //页面可视区域高度
      $(window).scroll(function(){
          var pageH = $(document.body).height();
          var scrollT = $(window).scrollTop(); //滚动条top
          var aa = (pageH - winH - scrollT) / winH;
          if(aa < 0.02){
              if(ajaxkey){
                  getData2("<c:url value='/basic/xmj.do?qm=plistMasterProject_master&conditions=project.id:${project.id}&pageEntity.size=12&pageEntity.index='/>");
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
        console.log(data);
        var pubu = $("#pubu");
        if(data.list && data.list != null) {
          for (var i in data.list) {
              var box = $("<li><div class=\"pc-dy-txt ae\"><div class=\"pc-dy-pic\"><div class=\"pc-d-pic\"><a href=\"#\"><img  class=\"am-circle\"  src=\"../shop2015/upload/pep-2.jpg\"></a></div>" +
                      "<div class=\"pc-gz gz-pc\"><div class=\"bt-gz act-1\"><a class=\"btn-guan\" href=\"#\"><div class=\"gz-q\"><i class=\"gz-icon\"></i><em>关注</em></div></a></div></div></div>" +
                      "<div class=\"pc-dy-box\"><h5>张同禄</h5><p>景泰蓝</p><p>国家级非遗传承人</p><div class=\"pc-dy-content\"><p>大家好，景泰蓝展览</p>" +
                      "<div class=\"one-pic\"><a href=\"#\"><img src=\"../shop2015/upload/dashi-img-1.png\"></a></div><div class=\"one-tiem\"><span>9-13</span><span>12:30</span><span>来自&nbsp;微信</span></div>" +
                      "</div></div></div><div class=\"one-state\"><ul class=\"state\"><li><a href=\"#\"><span class=\"pos\"><span class=\"line\"><i class=\"dnc-icon zq\"></i>" +
                      "<em>赞(9999)</em></span></span></a></li><li><a href=\"#\"><span class=\"pos\"><span class=\"line\"><i class=\"dnc-icon-2 zq\"></i><em>评论(9999)</em>" +
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
          type:"get",//设置get请求方式
          url:url+StartNum2,//设置请求的脚本地址
          data:"",//设置请求的数据
          async:true,
          dataType:"json",//设置请求返回的数据格式
          success:function(data){
          var pubu = $("#pubu");
          if(data.list && data.list != null){
            for(i in data.list){
              var box = $("<li class=\"cell craft-page\"><a href=\"<c:url value='/project/showProduct.do?productId='/>"+data.list[i].id+"\"> <img src=\""+data.list[i].picture_url+"\"> " +
              "</a><h4 class=\"ae\">"+data.list[i].name+"</h4> <div class=\"function-page ae\">") ;
              pubu.append(box);
            }
          }else{
              flag = true;
          }
          PBL("#pubu",".craft-page",2);
          StartNum2=StartNum2+1;
          },
          error:function(){
              alert("出错了，请联系管理员！！！");
              return false;
          },
          complete:function(){
            if(flag==true) {
              ajaxkey = false;
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
  //设置请求数据加载的样式
  function getStyle(boxs,top,left,index,style){
    if (getStartNum>=index) {
      return;
    }
    boxs.css("position","absolute");
    switch(style){
      case 1:
        boxs.css({
          "top":top+$(window).height(),
          "left":left
        });
        boxs.stop().animate({
          "top":top,
          "left":left
        },999);
        break;
      case 2:
        boxs.css({
          "top":top,
          "left":left+10*(index+1),
          "opacity":"0"
        });
        boxs.stop().animate({
          "opacity":"1"
        },999);
    }
    getStartNum = index;//更新请求数据的条数位置

  }
</script>

<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="/scripts/assets/js/system.js"></script>
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
<script src="/scripts/assets/js/cyclopedia.js"></script>
</body>
</html>

