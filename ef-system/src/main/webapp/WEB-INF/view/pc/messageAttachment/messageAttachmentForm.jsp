<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title></title>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">动态详情</strong> /
        <small>Message Attachment</small>
    </div>
</div>

<hr/>
<script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/>"></script>
<div class="am-g">
    <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8"><%--少了这个div就出错--%>
    </div>
    <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
        <form action="<c:url value="/attachment/saveAttachment.do"/>" method="post" class="am-form am-form-horizontal" enctype="multipart/form-data">
            <input type="hidden" value="saveOrUpdateMessageAttachment" name="qm">
            <input type="hidden" name="masterMessageId" value="${masterMessageId}">
            <input type="hidden" name="masterMessage.id" value="${masterMessageId}">
            <input type="hidden" name="type" value="${type}">
            <input type="hidden" name="id" value="${object.id}"/>
            <label class="am-u-sm-3 am-form-label">动态</label>
            <div class="am-u-sm-9" style="margin-top: 10px;">
                <textarea id="productDescription" name="content" class="ckeditor" id="content"
                          placeholder="动态" required >${object.fileName}
                </textarea>
            </div>
            <div class="am-form-group">
                <div class="am-u-sm-9 am-u-sm-push-3">
                    <button type="submit" class="am-btn am-btn-primary">保存</button>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>
