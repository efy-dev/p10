<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>礼品频道</title>
  <link rel="stylesheet" href="<c:url value="/scripts/wap/css/amazeui.min.css?t=20160413"/>">
  <link rel="stylesheet" href="<c:url value="/scripts/wap/css/layout.css?t=20160413"/>">
  <link rel="stylesheet" href="<c:url value="/scripts/wap/css/gift.css?t=20160413"/>">
</head>
<body>
<div class="gift gift-home">
  <div data-am-widget="slider" class="am-slider am-slider-a4 img-slider" data-am-slider='{&quot;directionNav&quot;:false}' >
    <ul class="am-slides">
    <c:if test="${bannerList != null && bannerList != ''}">
        <c:forEach items="${bannerList}" var="banner">
            <li><img src="http://pro.efeiyi.com/${banner.wapUrl}"></li>
        </c:forEach>
    </c:if>
    </ul>
  </div>
  <!--//End--轮播图-->
  <div class="menu">
    <ul>
      <li><a href=""><i class="icon icon-slch"></i><p>送礼场合</p></a></li>
      <li><a href=""><i class="icon icon-sldx"></i><p>送礼对象</p></a></li>
      <li><a href=""><i class="icon icon-sljg"></i><p>送礼价格</p></a></li>
    </ul>
    <ul>
      <li><a href="<c:url value="/industrySolution.do"/>"><i class="icon icon-qylp"></i><p>企业礼品</p></a></li>
      <li><a href=""><i class="icon icon-glys"></i><p>国礼轶事</p></a></li>
      <li><a href=""><i class="icon icon-lswl"></i><p>礼尚往来</p></a></li>
    </ul>
  </div>
  <!--//End--menu-->
  <div class="bd ht">
    <div class="bd list">
        <ul class="ul-col-2">
            <c:if test="${subjectList != null && subjectList != ''}">
                <c:forEach items="${subjectList}" var="subject">
                    <li>
                        <a href="" title="">
                            <img src="http://pro.efeiyi.com/${subject.pictureUrl}" alt="">
                        <span class="txt">
                            <p>${subject.name}</p>
                            <p>全网独家·匠心好礼</p>
                        </span>
                        </a>
                    </li>
            </c:forEach>
        </c:if>
      </ul>
      <div class="bd more"><a class="btn-link" href="" title="查看更多作品">查看更多作品</a></div>
    </div>
  </div>
  <!--//ENd--ht-->
  <div class="bd ht reco">
    <div class="bd">
        <c:if test="${subjectList1 != null && subjectList1 != ''}">
            <c:forEach items="${subjectList1}" var="subject1">
                <a href=""><img class="bd" src="http://pro.efeiyi.com/${subject1.pictureUrl}" alt=""></a>
            </c:forEach>
        </c:if>
    </div>
    <%--<div class="bd more"><a class="btn-link" href="" title="查看更多作品">查看更多作品</a></div>--%>

  </div>
</div>


<script src="<c:url value="/scripts/wap/js/jquery.min.js"/>"></script>
<script src="<c:url value="/scripts/wap/js/amazeui.min.js"/>"></script>


<script src="<c:url value="/scripts/wap/js/system.js"/>"></script>
</body>
</html>
