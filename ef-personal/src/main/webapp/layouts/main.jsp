
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
//        $(document).ready(function(){
//            $.post("", { tenantId: ""},
//                function(data){
//                    process(data);
//                }, "text");
//        })
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
        <li><a href="${pageContext.request.contextPath}/tenant/getTenant/{tenantId}"><img src="<c:url value="/scripts/assets/images/i/nav-sy.gif"/>"></a></li>
        <li><a href="${pageContext.request.contextPath}/tenantIntroduction/tenantIntroductionList.do?conditions=introduction.tenant.id:1"><img src="<c:url value="/scripts/assets/images/i/nav-jj.gif"/>"></a></li>
        <li><a href="${pageContext.request.contextPath}/tenantProduct/tenantProductList.do?tenantId=1"><img src="<c:url value="/scripts/assets/images/i/nav-zp.gif"/>"></a></li>
        <li><a href="${pageContext.request.contextPath}/tenantInfo/tenantInfoList.do?tenantId=1"><img src="<c:url value="/scripts/assets/images/i/nav-zx.gif"/>"></a></li>
        <li><a href="${pageContext.request.contextPath}/tenantWork/getTenantWorkShop.do?tenantId=1"><img src="<c:url value="/scripts/assets/images/i/nav-gzf.gif"/>"></a></li>
    </ul>
</div>
<sitemesh:write property='body'/>
<div id="footer">
    <ul class="guild">
        <li><a href="#"><img src="<c:url value="/scripts/assets/images/i/fybk.jpg"/> "></a></li>
        <li><a href="#"><img src="<c:url value="/scripts/assets/images/i/efeiyi.jpg"/> "></a></li>
        <li><a href="#"><img src="<c:url value="/scripts/assets/images/i/cpb.jpg"/> "></a></li>
        <li><a href="#"><img src="<c:url value="/scripts/assets/images/i/gl.jpg"/> "></a></li>
    </ul>
    <div class="efeiyi-url">Copyright © <a href="#">www.efeiyi.com</a>2015</div>
</div>
<!--分析-->
<div class="floating_ck">
    <dl>
        <dt></dt>
        <dd class="return">
            <span onClick="gotoTop();return false;"></span>
        </dd>
        <dd class="qrcord">
            <span></span>
            <div class="floating_left floating_ewm">
                <i><img src="<c:url value="/scripts/assets/images/images/img6_03.jpg"/> "></i>
            </div>
        </dd>
        <dd class="quote">
            <span>分享</span>
            <div class="floating_left"><a href="#">分享</a></div>
        </dd>


    </dl>
</div>
</body>
</html>
