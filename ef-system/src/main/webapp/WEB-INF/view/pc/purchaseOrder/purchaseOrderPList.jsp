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

        <%--$(function(){--%>
            <%--$('#postSpan').on('click',function(){--%>
                <%--var temp = $('#postSpan').text().trim()--%>
                <%--var orderStatus = "5";--%>
                <%--if(temp == '立即发货'){--%>
                    <%--$('#my-prompt').modal({--%>
                        <%--relatedTarget: this,--%>
                        <%--onConfirm: function(e) {--%>

                            <%--$.ajax({--%>
                                <%--type:"get",--%>
                                <%--data:{id:id,orderStatus:orderStatus,logisticsCompany:$('#logisticsCompany').val(),serial:$('#serial').val()},--%>
                                <%--url:"<c:url value="/purchaseOrder/updateOrderStatus.do"/>",--%>
                                <%--success:function(data){--%>
                                    <%--$(obj).find("span").text("已发货");--%>
                                <%--}--%>
                            <%--});--%>
                        <%--},--%>
                        <%--onCancel: function(e) {--%>
                            <%--alert('不想说!');--%>
                        <%--}--%>
                    <%--});--%>
                <%--}else if(temp == "无法发货"){--%>

                    <%--alert("无法发货!")--%>
                <%--}else{--%>
                    <%--alert("已经发货!")--%>
                <%--}--%>
            <%--});--%>
        <%--});--%>


        function updateOrderStatusNew(obj,id){

            var temp =  $(obj).find("span").text().trim();
            var orderStatus = "5";
            if(temp == '立即发货'){
                $('#logisticsCompany')[0].options.length=0;
                $('#serial').val("");
                $.ajax({
                    type:'get',
                    url:"<c:url value="/purchaseOrderDelivery/getLogisticsCompany.do"/>",
                    success:function(data){
                        var selector = $("#logisticsCompany");
                        data = eval('(' + data + ')');
                        for(var key in data){
                            selector.append('<option value="'+key+'">'+data[key]+'</option>')
                        }

                    }
                });
                $('#my-prompt').modal({
                    relatedTarget: this,
                    onConfirm: function(e) {
                        //console.log(e.data);
                        $.ajax({
                            type:"get",
                            data:{id:id,orderStatus:orderStatus,logisticsCompany:$('#logisticsCompany').val(),serial: e.data},//输入框的值传递到后台
                            url:"<c:url value="/purchaseOrder/updateOrderStatus.do"/>",
                            success:function(data){
                                $(obj).find("span").text("已发货");
                            }
                        });
                    },
                    onCancel: function(e) {
                       // alert('不想说!');
                    }
                });
            }else if(temp == "已取消"){

                alert("订单已取消，无法发货!")
            }else if(temp == "等待付款"){

                alert("等待付款，无法发货!")
            }else{
                alert("已经发货!")
            }
        }

    </script>
