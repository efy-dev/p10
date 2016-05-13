<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/5/13
  Time: 19:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>${question.questionContent}</title>
  <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/assets/css/amazeui.min.css"/>">
  <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/assets/css/layout.css"/>">
</head>
<body>
<div class="wb fl page-question">
  <div class="wm">
    <div class="details">
      <div class="return">
        <a href="<c:url value="/questionList.do"/>" title=""><i class="icon"></i>返回上一级</a>
      </div>
      <div class="contain">
        <div class="info">
          <h1>${question.questionContent}</h1>
          <div class="text">
            <p>${question.answerKnowledge}</p>
          </div>
        </div>
        <!--//End--info-->
        <div class="imgsq">
          <img src="<c:url value="/${question.pictureUrl}"/>" alt="">
        </div>
      </div>
    </div>
  </div>
</div>
<!--//End--非遗题库-->



<!--//End--homenew-->
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="shop2016/js/jquery.min.js"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value="/scripts/assets/js/amazeui.ie8polyfill.min.js"/>"></script>
<![endif]-->



<script src="shop2016/js/system.js"></script>
</body>
</html>

