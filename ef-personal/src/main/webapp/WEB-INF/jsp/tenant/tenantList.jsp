<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <script type="text/javascript" src="<c:url value='/scripts/jquery-1.11.1.min.js'/>"></script>
    <script type="text/javascript" >
        function tenantView(o){
            var tenantId = $(o).next().val();
            window.location.href="/tenant/getTenant.do?tenantId="+tenantId;
        }
    </script>
</head>
<body>
    <form action="" method="post">
        <table>
            <c:forEach items="${tenantList}" var="tenant" >
                <tr>
                    <td>
                        <input type="button" value="查看" onclick="tenantView(this);">
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
