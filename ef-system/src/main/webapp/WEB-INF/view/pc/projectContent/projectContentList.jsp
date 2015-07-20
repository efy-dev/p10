<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/18
  Time: 14:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--<script type="text/javascript" src="<c:url value='/scripts/assets/js/amazeui.js'/>"/>--%>
<link href="/script/assets/css/amazeui.css">
<html>
<head>
    <title>百科内容</title>
</head>
<body>
  <table <%--class="am-table am-table-bordered am-table-striped am-table-compact"--%>>
    <tr>
      <td>百科内容id</td>
      <td>百科内容</td>
    </tr>

      <c:forEach items="${objectList}" var="projectContent">
    <tr>
        <td>${projectContent.id}</td>
        <td>${projectContent.content}</td>
    </tr>
      </c:forEach>
  </table>
</body>
</html>
