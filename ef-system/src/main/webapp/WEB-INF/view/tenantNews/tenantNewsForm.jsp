<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <script src="/scripts/ckeditor2/ckeditor.js"></script>
</head>
<body>
  <form action="/basic/xm.do?qm=saveOrUpdateTenantNews" method="post">
    title：<input type="text" name="title" id="title" >
    <textarea id="content" name="content" class="ckeditor"></textarea>
    <input type="submit" value="保存">
  </form>

</body>
</html>
