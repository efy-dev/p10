<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>礼物订单-物流信息</title>
    <!-- Set render engine for 360 browser -->
    <meta name="renderer" content="webkit">
    <!-- No Baidu Siteapp-->
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="icon" type="image/png" href="assets/i/favicon.png">
    <!-- Add to homescreen for Chrome on Android -->
    <meta name="mobile-web-app-capable" content="yes">
    <link rel="icon" sizes="192x192" href="assets/i/app-icon72x72@2x.png">
    <!-- Add to homescreen for Safari on iOS -->
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <link rel="apple-touch-icon-precomposed" href="assets/i/app-icon72x72@2x.png">
    <!-- Tile icon for Win8 (144x144 + tile color) -->
    <meta name="msapplication-TileImage" content="assets/i/app-icon72x72@2x.png">
    <meta name="msapplication-TileColor" content="#0e90d2">
    <img src="http://pro.efeiyi.com/${purchaseOrder.purchaseOrderProductList.get(0).productModel.productModel_url}@!wap-product-pic"
         style="position: absolute;left: 0;top: -1000px;width: 100%">
</head>
<body>
<div id="cardDiv" class="gift ae">
    <div class="card custom ae">
        <div class="btb"><h5>礼物卡片</h5></div>
        <div class="pic-page ae">
            <div class="pic-img">
                <c:if test="${purchaseOrderGift.showGiftNameStatus=='1'}">
                <a  href="<c:url value="/product/productModel/${purchaseOrder.purchaseOrderProductList.get(0).productModel.id}"/>">
                    </c:if>
                        <c:if test="${purchaseOrderGift.showGiftNameStatus=='0'}">
                        <a>
                            </c:if>
                     <img
                    src="http://pro.efeiyi.com/${purchaseOrder.purchaseOrderProductList.get(0).productModel.productModel_url}@!gift-card-picture"
                    width="181" height="101">
                     </a>
            </div>
            <div class="pic-text">
                <p>
                    <c:if test="${purchaseOrderGift.showGiftNameStatus=='1'}">
                    <a  href="<c:url value="/product/productModel/${purchaseOrder.purchaseOrderProductList.get(0).productModel.id}"/>" style="color: #000">
                        </c:if>
                            <c:if test="${purchaseOrderGift.showGiftNameStatus=='0'}">
                            <a style="color: #000">
                                </c:if>
                ${purchaseOrder.purchaseOrderProductList.get(0).productModel.product.name}</a></p>

                <p class="t2">
                    <i></i><span>${purchaseOrder.purchaseOrderProductList.get(0).productModel.product.project.name}</span><em></em>
                </p>
            </div>
        </div>
        <c:if test="${not empty purchaseOrder.giftMessage}">
            <div class="c-info ae" style="margin-top:0;">
                <p>${purchaseOrder.giftMessage}</p>
                <c:if test="${not empty purchaseOrder.giftGaverName}">
                    <p>——${purchaseOrder.giftGaverName}</p>
                </c:if>
            </div>
        </c:if>
    </div>
    <!-- //End-->
    <div class="logistics ae">
        <div class="part">
            <c:if test="${purchaseOrder.orderStatus=='5'}">
                <h4>感谢您收下礼物，礼物正在准备出库。</h4>
            </c:if>
            <c:if test="${purchaseOrder.orderStatus=='7'}">
                <h4>感谢您收下礼物，快递小哥正在拼命配送中。</h4>
                <ul>
                    <li><span>物流公司：</span><em><c:if test="${not empty lc}"><ming800:status name="logisticsCompany"
                                                                                           dataType="PurchaseOrderDelivery.logisticsCompany"
                                                                                           checkedValue="${lc}"
                                                                                           type="normal"/></c:if> </em>
                    </li>
                    <li><span>运单编号：</span><em><c:if test="${not empty serial}">${serial}</c:if> </em></li>
                </ul>
            </c:if>
        </div>

        <c:if test="${!empty content}">
            <%--<a id="showPostStatus1">查看物流</a>--%>

            <a id="showPostStatus"
               style="width:100%; float:left;text-align:center;margin-top: 10px;padding: 1rem 0.9rem;font-size: 1rem;border: 1px solid #ccc;background: #000;color: #fff;">
                查看物流
            </a>
        </c:if>
        <div class="registration"><p>也想送好礼？</p><p>10秒注册，更多好礼等着你。</p></div>
    </div>
