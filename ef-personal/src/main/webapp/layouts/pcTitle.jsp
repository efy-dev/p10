<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/28
  Time: 17:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<title id="title_attr"></title>
<script>
    $.ajax({
        type: "post",
        url: '<c:url value="/getTenant.do"/>',
        cache: false,
        dataType: "json",
        success: function (data) {
            console.log(data);
            $("#title_attr").val(data.fullName);
        }
    });
</script>
