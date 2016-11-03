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
    <meta name="keywords" content="${question.questionContent},非遗百科,百科,非物质文化遗产,文化遗产,传统技艺,传统美术,e飞蚁,非遗电商,前门,前门大街"/>
    <meta name="description"
          content="${question.answerKnowledge},中国领先的非物质文化遗产百科全书"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>${question.questionContent}</title>
</head>
<body>
<div class="wb fl page-question">
    <div class="wm">
        <div class="details">
            <div class="return">
                <a href="<c:url value="/minglu/questionList.do"/>" title=""><i class="icon"></i>返回上一级</a>
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
                    <img src="<c:url value="${question.pictureUrl}"/>" alt="${question.questionContent}">
                </div>
            </div>
        </div>
    </div>
    <a href="http://minglu.efeiyi.com/question" title="题库地图-非遗百科" style="color: #fff;;">题库地图</a>
</div>

</body>
</html>

