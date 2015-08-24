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
    <script type="text/javascript">
        function showDiv(){
            var psf=document.getElementById("selectPS");
            psf.setAttribute("style","display");
        }
    </script>
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
    <input onclick="showDiv()"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;"
           value="选择商品系列"/>
    <input onclick="window.location.href='<c:url value="/tenantCertification/newTenantCertification.do?tenantId=${object.id}"/>'"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;"
           value="新建认证信息" />
</div>

<div class="am-g" id="selectPS" style="display:none">
    <form action="<c:url value='/tenant/saveTenantProductSeries.do'/>" method="post" class="am-form am-form-horizontal">
        <input type="hidden" name="tenant.id" value="${object.id}">

        <div class="am-form-group">
            <label name="productSeries_id" for="productSeries_idName" class="am-u-sm-3 am-form-label">商品系列 <small style="color: red">*</small></label>
            <div class="am-u-sm-9">
                <input id="productSeries_idName" placeholder="商品系列" onclick="m8uDialog.openDialog('productSeries_id','productSeries_idName','productSeries', null)" required>
                <input type="hidden" id="productSeries_id"  name="productSeries.id">
            </div>
        </div>

        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="submit" class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>
    </form>
</div>

<c:if test="${not empty object.tenantProductSeriesList}">
    <div class="am-cf am-padding">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">商户系列</strong>
        </div>
    </div>
    <div>
        <table class="am-table am-table-bordered am-table-radius am-table-striped">
            <tr>
                <td>操作</td>
                <td>系列名称</td>
                <td>序列号</td>
            </tr>

            <c:forEach items="${object.tenantProductSeriesList}" var="tenantProductSeries">
                <tr style="text-align: left">
                    <td>
                        <div class="am-btn-toolbar">
                            <div class="am-btn-group am-btn-group-xs" style="width: 100%;" >
                                <button onclick="window.location.href='<c:url value="/tenant/delTenantProductSeries.do?tenantId=${object.id}&tenantProductSeriesId=${tenantProductSeries.id}"/>'"
                                        class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 删除</button>
                            </div>
                        </div>
                    </td>
                    <td><a href="<c:url value="/basic/xm.do?qm=viewProductSeries&id=${tenantProductSeries.productSeries.id}"/>">${tenantProductSeries.productSeries.name}</a></td>
                    <td>${tenantProductSeries.productSeries.serial}</td>
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

<c:if test="${!empty object.tenantCertificationList}">
    <div class="am-cf am-padding">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">认证信息</strong>
        </div>
    </div>
    <div>
        <table class="am-table am-table-bordered am-table-radius am-table-striped">
            <tr style="text-align:left">
                <td>操作</td>
                <td>认证证书</td>
                <td>认证机构</td>
                <td>认证时间</td>
                <td>认证结果</td>
                <td>证书图片</td>
            </tr>

            <c:forEach items="${object.tenantCertificationList}" var="tenantCertification">
                <tr>
                    <td>
                        <div class="am-btn-toolbar">
                            <div class="am-btn-group am-btn-group-xs" style="width: 100%;" >
                                <button onclick="window.location.href='<c:url value="/basic/xm.do?qm=formTenantCertification&id=${tenantCertification.id}"/>'"
                                        class="am-btn am-btn-default am-btn-xs am-hide-sm-only">
                                    <span class="am-icon-edit"></span> 编辑
                                </button>
                                <button onclick="window.location.href='<c:url value="/tenantCertification/removeTenantCertification.do?tenantCertificationId=${tenantCertification.id}"/>'"
                                        class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only">
                                    <span class="am-icon-trash-o"></span> 删除
                                </button>
                            </div>
                        </div>
                    </td>
                    <td>${tenantCertification.name}</td>
                    <td>${tenantCertification.org}</td>
                    <td><fmt:formatDate value="${tenantCertification.theDate}" pattern="yyyy年MM月"/></td>
                    <td>
                        <ming800:status name="level" dataType="PCTenantCertification.level" checkedValue="${tenantCertification.level}" type="normal" />
                    </td>
                    <td>
                        <c:forEach items="${tenantCertification.imgList}" var="tenantCertificationImg">
                            <c:if test="${not empty tenantCertificationImg.imgUrl}">
                                <img src="http://pal.efeiyi.com/${tenantCertificationImg.imgUrl}@!pal-img-list"/>
                            </c:if>
                        </c:forEach>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</c:if>

</body>
</html>
