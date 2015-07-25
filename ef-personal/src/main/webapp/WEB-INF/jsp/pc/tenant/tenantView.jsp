<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
</head>
<body>
<div id="banner1">
    <div id="full-screen-slider">
        <ul id="slides">
            <li style="background:url(<c:url value="/scripts/assets/images/1920.jpg"/>) no-repeat center top;width:100%;height:266px;"><a href="#" ></a></li>
            <li style="background:url(<c:url value="/scripts/assets/images/1920.jpg"/>) no-repeat center top;width:100%;height:266px;"><a href="#" ></a></li>
            <li style="background:url(<c:url value="/scripts/assets/images/1920.jpg"/>) no-repeat center top;width:100%;height:266px;"><a href="#" ></a></li>
            <li style="background:url(<c:url value="/scripts/assets/images/1920.jpg"/>) no-repeat center top;width:100%;height:266px;"><a href="#" ></a></li>
        </ul>
    </div>
    <div class="banner-rq">
        <div id="tab">
            <p></p>
            <dl class="tab-dl">
                <dt><a href="${pageContext.request.contextPath}/introduction/listTenantIntroduction.do?conditions=introduction.tenant.id:${tenant.id}" target="_blank"><img src="<c:url value="/scripts/assets/images/img5.jpg"/>"></a></dt>
                <dd>
                    <c:choose>
                        <c:when test="${fn:length(tenant.brief)  > 30}">
                        <a href="${pageContext.request.contextPath}/introduction/listTenantIntroduction.do?conditions=introduction.tenant.id:${tenant.id}" target="_blank">${fn:substring(tenant.brief,0 ,30 ) }......</a>
                        </c:when>
                        <c:otherwise>
                        <a href="${pageContext.request.contextPath}/introduction/listTenantIntroduction.do?conditions=introduction.tenant.id:${tenant.id}" target="_blank">${tenant.brief}</a>
                        </c:otherwise>
                    </c:choose>
                </dd>
            </dl>
            <span><a href="${pageContext.request.contextPath}/introduction/listTenantIntroduction.do?conditions=introduction.tenant.id:${tenant.id}" target="_blank">了解详细</a></span>
        </div>
    </div>
</div>
<div id="center">
    <c:forEach items="${tenantWorkList}" var="tenantWork" varStatus="work" begin="0" end="2">
        <c:if test="${tenantWorkList != null && tenantWorkList.size() > 0}">
            <dl class="center-${work.index + 1}">
                <dt class="center-1-dt"><a href="${pageContext.request.contextPath}/work/${tenantWork.id}" target="_blank"><img src="<c:url value="/scripts/assets/images/img1.gif"/>"></a></dt>
                <dd class="center-1-dd"><span><a href="javascript:void(0);">大师作品</a></span><span><a href="javascript:void(0);">木版水印</a></span><span><a href="javascript:void(0);">2015</a></span></dd>
            </dl>
        </c:if>
    </c:forEach>
</div>
<!--内容-->

</body>
</html>
