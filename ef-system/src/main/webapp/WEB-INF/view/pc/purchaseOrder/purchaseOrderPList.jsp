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
        function updateOrderStatusNew(obj, id) {

            var temp = $(obj).find("span").text().trim();
            var orderStatus = "5";
            if (temp == '立即发货') {
                $('#logisticsCompany')[0].options.length = 0;
                $('#serial').val("");
                $.ajax({
                    type: 'get',
                    url: "<c:url value="/purchaseOrderDelivery/getLogisticsCompany.do"/>",
                    success: function (data) {
                        var selector = $("#logisticsCompany");
                        data = eval('(' + data + ')');
                        for (var key in data) {
                            selector.append('<option value="' + key + '">' + data[key] + '</option>')
                        }

                    }
                });
                var dingYueSerial;
                $('#my-prompt').modal({
                    relatedTarget: this,
                    onConfirm: function (e) {
                        //console.log(e.data);
                        dingYueSerial = e.data;
                        $.ajax({
                            type: "get",
                            data: {
                                id: id,
                                orderStatus: orderStatus,
                                logisticsCompany: $('#logisticsCompany').val(),
                                serial: e.data,
                                logisticsCompanyZHCN: $('#logisticsCompany option:checked').text()
                            },//输入框的值传递到后台
                            url: "<c:url value="/purchaseOrder/updateOrderStatus.do"/>",
                            success: function (data) {
                                $(obj).find("span").text("已发货");

//                                alert("wuliugongsi"+$('#logisticsCompany').val());
//                                alert("wuliudanhao"+dingYueSerial);

                                //发完货之后还要在快递100订阅 用户收货后直接修改订单状态为已签收
                                $.ajax({
                                    type: 'post',
                                    url: "<c:url value="http://www.kuaidi100.com/poll"/>",
                                    data: {
                                        schema: 'json',
                                        param: {
                                            "company": $('#logisticsCompany').val(),
                                            "number": dingYueSerial,
                                            "key": "WTVaPjwE5593",
                                            "parameters": {
                                                "callbackurl": "admin.efeiyi.com/purchaseOrder/edingyue.do",
                                                "salt": "test",
                                                "resultv2": "1"
                                            }
                                        }
                                    },
                                    success: function (data) {
                                        alert(data.message);
                                    }
                                });

                                window.location.reload();
                            }
                        });
                    },
                    onCancel: function (e) {
                        // alert('不想说!');
                    }
                });
            } else if (temp == "已取消") {
                alert("订单已取消!")
            } else if (temp == "等待付款") {
                alert("等待付款!")
            } else if (temp == "待收礼") {
                alert("待收礼!")
            } else if (temp == "已退款") {
                alert("已退款!")
            } else if (temp == "等待成团") {
                alert("等待成团!")
            } else {
                alert("已经发货!")
            }
        }
        function refund(obj, id) {
            var refundWay = $('#refundType').val();

            $('#my-prompt1').modal({
                relatedTarget: this,
                onConfirm: function (e) {
                    $.ajax({
                        type: "get",
                        data: {
                            id: id,//订单id
                            refundWay:refundWay,//退款方式
                            refundMoney:e.data,//退款金额
                        },//输入框的值传递到后台
                        url: "<c:url value="/purchaseOrder/refund.do"/>",
                        success: function (data) {
                            if(data){
                                window.location.reload();
                            }
                        }
                    });
                }});

        }

        function downloadOrder(){
            var startTime = $("#startTime").val();
            var endTime = $("#endTime").val();
            var selectTenant = $("#tenant3").val();
            window.location.href = "<c:url value='/purchaseOrder/downloadOrders.do?startTime='/>"+startTime+"&endTime="+endTime+"&selectTenant="+selectTenant;
        }

        function confirmOrder(id){
            jQuery.ajax({
                type: "GET",
                data: {id: id},
                dataType: "json",
                async:false,
                url: '<c:url value="/purchaseOrder/confirmOrder.do"/>',
                success: function (data) {
                    window.location = window.location;
                }
            });
        }
    </script>
