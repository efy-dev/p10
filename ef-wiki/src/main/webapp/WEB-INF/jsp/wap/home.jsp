<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/4/14
  Time: 14:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>工艺</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <link rel="stylesheet" href="<c:url value="/scripts/assets/wap/css/amazeui.min.css?t=20160413"/>">
  <link rel="stylesheet" href="<c:url value="/scripts/assets/wap/css/craft.css?t=20160413"/>">
</head>
<body>
<div class="craft">
  <div data-am-widget="slider" class="am-slider am-slider-a4 img-slider" data-am-slider='{&quot;directionNav&quot;:false}' >
    <ul class="am-slides">
      <c:forEach items="${wapBannerList}" var="banner">
      <li>
        <a href="<c:url value="${banner.directUrl}"/>" title=""><img src="http://wiki-oss.efeiyi.com/${banner.imageUrl}@!wiki-wap-banner" alt=""></a>
      </li>
      </c:forEach>
    </ul>
  </div>
  <!--//End--轮播图-->
  <div class="list bd">
    <div class="title">传统美术</div>
    <ul class="ul-col-2">
      <c:forEach items="${artList}" var="art">
      <li>
        <a href="" title="">
          <img src="http://wiki-oss.efeiyi.com/${art.project.picture_pc_url}@!wiki-project-picture" alt="">
                    <span class="txt">
                        <p>${art.project.name}</p>
                        <p><ming800:status name="level" dataType="Project.level" checkedValue="${art.getProject().getLevel()}" type="normal"/>非遗项目</p>
                    </span>
        </a>
      </li>
      </c:forEach>
    </ul>
  </div>
  <!--//End--传统美术-->
  <div class="list bd">
    <div class="title">传统技艺</div>
    <ul class="ul-col-2">
      <c:forEach items="${craftList}" var="craft">
      <li>
        <a href="" title="">
          <img src="http://wiki-oss.efeiyi.com/${craft.project.picture_pc_url}@!wiki-work-picture"  alt="">
                    <span class="txt">
                        <p>${craft.project.name}</p>
                        <p><ming800:status name="level" dataType="Project.level" checkedValue="${craft.getProject().getLevel()}" type="normal"/>非遗项目</p>
                    </span>
        </a>
      </li>
      </c:forEach>
    </ul>
  </div>
  <!--//End--传统技艺-->

</div>

<script src="<c:url value="/scripts/assets/wap/js/jquery.min.js"/>"></script>
<script src="<c:url value="/scripts/assets/wap/js/amazeui.min.js"/>"></script>
<script src="<c:url value="/scripts/assets/wap/js/system.js"/>"></script>
</body>
</html>
