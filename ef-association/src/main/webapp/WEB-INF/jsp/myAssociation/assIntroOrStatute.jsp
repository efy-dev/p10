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
    <form id="assForm" action="<c:url value='/myDocument/saveDocument.do'/>?qm=${requestScope.resultPage}"
          onsubmit="return afterSubmitForm('assForm')"
          method="post" enctype="multipart/form-data" class="am-form">
        <input id="id" value="${document.id}" name="id" type="hidden"/>
        <input id="documentContent.id" value="${document.documentContent.id}" name="documentContent.id" type="hidden"/>
        <input id="status" value="${document.status}" name="status" type="hidden"/>
        <input id="group" name="group" value="${group}" type="hidden">

        <div class="am-form-group">
            <textarea name="documentContent.content" id="documentContent.content"
                      class="ckeditor"
                      placeholder="内容"
                      required="true">${document.documentContent.content}</textarea>
        </div>
        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="button" class="am-btn am-btn-primary"
                        data-am-modal="{target: '#assPreview', closeViaDimmer: 0, width: 800, height: 250}"
                        value="预览"/>
                <input type="submit" class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>
    </form>
</div>
<div class="am-modal am-modal-no-btn" tabindex="-1" id="assPreview">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">中国非物质文化遗产保护协会-
            <ming800:status name="group" dataType="document.group" checkedValue='${group}' type="normal"/>
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd">
            <div id="contentText" align="left" style="height: 200px;overflow-y: auto">
                ${document.documentContent.content}
            </div>
        </div>
    </div>
</div>
<script src="<c:url value='http://libs.baidu.com/jquery/1.11.3/jquery.min.js'/>"></script>
<script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/> "></script>
</body>
</html>