</div>

<div id="postDiv" class="part" style="display: none;">

    <div>
        <a id="showGiftCard"
           style=" float:left;text-align:center;margin-top: 10px;padding: 1rem 0.9rem;font-size: 1rem;border: 1px solid #ccc;background: #000;color: #fff;">
            返回查看礼品卡
        </a>
    </div>
    <br>
    <br>
    <br>

    <h5>物流跟踪</h5>

    <div style="width:100%;float:left;margin-left:-34px;">
        <iframe id="kuaidi100" name="kuaidi100" src="${content}" width="600" height="380" marginwidth="12"
                marginheight="10" hspace="11" vspace="10" frameborder="0" scrolling="no"></iframe>
    </div>

</div>
<br>
<c:if test="${purchaseOrder.orderStatus!='6'}">

    <div class="login-reg">
        <a href="<c:url value="/sso.do"/>" class="btn-login" title="登录">登&nbsp;&nbsp;&nbsp;&nbsp;录</a>
        <a id="signin"
           href="http://passport.efeiyi.com/register?service=http://www.efeiyi.com/sso.do?registeSuccess=/registerSuccess.do"
           class="btn-reg"
           onclick="register()">注&nbsp;&nbsp;&nbsp;&nbsp;册</a>
    </div>

<footer class="footer-new">
    <div class="bd authentication">
        <h3>战略合作伙伴</h3>

        <div class="bd">
            <a class="icon1" href="http://en.unesco.org/" title="联合国教科文组织"></a>
            <em class="line"></em>
            <a class="icon2" href="http://www.efeiyi.com" title="e飞蚁"></a>
            <em class="line"></em>
            <a class="icon3" title="中国非物质文化遗产保护协会"></a>
        </div>
    </div>
    <div class="bd info">
        <a class="icon" href="http://www.efeiyi.com"></a>

        <div class="txt">中&nbsp;&nbsp;国&nbsp;&nbsp;非&nbsp;&nbsp;遗&nbsp;&nbsp;电&nbsp;&nbsp;商&nbsp;&nbsp;平&nbsp;&nbsp;台
        </div>
        <div class="wechat"><img src="/scripts/images/icon-wechat.png"></div>
        <div class="txt">关注微信公众号</div>
        <div class="txt">领取超值代金券</div>
    </div>
    <%--<div class="bd info">--%>
    <%--<a class="icon"></a>--%>

    <%--<div class="txt">中&nbsp;&nbsp;国&nbsp;&nbsp;非&nbsp;&nbsp;遗&nbsp;&nbsp;电&nbsp;&nbsp;商&nbsp;&nbsp;平&nbsp;&nbsp;台--%>
    <%--</div>--%>
    <%--<div class="wechat"  id="wechat"><img src="/scripts/images/icon-wechat.png"></div>--%>
    <%--<div class="txt" id="wechatStr1">关注微信公众号</div>--%>
    <%--<div class="txt"id="wechatStr2">领取好礼</div>--%>
    <%--</div>--%>
    <div class="bd copyright">京ICP备15032511号-1</div>
</footer>
</c:if>
<script>
    $().ready(function () {
        $("#showPostStatus").click(function () {
            $("#postDiv").slideToggle();
            $("#cardDiv").slideToggle();
            $("#header").slideToggle();
        });

        $("#showGiftCard").click(function () {
            $("#postDiv").slideToggle();
            $("#cardDiv").slideToggle();
            $("#header").slideToggle();
        });
    });
</script>
</body>
</html>