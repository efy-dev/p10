<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/29
  Time: 20:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html class="no-js">
<head>
  <title>申报查询</title>
</head>
<body>
<div class="slide-right">
  <div class="title-hide">申报查询</div>
  <div class="div-list" id="div-list">
    <div class="div-tab-btn">
      <span class="active">传承人<i class="icon"></i></span>
      <span>项目<i class="icon"></i></span>
    </div>
    <div class="div-tab-box">
      <form action="<c:url value='/protection/protection.checkDeclareState.do'/>" method="post">
        <span>传承人姓名</span>
        <input type="hidden" name="type" value="masterApply">
        <input type="text" class="txt" name="name" placeholder="传承人姓名" required/>
        <input type="submit" class="btn" value="查询"/>
      </form>
    </div>
    <!-- //End--传承人-->
    <div class="div-tab-box">
      <form action="<c:url value='/protection/protection.checkDeclareState.do'/>" method="post">
        <span>项目名称</span>
        <input type="hidden" name="type" value="projectApply">
        <input type="text" class="txt" name="name" placeholder="项目名称" required/>
        <input type="submit" class="btn" value="查询"/>
      </form>
    </div>
    <!-- //End--项目-->
  </div>
</div>
</body>
</html>
