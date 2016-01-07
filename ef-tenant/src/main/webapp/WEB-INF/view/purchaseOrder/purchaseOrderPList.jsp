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
<table class="am-table am-table-bordered am-table-radius am-table-striped">



    <tr>
        <th>操作</th>
        <th>订单号</th>
        <th>订单状态</th>
        <th>总额/实付金额</th>
        <th>下单人</th>
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
                           href="<c:url value="/basic/xm.do?qm=viewPurchaseOrder&view=${view}&id=${purchaseOrder.id}"/>"><span
                                class="am-icon-pencil-square-o">订单详情</span>
                        </a>
                        <a class="am-btn am-btn-default am-btn-xs am-text-secondary" style="color: red;" onclick="updateOrderStatus(this,'${purchaseOrder.id}')">
                            <span class="am-icon-pencil-square-o">
                               <c:if test="${purchaseOrder.orderStatus==1}">
                                   等待付款
                               </c:if>
                                <c:if test="${purchaseOrder.orderStatus==3}">
                                    等待成团
                                </c:if>
                                <c:if test="${purchaseOrder.orderStatus==5}">
                                    立即发货
                                </c:if>
                                <c:if test="${purchaseOrder.orderStatus==6}">
                                    待收礼
                                </c:if>
                                <c:if test="${purchaseOrder.orderStatus==9 or purchaseOrder.orderStatus==13 or purchaseOrder.orderStatus==7}">
                                    已发货
                                </c:if>
                                <c:if test="${purchaseOrder.orderStatus==15}">
                                    已退款
                                </c:if>
                                 <c:if test="${ purchaseOrder.orderStatus==17}">
                                     已取消
                                 </c:if>
                            </span>
                        </a>
                        <%--<c:if test="${purchaseOrder.orderStatus==5 || purchaseOrder.orderStatus==6 || purchaseOrder.orderStatus==7 || purchaseOrder.orderStatus==9 || purchaseOrder.orderStatus==13}">--%>
                            <%--<a class="am-btn am-btn-default am-btn-xs am-text-secondary"--%>
                               <%--style="color: red;" id="refund"--%>
                               <%--onclick="refund(this,'${purchaseOrder.id}')">--%>
                                <%--<span class="am-icon-pencil-square-o">退款</span>--%>
                            <%--</a>--%>
                        <%--</c:if>--%>
                    </div>
                </div>
            </td>

            <td>
                <a  href="<c:url value="/basic/xm.do?qm=viewPurchaseOrder&view=${view}&id=${purchaseOrder.id}"/>">
                 ${purchaseOrder.serial}
                </a>
                <br>
                <c:if test="${empty purchaseOrder.fatherPurchaseOrder}">
                    父订单
                </c:if>
                <c:if test="${not empty purchaseOrder.fatherPurchaseOrder}">
                    子订单
                </c:if>
            </td>
            <td width="10%" id="${purchaseOrder.id}">
                <ming800:status name="orderStatus" dataType="purchaseOrder.orderStatus" checkedValue="${purchaseOrder.orderStatus}" type="normal" />
            </td>
            <td width="10%">
                <fmt:formatNumber type="number" value="${purchaseOrder.total}" maxFractionDigits="2" minFractionDigits="2"/><br>
                <fmt:formatNumber type="number" value="${purchaseOrder.getRealPayMoney()}" maxFractionDigits="2" minFractionDigits="2"/>
            </td>
            <td width="10%">
                    ${purchaseOrder.user.username}
            </td>
            <td width="10%">
              ${purchaseOrder.receiverName}
            </td>
            <td width="20%">
                <fmt:formatDate value="${purchaseOrder.createDatetime}" type="both" pattern="YYYY-MM-dd HH:mm" />
            </td>
        </tr>
        <tr id="collapse-panel-${status.index}" class="am-collapse">
            <td colspan="7">
             <table class="am-table am-table-bd am-table-bdrs am-table-striped am-table-hover" width="90%">
                <tr>
                    <th class="am-text-center">图片</th>
                    <th class="am-text-center">商品</th>
                    <th class="am-text-center">规格</th>
                    <th class="am-text-center">单价</th>
                    <th class="am-text-center">数量</th>
                </tr>
                <c:forEach var="purchaseOrderProduct" items="${purchaseOrder.purchaseOrderProductList}" >
                    <tr >
                        <td class="am-text-center">
                            <img width="30px;" src="http://tenant.efeiyi.com/${purchaseOrderProduct.productModel.productModel_url}@!tenant-manage-photo" alt="商品图片">
                        </td>
                        <td class="am-text-center">
                            <a href="<c:url value="/basic/xm.do?qm=viewPurchaseOrderProduct&view=${view}&id=${purchaseOrderProduct.id}"/>">
                                    ${purchaseOrderProduct.productModel.product.name}
                            </a>
                        </td>
                        <td class="am-text-center">
                                    ${purchaseOrderProduct.productModel.name}
                        </td>
                        <td class="am-text-center">
                            <fmt:formatNumber type="number" value="${purchaseOrderProduct.productModel.price}" maxFractionDigits="2" minFractionDigits="2"/>
                        </td>
                        <td class="am-text-center">
                                    ${purchaseOrderProduct.purchaseAmount}
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
        <ming800:pcPageParam name="view" value="${view}"/>
        <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
    </ming800:pcPageList>
</div>
<script type="text/javascript">
    function updateOrderStatus(obj,id){
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
            var dingYueSerial;
            $('#my-prompt').modal({
                relatedTarget: this,
                onConfirm: function(e) {
                    //console.log(e.data);
                    dingYueSerial = e.data;
                    $.ajax({
                        type:"get",
                        data:{id:id,orderStatus:orderStatus,logisticsCompany:$('#logisticsCompany').val(),serial: e.data,logisticsCompanyZHCN:$('#logisticsCompany option:checked').text()},//输入框的值传递到后台
                        url:"<c:url value="/purchaseOrder/updateOrderStatus.do"/>",
                        success:function(data){
                            $(obj).find("span").text("已发货");

                            $.ajax({
                                type:'post',
                                url:"<c:url value="http://www.kuaidi100.com/poll"/>",
                                data:{schema:'json',param:{"company":$('#logisticsCompany').val(),"number":dingYueSerial,"key":"WTVaPjwE5593","parameters":{"callbackurl":"http://seller.efeiyi.com/purchaseOrder/edingyue.do","salt":"test","resultv2":"1"}}},
                                success:function(data){
                                    alert(data.message);
                                }
                            });

                            window.location.reload();
                        }
                    });
                },
                onCancel: function(e) {
                }
            });
        }else if(temp == "已取消"){

            alert("订单已取消，无法发货!")
        }else if(temp == "等待付款"){

            alert("等待付款，无法发货!")
        }else if(temp == "等待成团"){

            alert("等待成团，无法发货!")
        } else if (temp == "待收礼") {
            alert("待收礼!")
        } else if (temp == "已退款") {
            alert("已退款!")
        }else{
            alert("已经发货!")
        }

    }

    function refund(obj, id){
        $.ajax({
            type: "get",
            data: {
                id: id,
            },//输入框的值传递到后台
            url: "<c:url value="/purchaseOrder/refund.do"/>",
            success: function (data) {
                window.location.reload();
            }
        });
    }
</script>
</body>
</html>
