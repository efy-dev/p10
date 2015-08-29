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
 </script>

</head>
<body>
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
<table class="am-table am-table-bordered am-table-radius am-table-striped">

    <tr>
        <th>操作</th>
        <th>订单号</th>
        <th>订单状态</th>
        <th>总计(元)</th>
        <th>收货人</th>
        <!--<th>ming800:status name="orderStatus" dataType="purchaseOrder.orderStatus" type="select" /> </th> -->
        <th>下单时间</th>
    </tr>

    <c:forEach items="${requestScope.pageInfo.list}" var="purchaseOrder" varStatus="status">
        <tr data-am-collapse="{target: '#collapse-panel-${status.index}'}" >
            <td width="20%" >
                <div class="am-btn-toolbar">
                    <div class="am-btn-group am-btn-group-xs" style="width: 100%" >
                        <a class="am-btn am-btn-default am-btn-xs am-text-secondary" style="color: red;"
                           href="<c:url value="/basic/xm.do?qm=viewPurchaseOrder&view=delivery&id=${purchaseOrder.id}"/>"><span
                                class="am-icon-pencil-square-o">订单详情</span>
                        </a>
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

            <td>
                <a  href="<c:url value="/basic/xm.do?qm=viewPurchaseOrder&id=${purchaseOrder.id}"/>">
                 ${purchaseOrder.serial}
                </a>
            </td>
            <td width="10%" id="${purchaseOrder.id}">
                <ming800:status name="orderStatus" dataType="purchaseOrder.orderStatus" checkedValue="${purchaseOrder.orderStatus}" type="normal" />
            </td>
            <td width="10%">
                    ${purchaseOrder.total}
            </td>
            <td width="10%">
              ${purchaseOrder.user.name}
            </td>
            <td width="20%">
                <fmt:formatDate value="${purchaseOrder.createDatetime}" type="both" pattern="YYYY-MM-dd HH:mm" />
            </td>
        </tr>
        <tr id="collapse-panel-${status.index}" class="am-collapse">
            <td colspan="6">
             <table class="am-table am-table-bd am-table-bdrs am-table-striped am-table-hover" width="90%">
                <tr>
                    <th class="am-text-center">图片</th>
                    <th class="am-text-center">商品</th>
                    <th class="am-text-center">单价</th>
                    <th class="am-text-center">数量</th>
                    <th class="am-text-center">实付款</th>
                </tr>
                <c:forEach var="purchaseOrderProduct" items="${purchaseOrder.purchaseOrderProductList}" >
                    <tr >
                        <td class="am-text-center">
                            <img width="30px;" src="http://tenant.efeiyi.com/${purchaseOrderProduct.productModel.product.picture_url}@!tenant-manage-photo" alt="商品图片">
                        </td>
                        <td class="am-text-center">
                            <a href="<c:url value="/basic/xm.do?qm=viewProduct&id=${purchaseOrderProduct.productModel.product.id}"/>">
                                    ${purchaseOrderProduct.productModel.product.name}
                            </a>
                        </td>
                        <td class="am-text-center">
                            <a href="#">
                                    ${purchaseOrderProduct.productModel.price}
                            </a>
                        </td>
                        <td class="am-text-center">
                            <a href="#">
                                    ${purchaseOrderProduct.purchaseAmount}
                            </a>
                        </td>
                        <td class="am-text-center">
                            <a href="#">
                                    ${purchaseOrderProduct.purchasePrice}
                            </a>
                        </td>
                    </tr>
                </c:forEach>
             </table>
            </td>
        </tr>
    </c:forEach>
</table>
<div style="clear: both">
    <c:url value="/basic/xm.do" var="url"/>
    <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
        <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
        <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
    </ming800:pcPageList>
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
                    $("#"+id).html("等待收货");
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
