<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>移动端详情-商品信息终</title>
  <!-- Set render engine for 360 browser -->
  <meta name="renderer" content="webkit">
  <!-- No Baidu Siteapp-->
  <meta http-equiv="Cache-Control" content="no-siteapp"/>
  <link rel="icon" type="image/png" href="<c:url value='/resources/assets/i/favicon.png'/>">
  <!-- Add to homescreen for Chrome on Android -->
  <meta name="mobile-web-app-capable" content="yes">
  <link rel="icon" sizes="192x192" href="<c:url value='/resources/assets/i/app-icon72x72@2x.png'/>">
  <!-- Add to homescreen for Safari on iOS -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
  <link rel="apple-touch-icon-precomposed" href="<c:url value='/resources/assets/i/app-icon72x72@2x.png'/>">
  <!-- Tile icon for Win8 (144x144 + tile color) -->
  <meta name="msapplication-TileImage" content="<c:url value='/resources/assets/i/app-icon72x72@2x.png'/>">
  <meta name="msapplication-TileColor" content="#0e90d2">
  <link rel="stylesheet" href="<c:url value='/resources/css/amazeui.min.css'/>">
  <link rel="stylesheet" href="<c:url value='/resources/css/app.css'/>">
</head>
<body class="bgf7">
<header data-am-widget="header" class="am-header am-header-default">
  <div class="am-header-left am-header-nav"> <a href="" class="" title="返回上一步"></a> </div>
  <h1 class="am-header-title">商品信息终</h1>
  <div class="am-header-right am-header-nav">购买</div>
  <!--  <em class="line"></em>-->
</header>
<!--//End--header-->
<div data-am-widget="slider" class="am-slider am-slider-a1" data-am-slider='{"directionNav":false}'>
  <ul class="am-slides">
    <li><img src="<c:url value='/resources/upload/search-exp2.jpg'/>"></li>
    <%--<li><img src="upload/exp2.jpg"></li>--%>
    <%--<li><img src="upload/exp2.jpg"></li>--%>
    <%--<li><img src="upload/exp2.jpg"></li>--%>
    <%--<li><img src="upload/exp2.jpg"></li>--%>
  </ul>
</div>
<!--//End--轮播图-->
<div data-am-widget="list_news" class="am-list-news am-list-news-default cuslist">
  <!--列表标题-->
  <div class="am-list-news-bd">
    <ul class="am-list">
      <li class="am-g am-list-item-dated">
        <strong class="am-list-info">商品名称:</strong>
        <span class="am-list-info2">${product.name}</span>
      </li>
      <li class="am-g am-list-item-dated">
        <strong class="am-list-info">创  作  者:</strong>
        <span class="am-list-info2">${product.productSeries.tenant.name}</span>
      </li>
      <li class="am-g am-list-item-dated">
        <strong class="am-list-info">认证时间:</strong>
        <span class="am-list-info2"><fmt:formatDate value="${product.tenantCertification.theDate}" pattern="yyyy年MM月"/></span>
      </li>
      <%--<li class="am-g am-list-item-dated">--%>
        <%--<strong class="am-list-info">装裱尺寸:</strong>--%>
        <%--<span class="am-list-info2">100CM*128CM</span>--%>
      <%--</li>--%>
      <c:forEach items="${product.productSeries.productSeriesPropertyNameList}" var="propertyName"  varStatus="status">
        <c:forEach items="${product.productPropertyValueList}" var="propertyValue" begin="${status.index}" end="${status.index}">
          <li >${propertyName.name}:${propertyValue.value}</li>
        </c:forEach>
      </c:forEach>

      <%--<li class="am-g am-list-item-dated">--%>
        <%--<strong class="am-list-info">工       艺: :</strong>--%>
        <%--<span class="am-list-info2">刺绣-乱针绣</span>--%>
      <%--</li>--%>
      <%--<li class="am-g am-list-item-dated">--%>
        <%--<strong class="am-list-info">商品材质:</strong>--%>
        <%--<span class="am-list-info2">蚕丝、真丝纱</span>--%>
      <%--</li>--%>
      <%--<li class="am-g am-list-item-dated">--%>
        <%--<strong class="am-list-info">包       装:</strong>--%>
        <%--<span class="am-list-info2">锦盒</span>--%>
      <%--</li>--%>
      <%--<li class="am-g am-list-item-dated">--%>
        <%--<strong class="am-list-info">商品简介:</strong>--%>
        <%--<span class="am-list-info2">这是一幅视觉效果很强的刺绣作品。作者凭借着扎实的绘画功底，将画理与绣理相结合，以粗、细乱针结合平针的绣法自由灵动地刻画了人物的神态与动感，同时，创作者又巧妙地将丝线的光泽有机地融入了原画的笔触之中，因而使作品的光影和色彩表现得淋漓尽致。</span>--%>
      <%--</li>--%>
    </ul>
  </div>
</div>



<!--<div class="rzinfo">
	<ul>
		<li><strong>证书证书:</strong><p>国家级非物质文化遗产项目（苏绣）代表性传承人</p></li>
		<li><strong>认证机构:</strong><p>文化部.非物质文化遗产司认证中心</p></li>
		<li><strong>认证时间:</strong><p>2012年12月</p></li>
		<li><strong>认证结果:</strong><p>国家级非遗名录项目</p></li>
	</ul>
</div>-->


<script src="js/jquery.min.js"></script>
<script src="js/amazeui.min.js"></script>
<script type="text/javascript">
  $(function() {
    $('.am-slider-manual').flexslider({
      // options
    });
  });
</script>
</body>
</html>
