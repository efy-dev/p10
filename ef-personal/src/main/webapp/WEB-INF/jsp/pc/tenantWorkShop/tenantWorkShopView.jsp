<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
</head>
<!--工作坊-->
<body>
<div id="page-nav">
  <p><a href="<c:url value="/"/>">首页</a><span>工作坊</span></p>
</div>
<div class="border-nav"></div>
<c:if test="${productWorkShop != null}">
    <div id="center--1">
          <div class="center-buttom-1"></div>
          <div class="center-right">
                <div class="video-or-img">
                  <video src="http://ef-video.oss-cn-beijing.aliyuncs.com/%E4%BA%92%E8%81%94%E7%BD%91%E8%A7%86%E9%A2%913.mp4" content="content" preload="auto" controls="controls"></video>
                </div>
                <div class="content-img">
                  <img src="<c:url value="${productWorkShop.picture_url}"/>">
                </div>
                <div class="content-text-gzf">
                  ${productWorkShop.shopIntroduction}
                </div>
          </div>
    </div>
</c:if>
</body>
</html>