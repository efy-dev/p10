<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html class="no-js">
<head></head>
<body>
<!--内容-->
<!--资讯详情-->
<div id="page-nav">
  <p><a href="<c:url value="/"/>">首页</a><span id="zpxq-1"><a href="<c:url value="/info/listTenantInfo.do"/> ">资讯</a></span><span>${tenantNews.title}</span></p>
</div>
<div class="border-nav"></div>
<!--资讯详情页内容-->
<div style="width:100%;height:23px;"></div>
<div id="page-column-1">
  <h5>
    <c:forEach items="${tenantNews.tenantNewsTagList}" var="tenantNewsTag">
      [${tenantNewsTag.wordValue.value}]
    </c:forEach>
    ${tenantNews.title}
  </h5>
  <div class="p"><fmt:formatDate value="${tenantNews.createDateTime}" pattern="yyyy.MM.dd" />  来源:${tenantNews.dataSource}</div>

  <div class="column-text-page">
      ${tenantNews.content}
  </div>
</div>
</body>
</html>