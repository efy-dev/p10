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

<html>
<head>
    <title></title>
    <script>
        function removePurchaseOrder(orderId) {
            jQuery.ajax({
                type: "GET",
                url: '<c:url value="/basic/xmj.do?qm=removePurchaseOrder"/>',
                data: {id: orderId},
                dataType: "json",
                success: function (data) {
                    $("#" + orderId).remove();
                }
            });
        }
    </script>
</head>
<body>
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
<div class="admin-content">
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-6">
        </div>
        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
                    <th class="table-set">操作</th>
                    <th class="table-title">订单号</th>
                    <th class="table-title">产品</th>
                    <%--<th class="table-title">支付类型</th>--%>
                    <th class="table-title">收货地址</th>
                    <th class="table-title">下单人</th>
                    <th class="table-title">创建日期</th>

                </tr>
                </thead>
                <tbody>


                <c:forEach items="${requestScope.pageInfo.list}" var="purchaseOrder">
                    <tr id="${purchaseOrder.id}">
                        <td>
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">
                                    <button class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                            onclick="showConfirm('提示','是否删除',function(){removePurchaseOrder('${purchaseOrder.id}')})"><span
                                            class="am-icon-trash-o">删除</span>
                                    </button>

                                    <a class="am-btn am-btn-default am-btn-xs am-text-secondary" style="color: red;" onclick="updateOrderStatus(this,'${purchaseOrder.id}')">
                            <span class="am-icon-pencil-square-o">
                                <c:if test="${purchaseOrder.orderStatus==1}">
                                    立即发货
                                </c:if>
                                <c:if test="${purchaseOrder.orderStatus!=1 and purchaseOrder.orderStatus!=17}">
                                    已发货
                                </c:if>
                                 <c:if test="${ purchaseOrder.orderStatus==17}">
                                     无法发货
                                 </c:if>
                            </span>
                                    </a>
                                </div>
                            </div>
                        </td>
                        <td class="am-hide-sm-only"><a
                                href="<c:url value='/basic/xm.do?qm=viewPurchaseOrder&viewIdentify=${viewIdentify}&id=${purchaseOrder.id}'/>">${purchaseOrder.serial}</a>
                        </td>
                        <td class="am-hide-sm-only">
                            <c:forEach items="${purchaseOrder.purchaseOrderProductList}" var="purchaseProduct">
                                <p style="margin-left: 10px;"><a
                                        href="<c:url value='/basic/xm.do?qm=viewPurchaseOrderProduct&viewProductModel=${viewProductModel}&id=${purchaseProduct.productModel.product.id}'/>">${purchaseProduct.productModel.product.name}</a>
                                    <img width="20px" src="http://pro.efeiyi.com/${purchaseProduct.productModel.product.picture_url}@!product-model" alt="产品图片">
                                </p>
                            </c:forEach>

                        </td>
                        <%--<td class="am-hide-sm-only">--%>
                            <%--<c:forEach items="${purchaseOrder.purchaseOrderPaymentList}" var="purchaseOrderPayment">--%>
                                <%--<span style="margin-left: 10px;">--%>
                                    <%--<ming800:status name="payWay" dataType="purchaseOrderPayment.payWay"--%>
                                                    <%--checkedValue="${purchaseOrderPayment.payWay}"--%>
                                                    <%--type="normal"/>--%>
                            <%--</c:forEach>--%>
                        <%--</td>--%>
                        <td class="am-hide-sm-only">${purchaseOrder.consumerAddress.province.name}</td>
                        <td class="am-hide-sm-only">${purchaseOrder.user.username}</td>
                        <td class="am-hide-sm-only"><fmt:formatDate value="${purchaseOrder.createDatetime}" type="both"
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
            <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
        </ming800:pcPageList>
    </div>
</div>

<script type="text/javascript">
    function updateOrderStatus(obj,id){
        var temp = $(obj).find("span").text().trim()
        var orderStatus = "5";
        if(temp=="立即发货"){
            $.ajax({
                type:"get",
                data:{id:id,orderStatus:orderStatus},
                url:"<c:url value="/purchaseOrder/updateOrderStatus.do"/>",
                success:function(data){
                    $(obj).find("span").text("已发货");
                }
            });
        }else if(temp == "无法发货"){

            alert("无法发货!")
        }else{
            alert("已经发货!")
        }


    }
</script>
</body>
</html>
