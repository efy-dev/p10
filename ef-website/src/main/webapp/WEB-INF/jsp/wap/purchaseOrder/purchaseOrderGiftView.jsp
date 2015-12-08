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
        <div class="cupic ae"><img src="http://pro.efeiyi.com/${order.purchaseOrderProductList.get(0).productModel.productModel_url}@!product-icon"></div>
    </div>
    <div class="c-info ae">
        <p>${order.giftMessage}</p>
        <p>——${order.giftGaverName}</p>
    </div>
    <!-- //End-->
    <div class="car-state ae">
        <div class="btb"><h5>礼物状态</h5><span><c:if test="${order.orderStatus=='6'}">未收礼</c:if> <c:if
                test="${order.orderStatus=='5'}">已收礼</c:if></span></div>
    </div>
    <c:if test="${!empty content}">
    <div class="logistics ae">
        <div class="part">
            <h4>感谢您收下礼物，快递小哥正在拼命配送中。</h4>
            <ul>
                <li><span>物流状态：</span><em><ming800:status name="orderStatus" dataType="PurchaseOrder.orderStatus" checkedValue="${order.orderStatus}" type="normal"/></em></li>
                <li><span>物流公司：</span><em><ming800:status name="logisticsCompany" dataType="PurchaseOrderDelivery.logisticsCompany" checkedValue="${lc}" type="normal"/></em></li>
                <li><span>运单编号：</span><em>${serial}</em></li>
            </ul>
        </div>
        <div class="part">
            <h5>物流跟踪</h5>
            <div style="width:100%;overflow: hidden;float:left;margin-left:-73px;"><iframe id="kuaidi100" name="kuaidi100" src="${content}" width="600" height="380" marginwidth="12" marginheight="10" hspace="11" vspace="10" frameborder="0" scrolling="no"></iframe></div>
        </div>
    </div>
</div>
</c:if>
<script type="text/javascript">
    $(function(){
        if($('div').hasClass('car-fx')){
            $('.car-state').css({'padding-bottom':'50px'});
        }
    })
</script>
</body>
</html>