<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>${groupProduct.productModel.product.name}${groupProduct.productModel.name}${groupProduct.productModel.product.subName}</title>
    <!-- Set render engine for 360 browser -->
    <meta name="renderer" content="webkit">
    <!-- No Baidu Siteapp-->
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="icon" type="image/png" href="/resources/assets/i/favicon.png">
    <!-- Add to homescreen for Chrome on Android -->
    <meta name="mobile-web-app-capable" content="yes">
    <link rel="icon" sizes="192x192" href="/resources/assets/i/app-icon72x72@2x.png">
    <!-- Add to homescreen for Safari on iOS -->
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <link rel="apple-touch-icon-precomposed" href="/resources/assets/i/app-icon72x72@2x.png">
    <!-- Tile icon for Win8 (144x144 + tile color) -->
    <meta name="msapplication-TileImage" content="/resources/assets/i/app-icon72x72@2x.png">
    <meta name="msapplication-TileColor" content="#0e90d2">
    <script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
    <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/wap/css/amazeui.min.css"/>">
    <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/wap/css/app.css?v=20150831"/>">
    <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/wap/css/myorder.css?v=20150831"/>">
</head>
<body>
<header class="am-header custom-header">
    <div class="am-header-left am-header-nav">
        <a href="javascript:history.go(-1)" class="chevron-left"></a>
    </div>
    <!-- //End--chevron-left-->
    <h1 class="am-header-title" style="margin: 0 10%;">我的团长我的团</h1>
    <!-- //End--title-->
    <div class="am-header-right am-header-nav am-header-right1">
        <a href="<c:url value="/person/personInfoView.do"/>" class="chevron-right" id="menu">
            <i class="icon icon-user"></i>
        </a>
    </div>
</header>
<!--//End--header-->
<div class="my-colonel ae">
    <!--产品-->
    <div class="colonel-pic ae"><img src="http://pro.efeiyi.com/${groupProduct.productModel.productModel_url}@!tg-efeiyi-view-list"><div class="c-page"><span>${groupProduct.productModel.product.name}${groupProduct.productModel.name}${groupProduct.productModel.product.subName}</span></div></div>
    <!--价格-->
    <div class="cost ae">
        <div class="txt1"><s>原价:${groupProduct.productModel.price}元</s></div>
        <div class="txt2"><em>拼团价:${groupProduct.groupPrice}元</em><i class="icon"></i></div>
    </div>
    <!--功能-->
    <div class="iwill ae">
        <div class="page ae"><div class="left"><p>分享红包:${groupProduct.bonus}元</p></div><div class="right"><p>${groupProduct.memberAmount}人起成团</p><p>成团时间${groupProduct.groupPurchaseTime}天</p></div></div>
        <a href="<c:url value="/group/groupBuy?groupProductId="/>"+${groupProduct.id} class="btn">我&nbsp;要&nbsp;开&nbsp;团</a>
        <div class="txt3 ae"><span>开团当团长，分享赚红包！在规定时间内，好友通过您的链接成功参团，拼团成功后，红包就是你的了！红包无上限，更多分享，更多红包！</span></div>
    </div>
    <!-- 选项卡-->
    <div class="colonel-table ae">
        <!--产品-->
        <div class="c-title ae">
            <ul>
                <li class="active">产品介绍</li>
                <li>评论</li>
            </ul>
        </div>
        <!--评论-->
        <div class="c-content ae">
            <div class="co-page">
                <div class="introduce ae">
                    ${groupProduct.productModel.product.productDescription.content}
                    <div class="button ae"><a href="$" class="gbtn"><span>原价直接购买</span><i class="icon1"></i></a></div>
                </div>
                <a class="efeiyi-btn" href="<c:url value="/group/protocol"/>">e飞蚁拼团协议<i class="efiyi"></i></a>
            </div>
            <div class="co-page" style="display: none">
                <c:if test="${not empty purchaseOrderProductList&&fn:length(purchaseOrderProductList) >0}">
                <div class="col-pl ae">
                    <ul class="ae">
                        <c:forEach items="${purchaseOrderProductList}" var="purchaseOrderProduct" varStatus="rec">
                           <c:if test="${not empty purchaseOrderProduct.purchaseOrderComment&&purchaseOrderProduct.purchaseOrderComment.status!='0'}">
                             <li>
                                 <c:set var="user">
                                     ${purchaseOrderProduct.purchaseOrder.user.getUsername()}
                                 </c:set>
                                 <div class="co-pic"><img class="am-circle" src="<c:url value="/scripts/wap/upload/yonghm.jpg"/>"></div><h5>${fn:substring(user, 0,3 )}****${fn:substring(user,7,11)}</h5><P>${purchaseOrderProduct.purchaseOrderComment.content}</P><p><strong></strong></p></li>
                            </li>
                          </c:if>
                        </c:forEach>

                    </ul>
                </div>
                </c:if>
                <%--<div class="more ae"><a href="javascript:void(0)"><span>下拉加载更多...</span><div class="icon"></div></a></div>--%>
            </div>
        </div>
    </div>
</div>
<!--//End--footer-->

<!--[if (gte IE 9)|!(IE)]><!-->
<script src="<c:url value="/scripts/wap/js/jquery.min.js"/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="/resources/assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<!--自定义js--Start-->
<script src="<c:url value="/scripts/wap/js/system.js?v=20150831"/>"></script>
<script src="<c:url value="/scripts/wap/js/myorder.js"/>"></script>
<script>
    $().ready(function(){
        $("img").each(function(){
            $(this).css("width","100%");
        })
    })
</script>
<!--自定义js--End-->
</body>
</html>