<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
    <title>首页</title>
</head>
<body>
<!--//End--header-->
<article class="custom">
    <div data-am-widget="slider" class="am-slider am-slider-a1" data-am-slider='{&quot;directionNav&quot;:false}'>
        <ul class="am-slides">
            <c:forEach items="${bannerList}" var="banner">
                <li><a href="<c:url value="${banner.directUrl}"/>"><img src="<c:url value="http://pro.efeiyi.com/${banner.imageUrl}@!home-banner"/>"></a></li>
            </c:forEach>
        </ul>
    </div>
    <!--//End--am-slider-->
    <div class="toolbar">
        <a class="item asso" href="<c:url value="/productCategory.do"/> ">
            <span><i class="icon"></i></span>
            <span>分类</span>
        </a>
        <a class="item user" href="http://master.efeiyi.com">
            <span><i class="icon"></i></span>
            <span>大&nbsp;师</span>
        </a>
        <a class="item coupon" href="/coupon/list">
            <span><i class="icon"></i></span>
            <span>我&nbsp;的&nbsp;卡&nbsp;券</span>
        </a>
    </div>
    <!--//End--toolbar-->
    <div class="box-hd">
        <ul class="ul-index-list">
            <li><a href="<c:url value="/subject/${subject.id}"/>" title=""><img src="http://pro.efeiyi.com/${subject.pictureUrl}" alt=""/></a></li>
        </ul>
    </div>
    <!--//End--铜的故事-->
    <c:forEach items="${projectList}" var="project">
        <div class="box-hd">
            <div class="title"><strong>${project.name}</strong></div>
            <ul class="ul-index-list">
                <c:forEach items="${recommendMap.get(project.id)}" var="product" varStatus="status" begin="0" end="3">
                    <li>
                        <a href="<c:url value="/product/hot/${product.productModel.id}"/>" title="">
                            <img src="<c:url value="http://pro.efeiyi.com/${product.productModel.product.getProductPicture().pictureUrl}@!home-product"/>"
                                 alt=""/>
                            <em class="name">${product.productModel.name}</em>
                            <span class="price"><i>￥</i><strong>${product.productModel.price}</strong></span>
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