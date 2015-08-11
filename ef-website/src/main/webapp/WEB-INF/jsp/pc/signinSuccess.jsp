<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/1/10
  Time: 16:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>

<div class="am-g am-g-fixed" style="text-align: center;margin-bottom: 150px;margin-top: 150px">

    <div><span style="padding-right: 4px;color: #8cc5fb;font-size: 16px;">${user.username}</span>注册成功注册成功</div>
    <div><span id="time" style="padding-right: 4px;color: #8cc5fb;font-size: 34px;font-weight: bold;">5</span>秒后跳转到登录页面
    </div>
</div>
<script>
    var wait = 5;//时间
    function time() {//o为按钮的对象，p为可选，这里是60秒过后，提示文字的改变
        if (wait == 0) {
            window.location.href = "/pc/login.do?enrollUsername=${user.username}";
            wait = 5;
        } else {
//            o.attr("disabled", true);//倒计时过程中禁止点击按钮
//            o.html(wait + "秒后重新获取验证码");//改变按钮中value的值
            wait--;
            $("#time").html(wait);
            setTimeout(function () {
                        time();//循环调用
                    },
                    1000)
        }
    }

    $().ready(function () {
        time();
    })

</script>
</body>
</html>
