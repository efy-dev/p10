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
    <script src="/scripts/ckeditor/ckeditor.js"></script>
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
            <input type="hidden" name="status" value="1"/>
            <div class="am-form-group">
                <label for="name" class="am-u-sm-3 am-form-label">姓名拼音 / NamePinYi</label>

                <div class="am-u-sm-9">
                    <input type="text" id="name" name="name" placeholder="姓名拼音 / NamePinYi" value="${object.name}" required>
                </div>
            </div>
            <div class="am-form-group">
                <label for="fullName" class="am-u-sm-3 am-form-label">中文姓名 / FullName</label>

                <div class="am-u-sm-9">
                    <input type="text" id="fullName" name="fullName" placeholder="中文姓名 / FullName"
                           value="${object.fullName}" required>
                </div>
            </div>

            <div class="am-form-group">
                <label class="am-u-sm-3 am-form-label">等级 / Level</label>

                <div class="am-u-sm-9">
                    <ming800:status name="level" dataType="Tenant.level" checkedValue="${object.level}" type="select"/>

                </div>
            </div>


            <div class="am-form-group">
                <label for="birthday" class="am-u-sm-3 am-form-label">出生日期 / Birthday</label>

                <div class="am-u-sm-9">
                    <div class="am-form-group am-form-icon">
                        <i class="am-icon-calendar"></i>
                        <input type="text" id="birthday" name="birthday" class="am-form-field am-input-sm"
                               placeholder="出生日期" value="${object.birthday}">
                    </div>
                </div>
            </div>
            <div class="am-form-group">
                <label for="provinceName" class="am-u-sm-3 am-form-label">籍贯 / ProvinceName</label>

                <div class="am-u-sm-9">
                    <input type="text" id="provinceName" name="provinceName" placeholder="籍贯 / ProvinceName"
                           value="${object.provinceName}" required>
                </div>
            </div>
            <div class="am-form-group">
                <label for="presentAddress" class="am-u-sm-3 am-form-label">现居地/ PresentAddress</label>

                <div class="am-u-sm-9">
                    <input type="text" id="presentAddress" name="presentAddress" placeholder="现居地/ PresentAddress"
                           value="${object.presentAddress}">
                </div>
            </div>
            <div class="am-form-group">
                <label for="sex" class="am-u-sm-3 am-form-label">性别 / Sex</label>

                <div class="am-u-sm-9">
                    <ming800:status name="sex" dataType="Tenant.sex" checkedValue="${object.sex}" type="select" required="true"/>
                </div>
            </div>

            <div class="am-form-group">
                <label for="favicon" class="am-u-sm-3 am-form-label">头像 / Favicon</label>

                <div class="am-u-sm-9">
                    <input type="file" id="favicon" name="favicon" placeholder="头像 / Favicon"
                           value="${object.favicon}">
                </div>
                <c:if test="${!empty object.favicon}">
                    <img src="http://tenant.efeiyi.com/${object.favicon}@!tenant-manage-photo">
                </c:if>
            </div>

            <div class="am-form-group">
                <label for="background" class="am-u-sm-3 am-form-label">背景图片</label>

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
                <label for="user-intro" class="am-u-sm-3 am-form-label">短简介 / Brief</label>

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
