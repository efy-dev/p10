<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<head>
    <title>非遗百科</title>
</head>
<body>
<div id="banner1">
  <div id="full-screen-slider">
    <ul id="slides">
      <c:if test="${!empty bannerList}">
        <c:forEach items="${bannerList}" var="banner">
          <li style="background:url(http://tenant.efeiyi.com/${banner.imageUrl}) no-repeat center top;width:100%;height:266px;">
            <a href="#"></a></li>
        </c:forEach>
      </c:if>
      <c:if test="${empty bannerList}">
        <li style="background:url(http://tenant.efeiyi.com/banner/20150725150117.jpg) no-repeat center top;width:100%;height:266px;">
          <a href="#"></a></li>
      </c:if>
    </ul>
  </div>
</body>
</html>
