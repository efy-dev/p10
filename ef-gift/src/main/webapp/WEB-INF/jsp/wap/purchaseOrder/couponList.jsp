<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的卡券</title>
</head>
<body>
<!--//End--header-->
<div class="discount">
  <div data-am-widget="tabs" class="am-tabs am-tabs-default">
    <div class="am-tabs-bd">
      <c:forEach items="${couponList}" var="coupon">
        <div class="on-list">
          <dl>
            <%--<dt><a href="#"><img src="<c:url value="http://pro.efeiyi.com/${coupon.couponBatch.pictureUrl}"/>"><i class="icon-gq"></i></a></dt>--%>
            <dd class="clpt">
              <p>一次性消费满${coupon.couponBatch.priceLimit}元即可使用</p>
              <p>有效期限 <fmt:formatDate value="${coupon.couponBatch.startDate}" pattern="yyyy-MM-dd"/>—<fmt:formatDate value="${coupon.couponBatch.endDate}" pattern="yyyy-MM-dd"/></p>
              <p>适用范围：全网通用</p>
            </dd>
          </dl>
        </div>
      </c:forEach>
    </div>
  </div>
</div>
</body>
</html>
