<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/11/17
  Time: 16:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
</head>
<body>
<!-- //End--topbar-->

<%--<div class="wh nav-new">--%>
<%--<div class="hd">--%>
<%--<div class="cate">--%>
<%--<div class="ld"><h2>非遗商品分类<i class="icon-new"></i></h2></div>--%>
<%--<div class="allsort">--%>
<%--<c:forEach items="${categoryList}" var="category">--%>
<%--<div class="item">--%>
<%--<h3><a href="" title="">${category.name}</a><i class="icon-new icon-link"></i></h3>--%>
<%--<div class="i-mc" style="display: none;">--%>
<%--<div class="links">--%>
<%--<c:forEach items="${projectMap.get(category.id)}" var="project">--%>
<%--<a href="<c:url value="/product/list/${project.id}"/>" title="">${project.name}</a>--%>
<%--</c:forEach>--%>
<%--</div>--%>
<%--<!-- //End--links-->--%>
<%--<div class="reco">--%>
<%--<c:forEach items="${projectMap.get(category.id)}" var="project">--%>
<%--<c:if test="${not empty recommendedTenantList}">--%>
<%--<c:forEach items="${recommendedTenantList}" var="tenant">--%>
<%--<c:if test="${project.id==tenantMap.get(tenant.id)}">--%>
<%--<a href="<c:url value="/tenant/${tenant.id}"/>" title=""> <img class="imgfilter" src="http://pro.efeiyi.com/${tenant.logoUrl}" alt=""></a>--%>
<%--</c:if>--%>
<%--</c:forEach>--%>
<%--</c:if>--%>
<%--</c:forEach>--%>
<%--</div>--%>
<%--&lt;%&ndash;</c:forEach>&ndash;%&gt;--%>
<%--</div>--%>
<%--</div>--%>
<%--</c:forEach>--%>
<%--</div>--%>
<%--</div>--%>
<%--<div class="items">--%>
<%--<a href="">首页</a>--%>
<%--<a href="">品牌专区</a>--%>
<%--<a href="">各地非遗</a>--%>
<%--<a href="">大师</a>--%>
<%--<a href="">工艺</a>--%>
<%--</div>--%>
<%--</div>--%>
<%--</div>--%>
<%--<!--//End--nav-new-->--%>
<%--<div class="wh focus-new">--%>
<%--<div class="hd">--%>
<%--<ul class="slider-main">--%>
<%--<c:forEach items="${bannerList}" var="banner" varStatus="status">--%>
<%--<c:if test="${status.index==0}">--%>
<%--<li style="display: block;">--%>
<%--</c:if>--%>
<%--<c:if test="${status.index!=0}">--%>
<%--<li>--%>
<%--</c:if>--%>
<%--<a href="<c:url value="${banner.directUrl}"/> " target="_blank"><img--%>
<%--src="http://pro.efeiyi.com/${banner.imageUrl}@!home-banner" width="1280" height="481"--%>
<%--alt=""/></a></li>--%>
<%--</c:forEach>--%>
<%--</ul>--%>
<%--<ul class="slider-nav">--%>
<%--<li class="active"></li>--%>
<%--<c:forEach items="${bannerList}" var="banner" begin="1">--%>
<%--<li></li>--%>
<%--</c:forEach>--%>
<%--</ul>--%>
<%--<div class="btn btn-prev" title="上一页"></div>--%>
<%--<div class="btn btn-next" title="下一页"></div>--%>
<%--</div>--%>
<%--</div>--%>
<!--//End--focus-new-->
<div class="wh focus-new">
    <div class="hd">
        <ul class="slider-main">
            <c:forEach items="${bannerList}" var="banner" varStatus="status">
                <c:if test="${status.index==0}">
                    <li style="display: block;">
                </c:if>
                <c:if test="${status.index!=0}">
                    <li>
                </c:if>
                <a href="<c:url value="${banner.directUrl}"/> " target="_blank"><img
                        src="http://pro.efeiyi.com/${banner.imageUrl}@!home-banner" width="1280" height="481"
                        alt=""/></a></li>
            </c:forEach>
        </ul>
        <ul class="slider-nav">
            <li class="active"></li>
            <c:forEach items="${bannerList}" var="banner" begin="1">
                <li></li>
            </c:forEach>
        </ul>
        <div class="btn btn-prev" title="上一页"></div>
        <div class="btn btn-next" title="下一页"></div>
    </div>
