<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/18
  Time: 16:48
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
    <form id="assForm" action="<c:url value='/myAssociation/saveAssIntroOrStatute.do'/>?qm=${requestScope.resultPage}"
          onsubmit="return afterSubmitForm('assForm')"
          method="post" enctype="multipart/form-data" class="am-form">
        <input value="${document.id}" name="id" type="hidden"/>
        <input value="${document.status}" name="status" type="hidden"/>
        <input value="${document.documentContent.id}" name="documentContent.id" type="hidden"/>
        <input value="${group}" name="group"  type="hidden">

        <div class="am-form-group">
            <textarea name="documentContent.content" id="content"
                      class="ckeditor"
                      placeholder="内容"
                      required="true">${document.documentContent.content}</textarea>
        </div>
        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="button" class="am-btn am-btn-primary" onclick="addHTML()" value="预览">
                <input type="submit" class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>
    </form>
</div>
<script src="<c:url value='http://libs.baidu.com/jquery/1.11.3/jquery.min.js'/>"></script>
<script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/> "></script>
<script type="text/javascript">
    function addHTML(){
       var ss=window.open("");
        var content = CKEDITOR.instances.content.getData();
        ss.document.write(content);
        ss.document.close();
    }
    CKEDITOR.replace('content', {
        filebrowserUploadUrl: '<c:url value="/myDocument/ckeditorUpload.do"/>'
    });
</script>
</body>
</html>
