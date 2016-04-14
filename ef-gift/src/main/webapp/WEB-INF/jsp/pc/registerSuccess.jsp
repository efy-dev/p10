<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
</head>
<body>
<!-- //End--topbar-->
<div class="header wh">
  <div class="hd">
    <div class="logo"><a herf="#">
      <span  class="myod-logo"></span>
      <span class="myod-text6"></span>
    </a></div>
  </div>
</div>
<!-- //End--header-->
<div class="wh">
  <div class="successful">
    <c:set var="user">
      ${user.getUsername()}
    </c:set>
    <h5>恭喜您已经注册成功</h5>
    <p>新用户注册送${couponAmount}张优惠券，已发放到您的账户</p>
    <div class="btn-q">
      <a href="http://www.efeiyi.com" class="but1">去购物</a>
      <a href="http://i.efeiyi.com/coupon/list" class="but2">去查看</a>
    </div>
    <p><span>您的手机号会显示到页面顶部和商品评价等位置，如不希望暴露，建议您修改昵称。</span></p>
  </div>
</div>
<!-- //End--footer-->
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="<c:url value='/scripts/js/jquery.min.js'/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="<c:url value='/scripts/js/amazeui.min.js'/>"></script>
<script src="<c:url value='/scripts/js/system.js'/>"></script>
<script src="<c:url value='/scripts/js/myorder.js'/>"></script>
<%--<script type='text/javascript'>--%>

  <%--$().ready(function(){--%>
    <%--$("#test").hide();--%>
  <%--})--%>
<%--</script>--%>


</body>
</html>
