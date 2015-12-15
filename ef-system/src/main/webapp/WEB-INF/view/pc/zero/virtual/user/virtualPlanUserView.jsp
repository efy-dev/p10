<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/22
  Time: 16:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title>虚拟用户计划信息</title>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">虚拟用户计划信息</strong>
    </div>
</div>
<div class="am-g">
    <form action="<c:url value='/virtualPlan/saveVirtualUser.do'/>"
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
                <input type="text" name="description" id="description" title="虚拟数据批次名"
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

        <div class="am-form-group">
            <label for="count" class="am-u-sm-3 am-form-label">虚拟用户数量<small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="count" id="count" title="虚拟用户数量"
                       value="${object.count}" required="true">
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
