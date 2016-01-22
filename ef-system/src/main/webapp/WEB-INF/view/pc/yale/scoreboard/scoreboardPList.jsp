<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/1/18
  Time: 10:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
  <title>答题排行榜</title>
</head>
<body style="height: auto">
<div style="margin-left: 10px;margin-top: 10px;">
  <form action="<c:url value="/scoreboard/scoreboardPList.do"/>">
    <span style="margin-top: 8px">日期:从</span>
    <input type="text" name="selStartDate"
           value="<fmt:formatDate value='${selStartDate}'  pattern='yyyy-MM-dd'/>"
           data-am-datepicker placeholder="开始日期" readonly/>
    <span style="margin-top: 8px">至</span>
    <input type="text" name="selEndDate"
           value="<fmt:formatDate value='${selEndDate}'  pattern='yyyy-MM-dd'/>"
           data-am-datepicker placeholder="结束日期" readonly/>
    <input type="submit" value="提交">
  </form>
</div>
<hr>
<div>
  <table class="am-table am-table-bordered am-table-radius am-table-striped">
    <tr style="text-align:left">
      <td>微信昵称</td>
      <td>e飞蚁用户名</td>
      <td>答题次数</td>
      <td>累计奖励</td>
      <td>分享次数</td>
      <td>开始日期</td>
      <td>结束日期</td>
    </tr>
    <c:forEach items="${scoreboardList}" var="scoreboard">
      <tr>
        <td>${scoreboard.nickname}</td><%--微信昵称--%>
        <td>${scoreboard.username}</td><%--e飞蚁用户名--%>
        <td>${scoreboard.answerCount}</td><%--答题次数--%>
        <td>${scoreboard.rewardTotal}</td><%--累计奖励--%>
        <td>${scoreboard.shareCount}</td><%--好友帮助次数(有效的分享次数)--%>
        <td><%--开始日期--%>
          <fmt:formatDate value="${scoreboard.startDate}" pattern="yyyy-MM-dd"/>
        </td>
        <td><%--结束日期--%>
          <fmt:formatDate value="${scoreboard.endDate}" pattern="yyyy-MM-dd"/>
        </td>
      </tr>
    </c:forEach>
  </table>
</div>
<div style="clear: both">
  <c:url value="/scoreboard/scoreboardPList.do" var="url"/>
  <ming800:pcPageList bean="${pageEntity}" url="${url}">
    <ming800:pcPageParam name="selStartDate" value="${selStartDate}"/>
    <ming800:pcPageParam name="selEndDate" value="${selEndDate}"/>
  </ming800:pcPageList>
</div>
</body>
</html>
