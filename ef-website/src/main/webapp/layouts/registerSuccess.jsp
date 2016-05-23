<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.ming800.core.util.HttpUtil" %>
<%--<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>--%>
<html>
<head>
  <title><sitemesh:write property='title'/></title>
  <%
    if (HttpUtil.isPhone(request)) {
  %>
  <%@include file="mobileMainHeader.jsp" %>
  <%
  } else {
  %>
  <%@include file="pcMainHeader.jsp" %>
  <%
    }
  %>
  <sitemesh:write property='head'/>
</head>
<body>

<div class="topbar wh">
  <div class="hd">
    <ul class="ul-item">
      <%
        if (HttpUtil.isPhone(request)) {
      %>
      <%--导航--%>
      <header class="am-header custom-header">
        <div class="am-header-left am-header-nav">
          <a href="javascript:history.go(-1)" class="chevron-left"></a>
        </div>
        <!-- //End--chevron-left-->
        <h1 class="am-header-title">注册成功</h1>
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
      <%
      } else {
      %>
      <%
        if (AuthorizationUtil.getMyUser().getId() != null) {
      %>
      <li><a href="http://i.efeiyi.com" title="个人中心">个人中心</a></li>
      <li><a href="<c:url value='/j_spring_cas_security_logout'/>" title="退出">退出</a></li>
      <%
        }
      %>

      <%
        if (AuthorizationUtil.getMyUser().getId() == null) {
      %>
      <li><a href="<c:url value="/sso.do"/>" title="请登录">请登录</a></li>
      <li><a href="http://passport.efeiyi.com/register?service=http://mall.efeiyi.com/sso.do" title="快速注册">快速注册</a></li>
      <%
        }
      %>
      <%--<li><a href="" title="商家入驻">商家入驻</a></li>--%>
      <li class="btn-top-wechat">
        <a title="手机e飞蚁">手机e飞蚁</a>
        <span class="top-wechat"></span>
      </li>
      <li class="cart">
        <a href="<c:url value="/cart/view"/> " title="购物车"><i class="icon"></i>购物车</a>
        <span class="tips"><em id="cartAmount">0</em></span>
      </li>
    </ul>
  </div>
</div>

      <%
        }
      %>

    <%--<li><a href="" title="商家入驻">商家入驻</a></li>--%>

<%
  if (HttpUtil.isPhone(request)) {
%>
<sitemesh:write property='body'/>
<%
} else {
%>
<div class="wh">
  <sitemesh:write property='body'/>
</div>
<%
  }
%>

<%
  if (HttpUtil.isPhone(request)) {
%>
<%@include file="mobileFooter.jsp" %>
<%
} else {
%>
<%@include file="footer.jsp" %>
<%
  }
%>

</body>

</html>
