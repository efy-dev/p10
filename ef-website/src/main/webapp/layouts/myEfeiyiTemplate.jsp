<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/24
  Time: 17:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>--%>
<html>
<head>
  <sitemesh:write property='head'/>
</head>
<body>
<div class="my-order">
  <div class="order-nav">
    <div class="layout-nav">
      <div class="order">
        <span><img src="images/img-tx.png"></span>
        <p>151******79</p>
      </div>
      <ul class="layout-li">
        <c:set var="match" value="${requestScope['javax.servlet.forward.servlet_path']}"/>${pageContext.request.queryString}
        <jsp:include flush="true" page="/getMenu.do?jmenuId=orderMenu&jnodeId=orderManager&resultPage=/jmenu/nav&match=${match} "></jsp:include>
      </ul>
    </div>
  </div>
</div>
<sitemesh:write property='body'/>

</body>

</html>
