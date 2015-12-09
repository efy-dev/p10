<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
</head>
<body>
<!--//End--header-->
<div class="gift ae">
    <div class="card custom ae">
        <div class="btb"><h5>礼物卡片</h5></div>
        <div class="cupic ae"><img
                src="http://pro.efeiyi.com/${order.purchaseOrderProductList.get(0).productModel.productModel_url}@!product-hot">
        </div>
    </div>
    <c:if test="${!empty order.giftMessage || !empty order.giftGaverName}">
        <div class="c-info ae">
            <c:if test="${!empty order.giftMessage}">
                <p>${order.giftMessage}</p>
            </c:if>
            <c:if test="${!empty order.giftGaverName}">
                <p>——${order.giftGaverName}</p>
            </c:if>
        </div>
    </c:if>
    <!-- //End-->
    <div class="car-state ae">
        <div class="btb"><h5>礼物状态</h5><span><c:if test="${order.orderStatus=='6'}">未收礼</c:if> <c:if
                test="${order.orderStatus=='5'}">已收礼</c:if></span></div>
        <c:if test="${order.orderStatus=='6'}">
            <div class="btb"><h5>送礼说明</h5></div>
            <div class="btb-text ae">
                <p>方式一：点击“送礼给Ta”，根据提示送礼给好友，好友通过点击收到的链接进入收礼页面，正确填写收货信息后即可收礼。</p>
                <p>方式二：点击“保存为图片”将生成图片形式的礼物卡片，保存图片后发给好友，好友通过识别图片上的二维码进入收礼页面，正确填写收货信息后即可收礼。</p>
            </div>
        </c:if>
    </div>
    <c:if test="${order.orderStatus=='6'}">

        <div class="car-fx">
            <a href="#" id="share">送礼给Ta</a>
            <a href="<c:url value="/createGiftImage/${order.id}"/> ">保存为图片</a>

            <div id="cover" style="display: none;"><em class="bg"></em><img
                    src="<c:url value="/scripts/wap/upload/guide-share.png"/>" alt=""></div>
            <div id="cover2" style="display: none">
                <div class="text-co2">
                    <strong class="cov-titie">提示</strong>

                    <p class="covtext">在浏览器中寻找分享按钮，将本页面链接分享给您的好友吧。</p>

                    <div class="ae" style="text-align: center"><a class="covbtn" href="#">确定</a></div>
                </div>
                <div class="bg"></div>
            </div>
        </div>
    </c:if>
    <c:if test="${!empty content}">
    <div class="logistics ae">
        <div class="part">
            <ul>
                <li><span>物流状态：</span><em><ming800:status name="orderStatus" dataType="PurchaseOrder.orderStatus"
                                                          checkedValue="${order.orderStatus}" type="normal"/></em></li>
                <li><span>物流公司：</span><em><ming800:status name="logisticsCompany"
                                                          dataType="PurchaseOrderDelivery.logisticsCompany"
                                                          checkedValue="${lc}" type="normal"/></em></li>
                <li><span>运单编号：</span><em>${serial}</em></li>
            </ul>
        </div>
        <div class="part">
            <h5>物流跟踪</h5>

            <div style="width:100%;overflow: hidden;float:left;margin-left:-73px;">
                <iframe id="kuaidi100" name="kuaidi100" src="${content}" width="600" height="380" marginwidth="12"
                        marginheight="10" hspace="11" vspace="10" frameborder="0" scrolling="no"></iframe>
            </div>
        </div>
    </div>
</div>
</c:if>
<script type="text/javascript">
    $(function () {
        if ($('div').hasClass('car-fx')) {
            $('.car-state').css({'padding-bottom': '50px'});
        }
    })


    $().ready(function () {
        $("#share").click(function () {
            if (isWeiXin()) {
                $("#cover").show();
            } else {
                $("#cover2").show();
            }
        })
    })
</script>
</body>
</html>