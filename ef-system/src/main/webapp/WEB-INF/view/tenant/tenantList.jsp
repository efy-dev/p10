<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 14:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <script src="<c:url value="/scripts/jquery-1.11.1.min.js"/>"></script>
    <title></title>
    <script>
      $(function(){
        $('#send').click(function(){
          $.ajax({
            type: "POST",
            url: "/basic/xm.do?qm=formTenant&conditions=id:${objectList};name:'${tenant.name}'"
          });
        });
      });
    </script>
</head>
<body>
<table>
  <tr>
    <td>传承人id</td>
    <td>传承人名称</td>
    <td>修改</td>
  </tr>

  <c:forEach items="${objectList}" var="tenant">
    <tr>
      <td>${tenant.id}<input type="hidden" value="${tenant.id}" id="${tenant.id}"></td>
      <td>${tenant.name}<input type="hidden" value="${tenant.name}" id="${tenant.name}"></td>
    </tr>
  </c:forEach>

</table>

</body>
</html>
