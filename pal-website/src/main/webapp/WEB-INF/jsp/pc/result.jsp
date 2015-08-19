<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/17
  Time: 18:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@include file="/layouts/public.jsp"%>
<!doctype html>
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
    <link rel="icon" type="image/png" href="<c:url value='/resources/assets/i/favicon.png'/>">
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
    <link rel="stylesheet" href="<c:url value='/resources/css/pc.css'/>">
</head>
<body>
<div class="search-list">
    <div class="search-home">
        <div class="logo">
            <h1><a href=""><img src="<c:url value='/resources/images/logo.png'/>" width="160" height="72" /></a></h1>
        </div>
        <form id="form" method="get" action="<c:url value='/checkLabelPc.do'/>">
            <div class="title"><a class="active">真伪查询</a><span class="line"></span><a>非遗搜</a></div>
            <label for="">
                <input class="txt" type="text" name="serial" id="serial" value="" placeholder="请输入名称查询,如:”苏绣”" />
                <input class="btn" type="submit" value="查 询"/>
            </label>
        </form>
    </div>
</div>
<!--//End--search-list-->
<div class="hd">
    <div class="search-result">
        <%--<div class="result-text">--%>
        <%--<span>查询“苏绣”的结果，共12个：</span>--%>
        <%--</div>--%>
        <div class="item item2">
            <c:if test="${result.authenticity != -1}">
                <a class="img" href="<%=imgBasePath%>${product.imgUrl}"><img src="<%=imgBasePath%>${product.imgUrl}" width="460" height="580"/></a>
            </c:if>
            <div class="info">
                <table>
                    <tr>
                        <td colspan="2">
                            <div class="result-title">
                                <strong>${result.msg}</strong>
                                <c:if test="${result.authenticity != -1}">
                                <a href="" title="奖励您100积分，点击领取。">奖励您100积分，点击领取。</a>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>证书编号</td>
                        <td>${product.tenantCertification.name}</td>
                    </tr>
                    <tr>
                        <td>名称</td>
                        <td>${product.name}</td>
                    </tr>
                    <tr>
                        <td>作者</td>
                        <td>${product.tenant.name}</td>
                    </tr>
                    <tr>
                        <td>创作年代</td>
                        <td><fmt:formatDate value="${product.madeYear}" pattern="yyyy年MM月"/></td>
                    </tr>
                    <tr>
                        <td>认证时间</td>
                        <td><fmt:formatDate value="${product.madeYear}" pattern="yyyy年MM月"/></td>
                    </tr>
                    <tr>
                        <td>类别</td>
                        <td>${product.productSeries.name}</td>
                    </tr>
                    <c:forEach items="${product.productSeries.productSeriesPropertyNameList}" var="propertyName"
                               varStatus="status">
                        <c:forEach items="${product.productPropertyValueList}" var="propertyValue"
                                   begin="${status.index}" end="${status.index}">
                            <tr>
                                <td>${propertyName.name}</td>
                                <td>${propertyValue.value}</td>
                            </tr>
                        </c:forEach>
                    </c:forEach>
                    </c:if>
                </table>
            </div>
        </div>
        <!--//End-->
        <c:if test="${result.authenticity == 1}">
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
                            <td><ming800:status name="level" dataType="PCTenantCertification.level" checkedValue="${product.tenantCertification.level}" type="normal" /></td>
                            <td><a href="<%=imgBasePath%>${product.tenantCertification.imgUrl}" title="${product.tenantCertification.name}">查看证书</a></td>
                        </tr>
                        <tr>
                            <td>传承项目认证</td>
                            <td><ming800:status name="level" dataType="PCTenantCertification.level" checkedValue="${product.tenantCertification.level}" type="normal" /></td>
                            <td><a href="<%=imgBasePath%>${product.tenantCertification.imgUrl}" title="${product.tenantCertification.name}">查看证书</a></td>
                        </tr>
                        <tr>
                            <td>其他获奖证书</td>
                            <td>${product.tenantCertification.name}</td>
                            <td><a href="<%=imgBasePath%>${product.tenantCertification.imgUrl}" title="${product.tenantCertification.name}">查看证书</a></td>
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
                            <td>大师创作现场图，<fmt:formatDate value="${product.madeYear}" pattern="yyyy-MM-dd"/></td>
                            <td><a href="<%=imgBasePath%>${product.tenantSource.imgUrl}" title="创作地区：${product.tenantSource.region}</br>制作工艺：${product.tenantSource.name}</br>参与人：${product.masterName}">查看溯源图片</a></td>
                        </tr>
                        <tr>
                            <td>传承人视频</td>
                            <td>大师创作现场图，<fmt:formatDate value="${product.madeYear}" pattern="yyyy-MM-dd"/></td>
                            <td><a href="<%=imgBasePath%>${product.tenantSource.imgUrl}" title="创作地区：${product.tenantSource.region}</br>制作工艺：${product.tenantSource.name}</br>参与人：${product.masterName}">查看溯源图片</a></td>
                        </tr>
                        <tr>
                            <td>文本信息</td>
                            <td>传承历史</td>
                            <td><a href="<%=imgBasePath%>${product.tenantSource.imgUrl}" title="创作地区：${product.tenantSource.region}</br>制作工艺：${product.tenantSource.name}</br>参与人：${product.masterName}">查看溯源图片</a></td>
                        </tr>
                    </table>
                </div>
            </div>
        </c:if>
        <!--//End--溯源信息-->
    </div>
