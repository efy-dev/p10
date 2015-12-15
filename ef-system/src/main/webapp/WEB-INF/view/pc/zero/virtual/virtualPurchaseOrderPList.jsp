<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/11/25
  Time: 17:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title>虚拟数据批次</title>
</head>
<body style="height: auto">
<%--<div style="text-align: left;margin-left: 10px;">
    <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=formVirtualPlan&VirtualPlan=VirtualPlan"/>'"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 4px;margin-bottom: 6px;margin-left:2px;height: 35px;"
           value="新建虚拟数据批次"/>
</div>--%>
<div style="text-align: left;margin-left: 10px;">
    <input onclick="window.history.go(-1);"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 4px;margin-bottom: 6px;margin-left:2px;height: 35px;"
           value="返回"/>
</div>
<div>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr style="text-align:left">
            <td>操作</td>
            <td>订单编号</td>
            <td>用户</td>
            <td>商品编号</td>
            <td>商品名称</td>
            <td>订单金额</td>
            <td>下单时间</td>
            <td>评价</td>
        </tr>
        <c:forEach items="${popList}" var="pop">
            <tr>
                <td>
                    <div class="am-btn-toolbar">
                        <div class="am-btn-group am-btn-group-xs" style="width: 100%;">
                            <button onclick="window.location.href='<c:url
                                    value=""/>'"
                                    class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                    class="am-icon-edit"></span> 编辑
                            </button>
                            <button onclick="window.location.href='<c:url
                                    value=""/>'"
                                    class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                                    class="am-icon-trash-o"></span> 删除
                            </button>
                        </div>
                    </div>
                </td>
                <td>${pop.purchaseOrder.serial}</td>
                <td>${pop.purchaseOrder.user.username}</td>
                <td>${pop.productModel.serial}</td>
                <td>${pop.productModel.name}</td>
                <td>${pop.purchasePrice}</td>
                <td>
                    <fmt:formatDate value="${pop.purchaseOrder.createDatetime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </td>
                <td>${pop.purchaseOrderComment.content}</td>
            </tr>
        </c:forEach>
    </table>
</div>
<div style="clear: both">
    <c:url value="/virtualPlan/getTypeObjectList.do" var="url"/>
    <ming800:pcPageList bean="${pageEntity}" url="${url}">
        <ming800:pcPageParam name="id" value="${planId}"/>
        <ming800:pcPageParam name="type" value="${objectType}"/>
    </ming800:pcPageList>
</div>
</body>
</html>
