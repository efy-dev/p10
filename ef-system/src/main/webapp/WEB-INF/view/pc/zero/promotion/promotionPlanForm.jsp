<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/12/04
  Time: 10:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title>返利链接</title>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">返利链接</strong>
    </div>
</div>
<hr/>
<div class="am-g">
    <form id="pPlanForm" onsubmit="return afterSubmitForm('pPlanForm')"
          action="<c:url value='/basic/xm.do?qm=saveOrUpdatePromotionPlan'/>"
          method="post" enctype="multipart/form-data" class="am-form am-form-horizontal">
        <input type="hidden" name="id" value="${object.id}">
        <input type="hidden" name="status" value="${object.status}"/>

        <div class="am-form-group">
            <label for="urlDescription" class="am-u-sm-3 am-form-label">链接名称<small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="urlDescription" id="urlDescription" style="width: auto"
                       title="链接名称" placeholder="链接名称"
                       value="${object.urlDescription}" required="true">
            </div>
        </div>

        <div class="am-form-group">
            <label for="url" class="am-u-sm-3 am-form-label">链接地址<small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="url" id="url" style="width: auto"
                       title="链接地址" placeholder="链接地址"
                       value="${object.url}" required="true">
            </div>
        </div>

        <div class="am-form-group">
            <label for="name" class="am-u-sm-3 am-form-label">分享渠道<small>*</small></label>
            <div class="am-u-sm-9" style="width: 240px;float: left">
                <ming800:status name="nameSelect" dataType="PCPromotionPlan.name"
                                checkedValue="${object.name}" onclick="javascript:nameChange(this)" required="required" type="select"/>
                <input type="hidden" name="name" id="name" title="分享渠道" required="true" value="${object.name}">
            </div>
        </div>

        <div class="am-form-group">
            <label for="rdDays" class="am-u-sm-3 am-form-label">广告认定效果期(RD)<small>*</small></label>
            <div class="am-u-sm-9">
                <input type="number" name="rdDays" id="rdDays" style="width: 210px; float: left"
                       title="广告认定效果期" placeholder="广告认定效果期" min="1" max="366"
                       value="${object.rdDays}" required="true"><span style="margin-left: 4px;margin-top: 3px;float: left">天</span>
            </div>
        </div>

        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="submit" class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>

    </form>
</div>
<script>
    function nameChange(obj){
        var val = obj.value;
        if (val != null && val != ""){
            $("#name").val(val);
        }else{
            $("#name").val(null);
        }
    }
</script>
</body>
</html>
