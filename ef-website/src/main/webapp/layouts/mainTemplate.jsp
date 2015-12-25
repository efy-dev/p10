<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.ming800.core.util.HttpUtil" %>
<%--<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>--%>
<html>
<head>
    <title><sitemesh:write property='title'/></title>
    <%
        if (HttpUtil.isPhone(request)) {
    %>
    <%@include file="mobileMainHeader.jsp" %>
    <%
    } else {
    %>
    <%@include file="pcMainHeader.jsp" %>
    <%
        }
    %>
    <sitemesh:write property='head'/>

    <%--<script>--%>
        <%--//获取浏览器页面可见高度和宽度--%>
        <%--var _PageHeight = document.documentElement.clientHeight,--%>
                <%--_PageWidth = document.documentElement.clientWidth;--%>
        <%--//计算loading框距离顶部和左部的距离（loading框的宽度为215px，高度为61px）--%>
        <%--var _LoadingTop = _PageHeight > 61 ? (_PageHeight - 61) / 2 : 0,--%>
                <%--_LoadingLeft = _PageWidth > 215 ? (_PageWidth - 215) / 2 : 0;--%>
        <%--//在页面未加载完毕之前显示的loading Html自定义内容--%>
        <%--var divHeight = _LoadingTop-200--%>
        <%--var _LoadingHtml = '<div id="loadingDiv" style="position:absolute;left:0;width:100%;height:' + _PageHeight + 'px;top:0;background:#f3f8ff;opacity:1;filter:alpha(opacity=80);z-index:10000;"><div style="position: absolute; cursor1: wait; left: ' + _LoadingLeft + 'px; top:' + divHeight + 'px; width: auto; height: 57px; line-height: 57px; padding-left: 50px; padding-right: 5px; background: #fff ; color: #696969; font-family:\'Microsoft YaHei\';"><img width=120 height=100 src="<c:url value="/scripts/images/loading-fly.gif"/> "></div></div>';--%>
        <%--//呈现loading效果--%>
        <%--document.write(_LoadingHtml);--%>

        <%--//window.onload = function () {--%>
        <%--//    var loadingMask = document.getElementById('loadingDiv');--%>
        <%--//    loadingMask.parentNode.removeChild(loadingMask);--%>
        <%--//};--%>

        <%--//监听加载状态改变--%>
                <%--document.onreadystatechange = completeLoading;--%>

        <%--//加载状态为complete时移除loading效果--%>
                <%--function completeLoading() {--%>
                    <%--if (document.readyState == "complete") {--%>
                        <%--var loadingMask = document.getElementById('loadingDiv');--%>
                        <%--loadingMask.parentNode.removeChild(loadingMask);--%>
                    <%--}--%>
                <%--}--%>
    <%--</script>--%>

</head>
<body>

<%
    if (HttpUtil.isPhone(request)) {
%>
<%--导航--%>
<jsp:include flush="true"
             page="/getMenu.do?jmenuId=nav&jnodeId=nav&resultPage=/common/nav&match=${requestScope['javax.servlet.forward.servlet_path']}%3F${fn:replace(pageContext.request.queryString,'&','%26')}"/>

<%
} else {
%>
<jsp:include flush="true"
             page="/getMenu.do?jmenuId=nav&jnodeId=nav&resultPage=/common/nav&match=${requestScope['javax.servlet.forward.servlet_path']}%3F${fn:replace(pageContext.request.queryString,'&','%26')}"/>


<%
    }
%>

<%
    if (HttpUtil.isPhone(request)) {
%>
<sitemesh:write property='body'/>
<%
} else {
%>
<div class="wh">
    <sitemesh:write property='body'/>
</div>
<%
    }
%>

<%
    if (HttpUtil.isPhone(request)) {
%>
<%@include file="mobileFooter.jsp" %>
<%
} else {
%>
<%@include file="footer.jsp" %>
<%
    }
%>

</body>

</html>
