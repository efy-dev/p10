<!doctype html>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="no-js">
<head></head>
<body style="background-color:#F1F5F8">
<header class="work-details">
  <div class="work-details-i"><a href="<c:url value="/work/listTenantWork"/>"><img src="<c:url value="/scripts/assets/wap/images/logo10.gif"/>"></a></div>
</header>
<h1>${product.name}</h1>
<section class="work-text-h1">
  <p>
    <img src="http://tenant.efeiyi.com/${product.picture_url}"/>

    <span>${product.productDescription.content}</span>
  </p>
</section>
</body>
</html>