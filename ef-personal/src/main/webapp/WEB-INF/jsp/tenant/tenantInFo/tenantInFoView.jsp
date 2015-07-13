<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/7
  Time: 13:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>
<html>
<head>
  <title>tenantInFo</title>
</head>
<body>
<h1>传承人资讯</h1>
<form name="product"  method="post">
  <table width="95%" align="center" cellpadding="10" cellspacing="0" border="1">
    <tr>
      <td>传承人资讯</td>
    </tr>
    <c:forEach items="${tenantInFo}" var="tenantinfo" >
      <tr>
        <td><input type="text" name="title" value="${tenantinfo.title}"/></td>
      </tr>
      <tr>
        <td><input type="text" name="content" value="${tenantinfo.content}"/></td>
      </tr>
    </c:forEach>
  </table>
</form>
</body>
</html>

