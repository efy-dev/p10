<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改密码</title>
</head>
<body>
<div class="change">
  <div class="enroll">
    <form>
      <div class="start">
        <div class="login">

          <ul class="page">
            <li>
              <label>旧密码</label>
              <input type="password" class="txt" placeholder="请输入旧密码" maxlength="11" onblur="checkPassword(this);">
              <span class="active-d active-cl-si"></span>
            </li>
            <li>
              <label>设置密码</label>
              <input type="password" name="np" class="txt" placeholder="6—16个字符，建议使用字母、数字或符号的组合">
            </li>
            <li>
              <label>重复密码</label>
              <input type="password" name="pwd" class="txt" placeholder="请再次输入密码" onkeydown="checkEq(this);" onkeyup="checkEq(this);">
              <span class="active-d active-cl-si"></span>
            </li>
          </ul>
        </div>
        <div class="edit-info">
          <input type="button" value="确认修改" class="a" onclick="okChange()">
        </div>
      </div>
    </form>
    <!--状态-->
    <%--<div class="imparity" style="display: block;">
      <span>两次密码输入不一致</span>
    </div>--%>
    <!--状态-->
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
    if(flag==true){
      var pwd = $(":input[name='pwd']").val();
      window.location.href="<c:url value="/myEfeiyi/updatePassword.do?id=${user.id}&pwd="/>"+pwd;
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
</script>
</body>
</html>
