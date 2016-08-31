<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/8/30 0030
  Time: 11:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>找回密码-e飞蚁</title>
    <link rel="stylesheet" href="<c:url value="/scripts/wap/css/login.css"/>"/>
</head>
<body>
<link rel="stylesheet" href="<c:url value="/scripts/wap/css/myorder2.css"/>"/>
<div class="enroll">
    <form id="fp" action="<c:url value="/checkUserNameAndVerify"/>" method="post">
        <div class="start">
            <div class="login">

                <ul class="page">
                    <li>
                        <label>手机号</label>
                        <input id="phone" class="txt" type="text" name="targetname" placeholder="已验证过的手机号码"
                               maxlength="11">
                        <span class="active-d span1" id="error"></span>
                    </li>
                    <li>
                        <label>验证码</label>
                        <div class="tet1">
                            <input type="text" id="code" name="verificationCode" class="txt1 am-u-sm-7 am-u-end"
                                   placeholder="短信验证码，请注意查收">
                            <span class="am-u-sm-5 am-u-end"><button id="verificationButton"
                                                                     class="btn-p-1"
                                                                     type="button">获取短信效验码</button></span>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="edit-info">
                <input type="submit" value="保存信息" class="a">
                <span class="active-d span1" id="auth"></span>
            </div>
        </div>
    </form>
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
<script type='text/javascript'>
    (function () {
        $('.btn-top-wechat').hover(function () {
            $(this).find('.top-wechat').stop(true).slideDown('fast');
        }, function () {
            $(this).find('.top-wechat').stop(true).slideUp('fast');
        });
        //footer二维码
        $('.footer .service .wechat').hover(function () {
            $(this).find('.icon').fadeIn('100');
        }, function () {
            $(this).find('.icon').delay(2000).fadeOut();
        })
    })();
    (function (m, ei, q, i, a, j, s) {
        m[a] = m[a] || function () {
                    (m[a].a = m[a].a || []).push(arguments)
                };
        j = ei.createElement(q),
                s = ei.getElementsByTagName(q)[0];
        j.async = true;
        j.src = i;
        s.parentNode.insertBefore(j, s)
    })(window, document, 'script', '//eco-api.meiqia.com/dist/meiqia.js', '_MEIQIA');
    _MEIQIA('entId', 486);
</script>
</body>
</html>
