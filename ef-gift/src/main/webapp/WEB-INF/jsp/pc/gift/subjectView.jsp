<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title></title>
</head>
<body>
<div style="width: 1200px;margin: 0 auto">
  <c:if test="${subject.subjectDescription.content != null && subject.subjectDescription.content != ''}">
    ${subject.subjectDescription.content}
  </c:if>
</div>
</body>
</html>