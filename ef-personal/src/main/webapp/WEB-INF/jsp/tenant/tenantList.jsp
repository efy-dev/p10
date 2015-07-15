<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
</head>
<body>
    <form action="" method="post">
        <table>
            <c:forEach items="${tenantList}" var="tenant" >
                <tr>
                    <td>
                        <input type="button" value="查看">
                        <input type="hidden" name="tenantId" value="${tenant.id}">
                    </td>
                    <td>${tenant.id}</td>
                    <td>${tenant.name}</td>
                </tr>
            </c:forEach>
        </table>
    </form>
</body>
</html>
