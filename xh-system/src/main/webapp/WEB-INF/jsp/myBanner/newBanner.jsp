<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/7
  Time: 13:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@include file="/layouts/public.jsp" %>
<html>
<head>
    <title></title>
</head>
<body>
<div style="text-align: left;margin-left: 10px;">
    <input onclick="window.history.back()"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 8px;margin-bottom: 6px;margin-left:2px;height: 35px;"
           value="返回"/>
</div>
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">添加/编辑顶部轮播图<ming800:status name="group" dataType="announcements.group"
                                                                             checkedValue="${object.group}"
                                                                             type="normal"/></strong>
    </div>
</div>
<hr/>
<div class="am-g">
    <form id="bannerForm" action="<c:url value='/myBanner/saveBanner.do'/>?qm=${requestScope.qm}"
          onsubmit="return afterSubmitForm('documentForm')"
          method="post" enctype="multipart/form-data" class="am-form am-form-horizontal">
        <input value="${object.id}" name="id" type="hidden"/>
        <input value="banner" name="group" type="hidden"/>
        <input value="${object.status}" name="status" type="hidden"/>
        <input value="${object.imageUrl}" name="imageUrl" type="hidden"/>
        <div class="am-form-group">
            <label name="title" for="title" class="am-u-sm-3 am-form-label">标题/title
                <small>*</small>
            </label>

            <div class="am-u-sm-9">
                <input type="text" name="title" id="title" placeholder="title" value="${object.title}" required="true">
            </div>
        </div>

        <div class="am-form-group">
            <label name="bannerOrder" for="bannerOrder" class="am-u-sm-3 am-form-label">展示顺序
                <small>*</small>
            </label>

            <div class="am-u-sm-9">
                <input type="number" name="bannerOrder" id="bannerOrder" placeholder="bannerOrder"
                       value="${object.bannerOrder}" required="true">
            </div>
        </div>

        <div class="am-form-group">
            <label name="directUrl" for="directUrl" class="am-u-sm-3 am-form-label">链接地址
                <small>&nbsp;&nbsp;</small>
            </label>
            <div class="am-u-sm-9">
                <input type="text" name="directUrl" id="directUrl" placeholder="directUrl" value="${object.directUrl}">
            </div>
        </div>

        <div class="am-form-group">
            <label for="image" class="am-u-sm-3 am-form-label">轮播图/Banner
                <small>&nbsp;&nbsp;</small>
            </label>

            <div class="am-u-sm-9">
                <input type="file" id="image" name="image" placeholder="">
            </div>
        </div>
        <div class="am-form-group">
            <label class="am-u-sm-3 am-form-label"><small></small></label>
            <div class="am-u-sm-9">
                <c:if test="${!empty object.imageUrl}">
                    <img src="${object.imageUrl}<%=imgFormCSS %>">
                </c:if>
            </div>
        </div>

        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="submit" class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>
    </form>
</div>
<script src="<c:url value='http://libs.baidu.com/jquery/1.11.3/jquery.min.js'/>"></script>
</body>
</html>
