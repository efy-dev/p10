<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/8/30 0030
  Time: 10:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>设置密码-e飞蚁</title>
</head>
<body>
<div class="new">
    <div class="short">
        <form id="myform" action="<c:url value="/updatePassword"/>" method='post'>
            <input type="hidden" id="id" value="${username}" name="username"/>

            <ul>
                <li>
                    <label>设置新密码</label>
                    <input name="np" class="txt" type="password" placeholder="请输入新密码" onblur="checkLg(this);">
                    <span class="active-d span2"></span>
                </li>
                <li>
                    <label>重复新密码</label>
                    <input name="pwd" class="txt" type="password" placeholder="请重复输入新密码" onkeydown="checkEq(this);"
                           onkeyup="checkEq(this);">
                    <span class="active-d span2"></span>
                </li>
                <li>
                    <label></label>
                    <span class="span-lest2"><a onclick="okChange()">保存并登录</a></span>
                </li>
            </ul>
        </form>
    </div>
</div>
<script>

    function okChange() {
        var flag = true;
        var np = $(":input[name='np']").val();
        var pwd = $(":input[name='pwd']").val();
        var username = $(":input[name='username']").val();
        $(".active-d").each(function () {
            if ($(this).text() != "" || np == "" || pwd == "") {
                flag = false;
                return false;
            }
        });
        /*ajax参数部分*/
        var param = {};
        param["username"] = username;
        param["pwd"] = pwd;
        var success = function (data) {
            if (data.code != "1") {
                login(data);
            } else {
                $(":input[name='pwd']").next("span").text("登陆失败,请重新登陆");
                return false;
            }
        };
        if (flag == true) {
            //异步请求
            ajaxRequest("/updatePassword", param, success, function () {
            }, "post");
        }
    }
    function login(userInfo) {
        var success = function (data) {
            if (data["login"] == "true") {
                //登陆成功
                $(":input[name='pwd']").next("span").text("");
                window.location.href = data["redirect"];
            } else if (data["login"] == "false") {
                $(":input[name='pwd']").next("span").text("登陆失败,请重新登陆");
                return false;
            }
        };
        ajaxRequest("/j_spring_security_check", {
            "username": userInfo.username,
            "password": userInfo.password
        }, success, function () {
        }, "post");
    }
    function checkEq(obj) {

        var np = $(":input[name='np']").val();
        var newPassword = $(obj).val();
        if (np != newPassword) {
            $(obj).next("span").text("您输入的两次密码不一致");
        } else {
            $(obj).next("span").text("");
        }
    }
    function checkLg(obj) {
        var lg = $(":input[name='np']").val().length;
        if (lg < 5 || lg > 16) {
            $(obj).next("span").text("密码由6位-16位字母或数字组成");
        } else {
            $(obj).next("span").text("");

        }
    }
</script>
</body>
</html>
