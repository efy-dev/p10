<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/25
  Time: 9:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title>协会章程</title>
</head>
<body>
<div class="slide-right">
  <div class="title">中国非物质文化遗产保护协会-<ming800:status name="group" dataType="document.group" checkedValue='${group}' type="normal"/></div>
  <div class="div-list">
    <ul class="div-list-ul">
      <li>
        ${object.documentContent.content}
      </li>
    </ul>
  </div>
  <!-- //End--div-list-->
</div>
<!-- //End--slide-right-->
</body>
</html>
