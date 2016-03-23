<%@ page import="com.ming800.core.p.PConst" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="now" class="java.util.Date" />
<!doctype html>
<html class="no-js">
<head>
  <title>我的卡券</title>
</head>
<body>
<!-- Start--收藏成功提示框 -->
<div class="alert-red-top" style="display: none">
  <span class="red-text">删除成功！</span>
</div>
<!-- //End--收藏成功提示框 -->
<!--//End--header-->
<div class="coupon-tab ae">
  <div class="c-tab ae">
    <ul>
      <li class="active"><p>可使用</p><p></p></li>
      <li><p>不可使用</p><p></p></li>
    </ul>
  </div>
  <div class="c-page ae">
    <!-- 可使用-->
    <div class="box add">
      <ul>
        <c:set var="td" >
          <fmt:formatDate value="${now}" type="both" dateStyle="long" pattern="yyyy-MM-dd" />
        </c:set>
        <c:forEach items="${allCouponList}" var="acl">
          <c:set var="ed">
            <fmt:formatDate value="${acl.couponBatch.endDate}" pattern='yyyy-MM-dd' />
          </c:set>
          <c:set var="sd">
            <fmt:formatDate value="${acl.couponBatch.startDate}" pattern='yyyy-MM-dd'/>
          </c:set>

          <c:if test="${sd<=td && td<=ed}">
        <li>
          <div class="left"><strong>
            <c:set var="price" value="${acl.couponBatch.price}"/>
              ${fn:substringBefore(price, ".")}
          </strong><span>
            <c:choose>
              <c:when test="${acl.couponBatch.type==1}">
                满减券
              </c:when>
              <c:when test="${acl.couponBatch.type==2}">
                现金券
              </c:when>
            </c:choose>
          </span><i>¥</i></div>
          <div class="top"><p>
            <c:if test="${acl.couponBatch.type==1}">
            满${acl.couponBatch.priceLimit}元使用
            </c:if>
          </p>
            <c:choose>
              <c:when test="${acl.couponBatch.range ==1}">
                <p>全场通用</p>
              </c:when>
              <c:when test="${acl.couponBatch.range ==2}">
                <p>限购 [${acl.couponBatch.project.name}] 类商品</p>

              </c:when>
              <c:when test="${acl.couponBatch.range ==3}">
                <p>限购 [${acl.couponBatch.tenant.name}] 店铺商品</p>

              </c:when>
              <c:when test="${acl.couponBatch.range ==4}">
                <p>限购 [${acl.couponBatch.product.name}] 商品</p>
              </c:when>
            </c:choose>
            <p> <fmt:formatDate value="${acl.couponBatch.startDate}" pattern='yyyy.MM.dd'/>
              至<fmt:formatDate value="${acl.couponBatch.endDate}" pattern='yyyy.MM.dd' /></p></div>
          <div class="right">
            <c:if test="${acl.couponBatch.range ==1}">
            <a href="http://www.efeiyi.com">立即使用</a>
              </c:if>
            <c:if test="${acl.couponBatch.range ==2}">
              <a href="<%=PConst.HOSTNAME%>/product/list/${acl.couponBatch.project.id}">立即使用</a>
            </c:if>
            <c:if test="${acl.couponBatch.range ==3}">
            <a href="<%=PConst.HOSTNAME%>/tenantOfMobile/${acl.couponBatch.tenant.id}">立即使用</a>
          </c:if>
            <c:if test="${acl.couponBatch.range ==4}">
              <a href="<%=PConst.HOSTNAME%>/product/productModel/${acl.couponBatch.product.productModelList.get(0).id}">立即使用</a>
            </c:if>
          </div>
        </li>
          </c:if>
       </c:forEach>
      </ul>
      <div class="change"><a href="<c:url value="/appExchange.do"/>" class="btn-change" title="使用兑换码">使用兑换码</a></div>
    </div>
    <!--    不可使用-->
    <div class="box ae" style="display: none">
      <ul>
        <c:set var="td" >
          <fmt:formatDate value="${now}" type="both" dateStyle="long" pattern="yyyy-MM-dd" />
        </c:set>
        <c:forEach items="${allCouponList}" var="acl">
          <c:set var="ed">
            <fmt:formatDate value="${acl.couponBatch.endDate}" pattern='yyyy-MM-dd' />
          </c:set>
          <c:set var="sd">
            <fmt:formatDate value="${acl.couponBatch.startDate}" pattern='yyyy-MM-dd'/>
          </c:set>

          <c:if test="${td<sd || td>ed}">
            <li>
              <div class="left"><strong>
                <c:set var="price" value="${acl.couponBatch.price}"/>
                  ${fn:substringBefore(price, ".")}
              </strong><span>
            <c:choose>
              <c:when test="${acl.couponBatch.type==1}">
                满减券
              </c:when>
              <c:when test="${acl.couponBatch.type==2}">
                现金券
              </c:when>
            </c:choose>
          </span><i>¥</i></div>
              <div class="top"><p>
                <c:if test="${acl.couponBatch.type==1}">
                  满${acl.couponBatch.priceLimit}元使用
                </c:if>
              </p>
                <c:choose>
                  <c:when test="${acl.couponBatch.range ==1}">
                    <p>全场通用</p>
                  </c:when>
                  <c:when test="${acl.couponBatch.range ==2}">
                    <p>限购 [${acl.couponBatch.project.name}] 类商品</p>

                  </c:when>
                  <c:when test="${acl.couponBatch.range ==3}">
                    <p>限购 [${acl.couponBatch.tenant.name}] 店铺商品</p>

                  </c:when>
                  <c:when test="${acl.couponBatch.range ==4}">
                    <p>限购 [${acl.couponBatch.product.name}] 商品</p>
                  </c:when>
                </c:choose>
                <p> <fmt:formatDate value="${acl.couponBatch.startDate}" pattern='yyyy.MM.dd'/>
                  至<fmt:formatDate value="${acl.couponBatch.endDate}" pattern='yyyy.MM.dd' /></p></div>
              <div class="right"><a href="<c:url value="/remove/coupon.do?couponId=${acl.id}&cf=4"/>">删除</a></div>
            </li>
          </c:if>
        </c:forEach>
      </ul>
    </div>
  </div>
</div>
</body>
</html>

