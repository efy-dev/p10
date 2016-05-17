<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/5/13
  Time: 17:30
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
  <title>微信答题题库</title>
  <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/assets/css/amazeui.min.css"/>">
  <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/assets/css/layout.css"/>">
</head>
<body>

<div class="wb fl page-question">
  <div class="wm">
    <ul class="items">
      <c:forEach items="${questions}" var="question" varStatus="status" >
      <li>
        <a href="<c:url value="/question/${question.id}"/>">
        <img src="<c:url value="${question.pictureUrl}"/>" alt="">
        </a>
        <div class="info">
          <a href="<c:url value="/question/${question.id}"/>" title="">【${status.index+1}】${question.questionContent}</a>
          <p>${question.answerKnowledge}</p>
        </div>
      </li>
      </c:forEach>
    </ul>
  </div>
  <div class="page wh">
    <ming800:pcPageList bean="${pageEntity}" url="/questionList.do">
      <ming800:pcPageParam name="sort"
                           value='<%=request.getParameter("sort")!=null ? request.getParameter("sort") : ""%>'/>
    </ming800:pcPageList>
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

