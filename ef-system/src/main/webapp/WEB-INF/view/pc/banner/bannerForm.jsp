
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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title></title>
</head>
<body>
<div class="admin-content">
    <div class="am-g">

        <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8"><%--少了这个div就出错--%>
        </div>

        <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
            <form action="<c:url value="/basic/xmm.do"/>" method="post" enctype="multipart/form-data" class="am-form am-form-horizontal">
                <input type="hidden" name="id" value="${object.id}">
                  <input type="hidden" name="group" value="${groupName}">
                <input type="hidden" name="bucket" value="${bucket}">
                <c:if test="${empty object.bannerOrder}">
                    <input type="hidden" name="bannerOrder" value="1">
                </c:if>
                <c:if test="${not empty object.bannerOrder}">
                    <input type="hidden" name="bannerOrder" value="${object.bannerOrder}">
                </c:if>
                <c:if test="${bucket == 'ec-efeiyi'}">
                    <input type="hidden" value="saveOrUpdateEcBanner" name="qm">
                    <c:set var="url" value="pro"/>
                    <c:set var="urlStyle" value="product-model"/>
                </c:if>
                <c:if test="${bucket == 'tenant'}">
                    <input type="hidden" value="saveOrUpdateBanner" name="qm">
                    <c:set var="url" value="tenant"/>
                    <c:set var="urlStyle" value="tenant-manage-banner"/>
                </c:if>
                <div class="am-form-group">
                    <label for="title" class="am-u-sm-3 am-form-label">标题 / Title</label>
                    <div class="am-u-sm-9">
                        <input type="text" id="title" name="title" placeholder="标题 / Title" value="${object.title}">
                        <small>输入你要保存的标题</small>
                    </div>
                </div>
                <c:if test="${fn:contains(groupName,'ec.home.banner')}">
                <div class="am-form-group">
                    <label for="groupName" class="am-u-sm-3 am-form-label">类别 / Category</label>
                    <div class="am-u-sm-9">
                        <ming800:status name="groupName" dataType="Banner.group" checkedValue="${object.group}"  type="select"/>
                    </div>
                </div>
                </c:if>
                <div class="am-form-group">
                    <label for="imageUrl" class="am-u-sm-3 am-form-label">轮播图 / Banner</label>

                    <div class="am-u-sm-9">
                        <c:if test="${not empty object.imageUrl}">
                            <img src="http://${url}.efeiyi.com/${object.imageUrl}@!${urlStyle}"/>
                            <input name="OldImageUrl" type="hidden" value="${object.imageUrl}">
                        </c:if>
                        <input type="file" id="imageUrl" value="${object.imageUrl}" name="imageUrl" placeholder="轮播图 / Banner">
                        <small>选择你要保存的轮播图</small>
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="directUrl" class="am-u-sm-3 am-form-label">PC地址</label>

                    <div class="am-u-sm-9">
                        <input type="text" id="directUrl" name="directUrl" placeholder="点击轮播图跳转的url" value="${object.directUrl}">
                    </div>
                </div>
                <div class="am-form-group">
                    <label for="wapUrl" class="am-u-sm-3 am-form-label">移动地址</label>

                    <div class="am-u-sm-9">
                        <input type="text" id="wapUrl" name="wapUrl" placeholder="点击轮播图跳转的url" value="${object.wapUrl}">
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
</div>
</body>
</html>
