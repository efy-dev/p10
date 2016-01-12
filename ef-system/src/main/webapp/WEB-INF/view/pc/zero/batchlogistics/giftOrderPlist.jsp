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
    <title>返利链接注册用户列表</title>
</head>
<body style="height: auto">
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
                                    value="/company/cancelPurchaseOrderGift.do?id=${purchaseOrderProduct.purchaseOrder.id}"/>'"
                                    class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only">取消订单
                            </button>
                            <button onclick="window.location.href='<c:url
                                    value="/basic/xm.do?qm=viewBatchGift&id=${purchaseOrderProduct.id}"/>'"
                                    class="am-btn am-btn-default am-btn-xs am-hide-sm-only"> 查看详情
                            </button>
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
</script>
</body>
</html>
