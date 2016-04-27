<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 17:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<div style="margin:0 auto; text-align:center">
 <c:if test="${result=='true'}">
     <h2>保存成功</h2>
 </c:if>
 <c:if test="${result=='false'}">
     <h2>保存失败</h2>
 </c:if>
 <div id="info"><span style="color: red;font-size: large;font-weight: bold">5</span>秒之后自动跳转到新建作品页面</div>
</div>
  <script>
      var time = 6;
      function lock(){
          time--;
         $("#info").html("<span style='color: red;font-size: large;font-weight: bold'>"+time+"</span>"+"秒之后自动跳转到新建作品页面");
          if(time==0){
              window.location.href = "<c:url value="/master/addWork.do?name=${name}" />";
          }
      }

      setInterval("lock()",1000);
  </script>
</body>
</html>
