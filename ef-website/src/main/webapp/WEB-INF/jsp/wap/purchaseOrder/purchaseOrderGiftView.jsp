<%@ page import="com.efeiyi.ec.website.organization.util.AuthorizationUtil" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
    <script>
        var gobackUrl = "<c:url value="/product/productModel/${order.purchaseOrderProductList.get(0).productModel.id}"/>"
    </script>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>${order.giftGaverName}送您礼物了，快快点击去收礼吧</title>
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
    <img src="http://pro.efeiyi.com/${order.purchaseOrderProductList.get(0).productModel.productModel_url}@!wap-product-pic"
         style="position: absolute;left: 0;top: -1000px;width: 100%">

</head>


<body>
<header class="am-header custom-header">
    <div class="am-header-left am-header-nav">
        <a href="javascript:history.go(-1)" class="chevron-left"></a>
    </div>
    <!-- //End--chevron-left-->
    <h1 class="am-header-title">礼物订单</h1>
    <!-- //End--title-->
    <div class="am-header-right am-header-nav">
        <a href="#chevron-right" class="chevron-right" id="menu">
            <i class="line"></i>
        </a>
    </div>
    <!-- //End--chevron-left-->
    <div class="menu-list">
        <ul class="bd">
            <li><a href="http://www.efeiyi.com" title="首页">首页</a></li>
            <li><a href="<c:url value="/cart/view"/> " title="购物车">购物车</a></li>
            <% if (AuthorizationUtil.isAuthenticated()) {%>
            <li><a href="http://i.efeiyi.com" title="个人中心">个人中心</a></li>
            <%} else {%>
            <li><a href="<c:url value="/sso.do"/>" title="个人中心">个人中心</a></li>
            <%}%>
            <li><a href="<c:url value="/productCategoryList.do"/>" title="个人中心">分类</a></li>
        </ul>
    </div>