</head>
<body>
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
<div class="admin-content" style="height: auto">
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-6">
        </div>

        <%--点击立即发货的时候弹出的模态对话框--%>
        <div class="am-modal am-modal-prompt" tabindex="-1" id="my-prompt">
            <div class="am-modal-dialog">
                <%--<div class="am-modal-hd">Amaze UI</div>--%>
                <div class="am-modal-bd">
                    <div>请填写正确的物流公司和快递单号</div>

                    <%--物流公司: <input type="text" id="logisticsCompany" name="logisticsCompany" class="am-modal-prompt-input">--%>
                    <div>
                    物流公司: <select class="am-modal-prompt-select" id="logisticsCompany" name="logisticsCompany" style="width: 90px;display: inline-block;"></select>
                    </div>
                    <div>
                    快递单号:<input type="text" id="serial" name="serial" class="am-modal-prompt-input" style="width: 100px;height:30px;display: inline-block;">
                    </div>
                </div>
                <div class="am-modal-footer">
                    <span class="am-modal-btn" data-am-modal-cancel>取消</span>
                    <span class="am-modal-btn" data-am-modal-confirm>提交</span>
                </div>
            </div>
        </div>

        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
                    <th class="table-set">操作</th>
                    <th class="table-title">订单号</th>
                    <th class="table-title">订单状态</th>
                    <th class="table-title">产品</th>
                    <th class="table-title">总额/实付金额</th>
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

                                    <a class="am-btn am-btn-default am-btn-xs am-text-secondary" style="color: red;" id="send" onclick="updateOrderStatusNew(this,'${purchaseOrder.id}')">
                            <span class="am-icon-pencil-square-o">
                                <c:if test="${purchaseOrder.orderStatus==1}">
                                    等待付款
                                </c:if>
                                <c:if test="${purchaseOrder.orderStatus==5}">
                                    立即发货
                                </c:if>
                                <c:if test="${purchaseOrder.orderStatus==9 or purchaseOrder.orderStatus==13 or purchaseOrder.orderStatus==7}">
                                    已发货
                                </c:if>
                                 <c:if test="${ purchaseOrder.orderStatus==17}">
                                     已取消
                                 </c:if>
                            </span>
                                    </a>
                                </div>
                            </div>
                        </td>
                        <td class="am-hide-sm-only"><a
                                href="<c:url value='/basic/xm.do?qm=viewPurchaseOrder&viewIdentify=${viewIdentify}&id=${purchaseOrder.id}'/>">${purchaseOrder.serial}
                        </a>
                            <br>
                            <c:if test="${empty purchaseOrder.fatherPurchaseOrder}">
                                父订单
                            </c:if>
                            <c:if test="${not empty purchaseOrder.fatherPurchaseOrder}">
                                子订单
                            </c:if>
                        </td>
                        <td class="am-hide-sm-only">
                            <ming800:status name="orderStatus" dataType="purchaseOrder.orderStatus"
                                            checkedValue="${purchaseOrder.orderStatus}"
                                            type="normal"/>
                        </td>
                        <td class="am-hide-sm-only">
                            <c:forEach items="${purchaseOrder.purchaseOrderProductList}" var="purchaseProduct">
                                <p style="margin-left: 10px;"><a
                                        href="<c:url value='/basic/xm.do?qm=viewPurchaseOrderProduct&viewProductModel=${viewProductModel}&id=${purchaseProduct.id}'/>">${purchaseProduct.productModel.product.name}</a>
                                    <img width="20px" src="http://pro.efeiyi.com/${purchaseProduct.productModel.productModel_url}@!product-model" alt="产品图片">
                                </p>
                            </c:forEach>

                        </td>

                        <td class="am-hide-sm-only">${purchaseOrder.total} <br>
                        ${purchaseOrder.getRealPayMoney()}</td>
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
            <ming800:pcPageParam name="viewIdentify" value="orderProduct"/>
            <ming800:pcPageParam name="viewProductModel" value="order"/>
            <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
        </ming800:pcPageList>
    </div>
</div>

<%--<script type="text/javascript">--%>
    <%--function updateOrderStatus(obj,id){--%>
        <%--var temp = $(obj).find("span").text().trim()--%>
        <%--var orderStatus = "5";--%>
        <%--if(temp=="立即发货"){--%>
            <%--$.ajax({--%>
                <%--type:"get",--%>
                <%--data:{id:id,orderStatus:orderStatus},--%>
                <%--url:"<c:url value="/purchaseOrder/updateOrderStatus.do"/>",--%>
                <%--success:function(data){--%>
                    <%--$(obj).find("span").text("已发货");--%>
                <%--}--%>
            <%--});--%>
        <%--}else if(temp == "无法发货"){--%>

            <%--alert("无法发货!")--%>
        <%--}else{--%>
            <%--alert("已经发货!")--%>
        <%--}--%>
    <%--}--%>


<%--</script>--%>
</body>
</html>
