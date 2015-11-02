<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/24
  Time: 11:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html class="no-js">
<head>
    <title>非遗协会</title>
</head>
<body>
<div class="wh home">
    <div class="hd">
        <div class="slide-left">
            <jsp:include flush="true" page="/home/homeBanner.do?qm=listPCBanner_default"/>
            <%-- 轮播图 --%>
            <div class="wh list-box">
                <jsp:include flush="true" page="/home/homeIndustryNews.do?qm=plistNewsIndustry_industry"/>
                <%-- 行业新闻 --%>
                <jsp:include flush="true" page="/home/homeNoteNews.do?qm=plistNewsNote_industry"/>
                <%-- 新闻公告 --%>
            </div>

            <jsp:include flush="true" page="/project/project.home.list.do?qm=plistProject_default"/>
            <%-- 非遗名录 --%>
            <jsp:include flush="true"
                         page="/protection/protection.homeList.do?qm=plistPolicy_default&jmenuId=AssociationMenu"/>
            <%-- 资料下载 --%>
        </div>
        <%-- 页面左部 --%>
        <div class="slider-right">
            <jsp:include flush="true" page="/home/homeOrgNews.do?qm=plistNewsOrganization_organization"/>
            <%-- 协会新闻 --%>
            <div class="part">
                <div class="title">在线服务</div>
                <ul class="ul-list-btn">
                    <li>
                        <a href="<c:url value='/protection/protection.declare.do?qm=plistMaterial_default'/>"
                           title="在线申报">
                            <i class="icon icon-1"></i>在线申报
                        </a>
                    </li>
                    <li>
                        <a href="<c:url value='/project/project.do?qm=plistProject_default&provinceid=-1&type=-1'/>"
                           title="非遗名录">
                            <i class="icon icon-2"></i>非遗名录
                        </a>
                    </li>
                    <li>
                        <a href="<c:url value='/protection/protection.list.do?qm=plistPolicy_default" title="政策法规'/>">
                            <i class="icon icon-3"></i>政策法规</a>
                    </li>
                    <li>
                        <a href="<c:url value='/organization/organization.committee.do?qm=plistCommitteeAssociation_default'/>"
                           title="下属机构">
                            <i class="icon icon-4"></i>下属机构</a>
                    </li>
                </ul>
            </div>
            <%-- 在线服务 --%>
            <jsp:include flush="true" page="/home/homeMaster.do?qm=plistMaster_master"/>
            <%-- 非遗传承人 --%>
        </div>
        <%-- 页面右部 --%>
    </div>
</div>
<script type="text/javascript">
    function homeMatchJNodes(id, matchJNode, currentJNode) {
        var jMenu = document.getElementById("jmenu").value;
        var url = ' <c:url value="/view/newView.do"/>' + "?id=" + id + "&jmenu=" + jMenu + "&currentJnode=" + currentJNode + "&matchJnode=" + matchJNode;
        window.location = url;
    }
</script>
</body>
</html>
