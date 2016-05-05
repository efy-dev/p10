<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/4/13
  Time: 17:38
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
  <title>工艺首页</title>
</head>
<body>
<div id="slide2016" class="slide2016">
  <div class="img">
    <div class="click prev"></div>
    <ul style="text-align: center">
      <c:forEach items="${pcBannerList}" var="banner" varStatus="status">
        <li>
          <a href="<c:url value="${banner.directUrl}"/> " target="_blank" title="非遗轮播图"><img
                  src="http://wiki-oss.efeiyi.com/${banner.imageUrl}" width="1920" height=""
                  alt="${banner.title}"/></a></li>
      </c:forEach>
      <div class="click next"></div>
    </ul>
  </div>
  <div class="num">
    <ul>
      <c:forEach items="${pcBannerList}" var="banner" varStatus="status">
        <li class=""></li>
      </c:forEach>
    </ul>
  </div>
</div>
<%--<div id="slide2016" class="slide2016">--%>
  <%--<div class="img">--%>
    <%--<div class="click prev"></div>--%>
    <%--<ul>--%>
      <%--<c:forEach items="${pcBannerList}" var="banner" varStatus="status">--%>
        <%--<li><a href="<c:url value="${banner.directUrl}"/>" title=""><img  src="http://pro.efeiyi.com/${banner.imageUrl}" width="1280" height="481" alt=""></a></li>--%>
      <%--</c:forEach>--%>
    <%--</ul>--%>
    <%--<div class="click next"></div>--%>
  <%--</div>--%>
  <%--<div class="num">--%>
    <%--<ul>--%>
      <%--<li class="active"></li>--%>
      <%--<li></li>--%>
      <%--<li></li>--%>
    <%--</ul>--%>
  <%--</div>--%>
<%--</div>--%>
<!--//End--slide2016-->
<div class="craft-list2016">
  <div class="craft-list">
    <div class="topic">
      <div class="bd-list"></div>
      <div class="topic-txt"><span>传统美术</span></div>
      <div class="bd-list"></div>
    </div>
    <ul class="list">
      <c:forEach items="${artRecommendList}" var="art" begin="0" end="7">
        <li>
          <a href="<c:url value="/project/${art.artistry.id}"/>">
            <img src="http://wiki-oss.efeiyi.com/${art.artistry.getMainPicture().pictureUrl}@!wiki-home-project-picture" alt="">
            <div class="list-content">
              <p class="name">${art.artistry.project.name}</p>
              <p class="title"> <ming800:status name="level" dataType="Project.level" checkedValue="${art.artistry.project.getLevel()}" type="normal"/>非遗项目</p>
            </div>
          </a>
        </li>
      </c:forEach>
    </ul>
  </div>
  <div class="craft-list">
    <div class="topic">
      <div class="bd-list"></div>
      <div class="topic-txt"><span>非遗技艺</span></div>
      <div class="bd-list"></div>
    </div>
    <ul class="list">
      <c:forEach items="${craftRecommendList}" var="craft" begin="0" end="7">
      <li>
        <a href="<c:url value="/project/${craft.artistry.id}"/>">
          <img src="http://wiki-oss.efeiyi.com/${craft.artistry.getMainPicture().pictureUrl}@!wiki-home-project-picture" alt="">
          <div class="list-content">
            <p class="name">${craft.artistry.project.name}</p>
            <p class="title"> <ming800:status name="level" dataType="Project.level" checkedValue="${craft.artistry.project.getLevel()}" type="normal"/>非遗项目</p>
          </div>
        </a>
      </li>
      </c:forEach>
    </ul>
  </div>
</div>
<!--//End--craft2016-->

<!--[if (gte IE 9)|!(IE)]><!-->
<script src="shop2016/js/jquery.min.js"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->



<script src="shop2016/js/system.js"></script>
</body>
</html>

