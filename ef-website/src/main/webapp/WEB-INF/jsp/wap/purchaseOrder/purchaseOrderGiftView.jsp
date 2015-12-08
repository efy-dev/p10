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
        <div class="edit-text">
            <em>${order.giftMessage}</em>
        </div>
        <div class="cupic ae"><img src="${order.giftPictureUrl}"></div>
    </div>
    <div class="car-state">
        <div class="btb"><h5>礼物状态</h5><span><c:if test="${order.orderStatus=='6'}">未收礼</c:if> <c:if
                test="${order.orderStatus=='5'}">已收礼</c:if> </span></div>
        <div class="btb"><h5>送礼说明</h5></div>
        <div class="btb-text ae">
            <p>1、点击“送礼给Ta”，根据提示送礼给好友，好友通过点击收到的链接开启收礼姿势，正确填写收货信息后即可收礼。 </p>

            <p>2、点击“保存为图片”将生成图片形式的礼物卡片，保存图片后发给好友，好友通过识别图片上的二维码开启收礼姿势，正确填写收货信息后即可收礼。</p>

        </div>
    </div>
    <div class="car-fx">
        <a href="#" id="btn">送礼给Ta</a>
        <a href="<c:url value="/createGiftImage/${order.id}"/> ">保存为图片</a>
        <div id="cover" style="display: none;"><em class="bg"></em><img src="<c:url value="/scripts/wap/upload/guide-share.png"/>"alt=""></div>
    </div>
</div>
</body>
</html>