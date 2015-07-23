<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/14
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<form class="am-form am-form-horizontal" action="/j_spring_security_check" method="post">
  <div class="am-form-group">
    <label for="username" class="am-u-sm-2 am-form-label">电子邮件</label>
    <div class="am-u-sm-10">
      <input type="text" name="username" id="username" placeholder="输入你的电子邮件">
    </div>
  </div>

  <div class="am-form-group">
    <label for="password" class="am-u-sm-2 am-form-label">密码</label>
    <div class="am-u-sm-10">
      <input type="password" name="password" id="password" placeholder="设置一个密码吧">
    </div>
  </div>

  <div class="am-form-group">
    <div class="am-u-sm-10 am-u-sm-offset-2">
      <button type="submit" class="am-btn am-btn-default">登录</button>
    </div>
  </div>
</form>
</body>
</html>
