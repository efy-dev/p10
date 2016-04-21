<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head></head>
<body>
<div class="wh">
  <div class="coupons">
    <div class="promptly">
      <a href="<c:url value="/coupon/getCouponView.do?couponBatchId=${couponBatchId}"/>" class="btn">立&nbsp;即&nbsp;领&nbsp;取</a>
    </div>
  </div>
</div>
</body>
</html>
