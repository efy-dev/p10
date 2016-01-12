<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/12/14
  Time: 13:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title>物流发货</title>
</head>
<body style="height: auto">
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
<span style="text-align: left;margin-left: 10px;">
    <input onclick="window.history.go(-1);"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 4px;margin-bottom: 6px;margin-left:2px;height: 35px;"
           value="返回"/>
</span>

<span style="text-align: left;margin-left: 10px;">
    <input onclick="window.location.href='<c:url
            value="/batch/deppon.do?qm=listBatchGift_default&result=redirect:/basic/xm.do?qm=plistBatchGift_default"/>'"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 4px;margin-bottom: 6px;margin-left:2px;height: 35px;"
           value="启动批量"/>
</span>

<span style="text-align: left;margin-left: 10px;">
    <input onclick="startUpAppoint()"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 4px;margin-bottom: 6px;margin-left:2px;height: 35px;"
           value="指定启动"/>
</span>

<div>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr style="text-align:left">
            <td>操作</td>
            <td align="center">
                <input type="checkbox" id="appointAll" name="appointAll" onchange="appointAll()" title="指定当前页">
            </td>
            <td>订单序列号</td>
            <td>商品规格</td>
            <td>商品名</td>
            <td>购买数量</td>
            <td>价格</td>
            <td>发送状态</td>
        </tr>
        <c:forEach items="${pageInfo.list}" var="purchaseOrderProduct">
            <tr>
                <td>
                    <div class="am-btn-toolbar">
                        <div class="am-btn-group am-btn-group-xs">
                            <button onclick="window.location.href='<c:url
                                    value="/company/removePurchaseOrderGift.do?id=${purchaseOrderProduct.purchaseOrder.id}"/>'"
                                    class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                                    class="am-icon-trash-o"></span> 删除
                            </button>
                            <button onclick="window.location.href='<c:url
                                    value="/basic/xm.do?qm=viewBatchGift&id=${purchaseOrderProduct.id}"/>'"
                                    class="am-btn am-btn-default am-btn-xs am-hide-sm-only"> 查看详情
                            </button>
                            <a class="am-btn am-btn-default am-btn-xs am-text-secondary" style="color: red;"
                               id="send" onclick="updateOrderStatusNew(this,'${purchaseOrderProduct.purchaseOrder.id}')">
                            <span class="am-icon-pencil-square-o">
                                <c:if test="${purchaseOrderProduct.purchaseOrder.orderStatus==1}">
                                    等待付款
                                </c:if>
                                <c:if test="${purchaseOrderProduct.purchaseOrder.orderStatus==3}">
                                    等待成团
                                </c:if>
                                <c:if test="${purchaseOrderProduct.purchaseOrder.orderStatus==5}">
                                    立即发货
                                </c:if>
                                <c:if test="${purchaseOrderProduct.purchaseOrder.orderStatus==6}">
                                    待收礼
                                </c:if>
                                <c:if test="${purchaseOrderProduct.purchaseOrder.orderStatus==9 or purchaseOrderProduct.purchaseOrder.orderStatus==13 or purchaseOrderProduct.purchaseOrder.orderStatus==7}">
                                    已发货
                                </c:if>
                                <c:if test="${purchaseOrderProduct.purchaseOrder.orderStatus==15}">
                                    已退款
                                </c:if>
                                 <c:if test="${purchaseOrderProduct.purchaseOrder.orderStatus==17}">
                                     已取消
                                 </c:if>
                            </span>
                            </a>
                        </div>
                    </div>
                </td>
                <td align="center">
                    <input type="checkbox" name="appoint" value="${purchaseOrderProduct.id}" title="选择">
                </td>
                <td>${purchaseOrderProduct.purchaseOrder.serial}</td>
                <td>${purchaseOrderProduct.productModel.name}</td>
                <td>${purchaseOrderProduct.productModel.product.name}</td>
                <td>${purchaseOrderProduct.purchaseAmount}</td>
                <td>${purchaseOrderProduct.productModel.price}</td>
                <td>
                    <c:if test="${not empty purchaseOrderProduct.purchaseOrder.message}">
                        发送失败
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
<div style="clear: both">
    <c:url value="/basic/xm.do" var="url"/>
    <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
        <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
        <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
    </ming800:pcPageList>
</div>
<script>
    if (${not empty msg}) {
        alert("${msg}");
    }

    function appointAll(){
        if($("#appointAll").is(":checked")){
            $("[name='appoint']").prop("checked", true);
        }else {
            $("[name='appoint']").prop("checked", false);
        }
    }

    function startUpAppoint(){
        var idList = "";
        $("input[name='appoint']:checked").each(function(){
            if(idList != ""){
                idList = idList + "," + $(this).val();
            }else {
                idList = $(this).val();
            }
        });

        window.location.href="<c:url value='/batch/deppon2.do?idList='/>" + idList;
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
</script>
</body>
</html>
