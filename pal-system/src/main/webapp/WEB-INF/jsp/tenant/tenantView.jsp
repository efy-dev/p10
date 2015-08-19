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
        <strong class="am-text-primary am-text-lg">商户${object.name}详细信息</strong>
    </div>
</div>

<div am-panel am-panel-default admin-sidebar-panel>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr>
            <td>商户名称：</td>
            <td>${object.name}</td>
        </tr>
        <tr>
            <td>地址：</td>
            <td>${object.province}&nbsp;${object.city}&nbsp;${object.address}</td>
        </tr>
    </table>
</div>

<div style="text-align: left;margin-left: 10px;">
    <input onclick="window.location.href='<c:url value="/tenant/selectProductSeries.do?tenantId=${object.id}"/>'"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;"
           value="选择商品系列"/>
</div>

<c:if test="${!empty object.productSeriesSet}">
    <div class="am-cf am-padding">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">商户拥有的商品系列</strong>
        </div>
    </div>
    <div>
        <table class="am-table am-table-bordered am-table-radius am-table-striped">
            <tr>
                <td>操作</td>
                <td>系列名称</td>
                <td>序列号</td>
            </tr>

            <c:forEach items="${object.productSeriesSet}" var="productSeries">
                <tr style="text-align: left">
                    <td>
                        <div class="am-btn-toolbar">
                            <div class="am-btn-group am-btn-group-xs" style="width: 100%;" >
                                <button onclick="window.location.href='<c:url value="/tenant/delTenantProductSeries.do?tenantId=${object.id}&productSeriesId=${productSeries.id}"/>'"
                                        class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 删除</button>
                            </div>
                        </div>
                    </td>
                    <td><a href="<c:url value="/basic/xm.do?qm=viewProductSeries&id=${productSeries.id}"/>">${productSeries.name}</a></td>
                    <td>${productSeries.serial}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</c:if>

<%--<div style="text-align: left;margin-left: 10px;" >--%>
    <%--<input onclick="window.location.href='<c:url value="/tenantSource/newTenantSource.do?tenantId=${object.id}"/>'"--%>
           <%--type="button" class="am-btn am-btn-default am-btn-xs"--%>
           <%--style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;"--%>
           <%--value="新建溯源信息" />--%>
    <%--<input onclick="window.location.href='<c:url value="/tenantCertification/newTenantCertification.do?tenantId=${object.id}"/>'"--%>
           <%--type="button" class="am-btn am-btn-default am-btn-xs"--%>
           <%--style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;"--%>
           <%--value="新建认证信息" />--%>
<%--</div>--%>
<%--<c:if test="${!empty object.tenantSourceList}">--%>
    <%--<div class="am-cf am-padding">--%>
        <%--<div class="am-fl am-cf">--%>
            <%--<strong class="am-text-primary am-text-lg">溯源信息</strong>--%>
        <%--</div>--%>
    <%--</div>--%>
    <%--<div>--%>
        <%--<table class="am-table am-table-bordered am-table-radius am-table-striped">--%>
            <%--<tr style="text-align:left">--%>
                <%--<td>操作</td>--%>
                <%--<td>参与人</td>--%>
                <%--<td>制作工艺</td>--%>
                <%--<td>创作地区</td>--%>
                <%--<td>溯源图片</td>--%>
            <%--</tr>--%>

            <%--<c:forEach items="${object.tenantSourceList}" var="tenantSource">--%>
                <%--<tr>--%>
                    <%--<td>--%>
                        <%--<div class="am-btn-toolbar">--%>
                            <%--<div class="am-btn-group am-btn-group-xs" style="width: 100%;" >--%>
                                <%--<button onclick="window.location.href='<c:url value="/basic/xm.do?qm=formTenantSource&id=${tenantSource.id}"/>'"--%>
                                        <%--class="am-btn am-btn-default am-btn-xs am-hide-sm-only">--%>
                                    <%--<span class="am-icon-edit"></span> 编辑--%>
                                <%--</button>--%>
                                <%--<button onclick="window.location.href='<c:url value="/tenantSource/removeTenantSource.do?tenantSourceId=${tenantSource.id}"/>'"--%>
                                        <%--class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only">--%>
                                    <%--<span class="am-icon-trash-o"></span> 删除--%>
                                <%--</button>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    <%--</td>--%>
                    <%--<td></td>--%>
                    <%--<td>${tenantSource.name}</td>--%>
                    <%--<td>${tenantSource.region}</td>--%>
                    <%--<td>--%>
                        <%--<c:if test="${!empty tenantSource.imgUrl}">--%>
                            <%--<img src="http://pal.efeiyi.com/${tenantSource.imgUrl}@!pal-img-list"/>--%>
                        <%--</c:if>--%>
                    <%--</td>--%>
                <%--</tr>--%>
            <%--</c:forEach>--%>
        <%--</table>--%>
    <%--</div>--%>
<%--</c:if>--%>

<%--<c:if test="${!empty object.tenantCertificationList}">--%>
    <%--<div class="am-cf am-padding">--%>
        <%--<div class="am-fl am-cf">--%>
            <%--<strong class="am-text-primary am-text-lg">认证信息</strong>--%>
        <%--</div>--%>
    <%--</div>--%>
    <%--<div>--%>
        <%--<table class="am-table am-table-bordered am-table-radius am-table-striped">--%>
            <%--<tr style="text-align:left">--%>
                <%--<td>操作</td>--%>
                <%--<td>认证证书</td>--%>
                <%--<td>认证机构</td>--%>
                <%--<td>认证时间</td>--%>
                <%--<td>认证结果</td>--%>
                <%--<td>证书图片</td>--%>
            <%--</tr>--%>

            <%--<c:forEach items="${object.tenantCertificationList}" var="tenantCertification">--%>
                <%--<tr>--%>
                    <%--<td>--%>
                        <%--<div class="am-btn-toolbar">--%>
                            <%--<div class="am-btn-group am-btn-group-xs" style="width: 100%;" >--%>
                                <%--<button onclick="window.location.href='<c:url value="/basic/xm.do?qm=formTenantCertification&id=${tenantCertification.id}"/>'"--%>
                                        <%--class="am-btn am-btn-default am-btn-xs am-hide-sm-only">--%>
                                    <%--<span class="am-icon-edit"></span> 编辑--%>
                                <%--</button>--%>
                                <%--<button onclick="window.location.href='<c:url value="/tenantCertification/removeTenantCertification.do?tenantCertificationId=${tenantCertification.id}"/>'"--%>
                                        <%--class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only">--%>
                                    <%--<span class="am-icon-trash-o"></span> 删除--%>
                                <%--</button>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    <%--</td>--%>
                    <%--<td>${tenantCertification.name}</td>--%>
                    <%--<td>${tenantCertification.org}</td>--%>
                    <%--<td><fmt:formatDate value="${tenantCertification.theDate}" pattern="yyyy年MM月"/></td>--%>
                    <%--<td>--%>
                        <%--<ming800:status name="level" dataType="PCTenantCertification.level" checkedValue="${tenantCertification.level}" type="normal" />--%>
                    <%--</td>--%>
                    <%--<td>--%>
                        <%--<c:if test="${!empty tenantCertification.imgUrl}">--%>
                            <%--<img src="http://pal.efeiyi.com/${tenantCertification.imgUrl}@!pal-img-list"/>--%>
                        <%--</c:if>--%>
                    <%--</td>--%>
                <%--</tr>--%>
            <%--</c:forEach>--%>
        <%--</table>--%>
    <%--</div>--%>
<%--</c:if>--%>

</body>
</html>
