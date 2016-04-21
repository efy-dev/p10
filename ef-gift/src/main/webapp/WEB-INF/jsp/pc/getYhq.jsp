<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head></head>

<body>
<script>

  $(function(){

  var s= setInterval(couponTime,1000);
    var index=5;
    function couponTime(){
      if(index>0){
        index--;
        $("#sj").html(index);
        $("#xj").html(index);

      }else{
        index=0;
        clearInterval(s);
        window.location.href = "http://www.efeiyi.com";

      }
    }
  })


</script>
  <div class="coupons">
    <c:if test="${yhq!=null && yhq!='used'}">
      <c:set var="price" value="${yhq.couponBatch.price}"/>
      <div class="celebrate">
      <h5>恭喜您，抢到${fn:substringBefore(price, ".")}元优惠券！<i class="icon"></i></h5>
      <div class="ae mg">
        <p>优惠券将于5-10分钟后，发送到您的个人账户，请注意查收呦~</p>
        <p><span id="sj">5</span>秒后为您自动跳转</p>
      </div>
      <div class="act">
        <a href="http://www.efeiyi.com" class="btn1 left">返回首页</a>
        <a href="http://www.efeiyi.com" class="btn1 right">关闭页面</a>
      </div>
    </div>
      </c:if>
    <c:if test="${yhq==null || yhq=='used'}">
      <div class="celebrate">
        <c:if test="${yhq==null}">
        <h5>没有找到该链接的活动，请您看一下其他活动吧~<i class="icon"></i></h5>
        </c:if>
        <c:if test="${yhq=='used'}">
          <h5>您已经领取过该优惠券了哟~<i class="icon"></i></h5>
        </c:if>
        <div class="ae mg">
          <p><span id="xj">5</span>秒后为您自动跳转</p>
        </div>
        <div class="act">
          <a href="http://www.efeiyi.com" class="btn1 left">返回首页</a>
          <a href="http://www.efeiyi.com" class="btn1 right">关闭页面</a>
        </div>
      </div>
    </c:if>

  </div>

</body>

</html>

