<%@ page import="com.efeiyi.ec.website.organization.util.AuthorizationUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/12/2
  Time: 16:26
  To change this template use File | Settings | File Templates.
--%>
<!doctype html>
<html class="no-js">
<head>
  <title>分类导航</title>
</head>
<body>
<header class="am-header custom-header newheader">
  <div class="am-header-left am-header-nav">
    <a href="javascript:history.go(-1)" class="chevron-left"></a>
  </div>
  <!-- //End--chevron-left-->
  <div class="newsearch">
    <form>
      <input class="newsebox" placeholder="茶叶罐">
      <input type="submit" class="newsebut" value="搜">
    </form>
  </div>
  <!-- //End--title-->
  <div class="am-header-right am-header-nav">
    <a href="#chevron-right" class="chevron-right" id="menu">
      <i class="line"></i>
    </a>
  </div>
  <div class="menu-list">
    <ul class="bd">
      <li><a href="http://www.efeiyi.com" title="首页">首页</a></li>
      <li><a href="<c:url value="/cart/view"/> " title="购物车">购物车</a></li>
      <% if (AuthorizationUtil.isAuthenticated()) {%>
      <li><a href="http://i.efeiyi.com" title="个人中心">个人中心</a></li>
      <%} else {%>
      <li><a href="<c:url value="/sso.do"/>" title="个人中心">个人中心</a></li>
      <%}%>
      <li><a href="http://master.efeiyi.com" title="分类">传承人</a></li>
    </ul>
  </div>
</header>
<!--//End--header-->
<div class="b06-list ae">
  <c:forEach items="${categoryList}" var="category">
  <div class="list-q ae">
    <h5>${category.name}</h5>
    <ul class="b06-page ae">
      <c:forEach items="${projectMap.get(category.id)}" var="project">
      <li><a href="<c:url value="/product/list/${project.id}"/>"><img src="http://pro.efeiyi.com/${project.picture_wap_url}"></a><p>${project.name}</p></li>
      </c:forEach>
      <%--<li><a href="#"><img src="<c:url value="/scripts/wap/upload/fl.png"/>"></a></li>--%>
    </ul>
  </div>
  </c:forEach>
</div>
</body>
</html>