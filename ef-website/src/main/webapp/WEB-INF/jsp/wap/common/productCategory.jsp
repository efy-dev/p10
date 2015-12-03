<%@ page import="com.efeiyi.ec.website.organization.util.AuthorizationUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/12/2
  Time: 16:26
  To change this template use File | Settings | File Templates.
--%>
<!doctype html>
<html class="no-js">
<head>
  <title>分类导航</title>
</head>
<body>

<!--//End--header-->
<div class="b06-list ae">
  <c:forEach items="${categoryList}" var="category">
  <div class="list-q ae">
    <h5>${category.name}</h5>
    <ul class="b06-page ae">
      <c:forEach items="${projectMap.get(category.id)}" var="project">
      <li><a href="<c:url value="/product/list/${project.id}"/>"><img src="http://pro.efeiyi.com/${project.picture_wap_url}@!project-mobile-list"></a><p>${project.name}</p></li>
      </c:forEach>
      <%--<li><a href="#"><img src="<c:url value="/scripts/wap/upload/fl.png"/>"></a></li>--%>
    </ul>
  </div>
  </c:forEach>
</div>
</body>
</html>