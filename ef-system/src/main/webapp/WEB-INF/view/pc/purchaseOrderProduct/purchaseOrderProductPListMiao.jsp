<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/25
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title></title>

</head>
<body>
    <jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
<div class="admin-content" style="height: auto">


        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
                    <th class="table-title">订单号</th>
                    <th class="table-title">订单状态</th>
                    <th class="table-title">订单类型</th>
                    <th class="table-title">产品</th>
                    <th class="table-title">总额/实付金额(元)</th>
                    <%--<th class="table-title">支付类型</th>--%>
                    <th class="table-title">收货地址</th>
                    <th class="table-title">下单人</th>
                    <th class="table-title">创建日期</th>

                </tr>
                </thead>
                <tbody>


                <c:forEach items="${requestScope.pageInfo.list}" var="purchaseOrderProduct">
                    <tr id="${purchaseOrderProduct.id}">

                        <td class="am-hide-sm-only"><a
                                href="<c:url value='/basic/xm.do?qm=viewPurchaseOrder&viewIdentify=${viewIdentify}&id=${purchaseOrderProduct.purchaseOrder.id}'/>">${purchaseOrderProduct.purchaseOrder.serial}
                        </a>
                            <br>
                            <c:if test="${empty purchaseOrderProduct.purchaseOrder.fatherPurchaseOrder}">
                                父订单
                            </c:if>
                            <c:if test="${not empty purchaseOrderProduct.purchaseOrder.fatherPurchaseOrder}">
                                子订单
                            </c:if>
                        </td>
                        <td class="am-hide-sm-only">
                            <ming800:status name="orderStatus" dataType="PurchaseOrder.orderStatus"
                                            checkedValue="${purchaseOrderProduct.purchaseOrder.orderStatus}"
                                            type="normal"/>
                        </td>
                        <td class="am-hide-sm-only">
                            <ming800:status name="orderType" dataType="PurchaseOrder.orderType"
                                            checkedValue="${purchaseOrderProduct.purchaseOrder.orderType}"
                                            type="normal"/>
                        </td>
                        <td class="am-hide-sm-only">

                                <p style="margin-left: 10px;"><a
                                        href="<c:url value='/basic/xm.do?qm=viewPurchaseOrderProduct&viewProductModel=${viewProductModel}&id=${purchaseOrderProduct.id}'/>">${purchaseOrderProduct.productModel.name}</a>
                                    <img width="20px"
                                         src="http://pro.efeiyi.com/${purchaseOrderProduct.productModel.productModel_url}@!product-model"
                                         alt="产品图片">
                                </p>

                        </td>

                        <td class="am-hide-sm-only"><fmt:formatNumber type="number" value="${purchaseOrderProduct.purchaseOrder.total}"
                                                                      maxFractionDigits="2" minFractionDigits="2"/> <br>
                            <fmt:formatNumber type="number" value="${purchaseOrderProduct.purchaseOrder.getRealPayMoney()}"
                                              maxFractionDigits="2" minFractionDigits="2"/></td>
                        <td class="am-hide-sm-only">${purchaseOrderProduct.purchaseOrder.purchaseOrderAddress}</td>
                        <td class="am-hide-sm-only">${purchaseOrderProduct.purchaseOrder.user.username}</td>
                        <td class="am-hide-sm-only"><fmt:formatDate value="${purchaseOrderProduct.purchaseOrder.createDatetime}" type="both"
                                                                    pattern="yyyy-MM-dd HH:mm"/></td>
                    </tr>

                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div style="clear: both">
        <c:url value="/basic/xm.do" var="url"/>
        <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
            <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
            <ming800:pcPageParam name="viewIdentify" value="orderProductMiao"/>
            <ming800:pcPageParam name="viewProductModel" value="orderMiao"/>
            <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
        </ming800:pcPageList>
    </div>
</div>
</body>
</html>
