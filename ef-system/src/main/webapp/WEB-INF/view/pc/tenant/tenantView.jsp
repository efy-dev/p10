<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title></title>
</head>
<body>
<div class="am-g">
    <div class="am-u-md-12">
        <h2>详细信息</h2>
        <table class="am-table am-table-bordered">
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">商家名字</td>
                <td class="am-u-md-3">${object.name}</td>
                <td class="am-primary am-u-md-3">图标</td>
                <td class="am-u-md-3" colspan="3"><img width="35px" src="http://pro.efeiyi.com/${object.logoUrl}@!product-model" alt="产品图片"></td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">简介</td>
                <td class="am-u-md-3">${object.content}</td>
                <td class="am-primary am-u-md-3">类型</td>
                <td class="am-u-md-3" colspan="3">
                    <c:if test="${object.tenantType == '11'}">
                        企业
                    </c:if>
                    <c:if test="${object.tenantType == '12'}">
                        个体
                    </c:if>
                    <c:if test="${object.tenantType == '13'}">
                        个人
                    </c:if>
                </td>

            </tr>
            <tr>
                <td class="am-primary am-u-md-3">商家联系方式</td>
                <td class="am-u-md-3">${object.phone}</td>
                <td class="am-primary am-u-md-3">商家合同号</td>
                <td class="am-u-md-3" colspan="3">${object.contractNumber}</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">开行户</td>
                <td class="am-u-md-3">${object.epositBank}</td>
                <td class="am-primary am-u-md-3">账号</td>
                <td class="am-u-md-3" colspan="3">${object.account}</td>
            </tr>
            </tbody>
        </table>

    </div>
</div>
<div class="am-g">
    <div class="am-u-md-12">
        <h2>大师信息</h2>
    </div>

    <div class="am-u-md-12">
        <jsp:include flush="true"
                     page="/basic/xm.do?qm=listTenantMaster_default&conditions=tenant.id:${object.id}&tenantId=${object.id}"/>
    </div>
</div>
<div class="am-g">
    <div class="am-u-md-12">
        <h2>项目信息</h2>
    </div>

    <div class="am-u-md-12">
        <jsp:include flush="true"
                     page="/basic/xm.do?qm=listTenantProject_default&conditions=tenant.id:${object.id}&tenantId=${object.id}"/>
    </div>
</div>
<div class="am-g">
    <div class="am-u-md-12">
        <h2>商家用户</h2>
    </div>

    <div class="am-u-md-12">
        <jsp:include flush="true"
                     page="/basic/xm.do?qm=listProfessional_default&conditions=bigTenant.id:${object.id}"/>
    </div>
</div>
<%--<div class="am-g">--%>
    <%--<div class="am-u-md-12">--%>
        <%--<h2>大师信息</h2>--%>

        <%--<div class="am-g">--%>
            <%--<div class="am-u-sm-12 am-u-md-6">--%>
            <%--</div>--%>
            <%--<div class="am-u-sm-12">--%>
                <%--<table class="am-table am-table-striped am-table-hover table-main">--%>
                    <%--<thead>--%>
                    <%--<tr>--%>
                        <%--<th class="table-title">大师姓名</th>--%>
                        <%--<th class="table-title">性别</th>--%>
                        <%--<th class="table-title">等级</th>--%>

                    <%--</tr>--%>
                    <%--</thead>--%>
                    <%--<tbody>--%>
                    <%--<c:forEach items="${object.tenantMasterList}" var="tenantMaster" end="4">--%>
                        <%--<tr id="${tenantMaster.id}">--%>
                            <%--<td class="am-hide-sm-only">--%>
                                    <%--${tenantMaster.master.fullName}--%>
                            <%--</td>--%>
                            <%--<td class="am-hide-sm-only">${product.sex}</td>--%>
                            <%--<td class="am-hide-sm-only">${product.level}</td>--%>
                        <%--</tr>--%>
                    <%--</c:forEach>--%>
                    <%--</tbody>--%>
                <%--</table>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--&lt;%&ndash;<jsp:include flush="true"&ndash;%&gt;--%>
                     <%--&lt;%&ndash;page="/basic/xm.do?qm=listTenantMaster&conditions=tenant.id:${object.id}"/>&ndash;%&gt;--%>
    <%--</div>--%>
    <%--<div class="am-u-md-12">--%>
        <%--<h2>项目信息</h2>--%>
        <%--<div class="am-g">--%>
            <%--<div class="am-u-sm-12 am-u-md-6">--%>
            <%--</div>--%>
            <%--<div class="am-u-sm-12">--%>
                <%--<table class="am-table am-table-striped am-table-hover table-main">--%>
                    <%--<thead>--%>
                    <%--<tr>--%>
                        <%--<th width="74%">项目名称</th>--%>
                        <%--<th width="">项目编号</th>--%>

                    <%--</tr>--%>
                    <%--</thead>--%>
                    <%--<tbody>--%>
                    <%--<c:forEach items="${object.tenantProjectList}" var="tenantProject" end="4">--%>
                        <%--<tr id="${tenantProject.id}">--%>
                            <%--<td class="am-hide-sm-only">--%>
                                    <%--${tenantProject.project.name}--%>
                            <%--</td>--%>
                            <%--<td class="am-hide-sm-only"> ${tenantProject.project.serial}</td>--%>
                        <%--</tr>--%>
                    <%--</c:forEach>--%>
                    <%--</tbody>--%>
                <%--</table>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--&lt;%&ndash;<jsp:include flush="true"&ndash;%&gt;--%>
                     <%--&lt;%&ndash;page="/basic/xm.do?qm=listTenantProject&conditions=tenant.id:${object.id}"/>&ndash;%&gt;--%>
    <%--</div>--%>
<%--</div>--%>
</body>
</html>
