<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title></title>
</head>
<body>
<div class="am-cf am-padding">
  <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">新建/编辑角色</strong> / <small>New/Edit Role</small></div>
</div>
<hr/>

<div class="am-g">
  <form action="<c:url value="/basic/xm.do"/>" method="post"  class="am-form am-form-horizontal">
    <input type="hidden" name="qm" value="saveOrUpdateRole">
    <input type="hidden" name="id" value="${object.id}">
    <input type="hidden" name="status" value="1">

    <input type="hidden" name="resultPage" value="redirect:/basic/xm.do?qm=plistRole_default" />
    <div class="am-form-group">
      <label name="name" for="name" class="am-u-sm-3 am-form-label">角色名称 <small>*</small></label>
      <div class="am-u-sm-9">
        <input type="text" name="name" id="name" placeholder="角色名称" value="${object.name}" required>
      </div>
    </div>
      <div class="am-form-group">
          <label name="cname" for="cname" class="am-u-sm-3 am-form-label">中文名称<small>*</small></label>
          <div class="am-u-sm-9">
              <input type="text" name="cname" id="cname" placeholder="中文名称" value="${object.cname}">
          </div>
      </div>
    <c:if test="${empty object.id}">
      <div class="am-form-group">
        <label name="basicType" for="basicType" class="am-u-sm-3 am-form-label">角色类型 <small>*</small></label>
        <div class="am-u-sm-9">
          <ming800:status name="basicType" dataType="Role.basicType" checkedValue="${object.basicType}" type="select"  />
        </div>
      </div>
    </c:if>
    <c:if test="${not empty object.id}">
      <input type="hidden" name="basicType" value="${object.basicType}">
    </c:if>

    <div class="am-form-group">
      <div class="am-u-sm-9 am-u-sm-push-3">
        <input type="submit" class="am-btn am-btn-primary" value="保存"/>
      </div>
    </div>
  </form>
</div>
<!-- content end -->
<hr/>


</body>
</html>
