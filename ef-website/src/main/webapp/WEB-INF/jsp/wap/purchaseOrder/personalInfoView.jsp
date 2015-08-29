<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>0202个人中心</title>
</head>
<body>
<header class="am-header custom-header">
  <div class="am-header-left am-header-nav">
    <a href="<c:url value="/order/myEfeiyi/list.do"/>" class="chevron-left"></a>
  </div>
  <!-- //End--chevron-left-->
  <h1 class="am-header-title">个人信息</h1>
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
<div class="personal-material">
  <div class="personal">
    <div class="material">
      <strong><img src="<c:url value="/scripts/wap/assets/upload/yonghm.jpg"/>" alt="..." class="am-img-thumbnail"></strong>
    </div>
    <div class="personal-list">
      <form>
        <ul>
          <li>用户名 :<span>15110008479</span></li>
          <li>昵称 :<span>胖胖</span></li>
          <li>性别 :<span>女</span></li>
          <li>出生日期 :<span>2015-08-19</span></li>
        </ul>
      </form>
    </div>
  </div>
  <div class="edit-info">
    <a href="#">编辑信息</a>
  </div>
</div>
</body>
</html>
