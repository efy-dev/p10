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
<div class="am-g am-g-fixed" style="max-width: 636px;">
    <div class="am-u-md-12" style="box-shadow: 0px 0px 2px #626262;">
        <div class="am-u-md-12" style="text-align: center ;"><h2 style=" margin-top: 1.6rem;">e飞蚁 商家注册</h2></div>
        <form class="am-form am-form-horizontal" action="<c:url value="/sign/Register.do"/>" method="post" id="form" >
            <div class="am-form-group">
                <div class="am-u-sm-10" style="margin-left: 87px;">
                    <span style="padding: 10px;">
                      <input type="radio" name="tenantType" value="13" checked="checked" />
                        企业
                    </span>
                    <span style="padding: 10px;">
                      <input type="radio" name="tenantType" value="12" />
                        个体
                    </span>
                    <span style="padding: 10px;">
                      <input type="radio" name="tenantType" value="11" />
                        个人
                    </span>
                </div>
            </div>

            <div class="am-form-group">
                <label for="username" class="am-u-sm-2 am-form-label">用户名</label>

                <div class="am-u-sm-10">
                    <input type="text" name="username" id="username" onblur="checkUserName()" placeholder="输入用户名">
                    <small name="message" style="color: red"></small>
                </div>
            </div>

            <div class="am-form-group">
                <label for="password" class="am-u-sm-2 am-form-label">密码</label>

                <div class="am-u-sm-10">
                    <input type="password" name="password" id="password" placeholder="输入密码">
                </div>
            </div>

            <div class="am-form-group">
                <label for="RePassword" class="am-u-sm-2 am-form-label">重复密码</label>

                <div class="am-u-sm-10">
                    <input type="password" name="rePassword" onkeydown="checkPassword()" onkeyup="checkPassword()" id="RePassword" placeholder="输入密码">
                    <small name="message" style="color: red"></small>
                </div>
            </div>

            <div class="am-form-group">
                <div class="am-u-sm-10" style="margin-left: 16%;">
                    <small>
                      <input type="checkbox" name="agree" onchange="checkAgree()" />
                      <a href="#">同意《“e飞蚁”开发平台在线服务协议》</a>
                    </small>
                </div>
            </div>


            <div class="am-form-group">
                <div class="am-u-sm-10 am-u-sm-offset-2">
                    <span>
                        <button type="button" id="register" onclick="checkRegister()"  class="am-btn am-btn-default" disabled="disabled">完成注册,马上登录</button>
                    </span>
                    <small>
                        已有账号?去<a href="<c:url value="/login.do"/>">登录</a>
                    </small>
                    <%--<span>--%>
                        <%--<button type="submit" class="am-btn am-btn-default">登录</button>--%>
                    <%--</span>--%>
                </div>
            </div>
        </form>
    </div>
 </div>
<script type="text/javascript">


    /**验证用户唯一*/
    function checkUserName(){
        var  username = $("#username").val();
        if(username==""){
            $("#username").next("small").text("用户名不能为空!");
        }else{
            $.ajax({
                type:"post",
                url: '<c:url value="/sign/checkUsername.do"/>',
                cache: false,
                data:{username:username},
                dataType: "json",
                success:function(data){
                    if(data){
                        $("#username").next("small").text("用户名已存在!");
                    }else{
                        $("#username").next("small").text("");
                    }
                }
            });
        }

    }

    //检验两次密码是否一致
    function checkPassword(){
        if($("#password").val()!=$("#RePassword").val()){
            $("#RePassword").next("small").text("两次密码不一致!");
        }else{
            $("#RePassword").next("small").text("");
        }
    }


    //注册验证
    function checkRegister(){
        var  flag = true;
        $("small[name='message']").each(function(){
             if($(this).text()!=""){
                 alert
                 flag = false;
                 return false;
             }
        });
        if(flag){
            alert("d");
            $("#form").submit();
        }else{
            alert("所填信息有误,无法注册!");
        }
    }

    //同意条约
    function checkAgree(){
        if($("input[type='checkbox']").is(":checked")){
            $("#register").removeAttr("disabled");
        }else{
            $("#register").attr("disabled","disabled");
        }
    }

</script>
</body>
</html>
