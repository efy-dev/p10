<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/8/29 0029
  Time: 12:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册-e飞蚁</title>
    <style type="text/css">

        .title {
            /*color:#D4D4D4;*/
            font-size: 16px;
            font-weight: bold;
            border-bottom: 2px solid #247ba0;
        }

        .am-nav-tabs > li.am-active > a, .am-nav-tabs > li.am-active > a:hover, .am-nav-tabs > li.am-active > a:focus {
            color: #555;
            background-color: #fff;
            border: 1px solid #ddd;
            border-bottom-color: transparent;
            cursor: default;
            background-color: #8cc5fb;
            color: white;
        }

        .am-active {
            background-color: #8cc5fb;
        }
    </style>
    <link href="<c:url value="/scripts/wap/css/app2.css"/>" rel="stylesheet">
    <link href="<c:url value="/scripts/wap/css/myorder2.css"/>" rel="stylesheet">
</head>
<body>
<div class="help-block">
    <h5 id="consumerVerificationCodeCheck" style="color: red;display: none">
        手机验证码输入错误</h5>
</div>
<div class="enroll">
    <form class="am-form" data-parsley-validate id="bigUser" name="bigUser"
          action="<c:url value="signinUser"/>" method="post">
        <div class="start">
            <div class="login">
                <ul class="page">
                    <li>
                        <label>手机号</label>
                        <input class="txt" type="text" id="username" name="username"
                               data-parsley-pattern="^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$"
                               data-parsley-error-message="请输入正确的手机号" data-parsley-trigger="change"
                               data-parsley-required-message="请输入您的手机号" placeholder="请输入您的手机号" required=""
                               data-parsley-id="8402">
                        <ul class="parsley-errors-list" id="parsley-id-8402"></ul>
                        <label class="msg-tips" id="usernameMessage" style="display: none">
                            <span class="msg">！该手机号已存在,如果您是该用户，请

                            <a href="http://www.efeiyi.com/login">立刻登录</a>

                            </span>
                        </label>
                    </li>
                    <li>
                        <label>图片验证码</label>
                        <input class="txt" type="text" id="imageVCode" minlength="3" placeholder="输入图片中的验证码"
                               data-parsley-required="true" onblur="checkImageCode()" data-parsley-id="5221">
                        <ul class="parsley-errors-list" id="parsley-id-5221"></ul>
                        <span><h5 id="imageCodeMessage" style="color: red;display: none">
                                验证码错误 </h5>
                            </span>
                    </li>
                    <li>
                        <div class="tet">
                            <span class="am-u-sm-6"><input type="image" id="imageCode" minlength="3" placeholder="图片验证码"
                                                           src="<c:url value="/getImageCode"/>" data-parsley-id="8391"><ul
                                    class="parsley-errors-list" id="parsley-id-8391"></ul></span>
                            <span class="am-u-sm-6"><a onclick="changeImageCode()">看不清？换一张</a></span>
                        </div>
                    </li>
                    <li>
                        <label>验证码</label>
                        <div class="tet1">
                            <span class="span-ipt"><input class="txt1 am-u-sm-7 am-u-end" type="text" id="verification"
                                                          placeholder="验证码" data-parsley-required="true"
                                                          data-parsley-required-message="请输入验证码" data-parsley-id="1138"><ul
                                    class="parsley-errors-list" id="parsley-id-1138"></ul></span>
                            <span class="span-btn"><a class="btn-p-1" id="verificationButton">获取验证码</a></span>
                        </div>
                    </li>
                    <li>
                        <label>设置密码</label>
                        <input class="txt" type="password" id="password" name="password"
                               data-parsley-pattern="^[a-zA-Z0-9]{6,16}$" data-parsley-error-message="密码由6-16位字母或数字组成"
                               placeholder="密码由6-16位字母或数字组成" data-parsley-trigger="change" required=""
                               data-parsley-id="7944">
                        <ul class="parsley-errors-list" id="parsley-id-7944"></ul>
                    </li>
                    <li>
                        <label>重复密码</label>
                        <input class="txt" type="password" id="passwordAgain" name="passwordAgain"
                               data-parsley-equalto="#password" data-parsley-equalto-message="两次输入不一致"
                               data-parsley-required="true" data-parsley-required-message="请确认密码"
                               data-parsley-trigger="change" placeholder="请与上面输入的值一致" data-parsley-id="3457">
                        <ul class="parsley-errors-list" id="parsley-id-3457"></ul>
                    </li>
                </ul>
            </div>
            <div class="err-tips">注册即视为同意<a href="<c:url value="/html/registerDeal.html"/>">《e飞蚁用户注册协议》</a></div>
            <div class="edit-info">

                <input id="consumerSubmit" type="submit" class="a" value="注册"
                       style="border-color: #db0c5b;background-color: #db0c5b; display: none">
                <a class="a" id="consumerSignin">注&nbsp;&nbsp;&nbsp;&nbsp;册</a>
            </div>
        </div>
    </form>
</div>
<style type="text/css">
    .loading {
        position: fixed;
        bottom: 0;
        left: 0;
        right: 0;
        top: 0;
        background: rgba(0, 0, 0, .5);
        z-index: 9999
    }

    .loading .box {
        width: 260px;
        height: 260px;
        text-align: center;
        position: absolute;
        top: 50%;
        left: 50%;
        margin-top: -130px;
        margin-left: -130px;
        background: #fff;
        -webkit-border-radius: 10px;
        border-radius: 10px;
    }

    .loading .box img {
        position: absolute;
        top: 50%;
        left: 50%;
        margin-top: -105px;
        margin-left: -105px;
    }
</style>
<div class="loading" style="display:none;">
    <div class="box">
        <img src="${ctx}/scripts/images/loading-fly.gif" alt="">
        <p style="position:relative;top:210px;font-size:14px;">注册并登录中,请稍后...</p>
    </div>
