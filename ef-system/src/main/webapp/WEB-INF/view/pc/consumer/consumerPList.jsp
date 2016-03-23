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
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title></title>
    <script>
        function removeConsumer(consumerId){
            jQuery.ajax({
                type:"GET",
                url:'<c:url value="/consumer/remove.do"/>',
                data:{id:consumerId},
                dataType:"json",
                success:function(data){
                    $("#"+consumerId).remove();
                }
            });
        }
    </script>
</head>
<body>
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
<div class="admin-content">
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-6">
        </div>
        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>

                    <th class="table-set">操作</th>
                    <th class="table-title">用户名</th>
                    <th class="table-title">电话</th>
                    <th class="table-title">性别</th>
                    <th class="table-title">账户余额</th>
                    <th class="table-title">积分</th>
                    <th class="table-title">注册时间</th>

                </tr>
                </thead>
                <tbody>
                <c:forEach items="${requestScope.pageInfo.list}" var="consumer">
                    <tr id="${consumer.id}">
                        <td>
                            <div class="am-btn-toolbar">
                                <security:authorize ifAnyGranted="admin,operational,o_operational">
                                <div class="am-btn-group am-btn-group-xs">
                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                       href="<c:url value="/basic/xm.do?qm=formConsumer&id=${consumer.id}"/>"><span
                                            class="am-icon-trash-o">编辑</span>
                                    </a>
                                </div>
                                <div class="am-btn-group am-btn-group-xs">
                                    <button class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="showConfirm('提示','是否删除',function(){removeConsumer('${consumer.id}')})"><span
                                            class="am-icon-trash-o">删除</span>
                                    </button>
                                </div>
                                </security:authorize>
                                <div class="am-btn-group am-btn-group-xs">
                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                       href="<c:url value="/basic/xm.do?qm=plistPurchaseOrder_consumer&view=consumer&viewIdentify=consumer&viewProductModel=consumer&conditions=user.id:${consumer.id}"/>"><span
                                            class="am-icon-trash-o">查看消费者订单</span>
                                    </a>
                                </div>
                                <div class="am-btn-group am-btn-group-xs">
                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                       href="<c:url value="/basic/xm.do?qm=plistConsumerCoupon_default&conditions=consumer.id:${consumer.id}"/>"><span
                                            class="am-icon-trash-o">查看优惠券</span>
                                    </a>
                                </div>
                            </div>
                        </td>

                        <td class="am-hide-sm-only"><a href="<c:url value='/basic/xm.do?qm=viewConsumer&viewConsumer=consumer&id=${consumer.id}'/>">${consumer.username}</a></td>
                        <td class="am-hide-sm-only">${consumer.phone}</td>
                        <td class="am-hide-sm-only">
                                <ming800:status name="sex" dataType="Consumer.sex"
                                                checkedValue="${consumer.sex}"
                                                type="normal"/>
                        </td>
                        <td class="am-hide-sm-only">${consumer.deposit}</td>
                        <td class="am-hide-sm-only">${consumer.score}</td>
                        <td class="am-hide-sm-only"><fmt:formatDate value="${consumer.createDatetime}" type="both"
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
            <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
        </ming800:pcPageList>
    </div>
</div>

</body>
</html>
