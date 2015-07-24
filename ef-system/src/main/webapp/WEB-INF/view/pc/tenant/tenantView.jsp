<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title></title>
    <style>
    </style>
</head>
<body>
<%--<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>--%>

<div class="am-g">
    <div class="am-u-md-12">
        <h2>详细信息</h2>
        <table class="am-table am-table-bordered">
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">名字</td>
                <td class="am-u-md-3">${object.name}</td>
                <td class="am-primary am-u-md-3">头衔</td>
                <td class="am-u-md-3">${object.title}</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">等级</td>
                <td class="am-u-md-3">${object.level}</td>
                <td class="am-primary am-u-md-3">简介</td>
                <td class="am-u-md-3">${object.brief}</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<div class="am-g">
    <div class="am-u-md-12">
        <h2>传承人的项目</h2>
        <div class="am-btn-toolbar">
            <div class="am-btn-group am-btn-group-xs">
                <a type="button" class="am-btn am-btn-default"
                   href="<c:url value="/basic/xm.do?qm=listProject_default&tenantId=${object.id}&master=1"/>"><span
                        class="am-icon-plus"></span> 新建为主项目</a>
                <a type="button" class="am-btn am-btn-default"
                   href="<c:url value="/basic/xm.do?qm=listProject_default&tenantId=${object.id}"/>"><span
                        class="am-icon-plus"></span> 新建项目</a>
            </div>
        </div>
    </div>

    <div class="am-u-md-12">
        <jsp:include flush="true"
                     page="${pageContext.request.contextPath}/basic/xm.do?qm=listTenantProject_include&conditions=tenant.id:${object.id}"/>
    </div>
</div>




<div class="am-g">

    <div class="am-u-md-12">
    <h2>轮播图</h2>
        <div class="am-btn-toolbar">
            <div class="am-btn-group am-btn-group-xs">
                <a type="button" class="am-btn am-btn-default"
                   href="<c:url value="/basic/xm.do?qm=formTenantBanner&tenantId=${object.id}"/>"><span
                        class="am-icon-plus"></span> 新建轮播图</a>
            </div>
        </div>
    </div>

    <div class="am-u-md-12">
        <jsp:include flush="true"
                     page="${pageContext.request.contextPath}/basic/xm.do?qm=listTenantBanner_default&conditions=tenant.id:${object.id}"/>
    </div>
</div>


<div class="am-g">
    <div class="am-u-md-12">
        <h2>传承人介绍</h2>
        <div class="am-btn-toolbar">
            <div class="am-btn-group am-btn-group-xs">
                <a type="button" class="am-btn am-btn-default"
                   href="<c:url value="/basic/xm.do?qm=formTenantIntroduction&tenantId=${object.id}"/>"><span
                        class="am-icon-plus"></span> 新建传承人介绍</a>
            </div>
        </div>
    </div>

    <div class="am-u-md-12">
        <jsp:include flush="true"
                     page="${pageContext.request.contextPath}/basic/xm.do?qm=listTenantIntroduction_include&conditions=tenant.id:${object.id}"/>
    </div>
</div>





<div class="am-g">
    <div class="am-u-md-12">
        <h2>传承人的资讯</h2>
        <div class="am-btn-toolbar">
            <div class="am-btn-group am-btn-group-xs">
                <a type="button" class="am-btn am-btn-default"
                   href="<c:url value="/basic/xm.do?qm=formTenantNews&tenantId=${object.id}"/>"><span
                        class="am-icon-plus"></span>新建资讯</a>
            </div>
        </div>
    </div>

    <div class="am-u-md-12">
        <jsp:include flush="true"
                     page="${pageContext.request.contextPath}/basic/xm.do?qm=listTenantNews_include&conditions=tenant.id:${object.id}"/>
    </div>
</div>

<div class="am-g">
    <div class="am-u-md-12">
        <h2>传承人工作坊</h2>
        <div class="am-btn-toolbar">
            <div class="am-btn-group am-btn-group-xs">
                <a type="button" class="am-btn am-btn-default"
                   href="<c:url value="/basic/xm.do?qm=formTenantWorkShop&tenantId=${object.id}"/>"><span
                        class="am-icon-plus"></span>新建工作坊</a>
            </div>
        </div>
    </div>

    <div class="am-u-md-12">
        <jsp:include flush="true"
                     page="${pageContext.request.contextPath}/basic/xm.do?qm=listTenantWorkShop_default&conditions=tenant.id:${object.id}"/>
    </div>
</div>


</body>
</html>
