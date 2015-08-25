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
            <td>
                <ming800:status name="status" dataType="PCProductSeries.status"
                                checkedValue="${object.status}" type="normal"/>
            </td>
        </tr>
    </table>
</div>

<div style="text-align: left;margin-left: 10px;">
    <input onclick="window.location.href='<c:url value="/productSeriesPropertyName/newPropertyNameList.do?productSeriesId=${object.id}"/>'"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 4px;margin-bottom: 6px;margin-left:2px;height: 35px;"
           value="添加/编辑--属性"/>
</div>

<c:if test="${!empty object.productSeriesPropertyNameList}">
    <div class="am-cf am-padding">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">${object.name}的系列属性名列表</strong>
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

<c:if test="${not empty object.tenantProductSeriesList}">
    <div class="am-cf am-padding">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">商户系列</strong>/<small>溯源信息</small>
        </div>
    </div>
    <div>
        <table class="am-table am-table-bordered am-table-radius am-table-striped">
            <tr style="text-align:left">
                <td>操作</td>
                <td>商户名称</td>
                <td>商户地址</td>
                <td>制作工艺</td>
                <td>创作地域</td>
                <td>溯源图片</td>
                <td>编辑溯源图片</td>
            </tr>

            <c:forEach items="${object.tenantProductSeriesList}" var="tenantProductSeries">
                <tr style="text-align: left">
                    <td>
                        <button onclick="window.location.href='<c:url value="/basic/xm.do?qm=formTenantProductSeries&id=${tenantProductSeries.id}"/>'"
                                class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span class="am-icon-edit"></span> 编辑溯源信息</button>
                    </td>
                    <td><a href="<c:url value="/basic/xm.do?qm=viewTenant&id=${tenantProductSeries.tenant.id}"/>">${tenantProductSeries.tenant.name}</a></td>
                    <td>${tenantProductSeries.tenant.province}&nbsp;${tenantProductSeries.tenant.city}&nbsp;${tenantProductSeries.tenant.address}</td>
                    <td>${tenantProductSeries.craft}</td>
                    <td>${tenantProductSeries.region}</td>
                    <td>
                        <c:forEach items="${tenantProductSeries.imgList}" var="img">
                            <c:if test="${not empty img.imgUrl}">
                                <img src="http://pal.efeiyi.com/${img.imgUrl}@!pal-img-list"/>
                            </c:if>
                        </c:forEach>
                    </td>
                    <td>
                        <button onclick="window.location.href='<c:url value="/basic/xm.do?qm=viewTenantProductSeries&id=${tenantProductSeries.id}"/>'"
                                class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span class="am-icon-edit"></span> 编辑溯源图片</button>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</c:if>

</body>
</html>
