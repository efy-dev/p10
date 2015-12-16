<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/12/04
  Time: 09:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title>返利列表</title>
</head>
<body style="height: auto">
<div style="text-align: left;margin-left: 10px;">
    <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=formPromotionPlan&rebate=rebate"/>'"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 4px;margin-bottom: 6px;margin-left:2px;height: 35px;"
           value="新建返利链接"/>
</div>
<div>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr style="text-align:left">
            <td>操作</td>
            <td>连接名称</td>
            <td>连接标识</td>
            <td>分享渠道</td>
            <td>注册量</td>
            <td>订单数</td>
            <td>订单总额</td>
            <td>实付总额</td>
            <td>创建时间</td>
        </tr>
        <c:forEach items="${PPEList}" var="PPE">
            <tr>
                <td>
                    <div class="am-btn-toolbar">
                        <div class="am-btn-group am-btn-group-xs" style="width: 100%;">
                            <button onclick="window.location.href='<c:url
                                    value="/basic/xm.do?qm=formPromotionPlan&rebate=rebate&id=${PPE.promotionPlan.id}"/>'"
                                    class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                    class="am-icon-edit"></span> 编辑
                            </button>
                            <button onclick="window.location.href='<c:url
                                    value="/basic/xm.do?qm=removePromotionPlan&id=${PPE.promotionPlan.id}"/>'"
                                    class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                                    class="am-icon-trash-o"></span> 删除
                            </button>
                        </div>
                    </div>
                </td>
                <td>${PPE.promotionPlan.urlDescription}</td>
                <td>${PPE.promotionPlan.url}?source=${PPE.promotionPlan.identifier}</td>
                <td>
                    <ming800:status name="name" dataType="PCPromotionPlan.name"
                                    checkedValue="${PPE.promotionPlan.name}" type="normal"/>
                </td>
                <td>
                    <a href="<c:url value="/promotionPlan/getZCLInfo.do?id=${PPE.promotionPlan.id}"/>">${PPE.registerCount}</a>
                </td>
                <td>
                    <a href="<c:url value="/promotionPlan/getDDLInfo.do?id=${PPE.promotionPlan.id}"/>">${PPE.orderCount}</a>
                </td>
                <td>${PPE.orderAmount}</td>
                <td>${PPE.ordePaidAmount}</td>
                <td>
                    <fmt:formatDate value="${PPE.promotionPlan.createDatetime}" pattern="yyyy-MM-dd HH:mm:ss"/>
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
</body>
</html>
