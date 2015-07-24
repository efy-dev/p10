<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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


<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<div class="am-g am-g-fixed" style="max-width: 550px;">
    <div class="am-u-md-12" style="box-shadow: 0px 0px 2px #626262;">
        <div class="am-u-md-12" style="text-align: center ;"><h2 style=" margin-top: 1.6rem;">e飞蚁 后台系统登录</h2></div>
        <form class="am-form am-form-horizontal" action="<c:url value="/j_spring_security_check"/>" method="post">
            <div class="am-form-group">
                <label for="username" class="am-u-sm-2 am-form-label">用户名</label>

                <div class="am-u-sm-10">
                    <input type="text" name="username" id="username" placeholder="输入用户名">
                </div>
            </div>

            <div class="am-form-group">
                <label for="password" class="am-u-sm-2 am-form-label">密码</label>

                <div class="am-u-sm-10">
                    <input type="password" name="password" id="password" placeholder="输入密码">
                </div>
            </div>

            <div class="am-form-group">
                <div class="am-u-sm-10 am-u-sm-offset-2">
                    <button type="submit" class="am-btn am-btn-default">登录</button>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>
