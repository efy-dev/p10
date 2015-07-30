<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
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
  <form action="/basic/xm.do" method="post"  class="am-form am-form-horizontal">
    <input type="hidden" name="qm" value="saveOrUpdateRole">
    <input type="hidden" name="id" value="${object.id}">
    <input type="hidden" name="status" value="1">
    <input type="hidden" name="resultPage" value="redirect:/basic/xm.do?qm=plistRole_default" />
    <div class="am-form-group">
      <label name="name" for="name" class="am-u-sm-3 am-form-label">角色名称 <small>*</small></label>
      <div class="am-u-sm-9">
        <input type="text" name="name" id="name" placeholder="角色名称" value="${object.name}">
      </div>
    </div>
    <div class="am-form-group">
      <label name="basicType" for="basicType" class="am-u-sm-3 am-form-label">角色类型 <small>*</small></label>
      <div class="am-u-sm-9">
        <ming800:status name="basicType" dataType="Role.basicType" checkedValue="${object.basicType}" type="select" />
      </div>
    </div>
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
