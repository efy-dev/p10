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
</head>
<body>

<div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">新建/编辑项目标签</strong> / <small>New/Edit ProjectTag</small></div>
</div>
<hr/>

<div class="am-g">
    <form action="<c:url value="/basic/xm.do"/>"  class="am-form am-form-horizontal">
        <input type="hidden" name="qm" value="saveOrUpdateProjectTag">
        <input type="hidden" name="id" value="${object.id}">
        <input type="hidden" name="project.id" value="${projectId}">
        <input type="hidden" name="sort" value="${object.sort}">
        <input type="hidden" name="status" value="1">
        <div class="am-form-group">
            <label name="value" for="value" class="am-u-sm-3 am-form-label">标签名称</label>
            <div class="am-u-sm-9">
                <input type="text" name="value" id="value" placeholder="标签名称" value="${object.value}">
                <small>必填项*</small>
            </div>
        </div>

        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="submit" class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>
    </form>
</div>
<!-- content end -->
<hr/>
</body>
</html>
