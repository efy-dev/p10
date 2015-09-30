<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<!doctype html>
  < class="no-js">
  <head></head>
  <body>
  <!--//End--header-->
  <div class="enroll">
    <form>
      <div class="start">
        <div class="login">
          <ul class="page">
            <li>
              <label>新密码</label>
              <input name="np" type="password" class="txt" placeholder="6—16个字符，建议使用字母、数字或符号的组合"onblur="checkLg(this);">
              <span class="active-d span2"></span>
            </li>
            <li>
              <label>重复密码</label>
              <input name="pwd" type="password" class="txt" placeholder="请再次输入密码" onkeydown="checkEq(this);" onkeyup="checkEq(this);">
              <span class="active-d span2"></span>
            </li>
          </ul>
        </div>
        <div class="edit-info">
          <input type="button" value="保存并登陆" class="a" onclick="okChange()">
        </div>
      </div>
    </form>
  </div>
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
        <%--window.location.href="<c:url value="/myEfeiyi/updatePassword.do?id=${user.id}&pwd="/>"+pwd;--%>
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
      var ch= $(":input[name='np']").val();
      var reg = /^[0-9a-zA-Z]+$/;
      if(lg<5 || lg>16 || !reg.test(ch)){
        $(obj).next("span").text("密码由6位-16位数字或字母组成");
      }else{
        $(obj).next("span").text("");

      }
    }

  </script>
  </body>


</html>
