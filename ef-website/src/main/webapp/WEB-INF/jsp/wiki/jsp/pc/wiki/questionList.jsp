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
    <meta name="description" content="中国领先的非物质文化遗产百科全书">
    <meta name="keywords" content="非遗百科,百科,非物质文化遗产,文化遗产,传统技艺,传统美术,e飞蚁,非遗电商,非遗答题">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>微信答题题库</title>
</head>
<body>

<div class="wb fl page-question">
    <div class="wm">
        <ul class="items">
            <c:forEach items="${questions}" var="question" varStatus="status">
                <li>
                    <a href="<c:url value="/minglu/question/${question.id}.html"/>">
                        <img src="<c:url value="${question.pictureUrl}"/>" alt="">
                    </a>
                    <div class="info">
                        <a href="<c:url value="/minglu/question/${question.id}.html"/>"
                           title="">【${status.index+1}】${question.questionContent}</a>
                        <p>${question.answerKnowledge}</p>
                    </div>
                </li>
            </c:forEach>
        </ul>
    </div>
    <div class="page wh">
        <ming800:pcPageList bean="${pageEntity}" url="/minglu/questionList.do">
            <ming800:pcPageParam name="sort"
                                 value='<%=request.getParameter("sort")!=null ? request.getParameter("sort") : ""%>'/>
        </ming800:pcPageList>
    </div>
    <a href="http://minglu.efeiyi.com/question" title="题库地图-非遗百科" style="color: #fff;;">题库地图</a>
</div>

</body>
</html>

