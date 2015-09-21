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
        <strong class="am-text-primary am-text-lg">添加/编辑<ming800:status name="group" dataType="announcements.group"
                                                                        checkedValue="${object.group}"
                                                                        type="normal"/></strong>
    </div>
</div>
<hr/>
<div class="am-g">
    <form id="documentForm" action="<c:url value='/myAttachment/saveAttachment.do'/>?qm=${requestScope.qm}"
          onsubmit="return afterSubmitForm('documentForm')"
          method="post" enctype="multipart/form-data" class="am-form am-form-horizontal">
        <input id="id" value="${object.id}" name="id"
               type="hidden"/>
        <%--<input id="documentContent.id" value="${object.documentContent.id}"--%>
               <%--name="documentContent.id"--%>
               <%--type="hidden"/>--%>
        <input id="documentOrder" value="${object.documentOrder}"
               name="documentOrder"
               type="hidden"/>
        <input id="status" value="${object.status}" name="status"
               type="hidden"/>
        <input id="publishDate"
               value="<fmt:formatDate value="${object.publishDate}" pattern="yyyy-MM-dd HH:mm"/>"
               name="publishDate"
               type="hidden"/>
        <input type="hidden" id="keywords" placeholder="keywords" name="keywords"
               value="${object.keywords}">
        <input type="hidden" id="name" placeholder="name"
               name="name"
               value="${object.name}">
        <c:if test='${empty object.group}'>
            <input type="hidden" id="group" placeholder="group"
                   name="group"
                   value="${group}">
        </c:if>
        <c:if test='${not empty object.group}'><input type="hidden" id="group" placeholder="group"
                                                      name="group"
                                                      value="${object.group}"></c:if>

        <div class="am-form-group">
            <label name="附件名称" for="title" class="am-u-sm-3 am-form-label">附件名称
                <small>*</small>
            </label>

            <div class="am-u-sm-9">
                <input type="text" name="title" id="title" placeholder="附件名称" value="${object.title}" required="true">
            </div>
        </div>

        <div class="am-form-group">
            <label name="附件说明" for="name" class="am-u-sm-3 am-form-label">附件说明
                <small>&nbsp;&nbsp;</small>
            </label>

            <div class="am-u-sm-9">
                <input type="text" name="sampleContent" id="sampleContent" placeholder="附件说明"
                       value="${object.sampleContent}">
            </div>
        </div>

        <div class="am-form-group">
            <label for="file" class="am-u-sm-3 am-form-label">附件上传
                <small>&nbsp;&nbsp;</small>
            </label>
            <div class="am-u-sm-9">
                <input type="file" id="file" name="file" placeholder="">
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
