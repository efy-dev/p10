<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/10/12 0012
  Time: 17:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<script>
  var register = "http://passport.efeiyi.com/register?service=http://www.efeiyi.com/sso.do";
  window.location.href = register+"&unionid=${unionid}";
</script>
</body>
</html>
