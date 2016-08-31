<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>个人中心</title>
</head>
<body>
<!-- //End--header-->
<!--content-->
    <div class="layout-col">
      <div class="mt wh1">
        <div class="extra-l">
          <strong>修改密码</strong>
        </div>
      </div>
      <!-- //End--information-->
      <div class="password">
        <ul>
          <li>
            <label>账号：</label>
            <span>${user.username}</span>
          </li>
          <li>
            <label>现密码：</label>
            <input type="password" flag = "false" class="userinfo-tex" onblur="checkPassword(this);">

             <span class="active-d"></span>

          </li>
          <li>
            <label>新密码：</label>
            <input name="np"  type="password" class="userinfo-tex" onblur="checkLg(this);">
            <span class="active-d"></span>
          </li>
          <li>
            <label>确定密码：</label>
            <input type="password" name="pwd" class="userinfo-tex" onkeydown="checkEq(this);" onkeyup="checkEq(this);">
            <span class="active-d"></span>
          </li>
          <li>
            <label></label>
            <input type="button" class="dj-btn" value="确定修改" onclick="okChange()">
          </li>
        </ul>
      </div>
      <!-- //End--title-->
    </div>
  </div>
</div>


<script>
  function okChange(){
    var  flag = true;
    $(".active-d").each(function(){
      if($(this).text()!=""){
        flag = false;
        return false;
      }

    });
    var np = $(":input[name='np']").val();
    var op= $(":input[name='op']").val();
    var pwd= $(":input[name='pwd']").val();

    if(flag==true && np!="" && op != "" && pwd !=""){
      var pwd = $(":input[name='pwd']").val();
      $.ajax({
        type:"post",
        dataType:"json",
        url:"/myEfeiyi/updatePassword.do",
        data:{pwd:pwd,id:'${user.id}'},
        success:function(data){
          window.location.href="<c:url value="/sso.do"/>";
        }
      });
    }
  }
  function checkPassword(obj){

    var newPassword = $(obj).val();
    $.ajax({
      type: 'post',
      async: false,
      url: '<c:url value="/myEfeiyi/checkPassword.do"/>',
      dataType: 'json',
      data:{
        password:newPassword
      },
      success: function (data) {
       if(data == false){
            $(obj).next("span").text("您输入的密码与原密码不一致");
       }else{
         $(obj).next("span").text("");
       }
      },

    });

  }

  function checkEq(obj){

    var np = $(":input[name='np']").val();
    var newPassword = $(obj).val();
    if(np != newPassword){
      $(obj).next("span").text("您输入的两次密码不一致");
    }else{
      $(obj).next("span").text("");
    }

  }

  function checkLg(obj){
    var lg= $(":input[name='np']").val().length;
    var ch= $(":input[name='np']").val();
    var reg = /^[0-9a-zA-Z]+$/;
    if(lg<6 || lg>16 || !reg.test(ch)){
      $(obj).next("span").text("密码由6位-16位数字或字母组成");
    }else{
      $(obj).next("span").text("");

    }
  }
</script>



</body>
</html>
