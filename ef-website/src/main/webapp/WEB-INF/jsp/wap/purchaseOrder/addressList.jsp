<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理收货地址</title>
</head>
<body>
<header class="am-header custom-header">
  <div class="am-header-left am-header-nav">
    <a href="<c:url value="/order/myEfeiyi/list.do"/>" class="chevron-left"></a>
  </div>
  <!-- //End--chevron-left-->
  <h1 class="am-header-title">地址管理</h1>
  <!-- //End--title-->
  <div class="am-header-right am-header-nav">
    <a href="#chevron-right" class="chevron-right" id="menu">
      <i class="line"></i>
    </a>
  </div>
  <!-- //End--chevron-left-->
  <div class="menu-list">
    <ul class="bd">
      <li><a href="" title="首页">首页</a></li>
      <li><a href="" title="分类">分&nbsp;类</a></li>
      <li class="active"><a href="" title="购物车">购&nbsp;物&nbsp;车</a></li>
      <li><a href="" title="传承人">传承人</a></li>
      <li><a href="" title="个人中心">个&nbsp;人&nbsp;中&nbsp;心</a></li>
    </ul>
  </div>
</header>
<!--//End--header-->
<div class="manage">
  <div class="manage-list">
    <!--一个地址-->
    <div class="list-one">
      <div class="head-list">
        <strong>温群英</strong>
        <span>15110008479</span>
      </div>
      <div class="content-list">
        <p>北京市朝阳区酒仙桥东路电子城科技园</p>
      </div>
      <ul class="botton-list">
        <li><a href="#">删除</a></li>
        <li><a href="#">编辑</a></li>
      </ul>
    </div>
    <!--一个地址-->
    <!--一个地址-->
    <div class="list-one">
      <div class="head-list">
        <strong>温群英</strong>
        <span>15110008479</span>
      </div>
      <div class="content-list">
        <p>北京市朝阳区酒仙桥东路电子城科技园</p>
      </div>
      <ul class="botton-list">
        <li><a href="#">删除</a></li>
        <li><a href="#">编辑</a></li>
      </ul>
    </div>
    <!--一个地址-->
    <!--一个地址-->
    <div class="list-one">
      <div class="head-list">
        <strong>温群英</strong>
        <span>15110008479</span>
      </div>
      <div class="content-list">
        <p>北京市朝阳区酒仙桥东路电子城科技园</p>
      </div>
      <ul class="botton-list">
        <li><a href="/myEfeiyi/removeAddress.do?addressId=${address.id}">删除</a></li>
        <li><a href="/myEfeiyi/addAddress.do/${address.id}">编辑</a></li>
      </ul>
    </div>
    <!--一个地址-->
  </div>
  <div class="edit-info">
    <a href="/myEfeiyi/addAddress.do/">新增地址</a>
  </div>
</div>
</body>
</html>
