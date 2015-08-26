
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.ming800.core.util.HttpUtil" %>
<%--<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>--%>
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
</head>
<body <sitemesh:write property='body.class'/>>

<%
    if(HttpUtil.isPhone(request)){
%>
<%--导航--%>
<jsp:include flush="true"
             page="/getMenu.do?jmenuId=nav&jnodeId=nav&resultPage=/common/nav&match=${requestScope['javax.servlet.forward.servlet_path']}%3F${fn:replace(pageContext.request.queryString,'&','%26')}"/>

<%
}else{
%>
<%--导航--%>
<jsp:include flush="true"
             page="/getMenu.do?jmenuId=nav&jnodeId=nav&resultPage=/common/nav&match=${requestScope['javax.servlet.forward.servlet_path']}%3F${fn:replace(pageContext.request.queryString,'&','%26')}"/>

<%
    }
%>

<div class="wh" style="">
    <%
        if(HttpUtil.isPhone(request)){
    %>
    <sitemesh:write property='body'/>
    <%
    }else{
    %>
    <sitemesh:write property='body'/>
    <%
        }
    %>
</div>
    <%
        if(HttpUtil.isPhone(request)){
    %>
    <%@include file="mobileFooter.jsp" %>
    <%
    }else{
    %>
    <%@include file="footer.jsp" %>
    <%
        }
    %>

</body>

</html>
