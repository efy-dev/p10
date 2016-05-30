<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/5/27 0027
  Time: 17:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>题库地图-非遗百科</title>
</head>
<body>
<div class="am-g" style="text-align: center">

    <c:forEach items="${questions}" var="question">
        <a href="http://minglu.efeiyi.com/question/${question.id}.html"
           title="${question.questionName}">${question.questionContent}</a><br>
    </c:forEach>
</div>
</body>
</html>
