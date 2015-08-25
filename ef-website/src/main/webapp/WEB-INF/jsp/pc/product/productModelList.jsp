<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/17
  Time: 9:34
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>品类首页新</title>
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
  <meta name="msapplication-TileImage" content="/scripts/assets/i/app-icon72x72@2x.png">
  <meta name="msapplication-TileColor" content="#0e90d2">
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/css/amazeui.min.css'/>">
  <link type="text/css" rel="stylesheet" href="<c:url value='/scripts/assets/css/app.css'/>">
</head>
<body>
<!-- //End--header-->
<div class="hd category">
  <div class="breadcrumb wh">
    <ol class="am-breadcrumb">
      <li><a href="#">首页</a></li>
      <li class="am-active">${proName}</li>
    </ol>
  </div>
  <!-- //End--breadcrumb-->
    <div class="explain">
        <img src="<c:url value='/scripts/assets/upload/t-banner.jpg'/>" alt=""/>
        <!--<div class="title">-->
        <!--<p class="wh"><span class="zh">she</span><span class="cn">歙</span></p>-->
        <!--<p class="wh"><span class="zh">yan</span><span class="cn">砚</span></p>-->
        <!--</div>-->
        <!--<div class="info">歙砚，全称歙州砚，中国四大名砚之一，与甘肃洮砚、广东端砚齐名。产于安徽黄山山脉与天目山、白际山之间的歙州，包括歙县、休宁、祁门、黟县、婺源等县。歙石的产地以婺源与歙县交界处的龙尾山（罗纹山）下溪涧为最优，所以歙砚又称龙尾砚，而龙尾山则是大部分存世歙砚珍品的石料出产地。除此之外，歙县、休宁县、祁门县亦产歙砚。</div>-->
        <!--<a href="" class="more" title="了解更多"><i class="icon"></i>了解更多</a>-->
    </div>
  <!-- //End--explain-->
  <div class="shop-sort wh">
      <ul class="link1">
          <li class="active"><a
                  href="<c:url value="/product/list/${project.id}?sort=desc:price&pageEntity.index=1"/>"
                  title="价  格">价 格</a></li>
          <%-- <li><a href="" title="销  售">销  售</a></li>
           <li><a href="" title="新  品">新  品</a></li>
           <li><a href="" title="人  气">人  气</a></li>--%>
      </ul>
  </div>
  <!-- //End--shop-sort-->

  <c:if test="${productModelList.size()>0}">
      <div class="list-pro">
        <ul class="ul-item">
          <c:forEach items="${productModelList}" var="productModel" varStatus="rec">
          <li>

            <a href="<c:url value="/product/category/${productModel.id}"/>" target="_blank" title="">
              <img  class="imgfilter" <c:url value="http://tenant.efeiyi.com/photo/20150728100546.jpg@!tenant-pc-tenant-list"/> alt=""/>
              <p class="wh name">${productModel.product.name}</p>
              <p class="wh price">${productModel.price}</p>
            </a>
          </li>
          </c:forEach>
        </ul>
        <!-- //End-->
      </div>
  </c:if>

 <div class="page wh">
      <ming800:pcPageList bean="${pageEntity}" url="/product/list/${project.id}">
      <ming800:pcPageParam name="sort"
                           value='<%=request.getParameter("sort")!=null ? request.getParameter("sort") : ""%>'/>
      </ming800:pcPageList>
  </div>

  <!-- //End--footer-->
</div>
<!--[if (gte IE 9)|!(IE)]><!-->
<script href="<c:url value='/scripts/assets/js/jquery.min.js'/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script href="<c:url value='http://libs.baidu.com/jquery/1.11.3/jquery.min.js'/>"></script>
<script href="<c:url value='http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js'/>"></script>
<script href="<c:url value='/scripts/assets/js/amazeui.ie8polyfill.min.js'/>"></script>
<![endif]-->

<script href="<c:url value='/scripts/assets/js/amazeui.min.js'/>"></script>
<script href="<c:url value='/scripts/assets/js/system.js'/>"></script>
</body>
</html>
