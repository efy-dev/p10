<!DocType html>
<%@ page import="com.ming800.core.util.HttpUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title id="pages">
        <sitemesh:write property="title"/>
    </title>
    <%
        if(HttpUtil.isPhone(request)){
    %>
    <%@include file="mobileStyle.jsp"%>
    <%
    }else{
    %>
    <%@include file="pcStyle.jsp"%>
    <%
        }
    %>
    <sitemesh:write property='head'/>
</head>
<body>
<%
        if(HttpUtil.isPhone(request)){
    %>
    <%@include file="mobileHeader.jsp"%>
    <%
    }else{
    %>
    <%@include file="pcHeader.jsp"%>
    <%
        }
    %>
    <sitemesh:write property='body'/>
    <%
        if(HttpUtil.isPhone(request)){
    %>
    <%@include file="mobileFooter.jsp"%>
    <%
    }else{
    %>
    <%@include file="pcFooter.jsp"%>
    <%
        }
    %>
    <script type="text/javascript">
        var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1255887869'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "w.cnzz.com/q_stat.php%3Fid%3D1255887869' type='text/javascript'%3E%3C/script%3E"));
    </script>
</body>
</html>