</div>
<div class="homenew hd">
    <div class="deduce ae">
        <ul class="list-top ae">
            <c:if test="${not empty marketingActivityQueryList&&fn:length(marketingActivityQueryList)>0}">
                <c:forEach items="${marketingActivityQueryList}" var="marketingActivity">
                    <li><a href="${marketingActivity.redirect}" target="_blank"><img class="imgfilter" src="http://pro.efeiyi.com/${marketingActivity.img}@!pc-home-marketing-activity"></a></li>
                </c:forEach>
            </c:if>
        </ul>
        <ul class="list-bottom ae">
            <%--<c:if test="${not empty hotSaleList&&fn:length(hotSaleList)>0}">--%>
            <%--<c:forEach items="${hotSaleList}" var="hotSale">--%>
            <%--<li>--%>
            <%--<a href="#" target="_blank">--%>
            <%--<strong>${hotSale.name}</strong>--%>
            <%--<img class="imgfilter" src="http://pro.efeiyi.com/${hotSale.img}@!pc-home-hot-sale">--%>
            <%--</a>--%>
            <%--<span class="money"><em>￥</em><font>${hotSale.price}</font></span>--%>
            <%--<span class="fiery">热卖</span>--%>
            <%--</li>--%>
            <%--</c:forEach>--%>
            <%--</c:if>--%>
            <li>
                <a href="${hotSaleList.get(0).redirect}" target="_blank">
                    <strong>${hotSaleList.get(0).name}</strong>
                    <img class="imgfilter" src="http://pro.efeiyi.com/${hotSaleList.get(0).img}@!pc-home-hot-sale">
                </a>
                <span class="money"><em>￥</em><font>${hotSaleList.get(0).price}</font></span>
                <span class="fiery">热卖</span>
            </li>
            <li>
                <a href="${hotSaleList.get(1).redirect}" target="_blank">
                    <strong>${hotSaleList.get(1).name}</strong>
                    <img class="imgfilter" src="http://pro.efeiyi.com/${hotSaleList.get(1).img}@!pc-home-hot-sale">
                </a>
                <span class="money"><em>￥</em><font>${hotSaleList.get(1).price}</font></span>
                <span class="fiery">热卖</span>
            </li>
            <li>
                <a href="${hotSaleList.get(2).redirect}" target="_blank">
                    <strong>${hotSaleList.get(2).name}</strong>
                    <img class="imgfilter" src="http://pro.efeiyi.com/${hotSaleList.get(2).img}@!pc-home-hot-sale">
                </a>
                <span class="money"><em>￥</em><font>${hotSaleList.get(2).price}</font></span>
                <span class="fiery">热卖</span>
            </li>
            <li>
                <a href="${hotSaleList.get(3).redirect}" target="_blank">
                    <strong>${hotSaleList.get(3).name}</strong>
                    <img class="imgfilter" src="http://pro.efeiyi.com/${hotSaleList.get(3).img}@!pc-home-hot-sale">
                </a>
                <span class="money"><em>￥</em><font>${hotSaleList.get(3).price}</font></span>
                <span class="fiery">热卖</span>
            </li>
            <li>
                <a href="${hotSaleList.get(4).redirect}" target="_blank">
                    <strong>${hotSaleList.get(4).name}</strong>
                    <img class="imgfilter" src="http://pro.efeiyi.com/${hotSaleList.get(4).img}@!pc-home-hot-sale">
                </a>
                <span class="money"><em>￥</em><font>${hotSaleList.get(4).price}</font></span>
                <span class="fiery">热卖</span>
            </li>
            <li>
                <a href="${hotSaleList.get(5).redirect}" target="_blank">
                    <strong>${hotSaleList.get(5).name}</strong>
                    <img class="imgfilter" src="http://pro.efeiyi.com/${hotSaleList.get(5).img}@!pc-home-hot-sale">
                </a>
                <span class="money"><em>￥</em><font>${hotSaleList.get(5).price}</font></span>
                <span class="fiery">热卖</span>
            </li>
            <li>
                <a href="${hotSaleList.get(6).redirect}" target="_blank">
                    <strong>${hotSaleList.get(6).name}</strong>
                    <img class="imgfilter" src="http://pro.efeiyi.com/${hotSaleList.get(6).img}@!pc-home-hot-sale">
                </a>
                <span class="money"><em>￥</em><font>${hotSaleList.get(6).price}</font></span>
                <span class="fiery">热卖</span>
            </li>
            <li>
                <a href="${hotSaleList.get(7).redirect}" target="_blank">
                    <strong>${hotSaleList.get(7).name}</strong>
                    <img class="imgfilter" src="http://pro.efeiyi.com/${hotSaleList.get(7).img}@!pc-home-hot-sale">
                </a>
                <span class="money"><em>￥</em><font>${hotSaleList.get(7).price}</font></span>
                <span class="fiery">热卖</span>
            </li>
            <li>
                <a href="${hotSaleList.get(8).redirect}" target="_blank">
                    <strong>${hotSaleList.get(8).name}</strong>
                    <img class="imgfilter" src="http://pro.efeiyi.com/${hotSaleList.get(8).img}@!pc-home-hot-sale">
                </a>
                <span class="money"><em>￥</em><font>${hotSaleList.get(8).price}</font></span>
                <span class="fiery">热卖</span>
            </li>
            <li>
                <a href="${hotSaleList.get(9).redirect}" target="_blank">
                    <strong>${hotSaleList.get(9).name}</strong>
                    <img class="imgfilter" src="http://pro.efeiyi.com/${hotSaleList.get(9).img}@!pc-home-hot-sale">
                </a>
                <span class="money"><em>￥</em><font>${hotSaleList.get(9).price}</font></span>
                <span class="fiery">热卖</span>
            </li>
        </ul>
    </div>
    <!-- 放banner-->
    <div class="middle-banner"><a href="${bannerActivityList[0].redirect}" target="_blank"><img src="http://pro.efeiyi.com/${bannerActivityList[0].img}@!pc-banner-advertisement"/></a></div>
    <div class="max-cat ae">
        <!--一个类别-->
        <c:forEach items="${recommendedCategoryList}" var="projectCategory">
            <div class="category ae">
                <div class="cat-left">
                    <div class="cat-title">${projectCategory.name}</div>
                    <div class="cat-txt ">${projectCategory.context}</div>
                        <%--<div class="cat-txt c-tx2">不困于情</div>--%>
                    <div class="c-o-list">
                        <c:forEach items="${projectMap.get(projectCategory.id)}" var="project">
                            <a href="<c:url value="/product/list/${project.id}"/>" target="_blank">${project.name}</a>
                        </c:forEach>
                    </div>
                </div>
                <ul class="cat-right">
                        <c:forEach items="${recommendMap.get(projectCategory.id)}" var="projectCategoryProductModel" varStatus="status">
                    <li>
                        <a href="<c:url value="/product/hot/${projectCategoryProductModel.productModel.id}"/>" target="_blank">
                            <strong>${projectCategoryProductModel.productModel.product.name}</strong>
                            <img class="imgfilter" src="http://pro.efeiyi.com/${projectCategoryProductModel.productModel.product.getProductPicture().pictureUrl}@!pc-recommend-list">
                        </a>
                        <span class="cat-money"><em>￥</em><font>${projectCategoryProductModel.productModel.price.intValue()}</font></span>
                    </li>
                        </c:forEach>
                </ul>
            </div>
        </c:forEach>
        <!--一个类别-->
    </div>
