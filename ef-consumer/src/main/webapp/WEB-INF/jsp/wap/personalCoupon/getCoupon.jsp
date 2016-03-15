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
  <title>优惠券</title>
</head>
<body>
<c:set var="td" >
  <fmt:formatDate value="${now}" type="both" dateStyle="long" pattern="yyyy-MM-dd" />
</c:set>
<c:set var="ed">
  <fmt:formatDate value="${coupon.couponBatch.endDate}" pattern='yyyy-MM-dd' />
</c:set>
<c:set var="sd">
  <fmt:formatDate value="${coupon.couponBatch.startDate}" pattern='yyyy-MM-dd'/>
</c:set>
<c:if test="${sd<=td && td<=ed}">
<div class="tab-convert ae tab-add">
  <form>
    <h5>恭喜您，获得优惠券。</h5>
    <ul>
      <li>
        <div class="right">
          <div class="money"><strong>${coupon.couponBatch.price}</strong><span>
            <c:choose>
              <c:when test="${coupon.couponBatch.type==1}">
                满减券
              </c:when>
              <c:when test="${coupon.couponBatch.type==2}">
                现金券
              </c:when>
            </c:choose>
          </span><i>¥</i></div>
          <div class="page">
            <p>
              <c:if test="${coupon.couponBatch.type==1}">
                满${coupon.couponBatch.priceLimit}元使用
              </c:if>
              <c:if test="${coupon.couponBatch.type==2}">
                消费立减${coupon.couponBatch.price}元
              </c:if>
            </p>
              <c:choose>
              <c:when test="${coupon.couponBatch.range ==1}">
            <p>全场通用</p>
            </c:when>
            <c:when test="${coupon.couponBatch.range ==2}">
              <p>限购 [${coupon.couponBatch.project.name}] 类商品</p>

            </c:when>
            <c:when test="${coupon.couponBatch.range ==3}">
              <p>限购 [${coupon.couponBatch.tenant.name}] 店铺商品</p>

            </c:when>
            <c:when test="${coupon.couponBatch.range ==4}">
              <p>限购 [${coupon.couponBatch.product.name}] 商品</p>
            </c:when>
            </c:choose>
            <p><fmt:formatDate value="${coupon.couponBatch.startDate}" pattern='yyyy.MM.dd'/>
              至<fmt:formatDate value="${coupon.couponBatch.endDate}" pattern='yyyy.MM.dd' /></p>
          </div>
        </div>
      </li>
    </ul>
    <div class="aclass">
      <a href="<%=PConst.HOSTNAME%>">返&nbsp;回&nbsp;首&nbsp;页</a>
      <c:if test="${coupon.couponBatch.range ==1}">
        <a href="<%=PConst.HOSTNAME%>">使&nbsp;用</a>
      </c:if>
      <c:if test="${coupon.couponBatch.range ==2}">
        <a href="<%=PConst.HOSTNAME%>/product/list/${coupon.couponBatch.project.id}">使&nbsp;用</a>
      </c:if>
      <c:if test="${coupon.couponBatch.range ==3}">
        <a href="<%=PConst.HOSTNAME%>/tenantOfMobile/${coupon.couponBatch.tenant.id}">使&nbsp;用</a>
      </c:if>
      <c:if test="${coupon.couponBatch.range ==4}">
        <a href="<%=PConst.HOSTNAME%>/product/productModel/${coupon.couponBatch.product.productModelList.get(0).id}">使&nbsp;用</a>
      </c:if>

    </div>
  </form>
</div>
</c:if>

<c:if test="${sd>=td || td>=ed}">
  <div class="tab-convert ae tab-add tab-add1">
    <form>
      <h5>恭喜您，获得优惠券。</h5>
      <ul>
        <li>
          <div class="right">
            <div class="money"><strong>${coupon.couponBatch.price}</strong><span>
            <c:choose>
              <c:when test="${coupon.couponBatch.type==1}">
                满减券
              </c:when>
              <c:when test="${coupon.couponBatch.type==2}">
                现金券
              </c:when>
            </c:choose>
          </span><i>¥</i></div>
            <div class="page">
              <p>
                <c:if test="${coupon.couponBatch.type==1}">
                  满${coupon.couponBatch.priceLimit}元使用
                </c:if>
                <c:if test="${coupon.couponBatch.type==2}">
                  消费立减${coupon.couponBatch.price}元
                </c:if>
              </p>
              <p><c:choose>
                <c:when test="${coupon.couponBatch.range ==1}">
              <p>全场通用</p>
              </c:when>
              <c:when test="${coupon.couponBatch.range ==2}">
                <p>限购 [${coupon.couponBatch.project.name}] 类商品</p>

              </c:when>
              <c:when test="${coupon.couponBatch.range ==3}">
                <p>限购 [${coupon.couponBatch.tenant.name}] 店铺商品</p>

              </c:when>
              <c:when test="${coupon.couponBatch.range ==4}">
                <p>限购 [${coupon.couponBatch.product.name}] 商品</p>
              </c:when>
              </c:choose>
              </p>
              <p><fmt:formatDate value="${coupon.couponBatch.startDate}" pattern='yyyy.MM.dd'/>
                至<fmt:formatDate value="${coupon.couponBatch.endDate}" pattern='yyyy.MM.dd' /></p>
            </div>
          </div>
        </li>
      </ul>
      <div class="aclass">
        <a href="<%=PConst.HOSTNAME%>">返&nbsp;回&nbsp;首&nbsp;页</a>
        <a href="#">使&nbsp;用</a>
      </div>
    </form>
  </div>
</c:if>
</body>
</html>
