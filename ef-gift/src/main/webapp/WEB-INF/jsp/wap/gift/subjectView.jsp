<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<title>${title}</title>
<style>
#h5img img {width:100%;height:100%}
</style>
</head>
<body>
<header id="header" class="am-header custom-header newheader">
    <div class="am-header-left am-header-nav">
        <a href="javascript:history.go(-1)" class="chevron-left"></a>
    </div>
    <!-- //End--chevron-left-->
    <h1 class="am-header-title">${title}</h1>
    <!-- //End--title-->
    <div class="am-header-right am-header-nav">
        <a href="#chevron-right" class="chevron-right" id="menu">
            <i class="line"></i>
        </a>
    </div>
    <div class="menu-list">
        <ul class="bd">
            <li><a href="http://j.efeiyi.com/ef-gift" title="礼品首页">礼品首页</a></li>
        </ul>
    </div>
</header>
<div id="h5img">
  <c:if test="${subject.subjectDescription.content != null && subject.subjectDescription.content != ''}">
    ${subject.subjectDescription.content}
  </c:if>
</div>
</body>
</html>
