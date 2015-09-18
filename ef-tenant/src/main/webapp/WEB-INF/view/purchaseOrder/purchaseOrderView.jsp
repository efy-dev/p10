<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title></title>

</head>
<body>
<hr/>
<div class="am-g">
    <div class="am-u-md-12">
        <h2>订单信息</h2>
        <table class="am-table am-table-bordered">
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">订单号</td>
                <td class="am-u-md-3">${object.serial}</td>
                <td class="am-primary am-u-md-3">交易状态</td>
                <td class="am-u-md-3">
                    <ming800:status name="orderStatus" dataType="purchaseOrder.orderStatus"
                                    checkedValue="${object.orderStatus}" type="normal"/>
                </td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">总计（元）</td>
                <td class="am-u-md-3">${object.total}</td>
                <td class="am-primary am-u-md-3">收货人</td>
                <td class="am-u-md-3">
                    ${object.user.name}
                </td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">下单时间</td>
                <td class="am-u-md-3">
                    <fmt:formatDate value="${object.createDatetime}" type="both" pattern="YYYY-MM-dd HH:mm"/>
                </td>
                <td class="am-primary am-u-md-3">收货地址</td>
                <td class="am-u-md-3">${object.consumerAddress.details}</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<div class="am-g">
    <div class="am-u-md-12">
        <table class="am-table am-table-bordered">
            <thead>
            <tr>
                <th>下单人</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">下单人姓名</td>
                <td class="am-u-md-3">${object.user.username}</td>
                <td class="am-primary am-u-md-3">性别</td>
                <td class="am-u-md-3">
                    <ming800:status name="sex" dataType="consumer.sex" checkedValue="${object.user.sex}" type="normal"/>
                </td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">账户余额</td>
                <td class="am-u-md-3">${object.user.deposit}</td>
                <td class="am-primary am-u-md-3">积分</td>
                <td class="am-u-md-3">${object.user.score}</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<div class="am-g">
    <div class="am-u-md-12">
        <h2>商品清单</h2>
    </div>
    <div class="am-u-md-12">
        <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
            <tr>
                <th class="table-set">图片</th>
                <th class="table-title">商品编号</th>
                <th class="table-title">单价(元)</th>
                <th class="table-title">数量</th>
                <th class="table-title">实付款</th>
            </tr>
            </thead>
            <tbody>

            <c:forEach var="purchaseOrderProduct" items="${object.purchaseOrderProductList}">
                <tr>
                    <td>
                        <img width="30px;"
                             src="http://tenant.efeiyi.com/${purchaseOrderProduct.productModel.product.picture_url}@!tenant-manage-photo"
                             alt="商品图片">
                        <a href="<c:url value="/basic/xm.do?qm=viewPurchaseOrderProduct&view=${view}&id=${purchaseOrderProduct.id}"/>">
                                ${purchaseOrderProduct.productModel.product.name}
                        </a>
                    </td>
                    <td>
                            ${purchaseOrderProduct.productModel.serial}
                    </td>
                    <td>
                            ${purchaseOrderProduct.productModel.price}
                    </td>
                    <td>
                            ${purchaseOrderProduct.purchaseAmount}
                    </td>
                    <td>
                            ${purchaseOrderProduct.purchasePrice}
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<div class="am-g">
    <%--点击修改的时候弹出的模态对话框--%>
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
    <div class="am-u-sm-12 am-u-md-6">
        <h4>支付记录</h4>
    </div>
    <div class="am-u-sm-12">
        <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
            <tr>
                <th class="table-title">支付方式</th>
                <th class="table-title">支付金额</th>
                <th class="table-title">支付状态</th>
                <th class="table-title">支付详情(支付方式/金额)</th>
                <th class="table-title">支付者姓名</th>
                <th class="table-title">支付时间</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${object.purchaseOrderPaymentList}" var="purchaseOrderPayment" varStatus="stat">
                <tr>
                    <td class="am-hide-sm-only">
                        <ming800:status name="payWay" dataType="purchaseOrderPayment.payWay"
                                        checkedValue="${purchaseOrderPayment.payWay}"
                                        type="normal"/>
                    </td>
                    <td class="am-hide-sm-only">${purchaseOrderPayment.paymentAmount}</td>
                    <td class="am-hide-sm-only">
                        <ming800:status name="status" dataType="purchaseOrderPayment.status"
                                        checkedValue="${purchaseOrderPayment.status}"
                                        type="normal"/>
                    </td>
                    <td class="am-hide-sm-only">
                        <c:forEach items="${purchaseOrderPayment.purchaseOrderPaymentDetailsList}"
                                   var="purchaseOrderPaymentDetails">

                            <ming800:status name="payWay" dataType="purchaseOrderPaymentDetails.payWay"
                                            checkedValue="${purchaseOrderPaymentDetails.payWay}"
                                            type="normal"/> : ${purchaseOrderPaymentDetails.money}
                            <br>
                            优惠券编号：${purchaseOrderPaymentDetails.coupon.serial}
                            <br>
                        </c:forEach>
                    </td>
                    <td class="am-hide-sm-only">${purchaseOrderPayment.user.name}</td>
                    <td class="am-hide-sm-only">
                        <fmt:formatDate value="${purchaseOrderPayment.createDateTime}"
                                        pattern="yyyy-mm-dd"/>
                    </td>
                </tr>

            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<div class="am-g">
    <div class="am-u-sm-12 am-u-md-6">
        <h4>发货记录</h4>
    </div>
    <div class="am-u-sm-12">
        <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
            <tr>
                <th class="table-title">操作</th>
                <th class="table-title">物流单号</th>
                <th class="table-title">配送状态</th>
                <th class="table-title">物流公司</th>
                <th class="table-title">配送时间</th>
                <th class="table-title">配送地址</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${object.purchaseOrderDeliveryList}" var="purchaseOrderDelivery" varStatus="stat">
                <tr>

                    <td>
                        <div class="am-btn-toolbar">
                            <div class="am-btn-group am-btn-group-xs">
                                <button class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                        onclick="editPurchaseOrderDelivery('${purchaseOrderDelivery.id}','${purchaseOrderDelivery.logisticsCompany}','${purchaseOrderDelivery.serial}')"><span
                                        class="am-icon-trash-o">编辑</span>
                                </button>

                                <button class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                        onclick="logisticsTracking('${purchaseOrderDelivery.logisticsCompany}','${purchaseOrderDelivery.serial}')"><span
                                        class="am-icon-trash-o">物流追踪</span>
                                </button>

                            </div>
                        </div>
                    </td>

                    <td class="am-hide-sm-only">${purchaseOrderDelivery.serial}</td>
                    <td class="am-hide-sm-only">
                        <ming800:status name="status" dataType="purchaseOrderDelivery.status"
                                        checkedValue="${purchaseOrderDelivery.status}"
                                        type="normal"/>
                    </td>
                    <td class="am-hide-sm-only">
                        <ming800:status name="logisticsCompany" dataType="purchaseOrderDelivery.logisticsCompany"
                                        checkedValue="${purchaseOrderDelivery.logisticsCompany}"
                                        type="normal"/>
                    </td>
                    <td class="am-hide-sm-only">
                        <fmt:formatDate value="${purchaseOrderDelivery.createDateTime}"
                                        pattern="yyyy-mm-dd"/>
                    </td>
                    <td class="am-hide-sm-only">${purchaseOrderDelivery.consumerAddress.details}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- content end -->
