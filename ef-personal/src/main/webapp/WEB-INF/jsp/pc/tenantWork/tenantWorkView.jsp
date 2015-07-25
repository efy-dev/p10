<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
</head>
<body>
<!--作品详情-->
<div id="page-nav">
  <p><a href="${pageContext.request.contextPath}/tenant/ten">首页</a><span id="zpxq-1"><a href="${pageContext.request.contextPath}/tenantWork/listTenantWork.do?conditions=tenant.id:${product.tenant.id}">作品</a></span><span>${product.name}</span></p>
</div>
<div class="border-nav"></div>
<div id="center--1">
  <div class="center-buttom-1"></div>
  <div class="center-right">
    <div class="content-border">
      <dl class="right-content">
        <dt class="right-content-img"><img src="<c:url value="${product.picture_url}"/>"></dt>
        <dd class="right-content-p">
          ${product.productDescription.content}
        </dd>
      </dl>
      <div class="right-border"></div>
    </div>
  </div>
</div>
<!--其他内容-->
</body>
</html>