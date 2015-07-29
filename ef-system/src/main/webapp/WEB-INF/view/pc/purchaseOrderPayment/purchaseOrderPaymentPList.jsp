<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/25
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>

<html>
<head>
    <title></title>
    <script>
        function removePurchaseOrderPayment(orderPaymentId){
            jQuery.ajax({
                type:"GET",
                url:'<c:url value="/basic/xmj.do?qm=removePurchaseOrderPayment"/>',
                data:{id:orderPaymentId},
                dataType:"json",
                success:function(data){
                    $("#"+orderPaymentId).remove();
                }
            });
        }
    </script>
</head>
<body>
<div class="admin-content">
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-6">
        </div>
        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
                    <th class="table-set">操作</th>
                    <th class="table-title">支付记录编号</th>
                    <th class="table-title">支付订单</th>
                    <th class="table-title">支付方式</th>
                    <th class="table-title">支付用户</th>
                    <th class="table-title">支付时间</th>

                </tr>
                </thead>
                <tbody>



                <c:forEach items="${requestScope.pageInfo.list}" var="purchaseOrderPayment">
                    <tr id="${purchaseOrderPayment.id}">
                        <td>
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">
                                    <button class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="removePurchaseOrderPayment('${purchaseOrderPayment.id}')"><span
                                            class="am-icon-trash-o"></span> 删除
                                    </button>
                                </div>
                            </div>
                        </td>
                        <td class="am-hide-sm-only"><a href="<c:url value='/basic/xm.do?qm=viewPurchaseOrderPayment&id=${purchaseOrderPayment.id}'/>">${purchaseOrderPayment.serial}</a></td>
                        <td class="am-hide-sm-only"><a href="<c:url value='/basic/xm.do?qm=viewPurchaseOrder&id=${purchaseOrderPayment.purchaseOrder.id}'/>">${purchaseOrderPayment.purchaseOrder.serial}</a></td>
                        <td class="am-hide-sm-only">
                            <c:choose>
                                <c:when test="${purchaseOrderPayment.payWay == 1}">
                                    支付宝
                                </c:when>
                                <c:when test="${purchaseOrderPayment.payWay == 2}">
                                    网银支付
                                </c:when>
                            </c:choose>
                        </td>
                        <td class="am-hide-sm-only"><a href="<c:url value='/basic/xm.do?qm=viewConsumer&id=${purchaseOrderPayment.user.id}'/>">${purchaseOrderPayment.user.name}</a></td>
                        <td class="am-hide-sm-only"><fmt:formatDate value="${purchaseOrderPayment.createDateTime}" type="both" pattern="yyyy-MM-dd HH:mm"/></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div style="clear: both">
        <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="/basic/xm.do">
            <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
            <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
        </ming800:pcPageList>
    </div>
</div>

</body>
</html>
