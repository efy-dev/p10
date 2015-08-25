<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@include file="/layouts/public.jsp" %>

<html>
<head>
    <title></title>
    <script type="text/javascript">
        function openProductSourceOrCertification(id, name, type){
            var tenantId = document.getElementById("tenant_id").value;
            if(tenantId == null || tenantId == ""){
                alert("请选择商户!");
            }else {
                m8uDialog.openDialog(id, name, type, tenantId,'<%=path%>');
            }
        }

        function openTenantProductSeries(tag, id, name){
            if(tag){//选择系列
                var tenantId = document.getElementById("tenant_id").value;
                if(tenantId == null || tenantId == ""){
                    m8uDialog.openDialog(id, name, "seriesByTenantNull", null,'<%=path%>');
                }else {
                    m8uDialog.openDialog(id, name, "seriesByTenant", tenantId,'<%=path%>');
                }
            }else {//选择商户
                var productSeriesId = document.getElementById("productSeries_id").value;
                if(productSeriesId == null || productSeriesId == ""){
                    m8uDialog.openDialog(id, name, "TenantBySeriesNull", null,'<%=path%>');
                }else {
                    m8uDialog.openDialog(id, name, "TenantBySeries", productSeriesId,'<%=path%>');
                }
            }

        }
    </script>
</head>
<body>
<div class="am-cf am-padding">
    <c:if test="${empty object || object.id == null || object.id==''}">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">新建商品</strong> / <small>New Product</small>
        </div>
    </c:if>
    <c:if test="${!empty object && object.id != null && object.id != '' }">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">编辑商品信息</strong> / <small>Edit Product</small>
        </div>
    </c:if>
</div>
<hr/>

