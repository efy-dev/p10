<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@include file="/layouts/public.jsp" %>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>移动端详情页真伪</title>
    <!-- Set render engine for 360 browser -->
    <meta name="renderer" content="webkit">
    <!-- No Baidu Siteapp-->
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="icon" type="image/png" href="<c:url value='/images/pal_icon.png'/>">
    <!-- Add to homescreen for Chrome on Android -->
    <meta name="mobile-web-app-capable" content="yes">
    <link rel="icon" sizes="192x192" href="<c:url value='/resources/assets/i/app-icon72x72@2x.png'/>">
    <!-- Add to homescreen for Safari on iOS -->
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <link rel="apple-touch-icon-precomposed" href="<c:url value='/resources/assets/i/app-icon72x72@2x.png'/>">
    <!-- Tile icon for Win8 (144x144 + tile color) -->
    <meta name="msapplication-TileImage" content="<c:url value='/resources/assets/i/app-icon72x72@2x.png'/>">
    <meta name="msapplication-TileColor" content="#0e90d2">
    <link rel="stylesheet" href="<c:url value='/css/amazeui.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/app.css'/>">
</head>
<body class="bgf7">
<header data-am-widget="header" class="am-header am-header-default">
    <h1 class="am-header-title">诚品宝-非遗商品防伪溯源系统</h1>
</header>
<!--//End--header-->
<article class="eslite">
    <div class="am-paragraph-default">
        <c:if test="${result.authenticity != -1}">
            <div class="imglogo"><img src="<%=imgBasePath%><c:url value='${product.logo}@!'/><%= picForm%>"/></div>
        </c:if>
        <div class="tips">${result.msg}</div>
    </div>
    <!--//End-->
    <c:if test="${result.authenticity != -1}">
        <div class="am-paragraph-default">
            <div class="title">${product.name}</div>
            <div class="infolist">
                <ul>
                    <li><strong>非遗项目：</strong>

                        <p>${product.productSeries.name}</p></li>
                    <li><strong>商户名称：</strong>

                        <p>${product.tenant.name}</p></li>
                    <li><strong>创作年代：</strong>

                        <p><fmt:formatDate value="${product.madeYear}" pattern="yyyy年MM月"/></p></li>
                </ul>
            </div>
        </div>
        <!--//End-->
        <c:if test="${result.authenticity == 1}">
            <div class="am-paragraph-default">
                <div class="infoitem">
                    <ul>
                        <li><a href="<c:url value='/viewCertificate.do?code=${code}'/>">认证信息</a></li>
                        <li><a href="<c:url value='/viewProduct.do?code=${code}'/>">商品信息</a></li>
                        <li><a href="<c:url value='/viewSource.do?code=${code}'/>">溯源信息</a></li>
                            <%--<li><a href="#">DNA鉴定信息</a></li>--%>
                    </ul>
                </div>
            </div>
            <!--//End-->
            <c:if test="${not empty product.shoppingUrl}">
                <div class="am-list-news-ft"><a class="am-list-news-more am-btn am-btn-default"
                                                href="${product.shoppingUrl}">立即购买</a></div>
            </c:if>
        </c:if>
    </c:if>
</article>

<script src="<c:url value='/resources/assets/js/jquery.min.js'/>"></script>
<script src="<c:url value='/js/amazeui.min.js'/>"></script>
<script type="text/javascript">
    $(function () {
        $('.am-slider-manual').flexslider({
            // options
        });
    });
    <c:if test="${result.authenticity != -1}">
    var url = "http://api.map.baidu.com/location/ip?ak=zKrEDoOM6VCNjYDcBgpufSWR&ip=" + "${ip}";
    //  var url = "http://api.map.baidu.com/location/ip?ak=zKrEDoOM6VCNjYDcBgpufSWR";
    $.ajax({
        type: "get",
        url: url,
        cache: false,
        dataType: "jsonp",
        jsonp: "callback",
        jsonpCallback: "jsonpCallback",
        success: jsonpCallback,
        error: jsonpCallback2,
    });
    function jsonpCallback(data) {
//        alert("success");
        var ipAddressDiv = document.getElementById("ipAddress");
        if (data.status == 0) {
            var text = data.address.split("|");
            ipAddressDiv.innerHTML = "上次验证地点：" + text[0] + " " + text[1] + " " + text[2];
//            alert(ipAddressDiv.innerHTML);
        } else {
            ipAddressDiv.innerHTML = "上次验证地点：未知";
        }
    }
    function jsonpCallback2(error) {
        alert("failed");
        var ipAddressDiv = document.getElementById("ipAddress");
        ipAddressDiv.innerText = error;
    }
    </c:if>

    <c:if test="${result.isTimeLimited}">
    window.onload = function () {
        setTimeout("autoClose()", ${result.timeLimit});
    }

    function autoClose() {
        var userAgent = navigator.userAgent;
        <%--alert(userAgent);--%>
        <%--if (userAgent.indexOf("Firefox") != -1--%>
        <%--|| userAgent.indexOf("Chrome") != -1) {--%>
        <%--location.href = "<c:url value='/500.jsp'/>";--%>
        <%--//            window.open(href,"_self","");--%>
        <%--//            window.close();--%>
        <%--} else {--%>
        <%--window.opener = null;--%>
        <%--window.open("", "_self");--%>
        <%--window.close();--%>
        <%--}--%>
        location.href = "<c:url value='/index.jsp'/>";
    }
    </c:if>
</script>
</body>
</html>
