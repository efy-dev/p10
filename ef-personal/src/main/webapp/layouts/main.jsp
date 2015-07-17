
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="../scripts/assets/css/amazeui.min.css">
    <link rel="stylesheet" type="text/css" href="../scripts/assets/css/app.css">
    <link rel="stylesheet" type="text/css" href="../scripts/assets/css/style.css">
    <link href="../scripts/assets/css/jquery.jslides.css" rel="stylesheet" type="text/css" />
    <script src="../scripts/assets/js/jquery.min.js"></script>
    <script src="../scripts/assets/js/jquery.jslides.js"></script>
    <script src="../scripts/assets/js/amazeui.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            $.post("", { tenantId: ""},
                function(data){
                    process(data);
                }, "text");
        })
    </script>
    <sitemesh:write property='head'/>
</head>
<body>
<div id="header">
    <h1><img src="<c:url value="/scripts/assets/images/logo1.gif"/>" alt="vlogo" class="logov"></h1>
    <div class="printing">国家级非物质文化遗产传承人<span>  [<a href="#">木板水印</a>]</span></div>
    <ul class="register">
        <li class="register-page"><a href="#"><img src="<c:url value="/scripts/assets/images/i/wz1.gif"/>"></a></li>
        <li class="register-left"><a href="#"><img src="<c:url value="/scripts/assets/images/i/wz2.gif"/>"></a></li>
        <li class="register-right"><a href="#"><img src="<c:url value="/scripts/assets/images/i/wz3.gif"/>"></a></li>
    </ul>
</div>
<div id="nav">
    <h1><a href="#"><img src="<c:url value="/scripts/assets/images/logo2.gif"/>"></a></h1>
    <ul class="nav-centent">
        <li><a href="${pageContext.request.contextPath}/tenant/getTenant.do?tenantId=1"><img src="<c:url value="/scripts/assets/images/i/nav-sy.gif"/>"></a></li>
        <li><a href="${pageContext.request.contextPath}/tenant/tenantIntroductionList.do?tenantId=1"><img src="<c:url value="/scripts/assets/images/i/nav-jj.gif"/>"></a></li>
        <li><a href="${pageContext.request.contextPath}/tenant/tenantProductList.do?tenantId=1"><img src="<c:url value="/scripts/assets/images/i/nav-zp.gif"/>"></a></li>
        <li><a href="${pageContext.request.contextPath}/tenant/tenantInfoList.do?tenantId=1"><img src="<c:url value="/scripts/assets/images/i/nav-zx.gif"/>"></a></li>
        <li><a href="${pageContext.request.contextPath}/tenant/getTenantWorkShop.do?tenantId=1"><img src="<c:url value="/scripts/assets/images/i/nav-gzf.gif"/>"></a></li>
    </ul>
</div>
<sitemesh:write property='body'/>
</body>
</html>
