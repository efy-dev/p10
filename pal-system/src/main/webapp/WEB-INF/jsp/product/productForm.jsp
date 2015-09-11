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
<%@include file="/layouts/public.jsp" %>
<html>
<head>
    <title></title>
    <script type="text/javascript">
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
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">商品信息</strong>
    </div>
</div>
<hr/>
<div class="am-g">
    <form id="productForm" action="<c:url value='/product/saveProduct.do'/>" onsubmit="return afterSubmitForm('productForm')"
          method="post" enctype="multipart/form-data" class="am-form am-form-horizontal">
        <input type="hidden" name="id" value="${object.id}">
        <input type="hidden" name="status" value="${object.status}" />
        <div class="am-form-group">
            <label name="name" for="name" class="am-u-sm-3 am-form-label">商品名称 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="name" id="name" title="商品名称" placeholder="商品名称" value="${object.name}" required="true">
            </div>
        </div>
        <div class="am-form-group">
            <label name="masterName" for="masterName" class="am-u-sm-3 am-form-label">制作大师 <small>&nbsp;&nbsp;</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="masterName" id="masterName" placeholder="制作大师" value="${object.masterName}">
            </div>
        </div>
        <div class="am-form-group">
            <label name="productSeries_id" for="productSeries_idName" class="am-u-sm-3 am-form-label">非遗项目 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" id="productSeries_idName" title="非遗项目" placeholder="非遗项目"
                       onclick="openTenantProductSeries(true, 'productSeries_id', 'productSeries_idName')"
                       value="${object.productSeries.name}" required="true" readonly>
                <input type="hidden" id="productSeries_id"  name="productSeries.id" value="${object.productSeries.id}">
            </div>
        </div>
        <div class="am-form-group">
            <label name="tenant_id" for="tenant_idName" class="am-u-sm-3 am-form-label">商户名称 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" id="tenant_idName" title="商户名称" placeholder="商户名称"
                       onclick="openTenantProductSeries(false, 'tenant_id', 'tenant_idName')"
                       value="${object.tenant.name}" required="true" readonly>
                <input type="hidden" id="tenant_id"  name="tenant.id" value="${object.tenant.id}">
            </div>
        </div>
        <div class="am-form-group">
            <label name="madeYear" for="madeYear" class="am-u-sm-3 am-form-label">制作时间 <small>*</small></label>
            <%--<div class="am-input-group am-datepicker-date am-u-sm-9" data-am-datepicker="{format: 'yyyy-mm-dd'}">--%>
                <%--<input type="datetime" name="madeYear" id="madeYear" class="am-form-field" title="制作时间" placeholder="制作时间"--%>
                       <%--value="<fmt:formatDate value='${object.madeYear}'  pattern='yyyy-MM-dd'/>" readonly required="true"/>--%>
                <%--<span class="am-input-group-btn am-datepicker-add-on">--%>
                    <%--<button class="am-btn am-btn-default" type="button"><span class="am-icon-calendar"></span> </button>--%>
                <%--</span>--%>
            <%--</div>--%>
            <div class="am-u-sm-9">
                <input type="text" name="madeYear" id="madeYear" class="am-form-field"
                       title="制作时间" placeholder="制作时间"
                       value="<fmt:formatDate value='${object.madeYear}'  pattern='yyyy-MM-dd'/>"
                       data-am-datepicker readonly required="true"/>
            </div>
        </div>
        <div class="am-form-group">
            <label name="shoppingUrl" for="shoppingUrl" class="am-u-sm-3 am-form-label">购买链接 <small>&nbsp;&nbsp;</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="shoppingUrl" id="shoppingUrl" placeholder="购买链接" value="${object.shoppingUrl}">
            </div>
        </div>
        <div class="am-form-group">
            <label for="logo" class="am-u-sm-3 am-form-label">商品Logo <small>&nbsp;&nbsp;</small></label>
            <div class="am-u-sm-9">
                <input type="file" id="logo" name="logo" placeholder="商品LogoLogo"
                       value="${object.logo}">
            </div>
        </div>
        <div class="am-form-group">
            <label class="am-u-sm-3 am-form-label"><small></small></label>
            <div class="am-u-sm-9">
                <c:if test="${!empty object.logo}">
                    <img src="<%=imgBasePath %>${object.logo}<%=imgFormCSS %>">
                </c:if>
            </div>
        </div>
        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="submit" class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>
    </form>
</div>
</body>
</html>
