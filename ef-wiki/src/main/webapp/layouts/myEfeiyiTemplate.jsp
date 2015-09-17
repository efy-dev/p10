<!doctype html>
<%@ page import="com.efeiyi.ec.wiki.organization.util.AuthorizationUtil" %>
<%@ page import="com.ming800.core.util.HttpUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title><sitemesh:write property='title'/></title>
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
<jsp:include flush="true"
             page="/getMenu.do?jmenuId=nav&jnodeId=nav&resultPage=/common/nav&match=${requestScope['javax.servlet.forward.servlet_path']}%3F${fn:replace(pageContext.request.queryString,'&','%26')}"/>
<sitemesh:write property='body'/>
<%@include file="mobileFooter.jsp" %>
<%
}else{
%>
<jsp:include flush="true"
             page="/getMenu.do?jmenuId=nav&jnodeId=nav&resultPage=/common/nav&match=${requestScope['javax.servlet.forward.servlet_path']}%3F${fn:replace(pageContext.request.queryString,'&','%26')}"/>
<div class="wh">

   <%-- <%@include file="footer.jsp" %>--%>
<%
  }
%>

</body>
</html>
