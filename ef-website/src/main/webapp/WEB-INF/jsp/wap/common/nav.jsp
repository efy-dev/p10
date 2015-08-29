<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/25
  Time: 15:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
</head>
<body>
<c:if test="${sign != null and sign == '000'}">
    <header class="am-header custom-header index-header">
        <div class="logo"><a class="icon" href="" title="e飞蚁"></a></div>
        <!-- //End--logo-->
        <div class="am-header-right am-header-nav">
            <a href="<c:url value="/cart/view"/>" class="icon icon-cart"><span class="tips"><em
                    id="cartAmount">0</em></span></a>
            <a href="<c:url value="/order/myEfeiyi/list.do"/>" class="icon icon-user"></a>
        </div>
    </header>
</c:if>
<c:if test="${sign == null}">

</c:if>
<script>

    $().ready(function () {
        var success = function (data) {
            $("#cartAmount").html(data);
        }
        ajaxRequest("<c:url value="/cart/cartAmount.do"/>", {}, success, function () {
        }, "post");
    });

</script>
</body>
</html>
