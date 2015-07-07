<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/24
  Time: 17:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title><sitemesh:title default="装饰器页面..." /></title>
  <sitemesh:head/>
</head>
<body>
<%@ include file="/layouts/header.jsp"%>
<div>
  <sitemesh:body/>
</div>
<%@ include file="/layouts/footer.jsp"%>
</body>

</html>
