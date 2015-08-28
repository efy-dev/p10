<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<body>
<!--//End--header-->
<article class="custom">
  <div data-am-widget="slider" class="am-slider am-slider-a1" data-am-slider='{&quot;directionNav&quot;:false}' >
    <ul class="am-slides">
      <c:forEach items="${bannerList}" var="banner">
        <li><img src="<c:url value="http://pro.efeiyi.com/${banner.imageUrl}@!home-banner"/>"></li>
      </c:forEach>
    </ul>
  </div>
  <!--//End--am-slider-->
  <div class="toolbar">
    <a class="item asso" href="#">
      <span><i class="icon"></i></span>
      <span>分类</span>
    </a>
    <a class="item user" href="#user">
      <span><i class="icon"></i></span>
      <span>传&nbsp;承&nbsp;人</span>
    </a>
    <a class="item coupon" href="#coupon">
      <span><i class="icon"></i></span>
      <span>我&nbsp;的&nbsp;卡&nbsp;券</span>
    </a>
  </div>
  <!--//End--toolbar-->
  <div class="box-hd">
    <ul class="ul-index-list">
      <li><a href="" title=""><img src="<c:url value="/scripts/wap/assets/upload/box-hd-1.jpg"/>" alt=""/></a></li>
    </ul>
  </div>
  <!--//End--铜的故事-->
  <c:forEach items="${projectList}" var="project">
    <div class="box-hd">
      <div class="title"><strong>${project.name}</strong></div>
      <ul class="ul-index-list">
        <c:forEach items="${recommendMap.get(project.id)}" var="product" varStatus="status" begin="0" end="3">
          <li>
            <a href="<c:url value="/product/hot/${product.id}"/>" title="">
              <img src="<c:url value="http://pro.efeiyi.com/${product.productModel_url}@!home-product"/>" alt=""/>
              <em class="name">${product.product.name}</em>
              <span class="price"><i>￥</i><strong>${product.price}</strong></span>
            </a>
          </li>
        </c:forEach>
      </ul>
    </div>
  </c:forEach>
  <!--//End--名品佳酿-->

</article>
</body>
</html>