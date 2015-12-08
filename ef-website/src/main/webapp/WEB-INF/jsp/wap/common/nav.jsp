<%@ page import="com.efeiyi.ec.website.organization.util.AuthorizationUtil" %>
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
<c:if test="${request=='/giftBuy/**'}">
<header>
    <header class="am-header custom-header">
        <div class="am-header-left am-header-nav">
            <a href="#chevron-left" class="chevron-left"></a>
        </div>
        <!-- //End--chevron-left-->
        <h1 class="am-header-title">礼物订单</h1>
        <!-- //End--title-->
        <!-- //End--chevron-left-->
        <div class="menu-list">
            <ul class="bd">
                <li><a href="http://www.efeiyi.com" title="首页">首页</a></li>
                <li><a href="<c:url value="/cart/view"/> " title="购物车">购物车</a></li>
                <% if (AuthorizationUtil.isAuthenticated()) {%>
                <li><a href="http://i.efeiyi.com" title="个人中心">个人中心</a></li>
                <%} else {%>
                <li><a href="<c:url value="/sso.do"/>" title="个人中心">个人中心</a></li>
                <%}%>
                <li><a href="http://master.efeiyi.com" title="分类">传承人</a></li>
            </ul>
        </div>
    </header>
</header>
</c:if>
<c:if test="${request=='/purchaseOrder/purchaseOrderGiftView'}">
    <header>
        <header class="am-header custom-header">
            <div class="am-header-left am-header-nav">
                <a href="#chevron-left" class="chevron-left"></a>
            </div>
            <!-- //End--chevron-left-->
            <h1 class="am-header-title">礼物订单</h1>
            <!-- //End--title-->
            <!-- //End--chevron-left-->
            <div class="menu-list">
                <ul class="bd">
                    <li><a href="http://www.efeiyi.com" title="首页">首页</a></li>
                    <li><a href="<c:url value="/cart/view"/> " title="购物车">购物车</a></li>
                    <% if (AuthorizationUtil.isAuthenticated()) {%>
                    <li><a href="http://i.efeiyi.com" title="个人中心">个人中心</a></li>
                    <%} else {%>
                    <li><a href="<c:url value="/sso.do"/>" title="个人中心">个人中心</a></li>
                    <%}%>
                    <li><a href="http://master.efeiyi.com" title="分类">传承人</a></li>
                </ul>
            </div>
        </header>
    </header>
</c:if>
<c:if test="${request=='/purchaseOrder/giftView'}">
    <header class="am-header custom-header newam-header">
        <!-- //End--chevron-left-->
        <h1 class="am-header-title">e飞蚁，领先的非物质文化遗产电商平台</h1>
        <!-- //End--title-->
        <!-- //End--chevron-left-->
        <div class="menu-list">
            <ul class="bd">
                <li><a href="http://www.efeiyi.com" title="首页">首页</a></li>
                <li><a href="<c:url value="/cart/view"/> " title="购物车">购物车</a></li>
                <% if (AuthorizationUtil.isAuthenticated()) {%>
                <li><a href="http://i.efeiyi.com" title="个人中心">个人中心</a></li>
                <%} else {%>
                <li><a href="<c:url value="/sso.do"/>" title="个人中心">个人中心</a></li>
                <%}%>
                <li><a href="http://master.efeiyi.com" title="分类">传承人</a></li>
            </ul>
        </div>
    </header>
</c:if>
<c:if test="${request=='/purchaseOrder/receiveGift'}">
    <header class="am-header custom-header newam-header">
        <!-- //End--chevron-left-->
        <h1 class="am-header-title">e飞蚁，领先的非物质文化遗产电商平台</h1>
        <!-- //End--title-->
        <!-- //End--chevron-left-->
        <div class="menu-list">
            <ul class="bd">
                <li><a href="http://www.efeiyi.com" title="首页">首页</a></li>
                <li><a href="<c:url value="/cart/view"/> " title="购物车">购物车</a></li>
                <% if (AuthorizationUtil.isAuthenticated()) {%>
                <li><a href="http://i.efeiyi.com" title="个人中心">个人中心</a></li>
                <%} else {%>
                <li><a href="<c:url value="/sso.do"/>" title="个人中心">个人中心</a></li>
                <%}%>
                <li><a href="http://master.efeiyi.com" title="分类">传承人</a></li>
            </ul>
        </div>
    </header>
