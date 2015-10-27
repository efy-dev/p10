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
        function removePurchaseOrderComment(divId) {
            jQuery.ajax({
                type: "GET",
                url: '<c:url value="/basic/xmj.do?qm=removePurchaseOrderComment"/>',
                data: {id: divId},
                dataType: "json",
                success: function (data) {
                    $("#" + divId).remove();
                }
            });
        }



    </script>
</head>
<body>
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
<div class="admin-content" style="height: auto">
    <div class="am-g">
        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
                    <th class="table-set">操作</th>
                    <th class="table-title">订单编号</th>
                    <th class="table-title">用户名</th>
                    <th class="table-title">昵称</th>
                    <th class="table-title">总额/实付金额(元)</th>
                    <th class="table-title">产品</th>
                    <th class="table-title">评价内容</th>
                    <th class="table-title">评价时间</th>

                </tr>
                </thead>
                <tbody>


                <c:forEach items="${requestScope.pageInfo.list}" var="purchaseOrderComment">
                    <tr id="${purchaseOrderComment.id}" width="12%">
                        <td width="12%">
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">
                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="javascript:void (0);" onclick="showConfirm('提示','是否删除',function(){removePurchaseOrderComment('${purchaseOrderComment.id}')})">
                                        删除
                                    </a>
                                </div>
                            </div>
                        </td>
                        <td class="am-hide-sm-only" width="12%">
                            <a
                                href="<c:url value='/basic/xm.do?qm=viewPurchaseOrder&viewIdentify=comment&id=${purchaseOrderComment.purchaseOrderProduct.purchaseOrder.id}'/>">${purchaseOrderComment.purchaseOrderProduct.purchaseOrder.serial}
                            </a>
                        </td>

                        <td class="am-hide-sm-only" width="12%">${purchaseOrderComment.purchaseOrderProduct.purchaseOrder.user.username}</td>
                        <td class="am-hide-sm-only" width="12%">${purchaseOrderComment.purchaseOrderProduct.purchaseOrder.user.name}</td>
                        <td class="am-hide-sm-only" width="12%">
                            <fmt:formatNumber type="number" value="${purchaseOrderComment.purchaseOrderProduct.productModel.price}" maxFractionDigits="2" minFractionDigits="2"/> <br>
                        </td>
                        <td class="am-hide-sm-only" width="12%">
                                <p style="margin-left: 10px;">
                                         ${purchaseOrderComment.purchaseOrderProduct.productModel.name}
                                         <img width="20px" src="http://pro.efeiyi.com/${purchaseOrderComment.purchaseOrderProduct.productModel.productModel_url}@!product-model" alt="产品图片">
                                </p>
                        </td>

                        <td class="am-hide-sm-only" width="12%">${purchaseOrderComment.content}</td>
                        <td class="am-hide-sm-only" width="12%"></td>
                        <%--<td class="am-hide-sm-only"><fmt:formatDate value="${purchaseOrder.createDatetime}" type="both"--%>
                                                                    <%--pattern="yyyy-MM-dd HH:mm"/></td>--%>
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


</body>
</html>
