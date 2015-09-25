<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/22
  Time: 11:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
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
           value="返回"/>
</div>
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">添加/编辑
            <ming800:status name="group" dataType="document.group" checkedValue='${group}' type="normal"/>
        </strong>
    </div>
</div>
<hr/>
<div class="am-g">
    <form id="memManagementForm" action="<c:url value='/myMember/saveMemManagementForm.do'/>?qm=${requestScope.qm}"
          onsubmit="return afterSubmitForm('memManagementForm')"
          method="post" enctype="multipart/form-data" class="am-form am-form-horizontal">
        <input value="${object.id}" name="id" type="hidden"/>
        <input value="${object.status}" name="status" type="hidden"/>
        <input value="${object.documentOrder}" name="documentOrder" type="hidden"/>
        <input value="${object.documentContent.id}" name="documentContent.id" type="hidden"/>
        <input value="${group}" name="group" type="hidden">

        <div class="am-form-group">
            <label name="会员名称" for="name" class="am-u-sm-3 am-form-label">会员名称<small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="name" id="name" placeholder="会员名称" value="${object.name}" required="true">
            </div>
        </div>
        <div class="am-form-group">
            <label name="会员类别" for="title" class="am-u-sm-3 am-form-label">会员类别<small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="title" id="title" placeholder="会员类别" value="${object.title}" required="true">
            </div>
        </div>
        <div class="am-form-group">
            <label name="成立时间" for="publishDate" class="am-u-sm-3 am-form-label">成立时间 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="datetime" name="publishDate" id="publishDate" class="am-form-field"
                       data-am-datepicker
                       value="<fmt:formatDate value='${object.publishDate}' pattern='yyyy-MM-dd'/>"
                       placeholder="成立时间" readonly/>
            </div>
        </div>
        <div class="am-form-group">
            <label name="documentContent.content" for="documentContent.content" class="am-u-sm-3 am-form-label">内容<small>*</small></label>
            <div class="am-u-sm-9">
                <textarea cols="10" rows="5" name="documentContent.content" id="documentContent.content"
                          class="ckeditor"
                          placeholder="内容"
                          required="true">${object.documentContent.content}</textarea>
            </div>
        </div>
        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="submit" class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>
    </form>
</div>
<script src="<c:url value='http://libs.baidu.com/jquery/1.11.3/jquery.min.js'/>"></script>
<script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/> "></script>
</body>
</html>
