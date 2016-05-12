<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<div>
  <c:if test="${subject.subjectDescription.content != null && subject.subjectDescription.content != ''}">
    ${subject.subjectDescription.content}
  </c:if>
</div>
</body>
</html>
