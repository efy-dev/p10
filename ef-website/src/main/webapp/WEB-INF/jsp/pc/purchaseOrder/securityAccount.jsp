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
            <input name="np"  type="password" class="userinfo-tex">
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
<!--content-->
<!-- //End--footer-->
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="<c:url value="/scripts/assets/js/jquery.min.js"/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value="/scripts/js/amazeui.ie8polyfill.min.js"/>"></script>
<![endif]-->
<script src="<c:url value="/scripts/js/amazeui.min.js"/>"></script>
<script src="<c:url value="/scripts/js/system.js"/>"></script>

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
