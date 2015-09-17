<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title></title>
    <script src="<c:url value='/scripts/PCDSelect.js'/>"></script>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">商户信息</strong>
    </div>
</div>
<hr/>
<div class="am-g">
    <form id="tenantForm" method="post" class="am-form am-form-horizontal">
    <%--<form action="<c:url value='/tenant/saveTenant.do'/>" method="post" class="am-form am-form-horizontal">--%>
        <input type="hidden" name="qm" value="saveOrUpdateTenant">
        <input type="hidden" name="id" value="${object.id}">
        <input type="hidden" name="status" value="${object.status}" />
        <div class="am-form-group">
            <label name="name" for="name" class="am-u-sm-3 am-form-label">商户名称 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="name" id="name" placeholder="商户名称" value="${object.name}" title="商户名称" required="true">
            </div>
        </div>
        <div id="pcdDiv">
        <div class="am-form-group">
            <label name="province" for="province" class="am-u-sm-3 am-form-label">省份 <small>*</small></label>
            <div class="am-u-sm-9">
                <select name="province.id" id="province" title="省份" required="true"></select>
            </div>
        </div>
        <div class="am-form-group">
            <label name="city" for="city" class="am-u-sm-3 am-form-label">市 <small>*</small></label>
            <div class="am-u-sm-9">
                <select name="city.id" id="city" title="市" required="true"></select>
            </div>
        </div>
        <div class="am-form-group">
            <label name="district" for="district" class="am-u-sm-3 am-form-label">区/县 <small>*</small></label>
            <div class="am-u-sm-9">
                <select name="district.id" id="district" title="区县" required="true"></select>
            </div>
        </div>
        </div>
        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="button" onclick="testAjaxSubmitForm('tenantForm', '<c:url value="/tenant/saveTenantAjax.do"/>');" class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>
        <%--<div class="am-form-group">--%>
            <%--<div class="am-u-sm-9 am-u-sm-push-3">--%>
                <%--<input type="submit" class="am-btn am-btn-primary" value="保存"/>--%>
            <%--</div>--%>
        <%--</div>--%>
    </form>
    <script type="text/javascript">
        $(function(){
            $("#pcdDiv").pcdSelect(
                "<c:url value='/pal/address/provinceList.do'/>",
                "<c:url value='/pal/address/cityListByProvince.do?conditions=addressProvince.id:'/>",
                "<c:url value='/pal/address/districtListByCity.do?conditions=addressCity.id:'/>",
                "${object.province.id}",
                "${object.city.id}",
                "${object.district.id}"
            )
        });
    </script>
</div>
</body>
</html>
