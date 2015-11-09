<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE>
<div class="topbar">
    <div class="hd">
        <div class="phone">
            <span>商户合作热线: </span>
            <strong>400-876-8766</strong>
        </div>
    </div>
</div>
<!--//End--topbar-->
<div class="search-home">
    <div class="logo">
        <h1><a href="/"><img src="<c:url value='/resources/images/logo.png'/>" width="150" height="68" /></a></h1>
        <p>非遗商品防伪溯源查询中心</p>
    </div>
    <form id="form" action="<c:url value='/checkLabelPc.do'/>" method="get">
        <%--<div class="title"><a >真伪查询</a><span class="line"></span><a>非遗搜</a></div>--%>
            <div class="title"><a >真伪查询</a></div>
        <label for="serial">
            <input class="txt" type="text" name="serial" id="serial" value="" />
            <input class="btn" type="submit" id="btn" value="查 询"/>
        </label>
    </form>
    <form id="form2" action="<c:url value='/search.do'/>" method="get">
        <div class="title"><a>非遗搜</a></div>
        <label for="q">
            <input type="hidden" name="q" id="q" value="" />
            <input class="txt" type="text" name="query" id="query" value="" />
            <input class="btn" type="button" id="btn2" value="查 询" onclick="preSubmit()"/>
        </label>
    </form>
    <!--//End--form-->
</div>
<!--//End--search-home-->


<!--[if (gte IE 9)|!(IE)]><!-->
<%--<script src="js/jquery.min.js"></script>--%>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<!--<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>-->
<%--<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>--%>
<%--<script src="<c:url value='/resources/assets/js/amazeui.ie8polyfill.min.js'/>"></script>--%>
<%--<![endif]-->--%>
<%--<script src="<c:url value='/js/amazeui.min.js'/>"></script>--%>
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
    function preSubmit(){
        var query = $("#query").val();
//        q = encodeURI(q);
        $("#q").val("all_name:"+query);

        $("#form2").submit();
    }
</script>