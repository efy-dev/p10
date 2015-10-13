<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/23
  Time: 13:39
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
        <strong class="am-text-primary am-text-lg">
            <c:if test="${empty document.title}">
                <ming800:status name="group" dataType="document.group" checkedValue='${group}' type="normal"/>
            </c:if>
            <c:if test="${not empty document.title}">
                ${document.title}
            </c:if>
        </strong>
    </div>
</div>
<hr/>
<div class="am-g">
    <form id="heritageLaw" action="<c:url value='/myHeritageProject/saveHeritageLaw.do'/>?qm=${requestScope.resultPage}"
          onsubmit="return afterSubmitForm('heritageLaw')"
          method="post" enctype="multipart/form-data" class="am-form am-form-horizontal">
        <input value="${document.id}" name="id" type="hidden"/>
        <input value="${document.status}" name="status" type="hidden"/>
        <input value="${document.publishDate}" name="publishDate" type="hidden"/>
        <input value="${document.documentOrder}" name="documentOrder" type="hidden"/>
        <input value="${document.documentContent.id}" name="documentContent.id" type="hidden"/>
        <input value="${group}" name="group" type="hidden"/>

        <div class="am-form-group">
            <label name="标题" for="title" class="am-u-sm-3 am-form-label">标题<small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="title" id="title" placeholder="标题" value="${document.title}" required="true">
            </div>
        </div>
        <div class="am-form-group">
            <label name="documentContent.content" for="documentContent.content" class="am-u-sm-3 am-form-label">正文<small>*</small>
            </label>
            <div class="am-u-sm-9">
                <textarea name="documentContent.content" id="documentContent.content"
                          class="ckeditor"
                          placeholder="内容" required="true">${document.documentContent.content}</textarea>
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
<script type="text/javascript">
    CKEDITOR.replace('documentContent.content', {
        filebrowserUploadUrl: '<c:url value="/myDocument/ckeditorUpload.do"/>'
    });
</script>
</body>
</html>
