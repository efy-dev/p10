<%@ page import="com.ming800.core.p.PConst" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/29
  Time: 16:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>订单详情</title>
</head>
<body>
<!--//End--header-->
<c:if test="${order.orderStatus == 3 or order.orderStatus == 1 or order.orderStatus == 17 or order.orderStatus == 5 or order.orderStatus == 9 or order.orderStatus == 13 or order.orderStatus==6}">
    <div class="line-item">
        <c:if test="${order.orderType=='3'}">
            <div class="address">
                <p><span>${order.receiverName}</span><span>${order.receiverPhone}</span></p>

                <p>${order.purchaseOrderAddress}</p>
            </div>
        </c:if>
        <div class="order-content">
            <div class="order-header">
                <p>订单号：<span>${order.serial}</span></p>
            </div>
            <!--一个商品-->
            <c:forEach items="${order.purchaseOrderProductList}" var="purchaseOrderProduct">
                <div class="order-js-list">
                        <%--<h1>${order.tenant.name}</h1>--%>
                    <div>
                        <hr data-am-widget="divider" style="" class=" am-divider-default"/>
                    </div>
                    <div class="am-g am-intro-bd">
                        <div class="am-intro-left am-u-sm-5 item-act"><a
                                href="<%=PConst.HOSTNAME%>/product/productModel/${purchaseOrderProduct.productModel.id}"><img
                                class="am-u-sm-12 item-act"
                                src="<c:url value="http://pro.efeiyi.com/${purchaseOrderProduct.productModel.productModel_url}"/>"
                                alt="产品"/></a></div>
                        <div class="am-intro-right am-u-sm-7 item-act">
                            <a href="<%=PConst.HOSTNAME%>/product/productModel/${purchaseOrderProduct.productModel.id}">
                                <p class="item-acr">
                                        ${purchaseOrderProduct.productModel.product.name}[${purchaseOrderProduct.productModel.name}]

                                </p></a>

                            <p class="item-rmb">
                                ￥${purchaseOrderProduct.purchasePrice}<span>x${purchaseOrderProduct.purchaseAmount}</span>
                            </p>
                        </div>
                    </div>
                    <div class="am-form-group">
                        <p></p>
                    </div>
                </div>
            </c:forEach>
            <!--一个商品-->
            <!--一个商品-->
        </div>
        <div class="btn-payment">
            <a href="#">
        <span>支付方式 <strong class="sp-active">
            <c:if test="${order.payWay=='1'}">
                支付宝
            </c:if>
            <c:if test="${order.payWay=='2'}">
                银行卡
            </c:if>
            <c:if test="${order.payWay=='3'}">
                微信
            </c:if>
        </strong></span>
            </a>
        </div>
        <ul class="figure">
            <c:if test="${coupon==1}">
                <li><span>总金额</span><span>￥${order.total}</span></li>
                <li><span>优惠券金额</span><span>￥${couponPrice}</span></li>
                <c:if test="${order.orderStatus==1}">
                    <li><span>应付金额</span><span>￥${order.total-couponPrice}</span></li>
                </c:if>
                <c:if test="${order.orderStatus !=1}">
                    <li><span>已付金额</span><span>￥${order.total-couponPrice}</span></li>
                </c:if>
            </c:if>
            <c:if test="${coupon==0}">
                <li><span>总金额</span><span>￥${order.total}</span></li>
                <li><span>优惠券金额</span><span>￥0</span></li>
                <c:if test="${order.orderStatus==1}">
                    <li><span>应付金额</span><span>￥${order.total-couponPrice}</span></li>
                </c:if>
                <c:if test="${order.orderStatus !=1}">
                    <li><span>已付金额</span><span>￥${order.total-couponPrice}</span></li>
                </c:if>
            </c:if>
        </ul>
    </div>
</c:if>
<c:if test="${order.orderStatus == 7 }">
    <div class="line-item">
        <div class="address">
            <p><span>${order.receiverName}</span><span>${order.receiverPhone}</span></p>

            <p>${order.purchaseOrderAddress}</p>
        </div>
        <div class="order-content">
            <div class="order-header">
                <p>订单号：<span>${order.serial}</span></p>
            </div>
            <!--订单状态为已付款-->

            <!--订单状态为已付款-->
            <!--一个商品-->
            <div class="order-js-list">
                    <%--<h1>${order.tenant.name}</h1>--%>
                <div>
                    <hr data-am-widget="divider" style="" class=" am-divider-default"/>
                </div>
                <c:forEach items="${order.purchaseOrderProductList}" var="purchaseOrderProduct">
                    <div class="am-g am-intro-bd">
                        <div class="am-intro-left am-u-sm-5 item-act"><a href="#"><img class="am-u-sm-12 item-act"
                                                                                       src="<c:url value="http://pro.efeiyi.com/${purchaseOrderProduct.productModel.productModel_url}"/>"
                                                                                       alt="产品"/></a></div>
                        <div class="am-intro-right am-u-sm-7 item-act">
                            <p class="item-acr">${purchaseOrderProduct.productModel.product.name}
                                <c:if test="${purchaseOrderProduct.productModel.product.productModelList.size()>1}">
                                    [${purchaseOrderProduct.productModel.name}]
                                </c:if>
                            </p>

                            <p class="item-rmb">
                                ￥${purchaseOrderProduct.purchasePrice}<span>x${purchaseOrderProduct.purchaseAmount}</span>
                            </p>

                        </div>
                    </div>
                </c:forEach>
                <div class="am-form-group">
                    <div class="am-form-group">
                        <p></p>
                    </div>
                </div>
            </div>
            <div class="order-js-list">
                <h1>
                    <p><ming800:status name="logisticsCompany" dataType="PurchaseOrderDelivery.logisticsCompany"
                                       checkedValue="${pl.logisticsCompany}" type="normal"/></p>

                    <p>快递单号：<span>${pl.serial}</span></p>
                </h1>
                <div>
                    <hr data-am-widget="divider" style="" class=" am-divider-default"/>
                </div>
                <div style="float:left;margin-left: -73px;">
                    <iframe id="kuaidi100" name="kuaidi100" src="${dl}" width="600" height="380" marginwidth="12"
                            marginheight="10" hspace="11" vspace="10" frameborder="0" scrolling="no"></iframe>
                </div>
            </div>

            <!--一个商品-->
        </div>
        <div class="btn-payment">
            <a href="#">
        <span>支付方式 <strong class="sp-active">
            <c:if test="${order.payWay=='1'}">
                支付宝
            </c:if>
            <c:if test="${order.payWay=='2'}">
                银行卡
            </c:if>
            <c:if test="${order.payWay=='3'}">
                微信
            </c:if>
        </strong></span>
            </a>
        </div>
        <ul class="figure">
            <c:if test="${coupon==1}">
                <li><span>总金额</span><span>￥${order.total}</span></li>
                <li><span>优惠券金额</span><span>￥${couponPrice}</span></li>
                <li><span>已付金额</span><span>￥${order.total-couponPrice}</span></li>
            </c:if>
            <c:if test="${coupon==0}">
                <li><span>总金额</span><span>￥${order.total}</span></li>
                <li><span>优惠券金额</span><span>￥0</span></li>
                <li><span>已付金额</span><span>￥${order.total}</span></li>
            </c:if>
        </ul>
    </div>
</c:if>

</body>
</html>
