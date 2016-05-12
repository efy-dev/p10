<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>礼品频道</title>
</head>
<body>
<div class="gift gift-home">
    <div data-am-widget="slider" class="am-slider am-slider-a4 img-slider" data-am-slider='{&quot;directionNav&quot;:false}' >
        <ul class="am-slides">
            <c:if test="${bannerList != null && bannerList != ''}">
                <c:forEach items="${bannerList}" var="banner">
                    <li><a href="${banner.wapUrl}"><img src="http://gift-oss.efeiyi.com/${banner.imageUrl}"></a></li>
                </c:forEach>
            </c:if>
        </ul>
    </div>
    <!--//End--轮播图-->
    <div class="menu">
        <ul>
            <li><a href="<c:url value="/searchProductGift"/>"><i class="icon icon-slch"></i><p>送礼场合</p></a></li>
            <li><a href="<c:url value="/searchProductGift"/>"><i class="icon icon-sldx"></i><p>送礼对象</p></a></li>
            <li><a href="<c:url value="/searchProductGift"/>"><i class="icon icon-sljg"></i><p>送礼价格</p></a></li>
        </ul>
        <ul>
            <li><a href="<c:url value="/industrySolution"/>"><i class="icon icon-qylp"></i><p>企业礼品</p></a></li>
            <li><a href="<c:url value="/viewSubject/inzu4ha1b7pa9flo"/>"><i class="icon icon-glys"></i><p>国礼轶事</p></a></li>
            <li><a href="<c:url value="/viewSubject/inzu4s481azja868"/>"><i class="icon icon-lswl"></i><p>中国“礼”文化</p></a></li>
        </ul>
    </div>
    <!--//End--menu-->
    <div class="bd ht">
        <div class="bd list">
            <ul class="ul-col-2">
                <c:if test="${advertisementList != null && advertisementList != ''}">
                    <c:forEach items="${advertisementList}" var="advertisement">
                        <li>
                            <a href="${advertisement.wapRedirect}" title="">
                                <img src="http://pro.efeiyi.com/${advertisement.img}" alt="">
                       <%-- <span class="txt">
                            <p>${subject.name}</p>
                            <p>全网独家·匠心好礼</p>
                        </span>--%>
                            </a>
                        </li>
                    </c:forEach>
                </c:if>
            </ul>
            <%--<div class="bd more"><a class="btn-link" href="" title="查看更多作品">查看更多作品</a></div>--%>
        </div>
    </div>
    <!--//ENd--ht-->
    <div class="bd ht reco">
        <div class="bd">
            <c:if test="${subjectList != null && subjectList != ''}">
                <c:forEach items="${subjectList}" var="subject">
                    <a href="<c:url value="/viewSubject/${subject.id}"/>"><img class="bd" src="http://gift-oss.efeiyi.com/${subject.pictureUrl}" alt=""></a>
                </c:forEach>
            </c:if>
        </div>
        <%--<div class="bd more"><a class="btn-link" href="" title="查看更多作品">查看更多作品</a></div>--%>

    </div>
</div>

</body>
</html>
