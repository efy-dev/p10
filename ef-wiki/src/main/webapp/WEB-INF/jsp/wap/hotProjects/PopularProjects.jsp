<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/14
  Time: 9:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>工艺</title>
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
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/wap/css/app.css?v=20150831'/>">
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/wap/css/cyclopedia.css?v=20150831'/>">
  <script src="/scripts/assets/js/jquery-2.1.3.min.js" type="text/javascript"></script>
  <script type="text/javascript" src="/scripts/assets/js/pubu.js"></script>
</head>
<body>
<script>
  $(window).load(function(){
    getData("<c:url value='/basic/xmj.do?qm=plistProjectRecommended_default&conditions=&pageEntity.size=10&pageEntity.index='/>");
    PBL("#pubu","#box",2);
    var ajaxkey = true;//设置ajax请求的开关,如需动态加载、需要打开这个开关
    var winH = $(window).height(); //页面可视区域高度
    $(window).scroll(function(){
      var pageH = $(document.body).height();
      var scrollT = $(window).scrollTop(); //滚动条top
      var aa = (pageH - winH - scrollT) / winH;
      //alert(aa)
      if(aa < 0.02){
        if (getDataCheck() && ajaxkey) {

          getData("/basic/xmj.do?qm=plistProjectRecommended_default&conditions=&pageEntity.size=10&pageEntity.index=");//jquery的Ajax异步加载数据、需要从数据库加载的、需要调用该函数
        };

      }


    });

  })
</script>

