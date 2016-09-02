<%@ page import="com.ming800.core.p.PConst" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>内容频道-工艺详情</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
</head>
<body>
<header id="header" class="am-header custom-header newheader">
    <div class="logo"><img src="<c:url value="/scripts/images/ef-logo-craft.png"/>" height="27" width="110"
                           align="center" alt=""></div>

    <div class="am-header-right am-header-nav">
        <a href="#chevron-right" class="chevron-right" id="menu">
            <i class="line"></i>
        </a>
    </div>
    <div class="menu-list">
        <ul class="bd">
            <li><a href="<c:url value="/minglu"/>" title="首页">首页</a></li>
            <li><a href="http://<%=PConst.WEBSITE_HOST%>" title="购物车">非遗商城</a></li>
            <li><a href="http://master.efeiyi.com" title="个人中心">非遗大师</a></li>
        </ul>
    </div>
</header>

<div class="craft">
    <div class="dt">
        <h1>${artistry.name}</h1>
        <p>[<ming800:status name="level" dataType="Project.level" checkedValue="${artistry.getLevel()}" type="normal"/>]非物质文化遗产传承项目</p>
        <p>${artistry.project.addressDistrict.name}</p>
    </div>
    <!--//End--传统技艺-->
    <div data-am-widget="tabs" class="am-tabs tabs">
        <ul class="am-tabs-nav nav bgfff">
            <li class="am-active"><a href="[data-tab-panel-0]">技艺介绍</a></li>
            <li class=""><a href="[data-tab-panel-1]">作品</a></li>
            <li class=""><a href="[data-tab-panel-2]">大师</a></li>
        </ul>
        <div class="am-tabs-bd items">
            <div data-tab-panel-0 class="am-tab-panel am-active">
                ${artistry.artistryDescription.descriptionWap}
            </div>
            <!--//End--技艺介绍-->
            <div data-tab-panel-2 class="am-tab-panel">
                <ul class="ul-col-2">
                    <c:forEach items="${masterWorkList}" var="masterWork">
                        <li>
                            <a href="<c:url value="/minglu/masterWork/${masterWork.id}"/>" title="">
                                <img src="http://tenant.efeiyi.com/${masterWork.pictureUrl}@!wiki-work-picture" alt="">
                                <span class="txt">
                                <p>${masterWork.name}</p>
                            </span>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <!--//End--作品-->
            <div data-tab-panel-1 class="am-tab-panel">
                <ul class="ul-col-2">
                    <c:forEach items="${masterProjectList}" var="masterProject">
                        <li>
                            <a href="http://${masterProject.master.name}.efeiyi.com" title="">
                                <img src="http://tenant.efeiyi.com/${masterProject.master.favicon}@!wiki-tenant-picture"
                                     alt="">
                                <span class="txt">
                                <p>${masterProject.master.fullName}</p>
                                <p>${masterProject.project.name}</p>
                                <p<ming800:status name="level" dataType="Project.level"
                                                  checkedValue="${masterProject.project.level}" type="normal"/>传承人</p>
                            </span>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <!--//End--大师-->
        </div>
    </div>
    <!--//End---->
</div>
</body>
</html>