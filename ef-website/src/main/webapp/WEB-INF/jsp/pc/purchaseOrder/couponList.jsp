<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head></head>
<body>
<div class="hd"></div>
<!-- //End--header-->
<!--content-->

        <div class="layout-col">
          <!--套用amazeui的选项卡插件-->

          <div class="my-kj">
            <div data-am-widget="tabs"
                 class="am-tabs am-tabs-default"
                    >
              <ul class="am-tabs-nav am-cf">
                <li class="am-active">我的卡券</li>
              </ul>
        <c:if test="${empty couponList}">
                  <tr style="border-top: 1px solid #ccc">
                    <td colspan="4">
                      <div class="mt-null">
                        <p>你还没有可用的优惠券哟</p>
                      </div>
                    </td>
                  </tr>
         </c:if>
              <c:if test="${!empty couponList}">
              <div class="am-tabs-bd">
                <div data-tab-panel-0 class="am-tab-panel am-active">
                  <div class="serial-list-page">
                    <div class="list-zq">
                      <c:forEach items="${couponList}" var="coupon">
                      <ul class="serial-list">
                        <li class="list1"><img src="<c:url value="http://pro.efeiyi.com/${coupon.couponBatch.pictureUrl}"/>"></li>
                        <li class="list2"><p>一次性消费满${coupon.couponBatch.priceLimit}元即可使用</p></li>
                        <li class="list3">
                          <p><a href="#">有效期限 <fmt:formatDate value="${coupon.couponBatch.startDate}" pattern="yyyy-MM-dd"/>—<fmt:formatDate value="${coupon.couponBatch.endDate}" pattern="yyyy-MM-dd"/></a></p>
                          <p><a href="#">适用范围：全网通用</a></p>
                        </li>
                      </ul>
                      </c:forEach>
                    </div>
                  </div>
                </div>
              </div>
              </c:if>
            </div>
          </div>

        </div>
      </div>
    </div>
  </div>
</div>
<!--content-->
<!-- //End--footer-->

<!--[if (gte IE 9)|!(IE)]><!-->
<script src="<c:url value="/scripts/js/jquery.min.js"/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value="/scripts/js/amazeui.ie8polyfill.min.js"/>"></script>
<![endif]-->
<script src="<c:url value="/scripts/js/amazeui.min.js"/>"></script>
<script src="<c:url value="/scripts/js/system.js"/>"></script>
<script src="<c:url value="/scripts/js/myorder.js"/>"></script>
</body>
</html>