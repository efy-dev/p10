<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/24
  Time: 19:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<body>
<%@include file="/layouts/title.jsp" %>
<div class="wh home-list isoc">
<jsp:include flush="true"
             page="/getMenu.do?jmenuId=AssociationMenu&resultPage=/jmenu/manageTemplateLeft&match=${requestScope['javax.servlet.forward.servlet_path']}%3F${fn:replace(pageContext.request.queryString,'&','%26')}"/>
<jsp:include flush="true"
             page="/myDocument/getSubMenu.do?jmenuId=AssociationMenu&resultPage=/jmenu/manageTemplateSubMenu&match=${requestScope['javax.servlet.forward.servlet_path']}%3F${fn:replace(pageContext.request.queryString,'&','%26')}"/>
<sitemesh:write property='body'/>
</div>
<%@include file="/layouts/footer.jsp" %>
</body>
</html>