</c:if>
<c:if test="${request!='/giftBuy/**'&&request!='/purchaseOrder/giftView'&&request!='/purchaseOrder/purchaseOrderGiftView'&&request!='/purchaseOrder/receiveGift'}">
<c:if test="${sign != null && sign == '000'}">

    <header class="am-header custom-header index-header newheader">
        <div class="logo"><a class="icon" href="" title="e飞蚁"></a></div>
        <!-- //End--logo-->
        <div class="newsearch">
            <form action="<c:url value='/search.do'/>" method="get">
                <input type="text" class="newsebox" placeholder="搜" name="q" value="<c:if test="${searchParamBean.q != '*'}">${searchParamBean.q}</c:if>">
                <input type="submit" class="newsebut" value="搜">
                <input type="hidden" name="resultPage" value="/searchResult"/>
                <input type="hidden" name="facetFields" value="project_name"/>
                <input type="hidden" name="group" value="efeiyi"/>
                <input type="hidden" name="priceUD" value="0"/>
            </form>
        </div>
        <div class="am-header-right am-header-nav">
            <a href="<c:url value="/cart/view"/>" class="icon icon-cart"><span class="tips"><em
                    id="cartAmount">0</em></span></a>
            <% if (AuthorizationUtil.isAuthenticated()) {%>
            <a href="http://i.efeiyi.com/order/myEfeiyi/list.do" class="icon icon-user"></a>
            <%} else {%>
            <a href="<c:url value="/sso.do"/>" class="icon icon-user"></a>
            <%}%>
        </div>
    </header>
</c:if>
<c:if test="${empty sign}">

    <header class="am-header custom-header newheader">
        <div class="am-header-left am-header-nav">
            <a href="javascript:history.go(-1)" class="chevron-left"></a>
        </div>
        <!-- //End--chevron-left-->
        <div class="newsearch">
            <form action="<c:url value='/search.do'/>" method="get">
                <input type="text" class="newsebox" placeholder="搜" name="q" value="<c:if test="${searchParamBean.q != '*'}">${searchParamBean.q}</c:if>">
                <input type="submit" class="newsebut" value="搜">
                <input type="hidden" name="resultPage" value="/searchResult"/>
                <input type="hidden" name="facetFields" value="project_name"/>
                <input type="hidden" name="group" value="efeiyi"/>
                <input type="hidden" name="priceUD" value="0"/>
            </form>
        </div>
        <!-- //End--title-->
        <div class="am-header-right am-header-nav">
            <a href="#chevron-right" class="chevron-right" id="menu">
                <i class="line"></i>
            </a>
        </div>
        <div class="menu-list">
            <ul class="bd">
                <li><a href="http://www.efeiyi.com" title="首页">首页</a></li>
                <li><a href="<c:url value="/cart/view"/> " title="购物车">购物车</a></li>
                <% if (AuthorizationUtil.isAuthenticated()) {%>
                <li><a href="http://i.efeiyi.com" title="个人中心">个人中心</a></li>
                <%} else {%>
                <li><a href="<c:url value="/sso.do"/>" title="个人中心">个人中心</a></li>
                <%}%>
                <li><a href="http://master.efeiyi.com" title="分类">传承人</a></li>
            </ul>
        </div>
    </header>
    <script>
        $("#title").html($("title").html())
    </script>

</c:if>
    </c:if>
<script>

    $().ready(function () {
        var success = function (data) {
            $("#cartAmount").html(data);
        }
        ajaxRequest("<c:url value="/cart/cartAmount.do"/>", {}, success, function () {
        }, "post");
    });

</script>
</body>
</html>
