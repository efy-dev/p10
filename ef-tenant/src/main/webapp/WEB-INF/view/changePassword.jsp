<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title></title>
  <script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/>" ></script>
</head>
<body>
<script >
  $(function(){
    console.log('${param.param}');
  })
</script>
<div class="am-cf am-padding">
  <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">修改密码</strong> /
    <small>Change Password</small>
  </div>
</div>
<hr/>
<div class="am-g admin-content">
    <form action="<c:url value="/basic/xmm.do"/>" method="post" class="am-form am-form-horizontal"
          enctype="multipart/form-data">
     <input type="hidden" name="id" value="${userId}"/>

      <div class="am-form-group">
        <label for="rePassword" class="am-u-sm-3 am-form-label">原始密码</label>
        <div class="am-u-sm-9">
          <input type="password" id="rePassword" name="rePassword" onblur="IsPassword(this);" placeholder="原始密码" value="" required>
          <small id="IsPassword" style="color: red"></small>
        </div>
      </div>
      <div class="am-form-group">
        <label for="password" class="am-u-sm-3 am-form-label">设置新密码</label>

        <div class="am-u-sm-9">
          <input type="password" id="password" onkeydown="checkNewPassword();" onkeyup="checkNewPassword();" name="password" placeholder="新密码"
                 value="" required>
        </div>
      </div>

      <div class="am-form-group">
        <label class="am-u-sm-3 am-form-label">重复新密码</label>

        <div class="am-u-sm-9">
          <input type="password" id="newPassword" onkeydown="checkNewPassword();" onkeyup="checkNewPassword();" name="newPassword" placeholder="重复新密码"
                 value="" required>
          <small id="IsSame" style="color: red"></small>
        </div>
      </div>

      <div class="am-form-group">
        <div class="am-u-sm-9 am-u-sm-push-3">
          <button type="button" onclick="SavePassword();" class="am-btn am-btn-primary">保存</button>
        </div>
      </div>
    </form>

</div>
<script>
  function checkNewPassword(){
    var password = $("#password").val();
    var newPassword = $("#newPassword").val();
    if(password == newPassword ){
          $("#IsSame").text("");
    }else{
          $("#IsSame").text("两次新密码不一致!");
    }
  }

  function IsPassword(){
    var rePassword = $("#rePassword").val();
    $.ajax({
      type:"GET",
      url:'<c:url value="/sign/checkPassword.do"/>',
      data:{password:rePassword},
      dataType:"json",
      success:function(data){
       if(data){
         $("#IsPassword").text("");
       }else{
         $("#IsPassword").text("原始密码不正确!");
       }
      }
    });
  }

  function SavePassword(){
    if($("#IsPassword").text()!=""){
      alert($("#IsPassword").text());
    }else if($("#IsSame").text()!=""){
      alert($("#IsSame").text());
    }else{
     var pass = $("#password").val();
      $.ajax({
        type:"GET",
        url:'<c:url value="/sign/SavePassword.do"/>',
        data:{password:pass},
        dataType:"json",
        success:function(data){
          if(data){
            alert("修改成功!");
          }else{
            alert("修改失败!");
          }
        }
      });
    }
  }
</script>
</body>
</html>