</head>
<body>
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
<div class="admin-content" style="height: auto">
    <div class="am-g">
        <div class="am-form-group am-form-icon" style="width: 150px;float: left">
            <i class="am-icon-calendar"></i>
            <input type="text" id="startTime" name="startTime"
                   class="am-form-field am-input-sm"
                   placeholder="下载日期起"  data-am-datepicker readonly>
        </div>
        <div style="float: left">&nbsp;&nbsp;至&nbsp;&nbsp;</div>
        <div class="am-form-group am-form-icon" style="width: 150px;float: left">
            <i class="am-icon-calendar"></i>
            <input type="text" id="endTime" name="startTime"
                   class="am-form-field am-input-sm"
                   placeholder="下载日期止"  data-am-datepicker readonly>
        </div>

        <div class="am-form-group" id="xztenant" style="float: left;text-align: center">
            <label class="am-u-sm-4 am-form-label" style="padding: 0;">选择商家</label>

            <div class="am-u-sm-8" name="selectTenant" id="selectTenant" style="display: inline-block;padding: 0">
                <select name="tenant3" id="tenant3"  data-am-selected="{searchBox: 1}" style="width:180px;float:left;">
                    <option value="">请选择</option>
                    <c:forEach items="${tenantList}" var="tenant">
                    <option value="${tenant.id}">${tenant.name}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="am-u-sm-12 am-u-md-6" style="padding-left: 35px;">
            <a class="am-btn am-btn-default am-btn-xs am-text-secondary"
               style="color: red;" id="downloadOrder" onclick="downloadOrder()"
               >
                <span class="am-icon-pencil-square-o">下载订单</span>
            </a>
        </div>

        <%--点击立即发货的时候弹出的模态对话框--%>
        <div class="am-modal am-modal-prompt" tabindex="-1" id="my-prompt">
            <div class="am-modal-dialog">
                <%--<div class="am-modal-hd">Amaze UI</div>--%>
                <div class="am-modal-bd">
                    <div>请填写正确的物流公司和快递单号</div>

                    <%--物流公司: <input type="text" id="logisticsCompany" name="logisticsCompany" class="am-modal-prompt-input">--%>
                    <div>
                        物流公司: <select class="am-modal-prompt-select" id="logisticsCompany" name="logisticsCompany"
                                      style="width: 90px;display: inline-block;"></select>
                    </div>
                    <div>
                        快递单号:<input type="text" id="serial" name="serial" class="am-modal-prompt-input"
                                    style="width: 100px;height:30px;display: inline-block;">
                    </div>
                </div>
                <div class="am-modal-footer">
                    <span class="am-modal-btn" data-am-modal-cancel>取消</span>
                    <span class="am-modal-btn" data-am-modal-confirm>提交</span>
                </div>
            </div>
        </div>

        <%--点击退款的时候弹出的模态对话框--%>
        <div class="am-modal am-modal-prompt" tabindex="-1" id="my-prompt1">
            <div class="am-modal-dialog">
                <%--<div class="am-modal-hd">Amaze UI</div>--%>
                <div class="am-modal-bd">
                    <div>请选择退款方式</div>
                    <div>
                        退款方式: <select class="am-modal-prompt-select" id="refundType" name="refundType"
                                      style="width: 90px;display: inline-block;">
                        <option value="支付宝">支付宝</option>
                        <option value="微信">微信</option>
                        <option value="其他">其他</option>
                    </select>
                    </div>
                    <div>
                        退款金额:<input type="text" id="refundMoney" name="refundMoney" class="am-modal-prompt-input"
                                    style="width: 100px;height:30px;display: inline-block;">
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
                    <security:authorize ifAnyGranted="admin,operational,o_operational">
                        <th class="table-set">操作</th>
                    </security:authorize>
                    <th class="table-title">订单号</th>
                    <th class="table-title">订单状态</th>
                    <th class="table-title">订单类型</th>
                    <th class="table-title">产品</th>
                    <th class="table-title">总额/实付金额(元)</th>
                    <th class="table-title">商家/编号</th>
                    <%--<th class="table-title">支付类型</th>--%>
                    <th class="table-title" width="150px">收货地区</th>
                    <th class="table-title">下单人</th>
                    <th class="table-title">创建日期</th>

                </tr>
                </thead>
                <tbody>


                <c:forEach items="${requestScope.pageInfo.list}" var="purchaseOrder">
                    <tr id="${purchaseOrder.id}">
                        <security:authorize ifAnyGranted="admin,operational,o_operational">
                            <td>
                                <div class="am-btn-toolbar">
                                    <div class="am-btn-group am-btn-group-xs">
                                        <a class="am-btn am-btn-default am-btn-xs am-text-secondary" style="color: red;"
                                           id="send" onclick="updateOrderStatusNew(this,'${purchaseOrder.id}')">
                            <span class="am-icon-pencil-square-o">
                                <c:if test="${purchaseOrder.orderStatus==1}">
                                    等待付款
                                </c:if>
                                <c:if test="${purchaseOrder.orderStatus==3}">
                                    等待成团
                                </c:if>
                                <c:if test="${purchaseOrder.orderStatus==5 || purchaseOrder.orderStatus==51}">
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

                                        <c:if test="${purchaseOrder.orderStatus==5 || purchaseOrder.orderStatus==51 || purchaseOrder.orderStatus==6 || purchaseOrder.orderStatus==7 || purchaseOrder.orderStatus==9 || purchaseOrder.orderStatus==13}">
                                            <a class="am-btn am-btn-default am-btn-xs am-text-secondary"
                                               style="color: red;" id="refund"
                                               onclick="refund(this,'${purchaseOrder.id}')">
                                                <span class="am-icon-pencil-square-o">退款</span>
                                            </a>
                                        </c:if>
                                        <c:if test="${purchaseOrder.orderStatus==5}">
                                            <a class="am-btn am-btn-default am-btn-xs am-text-secondary"
                                               style="color: red;" id="confirmOrder"
                                               onclick="confirmOrder('${purchaseOrder.id}')">
                                                <span class="am-icon-pencil-square-o">确认</span>
                                            </a>
                                        </c:if>
                                    </div>
                                </div>
                            </td>
                        </security:authorize>
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
                            <ming800:status name="orderType" dataType="purchaseOrder.orderType"
                                            checkedValue="${purchaseOrder.orderType}"
                                            type="normal"/>
                        </td>
                        <td class="am-hide-sm-only">
                            <c:forEach items="${purchaseOrder.purchaseOrderProductList}" var="purchaseProduct">
                                <p style="margin-left: 10px;"><a
                                        href="<c:url value='/basic/xm.do?qm=viewPurchaseOrderProduct&viewProductModel=${viewProductModel}&id=${purchaseProduct.id}'/>">${purchaseProduct.productModel.product.name}</a>
                                    <img width="20px"
                                         src="http://pro.efeiyi.com/${purchaseProduct.productModel.productModel_url}@!product-model"
                                         alt="产品图片">
                                </p>
                            </c:forEach>

                        </td>

                        <td class="am-hide-sm-only"><fmt:formatNumber type="number" value="${purchaseOrder.total}"
                                                                      maxFractionDigits="2" minFractionDigits="2"/> <br>
                            <fmt:formatNumber type="number" value="${purchaseOrder.getRealPayMoney()}"
                                              maxFractionDigits="2" minFractionDigits="2"/></td>
                        <td class="am-hide-sm-only">${purchaseOrder.bigTenant.name}<br>${purchaseOrder.bigTenant.contractNumber}</td>
                        <td class="am-hide-sm-only" width="150px">${purchaseOrder.purchaseOrderAddress}</td>
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
</body>
</html>
