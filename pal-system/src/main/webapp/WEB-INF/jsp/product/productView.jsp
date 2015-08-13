<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/22
  Time: 16:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title></title>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">商品${object.name}详细信息</strong>
    </div>
</div>

<div am-panel am-panel-default admin-sidebar-panel>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr>
            <td>商品名称：</td>
            <td>${object.name}</td>
        </tr>
        <tr>
            <td>序列号：</td>
            <td>${object.serial}</td>
        </tr>
        <tr>
            <td>制作时间：</td>
            <td><fmt:formatDate value="${object.madeYear}" pattern="yyyy-MM-dd"/></td>
        </tr>
        <tr>
            <td>所属系列：</td>
            <td>${object.productSeries.name}</td>
        </tr>
        <tr>
            <td>商户名称：</td>
            <td>${object.tenant.name}</td>
        </tr>
        <tr>
            <td>大师姓名：</td>
            <td>${object.tenant.masterName}</td>
        </tr>
    </table>
</div>

<c:if test="${!empty object.productPropertyValueList}">
    <div class="am-cf am-padding">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">商品${object.name}的系列属性列表</strong>
        </div>
    </div>
    <div am-panel am-panel-default admin-sidebar-panel>
        <table class="am-table am-table-bordered am-table-radius am-table-striped">
            <tr>
                <td>系列属性名</td>
                <td>商品属性值</td>
            </tr>
            <c:forEach items="${object.productPropertyValueList}" var="productPropertyValue">
                <tr>
                    <td>${productPropertyValue.productSeriesPropertyName.name}</td>
                    <td>${productPropertyValue.value}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</c:if>

<c:if test="${!empty object.tenantSource}">
    <div class="am-cf am-padding">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">商品${object.name}的溯源信息</strong>
        </div>
    </div>
    <div am-panel am-panel-default admin-sidebar-panel>
        <table class="am-table am-table-bordered am-table-radius am-table-striped">
            <tr style="text-align:left">
                <td>参与人</td>
                <td>制作工艺</td>
                <td>创作地区</td>
                <td>溯源图片</td>
            </tr>
            <tr>
                <td>${object.tenantSource.tenant.masterName}</td>
                <td>${object.tenantSource.name}</td>
                <td>${object.tenantSource.region}</td>
                <td>
                <%--${object.tenantSource.imgUrl}--%>
                    <c:if test="${!empty object.tenantSource.imgUrl}">
                        <img src="http://pal.efeiyi.com/${object.tenantSource.imgUrl}@!pal-img-list"/>
                    </c:if>
                </td>
            </tr>
        </table>
    </div>
</c:if>

<c:if test="${!empty object.tenantCertification}">
    <div class="am-cf am-padding">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">商品${object.name}的认证信息</strong>
        </div>
    </div>
    <div am-panel am-panel-default admin-sidebar-panel>
        <table class="am-table am-table-bordered am-table-radius am-table-striped">
            <tr style="text-align:left">
                <td>认证证书</td>
                <td>认证机构</td>
                <td>认证时间</td>
                <td>认证结果</td>
                <td>证书图片</td>
            </tr>
            <tr>
                <td>${object.tenantCertification.name}</td>
                <td>${object.tenantCertification.org}</td>
                <td><fmt:formatDate value="${object.tenantCertification.theDate}" pattern="yyyy年MM月"/></td>
                <td>
                    <ming800:status name="level" dataType="PCTenantCertification.level" checkedValue="${object.tenantCertification.level}" type="normal" />
                </td>
                <td>
                <%--${object.tenantCertification.imgUrl}--%>
                    <c:if test="${!empty object.tenantCertification.imgUrl}">
                        <img src="http://pal.efeiyi.com/${object.tenantCertification.imgUrl}@!pal-img-list">
                    </c:if>
                </td>
            </tr>
        </table>
    </div>
</c:if>

</body>
</html>
