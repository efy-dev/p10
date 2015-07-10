<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/24
  Time: 17:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>--%>
<html class="no-js">
<head>
    <title>首页</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Amaze UI Admin index Examples</title>
    <meta name="description" content="这是一个 index 页面">
    <meta name="keywords" content="index">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="icon" type="image/png" href="../scripts/assets/i/favicon.png">
    <link rel="apple-touch-icon-precomposed" href="../scripts/assets/i/app-icon72x72@2x.png">
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <link rel="stylesheet" href="../scripts/assets/css/amazeui.min.css"/>
    <link rel="stylesheet" href="../scripts/assets/css/admin.css">
    <script src="<c:url value='../scripts/assets/js/jquery.min.js'/>"></script>
    <script src="<c:url value='../scripts/assets/js/amazeui.min.js'/>"></script>
    <decorator:head/>
    <style>
        .efy-active {
            background-color: #9a9a9a;
        }
    </style>
</head>
<body>
<header class="am-topbar admin-header">
    <div class="am-topbar-brand">
        <strong>Amaze UI</strong>
        <small>后台管理模板</small>
    </div>

    <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only"
            data-am-collapse="{target: '#topbar-collapse'}"><span class="am-sr-only">导航切换</span> <span
            class="am-icon-bars"></span></button>

    <div class="am-collapse am-topbar-collapse" id="topbar-collapse">

        <c:if test="${jmenu.children.size()>1}">
            <ul class="am-nav am-nav-pills am-topbar-nav am-topbar-left admin-header-list">
                <c:forEach items="${jmenu.children}" var="jmenuNode">
                    <li>
                        <c:if test="${jnode.contain(requestScope.qm)&& jnode.getRootFather.id==jmenuNode.id}">
                            <a class="efy-active"
                               href="http://<%=request.getServerName()+':'+request.getServerPort()%>/main.do${jnode.url}">${jnode.text_zh_CN}</a>
                        </c:if>
                        <c:if test="${!jnode.contain(requestScope.qm)|| jnode.getRootFather.id!=jmenuNode.id}">
                            <a href="http://<%=request.getServerName()+':'+request.getServerPort()%>/main.do${jnode.url}">${jnode.text_zh_CN}</a>
                        </c:if>
                    </li>
                </c:forEach>
            </ul>
        </c:if>


        <ul class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list">
            <li><a href="javascript:;"><span class="am-icon-envelope-o"></span> 收件箱 <span
                    class="am-badge am-badge-warning">5</span></a></li>
            <li class="am-dropdown" data-am-dropdown="">
                <a class="am-dropdown-toggle" data-am-dropdown-toggle="" href="javascript:;">
                    <span class="am-icon-users"></span> 管理员 <span class="am-icon-caret-down"></span>
                </a>
                <ul class="am-dropdown-content">
                    <li><a href="#"><span class="am-icon-user"></span> 资料</a></li>
                    <li><a href="#"><span class="am-icon-cog"></span> 设置</a></li>
                    <li><a href="#"><span class="am-icon-power-off"></span> 退出</a></li>
                </ul>
            </li>
            <li class="am-hide-sm-only"><a href="javascript:;" id="admin-fullscreen"><span
                    class="am-icon-arrows-alt"></span> <span class="admin-fullText">开启全屏</span></a></li>
        </ul>

    </div>
</header>

<div class="am-cf admin-main">
    <!-- sidebar start -->
    <div class="admin-sidebar am-offcanvas" id="admin-offcanvas">
        <div class="am-offcanvas-bar admin-offcanvas-bar">
            <ul class="am-list admin-sidebar-list">
                <c:forEach items="${jnode.children}" var="childJnode">
                    <c:if test="${!empty childJnode.children&& childJnode.children.size()>0}">
                        <li class="admin-parent">
                            <a class="am-cf" data-am-collapse="{target: '#${childJnode.id}'}"><span
                                    class="am-icon-file"></span> ${childJnode.text_zh_CN} <span
                                    class="am-icon-angle-right am-fr am-margin-right"></span></a>
                            <ul class="am-list am-collapse admin-sidebar-sub am-in" id="${childJnode.id}">
                                <c:forEach items="${childJnode.children}" var="childchildJnode">
                                    <li>
                                        <c:if test="${!empty requestScope.qm && childchildJnode.contain(requestScope.qm)}">
                                            <a href="${childchildJnode.url}&menuId=${requestScope.menuId}"
                                               class="am-cf efy-active">${childchildJnode.text_zh_CN}</a>
                                        </c:if>
                                        <c:if test="${empty requestScope.qm || !childchildJnode.contain(requestScope.qm)}">
                                            <a href="${childchildJnode.url}&menuId=${requestScope.menuId}"
                                               class="am-cf">${childchildJnode.text_zh_CN}</a>
                                        </c:if>
                                    </li>
                                </c:forEach>
                            </ul>
                        </li>
                    </c:if>
                    <c:if test="${empty childJnode.children}">
                        <c:if test="${empty requestScope.qm || !childchildJnode.contain(requestScope.qm)}">
                            <li><a href="${childJnode.url}"></span> ${childJnode.text_zh_CN}</a></li>
                        </c:if>
                        <c:if test="${!empty requestScope.qm && childchildJnode.contain(requestScope.qm)}">
                            <li><a class="efy-active" href="${childJnode.url}"></span> ${childJnode.text_zh_CN}</a></li>
                        </c:if>
                    </c:if>
                </c:forEach>
            </ul>
            <div class="am-panel am-panel-default admin-sidebar-panel">
                <div class="am-panel-bd">
                    <p><span class="am-icon-bookmark"></span> 公告</p>

                    <p>时光静好，与君语；细水流年，与君同。—— Amaze UI</p>
                </div>
            </div>
            <div class="am-panel am-panel-default admin-sidebar-panel">
                <div class="am-panel-bd">
                    <p><span class="am-icon-tag"></span> wiki</p>

                    <p>Welcome to the Amaze UI wiki!</p>
                </div>
            </div>
        </div>
    </div>

    <div class="admin-content">
        <decorator:body/>
    </div>

</div>

<a href="#" class="am-icon-btn am-icon-th-list am-show-sm-only admin-menu"
   data-am-offcanvas="{target: '#admin-offcanvas'}"></a>

<footer>
    <hr>
    <p class="am-padding-left">© 2014 AllMobilize, Inc. Licensed under MIT license.</p>
</footer>

</body>

</html>
