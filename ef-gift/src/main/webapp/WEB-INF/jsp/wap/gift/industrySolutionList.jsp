<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
  <title>礼品频道</title>
</head>
<body>
<div class="gift gift-asp">
  <div data-am-widget="slider" class="am-slider am-slider-a4 img-slider" data-am-slider='{&quot;directionNav&quot;:false}' >
    <ul class="am-slides">
      <c:if test="${bannerList != null && bannerList != ''}">
        <c:forEach items="${bannerList}" var="banner">
          <li><img src="http://wiki-oss.efeiyi.com/${banner.wapUrl}"></li>
        </c:forEach>
      </c:if>
    </ul>
  </div>
  <!--//End--轮播图-->
  <c:if test="${subjectList != null && subjectList != ''}">
    <c:forEach items="${subjectList}" var="subject">
      <div class="bd ht">
        <div class="title">
          <h3>${subject.name}</h3>
          <h4>适合银行、证券、基金等金融机构</h4>
          <a class="btn-link" href="<c:url value="/industrySolutionRequest"/>" title="方案定制">方案定制</a>
        </div>
        <div class="bd list">
          <ul class="ul-col-2">
            <c:forEach items="${subject.subjectProductList}" var="subjectProduct">
            <li><a href="" title=""><img src="http://wiki-oss.efeiyi.com/${subjectProduct.product.picture_url}" alt=""><span class="txt-abs"><em>${subjectProduct.product.name}</em></span></a></li>
            </c:forEach>
          </ul>
        </div>
      </div>
    </c:forEach>
  </c:if>
  <!--//ENd--金融行业礼品方案-->
  <div class="bd ht ht-diy">
    <div class="title">
      <h3>定制流程</h3>
      <img class="bd" src="<c:url value="/scripts/wap/images/gift-path.png"/>" alt="">
      <a class="btn-link" href="tel:4008768766" title="马上咨询">马上咨询</a>
      <p>咨询热线：4008768766</p>
    </div>
  </div>
  <!--//ENd--定制流程-->

</div>
</body>
</html>
