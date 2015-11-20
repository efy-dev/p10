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

        <div style="margin-bottom: 10px;">
<security:authorize ifAnyGranted="admin,operational,c_operational">
            <a type="button" class="am-btn am-btn-default am-btn-xs" href="<c:url value="/basic/xm.do?qm=formTenantCategory&id=${object.id}&tenantId=${tenantId}"/>">修改</a>
    </security:authorize>
        </div>
        <table class="am-table am-table-bordered">
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">商家名字</td>
                <td class="am-u-md-3">${object.tenant.name}</td>
                <td class="am-primary am-u-md-3">类别名称</td>
                <td class="am-u-md-3" colspan="3">
                    ${object.value}
                </td>
            </tr>
            </tbody>
        </table>

    </div>
</div>
<div class="am-g">
    <div class="am-u-md-12">
        <h2>商品</h2>
    </div>

    <div class="am-u-md-12">
        <jsp:include flush="true"
                     page="/basic/xm.do?qm=listTenantProductTag_default&conditions=tenantCategory.id:${object.id}&tenantCategoryId=${object.id}&tenantId=${tenantId}"/>
    </div>
</div>


</body>
</html>
