<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
  <title>优惠券</title>
</head>
<body>
<div class="convert ae">
  <form>
    <label>输入兑换码</label>
    <input type="text" class="text" id="cdkey">
    <p id="tx"></p>
    <div class="subtn"><input type="button"   class="btnn" value="提&nbsp;&nbsp;&nbsp;&nbsp;交" onclick="exchangeCoupon()"></div>
  </form>
</div>

<script>
    function exchangeCoupon() {
    var cdkey=$("#cdkey").val()
    $.ajax({
    type: 'post',
    async: false,
    url: '<c:url value="/coupon/exchangeCoupon.do"/>',
    dataType: 'json',
       data:{
          cdkey:cdkey
    },
    success: function(data){
    if(data =="null"){
     $("#tx").html("兑换码输入错误，请核对后再输入！")
    }else{
      $("#tx").html("")

    window.location.href="/getAppCoupon.do?couponId="+data.id;
    }

    },

    });

   }
</script>
</body>
</html>
