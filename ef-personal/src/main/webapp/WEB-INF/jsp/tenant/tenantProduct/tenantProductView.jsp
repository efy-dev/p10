<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/16
  Time: 10:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
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
        <li><a href="${pageContext.request.contextPath}/tenant/tenantWorkShopList.do?tenantId=1"><img src="/scripts/assets/images/i/nav-gzf.gif"></a></li>
    </ul>
</div>
<tr>
  <td>${product.id}</td>
  <td>${product.name}</td>
  <td>${product.price}</td>
</tr>
</body>
</html>
