<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
</head>
<body>
<div id="banner1">
    <div id="full-screen-slider">
        <ul id="slides">
            <li style="background:url(<c:url value="/scripts/assets/images/1920.jpg"/>) no-repeat center top"><a href="#" ></a></li>
            <li style="background:url(<c:url value="/scripts/assets/images/1920.jpg"/>) no-repeat center top"><a href="#" ></a></li>
            <li style="background:url(<c:url value="/scripts/assets/images/1920.jpg"/>) no-repeat center top"><a href="#" ></a></li>
            <li style="background:url(<c:url value="/scripts/assets/images/1920.jpg"/>) no-repeat center top"><a href="#" ></a></li>
        </ul>
    </div>
    <div class="banner-rq">
        <div id="tab">
            <h1>${entity.fullName}</h1>
            <p>${entity.title}</p>
            <dl class="tab-dl">
                <dt><a href="${pageContext.request.contextPath}/tenantIntroduction/listTenantIntroduction.do?conditions=introduction.tenant.id:${entity.id}"><img src="<c:url value="/scripts/assets/images/img5.jpg"/>"></a></dt>
                <dd>${entity.brief}</dd>
            </dl>
            <span><a href="${pageContext.request.contextPath}/tenantIntroduction/listTenantIntroduction.do?conditions=introduction.tenant.id:${entity.id}">了解详细</a></span>
        </div>
    </div>
</div>

<div id="center">
    <c:forEach items="${tenantWorkList}" var="tenantWork" varStatus="work" begin="0" end="2">
        <c:if test="${tenantWorkList != null && tenantWorkList.size() > 0}">
            <dl class="center-${work.index + 1}">
                <dt class="center-1-dt"><a href="${pageContext.request.contextPath}/tenantWork/${tenantWork.id}"><img src="<c:url value="/scripts/assets/images/img1.gif"/>"></a></dt>
                <dd class="center-1-dd"><span><a href="javascript:void(0);">大师作品</a></span><span><a href="javascript:void(0);">木版水印</a></span><span><a href="javascript:void(0);">2015</a></span></dd>
            </dl>
        </c:if>
    </c:forEach>
</div>
<!--内容-->

</body>
</html>