</div>
<!--//End--homenew-->
<div class="footernew wh">
    <div class="publ-top hd">
        <dl class="city">
            <dt>正</dt>
            <dd>非&nbsp;遗&nbsp;正&nbsp;品</dd>
        </dl>
        <dl class="city">
            <dt>真</dt>
            <dd>诚&nbsp;品&nbsp;宝&nbsp;保&nbsp;真</dd>
        </dl>
        <dl class="city">
            <dt>好</dt>
            <dd>手&nbsp;工&nbsp;精&nbsp;品</dd>
        </dl>
        <dl class="city">
            <dt>值</dt>
            <dd>好&nbsp;工&nbsp;好&nbsp;料</dd>
        </dl>
    </div>
    <%--<div class="servicenew wh">--%>
    <%--<div class="hd tct">--%>
    <%--<div class=" foremax">--%>
    <%--<dl class="fore">--%>
    <%--<dt>帮助中心</dt>--%>
    <%--<dd><a href="#" target="_blank">购物流程</a></dd>--%>
    <%--<dd><a href="#" target="_blank">配送方式</a></dd>--%>
    <%--<dd><a href="#" target="_blank">常见问题</a></dd>--%>
    <%--</dl>--%>
    <%--<dl class="fore">--%>
    <%--<dt>服务保障</dt>--%>
    <%--<dd><a href="#" target="_blank">正品保障</a></dd>--%>
    <%--<dd><a href="#" target="_blank">7天退货</a></dd>--%>
    <%--</dl>--%>
    <%--<dl class="fore">--%>
    <%--<dt>支付方式</dt>--%>
    <%--<dd><a href="#" target="_blank">支付宝</a></dd>--%>
    <%--<dd><a href="#" target="_blank">微信支付</a></dd>--%>
    <%--<dd><a href="#" target="_blank">银行转账</a></dd>--%>
    <%--</dl>--%>
    <%--<dl class="fore">--%>
    <%--<dt>售后服务</dt>--%>
    <%--<dd><a href="#" target="_blank">售后政策</a></dd>--%>
    <%--<dd><a href="#" target="_blank">退款说明</a></dd>--%>
    <%--<dd><a href="#" target="_blank">退换货</a></dd>--%>
    <%--</dl>--%>
    <%--<dl class="fore">--%>
    <%--<dt>商家服务</dt>--%>
    <%--<dd><a href="#" target="_blank">商家入驻</a></dd>--%>
    <%--<dd><a href="#" target="_blank">商家中心</a></dd>--%>
    <%--<dd><a href="#" target="_blank">运营服务</a></dd>--%>
    <%--</dl>--%>
    <%--<div class="wechatnew" title="手机e飞蚁"></div>--%>
    <%--</div>--%>
    <%--</div>--%>
    <%--</div>--%>
    <%--<div class="max-links wh">--%>
    <%--<div class="links wh">--%>
    <%--<a href="" target="_blank" title="关于我们">关于我们</a>--%>
    <%--<a class="line"></a>--%>
    <%--<a href="" target="_blank" title="联系我们">联系我们</a>--%>
    <%--<a class="line"></a>--%>
    <%--<a href="" target="_blank" title="诚聘英才">诚聘英才</a>--%>
    <%--<a class="line"></a>--%>
    <%--<a href="" target="_blank" title="意见反馈">意见反馈</a>--%>
    <%--<a class="line"></a>--%>
    <%--<a href="" target="_blank" title="帮助中心">帮助中心</a>--%>
    <%--<a class="line"></a>--%>
    <%--<a href="" target="_blank" title="诚信保障">诚信保障</a>--%>
    <%--<a class="line"></a>--%>
    <%--<a href="" target="_blank" title="新闻资讯">新闻资讯</a>--%>
    <%--</div>--%>
    <%--<div class="copyright wh">--%>
    <%--<div class="phone">--%>
    <%--<strong>商家入驻热线</strong>--%>
    <%--<em>400-876-8766</em>--%>
    <%--</div>--%>
    <%--<div class="frlinks">--%>
    <%--<span>友情链接：</span>--%>
    <%--<a rel="nofollow" href="http://www.unesco.org.cn/" target="_blank" title="联合国教科文组织">联合国教科文组织</a>--%>
    <%--<a rel="nofollow" href="http://www.mcprc.gov.cn/" target="_blank" title="中国文化部">中国文化部</a>--%>
    <%--<a rel="nofollow" href="" target="_blank" title="中国文化部非物质文化遗产保护司">中国文化部非物质文化遗产保护司</a>--%>
    <%--<a rel="nofollow" href="" target="_blank" title="中国非物质文化遗产保护中心">中国非物质文化遗产保护中心</a>--%>
    <%--</div>--%>
    <%--<div class="info">Copyright © 2012-2022 永新华韵文化发展有限公司版权所有-京ICP备15032511号-1</div>--%>
    <%--</div>--%>
    <%--<div class="wh authentication">--%>
    <%--<a href="http://www.miitbeian.gov.cn" target="_blank" title="网站域名备案"> <img class="imgfilter" src="../shop2015/images/authentication-1.png" alt="网站域名备案"></a>--%>
    <%--<a href="http://www.baic.gov.cn/" target="_blank" title="企业信用信息备案"> <img class="imgfilter" src="../shop2015/images/authentication-2.png" alt="企业信用信息备案"></a>--%>
    <%--<a href="/scripts/images/license.jpg" target="_blank" title="企业营业执照"> <img class="imgfilter" src="../shop2015/images/authentication-3.png" alt="企业营业执照 "></a>--%>
    <%--</div>--%>
    <%--</div>--%>
</div>
<%--<!--//End--footernew-->--%>
<%--<!--[if (gte IE 9)|!(IE)]><!-->--%>
<%--<script src="../shop2015/js/jquery.min.js"></script>--%>
<%--<!--<![endif]-->--%>
<%--<!--[if lte IE 8 ]>--%>
<%--<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>--%>
<%--<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>--%>
<%--<script src="assets/js/amazeui.ie8polyfill.min.js"></script>--%>
<%--<![endif]-->--%>
<%--<script src="../shop2015/js/system.js"></script>--%>
<!--<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>-->
</body>
</html>
