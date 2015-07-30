<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <script type="text/javascript">

        var flag = false;



        function validForm() {
            if (flag == bool == true) {
                return true;
            }
            return false;
        }


    </script>
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
</head>
<body>
<div class="am-g am-g-fixed">
    <hr>
    <div class="am-g" style="margin-top: 100px">
        <div class="am-u-md-8">
            <%--<img id="consumerAttention" src="/scripts/yuepaila/images/common/signInStep.png">
            <img id="photographerAttention" src="/scripts/yuepaila/images/common/login4.png" style="display: none">--%>
        </div>

        <div class="am-u-md-4" style="margin-top: 35px">
            <div data-am-widget="tabs" class="am-tabs am-tabs-default">
                <ul id="btnPanel" class="am-tabs-nav am-cf">
                    <li class="am-active"><a href="#consumerPanel" id="consumerEnrollBtn">用户注册</a></li>
                </ul>

                <div class="am-tabs-bd" style="border: 0px;">
                    <div class="am-tab-panel am-active" id="consumerPanel">


                        <form data-parsley-validate id="bigUser" name="bigUser"
                              action="<c:url value="/pc/saveEnrollUser.do"/>" method="post"
                              onkeypress="if(event.keyCode==13||event.which==13){return false;}" class="am-form">
                            <div class="am-form-group">
                                <div class="controls">
                                    <label for="username">手机号</label>
                                    <input type="text" id="username" name="username"
                                           placeholder="请输入您的手机号"
                                           required/>

                                    <p id="usernameMessage" style="color: red"></p>

                                </div>
                            </div>
                            <%--<div class="col-md-12">--%>
                            <%--<div class="col-md-6">--%>
                            <div class="am-form-group">
                                <div class="controls">
                                    <label for="verification">手机验证</label>

                                    <div class="am-u-md-12" style="padding: 0px;">
                                        <div class="am-u-md-6" style="padding: 0px;">
                                            <input type="text" id="verification" placeholder="短信验证码"
                                                   required/>
                                        </div>
                                        <div class="am-u-md-6" style="padding-right: 0px;padding-left: 5px;">
                                            <a class="am-btn form-btn" id="verificationButton" style="margin-top: 0px">点击获取验证码</a>
                                        </div>
                                    </div>
                                    <div class="help-block">
                                        <h5 id="consumerVerificationCodeCheck" style="color: red;display: none">
                                            手机验证码输入错误</h5>
                                    </div>
                                </div>
                            </div>
                            <div class="am-form-group" style="margin-top: 40px;">
                                <div class="controls">
                                    <label for="password">密码</label>
                                    <input type="password" id="password" name="password"
                                           placeholder="密码由6-16位字母或数字组成"
                                           data-parsley-trigger="change"
                                           required/>
                                </div>
                            </div>
                            <div class="am-form-group">
                                <div class="controls">
                                    <label for="passwordAgain">确认密码</label>
                                    <input type="password" id="passwordAgain" class="form-control" name="passwordAgain"
                                           data-parsley-equalto="#password" data-parsley-equalto-message="两次输入不一致"
                                           data-parsley-required="true"
                                           data-parsley-trigger="change"
                                           placeholder="请与上面输入的值一致"
                                           required/>
                                </div>
                            </div>


                            <%--<div class="am-form-group" style="display: none">
                                <div class="controls">
                                    <label for="name">姓名</label>
                                    <input type="text" id="name" class="form-control" name="name"/>
                                </div>
                            </div>--%>
                            <div class="am-form-group" style="display: none">
                                <div class="controls">
                                    <label>邮箱</label>
                                    <input type="email" id="email" class="form-control" name="email"/>
                                </div>
                            </div>
                            <div class="am-form-group" style="display: none">
                                <div class="controls">
                                    <label>电话</label>
                                    <input type="input" id="phone" class="form-control" name="phone"/>
                                </div>
                            </div>

                            <%--<div class="am-form-group">--%>
                            <%--<label for="userRole">选择用户类型</label>--%>
                            <%--<select id="userRole">--%>
                            <%--<option value="consumer">消费者</option>--%>
                            <%--<option value="photographer">摄影师</option>--%>
                            <%--</select>--%>
                            <%--<span class="am-form-caret"></span>--%>
                            <%--</div>--%>

                            <div class="am-form-group" style="margin-top: 25px;margin-top: 17px;">
                                <div class="controls">
                                    <input id="consumerSubmit" type="submit" class="btn btn-primary btn-block"
                                           value="注册"
                                           style="border-color: #db0c5b;background-color: #db0c5b; display: none"/>
                                    <a id="consumerSignin" class="am-btn form-btn">注册</a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>

    var isConsumerCodeRight = false;
    var isVerification = false;

    //验证用户名
    function usernameConfirm(userType) {
        var reg = /^1[3578][0-9]{9}$/;
        var username
        if (userType == "user") {
            username = $("#username").val();
        } else {
            username = $("#photographerUsername").val();
        }
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
                url: '<c:url value="/pc/checkUserName.do"/>',
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
                            $("#usernameMessage").text("用户名已存在!");
                            bool = false;
                        } else {
//                        console.log("用户名不存在");
                            $("#usernameMessage").text("");
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
            o.html("点击获取验证码");//改变按钮中value的值
//        p.html("如果您在1分钟内没有收到验证码，请检查您填写的手机号码是否正确或重新发送");
            wait = 60;
        } else {
            o.attr("disabled", true);//倒计时过程中禁止点击按钮
            o.html(wait + "秒后重新获取验证码");//改变按钮中value的值
            wait--;
            setTimeout(function () {
                        time(o, p);//循环调用
                    },
                    1000)
        }
    }

    function sendVerificationCode(phone) {
        jQuery.ajax({
            type: 'get',
            async: false,
            url: '<c:url value="/pc/verification/send.do"/>',
            dataType: 'json',
            data: {
                phone: phone
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
            url: '<c:url value="/pc/verification/verify.do"/>',
            dataType: 'json',
            data: {
                verificationCode: code,
                phone: phone
            },
            success: function (data) {
               alert(data);
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
            if ($("#username").val() != "") {
                if (usernameConfirm("user")) {
                    sendVerificationCode($("#username").val())
                    time($("#verificationButton"));
                }
            }
        });

        $("#verification").blur(function () {
            checkVerificationCode($("#username").val(), $("#verification").val(), "user");
        });


        $("#consumerSignin").click(function () {
            if (isVerification && bool) {
//                if ($("#userRole").val() == "consumer") {
                $("#consumerSubmit").click();
                alert(111);
//                } else if ($("#userRole").val() == "photographer") {
//                    $("#bigUser").attr("action", "/pc/saveEnrollPhotographer.do");
//                    $("#consumerSubmit").click();
//                }
            } else if (!isVerification) {
                alert(2222)
                $("#consumerVerificationCodeCheck").css("display", "block");
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
