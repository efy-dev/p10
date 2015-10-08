<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/10/8
  Time: 10:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<!doctype html>
<html class="no-js">
<head>
  <title>申报状态</title>
</head>
<body>
<div class="slide-right">
  <div class="examined">
    <c:if test="${empty object}">
      <c:if test="${type == 'masterApply'}">
        <div class="title">所查询的申报传承人不存在!</div>
      </c:if>
      <c:if test="${type == 'projectApply'}">
        <div class="title">所查询的申报项目不存在!</div>
      </c:if>
    </c:if>
    <c:if test="${not empty object}">
      <div class="title">
        <ming800:status name="status" dataType="document.status" checkedValue='${object.status}' type="normal"/>
      </div>
      <div class="txt-info">
        <p></p>
        <c:if test="${type == 'masterApply'}">
          <p>申报传承人：${object.name}</p>
        </c:if>
        <c:if test="${type == 'projectApply'}">
          <p>申报项目：${object.name}</p>
        </c:if>
        <p></p>
        <p class="ps">PS:请保持通话畅通,工作人员会及时与您联系!</p>
      </div>
    </c:if>
  </div>
</div>
<!-- //End--slide-right-->
</body>
</html>
