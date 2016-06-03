<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html class="no-js">
<head>
    <meta name="description" content="${masterNews.title}">
    <meta name="keywords" content="${masterNews.master.fullName}">
</head>

<body>
<!--内容-->
<!--资讯详情-->
<div class="wh">
    <div class="hd">
        <div id="page-nav">
            <p><a href="<c:url value="/"/>">首页</a><span id="zpxq-1"><a href="<c:url value="/info/list"/> ">资讯</a></span><span>${masterNews.title}</span></p>
        </div>
    </div>
</div>

<!--资讯详情页内容-->
<div style="width:100%;height:23px;"></div>
<div id="page-column-1">
  <h5>
    <c:forEach items="${masterNews.masterNewsTagList}" var="masterNewsTag">
      [${masterNewsTag.wordValue.value}]
    </c:forEach>
    ${masterNews.title}
  </h5>
  <div class="p"><fmt:formatDate value="${masterNews.createDateTime}" pattern="yyyy.MM.dd" />  来源:${masterNews.dataSource}</div>

  <div class="column-text-page">
      ${masterNews.content}
  </div>
</div>
</body>
</html>