<div class="am-g">
    <form action="<c:url value='/product/saveProductAndNext.do'/>" method="post" enctype="multipart/form-data" class="am-form am-form-horizontal">
        <input type="hidden" name="qm" value="saveOrUpdateProduct">
        <input type="hidden" name="id" value="${object.id}">
        <c:if test="${empty object || object.id == null || object.id==''}">
            <input type="hidden" name="status" value="1" />
        </c:if>
        <c:if test="${!empty object && object.id != null && object.id != '' }">
            <input type="hidden" name="status" value="${object.status}" />
        </c:if>

        <div class="am-form-group">
            <label name="name" for="name" class="am-u-sm-3 am-form-label">商品名称 <small style="color: red">*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="name" id="name" placeholder="商品名称" value="${object.name}" required>
            </div>
        </div>
        <div class="am-form-group">
            <label name="masterName" for="masterName" class="am-u-sm-3 am-form-label">制作大师 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="masterName" id="masterName" placeholder="制作大师" value="${object.masterName}">
            </div>
        </div>

        <%--<div class="am-form-group">--%>
            <%--<label name="serial" for="serial" class="am-u-sm-3 am-form-label">序列号 <small style="color: red">*</small></label>--%>
            <%--<div class="am-u-sm-9">--%>
                <%--<input type="text" name="serial" id="serial" placeholder="序列号" value="${object.serial}" required>--%>
            <%--</div>--%>
        <%--</div>--%>

        <div class="am-form-group">
            <label name="productSeries_id" for="productSeries_idName" class="am-u-sm-3 am-form-label">所属系列 <small style="color: red">*</small></label>
            <div class="am-u-sm-9">
                <input id="productSeries_idName" placeholder="所属系列"
                       onclick="openTenantProductSeries(true, 'productSeries_id', 'productSeries_idName')"
                       value="${object.productSeries.name}" required>
                <input type="hidden" id="productSeries_id"  name="productSeries.id" value="${object.productSeries.id}">
            </div>
        </div>

        <div class="am-form-group">
            <label name="tenant_id" for="tenant_idName" class="am-u-sm-3 am-form-label">商户名称 <small style="color: red">*</small></label>
            <div class="am-u-sm-9">
                <input id="tenant_idName" placeholder="商户名称"
                       onclick="openTenantProductSeries(false, 'tenant_id', 'tenant_idName')"
                       value="${object.tenant.name}" required>
                <input type="hidden" id="tenant_id"  name="tenant.id" value="${object.tenant.id}">
            </div>
        </div>

        <%--<div class="am-form-group">--%>
            <%--<label name="productSeries_id" for="productSeries_idName" class="am-u-sm-3 am-form-label">所属系列 <small style="color: red">*</small></label>--%>
            <%--<div class="am-u-sm-9">--%>
                <%--<input id="productSeries_idName" placeholder="所属系列" onclick="m8uDialog.openDialog('productSeries_id','productSeries_idName','productSeries', null)" value="${object.productSeries.name}" required>--%>
                <%--<input type="hidden" id="productSeries_id"  name="productSeries.id" value="${object.productSeries.id}">--%>
            <%--</div>--%>
        <%--</div>--%>

        <%--<div class="am-form-group">--%>
            <%--<label name="tenant_id" for="tenant_idName" class="am-u-sm-3 am-form-label">商户名称 <small style="color: red">*</small></label>--%>
            <%--<div class="am-u-sm-9">--%>
                <%--<input id="tenant_idName" placeholder="商户名称" onclick="m8uDialog.openDialog('tenant_id','tenant_idName','tenant', null)" value="${object.tenant.name}" required>--%>
                <%--<input type="hidden" id="tenant_id"  name="tenant.id" value="${object.tenant.id}">--%>
            <%--</div>--%>
        <%--</div>--%>

        <div class="am-form-group">
            <label name="madeYear" for="madeYear" class="am-u-sm-3 am-form-label">制作时间 <small style="color: red">*</small></label>
            <div class="am-input-group am-datepicker-date am-u-sm-9" data-am-datepicker="{format: 'yyyy-mm-dd'}">
                <input type="text" name="madeYear" id="madeYear" class="am-form-field" placeholder="制作时间" value="<fmt:formatDate value='${object.madeYear}'  pattern='yyyy-MM-dd'/>" readonly required/>
                <span class="am-input-group-btn am-datepicker-add-on">
                    <button class="am-btn am-btn-default" type="button"><span class="am-icon-calendar"></span> </button>
                </span>
            </div>
        </div>

        <%--<div class="am-form-group">--%>
            <%--<label name="productSource_id" for="productSource_idName" class="am-u-sm-3 am-form-label">溯源信息 <small style="color: red">*</small></label>--%>
            <%--<div class="am-u-sm-9">--%>
                <%--<input id="productSource_idName" placeholder="溯源信息"--%>
                       <%--onclick="openProductSourceOrCertification('productSource_id','productSource_idName','source');"--%>
                       <%--value="${object.tenantSource.name}" required>--%>
                <%--<input type="hidden" id="productSource_id"  name="tenantSource.id" value="${object.tenantSource.id}">--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="am-form-group">--%>
            <%--<label name="productCertification_id" for="productCertification_idName" class="am-u-sm-3 am-form-label">认证信息 <small style="color: red">*</small></label>--%>
            <%--<div class="am-u-sm-9">--%>
                <%--<input id="productCertification_idName" placeholder="认证信息"--%>
                       <%--onclick="openProductSourceOrCertification('productCertification_id','productCertification_idName','certification');"--%>
                       <%--value="${object.tenantCertification.name}" required>--%>
                <%--<input type="hidden" id="productCertification_id"  name="tenantCertification.id" value="${object.tenantCertification.id}">--%>
            <%--</div>--%>
        <%--</div>--%>

        <div class="am-form-group">
            <label name="shoppingUrl" for="shoppingUrl" class="am-u-sm-3 am-form-label">购买链接 <small <%--style="color: red"--%>>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="shoppingUrl" id="shoppingUrl" placeholder="购买链接" value="${object.shoppingUrl}" <%--required--%>>
            </div>
        </div>

        <div class="am-form-group">
            <label for="logo" class="am-u-sm-3 am-form-label">商品Logo <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="file" id="logo" name="logo" placeholder="商品LogoLogo"
                       value="${object.logo}">
            </div>
            <c:if test="${!empty object.logo}">
                <img src="http://pal.efeiyi.com/${object.logo}@!pal-img-form">
                <%--<figure data-am-widget="figure" class="am am-figure am-figure-default "--%>
                        <%--data-am-figure="{  pureview: 'true' }">--%>
                    <%--<img src="http://pal.efeiyi.com/${object.imgUrl}@!pal-img-form"--%>
                         <%--data-rel="http://pal.efeiyi.com/${object.imgUrl}" alt="商品Logo"/>--%>
                    <%--<figcaption class="am-figure-capition-btm">商品Logo</figcaption>--%>
                <%--</figure>--%>
            </c:if>
        </div>

        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="submit" class="am-btn am-btn-primary" value="下一页"/>
            </div>
        </div>
    </form>
</div>

</body>
</html>
