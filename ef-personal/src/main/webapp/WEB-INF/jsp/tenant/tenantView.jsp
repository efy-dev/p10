<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
</head>
<body>
<div id="banner1">
    <div id="full-screen-slider">
        <ul id="slides">
            <li style="background:url(/scripts/assets/images/img4.jpg) no-repeat center top"><a href="#" ></a></li>
            <li style="background:url(/scripts/assets/images/img4.jpg) no-repeat center top"><a href="#" ></a></li>
            <li style="background:url(/scripts/assets/images/img4.jpg) no-repeat center top"><a href="#" ></a></li>
            <li style="background:url(/scripts/assets/images/img4.jpg) no-repeat center top"><a href="#" ></a></li>
        </ul>
    </div>
    <div id="tab">
        <h1>${entity.fullName}</h1>
        <p>${entity.title}</p>
        <dl class="tab-dl">
            <dt><a href="${pageContext.request.contextPath}/tenantIntroduction/listTenantIntroduction.do?conditions=introduction.tenant.id:${entity.id}"><img src="/scripts/assets/images/img5.jpg"></a></dt>
            <dd>${entity.brief}</dd>
        </dl>
        <span><a href="${pageContext.request.contextPath}/tenantIntroduction/listTenantIntroduction.do?conditions=introduction.tenant.id:${entity.id}">了解详细</a></span>
    </div>
</div>

<div id="center">
    <dl class="center-1">
        <dt class="center-1-dt"><a href="${pageContext.request.contextPath}/tenantWork/${tenantWorkList.get(0).id}"><img src="<c:url value="/scripts/assets/images/img1.gif"/>"></a></dt>
        <dd class="center-1-dd"><span><a href="#">大师作品</a></span><span><a href="#">木版水印</a></span><span><a href="#">2015</a></span></dd>
    </dl>
    <dl class="center-2">
        <dt class="center-1-dt"><a href="${pageContext.request.contextPath}/tenantWork/${tenantWorkList.get(1).id}"><img src="<c:url value="/scripts/assets/images/img2.gif"/>"></a></dt>
        <dd class="center-1-dd"><span><a href="#">大师作品</a></span><span><a href="#">木版水印</a></span><span><a href="#">2015</a></span></dd>
    </dl>
    <dl class="center-3">
        <dt class="center-1-dt"><a href="${pageContext.request.contextPath}/tenantWork/${tenantWorkList.get(2).id}"><img src="<c:url value="/scripts/assets/images/img3.gif"/>"></a></dt>
        <dd class="center-1-dd"><span><a href="#">大师作品</a></span><span><a href="#">木版水印</a></span><span><a href="#">2015</a></span></dd>
    </dl>
</div>
<!--内容-->

</body>
</html>
