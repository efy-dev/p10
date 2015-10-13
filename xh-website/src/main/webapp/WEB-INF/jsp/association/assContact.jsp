<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/25
  Time: 9:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
  <title>协会联系方式</title>
</head>
<body>
<div class="slide-right">
  <div class="title">中国非物质文化遗产保护协会-<ming800:status name="group" dataType="document.group" checkedValue='${group}' type="normal"/></div>
  <div class="div-list">
    <ul class="div-list-ul">
      <li>
        ${object.documentContent.content}
      </li>
      <li>
        <p>地址:&nbsp;&nbsp;${object.sampleContent}</p>
      </li>
      <li>
        <p>邮编:&nbsp;&nbsp;${object.documentOrder}</p>
      </li>
      <li>
        <p>电话:&nbsp;&nbsp;${object.name}</p>
      </li>
      <li>
        <p>E-mail:&nbsp;&nbsp;${object.title}</p>
      </li>
      <li>
        <p>在线客服:&nbsp;&nbsp;${object.keywords}</p>
      </li>
    </ul>
  </div>
</div>
</body>
</html>
