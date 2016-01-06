<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 14:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <script src="<c:url value="/scripts/jquery-1.11.1.min.js"/>"></script>
    <title></title>
</head>
<body>
<table>
</table>
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
<div class="admin-content" style="height: auto">
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-6">
        </div>
        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>

                    <td class="table-set">链接</td>
                    <td class="table-set">用户名</td>
                    <td class="table-set">真实姓名</td>
                    <td class="table-set">昵称</td>
                    <td class="table-set">操作</td>
                    <td class="table-set">注册量</td>
                    <td class="table-set">订单数</td>
                    <td class="table-set">订单总额</td>
                    <td class="table-set">实付总额</td>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${objectList}" var="user" varStatus="status">
                    <c:forEach items="${statisticsList}" var="statistics" begin="${status.index}" end="${status.index}">
                        <c:if test="${(!empty user.name) || (!empty user.name2)}">
                            <tr>
                                <td class="am-hide-sm-only">
                                    http://www.efeiyi.com/subject/iibegant1zwnlnby?source=user_${user.id}</td>
                                <td class="am-hide-sm-only">${user.username}</td>
                                <td class="am-hide-sm-only">${user.name}</td>
                                <td class="am-hide-sm-only">${user.name2}</td>
                                <td class="am-hide-sm-only">
                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                       href='<c:url value="/userGift/createQRCode.do">
                               <c:param name="userID" value="${user.id}"></c:param>
                                </c:url>'><span class="am-icon-trash-o">生成二维码并下载</span>
                                    </a>
                                </td>
                                <td class="am-hide-sm-only">
                                    <a href="<c:url value="/promotionPlan/getRegisterCountInfo.do?type=user&source=user_${user.id}"/>">${statistics.registerCount}</a>
                                </td>
                                <td class="am-hide-sm-only">
                                    <a href="<c:url value="/promotionPlan/getOrderCountInfo.do?type=user&source=user_${user.id}"/>">${statistics.orderCount}</a>
                                </td>
                                <td class="am-hide-sm-only">${statistics.orderAmount}</td>
                                <td class="am-hide-sm-only">${statistics.orderPaidAmount}</td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>
