<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/24
  Time: 11:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/layouts/public.jsp" %>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>X10101首页</title>
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
  <link type="text/css" rel="stylesheet" href="/shop2015/css/amazeui.min.css?v=20150831">
  <link type="text/css" rel="stylesheet" href="/shop2015/css/app.css?v=20150831">
</head>
<body>
<header class="wh header">
  <div class="hd">
    <a class="icon logo" href="" title="中国非物质文化遗产保护协会"></a>
    <div class="txt">
      <p>以“宣传、保护、传承”非物质文化遗产为宗旨。</p>
      <p>以提升我国人民群众对非物质文化遗产的保护意识为目的。</p>
    </div>
  </div>
</header>
<!--//End--header-->
<div class="wh nav">
  <div class="hd">
    <ul class="ul-list">
      <li><a href="" title="" target="_blank">首页</a></li>
      <li><a href="" title="" target="_blank">协会概况</a></li>
      <li><a href="" title="" target="_blank">新闻公告</a></li>
      <li><a href="" title="" target="_blank">下属机构</a></li>
      <li><a href="" title="" target="_blank">非遗名录</a></li>
      <li><a href="" title="" target="_blank">非遗保护</a></li>
    </ul>
    <a href="#btn-menu-down" class="btn-menu-down" title=""><i class="icon icon-menu"></i></a>
    <a style="display: none;" href="btn-menu-up" class="btn-menu-up" title=""><i class="icon icon-menu"></i></a>
  </div>
