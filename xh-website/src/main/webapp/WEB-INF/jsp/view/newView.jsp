<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/29
  Time: 9:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html class="no-js">
<head>
  <title>新闻详情</title>
</head>
<body>
<div class="slide-right">
  <div class="slide-article">
    <div class="title">
      <h1>${document.title}</h1>
      <c:if test="${not empty document.name}">
        <span>发布人：${document.name}</span>
      </c:if>
      <c:if test="${not empty document.publishDate}">
        <span>发布日期：<fmt:formatDate value="${document.publishDate}" pattern="yyyy年MM月dd日"/></span>
      </c:if>
      <%--<span>阅读次数：5085次</span>--%>
    </div>
    <!-- //End---->
    <div class="article-con">
      ${document.documentContent.content}
    </div>
  </div>
</div>
<!--//End--home-->
</body>
</html>
