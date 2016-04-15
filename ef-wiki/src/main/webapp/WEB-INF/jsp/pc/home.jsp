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
  <c:if test="${not empty pcBannerList}">
  <div id="slide2016" class="slide2016">
  <div class="img">
    <ul>
      <c:forEach items="${pcBannerList}" var="banner" varStatus="status">
        <li><a href="<c:url value="${banner.directUrl}"/>" title=""><img  src="http://wiki-oss.efeiyi.com/${banner.imageUrl}@!wiki-pc-banner" alt=""></a></li>
      </c:forEach>
    </ul>
  </div>
  <div class="num">
    <ul>
      <c:forEach items="${pcbannerList}" var="banner" varStatus="status">
      <li class=""></li>
      </c:forEach>
    </ul>
  </div>
</div>
  </c:if>
<!--//End--slide2016-->
<div class="craft-list2016">
  <div class="craft-list">
    <div class="topic">
      <div class="bd-list"></div>
      <div class="topic-txt"><span>传统技艺</span></div>
      <div class="bd-list"></div>
    </div>
    <ul class="list">
      <c:forEach items="${craftList}" var="craft">
      <li>
        <a href="<c:url value="/project/${craft.project.id}"/>">
          <img src="http://wiki-oss.efeiyi.com/${craft.project.picture_pc_url}@!wiki-home-project-picture" alt="">
          <div class="list-content">
            <p class="name">${craft.project.name}</p>
            <p class="title"> <ming800:status name="level" dataType="Project.level" checkedValue="${craft.getProject().getLevel()}" type="normal"/>非遗项目</p>
          </div>
        </a>
      </li>
      </c:forEach>
    </ul>
  </div>
  <div class="craft-list">
    <div class="topic">
      <div class="bd-list"></div>
      <div class="topic-txt"><span>传统美术</span></div>
      <div class="bd-list"></div>
    </div>
    <ul class="list">
      <c:forEach items="${artList}" var="art">
        <li>
          <a href="<c:url value="/project/${art.project.id}"/>">
            <img src="http://wiki-oss.efeiyi.com/${art.project.picture_pc_url}@!wiki-home-project-picture" alt="">
            <div class="list-content">
              <p class="name">${art.project.name}</p>
              <p class="title"> <ming800:status name="level" dataType="Project.level" checkedValue="${art.getProject().getLevel()}" type="normal"/>非遗项目</p>
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

