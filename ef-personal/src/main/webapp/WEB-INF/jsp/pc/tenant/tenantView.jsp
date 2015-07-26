<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<head>
</head>
<body>
<div id="banner1">
    <div id="full-screen-slider">
        <ul id="slides">
            <c:forEach items="${bannerList}" var="banner">
                <li style="background:url(http://tenant.efeiyi.com/${banner.imageUrl}) no-repeat center top;width:100%;height:266px;">
                    <a href="#"></a></li>
            </c:forEach>
        </ul>
    </div>
    <div class="banner-rq">
        <div id="tab">
            <p></p>
            <dl class="tab-dl">
                <dt>
                    <c:if test="${tenant.favicon == null}">
                        <a href="<c:url value="/introduction/intro"/>" target="_blank">
                            <img src="http://tenant.efeiyi.com/${tenant.favicon}@!tenant-pc-favicon"></a>
                    </c:if>
                    <c:if test="${tenant.favicon != null}">
                        <a href="<c:url value="/introduction/intro"/>" target="_blank">
                            <img src="http://tenant.efeiyi.com/${tenant.favicon}@!tenant-pc-favicon"></a>
                    </c:if>
                </dt>
                <dd>
                    <c:choose>
                        <c:when test="${fn:length(tenant.brief)  > 30}">
                            <a href="${pageContext.request.contextPath}/introduction/intro"
                               target="_blank">${fn:substring(tenant.brief,0 ,30 ) }......</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/introduction/intro"
                               target="_blank">${tenant.brief}</a>
                        </c:otherwise>
                    </c:choose>
                </dd>
            </dl>
            <span><a href="${pageContext.request.contextPath}/introduction/intro" target="_blank">了解详细</a></span>
        </div>
    </div>
</div>
<div id="center">
    <c:forEach items="${tenantWorkList}" var="tenantWork" varStatus="work" begin="0" end="2">
        <c:if test="${tenantWorkList != null && tenantWorkList.size() > 0}">
            <dl class="center-${work.index + 1}">
                <dt class="center-1-dt"><a href="<c:url value="/work/${tenantWork.id}"/>" target="_blank"><img
                        src="http://tenant.efeiyi.com/${tenantWork.picture_url}@!tenant-pc-work"></a></dt>
                <dd class="center-1-dd"><span><a href="javascript:void(0);">${tenantWork.name}</a></span>
                    <span><a href="javascript:void(0);">${tenantWork.project.name}</a></span>
                </dd>
            </dl>
        </c:if>
    </c:forEach>
</div>
<!--内容-->

</body>
</html>