</div>
<script type="text/javascript">

    var flag = false;


    function validForm() {
        if (flag == bool == true) {
            return true;
        }
        return false;
    }


</script>
<script type="application/javascript" src="<c:url value="/scripts/js/parsley/parsley.min.js"/>"></script>
<script type="application/javascript" src="<c:url value="/scripts/js/parsley/parsley.remote.min.js"/>"></script>
<script>
    $(document).ready(function () {
        $('#btnPanel').on('click', function (event) {
            if ($(event.target).attr('id') == 'consumerEnrollBtn') {
                /*$('#photographerAttention').fadeOut('fast');
                 $('#consumerAttention').fadeIn('slow');*/
                $('#photographerAttention').fadeOut('fast', function () {
                    $('#consumerAttention').fadeIn('slow');
                });

            }
            else if ($(event.target).attr('id') == 'photographerEnrollBtn') {
                $('#consumerAttention').fadeOut('fast', function () {
                    $('#photographerAttention').fadeIn('slow');
                });

            }
        });
    });
</script>
<script>

    var isConsumerCodeRight = false;
    var isVerification = false;
    var isImageCodeChecked = false;

    function changeImageCode() {
//        $("#imageCode").attr("src", "");
        $("#imageCode").attr("src", "<c:url value="/getImageCode?"/>" + new Date().getTime());
    }

    function checkImageCode() {
        jQuery.ajax({
            type: 'get',
            async: false,
            url: '<c:url value="/checkImageCode"/>',
            dataType: 'json',
            data: {
                code: $("#imageVCode").val()
            },
            success: function (data) {
                isImageCodeChecked = data;
                if (isImageCodeChecked) {
                    $("#imageCodeMessage").hide();
                } else {
                    $("#imageCodeMessage").show();
                }
            }
        });
    }

    //验证用户名
    function usernameConfirm() {
        var reg = /^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;
        var username
        username = $("#username").val();

        if (reg.test(username)) {
            $("#usernameConfirmWarning").hide();
            return true;
        } else {
            $("#usernameConfirmWarning").show();
            return false;
        }
    }


    var bool = false;


    function checkUserName(usertype) {

        var username = "";
        if (usertype == "user") {
            username = $("#username").val();
//                $("#name").val($("#username").val());
            $("#phone").val($("#username").val());
        } else {
            username = $("#photographerUsername").val();
            $("#pgphone").val($("#photographerUsername").val());
        }


        if ((username != null && username != "")) {
            jQuery.ajax({
                type: 'post',
                async: false,
                url: '<c:url value="/checkUserName"/>',
                dataType: 'json',
                data: {
                    username: username
                },
                success: function (data) {
//                console.log("检查用户名");
                    if (usertype == "user") {
//                    console.log("user type is user");
                        if (data) {
//                        console.log("用户名已经存在");
                            $("#usernameMessage").show()
                            bool = false;
                        } else {
//                        console.log("用户名不存在");
                            $("#usernameMessage").hide();
                            bool = true;
                        }
                    } else {
//                        console.log("user type is photographer");
                        if (data) {
//                        console.log("用户名已经存在");
                            $("#pgUsernameMessage").text("用户名已存在!");
                            bool = false;
                        } else {
//                        console.log("用户名不存在");
                            $("#pgUsernameMessage").text("");
                            bool = true;
                        }
                    }
                }
            });
        }
//    console.log("检查用户名");
//    console.log(bool)
        return bool;
    }


    var wait = 60;//时间
    function time(o, p) {//o为按钮的对象，p为可选，这里是60秒过后，提示文字的改变
        if (wait == 0) {
            o.removeAttr("disabled");
            o.html("获取验证码");//改变按钮中value的值
//        p.html("如果您在1分钟内没有收到验证码，请检查您填写的手机号码是否正确或重新发送");
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
                ramId: $("#ramId").val(),
                check: isImageCodeChecked
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

    function checkVerificationCode(phone, code, userType) {
        isVerification = false;
        isPhotographerVerification = false;
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
                if (data) {
                    if (userType == "user") {
                        isVerification = true;
                        $("#consumerVerificationCodeCheck").css("display", "none");
                    } else {
                        isPhotographerVerification = true;
                        $("#photographerVerificationCodeCheck").css("display", "none");
                    }
//                console.log("验证成功");
                } else {
                    if (userType == "user") {
                        isVerification = false;
                    } else {
                        isPhotographerVerification = false;
                    }
                    console.log("验证失败");
                }
            },
            error: function () {
                console.log("数据获取失败");
            }
        });
    }

    $().ready(function () {

        $("#verificationButton").click(function () {
            if (isImageCodeChecked) {

                if ($("#username").val() != "") {
                    if (true) {
                        sendVerificationCode($("#username").val())
                        time($("#verificationButton"));
                    }
                }
            } else {
                $("#imageCodeMessage").show();
            }
        });

        $("#verification").blur(function () {
            checkVerificationCode($("#username").val(), $("#verification").val(), "user");
        });


        $("#consumerSignin").click(function () {
            if (isVerification && bool) {
//                if ($("#userRole").val() == "consumer") {
                $("#consumerSubmit").click();
                $("#consumerSubmit").attr("disabled", true);
                $(".loading").show();
            } else if (!isVerification) {
                $("#consumerVerificationCodeCheck").css("display", "block");
                $("#consumerSubmit").attr("disabled", false);
            }
        });


        $("#username").blur(function () {


            if ($("#verification").val() != "") {
                checkVerificationCode($("#username").val(), $("#verification").val(), "user");
            }
            checkUserName("user");
        });
    });
</script>
</body>
</html>
