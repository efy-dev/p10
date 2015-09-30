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
      <li><img src="<c:url value="http://pro.efeiyi.com/${tenant.pictureUrl}"/>"></li>
    </ul>
  </div>
  <!-- //End--slider-->
  <div class="details-shop-des">
    <div class="bd details-shop">
      <div class="bd s-part s-part2">
        <div class="img"><img src="<c:url value="http://pro.efeiyi.com/${tenant.logoUrl}"/>" width="80" alt=""/></div>
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
        <li><a href="http://${tenant.tenantMasterList.get(0).master.name}.efeiyi.com" title="了解大师">了解大师</a></li>
      </ul>
      <h3 class="title">欢迎</h3>
      <ul class="ul-list">
        <c:forEach items="${productModelList}" var="productModel">
          <li>
            <a href="/product/productModel/${productModel.id}" style="color: #000">
            <img src="<c:url value="http://pro.efeiyi.com/${productModel.productModel_url}@product-model-wap-tenant"/>" alt="">
            <p class="name">${productModel.name}
              <c:if test="${productModel.productPropertyValueList.size()>1}">
                [
                <c:forEach items="${productModel.productPropertyValueList}"
                           var="ppv">${ppv.projectPropertyValue.value}</c:forEach>
                ]
              </c:if>
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
