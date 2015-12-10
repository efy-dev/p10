<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head></head>
<body>
<div class="wh">
  <div class="help-order">
    <div class="title ae"><p>
      <c:forEach items="${document}" var="document">
        ${document.title}
      </c:forEach>
    </p></div>
    <div class="page ae">
      <div class="left bk">
        <dl class="ae">
          <dt><a href="<c:url value="/document/aboutUs?group=ec.gywm"/>">关于我们</a></dt>
        </dl>
        <dl class="ae">
          <dt><a href="<c:url value="/document/aboutUs?group=ec.ptys"/>">平台优势</a></dt>
        </dl>
        <dl class="ae">
          <dt><a href="<c:url value="/document/aboutUs?group=ec.cpyc"/>">诚聘英才</a></dt>
        </dl>
        <dl class="ae">
          <dt><a href="<c:url value="/document/aboutUs?group=ec.lxwm"/>">联系我们</a></dt>
        </dl>
        <dl class="ae">
          <dt><a href="<c:url value="/document/aboutUs?group=ec.yjfk"/>">意见反馈</a></dt>
        </dl>
        <dl class="ae">
          <dt><a href="<c:url value="/document/aboutUs?group=ec.fyjj"/>">非遗简介</a></dt>
        </dl>
      </div>
      <div class="right bk">
        <c:forEach items="${document}" var="document">
          ${document.documentContent.content}
        </c:forEach>
      </div>
    </div>
  </div>
</div>
</body>
</html>
