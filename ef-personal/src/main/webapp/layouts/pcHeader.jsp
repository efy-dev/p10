<!DocType html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="header">
    <h1><img src="<c:url value="/scripts/assets/images/logo1.gif"/>" alt="vlogo" class="logov"></h1>
    <div class="printing">${tenant.title}<span>  [<a href="#">木板水印</a>]</span></div>
    <ul class="register">
        <li class="register-page"><a href="#"><img src="<c:url value="/scripts/assets/images/i/wz1.gif"/>"></a></li>
       <%-- <li class="register-left"><a href="#"><img src="<c:url value="/scripts/assets/images/i/wz2.gif"/>"></a></li>
        <li class="register-right"><a href="#"><img src="<c:url value="/scripts/assets/images/i/wz3.gif"/>"></a></li>--%>
    </ul>
</div>
<div id="nav">
    <h1><a href="#"><img src="http://tenant.efeiyi.com/photo/2015-07-20%2014%3A41%3A29.jpg@!tenant-manage-banner"></a></h1>
    <ul class="nav-centent">
        <li><a href="${pageContext.request.contextPath}/tenant/${tenant.id}">首页</a></li>
        <li><a href="${pageContext.request.contextPath}/introduction/${tenant.id}">简介</a></li>
        <li><a href="${pageContext.request.contextPath}/work/listTenantWork.do?conditions=tenant.id:${tenant.id}">作品</a></li>
        <li><a href="${pageContext.request.contextPath}/info/listTenantInfo.do?conditions=tenant.id:${tenant.id}">资讯</a></li>
        <li><a href="${pageContext.request.contextPath}/workShop/${tenant.id}">工作坊</a></li>
    </ul>
</div>