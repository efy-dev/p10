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
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title></title>
    <script type="text/javascript">
        function formSubmit(){
            var theDate = document.getElementById("theDate").value;
            var PLevel = document.getElementById("PLevel");
            var level = PLevel.firstElementChild.value;
            if(theDate == null || theDate == ""){
                alert("请选择时间");
                return false;
            } else if(level == null || level == ""){
                alert("请选择认证结果");
                return false;
            } else {
                return true;
            }
        }
    </script>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">认证信息</strong>
    </div>
</div>
<hr/>
<div class="am-g">
    <form id="certificationForm" action="<c:url value='/tenantCertification/saveTenantCertification.do'/>"
          onsubmit="return formSubmit()" method="post" enctype="multipart/form-data" class="am-form am-form-horizontal">
        <input type="hidden" name="id" value="${object.id}">
        <input type="hidden" name="status" value="${object.status}" />
        <div class="am-form-group">
            <label name="tenant.idName" for="tenant.idName" class="am-u-sm-3 am-form-label">商户名称 <small>*</small></label>
            <div class="am-u-sm-9">
                <c:if test="${empty object || object.id == null || object.id==''}">
                    <input type="text" name="tenant.idName" id="tenant.idName" placeholder="商户名称" value="${tenant.name}" readonly>
                    <input type="hidden" name="tenant.id" value="${tenant.id}" readonly>
                </c:if>
                <c:if test="${!empty object && object.id != null && object.id != '' }">
                    <input type="text" name="tenant.idName" id="tenant.idName" placeholder="商户名称" value="${object.tenant.name}" readonly>
                    <input type="hidden" name="tenant.id" value="${object.tenant.id}" readonly>
                </c:if>
            </div>
        </div>
        <div class="am-form-group">
            <label name="name" for="name" class="am-u-sm-3 am-form-label">认证证书 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="name" id="name" placeholder="认证证书" value="${object.name}" required>
            </div>
        </div>
        <div class="am-form-group">
            <label name="org" for="org" class="am-u-sm-3 am-form-label">认证机构 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="org" id="org" placeholder="认证机构" value="${object.org}" required>
            </div>
        </div>
        <div class="am-form-group">
            <label name="theDate" for="theDate" class="am-u-sm-3 am-form-label">认证时间 <small>*</small></label>
            <%--<div class="am-input-group am-datepicker-date am-u-sm-9" data-am-datepicker="{format: 'yyyy-mm', viewMode: 'years', minViewMode: 'months'}">--%>
                <%--<input type="text" name="theDate" id="theDate" class="am-form-field" placeholder="认证时间"--%>
                       <%--value="<fmt:formatDate value='${object.theDate}'  pattern='yyyy-MM'/>" required readonly/>--%>
                <%--<span class="am-input-group-btn am-datepicker-add-on">--%>
                    <%--<button class="am-btn am-btn-default" type="button"><span class="am-icon-calendar"></span></button>--%>
                <%--</span>--%>
            <%--</div>--%>
            <div class="am-u-sm-9">
                <input type="text" name="theDate" id="theDate" class="am-form-field"
                       data-am-datepicker="{format: 'yyyy-mm', viewMode: 'years', minViewMode: 'months'}"
                       value="<fmt:formatDate value='${object.theDate}'  pattern='yyyy-MM'/>"
                       placeholder="日历组件" data-am-datepicker readonly/>
            </div>
        </div>
        <div class="am-form-group">
            <label for="level" class="am-u-sm-3 am-form-label">认证结果 <small>*</small></label>
            <div class="am-u-sm-9" id="PLevel">
                <ming800:status name="level" dataType="PCTenantCertification.level" checkedValue="${object.level}" type="select"/>
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
