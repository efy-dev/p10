<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/23
  Time: 14:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@include file="/layouts/public.jsp" %>
<html>
<head>
    <title></title>
    <script type="text/javascript">
        function openProductSourceOrCertification(id, name, type) {
            var tenantId = document.getElementById("tenant.id").value;
            if (tenantId == null || tenantId == "") {
                alert("请确定商户是否存在!");
            } else {
                m8uDialog.openDialog(id, name, type, tenantId, '<%=path%>');
            }
        }
    </script>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">非遗项目溯源信息</strong>
    </div>
</div>
<hr/>
<div class="am-g">
    <form action="<c:url value='/TenantProductSeries/saveTenantProductSeries.do'/>" method="post" class="am-form am-form-horizontal">
        <input type="hidden" name="id" value="${object.id}">
        <input type="hidden" name="status" value="${object.status}"/>
        <div class="am-form-group">
            <label name="productSeriesName" for="productSeriesName" class="am-u-sm-3 am-form-label">非遗项目名称<small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="productSeriesName" id="productSeriesName" placeholder="非遗项目名称"
                       value="${object.productSeries.name}" required readonly>
                <input type="hidden" name="productSeries.id" value="${object.productSeries.id}">
            </div>
        </div>
        <div class="am-form-group">
            <label name="tenantName" for="tenantName" class="am-u-sm-3 am-form-label">商户名称<small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="tenantName" id="tenantName" placeholder="商户名称"
                       value="${object.tenant.name}" required readonly>
                <input type="hidden" id="tenant.id" name="tenant.id" value="${object.tenant.id}">
            </div>
        </div>
        <div class="am-form-group">
            <label name="craft" for="craft" class="am-u-sm-3 am-form-label">制作工艺<small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="craft" id="craft" placeholder="制作工艺" value="${object.craft}" required>
            </div>
        </div>
        <div class="am-form-group">
            <label name="region" for="region" class="am-u-sm-3 am-form-label">创作地域<small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="region" id="region" placeholder="创作地域" value="${object.region}" required>
            </div>
        </div>
        <c:if test="${(object.tenant.tenantCertificationList) != null && fn:length(object.tenant.tenantCertificationList) == 1}">
            <c:forEach items="${object.tenant.tenantCertificationList}" var="tcf" begin="0" end="0">
                <div class="am-form-group">
                    <label class="am-u-sm-3 am-form-label">认证信息<small>*</small></label>
                    <div class="am-u-sm-9">
                        <input type="text" placeholder="认证信息" value="${tcf.name}" required readonly>
                        <input type="hidden" name="tenantCertification.id" value="${tcf.id}">
                    </div>
                </div>
            </c:forEach>
        </c:if>
        <c:if test="${(object.tenant.tenantCertificationList) != null && fn:length(object.tenant.tenantCertificationList) != 1}">
            <div class="am-form-group">
                <label name="tenantCertification_id" for="tenantCertification_idName" class="am-u-sm-3 am-form-label">认证信息<small>*</small></label>
                <div class="am-u-sm-9">
                    <input type="text" id="tenantCertification_idName" placeholder="认证信息"
                           onclick="openProductSourceOrCertification('tenantCertification_id','tenantCertification_idName','certification');"
                           value="${object.tenantCertification.name}" required>
                    <input type="hidden" id="tenantCertification_id" name="tenantCertification.id"
                           value="${object.tenantCertification.id}">
                </div>
            </div>
        </c:if>
        <%--<c:if test="${empty object.tenant.tenantCertificationList}">--%>
                <%--<div class="am-form-group">--%>
                    <%--<label class="am-u-sm-3 am-form-label">认证信息<small>*</small></label>--%>
                    <%--<div class="am-u-sm-9">--%>
                        <%--<input type="text" placeholder="该商户无认证信息,请添加认证信息后继续操作" value="" required readonly>--%>
                        <%--<input type="hidden" name="tenantCertification.id" value="">--%>
                    <%--</div>--%>
                <%--</div>--%>
        <%--</c:if>--%>
        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="submit" class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>
    </form>
</div>
</body>
</html>
