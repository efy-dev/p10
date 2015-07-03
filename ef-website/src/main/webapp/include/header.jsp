<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 13-1-25
  Time: 下午2:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/common/taglibs.jsp" %>
<link type="text/css" rel="stylesheet" href="<c:url value="/scripts/m8u/themes/metro/easyui.css"/>"/>
<%--<link type="text/css" rel="stylesheet" href="<c:url value='/scripts/m8u/themes/metro/easyui.css?m=5.3'/>"/>--%>
<link type="text/css" rel="stylesheet" href="<c:url value='/theme/theme.css?m=5.4'/>"/>
<link type="text/css" rel="stylesheet" href="<c:url value="/scripts/m8u/themes/icon.css"/>"/>
<script type="text/javascript" src="<c:url value="/scripts/jquery-1.8.0.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/scripts/m8u/jquery.m8u.min.js"/>"></script>
<%--<script type="text/javascript" src="<c:url value='/scripts/jquery-1.8.0.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/m8u/jquery.m8u.min.js?m=1.2'/>"></script>--%>
<script type="text/javascript" src="<c:url value="/m8/m8uUtils.js?m=5.3"/>"></script>
<script type="text/javascript" src="<c:url value="/scripts/m8u/m8u-lang-zh_CN.js"/>"></script>

<script type="text/javascript" src="<c:url value="/m8/function.js?m=5.2"/>"></script>
<%--弹窗--%>
<% String agent = request.getHeader("User-Agent");
    if (agent.indexOf("MSIE 6.0") != -1) {//是IE6 %>
<script type="text/javascript" src="<c:url value="/scripts/artDialog/jquery.artDialog.js?skin=simple"/>"></script>
<% } else {//不是IE6 %>
<script type="text/javascript" src="<c:url value="/scripts/artDialog/jquery.artDialog.js?skin=blue"/>"></script>
<% } %>
<script type="text/javascript" src="<c:url value="/scripts/artDialog/plugins/iframeTools.js"/>"></script>

