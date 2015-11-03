<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/11/3
  Time: 9:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="master"></div>
<script src="<c:url value='/resources/assets/js/jquery.min.js'/>"></script>
<script type="text/javascript">
  $.ajax({
    type: "get",
    url: "<c:url value='/home/homeMaster.do?qm=plistMaster_master'/>",
    cache: false,
    success: function (result) {
      //            alert(result);
      $("#master").replaceWith(result);
    },
  });
</script>
