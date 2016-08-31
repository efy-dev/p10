<%@ page import="com.ming800.core.p.PConst" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<!doctype html>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>查看收货订单信息</title>
</head>
<body>

<!-- //End--header-->
<!--content-->
<div class="layout-col">
    <div class="mt wh1">
        <div class="extra-l">
            <strong>订单信息</strong>
        </div>
    </div>
    <div class="orderinfo">
        <dl class="orderid-mashup" style="margin-bottom: 15px;">
            <dt class="orderid">订单</dt>
            <dd class="od-id">
                <p>订单号：<span>${order.serial}</span></p>

                <p>订单金额：<span>${order.total}</span></p>
                <c:if test="${order.orderStatus!=1}">
                    <p>订单状态：<span><ming800:status name="orderStatus" dataType="PurchaseOrder.orderStatus"
                                                  checkedValue="${order.orderStatus}" type="normal"/></span></p>
                </c:if>
                <c:if test="${order.orderStatus==1}">
                    <p>订单状态：<span><ming800:status name="orderStatus" dataType="PurchaseOrder.orderStatus"
                                                  checkedValue="${order.orderStatus}" type="normal"/></span><a
                            class="od-id-btn" href="<%=PConst.NEWWEBURL%>/order/pay/${order.id}" title="去付款">去付款</a></p>
                </c:if>
            </dd>
        </dl>

        <dl class="orderid-mashup bd-top">
            <dt class="orderid">商品信息</dt>
            <dd class="od-id">
                <c:forEach items="${order.purchaseOrderProductList}" var="op">
                    <table class="item-bg">
                        <tr>
                            <td class="commodity_info1">
                                <ul class="commodity_info-1">
                                    <li class="l1 informala"><a
                                            href="<%=PConst.NEWWEBURL%>/product/productModel/${op.productModel.id}"
                                            style="outline: none"><img
                                            src="http://pro.efeiyi.com/${op.productModel.productModel_url}@!product-icon"></a>
                                    </li>
                                </ul>
                            </td>
                            <td class="commodity_price_unit1  price9"><a
                                    href="<%=PConst.NEWWEBURL%>/product/productModel/${op.productModel.id}">
                                    ${op.productModel.product.name}
                                        <c:if test="${op.productModel.product.productModelList.size()>1}">
                                            [${op.productModel.name}]
                                        </c:if>
                            </a></td>

                            <td class="commodity_quantity  amount">x<span>${op.purchaseAmount}</span></td>
                            <td class="commodity_price  price8">￥${op.purchasePrice * op.purchaseAmount}</td>
                        </tr>
                    </table>
                </c:forEach>
            </dd>
        </dl>
        <%--<c:if test="${!empty purchaseOrderDelivery}">--%>
        <c:if test="${!empty pl}">

            <dl class="orderid-mashup bd-top">
                <dt class="orderid">物流信息</dt>
                <dd class="od-id">
                    <p>店铺名称：<span>${pl.purchaseOrder.tenant.name}</span></p>

                    <p>物流方式：<span>普通快递</span></p>

                    <p>物流公司：<span><ming800:status name="logisticsCompany"
                                                  dataType="PurchaseOrderDelivery.logisticsCompany"
                                                  checkedValue="${pl.logisticsCompany}" type="normal"/></span></p>

                    <p>运单号码：<span>${pl.serial}</span></p>

                    <p style="cursor: pointer" id="act-q" name="ss" test="${dl}"> 物流查看：&nbsp;&nbsp;物流跟踪</p></li>
                    <div class="list-express" style="display: none; margin-left: 30px;">
                        <iframe id="kuaidi100" name="kuaidi100" src="${dl}" width="600" height="380" marginwidth="12"
                                marginheight="10" hspace="11" vspace="10" frameborder="0" scrolling="no"></iframe>
                    </div>
                </dd>
            </dl>

            <%--</c:if>--%>


        </c:if>
        <c:if test="${order.orderType=='3'}">
            <dl class="orderid-mashup bd-top">
                <dt class="orderid">收货信息</dt>
                <dd class="od-id">
                    <p>收货地址：<span>${order.purchaseOrderAddress}</span></p>

                    <p>收货人姓名：<span>${order.receiverName}</span></p>

                    <p>联系电话：<span>${order.receiverPhone}</span></p>

                </dd>
            </dl>
        </c:if>
        <dl class="orderid-mashup bd-top item-list5">
            <dt class="orderid">支付及配送方式</dt>
            <dd class="od-id">
                <p>支付方式：<span><ming800:status name="payWay" dataType="PurchaseOrder.payWay"
                                              checkedValue="${order.payWay}" type="normal"/>
              <strong style="font-size: 12px;color:#ff0000;font-weight: 100">共支付${order.total-couponPrice}元 <c:if
                      test="${coupon==1}">
                  ,优惠券抵扣${couponPrice}元
              </c:if></strong></p>

                <p>配送方式：<span>普通快递</span></p>

                <p>运费：<span>
                    <c:if test="${empty order.freight}">
                        免运费
                    </c:if>
                    <c:if test="${!empty order.freight}">
                          ${order.freight}
                    </c:if>
                </span></p>
            </dd>
        </dl>
    </div>
</div>
</div>
<script>
    $(function () {
        $("p[name='ss']").mouseenter(function () {
            $(this).siblings('.list-express').slideToggle();

        })
    })

</script>
</div>
<!-- //End--header-->

<!-- //End--footer-->
</div>

</body>
</html>