<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/12/10
  Time: 17:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title>虚拟订单计划信息</title>
    <script src="<c:url value='/DatePicker/WdatePicker.js'/>"></script>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">虚拟订单计划信息</strong>
    </div>
</div>
<hr/>
<div class="am-g">
    <form action="<c:url value=''/>"
          method="post" enctype="multipart/form-data" class="am-form am-form-horizontal">
        <input type="hidden" name="id" value="${object.id}">
        <input type="hidden" name="status" value="${object.status}"/>
        <input type="hidden" name="implementClass" value="${object.implementClass}"/>
        <input type="hidden" name="createDatetime" value="${object.createDatetime}"/>

        <div class="am-form-group">
            <label for="serial" class="am-u-sm-3 am-form-label">虚拟计划编号<small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="serial" id="serial" title="虚拟计划编号"
                       value="${object.serial}" required="true" readonly>
            </div>
        </div>

        <div class="am-form-group">
            <label for="description" class="am-u-sm-3 am-form-label">虚拟数据批次名<small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="description" id="description"
                       title="虚拟数据批次名" placeholder="虚拟数据批次名"
                       value="${object.description}" required="true" readonly>
            </div>
        </div>

        <div class="am-form-group">
            <label for="planType" class="am-u-sm-3 am-form-label">虚拟数据对象<small>*</small></label>
            <div class="am-u-sm-9" style="margin-top: 8px">
                <input type="text" value="<ming800:status name="planTypeSelect" dataType="PCVirtualPlan.planType" checkedValue="${object.planType}" type="normal"/>" readonly>
                <input type="hidden" name="planType" id="planType" title="虚拟数据对象" required="true" value="${object.planType}" readonly>
            </div>
        </div>

        <div class="am-form-group">
            <label class="am-u-sm-3 am-form-label">任务截止日期<small>*</small></label>
            <div class="am-u-sm-9">

                <input type="text" style="width: auto; float: left; height: 35px"
                       name="startDate" id="startDate" title="开始日期"
                       value="${object.startDate}" required="true" readonly>

                <span style="width: auto; float: left; font-family:'应用字体 Regular', '应用字体'; margin-left: 10px; margin-top: 4px">至</span>

                <input type="text" style="width: auto; float: left; margin-left: 10px; height: 35px"
                       name="endDate" id="endDate" title="结束日期"
                       value="${object.endDate}" required="true" readonly>
            </div>
        </div>

        <div class="am-form-group">
            <label class="am-u-sm-3 am-form-label">任务运行时间<small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" style="width: auto; float: left; height: 35px"
                       name="startTime" id="startTime" title="开始时间"
                       value="${object.startTime}" required="true" readonly>

                <span style="width: auto; float: left; font-family:'应用字体 Regular', '应用字体'; margin-left: 10px; margin-top: 4px">至</span>

                <input type="text" style="width: auto; float: left; margin-left: 10px; height: 35px"
                       name="endTime" id="endTime" title="结束时间"
                       value="${object.endTime}" required="true" readonly>
            </div>
        </div>
        <hr/>
        <div class="am-form-group">
            <label class="am-u-sm-3 am-form-label">订单数量区间<small>*</small></label>
            <div class="am-u-sm-9">
                <input type="number" style="width: 210px; float: left; height: 35px; margin-top: 4px"
                       name="orderAmountFloor" id="orderAmountFloor" title="订单数量下限" placeholder="订单数量下限"
                       value="${object.orderAmountFloor}" required="true">

                <span style="width: auto; float: left; font-family:'应用字体 Regular', '应用字体'; margin-left: 10px; margin-top: 8px">至</span>

                <input type="number" style="width: 210px; float: left; margin-left: 10px; height: 35px; margin-top: 4px"
                       name="orderAmountCeil" id="orderAmountCeil" title="订单数量上限" placeholder="订单数量上限"
                       value="${object.orderAmountCeil}" required="true">
            </div>
        </div>

        <div class="am-form-group">
            <label class="am-u-sm-3 am-form-label">均值小时<small>*</small></label>
            <div class="am-u-sm-9">
                <input class="Wdate" onClick="WdatePicker({dateFmt:'HH:mm:ss'})"
                       type="text" style="width: auto; float: left; height: 35px; margin-top: 4px"
                       name="peakTime" id="peakTime" title="均值小时"
                       placeholder="均值小时" value="${object.peakTime}" required="true">
            </div>
        </div>

        <div class="am-form-group">
            <label class="am-u-sm-3 am-form-label">标准差小时<small>*</small></label>
            <div class="am-u-sm-9">
                <input type="number" style="width: 210px; float: left; height: 35px; margin-top: 4px"
                       name="standardDeviation" id="standardDeviation" title="标准差小时" placeholder="标准差小时"
                       value="${object.standardDeviation}" required="true">
            </div>
        </div>

        <div class="am-form-group">
            <label class="am-u-sm-3 am-form-label">选择商品<small>*</small></label>
        </div>

        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="submit" class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>

    </form>
</div>
<script>
    function startLessThanEnd(val){
        if(afterSubmitForm(val) && amountCheck() /*&& timeCheck()*/){
            return true;
        }
        return false;
    }
    function amountCheck(){
        var oaf = $("#orderAmountFloor").val();
        var oac = $("#orderAmountCeil").val();
        if(oac<=oaf){
            alert("订单数量下限应小于数量上限");
            return false;
        }
        return true;
    }
    function timeCheck(){
        var st = $("#startTime").val();
        var et = $("#endTime").val();
        if(et<=st){
            alert("任务运行开始时间应该小于结束时间");
            return false;
        }
        return true;
    }
</script>
</body>
</html>
