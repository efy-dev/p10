<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
  <script type="application/javascript" src="<c:url value="/resources/plugins/parsley/parsley.min.js"/>"></script>
  <script type="application/javascript" src="<c:url value="/resources/plugins/parsley/parsley.remote.min.js"/>"></script>
</head>
<body>
<div class="dentification">
  <div class="short">
    <form>
      <ul>
        <li>
          <label>输入您的手机号</label>
          <input id="phone" class="txt" type="text" placeholder="手机号">
          <span class="active-d span1" id="error"></span>
        </li>
        <li>
          <label>手机验证码</label>
          <input class="txt1" id="code" type="text" placeholder="短信验证码">
          <span class="span-lest1"><button  id="verificationButton"  class="btn-p">获取短信效验码</button></span>
        </li>
        <li>
          <label></label>
          <span class="span-lest2" ><a onclick=checkVerificationCode($("#phone").val(),$("#code").val())>提交</a></span>
          <span class="active-d span1" id="auth"></span>
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
  var wait = 60;//时间
  function time(o, p) {//o为按钮的对象，p为可选，这里是60秒过后，提示文字的改变
    if (wait == 0) {
      o.removeAttr("disabled");
      o.html("点击获取验证码");//改变按钮中value的值
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
    $.ajax({
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
  $().ready(function () {

    $("#verificationButton").click(function () {
      $("#verificationButton").attr("disabled",true);
      var userName = $("#phone").val();
      $.ajax({
        type: 'post',
        async: false,
        url: '<c:url value="/pc/checkUserName.do"/>',
        dataType: 'json',
        data:{
          username:userName
        },
        success: function (data) {
          if(data == false){
            $("#error").text("您输入的用户名不正确");
            $("#verificationButton").removeAttr("disabled");
          }else{
            $("#error").text("");
            sendVerificationCode($("#phone").val())
            time($("#verificationButton"));
          }
        },

      });

    });

    $("#verification").blur(function () {
      checkVerificationCode($("#username").val(), $("#verification").val(), "user");
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
        checkVerificationCode($("#username").val(), $("#verification").val(), "user");
      }
      checkUserName("user");
    });
  });



  function checkVerificationCode(phone, code) {
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
        if (data == true) {
          window.location.href="/setPwd?username="+$("#phone").val();
        }else{
          $("#auth").text("您发送的验证码不正确");

        }
      },
      error: function () {
        console.log("数据获取失败");
      }
    });
  }
</script>
</body>
</html>
