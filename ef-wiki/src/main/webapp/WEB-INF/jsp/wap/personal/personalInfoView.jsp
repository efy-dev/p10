<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>个人信息</title>
</head>
<body>
<!--//End--header-->
<div class="personal-material">
  <div class="personal">
    <div class="material">
      <strong><img src="<c:url value="/scripts/assets/wap/upload/yonghm.jpg"/>" alt="..." class="am-img-thumbnail"></strong>
    </div>
    <div class="personal-list">
      <form>
        <ul>
          <li>用户名 :<span>${user.username}</span></li>
          <li>昵称 :<span>${user.name2}</span></li>
          <li>性别 :<span>
          <c:if test="${user.sex == '1'}">
            男
          </c:if>
          <c:if test="${user.sex == '2'}">
            女
          </c:if>
          </span></li>
          <li>出生日期 :<span><fmt:formatDate value="${user.birthDate}" pattern="yyyy-MM-dd"/></span></li>
        </ul>
      </form>
    </div>
  </div>
  <div class="edit-info">
    <a href="/myEfeiyi/personalInfoOfMobile.do">编辑信息</a>
  </div>
</div>
</body>
</html>
