<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>个人信息修改</title>
</head>
<body>
<!--//End--header-->
<div class="edit-personal">
  <div class="personal-material">
    <form action="<c:url value="/myEfeiyi/updatePersonalInfo.do"/>" method="post">
      <div class="personal">
        <div class="material">
          <strong><img src="<c:url value="/scripts/assets/wap/upload/yonghm.jpg"/>" alt="..." class="am-img-thumbnail"></strong>
        </div>
        <div class="edit-material">
          <ul>
            <li>
              <label>用户名</label>
              <input type="text" name="username" value="${user.username}">
            </li>
            <li>
              <label>昵称</label>
              <input type="text" name="name2" value="${user.name2}">
            </li>
            <li>
              <ul class="sex">
              <label>性别</label>
              <c:if test="${user.sex==1}">
                <li class="sex1">
                  <label class=" sex2">
                    <input type="radio" name="sex" value="1" class="sex2" checked> 男
                  </label>
                </li>
              </c:if>
              <c:if test="${user.sex !=1}">
                <li class="sex1">
                  <label class=" sex2">
                    <input type="radio" name="sex" value="1" class="sex2"> 男
                  </label>
                </li>
              </c:if>
              <c:if test="${user.sex == 2}">
                <li  class="sex1 ot-amg">
                  <label class=" sex2">
                    <input type="radio" name="sex" value="2"  class="sex2" checked> 女
                  </label>
                </li>
              </c:if>
              <c:if test="${user.sex != 2}">
                <li  class="sex1 ot-amg">
                  <label class=" sex2">
                    <input type="radio" name="sex" value="2"  class="sex2"> 女
                  </label>
                </li>
              </c:if>
              </ul>
            </li>
            <li>
              <label>出生日期</label>
              <div class="am-input-group am-datepicker-date" data-am-datepicker="{format: 'yyyy-mm-dd'}">
                <input type="text" class="am-form-field" placeholder="年月日" readonly name="birthDate" value="<fmt:formatDate value="${user.birthDate}" pattern="yyyy-MM-dd"/>">
                                    <span class="am-input-group-btn am-datepicker-add-on">
                                            <button class="am-btn am-btn-default" type="button">
                                              <span class="am-icon-rq"></span>
                                            </button>
                                    </span>
              </div>
            </li>
          </ul>

        </div>
      </div>
      <input type="hidden" name="id" value="${user.id}" >
      <div class="edit-info">
        <input type="submit" value="保存信息" class="a">
      </div>
    </form>
  </div>
</div>
</body>
</html>
