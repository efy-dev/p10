<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>


<div class="am-g">


    <br>
    <br>
    <div class="am-u-md-12">

        <br>
        <form action="<c:url value="/basic/xm.do"/>" method="post" class="am-form am-form-horizontal">
            <%--<input type="hidden" value="redirect:/basic/xm.do?qm=plistDocument_tenant&groupName=${groupName} " name="url">--%>
            <input type="hidden" name="id" value="${object.id}">
            <input type="hidden" name="qm" value="saveOrUpdateIndustrySolution">
            <%--<input type="hidden" name="documentContent.id" value="${object.documentContent.id}">--%>
            <div class="am-form-group">
                <label for="title" class="am-u-sm-3 am-form-label">名称</label>
                <div class="am-u-sm-9">
                    <input type="text" id="title" name="solutionName" placeholder="" value="${object.solutionName}">
                </div>
            </div>
            <div class="am-form-group">
                <label for="introduction" class="am-u-sm-3 am-form-label">介绍</label>
                <div class="am-u-sm-9">
                    <textarea id="introduction" name="introduction">${object.introduction}</textarea>
                </div>
            </div>

            <div class="am-form-group">
                <div class="am-u-sm-9 am-u-sm-push-3">
                    <button type="submit" class="am-btn am-btn-primary">提交</button>
                </div>
            </div>

        </form>
    </div>
</div>


</body>
</html>
