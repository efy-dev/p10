<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 14:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>

<html>
<head>
    <script src="<c:url value="/scripts/jquery-1.11.1.min.js"/>"></script>
    <title></title>
</head>
<body>
<table>
  <tr>
    <td>传承人新闻id</td>
    <td>传承人新闻title</td>
  </tr>

  <c:forEach items="${requestScope.pageInfo.list}" var="tenantNews">
    <tr>
      <td>${tenantNews.id}</td>
      <td>${tenantNews.title}</td>
    </tr>
  </c:forEach>
</table>
<div style="clear: both">
  <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="/basic/xm.do">
    <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
    <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
  </ming800:pcPageList>
</div>
</body>
</html>
