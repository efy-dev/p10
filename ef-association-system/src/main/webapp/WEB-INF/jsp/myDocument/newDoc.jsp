<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/7
  Time: 13:55
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
    <form id="documentForm" action="<c:url value='/myDocument/saveDocument.do'/>?qm=${requestScope.qm}"
          onsubmit="return afterSubmitForm('documentForm')"
          method="post" enctype="multipart/form-data" class="am-form am-form-horizontal">
        <input id="id" value="${object.id}" name="id"
               type="hidden"/>
        <input id="documentContent.id" value="${object.documentContent.id}"
               name="documentContent.id"
               type="hidden"/>
        <input id="documentOrder" value="${object.documentOrder}"
               name="documentOrder"
               type="hidden"/>
        <input id="status" value="${object.status}" name="status"
               type="hidden"/>
        <input id="publishDate"
               value="<fmt:formatDate value="${object.publishDate}" pattern="yyyy-MM-dd"/>"
               name="publishDate"
               type="hidden"/>
        <input type="hidden" id="keywords" placeholder="keywords" name="keywords"
               value="${object.keywords}">
        <input type="hidden" id="sampleContent" placeholder="sampleContent"
               name="sampleContent"
               value="${object.sampleContent}">
        <input value="${group}" name="group" type="hidden"/>

        <div class="am-form-group">
            <label name="标题" for="title" class="am-u-sm-3 am-form-label">标题
                <small>*</small>
            </label>

            <div class="am-u-sm-9">
                <input type="text" name="title" id="title" placeholder="标题" value="${object.title}" required="true">
            </div>
        </div>
        <div class="am-form-group">
            <label name="发布人" for="name" class="am-u-sm-3 am-form-label">发布人
                <small>&nbsp;&nbsp;</small>
            </label>

            <div class="am-u-sm-9">
                <input type="text" name="name" id="name" placeholder="发布人" value="${object.name}">
            </div>
        </div>
        <div class="am-form-group">
            <label name="documentContent.content" for="documentContent.content" class="am-u-sm-3 am-form-label">正文
                <small>*</small>
            </label>

            <div class="am-u-sm-9">
                <textarea cols="10" rows="5" name="documentContent.content" id="content"
                          class="ckeditor"
                          placeholder="内容"
                          required="true">${object.documentContent.content}</textarea>
            </div>
        </div>
        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="button" class="am-btn am-btn-primary" onclick="addHTML()" value="预览">
                <input type="submit" class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>
    </form>
</div>
<div class="am-modal am-modal-no-btn" tabindex="-1" id="preview">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">中国非物质文化遗产保护协会-
            <ming800:status name="group" dataType="document.group" checkedValue='${group}' type="normal"/>
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd">
            <div id="contentText" align="left" style="height: 200px;overflow-y: auto">
                ${object.documentContent.content}
            </div>
        </div>
    </div>
</div>
<script src="<c:url value='http://libs.baidu.com/jquery/1.11.3/jquery.min.js'/>"></script>
<script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/> "></script>
<script type="text/javascript">
    function addHTML(){
        var ss=window.open("");
        var content = CKEDITOR.instances.content.getData();
//        alert(content);
        ss.document.write(content);
        ss.document.close();
    }
</script>
</body>
</html>