<div class="great">
  <header class="am-header custom-header">
    <div class="am-header-left am-header-nav">
      <a href="#chevron-left" class="chevron-left"></a>
    </div>
    <!-- //End--chevron-left-->
    <h1 class="am-header-title">工艺</h1>
    <!-- //End--title-->
    <div class="am-header-right am-header-nav am-header-right1">
      <a href="#chevron-right" class="chevron-right" id="menu">
        <i class="icon icon-user"></i>
      </a>
    </div>
  </header>
  <!--//End--header-->
  <!--地区-->
  <div class="dis-q1">
    <div class="dis-q1-tabs">
      <ul class="tabs-nav tabs-nav-1">
        <li class="item active">热门</li>
        <li class="item">关注</li>
        <li class="item-class"><a href="http://www.baidu.com">分类</a></li>
      </ul>
      <ul class="tabs-nav tabs-nav-2">
        <li class="item active">分类</li>
        <li class="item">级别</li>
        <li class="item">地区</li>
      </ul>

      <div class="tabs-bd">
        <div class="am-tab-panel am-active" style="padding:10px 0 15px 0;width: 100%;float: left" id="pubu">
          <c:forEach var="ppj" items="${popularProjectsList}">
          <ul class="hot" id="box">
            <li>
              <a href="#"><img src="${ppj.project.picture_url}"></a>
              <div class="hot-poge">
                <span style="margin-right: 1rem">人气</span>
                <span>${ppj.project.projectFolloweds.length}</span>
              </div>
            </li>
          </ul>
          </c:forEach>
        </div>
        <div class="am-tab-panel ">
          <div class="suit">
            <div class="dynamic" style="border-bottom: 0">
              <div class="attention"><p>目前您还没有关注任何大师，下面是我们为您推荐的几位大师</p></div>
              <ul class="dynamic-list-suit">
                <!--只显示9个-->
                <li class="am-u-sm-4 am-u-end">
                  <div class="suit-list-bt">
                    <a href="#"><img src="../shop2015/upload/box-tx-3-4-7.jpg"></a>
                    <a class="gz-fd-icon" href="#">关注</a>
                  </div>
                  <div class="suit-list-wz"><span>iu</span></div>
                </li>
                <li class="am-u-sm-4 am-u-end">
                  <div class="suit-list-bt">
                    <a href="#"><img src="../shop2015/upload/box-tx-3-4-9.jpg"></a>
                    <a class="gz-fd-icon" href="#">已关注</a>
                  </div>
                  <div class="suit-list-wz"><span>金泰妍</span></div>
                </li>
                <li class="am-u-sm-4 am-u-end">
                  <div class="suit-list-bt">
                    <a href="#"><img src="../shop2015/upload/box-tx-3-4-7.jpg"></a>
                    <a class="gz-fd-icon" href="#">关注</a>
                  </div>
                  <div class="suit-list-wz"><span>iu</span></div>
                </li>
                <li class="am-u-sm-4 am-u-end">
                  <div class="suit-list-bt">
                    <a href="#"><img src="../shop2015/upload/box-tx-3-4-9.jpg"></a>
                    <a class="gz-fd-icon" href="#">已关注</a>
                  </div>
                  <div class="suit-list-wz"><span>金泰妍</span></div>
                </li>
                <li class="am-u-sm-4 am-u-end">
                  <div class="suit-list-bt">
                    <a href="#"><img src="../shop2015/upload/box-tx-3-4-7.jpg"></a>
                    <a class="gz-fd-icon" href="#">关注</a>
                  </div>
                  <div class="suit-list-wz"><span>iu</span></div>
                </li>
                <li class="am-u-sm-4 am-u-end">
                  <div class="suit-list-bt">
                    <a href="#"><img src="../shop2015/upload/box-tx-3-4-9.jpg"></a>
                    <a class="gz-fd-icon" href="#">已关注</a>
                  </div>
                  <div class="suit-list-wz"><span>金泰妍</span></div>
                </li>
                <li class="am-u-sm-4 am-u-end">
                  <div class="suit-list-bt">
                    <a href="#"><img src="../shop2015/upload/box-tx-3-4-7.jpg"></a>
                    <a class="gz-fd-icon" href="#">关注</a>
                  </div>
                  <div class="suit-list-wz"><span>iu</span></div>
                </li>
                <li class="am-u-sm-4 am-u-end">
                  <div class="suit-list-bt">
                    <a href="#"><img src="../shop2015/upload/box-tx-3-4-9.jpg"></a>
                    <a class="gz-fd-icon" href="#">已关注</a>
                  </div>
                  <div class="suit-list-wz"><span>金泰妍</span></div>
                </li>
                <li class="am-u-sm-4 am-u-end">
                  <div class="suit-list-bt">
                    <a href="#"><img src="../shop2015/upload/box-tx-3-4-9.jpg"></a>
                    <a class="gz-fd-icon"  href="#">已关注</a>
                  </div>
                  <div class="suit-list-wz"><span>金泰妍</span></div>
                </li>
              </ul>
              <a href="#" class="state-btn" style="color: #000;">查看更多工艺</a>
            </div>
            <div class="dynamic">
              <ul class="suit-zt-2">
                <li>
                  <div class="suit-zt--2-img am-u-sm-5 am-u-end">
                    <a href="#"><img src="../shop2015/upload/box-tx-3-4-9.jpg">
                      <div class="tp-bg-0">
                        <table>
                          <tr><td><div style="padding: 0 1rem;">铜胎掐丝珐琅景泰蓝</div></td></tr>
                        </table>
                      </div></a>
                  </div>
                  <div class="suit-zt--2-text am-u-sm-7 am-u-end">
                    <h4>景泰蓝工艺详情更新了</h4>
                    <p><a href="#"> 增加相关大师5位</a></p>
                  </div>
                </li>
                <li>
                  <div class="suit-zt--2-img am-u-sm-5 am-u-end">
                    <a href="www.baidu.com"><img src="../shop2015/upload/box-tx-3-4-7.jpg">
                      <div class="tp-bg-0">
                        <table>
                          <tr><td><div style="padding: 0 1rem;">铜胎掐丝珐琅景泰蓝</div></td></tr>
                        </table>
                      </div></a>
                  </div>
                  <div class="suit-zt--2-text am-u-sm-7 am-u-end">
                    <h4>景泰蓝工艺详情更新了</h4>
                    <p><a href="#"> 增加相关大师5位</a></p>
                  </div>
                </li>
              </ul>
            </div>
          </div>
        </div>
        <div class="am-tab-panel">
          <ul class="hot">
            <li>
              <a href="#"><img src="../shop2015/upload/cp-hd-1-2.jpg"></a>
              <div class="hot-poge">
                <span style="margin-right: 1rem">人气</span>
                <span>9999</span>
              </div>
            </li>
            <li>
              <a href="#"><img src="../shop2015/upload/cp-hd-1-3.jpg"></a>
              <div class="hot-poge">
                <span style="margin-right: 1rem">人气</span>
                <span>9999</span>
              </div>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
  <!--地区-->
  <div class="login-reg">
    <div class="bd logined">李先生8899，<a class="btn-exit" href="#退出">退出</a></div>
    <a href="#login" class="btn-login" title="登录">登&nbsp;&nbsp;&nbsp;&nbsp;录</a>
    <a href="#reg" class="btn-reg">注&nbsp;&nbsp;&nbsp;&nbsp;册</a>
  </div>

</div>
<!--[if (gte IE 9)|!(IE)]><!-->
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<!--自定义js--Start-->
<script src="<c:url value='/scripts/assets/js/system.js?v=20150831'/>"></script>
<script src="<c:url value='/scripts/assets/js/cyclopedia.js?v=20150831'/>"></script>
<!--自定义js--End-->
</body>
</html>