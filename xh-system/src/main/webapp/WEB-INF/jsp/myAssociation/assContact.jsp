<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/18
  Time: 10:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title></title>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">中国非物质文化遗产保护协会-
            <ming800:status name="group" dataType="document.group" checkedValue='${group}' type="normal"/>
        </strong>
    </div>
</div>
<hr/>
<div class="am-g">
    <form id="assContactForm" action="<c:url value='/myAssociation/saveAssContact.do'/>?qm=${requestScope.resultPage}"
          onsubmit="return afterSubmitForm('assContactForm')"
          method="post" enctype="multipart/form-data" class="am-form am-form-horizontal">
        <input value="${document.id}" name="id" type="hidden"/>
        <input value="${document.status}" name="status" type="hidden"/>
        <input value="${document.documentContent.id}" name="documentContent.id" type="hidden"/>
        <input value="${group}" name="group" type="hidden">

        <div class="am-form-group">
            <label name="地址" for="sampleContent" class="am-u-sm-3 am-form-label">地&nbsp;&nbsp;址<small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="sampleContent" id="sampleContent" placeholder="地址"
                       value="${document.sampleContent}" required="true">
            </div>
        </div>
        <div class="am-form-group">
            <label name="邮编" for="documentOrder" class="am-u-sm-3 am-form-label">邮&nbsp;&nbsp;编<small>*</small></label>
            <div class="am-u-sm-9">
                <input type="number" name="documentOrder" id="documentOrder" min="100000" max="999999"
                       placeholder="邮编" value="${document.documentOrder}" required="true">
            </div>
        </div>
        <div class="am-form-group">
            <label name="电话" for="name" class="am-u-sm-3 am-form-label">电&nbsp;&nbsp;话<small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="name" id="name" placeholder="电话" value="${document.name}" required="true">
            </div>
        </div>
        <div class="am-form-group">
            <label name="Email" for="title" class="am-u-sm-3 am-form-label">E-mail<small>*</small></label>
            <div class="am-u-sm-9">
                <input type="email" name="title" id="title" placeholder="E-mail" value="${document.title}" required="true">
            </div>
        </div>
        <div class="am-form-group">
            <label name="客服电话" for="keywords" class="am-u-sm-3 am-form-label">在线客服<small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="keywords" id="keywords" placeholder="在线客服" value="${document.keywords}" required="true">
            </div>
        </div>
        <div class="am-form-group">
            <label name="介绍" for="documentContent.content" class="am-u-sm-3 am-form-label">介&nbsp;&nbsp;绍<small>*</small></label>
            <div class="am-u-sm-9">
                <textarea name="documentContent.content" id="documentContent.content"
                          class="ckeditor"
                          placeholder="介绍" required="true">${document.documentContent.content}</textarea>
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
