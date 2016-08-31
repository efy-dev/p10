<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/8/30 0030
  Time: 12:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>设置密码-e飞蚁</title>
    <link rel="stylesheet" href="<c:url value="/scripts/wap/css/login.css"/>"/>
</head>
<body>
<link rel="stylesheet" href="<c:url value="/scripts/wap/css/myorder2.css"/>"/>
<div class="enroll">
    <form id="myform" action="<c:url value="/updatePassword"/>" method='post'>
        <input type="hidden" id="id" value="${username}" name="username"/>
        <div class="start">
            <div class="login">

                <ul class="page">
                    <li>
                        <label>新密码</label>
                        <input type="password" name="np" class="txt" onblur="checkLg(this);"
                               placeholder="6—16个字符，建议使用字母、数字或符号的组合">
                        <span class="active-d span2"></span>
                    </li>
                    <li>
                        <label>重复密码</label>
                        <input type="password" class="txt" name="pwd" onkeydown="checkEq(this);"
                               onkeyup="checkEq(this);" placeholder="请再次输入密码">
                        <span class="active-d span2"></span>
                    </li>
                </ul>

            </div>
            <div class="edit-info">
                <a class="a" onclick="okChange()">保存并登录</a>
            </div>
        </div>
    </form>
</div>
<script>

    function okChange() {
        var flag = true;
        var np = $(":input[name='np']").val();
        var pwd = $(":input[name='pwd']").val();
        $(".active-d").each(function () {
            if ($(this).text() != "" || np == "" || pwd == "") {
                flag = false;
                return false;
            }
        });
        if (flag == true) {

            document.getElementById('myform').submit();
            //document.getElementById('myform').submit();
        }
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
