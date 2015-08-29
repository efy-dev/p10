<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<html>
<head>

  <title>登录</title>

  <style type="text/css">
    .title {
      font-size: 16px;
      font-weight: bold;
      border-bottom: 2px solid #247ba0;
    }
  </style>
</head>
<body>
<div class="enroll">
  <form action="<c:url value="/j_spring_security_check" />" method="post">
    <div class="start">
      <div class="login">

        <ul>
          <li>
            <label>手机号</label>
            <input type="text" name="username" class="txt" placeholder="已验证过的手机号码" maxlength="11" required>
          </li>
          <li>
            <label>密码</label>
            <input type="password" name="password" class="txt" placeholder="6—16个字符，建议使用字母、数字或符号的组合" required>
          </li>
        </ul>

      </div>
      <div class="telnet">
        <%--<a href="#" class="telnet1">微&nbsp信&nbsp登&nbsp录</a>--%>
        <a href="<c:url value="/forgetPwd"/>" class="telnet2">忘&nbsp记&nbsp密&nbsp码</a>
      </div>
      <div class="edit-info">
        <input type="submit" value="登录" class="a">
      </div>
    </div>
  </form>
</div>
</body>
</html>
