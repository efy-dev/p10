<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/8/29 0029
  Time: 16:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>找回密码-e飞蚁</title>
    <style type="text/css">
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
<div class="dentification">
    <div class="short">
        <form id="fp" action="<c:url value="/checkUserNameAndVerify"/>" method="post">
            <ul>
                <li>
                    <label>输入您的手机号</label>
                    <input id="phone" class="txt" type="text" name="targetname" placeholder="手机号">
                    <span class="active-d span1" id="error"></span>
                </li>
                <li>
                    <label>手机验证码</label>
                    <input class="txt1" id="code" name="verificationCode" type="text"
                           placeholder="短信验证码">
                    <span class="span-lest1"><button id="verificationButton" class="btn-p"
                                                     type="button">获取短信效验码</button></span>
                </li>
                <li>
                    <label></label>
                    <span class="span-lest2"> <input class="btn-p" type="submit" value="提交"></span>
                    <span class="active-d span1" id="auth"></span>
                </li>
            </ul>
        </form>
    </div>
</div>
<script>
    var wait = 60;//时间
    function time(o, p) {//o为按钮的对象，p为可选，这里是60秒过后，提示文字的改变
        if (wait == 0) {
            o.removeAttr("disabled");
            o.html("获取验证码");//改变按钮中value的值
            wait = 60;
        } else {
            o.attr("disabled", true);//倒计时过程中禁止点击按钮
            o.html(wait + "秒后重试");//改变按钮中value的值
            wait--;
            setTimeout(function () {
                        time(o, p);//循环调用
                    },
                    1000)
        }
    }
    function sendVerificationCode(phone) {
        $.ajax({
            type: 'get',
            async: false,
            url: '<c:url value="/verification/send.do"/>',
            dataType: 'json',
            data: {
                phone: phone,
            },
            success: function (data) {
                if (data) {
                    console.log("发送验证吗成功");
                } else {
                    console.log("发送验证码失败");
                }
            },
            error: function () {
                console.log("数据获取失败");
            }
        });
    }
    $().ready(function () {

        $("#verificationButton").click(function () {
            $("#verificationButton").attr("disabled", true);
            var userName = $("#phone").val();
            $.ajax({
                type: 'post',
                async: false,
                url: '<c:url value="/checkUserName"/>',
                dataType: 'json',
                data: {
                    username: userName
                },
                success: function (data) {
                    if (data == false) {
                        $("#error").text("您输入的用户名不正确");
                        $("#verificationButton").removeAttr("disabled");
                    } else {
                        $("#error").text("");
                        sendVerificationCode($("#phone").val())
                        time($("#verificationButton"));
                    }
                },

            });

        });

        $("#code").blur(function () {
            checkVerificationCode($("#phone").val(), $("#code").val());
        });


        $("#consumerSignin").click(function () {
            if (isVerification && bool) {
//                if ($("#userRole").val() == "consumer") {
                $("#consumerSubmit").click();
//                } else if ($("#userRole").val() == "photographer") {
//                    $("#bigUser").attr("action", "/pc/saveEnrollPhotographer.do");
//                    $("#consumerSubmit").click();
//                }
            } else if (!isVerification) {
                $("#consumerVerificationCodeCheck").css("display", "block");
            }
        });


        $("#username").blur(function () {


            if ($("#verification").val() != "") {
                checkVerificationCode($("#username").val(), $("#code").val());
            }
            checkUserName("user");
        });
    });


    function checkVerificationCode(phone, code) {
        jQuery.ajax({
            type: 'get',
            async: false,
            url: '<c:url value="/verification/verify.do"/>',
            dataType: 'json',
            data: {
                verificationCode: code,
                phone: phone
            },
            success: function (data) {
                if (data == true) {
//                    document.getElementById('fp').submit();
                } else {
//                    $("#auth").text("您发送的验证码不正确");
                    showAlert("提示", "验证码输入错误，请从新验证")
                }
            },
            error: function () {
                console.log("数据获取失败");
            }
        });
    }
</script>
</body>
</html>
