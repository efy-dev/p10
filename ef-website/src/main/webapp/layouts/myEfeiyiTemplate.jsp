<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/24
  Time: 17:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>--%>
<html>
<head>
  <sitemesh:write property='head'/>
  <meta name="renderer" content="webkit">
  <!-- No Baidu Siteapp-->
  <meta http-equiv="Cache-Control" content="no-siteapp"/>
  <link rel="icon" type="image/png" href="assets/i/favicon.png">
  <!-- Add to homescreen for Chrome on Android -->
  <meta name="mobile-web-app-capable" content="yes">
  <link rel="ico" sizes="192x192" href="assets/i/app-icon72x72@2x.png">
  <!-- Add to homescreen for Safari on iOS -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
  <link rel="apple-touch-icon-precomposed" href="assets/i/app-icon72x72@2x.png">
  <!-- Tile icon for Win8 (144x144 + tile color) -->
  <meta name="msapplication-TileImage" content="assets/i/app-icon72x72@2x.png">
  <meta name="msapplication-TileColor" content="#0e90d2">
  <link type="text/css" rel="stylesheet" href="/scripts/assets/css/amazeui.min.css">
  <link type="text/css" rel="stylesheet" href="/scripts/assets/css/my-efeiyi2.css">
  <link type="text/css" rel="stylesheet" href="/scripts/assets/css/app.css">
</head>
<body>
<div class="hd">
  <div class="header wh">
    <div class="logo"><a class="icon" href="" target="_blank" title="e飞蚁-爱非遗"></a></div>
    <div class="nav">
      <ul>
        <li><a href="" title="首页">首页</a></li>
        <li><a href="" title="商品分类">商品分类</a></li>
        <li><a href="" title="传承人">传承人</a></li>
        <li><a href="" title="展览">展览</a></li>
        <li><a href="" title="资讯">资讯</a></li>
      </ul>
    </div>
  </div>
</div>
<div class="my-order">
  <div class="order-nav">
    <div class="layout-nav">
      <div class="order">
        <span><img src="/scripts/assets/images/img-tx.png"></span>
        <p>151******79</p>
      </div>
        <c:set var="match" value="${requestScope['javax.servlet.forward.servlet_path']}"/>
        <jsp:include flush="true" page="/getMenu.do?jmenuId=orderMenu&jnodeId=orderManager&resultPage=/purchaseOrder/purchaseOrderTemplate&match=${match} "/>

    </div>


    <sitemesh:write property='body'/>
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

</body>


</html>
