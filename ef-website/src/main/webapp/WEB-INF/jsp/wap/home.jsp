<%@ page import="com.efeiyi.ec.website.organization.util.AuthorizationUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
    <title>e飞蚁-领先的非物质文化遗产电商平台</title>
    <meta name="keywords" content="e飞蚁,非物质文化遗产,中国非物质文化遗产,非物质文化遗产网,非遗博览园,非遗节,非遗产品,非遗大师,传统工艺" />
    <meta name="description" content="e飞蚁，中国领先的非物质文化遗产电商与交流平台，汇聚诸多传承人和各类传统工艺" />
</head>
<body>
<%--<header class="am-header custom-header index-header newheader">--%>
    <%--<div class="logo"><a class="icon" href="" title="e飞蚁"></a></div>--%>
    <%--<!-- //End--logo-->--%>
    <%--<div class="newsearch">--%>
        <%--<form>--%>
            <%--<input class="newsebox" placeholder="茶叶罐">--%>
            <%--<input type="submit" class="newsebut" value="搜">--%>
        <%--</form>--%>
    <%--</div>--%>
    <%--<div class="am-header-right am-header-nav">--%>
        <%--<a href="<c:url value="/cart/view"/>" class="icon icon-cart"><span><em>0</em></span></a>--%>
        <%--<% if (AuthorizationUtil.isAuthenticated()) {%>--%>
        <%--<a href="http://i.efeiyi.com/order/myEfeiyi/list.do" class="icon icon-user"></a>--%>
        <%--<%} else {%>--%>
        <%--<a href="<c:url value="/sso.do"/>" class="icon icon-user"></a>--%>
        <%--<%}%>--%>
    <%--</div>--%>
<%--</header>--%>
<!--//End--header-->
<article class="custom newcustom">
    <div data-am-widget="slider" class="am-slider am-slider-a1" data-am-slider='{&quot;directionNav&quot;:false}' >
        <ul class="am-slides">
            <c:forEach items="${bannerList}" var="banner">
                <li><a ><img src="<c:url value="http://pro.efeiyi.com/${banner.imageUrl}@!home-banner"/>"></a></li>
            </c:forEach>
        </ul>
    </div>
    <!--//End--am-slider-->
    <div class="toolbar">
        <a class="item asso" href="<c:url value="/productCategoryList.do"/> ">
            <span><i class="newicon"></i></span>
            <span>分&nbsp;类</span>
        </a>
        <a class="item sh" href="http://www.efeiyi.com/subject/ig8zlvonengegjk9">
            <span><i class="newicon"></i></span>
            <span>专&nbsp;题</span>
        </a>
        <a class="item user" href="http://master.efeiyi.com">
            <span><i class="newicon"></i></span>
            <span>大&nbsp;师</span>
        </a>
        <a class="item coupon" href="#coupon">
            <span><i class="newicon"></i></span>
            <span>工&nbsp;艺</span>
        </a>
    </div>
    <!--//End--toolbar-->
    <div class="deduce">
        <!-- 营销活动 -->
        <ul class="list-top">
            <c:if test="${not empty marketingActivityQueryList&&fn:length(marketingActivityQueryList)>0}">
                <c:forEach items="${marketingActivityQueryList}" var="marketingActivity">
                    <li><a href="${marketingActivity.redirect}"><img src="http://pro.efeiyi.com/${marketingActivity.img}"></a></li>
                </c:forEach>
            </c:if>
        </ul>
        <!--热卖商品-->
        <ul class="deduce-all">
            <c:if test="${not empty hotSaleList&&fn:length(hotSaleList)>0}">
                <c:forEach items="${hotSaleList}" var="hotSale" begin="0" end="9">
                    <li>
                        <a href="${hotSale.redirect}">
                            <em>${hotSale.name}</em>
                            <img src="http://pro.efeiyi.com/${hotSale.img}">
                        </a>
                        <span class="price"><i>￥</i><strong>${hotSaleList.get(0).price}</strong></span>
                        <span class="heat"><font>热卖</font></span>
                    </li>
                </c:forEach>
            </c:if>
        </ul>
    </div>
    <!--//End--deduce-->
    <!--类别推荐-->
    <c:forEach items="${recommendedCategoryList}" var="projectCategory">
        <div class="max-cat ae">
            <div class="ae">
                <div class="cat-top">
                    <div class="cat-t-o">${projectCategory.name}</div>
                        <%--<div class="cat-t-t">一处一知音</div>--%>
                        <%--<div class="cat-t-t">一物一乾坤</div>--%>
                </div>
            </div>
            <ul class="cat-bottom ae">
                <c:forEach items="${recommendMap.get(projectCategory.id)}" var="projectCategoryProductModel" varStatus="status" begin="0" end="7">
                    <li>
                        <a href="<c:url value="/product/hot/${projectCategoryProductModel.productModel.id}"/>">
                            <em>${projectCategoryProductModel.productModel.product.name}</em>
                            <img src="http://pro.efeiyi.com/${projectCategoryProductModel.productModel.product.getProductPicture().pictureUrl}">
                        </a>
                        <span class="price"><i>￥</i><strong>${projectCategoryProductModel.productModel.price.intValue()}</strong></span>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </c:forEach>
    <!--//End--一个max-cat-->
</article>
<!--//End--newcustom-->
<%--<footer class="bd footer-new">--%>
<%--<div class="login-reg nawlogin-reg">--%>
<%--<div class="bd logined">李先生8899，<a class="btn-exit" href="#退出">退出</a></div>--%>
<%--<a href="#login" class="btn-login" title="登录">登&nbsp;&nbsp;&nbsp;&nbsp;录</a>--%>
<%--<a href="#reg" class="btn-reg">注&nbsp;&nbsp;&nbsp;&nbsp;册</a>--%>
<%--</div>--%>
<%--<!--//End--login-reg-->--%>
<%--<div class="bd authentication">--%>
<%--<h3>独家合作伙伴</h3>--%>
<%--<div class="bd">--%>
<%--<a class="icon1" href="http://en.unesco.org/" title="联合国教科文组织"></a>--%>
<%--<em class="line"></em>--%>
<%--<a class="icon2" title="e飞蚁"></a>--%>
<%--<em class="line"></em>--%>
<%--<a class="icon3" title="中国非物质文化遗产保护协会"></a>--%>
<%--</div>--%>
<%--</div>--%>
<%--<!----//End---->--%>
<%--<div class="bd info">--%>
<%--<a class="icon"></a>--%>
<%--<div class="txt">中&nbsp;&nbsp;国&nbsp;&nbsp;非&nbsp;&nbsp;遗&nbsp;&nbsp;电&nbsp;&nbsp;商&nbsp;&nbsp;平&nbsp;&nbsp;台</div>--%>
<%--<div class="wechat"><img src="../shop2015/images/icon-wechat.png"></div>--%>
<%--<div class="txt">关注微信公众号</div>--%>
<%--<div class="txt">领取超值代金券</div>--%>
<%--</div>--%>
<%--<div class="bd copyright">京ICP备15032511号-1</div>--%>
<%--</footer>--%>
<!--//End--footer-->

<!--自定义js--End-->
</body>
</html>
</body>
</html>