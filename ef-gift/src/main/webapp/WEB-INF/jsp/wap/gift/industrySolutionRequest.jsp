<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
  <title>礼品频道-方案咨询</title>
</head>
<body>
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
      <input type="text" class="txt" name="number" required>
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