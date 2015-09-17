<!DocType html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
</head>
<body>
<div  class="header-search">
    <h1><a href="http://www.efeiyi.com"><img src="<c:url value="/scripts/assets/images/images/logo.png"/>"></a></h1>
    <div class="header-aifeiyi"></div>
    <div class="header-sj"></div>
</div>
<div id="page-section">
    <div class="page-section-text"><a href="#"><img src="<c:url value="/scripts/assets/images/i/wz2-5.gif" />"></a></div>
    <div class="page-section-figure">
        <c:forEach items="${list}" var="tenant" varStatus="rec">
            <div class="img-mutual am-u-sm-4" style="float:left;">
                <div class="box">
                    <img src="http://tenant.efeiyi.com/${tenant.favicon}@!tenant-pc-tenant-list" alt="">
                    <div class="BG"></div>
                    <p class="txt">
                    <div class="img-mutual-text1">
                        <h1>${tenant.fullName}</h1>
                        <p>
                            <a href="http://${tenant.name}.efeiyi.com:${pageContext.request.serverPort}${pageContext.request.contextPath}" target="_blank">
                                <c:forEach items="${tenant.masterProjectList}" var="obj">
                                    <c:if test="${obj.status == '1'}">
                                        <p>[${obj.project.name}]</p>
                                    </c:if>
                                </c:forEach>
                                <p><ming800:status name='level' dataType='Tenant.level' checkedValue='${tenant.level}' type='normal'/>非物质文化遗产传承人</p>
                            </a>
                        </p>
                    </div>
                    </p>
                </div>
                <span class="img-mutual-jump">
                    <a href="http://${tenant.name}.efeiyi.com:${pageContext.request.serverPort}${pageContext.request.contextPath}" target="_blank">
                        深入了解
                    </a></span>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>
