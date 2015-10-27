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
            <li class="stau1"><a href="${advertisement[1].redirect}" title=""><em>${advertisement[1].name}</em><img src="http://pro.efeiyi.com/${advertisement[1].img}@!advertisement-big-mobile" alt=""/></a></li>
            <li class="stau2"><a href="${advertisement[0].redirect}" title=""><em>${advertisement[0].name}</em><img src="http://pro.efeiyi.com/${advertisement[0].img}@!advertisement-small-mobile" alt=""/></a></li>
            <li class="stau3"><a href="${advertisement[2].redirect}" title=""><em>${advertisement[2].name}</em><img src="http://pro.efeiyi.com/${advertisement[2].img}@!advertisement-small-mobile" alt=""/></a></li>
            <li class="stau1"><a href="${advertisement[7].redirect}" title=""><em>${advertisement[7].name}</em><img src="http://pro.efeiyi.com/${advertisement[7].img}@!advertisement-big-mobile" alt=""/></a></li>
            <li class="stau2"><a href="${advertisement[3].redirect}" title=""><em>${advertisement[3].name}</em><img src="http://pro.efeiyi.com/${advertisement[3].img}@!advertisement-small-mobile" alt=""/></a></li>
            <li class="stau3"><a href="${advertisement[4].redirect}" title=""><em>${advertisement[4].name}</em><img src="http://pro.efeiyi.com/${advertisement[4].img}@!advertisement-small-mobile" alt=""/></a></li>
            <li class="stau2"><a href="${advertisement[5].redirect}" title=""><em>${advertisement[5].name}</em><img src="http://pro.efeiyi.com/${advertisement[5].img}@!advertisement-small-mobile" alt=""/></a></li>
            <li class="stau3"><a href="${advertisement[6].redirect}" title=""><em>${advertisement[6].name}</em><img src="http://pro.efeiyi.com/${advertisement[6].img}@!advertisement-small-mobile" alt=""/></a></li>
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
                            <em class="name">${product.productModel.product.name}</em>
                            <span class="price"><i></i><strong></strong></span>
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