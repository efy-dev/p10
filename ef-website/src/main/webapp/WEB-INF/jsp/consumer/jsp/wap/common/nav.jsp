<%@ page import="com.ming800.core.p.PConst" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/25
  Time: 15:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
</head>
<body>
<c:if test="${sign != null and sign == '000'}">
    <header id="header" class="am-header custom-header index-header">
        <div class="logo"><a class="icon" href="" title="e飞蚁"></a></div>
        <!-- //End--logo-->
        <div class="am-header-right am-header-nav">
            <a href="<c:url value="#"/>" class="icon icon-cart"><span class="tips"><em
                    id="cartAmount">0</em></span></a>
            <a href="http://www.efeiyi.com/order/myEfeiyi/list.do" class="icon icon-user"></a>
        </div>
    </header>
</c:if>
<c:if test="${sign == null}">

    <header id="header" class="am-header custom-header">
        <div class="am-header-left am-header-nav">
            <a href="javascript:if(typeof gobackUrl=='undefined'){
            history.go(-1)}else{
            window.location.href= gobackUrl;
            }" class="chevron-left"></a>
        </div>
        <!-- //End--chevron-left-->
        <h1 class="am-header-title" id="title">分类</h1>
        <!-- //End--title-->
        <div class="am-header-right am-header-nav">
            <a href="#chevron-right" class="chevron-right" id="menu">
                <i class="line"></i>
            </a>
        </div>
        <!-- //End--chevron-left-->
        <div class="menu-list">
            <ul class="bd">
                <li><a href="<%=PConst.HOSTNAME%>" title="首页">首页</a></li>
                <li><a href="<%=PConst.HOSTNAME%>/cart/view " title="购物车">购物车</a></li>
                <li><a href="<c:url value="/order/myEfeiyi/list.do"/> " title="个人中心">个人中心</a></li>
                <li><a href="<%=PConst.HOSTNAME%>/productCategory.do " title="分类">分类</a></li>
                <%--<li><a href="http://master.efeiyi.com" title="大师">大师</a></li>--%>
            </ul>
        </div>
    </header>

    <script>
        $("#title").html($("title").html())
    </script>

</c:if>
<script>

    $().ready(function () {
        var success = function (data) {
            $("#cartAmount").html(data);
        }
        ajaxRequest("<c:url value="#"/>", {}, success, function () {
        }, "post");
    });

</script>
</body>
</html>
