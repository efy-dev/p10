<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/12/23
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <title>期次详情</title>
</head>
<body style="height: auto">
<div style="text-align: left;margin-left: 10px;">
  <input onclick="window.history.go(-1);"
         type="button" class="am-btn am-btn-default am-btn-xs"
         style="margin-top: 4px;margin-bottom: 6px;margin-left:2px;height: 35px;"
         value="返回"/>
</div>
<div class="am-cf am-padding">
  <div class="am-fl am-cf">
    <strong class="am-text-primary am-text-lg">期次详情</strong>
  </div>
</div>
<div am-panel am-panel-default admin-sidebar-panel>
  <table class="am-table am-table-bordered am-table-radius am-table-striped">
    <tr>
      <td>期次名称</td>
      <td>${object.name}</td>
    </tr>
    <tr>
      <td>答题时间</td>
      <td><fmt:formatDate value="${object.expireDate}" pattern="yyyy-MM-dd"/></td>
    </tr>
    <tr>
      <td>题目数量</td>
      <td>${object.questionCount}</td>
    </tr>
    <tr>
      <td>创建时间</td>
      <td><fmt:formatDate value="${object.createDatetime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
    </tr>
  </table>
</div>
</body>
</html>
