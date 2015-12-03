<%--检索使用 请勿删除
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/12/03
  Time: 17:46
  To change this template use File | Settings | File Templates.
--%>
<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title><sitemesh:write property='title'/></title>
    <%@include file="mobileMainHeader.jsp" %>
    <sitemesh:write property='head'/>
</head>
<body>
<%@include file="filterNav.jsp" %>
<sitemesh:write property='body'/>
<%@include file="mobileFooter.jsp" %>
<script>
    $().ready(function() {
        $.ajax({
            type: 'post',
            async: false,
            url: "<c:url value='/myEfeiyi/getUserAvatar.do'/>",
            dataType: 'json',
            success: function (data) {
                if(data == "false" ){
                    $("#uploadPi").attr("src", "<c:url value='/scripts/images/img-tx.png'/>");
                }else if(data!=null || data!=null){
                    $("#uploadPi").attr("src", "http://pro.efeiyi.com/" + data + "@!user-pic");
                }
            }
        })
    })
</script>
</body>
</html>
