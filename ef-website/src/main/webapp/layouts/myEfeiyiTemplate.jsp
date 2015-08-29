<%@ page import="com.efeiyi.ec.website.organization.util.AuthorizationUtil" %>
<%@ page import="com.ming800.core.util.HttpUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <%
      if(HttpUtil.isPhone(request)){
    %>
    <%@include file="mobileMainHeader.jsp" %>
    <%
    }else{
    %>
    <%@include file="pcMainHeader.jsp" %>
    <%
      }
    %>
    <sitemesh:write property='head'/>
</head>
<body>
<%
  if(HttpUtil.isPhone(request)){
%>
<sitemesh:write property='body'/>
<%@include file="mobileFooter.jsp" %>
<%
}else{
%>
<jsp:include flush="true"
             page="/getMenu.do?jmenuId=nav&jnodeId=nav&resultPage=/common/nav&match=${requestScope['javax.servlet.forward.servlet_path']}%3F${fn:replace(pageContext.request.queryString,'&','%26')}"/>
<div class="wh">
  <div class="my-order">
    <div class="order-nav">
      <div class="layout-nav">
        <div class="order">
          <c:set var="user" >
            <%= AuthorizationUtil.getMyUser().getUsername()%>
          </c:set>
          <span><img src="<c:url value="/scripts/images/img-tx.png"/>"></span>
          <p>${fn:substring(user, 0,3 )}*****${fn:substring(user,7,11)}</p>
        </div>
        <c:set var="match" value="${requestScope['javax.servlet.forward.servlet_path']}"/>
        <jsp:include flush="true" page="/getMenu.do?jmenuId=orderMenu&jnodeId=orderManager&resultPage=/purchaseOrder/purchaseOrderTemplate&match=${match} "/>
      </div>
      <sitemesh:write property='body'/>
    </div>
    <%@include file="footer.jsp" %>
<%
  }
%>

</body>
</html>
