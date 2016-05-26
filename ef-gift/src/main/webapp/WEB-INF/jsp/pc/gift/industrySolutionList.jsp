<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--//End--nav2016-->
<div id="slide2016" class="slide2016">
  <div class="img">
    <div class="click prev"></div>
    <ul>
      <c:if test="${bannerList != null && bannerList != ''}">
        <c:forEach items="${bannerList}" var="banner">
          <li><a href="${banner.directUrl}" title=""><img src="http://gift-oss.efeiyi.com/${banner.imageUrl}" alt=""></a></li>
        </c:forEach>
      </c:if>
    </ul>
    <div class="click next"></div>
  </div>
  <div class="num">
    <ul>
      <li class="active"></li>
      <li></li>
      <li></li>
    </ul>
  </div>
</div>
<!--//End--slide2016-->
<div class="gift2016">
  <div class="gift-home company">
    <div class="customization2016">
      <c:if test="${industrySolutionMap != null && industrySolutionMap != ''}">
        <c:forEach items="${industrySolutionMap}" var="industrySolution">
          <div class="customization-list">
            <div class="title">
              <h5>${industrySolution.key.solutionName}</h5>
              <p class="organization">${industrySolution.key.introduction}</p>
            </div>
            <ul class="list delete-mg">
              <c:forEach items="${industrySolution.value}" var="productGiftIndustrySolution">
                <li>
                  <a href="">
                    <img src="http://pro.efeiyi.com/${productGiftIndustrySolution.productGift.productModel.productModel_url}" alt="">
                    <div class="list-content delete-pd">
                      <p class="name">${productGiftIndustrySolution.productGift.name}</p>
                      <p class="title">${productGiftIndustrySolution.productGift.productModel.product.subName}</p>
                    </div>
                  </a>
                </li>
              </c:forEach>
            </ul>
            <div class="btn">
              <a class="scheme" href="<c:url value="/industrySolutionRequest"/>">定制方案</a>
            </div>
          </div>
        </c:forEach>
      </c:if>
    </div>
    <div class="flow">
      <h5>定制流程</h5>
      <div class="flow-pic">
        <img src="<c:url value="/scripts/images/gift/flow.jpg"/>" alt="流程">
        <div class="flow-content">
          <div class="consult">
            <a class="z-btn">马上咨询</a>
          </div>
          <p class="phone">咨询热线：4008768766</p>
        </div>
      </div>
    </div>
  </div>
</div>