</div>
<!--//End--nav-->
<div class="wh home">
  <div class="hd">
    <div class="slide-left">
      <div class="focus">
        <div data-am-widget="slider" class="am-slider am-slider-default" data-am-slider='{"animation":"slide","slideshow":false}' >
          <ul class="am-slides">
            <c:forEach items="${bannerList}" var="banner">
              <li>
                <a href="${banner.directUrl}" target="_blank"><img src="<%=imgBasePath %>${banner.imageUrl}"></a>
                <div class="am-slider-desc">
                  <h3>${banner.title}</h3>
                  <p>这是标题标题标题标题标题标题标题这是标题标题标题标题标题标题标题</p>
                </div>
              </li>
            </c:forEach>
            <%--<li>
              <img src="../shop2015/upload/banner1.jpg">
              <div class="am-slider-desc">
                <h3>这是标题标题标题标题标题标题标题0</h3>
                <p>这是标题标题标题标题标题标题标题这是标题标题标题标题标题标题标题</p>
              </div>
            </li>
            <li>
              <img src="../shop2015/upload/banner1.jpg">
              <div class="am-slider-desc">
                <h3>这是标题标题标题标题标题标题标题0</h3>
                <p>这是标题标题标题标题标题标题标题这是标题标题标题标题标题标题标题</p>
              </div>
            </li>
            <li>
              <img src="../shop2015/upload/banner1.jpg">
              <div class="am-slider-desc">
                <h3>这是标题标题标题标题标题标题标题0</h3>
                <p>这是标题标题标题标题标题标题标题这是标题标题标题标题标题标题标题</p>
              </div>
            </li>
            <li>
              <img src="../shop2015/upload/banner1.jpg">
              <div class="am-slider-desc">
                <h3>这是标题标题标题标题标题标题标题0</h3>
                <p>这是标题标题标题标题标题标题标题这是标题标题标题标题标题标题标题</p>
              </div>
            </li>
            <li>
              <img src="../shop2015/upload/banner1.jpg">
              <div class="am-slider-desc">
                <h3>这是标题标题标题标题标题标题标题0</h3>
                <p>这是标题标题标题标题标题标题标题这是标题标题标题标题标题标题标题</p>
              </div>
            </li>
            <li>
              <img src="../shop2015/upload/banner1.jpg">
              <div class="am-slider-desc">
                <h3>这是标题标题标题标题标题标题标题0</h3>
                <p>这是标题标题标题标题标题标题标题这是标题标题标题标题标题标题标题</p>
              </div>
            </li>--%>
          </ul>
        </div>
      </div>
      <!--//End--am-slider-->
      <div class="wh list-box">
        <div class="list-news">
          <div class="title">非遗要闻</div>
          <ul class="ul-items">
            <c:forEach items="${IndustryList}" var="industry">
              <li>
                <a href="#" target="_blank" title=""><img src="../shop2015/upload/exp1.jpg" alt=""/></a>
                <p class="name">${industry.title}</p>
                <p class="info">${industry.sampleContent}</p>
                <a href="#阅读更多" class="btn-more" title="阅读更多">阅读更多</a>
              </li>
            </c:forEach>
            <%--<li>
              <a href="" target="_blank" title=""><img src="../shop2015/upload/exp1.jpg" alt=""/></a>
              <p class="name">文化部启动非遗传承人群研修研习培训计划</p>
              <p class="info">非遗协会的业务范围广泛，包括：调查研究信息收集、举办展览、专业培训咨询服务和国际合作等方面，济和文化交流工作。</p>
              <a href="#阅读更多" class="btn-more" title="阅读更多">阅读更多</a>
            </li>
            <li>
              <a href="" target="_blank" title=""><img src="../shop2015/upload/exp1.jpg" alt=""/></a>
              <p class="name">第九届中国（长春）民间艺术博览会</p>
              <p class="info">中国方面，永新文化产业集团董事长李永军先生作出“一多相容、和而不同”的主题演讲，引发大家对文化多样性的深思。</p>
              <a href="#阅读更多" class="btn-more" title="阅读更多">阅读更多</a>
            </li>
            <li>
              <a href="" target="_blank" title=""><img src="../shop2015/upload/exp1.jpg" alt=""/></a>
              <p class="name">由中国非物质文化遗产保护协会</p>
              <p class="info">巴基斯坦拉合尔国立大学视觉艺术及设计学院美术系主任拉什德•拉农先生阐述：“艺术，文化表达的交汇点”。</p>
              <a href="#阅读更多" class="btn-more" title="阅读更多">阅读更多</a>
            </li>--%>
          </ul>
        </div>
        <!-- //End---->
        <div class="list-news list-news2">
          <div class="title">重要通知</div>
          <ul class="ul-items">
            <li>
              <a href="" target="_blank" title=""><img src="../shop2015/upload/exp1.jpg" alt=""/></a>
              <p class="name">文化部启动非遗传承人群研修研习培训计划</p>
              <p class="info">非遗协会的业务范围广泛，包括：调查研究信息收集、举办展览、专业培训咨询服务和国际合作等方面，济和文化交流工作。</p>
              <a href="#阅读更多" class="btn-more" title="阅读更多">阅读更多</a>
            </li>
            <li>
              <a href="" target="_blank" title=""><img src="../shop2015/upload/exp1.jpg" alt=""/></a>
              <p class="name">第九届中国（长春）民间艺术博览会</p>
              <p class="info">中国方面，永新文化产业集团董事长李永军先生作出“一多相容、和而不同”的主题演讲，引发大家对文化多样性的深思。</p>
              <a href="#阅读更多" class="btn-more" title="阅读更多">阅读更多</a>
            </li>
            <li>
              <a href="" target="_blank" title=""><img src="../shop2015/upload/exp1.jpg" alt=""/></a>
              <p class="name">由中国非物质文化遗产保护协会</p>
              <p class="info">巴基斯坦拉合尔国立大学视觉艺术及设计学院美术系主任拉什德•拉农先生阐述：“艺术，文化表达的交汇点”。</p>
              <a href="#阅读更多" class="btn-more" title="阅读更多">阅读更多</a>
            </li>
          </ul>
        </div>
        <!-- //End---->
      </div>
      <!-- //End---->
      <div class="wh directory">
        <div class="title">非遗名录<a class="btn-more" href="#更多" title="更多">更多</a></div>
        <ul class="list-img-txt">
          <li>
            <a href="" target="_blank" title=""><img src="../shop2015/upload/exp4.jpg" alt=""/></a>
            <p>蓝印花布手工艺</p>
          </li>
          <li>
            <a href="" target="_blank" title=""><img src="../shop2015/upload/exp4.jpg" alt=""/></a>
            <p>蓝印花布手工艺</p>
          </li>
          <li>
            <a href="" target="_blank" title=""><img src="../shop2015/upload/exp4.jpg" alt=""/></a>
            <p>蓝印花布手工艺</p>
          </li>
          <li>
            <a href="" target="_blank" title=""><img src="../shop2015/upload/exp4.jpg" alt=""/></a>
            <p>蓝印花布手工艺</p>
          </li>
        </ul>
        <a href="#上一页" class="btn btn-prev" title="上一页"></a>
        <a href="#下一页" class="btn btn-next" title="下一页"></a>
      </div>
      <!-- //End---->
      <div class="wh data-down">
        <div class="title">资料下载<a class="btn-more" href="#更多" title="更多">更多</a></div>
        <ul class="list-table">
          <li>
            <a href="#" target="_blank" title="国家级非物质文化遗产项目代表性传承人认定与管理暂行办法(2008)">
              <table>
                <tr>
                  <td>国家级非物质文化遗产项目代表性传承人认定与管理暂行办法(2008)</td>
                </tr>
              </table>
            </a>
          </li>
          <li>
            <a href="#" target="_blank" title="中华人民共和国非物质文化遗产法（2011）">
              <table>
                <tr>
                  <td>中华人民共和国非物质文化遗产法（2011）(2008)</td>
                </tr>
              </table>
            </a>
          </li>
          <li>
            <a href="#" target="_blank" title="中华人民共和国非物质文化遗产法（2011）">
              <table>
                <tr>
                  <td>中华人民共和国非物质文化遗产法（2011）</td>
                </tr>
              </table>
            </a>
          </li>
          <li>
            <a href="#" target="_blank" title="中华人民共和国非物质文化遗产法（2011）">
              <table>
                <tr>
                  <td>中华人民共和国非物质文化遗产法（2011）</td>
                </tr>
              </table>
            </a>
          </li>
        </ul>
      </div>
      <!-- //End---->
    </div>
    <!-- //End--slide-right-->
    <div class="slider-right">
      <div class="part">
        <div class="title">非物质文化</div>
        <ul class="ul-list">
          <li>
            <a href="" target="_blank" title=""><img src="../shop2015/upload/exp5.jpg" alt=""/></a>
            <p>建立非遗协会这样国家级的非物质文化遗产构。</p>
            <a class="btn-more" href="#更多" target="_blank" title="更多">更多</a>
          </li>
          <li>
            <a href="" target="_blank" title=""><img src="../shop2015/upload/exp5.jpg" alt=""/></a>
            <p>建立非遗协会这样国家级的非物质文化遗产构。</p>
            <a class="btn-more" href="#更多" target="_blank" title="更多">更多</a>
          </li>
        </ul>
      </div>
      <!-- //End--part1-->
      <div class="part">
        <div class="title">在线服务</div>
        <ul class="ul-list-btn">
          <li><a href="#在线申报" target="_blank" title="在线申报"><i class="icon icon-1"></i>在线申报</a></li>
          <li><a href="#非遗名录" target="_blank" title="非遗名录"><i class="icon icon-2"></i>非遗名录</a></li>
          <li><a href="#法规政策" target="_blank" title="法规政策"><i class="icon icon-3"></i>法规政策</a></li>
          <li><a href="#下属机构" target="_blank" title="下属机构"><i class="icon icon-4"></i>下属机构</a></li>
        </ul>
      </div>
      <!-- //End--part-->
      <div class="part">
        <div class="title">非物质文化</div>
        <ul class="ul-list">
          <li>
            <a href="" target="_blank" title=""><img src="../shop2015/upload/exp6.jpg" alt=""></a>
            <p>姚惠芬-苏绣</p>
          </li>
          <li>
            <a href="" target="_blank" title=""><img src="../shop2015/upload/exp6.jpg" alt=""></a>
            <p>姚惠芬-苏绣</p>
          </li>
        </ul>
      </div>
    </div>
    <!-- //End--slide-right-->
  </div>