</div>
<!--//End---->
<div class="footer footer-list">
    <div class="hd">
        <p>
            <a href="" title="关于诚品宝">关于诚品宝</a>
            <a href="" title="使用前必读">使用前必读</a>
            <strong>商家入住热线</strong>
            <em>400-876-8766</em>
        </p>
        <p class="copyright">Copyright © 2012-2022 永新华韵文化发展有限公司版权所有-京ICP备15032511号-1</p>
    </div>
</div>
<!--//End--footer-->
<!--[if (gte IE 9)|!(IE)]><!-->
<%--<script src="<c:url value='/resources/assets/js/jquery.min.js'/>"></script>--%>
<%--<script src="<c:url value='http://libs.baidu.com/jquery/1.11.3/jquery.min.js'/>"></script>--%>
<%--<script src="<c:url value='http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js'/>"></script>--%>
<%--<script src="<c:url value='/resources/assets/js/amazeui.ie8polyfill.min.js'/>"></script>--%>
<%--<script src="<c:url value='/resources/assets/js/amazeui.min.js'/>"></script>--%>
<%--<script src="<c:url value='/resources/assets/js/cpbjs.js'/>"></script>--%>
<script>
    $(document).ready(function () {
        $("#serial").keydown(function (e) {
            if (e.keyCode == 13) {
                $('#form').submit(); //处理事件
            }
        });
        $("#btn").click(function () {
            $('#form').submit();
        });
    });
    $(function () {
        $('.search-home .title a').click(function () {
            $(this).addClass('active').siblings().removeClass('active');
        });
        //查看证书部分
        $('.item-info .row a').click(function(){
            $('body').append('<div class="search-dialog"><div class="content"><div class="title"><i class="icon close" title="关闭"></i><img src="<c:url value='/resources/images/logo.png'/>" width="140" alt="" /></div><div class="img"><img src="'+$(this).attr('href')+'" alt="" /></div><div class="info">'+$(this).attr('title')+'</div></div><div class="overlay"></div>');
            $('.overlay, .search-dialog .close').click(function(){
                $('.search-dialog').remove();
            })
            return false;
        })
        //详情页终--产品二维码展示
        $('.search-result .item li .acode').click(function(){
            return false;
        })
        $('.search-result .item li .acode').hover(function(){
            $(this).append('<span class="wechat"><i class="icon"></i><img src="'+$(this).attr('href')+'" alt="" /></span>');
            return false;
        },function(){
            $(this).find('.wechat').fadeOut();
        });

    })

    <c:if test="${result.authenticity != -1}">
    var url = "http://api.map.baidu.com/location/ip?ak=zKrEDoOM6VCNjYDcBgpufSWR&ip=" + "${ip}";
//    var url = "http://api.map.baidu.com/location/ip?ak=zKrEDoOM6VCNjYDcBgpufSWR";
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
        var ipAddressDiv = document.getElementById("ipAddress");
        if (data.status == 0) {
            var text = data.address.split("|");
            ipAddressDiv.innerHTML = "上次验证地点：" + text[0] + " " + text[1] + " " + text[2];
        }else{
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
//        alert(userAgent);
        if (userAgent.indexOf("Firefox") != -1
                || userAgent.indexOf("Chrome") != -1) {
            location.href = "<c:url value='/'/>";
//            window.open(href,"_self","");
//            window.close();
        } else {
            window.opener = null;
            window.open("", "_self");
            window.close();
        }
    }
    </c:if>
</script>
</body>
</html>