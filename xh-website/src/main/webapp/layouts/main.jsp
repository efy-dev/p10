<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/24
  Time: 17:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html class="no-js">
<%@include file="/layouts/title.jsp"%>
<div class="am-cf admin-main">
    <%----%>
    <jsp:include flush="true"
                 page="/getMenu.do?jmenuId=AssociationMenu&resultPage=/jmenu/manageTemplateLeft&match=${requestScope['javax.servlet.forward.servlet_path']}%3F${fn:replace(pageContext.request.queryString,'&','%26')}"/>

    <div class="admin-content" style="height: auto">
        <sitemesh:write property='body'/>
    </div>

</div>
<%@include file="/layouts/footer.jsp"%>
</body>

</html>
