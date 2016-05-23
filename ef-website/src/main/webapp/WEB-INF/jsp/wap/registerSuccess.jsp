<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix=
                   "ming800" uri="http://java.ming800.com/taglib" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<body>
<!--//End--header-->
<div class="m-successful ae">
    <c:set var="user">
        ${user.getUsername()}
    </c:set>
    <h5>恭喜您已经注册成功</h5>

    <p>新用户注册送${couponAmount}张优惠券，已发放！</p>

    <div class="kbtn">
        <a href="http://mall.efeiyi.com">去首页</a>
        <a href="http://i.efeiyi.com/coupon/list">查看优惠券</a>
    </div>
</div>
</body>
</html>