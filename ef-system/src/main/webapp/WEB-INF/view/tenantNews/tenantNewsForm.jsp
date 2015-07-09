<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title></title>
    <script src="<c:url value='/scripts/ckeditor/ckeditor.js'/>"></script>
    <script src="<c:url value='/scripts/ckeditor/config.js'/>"></script>
    <script src="<c:url value='/scripts/jquery-1.11.1.min.js'/>"></script>
    <script src="<c:url value='/scripts/ckeditor/adapters/jquery.js'/>"></script>
    <%--引入jQuery的话 也必须引入adapter下的jQuery文件 两者不冲突--%>
    <script src="<c:url value='/scripts/m8u/jquery.m8u2.min.js'/>"></script>
    <%--引入jQuery easyui--%>
    <script>
        $(function () {
            CKEDITOR.editorConfig = function (config) {
//        config.language = 'es';
                config.uiColor = '#F7B42C';
//        config.height = 3000;
//        config.toolbarCanCollapse = true;
//        config.widths = 300;
                config.width = 400;
                config.height = 400;
            };
            CKEDITOR.replace('content');
            console.log("test");
        });
    </script>
</head>
<body>
<form action="/basic/xm.do" method="get">
    title：<input type="text" name="title" id="title">

    <div>
        <textarea id="content" name="content"  ></textarea>
    </div>
    <input type="submit" value="保存">
    <input type="hidden" value="saveOrUpdateTenantNews" name="qm">
</form>

</body>
</html>
