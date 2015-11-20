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
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <script src="<c:url value="/scripts/jquery-1.11.1.min.js"/>"></script>
    <title></title>
</head>
<body>

<div class="am-g">
    <div class="am-u-sm-12 am-u-md-6">
        <div class="am-btn-toolbar">
            <div class="am-btn-group am-btn-group-xs">
<security:authorize ifAnyGranted="admin,operational,c_operational">
                <a type="button" class="am-btn am-btn-default"
                   href="<c:url value="/basic/xm.do?qm=formMasterMessage&masterId=${masterId}"/>"><span
                        class="am-icon-plus"></span>新建动态</a>
    </security:authorize>
            </div>
        </div>
    </div>
    <div class="am-u-sm-12">
        <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
                <tr style="width: 100%;">
<security:authorize ifAnyGranted="admin,operational,c_operational">
                    <th class="table-title">操作</th>
</security:authorize>
                    <th class="table-set">传承人名称</th>
                    <th class="table-title">项目名称</th>
                    <th class="table-title">动态</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${requestScope.pageInfo.list}" var="msg">
                    <tr id="${msg.master.id}">
                        <security:authorize ifAnyGranted="admin,operational,c_operational">
                        <td>
                            <a type="button" class="am-btn am-btn-default"
                               href="<c:url value='/basic/xm.do?qm=formMasterMessage&masterId=${msg.master.id}&id=${msg.id}'/>">
                                    <%--<a type="button" class="am-btn am-btn-default" href="<c:url value='/basic/xm.do?qm=formMessage&masterMessageId=${msg.id}'/>">--%>
                                编辑
                            </a>

                            <a type="button" class="am-btn am-btn-default"
                               href="<c:url value='/basic/xm.do?qm=removeMasterMessage&messageId=${msg.id}&masterId=${msg.master.id}'/>">
                                删除
                            </a>
                        </td>
                        </security:authorize>
                        <%--<td>--%>
                            <%--<a type="button" class="am-btn am-btn-default"--%>
                               <%--href="<c:url value='/basic/xm.do?qm=formMessageAttachment&masterMessageId=${msg.id}&type=${msg.type}'/>">--%>
                                <%--添加附件--%>
                            <%--</a>--%>
                        <%--</td>--%>
                        <td class="am-hide-sm-only" width="10%">
                                ${msg.master.fullName}
                        </td>
                        <td class="am-hide-sm-only" width="20%">
                                ${msg.project.name}
                        </td>
                        <td class="am-hide-sm-only" width="50%">
                            <a href="<c:url value='/basic/xm.do?qm=viewMasterMessage&masterId=${msg.master.id}&id=${msg.id}'/>">
                                <c:choose>
                                    <c:when test="${fn:length(msg.content) > 30}">
                                        <c:out value="${fn:substring(msg.content, 0, 30)}..."/>
                                    </c:when>
                                    <c:otherwise>
                                        ${msg.content}
                                    </c:otherwise>
                                </c:choose>
                            </a>
                        </td>
                        <td class="am-hide-sm-only" width="10%">
                            <ming800:status name="type" dataType="MasterMessage.type" checkedValue="${msg.type}"
                                            type="normal"/>
                        </td>
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

</body>
</html>
