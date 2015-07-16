<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/7
  Time: 13:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <title>tenantInFo</title>
</head>
<body>
<div id="header">
    <h1><img src="/scripts/assets/images/logo1.gif" alt="vlogo" class="logov"></h1>
    <div class="printing">国家级非物质文化遗产传承人<span>  [<a href="#">木板水印</a>]</span></div>
    <ul class="register">
        <li class="register-page"><a href="#"><img src="/scripts/assets/images/i/wz1.gif"></a></li>
        <li class="register-left"><a href="#"><img src="/scripts/assets/images/i/wz2.gif"></a></li>
        <li class="register-right"><a href="#"><img src="/scripts/assets/images/i/wz3.gif"></a></li>
    </ul>
</div>
<div id="nav">
    <h1><a href="#"><img src="/scripts/assets/images/logo2.gif"></a></h1>
    <ul class="nav-centent">
        <li><a href="${pageContext.request.contextPath}/tenant/getTenant.do?tenantId=1"><img src="/scripts/assets/images/i/nav-sy.gif"></a></li>
        <li><a href="${pageContext.request.contextPath}/tenant/tenantIntroductionList.do?tenantId=1"><img src="/scripts/assets/images/i/nav-jj.gif"></a></li>
        <li><a href="${pageContext.request.contextPath}/tenant/tenantProductList.do?tenantId=1"><img src="/scripts/assets/images/i/nav-zp.gif"></a></li>
        <li><a href="${pageContext.request.contextPath}/tenant/tenantInfoList.do?tenantId=1"><img src="/scripts/assets/images/i/nav-zx.gif"></a></li>
        <li><a href="${pageContext.request.contextPath}/tenant/getTenantWorkShop.do?tenantId=1"><img src="/scripts/assets/images/i/nav-gzf.gif"></a></li>
    </ul>
</div>
<form name="product"  method="post">
  <table align="center" cellpadding="10" cellspacing="0" border="1">
    <tr>
      <td>传承人资讯</td>
    </tr>
    <c:forEach items="${tenantInfo}" var="tenantinfo" >
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

