<%--
  User: Kyll 
  Time: 2008-1-4 9:18:03
--%>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="org.springframework.security.ui.rememberme.TokenBasedRememberMeServices" %>
<%
    if (request.getSession(false) != null) {
        session.invalidate();
    }
    /*Cookie terminate = new Cookie(
            TokenBasedRememberMeServices.ACEGI_SECURITY_HASHED_REMEMBER_ME_COOKIE_KEY,
            null);
    String contextPath = request.getContextPath();
    terminate.setPath(contextPath != null && contextPath.length() > 0 ? contextPath : "/");
    terminate.setMaxAge(0);
    response.addCookie(terminate);*/
%>

<%@ include file="/common/taglibs.jsp" %>
<%@ page isErrorPage="true" %>
<c:redirect url="/index.jsp"/>
