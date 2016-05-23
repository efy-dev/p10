<%@ page import="com.efeiyi.ec.website.base.util.AuthorizationUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>

	<title>打开领券地址-领取成功</title>

</head>
<body>
<header class="am-header custom-header">
	<div class="am-header-left am-header-nav">
		<a href="javascript:history.go(-1)" class="chevron-left"></a>
	</div>
	<!-- //End--chevron-left-->
	<h1 class="am-header-title">打开领券地址</h1>
	<!-- //End--title-->
	<div class="am-header-right am-header-nav">
		<a href="#chevron-right" class="chevron-right" id="menu">
			<i class="line"></i>
		</a>
	</div>
	<!-- //End--chevron-left-->
	<div class="menu-list">
		<ul class="bd">
			<li><a href="http://mall.efeiyi.com" title="首页">首页</a></li>
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

<div class="coupon-sc">

	<div class="cont">
		<c:if test="${yhq!=null && yhq!='used'}">
			<div class="tc-txt tc-txt2">
				<i class="c-pic"></i>
				<c:set var="price" value="${yhq.couponBatch.price}"/>
				<p class="text">恭&nbsp;喜&nbsp;您&nbsp;获&nbsp;得&nbsp;${fn:substringBefore(price, ".")}&nbsp;元&nbsp;现&nbsp;金&nbsp;券</p>

				<div class="ae"><a href="http://mall.efeiyi.com" class="but act">返回首面</a></div>
				<div class="ae"><a href="http://i.efeiyi.com/coupon/list?cf=4" class="but">查看我的优惠券</a></div>
			</div>
		</c:if>
		<c:if test="${yhq==null || yhq=='used'}">
			<div class="tc-txt">
				<i class="s-pic"></i>
				<c:if test="${yhq==null}">
					<p class="text">没有找到该链接的活动</p>
				</c:if>
				<c:if test="${yhq=='used'}">
					<p class="text">您已经领取过该优惠券了呦</p>
				</c:if>
				<div class="ae"><a href="http://mall.efeiyi.com" class="but act">返回e飞蚁首页</a></div>
			</div>
		</c:if>
	</div>
</div>
<script src="<c:url value="/scripts/wap/js/system.js?"/>"></script>

</body>
</html>