<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix=".efeiyi.com" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
</head>
<body style="background-color:#F1F5F8;">
<header data-am-widget="footer" class="am-footer am-footer-default gather-am-1" data-am-footer="{  }"  style="background-color:#fff;">
    <div class="am-footer-switch">
        <span class="am-footer-ysp" data-rel="mobile" data-am-modal="{target: '#am-switch-mode'}"><a href="http://www.efeiyi.com" target="_blank"><img src="<c:url value='/scripts/assets/wap/images/logo.gif'/>" width="61" height="23"></a></span>
    </div>
    <div class="am-footer-miscs ">
        <p>中国非遗电商平台·传承人官网</p>
    </div>
</header>
<div id="am-footer-modal" class="am-modal am-modal-no-btn am-switch-mode-m am-switch-mode-m-default">
    <div class="am-modal-dialog">
        <div class="am-modal-hd am-modal-footer-hd">
            <a href="javascript:void(0)" data-dismiss="modal" class="am-close am-close-spin "
               data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd">
            <span class="am-switch-mode-owner"></span>
            <span class="am-switch-mode-slogan">中国非遗电商平台·传承人官网</span>
        </div>
    </div>
</div>
<div data-am-widget="slider" class="am-slider am-slider-a1"  data-am-slider='{"directionNav":false}'>
    <ul class="am-slides">
        <li>
            <img src="http://tenant.oss-cn-beijing.aliyuncs.com/index_banner/%E5%A7%9A%E6%83%A0%E8%8A%AC%281%29.jpg">
        </li>
        <li>
            <img src="http://tenant.oss-cn-beijing.aliyuncs.com/index_banner/%E5%BC%A0%E5%90%8C%E7%A6%84%281%29.jpg">
        </li>
        <li>
            <img src="http://tenant.oss-cn-beijing.aliyuncs.com/index_banner/%E6%9C%B1%E7%82%B3%E4%BB%81%282%29.jpg">
        </li>
        <li>
            <img src="http://tenant.oss-cn-beijing.aliyuncs.com/index_banner/%E9%AD%8F%E7%AB%8B%E4%B8%ADbanner%281%29.jpg">
        </li>
    </ul>
</div>
<div data-am-widget="tabs" class="am-tabs am-tabs-default">
    <ul class="am-tabs-nav am-cf am-ing-bg-color">
        <li class="am-active">
            <a href="[data-tab-panel-0]">传统技艺</a>
        </li>
        <li class="">
            <a href="[data-tab-panel-1]">传统美术</a>
        </li>
    </ul>
    <div class="am-tabs-bd">
        <div data-tab-panel-0 class="am-tab-panel am-active am-ing-bg-color">
            <ul data-am-widget="gallery" class="am-gallery am-avg-sm-2
                am-avg-md-3 am-avg-lg-4 am-gallery-overlay">
                <c:forEach items="${skillList}" var="tenant" varStatus="rec">
                    <%--<c:if test="${'1'.equals(tenantProject.project.type)}">--%>
                        <li style="width:50%;" class="am-u-sm-6 am-u-end">
                            <div class="am-gallery-item">
                                <a href="http://${tenant.name}.efeiyi.com:${pageContext.request.serverPort}/${pageContext.request.contextPath}" class="">
                                    <img src="http://tenant.efeiyi.com/${tenant.favicon}@!tenant-pc-tenant-list"/>
                                    <h3 class="am-gallery-title am-text-color-1" style="line-height:15px; font-weight:400;">
                                        <p>${tenant.fullName}</p>
                                        <p style="white-space:nowrap;text-overflow:ellipsis;overflow:hidden;width:120px;">${tenant.brief}</p>
                                    </h3>
                                </a>
                            </div>
                        </li>
                    <%--</c:if>--%>
                </c:forEach>
            </ul>
        </div>
        <div data-tab-panel-1 class="am-tab-panel am-ing-bg-color ">
            <ul data-am-widget="gallery" class="am-gallery am-avg-sm-2
                am-avg-md-2 am-avg-lg-4 am-gallery-overlay">
                <c:forEach items="${artList}" var="tenant" varStatus="rec">
                    <%--<c:if test="${'2'.equals(tenantProject.project.type)}">--%>
                        <li class=" am-u-sm-6 am-u-end ">
                            <div class="am-gallery-item">
                                <a href="http://${tenant.name}.efeiyi.com:${pageContext.request.serverPort}/${pageContext.request.contextPath}" class="">
                                    <img src="http://tenant.efeiyi.com/${tenant.favicon}@!tenant-pc-tenant-list"/>
                                    <h3 class="am-gallery-title am-text-color-1" style="line-height:15px; font-weight:400;">
                                        <p>${tenant.fullName}</p>
                                        <p style="white-space:nowrap;text-overflow:ellipsis;overflow:hidden;width:120px;">${tenant.brief}</p>
                                    </h3>
                                </a>
                            </div>
                        </li>
                    <%--</c:if>--%>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>
</body>
</html>