</header>
<!--//End--header-->
<div id="cardDiv" class="gift ae">
    <div class="card custom ae">
        <div class="btb"><h5>礼物卡片</h5></div>
        <div class="pic-page ae">
            <div class="pic-img"><img
                    src="http://pro.efeiyi.com/${order.purchaseOrderProductList.get(0).productModel.productModel_url}@!gift-card-picture"
                    width="181"></div>
            <div class="pic-text">
                <p>${productName}</p>
                <p class="t2"><i></i><span>${projectName}</span><em></em></p>
                <p class="t4">数量：<span>${order.purchaseOrderProductList.get(0).purchaseAmount}</span>个</p>
            </div>
        </div>
    </div>
    <div class="c-info ae" style="margin-top:0;">
        <c:if test="${not empty giftMessage}">
            <p>${giftMessage}</p>
        </c:if>
        <c:if test="${not empty sender}">
            <p>——${sender}</p>
        </c:if>
    </div>
    <!-- //End-->
    <div class="car-state ae" style="padding-bottom: 0px;">
        <div class="btb"><h5>礼物状态</h5><span id="giftStatus"><c:if test="${order.orderStatus=='6'}">未收礼</c:if>
            <c:if test="${order.orderStatus!='6'&&order.orderStatus!='1'}">已收礼</c:if></span></div>
        <c:if test="${order.orderStatus=='6'||order.orderStatus=='1'}">
            <div class="btb"><h5>送礼说明</h5></div>
            <div class="btb-text ae">
                <p>方式一：点击“送礼给Ta”，根据提示送礼给好友，好友通过点击收到的链接进入收礼页面，正确填写收货信息后即可收礼。</p>

                <p>方式二：点击“保存为图片”将生成图片形式的礼物卡片，保存图片后发给好友，好友通过识别图片上的二维码进入收礼页面，正确填写收货信息后即可收礼。</p>
                <%--<p>方式三：短信送礼，点击”复制链接“，根据提示复制链接,将链接地址通过短信发给好友，好友点击链接，填入收货地址即可收礼。</p>--%>
            </div>
        </c:if>
        <div class="btn-again">
            <a href="<c:url value="/order/giftBuy/${order.purchaseOrderProductList.get(0).productModel.id}/${order.purchaseOrderProductList.get(0).purchaseAmount}"/>"
               title="再买一份">再买一份</a>
        </div>
        <div class="btn-again" style="margin-top: 0">
            <a href="<c:url value="/order/easyBuy/${order.purchaseOrderProductList.get(0).productModel.id}?amount=${order.purchaseOrderProductList.get(0).purchaseAmount}"/>" title="送给自己">送给自己</a>
        </div>

    </div>
    <c:if test="${order.orderStatus!='6'}">
    <div class="car-fx" id="giftButton">
        </c:if>
        <c:if test="${order.orderStatus=='6'}">
        <div class="car-fx" id="giftButton">
            </c:if>
            <a href="#" id="share" style="width: 75%">送礼给Ta</a>
            <a href="<c:url value="/createGiftImage/${order.id}"/> ">保存为图片</a>

            <div id="cover" style="display: none;"><em class="bg"></em><img
                    src="<c:url value="/scripts/wap/upload/guide-share.png"/>" alt=""></div>
            <div id="cover2" style="display: none">
                <div class="text-co2">
                    <strong class="cov-titie">提示</strong>

                    <p class="covtext">在浏览器中寻找分享按钮，将本页面链接分享给您的好友吧。</p>

                    <div class="ae" style="text-align: center"><a class="covbtn">确定</a></div>
                </div>
                <div class="bg"></div>
            </div>
        </div>


        <c:if test="${!empty content}">
            <div class="logistics ae">
                <div class="part">
                    <ul>
                        <li><span>物流状态：</span><em><ming800:status name="orderStatus"
                                                                  dataType="PurchaseOrder.orderStatus"
                                                                  checkedValue="${order.orderStatus}"
                                                                  type="normal"/></em>
                        </li>
                        <li><span>物流公司：</span><em><ming800:status name="logisticsCompany"
                                                                  dataType="PurchaseOrderDelivery.logisticsCompany"
                                                                  checkedValue="${lc}" type="normal"/></em></li>
                        <li><span>运单编号：</span><em>${serial}</em></li>
                    </ul>
                </div>


                    <%--<a id="showPostStatus1">查看物流</a>--%>

                <a id="showPostStatus"
                   style="width:100%; float:left;text-align:center;margin-top: 10px;padding: 1rem 0.9rem;font-size: 1rem;border: 1px solid #ccc;background: #000;color: #fff;">
                    查看物流
                </a>

                    <%--<div class="part">--%>
                    <%--<h5>物流跟踪</h5>--%>

                    <%--<div style="width:100%;overflow: hidden;float:left;margin-left:-73px;">--%>
                    <%--<iframe id="kuaidi100" name="kuaidi100" src="${content}" width="600" height="380" marginwidth="12"--%>
                    <%--marginheight="10" hspace="11" vspace="10" frameborder="0" scrolling="no"></iframe>--%>
                    <%--</div>--%>
                    <%--</div>--%>
            </div>

        </c:if>

    </div>
</div>
<br>
<br>
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
<script type="text/javascript">
    $(function () {


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


        if ($('div').hasClass('car-fx')) {
            $('#cardDiv').css({'padding-bottom': '50px'});
        }
    })

    <c:if test="${order.orderStatus!='6' && order.orderStatus!='5'}">
    function checkOrderStatus() {
        ajaxRequest("<c:url value="/order/checkOrderStatus.do"/>", {"purchaseOrderId": "${order.id}"}, function (data) {
            if (data == "6") {
                $("#giftButton").show();
                $("#giftStatus").html("未收礼");
            } else {
                setTimeout("checkOrderStatus()", 2000);
            }
        }, function () {
        }, "post");
    }

    checkOrderStatus();

    </c:if>


    $().ready(function () {
        $("#share").click(function () {
            if (isWeiXin()) {
                $("#cover").show();
                $(".custom-header").css("z-index", "0");
            } else {
                $("#cover2").show();
                $(".custom-header").css("z-index", "0");
            }
        })

        $(".covbtn").click(function () {
            $("#cover2").hide();
        })

        $('#cover').click(function () {
            $(this).hide();
        })
    })
</script>


</body>


</html>