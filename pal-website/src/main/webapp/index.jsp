<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html class="no-js">
<head>
</head>
<body>
<!--//End--topbar-->
<div class="search-home">
    <div class="logo">
        <h1><a href="<%=basePath%>"><img src="<c:url value='/resources/images/logo.png'/>"></a></h1>
        <p>非遗商品防伪溯源查询中心</p>
    </div>
    <form id="form" action="<%=basePath%>checkLabel.do" method="get">
        <div class="title"><a>真伪查询</a><span class="line"></span><a>非遗搜</a></div>

        <input class="txt" type="text" name="serial" id="serial" value="">
        <input class="btn" type="button" value="查 询" id="btn">
        <input id="" onkeyup="eKeyup(event)" type="hidden">

    </form>
</div>

<!--//End--search-home-->


<!--//End--footer-->

<!--[if (gte IE 9)|!(IE)]><!-->
<script src="<c:url value='/resources/assets/js/jquery.min.js'/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="<c:url value='http://libs.baidu.com/jquery/1.11.3/jquery.min.js'/>"></script>
<script src="<c:url value='http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js'/>"></script>
<script src="<c:url value='/resources/assets/js/amazeui.ie8polyfill.min.js'/>"></script>
<![endif]-->

<script src="<c:url value='/resources/assets/js/amazeui.min.js'/>"></script>
<%--<script src="<c:url value='/resources/assets/js/cpbjs.js'/>"></script>--%>
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
    })</script>
</body>
</html>