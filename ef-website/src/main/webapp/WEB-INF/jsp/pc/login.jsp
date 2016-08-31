<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/8/29 0029
  Time: 9:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"
       scope="session"/>
<html>
<head>
    <title>e飞蚁用户认证中心</title>
    <style>
        body {
            background-color: #FFFFFF;
        }

        #msg {
            padding: 20px;
            margin-bottom: 10px;
        }

        #msg.errors {
            border: 1px dotted #BB0000;
            color: #BB0000;
            padding-left: 100px;
            background: url(${ctx}/images/error.gif) no-repeat 20px center;
        }

        .login-form .mt {
            margin-bottom: 30px
        }

        .login-form h1 {
            font-size: 18px;
            float: left
        }

        .login-form .link {
            float: right;
            margin-top: 5px
        }

        .login-form .link a, .login-form .am-form .link p {
            font-size: 12px;
            color: #999;
            float: left
        }

        .login-form .link a:hover {
            color: #f00
        }

        .login-form .link .reg {
            color: #036;
            text-decoration: underline
        }

        .footer .authentication {
            background: #000;
            text-align: center;
            padding: 20px 0
        }

        .footer .authentication a {
            display: inline-block;
            margin: 0 20px
        }
    </style>
</head>
<body>

<div class="hd login">
    <div class="login-wrap">

        <div class="banner" id="login-b">
            <!--<img src="${ctx}/images/login-1.jpg" alt="" />
				-->
            <ul>
                <li><img src="/scripts/images/login-1.jpg" alt=""/></li>
                <%--<li><img src="${ctx}/images/login-2.jpg" alt=""/></li>--%>
                <%--<li><img src="${ctx}/images/login-3.jpg" alt=""/></li>--%>
            </ul>
        </div>
        <div class="login-form">

            <form class="am-form" method="post" action="<c:url value="/j_spring_security_check"/>">
                <div class="am-form-group" style="display: none;" id="errorGroup">
                    <span id="errorMessage" style="color: red;"></span>
                </div>
                <%--<form:errors path="*" id="msg" cssClass="errors" element="div"--%>
                <%--htmlEscape="false"/>--%>
                <%--<input type="hidden" name="lt" value="${loginTicket}"/>--%>
                <%--<input type="hidden" name="execution" value="${flowExecutionKey}"/>--%>
                <%--<input type="hidden" name="_eventId" value="submit"/>--%>
                <div class="mt wh">
                    <h1>
                        会员登录
                    </h1>
                    <span class="link"><!-- <a href="javascript:void(0);">没有账号? </a> --><a class="reg"
                                                                                           href="${ctx}/register?service=<%=request.getParameter("service") %>">没有账号?注册</a> </span>
                </div>


                <div class="am-form-group">
                    <i class="icon name"></i>
                    <input type="text" name="username" value="" placeholder="      用户名" style="padding-left: 32px;"/>

                </div>

                <div class="am-form-group">
                    <i class="icon pwd"></i>
                    <input type="password" name="password" value="" placeholder="      密码" style="padding-left: 32px;"/>

                </div>
                <div class="am-form-group">
                    <input type="checkbox" tabindex="4" name="rememberMe" id="warn"
                           value="true"/>
                    <label for="warn" style="margin-left: 4px;">
                        自动登录
                    </label>

                    <a class="forgetpwd"
                       href="<c:url value='/forgetPassword'/>"
                       title="忘记密码">忘记密码？</a>
                </div>


                <%--<input class="am-btn am-btn-secondary " type="submit" tabindex="5"--%>
                <%--value="登录"/>--%>
                <a class="am-btn am-btn-secondary " href="javascript:void(0);" onclick="login()">登录</a>

            </form>


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

    $(function () {
        $('#login-b li').hide();
        $('#login-b li').eq(0).show();
        setInterval(autoRun, 5000);
        var index = 0;

        function autoRun() {
            index++;
            if (index >= 3) {
                index = 0;
            }
            $('#login-b li').eq(index).fadeIn().siblings('li').fadeOut();
        }
    })
</script>

</body>
</html>
