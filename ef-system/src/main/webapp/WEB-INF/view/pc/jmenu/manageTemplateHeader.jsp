<%@ page import="com.efeiyi.ec.system.organization.util.AuthorizationUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/10
  Time: 15:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<header class="am-topbar admin-header">
    <div class="am-topbar-brand">
        <h1 style="margin-bottom: 0px">e飞蚁后台管理系统&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h1>
    </div>

    <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only"
            data-am-collapse="{target: '#topbar-collapse'}"><span class="am-sr-only">导航切换</span> <span
            class="am-icon-bars"></span></button>

    <div class="am-collapse am-topbar-collapse" id="topbar-collapse">

        <c:if test="${jmenu.children.size()>1}">
            <ul class="am-nav am-nav-pills am-topbar-nav am-topbar-left admin-header-list">
                <c:forEach items="${jmenu.children}" var="jmenuNode">
                    <security:authorize ifAnyGranted="${jmenuNode.access}">
                        <li>
                            <a class="${jmenuNode.jnodeMatch('efy-active',jnode)}"
                               href="<c:url value="${jmenuNode.url}"/>">${jmenuNode.text_zh_CN}</a>
                        </li>
                    </security:authorize>
                </c:forEach>
            </ul>
        </c:if>


        <ul class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list">
            <%
                if (AuthorizationUtil.getMyUser().getId() != null) {
            %>

            <li class="am-hide-sm-only"><a href="<c:url value="/j_spring_security_logout"/>" id="admin-fullscreen"><span
                    class="am-icon-power-off"></span> <span class="admin-fullText">退出系统</span></a></li>

            <%
                }
            %>
        </ul>

    </div>
</header>
