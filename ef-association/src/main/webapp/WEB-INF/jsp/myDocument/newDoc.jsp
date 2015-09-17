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
           value="返回" />
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
    <form id="documentForm" action="<c:url value='/myDocument/saveDocument.do'/>?qm=${requestScope.qm}"
          onsubmit="return afterSubmitForm('documentForm')"
          method="post" enctype="multipart/form-data" class="am-form am-form-horizontal">
        <c:if test="${not empty object.id}">
        <input id="id" value="${object.id}" name="id"
               type="hidden"/>
        </c:if>
        <c:if test="${not empty object.documentContent.id}">
        <input id="documentContent.id" value="${object.documentContent.id}"
               name="documentContent.id"
               type="hidden"/>
        </c:if>
        <input id="documentOrder" value="${object.documentOrder}"
               name="documentOrder"
               type="hidden"/>
        <input id="status" value="${object.status}" name="status"
               type="hidden"/>
        <input id="publishDate"
               value="<fmt:formatDate value="${object.publishDate}" pattern="yyyy-MM-dd HH:mm"/>"
               name="publishDate"
               type="hidden"/>
        <div class="am-form-group">
            <label name="title" for="title" class="am-u-sm-3 am-form-label">title
                <small>*</small>
            </label>

            <div class="am-u-sm-9">
                <input type="text" name="title" id="title" placeholder="title" value="${object.title}" required="true">
            </div>
        </div>
        <div class="am-form-group">
            <label name="name" for="name" class="am-u-sm-3 am-form-label">name
                <small>&nbsp;&nbsp;</small>
            </label>

            <div class="am-u-sm-9">
                <input type="text" name="name" id="name" placeholder="name" value="${object.name}">
            </div>
        </div>
        <div class="am-form-group">
            <label name="keywords" for="keywords" class="am-u-sm-3 am-form-label">keywords
                <small>*</small>
            </label>

            <div class="am-u-sm-9">
                <input type="text" id="keywords" placeholder="keywords" name="keywords"
                       onclick=""
                       value="${object.keywords}" required="true">
            </div>
        </div>
        <div class="am-form-group">
            <label name="sampleContent" for="sampleContent" class="am-u-sm-3 am-form-label">sampleContent
                <small>*</small>
            </label>

            <div class="am-u-sm-9">
                <input type="text" id="sampleContent" placeholder="sampleContent"
                       onclick="" name="sampleContent"
                       value="${object.sampleContent}" required="true">
            </div>
        </div>
        <div class="am-form-group">
            <label name="group" for="group" class="am-u-sm-3 am-form-label">分类
                <small>*</small>
            </label>

            <div class="am-u-sm-9">
                <ming800:status name="group" dataType="document.group"
                                checkedValue="${object.group}"
                                type="select"/>
            </div>
        </div>
        <div class="am-form-group">
            <label name="documentContent.content" for="documentContent.content" class="am-u-sm-3 am-form-label">正文
                <small>*</small>
            </label>

            <div class="am-u-sm-9">
                <textarea cols="10" rows="5" name="documentContent.content" id="documentContent.content" class="am-form-field"
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
</body>
</html>