<hr/>

<div class="am-g">
    <div class="am-u-sm-12 am-u-md-6">
        <h4>物流记录</h4>
    </div>
    <iframe id="kuaidi100" name="kuaidi100" src="" width="600" height="380" marginwidth="0" marginheight="0" hspace="0"
            vspace="0" frameborder="0" scrolling="no">
    </iframe>
</div>
<script>
    function editPurchaseOrderDelivery(purchaseOrderDeliveryId, logisticsCompany, serial) {
        $('#logisticsCompany')[0].options.length = 0;
        $('#serial').val("");
        $.ajax({
            type: 'get',
            url: "<c:url value="/purchaseOrderDelivery/getLogisticsCompany.do"/>",
            success: function (data) {
                var selector = $("#logisticsCompany");
                data = eval('(' + data + ')');
                for (var key in data) {
                    if (logisticsCompany == key) {
                        selector.append('<option value="' + key + '" selected="true">' + data[key] + '</option>')
                    } else {
                        selector.append('<option value="' + key + '">' + data[key] + '</option>')
                    }
                }

                $('#serial').val(serial);
            }
        });
        $('#my-prompt').modal({
            relatedTarget: this,
            onConfirm: function (e) {
                //console.log(e.data);
                $.ajax({
                    type: "get",
                    data: {
                        id: purchaseOrderDeliveryId,
                        logisticsCompany: $('#logisticsCompany').val(),
                        serial: e.data
                    },//输入框的值传递到后台
                    url: "<c:url value="/purchaseOrderDelivery/updatePurchaseOrderDelivery.do"/>",
                    success: function (data) {
                        //$(obj).find("span").text("已发货");
                        alert("修改成功");
                    }
                });
            },
            onCancel: function (e) {
                // alert('不想说!');
            }
        });
    }

    function logisticsTracking(company, serial) {
        jQuery.ajax({
            type: "GET",
            //url: 'http://www.kuaidi100.com/applyurl?key=f8e96a50d49ef863&com='+company+'&nu='+serial+'', 不能直接请求这个地址
            url: '<c:url value="/purchaseOrderDelivery/logisticsTracking.do"/>',
            data: {company: company, serial: serial},
            dataType: "json",
            success: function (data) {
                alert(data);
                $("#kuaidi100").attr("src", data);
            }
        });
    }
</script>
</body>
</html>
