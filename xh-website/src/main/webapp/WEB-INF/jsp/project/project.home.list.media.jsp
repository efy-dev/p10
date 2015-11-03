<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/11/2
  Time: 16:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="project"></div>
<script src="<c:url value='/resources/assets/js/jquery.min.js'/>"></script>
<script type="text/javascript">
    $.ajax({
        type: "get",
        url: "<c:url value='/project/project.home.list.do?qm=plistProject_default'/>",
        cache: false,
        success: function (result) {
            //            alert(result);
            $("#project").replaceWith(result);
        },
    });
</script>
