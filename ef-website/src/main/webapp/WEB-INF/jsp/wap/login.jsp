<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/8/29 0029
  Time: 10:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"
       scope="session"/>
<html>
<head>
    <title>e飞蚁用户认证中心</title>
    <link href="<c:url value="/scripts/wap/css/signon.css"/>" rel="stylesheet">
    <link href="<c:url value="/scripts/wap/css/app2.css"/>" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
</head>
<body>
<div class="single-sign-on">
    <div class="hd login">
        <div class="login-wrap">


            <div class="login-form">

                <form class="am-form" method="post" action="<c:url value="/j_spring_security_check"/>">

                    <%--<form:errors path="*" id="msg" cssClass="errors" element="div"--%>
                    <%--htmlEscape="false"/>--%>
                    <%--<input type="hidden" name="lt" value="${loginTicket}"/>--%>
                    <%--<input type="hidden" name="execution" value="${flowExecutionKey}"/>--%>
                    <%--<input type="hidden" name="_eventId" value="submit"/>--%>
                    <div class="bk">
                        <div class="ld">

                            <div class="am-form-group" style="display: none;" id="errorGroup">
                                <span id="errorMessage" style="color: red;"></span>
                            </div>
                            <div class="am-form-group">
                                <i class="icon name"></i>
                                <label>手机号</label>
                                <input id="username" name="username" class="text1 textam" tabindex="1" minlength="3"
                                       placeholder="已验证手机" type="text" value="">
                            </div>

                            <div class="am-form-group">
                                <i class="icon pwd"></i>
                                <label>密码</label>
                                <input id="password" name="password" class="text1 textam" tabindex="2" minlength="3"
                                       placeholder="密码" type="password" value="">

                            </div>

                            <div class="am-form-group">
                                <input type="checkbox" tabindex="4" name="rememberMe" value="true" id="warn">
                                <label for="warn" class="warn">
                                    自动登录
                                </label>

                                <a class="forgetpwd"
                                   href="http://www.efeiyi.com/forgetPassword"
                                   title="忘记密码">忘记密码？</a>
                            </div>


                            <%--<input class="am-btn am-btn-secondary " type="submit" tabindex="5"--%>
                            <%--value="登&nbsp;&nbsp;&nbsp;&nbsp;录">--%>
                            <a class="am-btn am-btn-secondary " href="javascript:void(0);" onclick="login()">登&nbsp;&nbsp;&nbsp;&nbsp;录</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

</div>

<style>
    #login-b li {
        position: absolute;
        top: 0;
        left: 0;
    }

    #login-b {
        position: relative;
        width: 490px;
        height: 410px;
    }
</style>
<script>
    function login() {
        var username = $("input[name=username]").val();
        var password = $("input[name=password]").val();
        var success = function (data) {
            if (typeof data == "string") {
                data = JSON.parse(data);
            }
            if (data["login"] == "true") {
                //登录成功
                window.location.href = data["redirect"];
            } else if (data["login"] == "false") {
                $("#errorMessage").html(data["message"]);
                $("#errorGroup").show();
            }
        }
        ajaxRequest("/j_spring_security_check", {"username": username, "password": password}, success, function () {
        }, "post");
    }
</script>
</body>
</html>
