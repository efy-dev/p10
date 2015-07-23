<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!doctype html>
<html class="no-js">
<head></head>
<body>
<!--内容-->
<!--资讯详情-->
<div id="page-nav">
  <p><a href="#">首页</a><span>资讯</span></p>
</div>
<div class="border-nav"></div>
<!--资讯详情页内容-->
<div style="width:100%;height:23px;"></div>
<div id="page-column-1">
  <h5>[]${tenantNews.title}</h5>
  <div class="p"><fmt:formatDate value="${tenantNews.createDateTime}" pattern="yyyy.MM.dd" />  来源:${tenantNews.dataSource}</div>

  <div class="column-text-page">
      ${tenantNews.content}
  </div>
</div>
</body>
</html>