</div>
<!--//End--home-->
<div class="footer wh">

  <div class="links wh">
    <a href="" target="_blank" title="关于我们">关于我们</a>
    <a class="line"></a>
    <a href="" target="_blank" title="联系我们">联系我们</a>
    <a class="line"></a>
    <a href="" target="_blank" title="诚聘英才">诚聘英才</a>
    <a class="line"></a>
    <a href="" target="_blank" title="意见反馈">意见反馈</a>
    <a class="line"></a>
    <a href="" target="_blank" title="诚信保障">诚信保障</a>
    <a class="line"></a>
    <a href="" target="_blank" title="新闻资讯">新闻资讯</a>
  </div>
  <div class="copyright wh">
    <div class="frlinks">
      <span>友情链接：</span>
      <a rel="nofollow" href="http://www.unesco.org.cn/" target="_blank" title="联合国教科文组织">联合国教科文组织</a>
      <a rel="nofollow" href="http://www.mcprc.gov.cn/" target="_blank" title="中国文化部">中国文化部</a>
      <a rel="nofollow" href="http://www.mcprc.gov.cn/whzx/bnsjdt/fwzwhycs/" target="_blank" title="中国文化部非物质文化遗产保护司">中国文化部非物质文化遗产保护司</a>
      <a rel="nofollow" href="http://www.ihchina.cn/show/feiyiweb/index.html" target="_blank" title="中国非物质文化遗产保护中心">中国非物质文化遗产保护中心</a>
    </div>
    <div class="info">Copyright © 2012-2022 永新华韵文化发展有限公司版权所有-京ICP备15032511号-1</div>
  </div>
</div>




<!--[if (gte IE 9)|!(IE)]><!-->
<script src="../shop2015/js/jquery.min.js"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="../shop2015/js/amazeui.min.js"></script>
<script src="../shop2015/js/system.js"></script>
</body>
</html>
