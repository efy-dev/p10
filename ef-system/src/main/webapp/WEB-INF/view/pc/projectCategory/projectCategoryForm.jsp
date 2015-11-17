<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title></title>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">新建/编辑类别</strong> / <small>New/Edit Category</small></div>
</div>
<hr/>

<div class="am-g">
    <form action="<c:url value="/basic/xmm.do"/>"  class="am-form am-form-horizontal" method="post" enctype="multipart/form-data">
        <input type="hidden" name="qm" value="saveOrUpdateProjectCategory">
        <input type="hidden" name="id" value="${object.id}">
        <input type="hidden" name="status" value="1" />
        <input type="hidden" name="fatherCategory.id" value="${fatherCategoryId}">
        <input type="hidden" name="level" value="${level}" />
        <div class="am-form-group">
            <label name="name" for="user-name" class="am-u-sm-3 am-form-label">类别名称 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="name" id="user-name" placeholder="项目名称" value="${object.name}" >
            </div>
        </div>
        <div class="am-form-group">
            <label name="serial" for="serial" class="am-u-sm-3 am-form-label">类别编号 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="serial" id="serial" placeholder="项目编号" value="${object.serial}" >
            </div>
        </div>
        <div class="am-form-group">
            <label for="pictureUrl" class="am-u-sm-3 am-form-label">Logo</label>

            <div class="am-u-sm-9">
                <input type="file" id="pictureUrl" name="pictureUrl" placeholder="pictureUrl"
                       value="${object.pictureUrl}" >
            </div>
            <c:if test="${!empty object.pictureUrl}">
                <img src="http://pro.efeiyi.com/${object.pictureUrl}@!product-model">
            </c:if>
        </div>

        <div class="am-form-group">
            <label for="context" class="am-u-sm-3 am-form-label">类别简介</label>

            <div class="am-u-sm-9">
                <textarea id="context" name="context" placeholder="限200字以内" rows="3" cols="4">${object.context}</textarea>
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
