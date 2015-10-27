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
    <script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/>"></script>

</head>
<body>


<div class="admin-content">
    <div class="am-g">

        <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8"><%--少了这个div就出错--%>
        </div>

        <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
            <form action="<c:url value="/document/saveDocument.do?groupName=${groupName}"/>" method="post" class="am-form am-form-horizontal">
                <input type="hidden" value="saveOrUpdateDocument" name="qm">
                <input type="hidden" name="id" value="${object.id}">
                <input type="hidden" name="documentContent.id" value="${object.documentContent.id}">
                <div class="am-form-group">
                    <label for="title" class="am-u-sm-3 am-form-label">标题</label>
                    <div class="am-u-sm-9">
                        <input type="text" id="title" name="title" placeholder="" value="${object.title}">
                    </div>
                </div>
                <div class="am-form-group">
                    <label for="group" class="am-u-sm-3 am-form-label">类别</label>
                    <div class="am-u-sm-9">
                        <ming800:status name="group" dataType="Document.group" checkedValue="${object.group}" type="select"/>
                    </div>
                </div>
                <div class="am-form-group">
                    <label  class="am-u-sm-3 am-form-label">内容</label>
                    <div class="am-u-sm-9">
                            <textarea id="sampleContent" name="documentContent.content" class="ckeditor"
                                      placeholder="输入内容">${object.documentContent.content}
                            </textarea>
                    </div>
                </div>

                <div class="am-form-group">
                    <div class="am-u-sm-9 am-u-sm-push-3">
                        <button type="submit" class="am-btn am-btn-primary">保存修改</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>
