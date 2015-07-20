<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/10
  Time: 15:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>

<jsp:include flush="true" page="/manage/getMenu.do?jmenuName=commonMenu&resultPage=/jmenu/manageTemplateHeader"></jsp:include>

<div class="am-cf admin-main">

<jsp:include flush="true" page="/manage/getMenu.do?jmenuName=commonMenu&resultPage=/jmenu/manageTemplateLeft"></jsp:include>

<div class="admin-content">
</div>

</div>

</body>
</html>
