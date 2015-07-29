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
    <div id="center--1">
          <div class="center-buttom-1"></div>
          <div class="center-right">
              <c:if test="${workShop != null}">
                <div class="video-or-img">
                  <video src="http://tenant.img-cn-beijing.aliyuncs.com/${workShop.videoPath}" content="content" preload="auto" controls="controls"></video>
                </div>
              </c:if>
                <div class="content-img">
                  <img src="http://tenant.efeiyi.com/${workShop.picture_url}@!tenant-manage-work-view">
                </div>
                <div class="content-text-gzf">
                  ${workShop.shopIntroduction}
                </div>
          </div>
    </div>
</body>
</html>