<%@ page language="java" pageEncoding="UTF-8"
         contentType="text/html;charset=utf-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta http-equiv="Cache-Control" content="no-cache">
    <link type="text/css" rel="stylesheet" href="<c:url value='/theme/theme.css?m=5.2'/>"/>
</head>
<body>
<%--    <div id="dcrtNavg">
		<span class="navgico"></span>
		<span class="navglabel">
			异常信息
		</span>
	</div>--%>
<a href="javascript: window.history.back();" class="btn-blue" style="margin: 5px;">
    <%--<img src="<c:url value="/images/button/back.gif"/>" alt="" align="absmiddle" style="border: none;">--%>返回
</a>

<div class="note" style="margin-top: 5px;font-size: 14px;">
    提示信息：
    <c:out value="${pageContext.exception.message}"/>
</div>
<div style="margin-left: 50px; color: #FFFFFF;">
    <c:forEach items="${pageContext.exception.stackTrace}" var="element">
        <c:out value="${element.className}"/>.<c:out value="${element.methodName}"/>(<c:out
            value="${element.lineNumber}"/>)<br/>
    </c:forEach>
</div>
;
</body>
</html>
