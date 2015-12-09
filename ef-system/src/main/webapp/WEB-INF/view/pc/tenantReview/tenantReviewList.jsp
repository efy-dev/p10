<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/18
  Time: 14:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div class="am-g">

    <div class="am-u-sm-12">
        <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
            <tr>
                <th class="table-title" width="25%">审核状态</th>
                <th class="table-title" width="25%">审核意见</th>
                <th class="table-title" width="25%">审核时间</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${objectList}" var="tenantReview">
                <tr id="${tenantMaster.id}">

                    <td class="am-hide-sm-only">
                        <c:if test="${tenantReview.reviewStatus=='4'}">
                            审核成功
                        </c:if>
                        <c:if test="${tenantReview.reviewStatus!='4'}">
                            审核失败
                        </c:if>
                    </td>
                    <td class="am-hide-sm-only">
                       ${tenantReview.content}

                    </td>
                    <td class="am-hide-sm-only">
                        <fmt:formatDate value="${tenantReview.createDateTime}" pattern="yyyy-MM-dd hh:mm:ss" type="both"/>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>

</script>