<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${tenant.name}</title>
</head>
<body>
<artice class="custom">
  <div data-am-widget="slider" class="am-slider am-slider-a1 details-shop-slider" data-am-slider='{"directionNav":false}' >
    <ul class="am-slides">
      <li><img src="<c:url value="/scripts/wap/upload/details-shop-slider-exp1.jpg"/>"></li>
    </ul>
  </div>
  <!-- //End--slider-->
  <div class="details-shop-des">
    <div class="bd details-shop">
      <div class="bd s-part s-part2">
        <div class="img"><img src="<c:url value="/scripts/wap/upload/shop-details-exp2.jpg"/>" width="80" alt=""/></div>
        <div class="bd txt">
          <p>${tenant.name}</p>
          <p>200人关注</p>
        </div>
        <a href="#收藏" class="addfav"><i class="icon icon-addfav"></i><p>收藏</p></a>
      </div>
    </div>
    <!-- //End---->
    <div class="bd list-class">
      <ul class="ul-list-nav">
        <li><a href="#热门分类" title="热门分类">热门分类</a></li>
        <li><a href="#店铺详情" title="店铺详情">店铺详情</a></li>
      </ul>
      <h3 class="title">欢迎语欢迎语欢迎语欢迎语欢迎语欢迎语</h3>
      <ul class="ul-list">
        <c:forEach items="${productModelList}" var="productModel">
          <li>
            <img src="<c:url value="${productModel.product.picture_url}"/>" alt="">
            <p class="name">${productModel.name}</p>
            <p class="price"><em>￥</em><span>${productModel.price}</span></p>
          </li>
        </c:forEach>
      </ul>
    </div>
    <!-- //End--s-info-->
  </div>
</artice>
</body>
</html>
