<!DocType html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>


<div id="header">
    <h1><img src="<c:url value="/scripts/assets/images/logo1.gif"/>" alt="vlogo" class="logov"></h1>
    <div class="printing" style="width: 350px" id="tenantLevel">非物质文化遗产传承人<span>  [<a href="#" id="projectName">${master.getProjectName()}</a>]</span></div>
    <ul class="register">
        <li class="register-page"><a href="#"><img src="<c:url value="/scripts/assets/images/i/wz1.gif"/>"></a></li>
       <%-- <li class="register-left"><a href="#"><img src="<c:url value="/scripts/assets/images/i/wz2.gif"/>"></a></li>
        <li class="register-right"><a href="#"><img src="<c:url value="/scripts/assets/images/i/wz3.gif"/>"></a></li>--%>
    </ul>
</div>
<div id="nav">
    <h1>
        <a href="#">
            <img id="favicon" src="">
        </a>
    </h1>
    <ul class="nav-centent">
        <li><a href="<c:url value="/"/>">首页</a></li>
        <li><a href="<c:url value="/introduction/intro"/>">简介</a></li>
        <li><a href="<c:url value="/work/list"/>">作品</a></li>
        <li><a href="<c:url value="/info/list"/>">资讯</a></li>
        <li><a href="<c:url value="/workShop/work"/>">工作坊</a></li>
    </ul>
</div>
<script>
        $.ajax({
            type: "post",
            url: '<c:url value="/getTenant.do"/>',
            cache: false,
            dataType: "json",
            success: function (data) {
                console.log(data);
                $("#favicon").attr("src","http://tenant.efeiyi.com/"+data.logoUrl+"@!tenant-manage-banner")
//                $("#projectName").html(data.projectName);
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

                $("#tenantLevel").html(levelName+'非物质文化遗产传承人<span>  [<a href="#" id="projectName">'+data.projectName+'</a>]</span>');
            }
        });
</script>