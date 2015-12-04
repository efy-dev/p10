<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.ming800.core.util.HttpUtil" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/10/22
  Time: 15:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title><sitemesh:write property='title'/></title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/wap/css/amazeui.min.css?v=20151127"/>">
  <link type="text/css" rel="stylesheet"  href="<c:url value="/scripts/wap/css/app.css?v=20151127"/>">
  <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/wap/css/myorder.css?v=20151127"/>">
  <script src="<c:url value="/scripts/wap/js/jquery-1.11.1.min.js"/>" ></script>
  <script src="<c:url value="/scripts/js/ef.util.js"/>" ></script>

  <sitemesh:write property='head'/>
</head>
<body>

<sitemesh:write property='body'/>



<style type="text/css">
  #MEIQIA-BTN-HOLDER {
    right: 0;bottom: 145px;}
  #MEIQIA-BTN {
    background: #000;
    width: 33px;
    height:53px;
    -webkit-border-radius: 5px;
    -moz-border-radius: 5px;
    border-radius: 5px;
  }
  #MEIQIA-BTN-LINE {
    display: none;}
  #MEIQIA-BTN-TEXT {
    width:48px;
    font-size: 12px;
    position: absolute;
    left:-28px;
    top:20px;
    display: none;
  }
  .MEIQIA-ICON {
    background:url(http://j.efeiyi.com/tg-website/scripts/wap/images/qq.png) no-repeat -176px -143px;
    background-size: auto auto;
  }
  #MEIQIA-BTN-ICON {
    width: 23px;
    height: 28px;
    margin: 0;
    float: left;
    margin-left:5px;
    margin-top: 6px;
  }
</style>
<script type='text/javascript'>
  (function(m, ei, q, i, a, j, s) {
    m[a] = m[a] || function() {
              (m[a].a = m[a].a || []).push(arguments)
            };
    j = ei.createElement(q),
            s = ei.getElementsByTagName(q)[0];
    j.async = true;
    j.src = i;
    s.parentNode.insertBefore(j, s)
  })(window, document, 'script', '//eco-api.meiqia.com/dist/meiqia.js', '_MEIQIA');
  _MEIQIA('entId', 486);
</script>
<!--end在线客服-->
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="<c:url value="/scripts/wap/js/jquery.min.js"/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="<c:url value="/scripts/wap/js/amazeui.min.js"/>"></script>
<!--自定义js--Start-->
<script src="<c:url value="/scripts/wap/js/system.js?v=20151127"/>"></script>
<script src="<c:url value="/scripts/wap/js/myorder.js?v=20151127"/>"></script>

</body>
</html>
