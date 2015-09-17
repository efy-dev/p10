<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/11
  Time: 15:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title></title>
</head>
<body>
<div style="text-align: left;margin-left: 10px;">
    <input onclick="window.history.back()"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 8px;margin-bottom: 6px;margin-left:2px;height: 35px;"
           value="返回" />
</div>
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">添加/编辑机构</strong>
    </div>
</div>
<hr/>

<div class="am-g">
    <form id="organizationForm" method="post" class="am-form am-form-horizontal">
        <div class="am-u-sm-9">
            <input type="hidden" name="theDatetime" id="theDatetime" value="${object.theDatetime}">
            <c:if test="${not empty object.id}">
                <input type="hidden" name="id" id="id" value="${object.id}">
            </c:if>
            <input type="hidden" name="status" id="status" value="${object.status}">
        </div>

        <div class="am-form-group">
            <label name="name" for="name" class="am-u-sm-3 am-form-label">name
                <small>*</small>
            </label>

            <div class="am-u-sm-9">
                <input type="text" name="name" id="name" placeholder="name" value="${object.name}" required="true">
            </div>
        </div>
        <div id="pcdDiv">
            <div class="am-form-group">
                <label name="province" for="province" class="am-u-sm-3 am-form-label">省份
                    <small>*</small>
                </label>

                <div class="am-u-sm-9">
                    <select name="province.id" id="province" title="省份" required="true"></select>
                </div>
            </div>
            <div class="am-form-group">
                <label name="city" for="city" class="am-u-sm-3 am-form-label">市
                    <small>*</small>
                </label>

                <div class="am-u-sm-9">
                    <select name="city.id" id="city" title="市" required="true"></select>
                </div>
            </div>
            <div class="am-form-group">
                <label name="addressDistrict" for="addressDistrict" class="am-u-sm-3 am-form-label">区/县
                    <small>*</small>
                </label>

                <div class="am-u-sm-9">
                    <select name="addressDistrict.id" id="addressDistrict" title="区县" required="true"></select>
                </div>
            </div>
        </div>

        <%--<div class="am-form-group">--%>
        <%--<label name="theDatetime" for="theDatetime" class="am-u-sm-3 am-form-label">时间 <small>*</small></label>--%>
        <%--<div class="am-input-group am-datepicker-date am-u-sm-9" data-am-datepicker="{format: 'yyyy-mm-dd'}">--%>
        <%--<input type="datetime" name="theDatetime" id="theDatetime" class="am-form-field" title="theDatetime" placeholder="date"--%>
        <%--value="" readonly required="true"/>--%>
        <%--<span class="am-input-group-btn am-datepicker-add-on">--%>
        <%--<button class="am-btn am-btn-default" type="button"><span class="am-icon-calendar"></span> </button>--%>
        <%--</span>--%>
        <%--</div>--%>
        <%--</div>--%>
        <div class="am-form-group">
            <label name="inCharge" for="inCharge" class="am-u-sm-3 am-form-label">inCharge
                <small>*</small>
            </label>

            <div class="am-u-sm-9">
                <input type="text" id="inCharge" placeholder="inCharge"
                       onclick="" name="inCharge"
                       value="${object.inCharge}" required="true">
            </div>
        </div>
        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="button"
                       onclick="testAjaxSubmitForm('organizationForm', '<c:url
                               value="/organization/saveOrganization.do"/>?qm=${requestScope.qm}');"
                       class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>
    </form>
</div>
<script src="<c:url value='http://libs.baidu.com/jquery/1.11.3/jquery.min.js'/>"></script>
<script src="<c:url value='/scripts/PCDSelect.js'/>"></script>
<script type="text/javascript">
    $(function () {
        $("#pcdDiv").pcdSelect(
                "<c:url value='/pal/address/provinceList.do'/>",
                "<c:url value='/pal/address/cityListByProvince.do?conditions=addressProvince.id:'/>",
                "<c:url value='/pal/address/districtListByCity.do?conditions=addressCity.id:'/>",
                "${object.addressDistrict.addressCity.addressProvince.id}",
                "${object.addressDistrict.addressCity.id}",
                "${object.addressDistrict.id}"
        )
    });
</script>
</body>
</html>

