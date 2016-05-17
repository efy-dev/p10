<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
  <title>礼品频道-方案咨询</title>
</head>
<body>
<header id="header" class="am-header custom-header newheader">
  <div class="am-header-left am-header-nav">
    <a href="javascript:history.go(-1)" class="chevron-left"></a>
  </div>
  <!-- //End--chevron-left-->
  <h1 class="am-header-title">方案咨询</h1>
  <!-- //End--title-->
  <div class="am-header-right am-header-nav">
    <a href="#chevron-right" class="chevron-right" id="menu">
      <i class="line"></i>
    </a>
  </div>
  <div class="menu-list">
    <ul class="bd">
      <li><a href="http://j.efeiyi.com/ef-gift" title="礼品首页">礼品首页</a></li>
    </ul>
  </div>
</header>
<div class="gift gift-ask">
  <form action="<c:url value="/submitIndustrySolutionRequest"/>" method="post">
    <div class="area">
      <div class="bd title">您的姓名</div>
      <input type="text" class="txt" name="userName" required>
    </div>
    <div class="area">
      <div class="bd title">联系方式</div>
      <input type="text" class="txt" name="tel" required>
    </div>
    <div class="area">
      <div class="bd title">需求描述</div>
      <textarea type="text" class="txt" placeholder="详细描述礼品品类，送礼场合，包装，单价范围等。" name="description" required></textarea>
    </div>
    <div class="area">
      <div class="bd title">需求数量</div>
      <input type="text" class="txt" name="number" required onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')">
    </div>

    <div class="btns">
      <input class="submit" type="submit" value="提交">
      <input class="cancel" type="button" value="取消">
    </div>

    <div class="tels">咨询热线：4008768766</div>
  </form>
</div>
</body>
</html>