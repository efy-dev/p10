<%@ page import="com.efeiyi.ec.website.base.util.AuthorizationUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>

  <title>打开领券地址-立即领取</title>

</head>

<body>
<header class="am-header custom-header">
  <div class="am-header-left am-header-nav">
    <a href="javascript:history.go(-1)" class="chevron-left"></a>
  </div>
  <!-- //End--chevron-left-->
  <h1 class="am-header-title">打开领券地址-立即领取</h1>
  <!-- //End--title-->
  <div class="am-header-right am-header-nav">
    <a href="#chevron-right" class="chevron-right" id="menu">
      <i class="line"></i>
    </a>
  </div>
  <!-- //End--chevron-left-->
  <div class="menu-list">
    <ul class="bd">
      <li><a href="http://www.efeiyi.com" title="首页">首页</a></li>
      <li><a href="<c:url value="/cart/view"/> " title="购物车">购物车</a></li>
      <% if (AuthorizationUtil.isAuthenticated()) {%>
      <li><a href="http://i.efeiyi.com" title="个人中心">个人中心</a></li>
      <%} else {%>
      <li><a href="<c:url value="/sso.do"/>" title="个人中心">个人中心</a></li>
      <%}%>
      <li><a href="<c:url value="/productCategory.do"/> " title="分类">分类</a></li>
    </ul>
  </div>
</header>
<!--//End--header-->
<div class="coupon-sc">
  <div class="cont">
    <div class="tc-txt">

      <a href="<c:url value="/coupon/getCouponView.do?couponBatchId=${couponBatchId}"/>" class="btn">立即领取</a>
    </div>
  </div>
</div>
<script src="<c:url value="/scripts/wap/js/system.js?"/>"></script>
</body>
</html>