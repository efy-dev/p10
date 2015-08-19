<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/19
  Time: 15:00
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
        <strong class="am-text-primary am-text-lg">商品系列${object.name}详细信息</strong>
    </div>
</div>

<div am-panel am-panel-default admin-sidebar-panel>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr>
            <td>商品系列名称：</td>
            <td>${object.name}</td>
        </tr>
        <tr>
            <td>序列号：</td>
            <td>${object.serial}</td>
        </tr>
        <tr>
            <td>状态：</td>
            <td>${object.status}</td>
        </tr>
    </table>
</div>

<c:if test="${!empty object.productSeriesPropertyNameList}">
    <div class="am-cf am-padding">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">商品系列${object.name}的系列属性名列表</strong> / <small>ProductSeries PropertyNameList</small>
        </div>
    </div>
    <div am-panel am-panel-default admin-sidebar-panel>
        <table class="am-table am-table-bordered am-table-radius am-table-striped">
            <tr>
                <td>编号</td>
                <td>属性名</td>
            </tr>
            <% int i = 1;%>
            <c:forEach items="${object.productSeriesPropertyNameList}" var="productSeriesPropertyName">
                <tr>
                    <td><%=i %>、</td>
                    <td>${productSeriesPropertyName.name}</td>
                </tr>
                <% i += 1;%>
            </c:forEach>
        </table>
    </div>
</c:if>

<c:if test="${!empty object.tenantSet}">
    <div class="am-cf am-padding">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">包含商品系列的商户</strong>
        </div>
    </div>
    <div>
        <table class="am-table am-table-bordered am-table-radius am-table-striped">
            <tr style="text-align:left">
                <td>商户名称</td>
                <td>地址</td>
            </tr>

            <c:forEach items="${object.tenantSet}" var="tenant">
                <tr style="text-align: left">
                    <td><a href="<c:url value="/basic/xm.do?qm=viewTenant&id=${tenant.id}"/>">${tenant.name}</a></td>
                    <td>${tenant.province}&nbsp;${tenant.city}&nbsp;${tenant.address}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</c:if>

</body>
</html>
