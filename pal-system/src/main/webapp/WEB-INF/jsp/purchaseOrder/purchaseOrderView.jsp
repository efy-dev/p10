<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/22
  Time: 16:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@include file="/layouts/public.jsp" %>
<html>
<head>
    <title></title>
    <script type="text/javascript">
        var flg =true;
        function showDiv(){
            var pf=document.getElementById("productForm");
            if(flg){
                pf.setAttribute("style","display");
            }else{
                pf.setAttribute("style","display:none");
            }
            flg = !flg;
        }
    </script>
</head>
<body>
<div style="text-align: left;margin-left: 10px;">
    <c:if test="${object.status == '1' || object.status == '2'}">
        <input onclick="myConfirm('<c:url value="/basic/xm.do?qm=removePurchaseOrder&order=remove&id=${object.id}"/>', 'D')"
               type="button" class="am-btn am-btn-default am-btn-xs am-text-danger"
               style="margin-top: 8px;margin-bottom: 6px;margin-left:2px;height: 35px;"
               value="删除" />
    </c:if>
    <input onclick="window.history.back()"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 8px;margin-bottom: 6px;margin-left:2px;height: 35px;"
           value="返回" />
</div>
<jsp:include page="/layouts/myConfirm.jsp"/>
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">订单详情</strong>
    </div>
</div>
<div am-panel am-panel-default admin-sidebar-panel>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr>
            <td>订单编号</td>
            <td>${object.serial}</td>
        </tr>
        <tr>
            <td>商户名称</td>
            <td>${object.tenant.name}</td>
        </tr>
        <tr>
            <td>创建时间</td>
            <td><fmt:formatDate value="${object.createDatetime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
        </tr>
        <tr>
            <td>状态</td>
            <td>
                <ming800:status name="status" dataType="PCPurchaseOrder.status" checkedValue="${object.status}" type="normal" />
                <c:if test="${object.status == '1' || object.status == '2'}">
                    <c:if test="${not empty object.purchaseOrderLabelList}">
                        <input onclick="window.location.href='<c:url value="/purchaseOrderPayment/newPurchaseOrderPayment.do?order=payment&orderId=${object.id}"/>'"
                               type="button" class="am-btn am-btn-default am-btn-xs"
                               style="margin-left:4px;height: 30px;"
                               value="支付" />
                    </c:if>
                    <c:if test="${not empty object.purchaseOrderPaymentList}">
                        <input onclick="window.location.href='<c:url value="/order/deliverGoods.do?orderId=${object.id}"/>'"
                               type="button" class="am-btn am-btn-default am-btn-xs"
                               style="margin-left:4px;height: 30px;"
                               value="发货" />
                    </c:if>
                </c:if>
                <c:if test="${object.status == '9' && object.status != '4' && object.status != '3'}">
                    <input onclick="myConfirm('<c:url value="/order/activatedOrCancelLabels.do?orderId=${object.id}&type=A"/>', 'A')"
                           type="button" class="am-btn am-btn-default am-btn-xs am-text-danger"
                           style="margin-left:4px;height: 30px;"
                           value="激活标签" />
                    <input onclick="myConfirm('<c:url value="/order/activatedOrCancelLabels.do?orderId=${object.id}&type=C"/>', 'C')"
                           type="button" class="am-btn am-btn-default am-btn-xs am-text-danger"
                           style="margin-left:4px;height: 30px;"
                           value="作废标签" />
                </c:if>
            </td>
        </tr>
        <c:if test="${orderTag == 'true'}">
            <tr>
                <td>查看订单标签</td>
                <td>
                    <a href="<c:url value='/basic/xm.do?qm=plistLabel_orderLabel&order=labelList&conditions=purchaseOrderLabel.purchaseOrder.serial:${object.serial}'/>">查看订单已分配标签</a>
                </td>
            </tr>
        </c:if>
    </table>
</div>
<div style="text-align: left;margin-left: 10px;" >
    <c:if test="${object.status == '1' || object.status == '2'}">
        <input onclick="showDiv()"
               type="button" class="am-btn am-btn-default am-btn-xs"
               style="margin-bottom: 6px;margin-left:2px;height: 35px;"
               value="选择商品" />
    </c:if>
