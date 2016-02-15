<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${tenant.name}</title>
  <c:if test="${not empty tenantMasterList}">
    <c:set var="tenantName">
      ${tenantMasterList.get(0).master.fullName}
    </c:set>
  </c:if>
  <c:if test="${not empty productModelList}">
    <c:set var="projectName">
      ${productModelList.get(0).product.project.name}
    </c:set>
    <c:set var="projectContent">
      ${productModelList.get(0).product.project.name}
    </c:set>
  </c:if>
  <meta name="keywords" content="${projectName},${tenantName},${tenant.name}" />
  <meta name="description" content="${tenant.name},${projectContent}" />
  <style>
    @media (width: 320px) {
      .list-class .ul-list li{height: 17rem}
      .list-class .ul-list li img{height: 11.2rem}
    }
    @media (min-width: 414px) {
      .list-class .ul-list li{height: 21.5rem}
      .list-class .ul-list li img{height: 14.96rem}
    }
    @media (width: 375px) {
      .list-class .ul-list li{height: 17.5rem}
      .list-class .ul-list li img{height: 13.4rem}
    }
  </style>
</head>
<body>
<artice class="custom">
  <div data-am-widget="slider" class="am-slider am-slider-a1 details-shop-slider" data-am-slider='{"directionNav":false}' >
    <ul class="am-slides">
      <li><img src="<c:url value="http://pro.efeiyi.com/${tenant.pictureUrl}"/>"></li>
    </ul>
  </div>
  <!-- //End--slider-->
  <div class="details-shop-des">
    <div class="bd details-shop">
      <div class="bd s-part">
        <div class="img"><img src="<c:url value="http://pro.efeiyi.com/${tenant.logoUrl}@!tenant-wap-log"/>" width="80" alt=""/></div>
        <div class="bd txt">
          <p>${tenant.name}</p>
          <p>200人关注</p>
        </div>
        <%--<a href="#收藏" class="addfav"><i class="icon icon-addfav"></i><p>收藏</p></a>--%>
      </div>
    </div>
    <!-- //End---->
    <div class="bd list-class">
      <ul class="ul-list-nav ul-list-nav2">
        <li><a href="<c:url value="/productCategoryList.do"/> " title="热门分类">热门分类</a></li>
        <c:if test="${empty tenantMasterList}">
          <li><a  title="了解大师">了解大师</a></li>
        </c:if>
        <c:if test="${not empty tenantMasterList}">
        <li><a href="http://${tenantMasterList.get(0).master.name}.efeiyi.com" title="了解大师">了解大师</a></li>
       </c:if>
         </ul>
      <h3 class="title">欢迎</h3>
      <ul class="ul-list">
        <c:forEach items="${productModelList}" var="productModel">
          <li>
            <a href="/product/productModel/${productModel.id}" style="color: #000">
            <img src="<c:url value="http://pro.efeiyi.com/${productModel.productModel_url}@!product-model-wap-tenant"/>" alt="">
              <c:set var="name">
                <c:if test="${fn:length(productModel.product.productModelList)==1}">
                  ${productModel.product.name}
                </c:if>
                <c:if test="${fn:length(productModel.product.productModelList)>1}">
                  ${productModel.product.name}[${productModel.name}]
                </c:if>
              </c:set>
              <p class="name"> ${name}
            </p>
            <p class="price"><em>￥</em><span>${productModel.price}</span></p>
            </a>
          </li>
        </c:forEach>
      </ul>
    </div>
    <!-- //End--s-info-->
  </div>
</artice>
</body>
</html>
