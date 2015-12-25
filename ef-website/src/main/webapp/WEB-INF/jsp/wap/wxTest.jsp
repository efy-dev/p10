<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/12/25 0025
  Time: 14:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>微信功能测试页面</title>
</head>
<body>
微信功能测试页面

<a onclick="wxShare()">分享测试</a>

<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="<c:url value="/scripts/wap/js/weixin.js"/>"></script>

<script>

    initWx("<c:url value="/wx/init.do"/>");


    function wxShare() {

    }

</script>
</body>
</html>
