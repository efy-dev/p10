<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>

  <title>打开领券地址-立即领取</title>

</head>
<body>
<!--//End--header-->
<div class="coupon-sc">
  <div class="cont">
    <div class="tc-txt">

      <a href="<c:url value="/getYhq.do?couponBatchId=${couponBatchId}"/>" class="btn">立即领取</a>
    </div>
  </div>
</div>

</body>
</html>