
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html class="no-js">
<head>
<title>
    <c:forEach items="${document}" var="document">
        ${document.title}
    </c:forEach>
</title>
</head>
<body>

<div class="right bk">
    <c:forEach items="${document}" var="document">
          ${document.documentContent.content}
    </c:forEach>
</div>

</body>
</html>