</div>
<div class="am-g" id="productForm" style="display:none">
    <form id="selectProduct" onsubmit="return selectObjectSubmit('POType')" action="<c:url value='/purchaseOrderLabel/savePurchaseOrderLabel.do'/>" method="post" class="am-form am-form-horizontal">
        <input type="hidden" name="id">
        <input type="hidden" name="status" value="1" />
        <input type="hidden" name="purchaseOrder.id" value="${object.id}">
        <div class="am-form-group" style="child-align: left">
            <label name="product_id" for="product_idName" class="am-u-sm-3 am-form-label">商品名称 <small>*</small></label>
            <div class="am-u-sm-9" style="margin-left: 0px">
                <input type="text" id="product_idName" placeholder="商品名称"
                       onclick="m8uDialog.openDialog('product_id', 'product_idName', 'product2', '${object.tenant.id}','<%=path%>')"
                       required readonly>
                <input type="hidden" id="product_id"  name="product.id" >
            </div>
        </div>
        <div class="am-form-group">
            <label name="amount" for="amount" class="am-u-sm-3 am-form-label">数量 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="number" name="amount" id="amount" min="1" placeholder="数量" required>
            </div>
        </div>
        <div class="am-form-group">
            <label for="type" class="am-u-sm-3 am-form-label">标签类型 <small>*</small></label>
            <div class="am-u-sm-9" id="POType">
                <ming800:status name="type" dataType="PCLabelBatch.type" checkedValue="" type="select"/>
            </div>
        </div>
        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="submit" class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>
    </form>
</div>
<c:if test="${not empty object.purchaseOrderLabelList}">
    <div class="am-cf am-padding">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">商品列表</strong>
        </div>
    </div>
    <div am-panel am-panel-default admin-sidebar-panel>
        <table class="am-table am-table-bordered am-table-radius am-table-striped">
            <tr>
                <c:if test="${tagNFC == 'true'}">
                <td>操作</td>
                </c:if>
                <td>订单编号</td>
                <td>商品名称</td>
                <td>标签类型</td>
                <td>标签数量</td>
            </tr>
            <c:forEach items="${object.purchaseOrderLabelList}" var="pol">
                <tr>
                    <c:if test="${tagNFC == 'true'}">
                    <td>
                        <div class="am-btn-toolbar">
                            <div class="am-btn-group am-btn-group-xs" style="width: 100%;" >
                                <c:if test="${object.status == '1' || object.status == '2'}">
                                <button onclick="window.location.href='<c:url value="/basic/xm.do?qm=formPurchaseOrderLabel&order=orderLabel&id=${pol.id}"/>'"
                                        class="am-btn am-btn-default am-btn-xs am-hide-sm-only">
                                    <span class="am-icon-edit"></span> 编辑
                                </button>
                                <button onclick="window.location.href='<c:url value="/purchaseOrderLabel/removePurchaseOrderLabel.do?orderLabelId=${pol.id}"/>'"
                                        class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only">
                                    <span class="am-icon-trash-o"></span> 删除
                                </button>
                                </c:if>
                                <c:if test="${pol.type == '2' && (object.status == '9' || object.status == '3' || object.status == '4')}">
                                <button onclick="window.location.href='<c:url value="/purchaseOrderLabel/downNFCTxt.do?orderLabelId=${pol.id}&filetype=.rar"/>'"
                                        class="am-btn am-btn-default am-btn-xs am-hide-sm-only">
                                    下载NFC
                                </button>
                                </c:if>
                            </div>
                        </div>
                    </td>
                    </c:if>
                    <td>${pol.purchaseOrder.serial}</td>
                    <td>${pol.product.name}</td>
                    <td>
                        <ming800:status name="type" dataType="PCLabelBatch.type" checkedValue="${pol.type}" type="normal"/>
                    </td>
                    <td>${pol.amount}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</c:if>
<c:if test="${not empty object.purchaseOrderPaymentList}">
    <div class="am-cf am-padding">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">支付方式</strong>
        </div>
    </div>
    <div am-panel am-panel-default admin-sidebar-panel>
        <table class="am-table am-table-bordered am-table-radius am-table-striped">
            <tr>
                <c:if test="${object.status == '1' || object.status == '2'}">
                    <td>操作</td>
                </c:if>
                <td>订单编号</td>
                <td>支付方式</td>
                <td>支付时间</td>
            </tr>
            <c:forEach items="${object.purchaseOrderPaymentList}" var="pop">
                <tr>
                    <c:if test="${object.status == '1' || object.status == '2'}">
                        <td>
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs" style="width: 100%;" >
                                    <button onclick="window.location.href='<c:url value="/basic/xm.do?qm=formPurchaseOrderPayment&order=payment&id=${pop.id}"/>'"
                                            class="am-btn am-btn-default am-btn-xs am-hide-sm-only">
                                        <span class="am-icon-edit"></span> 编辑
                                    </button>
                                    <button onclick="window.location.href='<c:url value="/purchaseOrderPayment/removePurchaseOrderPayment.do?orderPaymentId=${pop.id}"/>'"
                                            class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only">
                                        <span class="am-icon-trash-o"></span> 删除
                                    </button>
                                </div>
                            </div>
                        </td>
                    </c:if>
                    <td>${pop.purchaseOrder.serial}</td>
                    <td>
                        <ming800:status name="payWay" dataType="PCPurchaseOrderPayment.payWay" checkedValue="${pop.payWay}" type="normal" />
                    </td>
                    <td><fmt:formatDate value="${pop.createDatetime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                </tr>
            </c:forEach>
        </table>
    </div>
</c:if>
</body>
</html>
