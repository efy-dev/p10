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

<html>
<head>
    <title></title>
    <script type="text/javascript" src="<c:url value='/scripts/jquery-1.11.1.min.js'/>"></script>
</head>
<body>

<%--<table>--%>
    <%--<tr>--%>
        <%--<td>传承人产品id</td>--%>
        <%--<td>传承人产品name</td>--%>
    <%--</tr>--%>

    <%--<c:forEach items="${requestScope.pageInfo.list}" var="tenantProduct">--%>
        <%--<tr>--%>
            <%--<td>${tenantProduct.id}</td>--%>
            <%--<td>${tenantProduct.name}</td>--%>
        <%--</tr>--%>
    <%--</c:forEach>--%>


<%--</table>--%>
<%--<div style="clear: both">--%>
    <%--<ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="/basic/xm.do">--%>
        <%--<ming800:pcPageParam name="qm" value="${requestScope.qm}"/>--%>
        <%--<ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>--%>
    <%--</ming800:pcPageList>--%>
<%--</div>--%>


<div class="admin-content">

    <div class="am-u-md-12">
        <div class="am-btn-toolbar">
            <div class="am-btn-group am-btn-group-xs">
                <a type="button" class="am-btn am-btn-default"
                   href="<c:url value="/basic/xm.do?qm=formTenantWork&tenantId=${tenantId}&projectId=${projectId}"/>"><span
                        class="am-icon-plus"></span>新建作品</a>
            </div>
        </div>
    </div>


    <div class="am-g">
        <div class="am-u-sm-12">
                <table class="am-table am-table-striped am-table-hover table-main">
                    <thead>
                    <tr>
                        <th class="table-set">操作</th>
                        <th class="table-title">名字</th>
                        <th class="table-title">作者</th>
                        <th class="table-title">价格</th>
                        <th class="table-title">作品描述</th>

                    </tr>
                    </thead>
                    <tbody>

                    <c:forEach items="${requestScope.pageInfo.list}" var="tenantWork">
                        <tr>
                            <td>
                                <div class="am-btn-toolbar">
                                    <div class="am-btn-group am-btn-group-xs">
                                        <a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="<c:url value="/basic/xm.do?qm=formTenantWork&id=${tenantWork.id}&tenantId=${tenantWork.tenant.id}"/>"><span
                                                class="am-icon-pencil-square-o"></span> 编辑
                                        </a>
                                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" href="<c:url value="/basic/xm.do?qm=removeTenantWork&id=${tenantWork.id}"/>"><span
                                                class="am-icon-trash-o"></span> 删除
                                        </a>
                                    </div>
                                </div>
                            </td>
                            <td class="am-hide-sm-only"><a href="<c:url value="/basic/xm.do?qm=viewTenantWork&id=${tenantWork.id}"/>">${tenantWork.name}</a></td>
                            <td class="am-hide-sm-only">${tenantWork.tenant.name}</td>
                            <td class="am-hide-sm-only">${tenantWork.price}</td>
                            <td class="am-hide-sm-only">${tenantWork.productDescription.content}</td>
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
