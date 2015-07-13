<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ include file="taglibs.jsp" %>
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
<div class="am-g am-g-fixed">
  <hr>
  <div class="am-g" style="margin-top: 100px">
    <div class="am-u-md-4" style="margin-top: 55px;">
      <form class="am-form" method="post" id="loginForm" action="<c:url value="/pc/login.do" />">
        <input type="hidden" name="dispatcher" value=""/>
        <input type="hidden" name="requestType" value="pc"/>
        <div class="am-form-group">
          <label for="username">用户</label>
          <input type="text" id="username" name="username" value="${enrollUsername}"/>
        </div>
        <div class="am-form-group">
          <label for="password">密码</label>
          <input type="password" class="form-control" id="password" name="password"
                 value="${j_password}"/>
        </div>
        <div class="message">${message}</div>
        <input id="login" type="submit" class="am-btn am-btn-default form-btn" value="登录"/>
        <%--<div style="text-align: right"><a class="ypl-a" href="/pc/forget.do">密码忘了？</a></div>--%>
      </form>
    </div>
  </div>
</div>

<script type="text/javascript">
 /* function init() {
    var j_yey = document.getElementById("j_yey");
    var j_username0 = document.getElementById("j_username");
    var j_password = document.getElementById("j_password");
    if (${exist==null}) {
      j_yey.value = getCookie("j_yey") == null ? j_yey.value : getCookie("j_yey");
      j_username.value = getCookie("j_username") == null ? j_username.value : getCookie("j_username");
    }
    if (j_yey.value == "") {
      j_yey.focus();
    } else if (j_username.value == "") {
      j_username0.focus();
    } else {
      j_password.focus();
    }
  }
  function setCookie(name, value, expires, path, domain, secure) {
    document.cookie = name + "=" + escape(value)
            + ((expires) ? "; expires=" + expires.toGMTString() : "")
            + ((path) ? "; path=" + path : "")
            + ((domain) ? "; domain=" + domain : "")
            + ((secure) ? "; secure" : "");
  }
  function getCookie(name) {
    var prefix = name + "=";
    var start = document.cookie.indexOf(prefix);
    if (start == -1) {
      return null;
    }
    var end = document.cookie.indexOf(";", start + prefix.length);
    if (end == -1) {
      end = document.cookie.length;
    }
    var value = document.cookie.substring(start + prefix.length, end);
    return unescape(value);
  }

  function saveUsername(form) {
    var expires = new Date();
    expires.setTime(expires.getTime() + 24 * 30 * 60 * 60 * 1000); // sets it for approx 30 days.
    setCookie("j_yey", document.getElementById('j_yey').value, expires, " / ");
    setCookie("j_username", form.elements['j_username'].value, expires, " / ");
    var location = this.location.href.toString().substring(7);
    location = location.substring(location.indexOf('/'))
    setCookie("location", location, expires, " / ");
  }

  function validateForm(form) {
    saveUsername(form);
    if (form.elements['j_username'].value == "") {
      alert('用户名不能为空');
      return false;
    }
    if (form.elements['j_password'].value == "") {
      alert('密码不能为空');
      return false;
    }
    return true;
  }
  function loginSubmit() {
    var form = document.getElementById('loginForm');
    if (validateForm(form)) {
      document.getElementById('login').value = '登录中......';
      saveUsername(form);
      return true;
    } else {
      return false;
    }
  }*/
</script>
</body>
</html>
