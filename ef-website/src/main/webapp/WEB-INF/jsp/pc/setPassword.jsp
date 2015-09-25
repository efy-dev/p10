<%@ page import="com.ming800.core.util.StringUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head></head>
<body>
<div class="new">
  <div class="short">
    <form>
      <ul>
        <li>
          <label>设置新密码</label>
          <input name="np" class="txt" type="password" placeholder="请输入新密码"onblur="checkLg(this);">
          <span class="active-d span2"></span>
        </li>
        <li>
          <label>重复新密码</label>
          <input name="pwd" class="txt" type="password" placeholder="请重复输入新密码" onkeydown="checkEq(this);" onkeyup="checkEq(this);">
          <span class="active-d span2"></span>
        </li>
        <li>
          <label></label>
          <span class="span-lest2"><a onclick="okChange()">保存并登录</a></span>
        </li>
      </ul>
    </form>
  </div>
</div>
<!-- //End--footer-->
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="<c:url value="/scripts/js/jquery.min.js"/>"></script>
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
    var np= $(":input[name='np']").val();
    var pwd= $(":input[name='pwd']").val();
    $(".active-d").each(function(){
      if($(this).text()!="" || np=="" || pwd==""){
        flag = false;
        return false;
      }
    });
    if(flag==true){
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
    if(lg<5 || lg>16){
      $(obj).next("span").text("密码由6位-16位字母或数字组成");
    }else{
      $(obj).next("span").text("");

    }
  }
</script>
</body>
</html>
