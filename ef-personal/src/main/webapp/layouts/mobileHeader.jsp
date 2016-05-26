<!DocType html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<header data-am-widget="header" class="am-header am-header-default">
    <div class="am-header-left am-header-nav">
        <a href="#left-link" class="">
        </a>
    </div>
    <h1 class="am-header-title">
        <a href="<c:url value="/index"/>" class="">e飞蚁—传承人官网</a>
    </h1>
    <div class="am-header-right am-header-nav">
        <a href="#right-link" class="">
        </a>
    </div>
</header>
<div class="am-border-1"></div>
<nav id="am-nav-1">
    <div class="am-bg-tp" id="backgroundUrl" style="background:url(http://tenant.efeiyi.com/${tenant.backgroundUrl}@!tenant-mobile-view-background);background-size: 100% 100%;"></div>
    <div class="am-xu-nav">
        <div id="favicon" style="background:url(http://tenant.efeiyi.com/${tenant.favicon}@!tenant-mobile-view-icon);background-size:100% 100%;" alt="传承人" class="am-img-thumbnail am-circle"></div>
        <p id="am-mg-14">${tenant.fullName}</p>
        <p id="projectName"></p>
        <p ><span id="levelName"></span><img src="<c:url value="/scripts/assets/wap/images/logo2.gif"/>" class="am-page-img"></p>
        <p id="am-bd-2"><a href="<c:url value="/"/>" class="p-a" id="p-a">首页<span class="am-bd-2"></span></a><a href="<c:url value="/introduction/intro"/>" class="p-a">简介<span class="am-bd-2"></span></a><a href="<c:url value="/work/list"/>" class="p-a">作品<span class="am-bd-2"></span></a><a href="<c:url value="/info/list"/>" class="p-a">资讯<span  class="am-bd-2"></span></a><a href="<c:url value="/workShop/work"/>" class="p-a">工作坊</a></p>
    </div>
</nav>

<script>
        $.ajax({
            type: "post",
            url: '<c:url value="/getTenant.do"/>',
            cache: false,
            dataType: "json",
            success: function (data) {
                console.log(data);
/*                $("#favicon").attr("src","http://tenant.efeiyi.com/"+data.logoUrl+"@!tenant-manage-banner")*/
                $("#backgroundUrl").attr({
                    style:"background:url(http://tenant.efeiyi.com/"+data.backgroundUrl+"@!tenant-mobile-view-background);"
                });
                $("#favicon").attr({
                    style:"background:url(http://tenant.efeiyi.com/"+data.favicon+"@!tenant-mobile-view-icon);"
                });
                $("#projectName").html(data.projectName);
                var levelName = "";
                if(data.level=="1"){
                    levelName = "国家级";
                }
                if(data.level=="2"){
                    levelName = "省级";
                }
                if(data.level=="3"){
                    levelName = "市级";
                }
                if(data.level=="4"){
                    levelName = "县级";
                }

                $("#levelName").html(levelName+'非物质文化遗产传承人');
            }
        });
</script>
