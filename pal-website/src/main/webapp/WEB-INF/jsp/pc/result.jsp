<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/30
  Time: 15:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>真伪查询终</title>
    <!-- Set render engine for 360 browser -->
    <meta name="renderer" content="webkit">
    <!-- No Baidu Siteapp-->
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="icon" type="image/png" href="<c:url value='resources/assets/i/favicon.png'/>">
    <!-- Add to homescreen for Chrome on Android -->
    <meta name="mobile-web-app-capable" content="yes">
    <link rel="icon" sizes="192x192" href="<c:url value='resources/assets/i/app-icon72x72@2x.png'/>">
    <!-- Add to homescreen for Safari on iOS -->
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <link rel="apple-touch-icon-precomposed" href="<c:url value='resources/assets/i/app-icon72x72@2x.png'/>">
    <!-- Tile icon for Win8 (144x144 + tile color) -->
    <meta name="msapplication-TileImage" content="<c:url value='resources/assets/i/app-icon72x72@2x.png'/>">
    <meta name="msapplication-TileColor" content="#0e90d2">
    <link rel="stylesheet" href="<c:url value='resources/css/amazeui.min.css'/>">
    <link rel="stylesheet" href="<c:url value='resources/css/app.css'/>">
</head>
<body>
<div class="search-home search-list">
    <div class="logo">
        <h1><a href="#"><img src="<c:url value='resources/images/logo.png'/>"/></a></h1>
    </div>
    <form action="" method="post">
        <div class="title"><a class="active">真伪查询</a><span class="line"></span><a>非遗搜</a></div>
        <%--<label for="">--%>
            <input class="txt" type="text" name="" id="serial" value="" placeholder="请输入名称查询,如:”苏绣”"/>
            <input class="btn" type="button" value="查 询"  onclick="checkLabel()"/>
        <%--</label>--%>
    </form>
</div>
<!--//End--search-list-->
<div class="hd">
    <div class="search-result">
        <h1>基本信息</h1>

        <div class="item item2">
            <a class="img" href=""><img src="${product.imgUrl}" width="395" height="500"/></a>
            <ul>
                <li class="title">
                    <strong>${result.msg}</strong>
                    <c:if test="${product != null}">
                    <a href="" title="奖励您100积分，点击领取。">奖励您100积分，点击领取。</a>
                </li>
                <li><span>证书编号: 140522398541258</span></li>
                <li>名称: ${product.name}</li>
                <li>作者: ${product.productSeries.tenant.name}</li>
                <li>创作年代: <fmt:formatDate value="${product.madeYear}" pattern="yyyy年MM月"/></li>
                <li>认证时间: 2015年5月</li>
                <li>类别: ${product.productSeries.name}</li>
                <c:forEach items="${product.productSeries.productSeriesPropertyNameList}" var="propertyName"  varStatus="status">
                    <li >${propertyName.name}:${propertyName.productPropertyValue.value}</li>
                </c:forEach>
            </ul>
        </div>

        <!--//End-->
        <div class="item-info">
            <h2>认证信息</h2>

            <div class="row">
                <table>
                    <tr>
                        <td width="345">认证证书</td>
                        <td width="377">简介</td>
                        <td width="315">证书查看</td>
                    </tr>
                    <tr>
                        <td>非遗传承人证书</td>
                        <td>国家级非遗传承人</td>
                        <td><a href="${product.tenantCertification.imgUrl}" title="查看证书">查看证书</a></td>
                    </tr>
                    <tr>
                        <td>传承项目认证</td>
                        <td>国家级非物质文化遗产项目</td>
                        <td><a href="${product.tenantCertification.imgUrl}" title="查看证书">查看证书</a></td>
                    </tr>
                    <tr>
                        <td>其他获奖证书</td>
                        <td>中国工艺美术大师</td>
                        <td><a href="${product.tenantCertification.imgUrl}" title="查看证书">查看证书</a></td>
                    </tr>
                </table>
            </div>
        </div>
        <!--//End--认证信息-->
        <div class="item-info">
            <h2>溯源信息</h2>

            <div class="row">
                <table>
                    <tr>
                        <td width="345">溯源信息</td>
                        <td width="377">简介</td>
                        <td width="315">内容查看</td>
                    </tr>
                    <tr>
                        <td>创作现场大图</td>
                        <td>大师创作现场图，2006-06-01</td>
                        <td><a href="" title="查看溯源图片">查看溯源图片</a></td>
                    </tr>
                    <tr>
                        <td>传承人视频</td>
                        <td>大师创作现场图，2006-06-01</td>
                        <td><a href="" title="查看溯源图片">查看溯源图片</a></td>
                    </tr>
                    <tr>
                        <td>文本信息</td>
                        <td>苏绣传承历史</td>
                        <td><a href="" title="查看溯源图片">查看溯源图片</a></td>
                    </tr>
                </table>
            </div>
        </div>
        <!--//End--溯源信息-->
    </div>
</div>
</c:if>
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="<c:url value='resources/assets/js/jquery.min.js'/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="<c:url value='http://libs.baidu.com/jquery/1.11.3/jquery.min.js'/>"></script>
<script src="<c:url value='http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js'/>"></script>
<script src="<c:url value='resources/assets/js/amazeui.ie8polyfill.min.js'/>"></script>
<![endif]-->
<script src="<c:url value='resources/assets/js/amazeui.min.js'/>"></script>
<script src="<c:url value='resources/assets/js/cpbjs.js'/>"></script>
<script>
    function checkLabel() {
        var serial = document.getElementById("serial").value;
//        alert(serial);
        window.location.href = "/checkLabel.do?serial=" + serial;
    }
</script>
</body>
</html>
