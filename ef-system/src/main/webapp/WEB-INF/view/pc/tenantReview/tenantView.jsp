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
        <h2>审核</h2>
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
                <td class="am-primary am-u-md-3"></td>
                <td class="am-u-md-3" colspan="3"></td>
            </tr>
            </tbody>
        </table>

    </div>
</div>
<div class="am-g">
    <div class="am-u-md-12">
        <h2>审核记录</h2>
    </div>

    <div class="am-u-md-12">
        <jsp:include flush="true"
                     page="/basic/xm.do?qm=listTenantMaster_default&conditions=tenant.id:${object.id}&tenantId=${object.id}"/>
    </div>
</div>

</body>
</html>
