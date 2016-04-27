<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>礼品频道-方案咨询</title>
  <link rel="stylesheet" href="<c:url value="/scripts/wap/css/amazeui.min.css"/>">
  <link rel="stylesheet" href="<c:url value="/scripts/wap/css/layout.css"/>">
  <link rel="stylesheet" href="<c:url value="/scripts/wap/css/gift.css"/>">
</head>
<body>
<div class="gift gift-ask">
  <form action="<c:url value="/submitIndustrySolutionRequest.do"/>" method="post">
    <div class="area">
      <div class="bd title">您的姓名</div>
      <input type="text" class="txt" name="name">
    </div>
    <div class="area">
      <div class="bd title">联系方式</div>
      <input type="text" class="txt" name="tel">
    </div>
    <div class="area">
      <div class="bd title">需求描述</div>
      <textarea type="text" class="txt" placeholder="详细描述礼品品类，送礼场合，包装，单价范围等。" name="description"></textarea>
    </div>
    <div class="area">
      <div class="bd title">需求数量</div>
      <input type="text" class="txt" name="number">
    </div>

    <div class="btns">
      <input class="submit" type="submit" value="提交">
      <input class="cancel" type="button" value="取消">
    </div>

    <div class="tels">咨询热线：4008768766</div>
  </form>
</div>


<script src="<c:url value="/scripts/wap/js/jquery.min.js"/>"></script>
<script src="<c:url value="/scripts/wap/js/amazeui.min.js"/>"></script>
<script src="<c:url value="/scripts/wap/js/system.js"/>"></script>
</body>
</html>