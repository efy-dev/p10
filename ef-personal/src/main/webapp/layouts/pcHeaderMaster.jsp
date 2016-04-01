<!DocType html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.efeiyi.ec.personal.AuthorizationUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>

<div class="topbar wh" data-am-sticky>
    <div class="hd">
        <ul class="ul-item">
            <div class="bd logined"></div>
            <li>
                <%if(AuthorizationUtil.getMyUser()!=null && AuthorizationUtil.getMyUser().getId() != null){ %>
                <strong><%=AuthorizationUtil.getMyUser().getUsername()%></strong><a href="<c:url value='/j_spring_cas_security_logout'/>">退出</a></li>
            <% } %>
            <%if(AuthorizationUtil.getMyUser()==null || AuthorizationUtil.getMyUser().getId() == null){ %>
            <li><a href="<c:url value='/sso.do'/>" title="登录">请登录</a></li>
            <li><a href="http://passport.efeiyi.com/register?service=http://master.efeiyi.com/ef-person//sso.do" title="快速注册">快速注册</a></li>
            <% } %>
            <li class="btn-top-wechat">
                <a title="手机e飞蚁">手机e飞蚁</a>
                <span class="top-wechat"></span>
            </li>
        </ul>
    </div>
</div>
<!-- //End--topbar-->
<div class="header wh">
    <div class="hd">
        <div class="logo"><a class="icon" href="" target="_blank" title="e飞蚁-爱非遗"></a></div>
        <div class="nav">
            <ul>
                <%--<li><a href="http://www2.efeiyi.com" title="首页">首页</a></li>--%>
                <li><a href="http://craft.efeiyi.com/ef-wiki/pc/index.do" title="工艺">工艺</a></li>
                <li><a href="http://master.efeiyi.com" title="传承人">大师</a></li>
            </ul>
        </div>
    </div>
</div>

