<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
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
      <strong><img src="<c:url value="/scripts/wap/upload/yonghm.jpg"/>" alt="..." class="am-img-thumbnail"></strong>
    </div>
    <div class="personal-list">
      <form>
        <ul>
          <li>用户名 :<span>${user.username}</span></li>
          <li>昵称 :<span>${user.name2}</span></li>
          <li>性别 :<span>${user.sex}</span></li>
          <li>出生日期 :<span>${user.birthDate}</span></li>
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
