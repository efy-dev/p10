<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<head>
    <title>非遗百科</title>
</head>
<body>
<div id="center-panel">
  <div id="full-screen-slider">
    <ul id="slides">
      <c:if test="${!empty bannerList}">
        <c:forEach items="${bannerList}" var="banner">
          <li style="background:url(http://tenant.efeiyi.com/${banner.imageUrl}) no-repeat center top;width:80%;height:266px;">
            <a href="#"></a></li>
        </c:forEach>
      </c:if>
      <c:if test="${empty bannerList}">
        <li style="background:url(http://tenant.efeiyi.com/banner/20150725150117.jpg) no-repeat center top;width:80%;height:266px;">
          <a href="#"></a></li>
      </c:if>
    </ul>
  </div>
  <div>
    <span><h3>非遗项目</h3></span>
    <div>
    <ul style="margin: 0;padding: 0">
      <c:if test="${!empty projectList}">
        <c:forEach items="${projectList}" var="project">
          <li style="float: left;margin-left: 10px"><a href="#">${project.name}</a></li>
        </c:forEach>
      </c:if>
    </ul>

    </div>
  </div>
  <div><br>
    <div style="float:left;margin-top: 20px" >
      <span><h3>精彩非遗项目</h3></span>
       <div style="float:left;margin-top: 20px">
         <div><img src="http://tenant.efeiyi.com/${bannerList[0].imageUrl}"></div>
         <div style="float: left"></div>

      <div style="float:right;margin-top:20px">
      <ul style="margin:0px;padding: 5px">
        <img src=""/>
        <c:if test="${!empty wondenfulProjectList}">
          <c:forEach items="${wondenfulProjectList}" var="wproject">
            <li style="float: left;margin-left: 10px"><a href="#"><img src="" onmouseover=""/>${project.name}</a></li>
          </c:forEach>
        </c:if>
        <c:if test="${!empty wondenfulProjectList}">

          <li style="background:url(http://tenant.efeiyi.com/${requestScope.bannerList[0].imageUrl}) no-repeat; width:25px;height:25px;float: left"> <a href="#"></a></li>
          <li style="background:url(http://tenant.efeiyi.com/${requestScope.bannerList[0].imageUrl}) no-repeat; width:25px;height:25px;float: left"><a href="#"></a></li>
          <li style="background:url(http://tenant.efeiyi.com/${requestScope.bannerList[0].imageUrl}) no-repeat; width:25px;height:25px;float: left"><a href="#"></a></li>
          <li style="background:url(http://tenant.efeiyi.com/${requestScope.bannerList[0].imageUrl}) no-repeat; width:25px;height:25px;float: left"><a href="#"></a></li>
          <li style="background:url(http://tenant.efeiyi.com/${requestScope.bannerList[0].imageUrl}) no-repeat; width:25px;height:25px;float: left"><a href="#"></a></li>
          <li style="background:url(http://tenant.efeiyi.com/${requestScope.bannerList[0].imageUrl}) no-repeat; width:25px;height:25px;float: left"><a href="#"></a></li>

        </c:if>
      </ul>
      </div>
    </div>
    <div style="float: left;margin-top: 20px;margin-left: 200px">
     <span><h3>非遗项目代表性传承人</h3></span>
      <div></div>
    </div>
  </div>
  </div>
</div>
<div id="right-panel">

</div>
</body>

</html>
