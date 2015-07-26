<!DocType html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="header">
    <h1><img src="<c:url value="/scripts/assets/images/logo1.gif"/>" alt="vlogo" class="logov"></h1>
    <div class="printing">${tenant.title}<span>  [<a href="#">木板水印</a>]</span></div>
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
        <li><a href="<c:url value="/tenant/ten"/>">首页</a></li>
        <li><a href="<c:url value="/introduction/intro"/>">简介</a></li>
        <li><a href="<c:url value="/work/listTenantWork"/>">作品</a></li>
        <li><a href="<c:url value="/info/listTenantInfo"/>">资讯</a></li>
        <li><a href="<c:url value="/workShop/work"/>">工作坊</a></li>
    </ul>
</div>
<script>
        $.ajax({
            type: "get",
            url: '<c:url value="/tenant/getTenant.do"/>',
            cache: false,
            dataType: "json",
            success: function (data) {
                console.log(data);
                $("#favicon").attr("src","http://tenant.efeiyi.com/"+data.logoUrl+"@!tenant-manage-banner")
            }
        });
</script>