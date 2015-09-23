<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.efeiyi.ec.wiki.organization.util.AuthorizationUtil" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/22
  Time: 19:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/wap/css/amazeui.min.css?v=20150831'/>">
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/wap/css/app.css?v=20150831'/>">
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/wap/css/cyclopedia.css?v=20150831'/>">
  <script type="text/javascript">
    $(document).ready(function(){
      $(".zoom,.ilike").hide();

      $(".zoom").each(function(){//遍历所有对象
        var src=$(this).siblings("img").attr("src");
        $(this).attr({href:src});
      });

      $("#nav li").click(function(){
        $("#nav a").removeClass("hover");
        $(this).find("a").addClass("hover");
      });

      $("#waterfall li").mouseover(function(){
        $(this).addClass("hover");
        $(this).find(".zoom,.ilike").show();
      });

      $("#waterfall li").mouseout(function(){
        $(this).removeClass("hover");
        $(this).find(".zoom,.ilike").hide();
      });
    });
  </script>
</head>
<body>
<div class="great">
  <header class="am-header custom-header">
    <div class="am-header-left am-header-nav">
      <a href="#chevron-left" class="chevron-left"></a>
    </div>
    <!-- //End--chevron-left-->
    <h1 class="am-header-title">${project.name}</h1>
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
  <div class="sit-page">
    <div class="sit-suit-head">
      <div class="sit-suit-text">
        <div class="sit-suit-content">
          <div class="sit-suit-cgz">
            <div class="sit-suit-cgz-l"><a href="#" class="cgz-r-1">关注</a></div>
            <div class="sit-suit-cgz-r"><a href="#" class="cgz-r-r">分享</a></div>
          </div>
          <div class="sit-suit-twz"><p>${project.description}</p></div>
        </div>
        <div class="sit-suit-img"><a href="http://www.baidu.com"><img src="../shop2015/upload/box-tx-3-4-10.jpg"></a></div>
      </div>
    </div>

    <div data-am-widget="tabs"
         class="am-tabs am-tabs-default"
            >
      <ul class="am-tabs-nav am-cf">
        <li class="am-active"><a href="[data-tab-panel-0]"><i class="bz-icon1"></i>
          <span style="float: left;margin-left: 10px;">简介</span><i class="sod-sr"></i></a></li>
        <li class=""><a href="[data-tab-panel-1]">
          <i class="bz-icon2"></i>
          <span style="float: left;margin-left: 10px;">传承人</span><i class="sod-sr"></i>
        </a></li>
        <li class=""><a href="[data-tab-panel-2]">
          <i class="bz-icon3"></i>
          <span style="float: left;margin-left: 10px;">作品</span></i>
        </a></li>
      </ul>
      <div class="am-tabs-bd">
        <div data-tab-panel-0 class="am-tab-panel am-active">
          <!--简介-->
          ${project.projectContents[0].content}
        </div>
        <div data-tab-panel-1 class="am-tab-panel ">
          <div class="vessel-inher">
            <!--传承人-->
            <div class="inheritor">
              <div class="inheritor-text">
                <p class="itor-text-1">张同禄</p>
                <p class="itor-text-2">景泰蓝</p>
                <p class="itor-text-3">国家级非遗传承人</p>
                <p class="itor-text-4">工笔勾画浓淡皆相宜</p>
                <a class="gz-fd-icon" href="#">关注</a>
                <div class="gz-fd-img"><a href="#"><img src="../shop2015/upload/box-tx-3-4-1.jpg"></a></div>
              </div>
            </div>
            <!--传承人-->
            <div class="inheritor">

              <div class="inheritor-text">
                <p class="itor-text-1">张同禄</p>

                <p class="itor-text-2">景泰蓝</p>

                <p class="itor-text-3">国家级非遗传承人</p>

                <p class="itor-text-4">工笔勾画浓淡皆相宜</p>
                <a class="gz-fd-icon" href="#">关注</a>

                <div class="gz-fd-img"><a href="#"><img src="../shop2015/upload/box-tx-3-4-1.jpg"></a>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div data-tab-panel-2 class="am-tab-panel ">
          <div class="penel-container"  id="pubu">
            <div class="master-works">
              <div class="works-list">
                <ul class="list-con">
                  <li class="item">
                    <a href="http://www.baidu.com"><img src="../shop2015/upload/120119-1.jpg"></a>
                    <div class="txt">
                      <div class="name">春梅</div>
                      <div class="txt-info">
                        <a href="#"><i class="icon good-1"></i><em>9999</em></a>
                        <a href="#"><i class="icon good-2"></i><em>9999</em></a>
                      </div>
                    </div>
                  </li>
                  <li class="item">
                    <a href="http://www.baidu.com"><img src="../shop2015/upload/120119-2.jpg"></a>
                    <div class="txt">
                      <div class="name">春梅</div>
                      <div class="txt-info">
                        <a href="#"><i class="icon good-1"></i><em>9999</em></a>
                        <a href="#"><i class="icon good-2"></i><em>9999</em></a>
                      </div>
                    </div>
                  </li>
                  <li class="item">
                    <a href="http://www.baidu.com"><img src="../shop2015/upload/120119-3.jpg"></a>
                    <div class="txt">
                      <div class="name">春梅</div>
                      <div class="txt-info">
                        <a href="#"><i class="icon good-1"></i><em>9999</em></a>
                        <a href="#"><i class="icon good-2"></i><em>9999</em></a>
                      </div>
                    </div>
                  </li>
                  <li class="item">
                    <a href="http://www.baidu.com"><img src="../shop2015/upload/120119-4.jpg"></a>
                    <div class="txt">
                      <div class="name">春梅</div>
                      <div class="txt-info">
                        <a href="#"><i class="icon good-1"></i><em>9999</em></a>
                        <a href="#"><i class="icon good-2"></i><em>9999</em></a>
                      </div>
                    </div>
                  </li>
                  <li class="item">
                    <a href="http://www.baidu.com"><img src="../shop2015/upload/120119-5.jpg"></a>
                    <div class="txt">
                      <div class="name">春梅</div>
                      <div class="txt-info">
                        <a href="#"><i class="icon good-1"></i><em>9999</em></a>
                        <a href="#"><i class="icon good-2"></i><em>9999</em></a>
                      </div>
                    </div>
                  </li>
                  <li class="item">
                    <a href="http://www.baidu.com"><img src="../shop2015/upload/120119-6.jpg"></a>
                    <div class="txt">
                      <div class="name">春梅</div>
                      <div class="txt-info">
                        <a href="#"><i class="icon good-1"></i><em>9999</em></a>
                        <a href="#"><i class="icon good-2"></i><em>9999</em></a>
                      </div>
                    </div>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>


  </div>
  <!--地区-->

  <!--//End--login-reg-->

  <!--//End--footer-->
</div>
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="<c:url value='/scripts/assets/wap/js/jquery.min.js?v=20150831'/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value='/scripts/assets/js/amazeui.ie8polyfill.min.js?v=20150831'/>"></script>
<![endif]-->
<script src="<c:url value='/scripts/assets/wap/js/amazeui.min.js?v=20150831'/>"></script>
<!--自定义js--Start-->

<script src="<c:url value='/scripts/assets/js/system.js?v=20150831'/>"></script>
<script src="<c:url value='/scripts/assets/js/cyclopedia.js?v=20150831'/>"></script>
<script type="text/javascript">
  $(function(){

    var $waterfall = $('#waterfall');

    $waterfall.masonry({
      columnWidth: 230
    });

  });
</script>
<!--自定义js--End-->
</body>
</html>