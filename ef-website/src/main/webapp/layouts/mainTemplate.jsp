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
    <script>
        var _hmt = _hmt || [];
        (function() {
            var hm = document.createElement("script");
            hm.src = "//hm.baidu.com/hm.js?3398e6871ab51d553fd6101c51f6f9f0";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(hm, s);
        })();
    </script>
    <script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

        ga('create', 'UA-70772829-1', 'auto');
        ga('send', 'pageview');

    </script>
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
