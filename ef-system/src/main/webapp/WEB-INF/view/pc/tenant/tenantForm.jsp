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
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<body>

<div class="am-g">

    <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8">
        <div class="am-panel am-panel-default">
        </div>
    </div>

    <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
        <form action="<c:url value="/basic/xmm.do"/>" method="post" class="am-form am-form-horizontal"
              enctype="multipart/form-data">
            <input type="hidden" value="saveOrUpdateTenant" name="qm">
            <input type="hidden" name="id" value="${object.id}">
            <div class="am-form-group">
                <label for="name" class="am-u-sm-3 am-form-label">姓名拼音</label>

                <div class="am-u-sm-9">
                    <input type="text" id="name" name="name" placeholder="姓名拼音 / NamePinYi" value="${object.name}" required>
                </div>
            </div>
            <div class="am-form-group">
                <label for="fullName" class="am-u-sm-3 am-form-label">中文姓名</label>

                <div class="am-u-sm-9">
                    <input type="text" id="fullName" name="fullName" placeholder="中文姓名 / FullName"
                           value="${object.fullName}" required>
                </div>
            </div>

            <div class="am-form-group">
                <label for="background" class="am-u-sm-3 am-form-label">背景图片(移动网站背景图片)</label>

                <div class="am-u-sm-9">
                    <input type="file" id="background" name="background" placeholder="背景图片"
                           value="${object.backgroundUrl}">
                </div>
                <c:if test="${!empty object.backgroundUrl}">
                    <img src="http://tenant.efeiyi.com/${object.backgroundUrl}@!tenant-manage-photo">
                </c:if>
            </div>


            <div class="am-form-group">
                <label for="logo" class="am-u-sm-3 am-form-label">Logo</label>

                <div class="am-u-sm-9">
                    <input type="file" id="logo" name="logo" placeholder="Logo"
                           value="${object.logoUrl}">
                </div>
                <c:if test="${!empty object.logoUrl}">
                    <img src="http://tenant.efeiyi.com/${object.logoUrl}@!tenant-manage-photo">
                </c:if>
            </div>

            <div class="am-form-group">
                <label for="user-intro" class="am-u-sm-3 am-form-label">短简介</label>

                <div class="am-u-sm-9" style="text-align: left;">
                    <textarea class="" cols="6" name="brief" rows="2" id="user-intro" placeholder="输入短简介,限30字以内">${object.brief}</textarea>
                    <small>输入短简介,限30字以内</small>
                </div>
            </div>

            <div class="am-form-group">
                <div class="am-u-sm-9 am-u-sm-push-3">
                    <button type="submit" class="am-btn am-btn-primary">保存</button>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>
