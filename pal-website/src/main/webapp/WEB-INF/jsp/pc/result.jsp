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
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html class="no-js">
<body>
<div class="search-home search-list">
    <div class="logo">
        <h1><a href="<c:url value='/'/> "><img src="<c:url value='/resources/images/logo.png'/>"/></a></h1>
    </div>
    <form id="form" action="<%=basePath%>checkLabel.do" method="get">
        <div class="title"><a>真伪查询</a><span class="line"></span><a>非遗搜</a></div>

        <input class="txt" type="text" name="serial" id="serial" value="">
        <input class="btn" type="button" value="查 询" id="btn">
        <input id="" onkeyup="eKeyup(event)" type="hidden">

    </form>
</div>
<!--//End--search-list-->
<script src="<c:url value='/resources/assets/js/jquery.min.js'/>"></script>

<!--[if (gte IE 9)|!(IE)]><!-->
<div class="hd">
    <div class="search-result">
<h1>基本信息</h1>

<div class="item item2">
<c:if  test="${result.authenticity != -1}"><a class="img" href="<c:url value='${product.imgUrl}'/>"><img src="<c:url value='${product.imgUrl}'/>" width="395" height="500"/></a></c:if>
<ul>
<li class="title">
<strong>${result.msg}</strong>
</li>
<c:if test="${result.authenticity != -1}">
<a href="#" title="奖励您100积分，点击领取。">奖励您100积分，点击领取。</a>
    <li><span>证书编号: ${product.tenantCertification.name}</span></li>
    <li>名称: ${product.name}</li>
    <li>作者: ${product.productSeries.tenant.name}</li>
    <li>创作年代: <fmt:formatDate value="${product.madeYear}" pattern="yyyy年MM月"/></li>
    <li>认证时间: <fmt:formatDate value="${product.madeYear}" pattern="yyyy年MM月"/></li>
    <li>类别: ${product.productSeries.name}</li>
    <c:forEach items="${product.productSeries.productSeriesPropertyNameList}" var="propertyName"  varStatus="status">
        <c:forEach items="${product.productPropertyValueList}" var="propertyValue" begin="${status.index}" end="${status.index}">
            <li >${propertyName.name}:${propertyValue.value}</li>
        </c:forEach>
    </c:forEach>
</c:if>
</ul>
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
    <td>国家级非遗传承人</td>
        <%--<td><a href="/viewCertification.do?productId=${product.id}" title="">查看证书</a></td>--%>
    <td><a href="${product.tenantCertification.imgUrl}" title="${product.tenantCertification.name}">查看证书</a></td>
    </tr>
    <tr>
    <td>传承项目认证</td>
    <td>国家级非物质文化遗产项目</td>
        <%--<td><a href="/viewCertification.do?productId=${product.id}" title="">查看证书</a></td>--%>
    <td><a href="${product.tenantCertification.imgUrl}" title="${product.tenantCertification.name}">查看证书</a></td>
    </tr>
    <tr>
    <td>其他获奖证书</td>
    <td>中国工艺美术大师</td>
        <%--<td><a href="/viewCertification.do?productId=${product.id}" title="">查看证书</a></td>--%>
    <td><a href="${product.tenantCertification.imgUrl}" title="${product.tenantCertification.name}">查看证书</a></td>
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
    <td><a href="${product.tenantSource.imgUrl}" title="创作地区：${product.tenantSource.region}</br>制作工艺：${product.tenantSource.name}</br>参与人：${product.tenant.masterName}">查看溯源图片</a></td>
    </tr>
    <tr>
    <td>传承人视频</td>
    <td>大师创作现场图，2006-06-01</td>
    <td><a href="${product.tenantSource.imgUrl}" title="创作地区：${product.tenantSource.region}</br>制作工艺：${product.tenantSource.name}</br>参与人：${product.tenant.masterName}">查看溯源图片</a></td>
    </tr>
    <tr>
    <td>文本信息</td>
    <td>苏绣传承历史</td>
    <td><a href="${product.tenantSource.imgUrl}" title="创作地区：${product.tenantSource.region}</br>制作工艺：${product.tenantSource.name}</br>参与人：${product.tenant.masterName}">查看溯源图片</a></td>
    </tr>
    </table>
    </div>
    </div>
    <!--//End--溯源信息-->
    </div>
    </div>
</c:if>

    <!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="<c:url value='http://libs.baidu.com/jquery/1.11.3/jquery.min.js'/>"></script>
<script src="<c:url value='http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js'/>"></script>
<script src="<c:url value='/resources/assets/js/amazeui.ie8polyfill.min.js'/>"></script>
<![endif]-->
<script src="<c:url value='/resources/assets/js/amazeui.min.js'/>"></script>
<script src="<c:url value='/resources/assets/js/cpbjs.js'/>"></script>
<script>
    $(document).ready(function(){
        $("#serial").keydown(function(e){
            if(e.keyCode==13){
                $('#form').submit(); //处理事件
            }
        });
        $("#btn").click(function(){
            $('#form').submit();
        });
    });
    $(function () {
        $('.search-home .title a').click(function () {
            $(this).addClass('active').siblings().removeClass('active');
        });
        //查看证书部分
        $('.item-info .row a').click(function(){
            $('body').append('<div class="search-dialog"><div class="content"><div class="title"><img src="<c:url value='/resources/images/logo.png'/>" width="140" alt="" /></div><div class="img"><img src="'+$(this).attr('href')+'" alt="" /></div><div class="info">'+$(this).attr('title')+'</div></div><div class="overlay"></div>');
            $('.overlay').click(function(){
                $('.search-dialog').remove();
            })
            return false;
        })
    })

    <c:if test="${result.isTimeLimited}">
    window.onload = function(){
        setTimeout("autoClose()", ${result.timeLimit});
    }

    function autoClose(){
        var userAgent = navigator.userAgent;
        alert(userAgent);
        if (userAgent.indexOf("Firefox") != -1
                || userAgent.indexOf("Chrome") != -1) {
            var href = window.location.href;
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
