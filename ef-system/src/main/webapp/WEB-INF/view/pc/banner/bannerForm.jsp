<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                <input type="hidden" value="saveOrUpdateBanner" name="qm">
                <input type="hidden" name="id" value="${object.id}">
                <input type="hidden" name="groupName" value="${groupName}">
                <input type="hidden" name="resultPage" value="redirect:/basic/xm.do?qm=plistBanner_${groupName}&groupId=${groupName}">
                <div class="am-form-group">
                    <label for="title" class="am-u-sm-3 am-form-label">标题 / Title</label>
                    <div class="am-u-sm-9">
                        <input type="text" id="title" name="title" placeholder="标题 / Title" value="${object.title}">
                        <small>输入你要保存的标题</small>
                    </div>
                </div>
                <div class="am-form-group">
                    <label for="imageUrl" class="am-u-sm-3 am-form-label">轮播图 / Banner</label>

                    <div class="am-u-sm-9">
                        <input type="file" id="imageUrl" name="imageUrl" placeholder="轮播图 / Banner">
                        <small>选择你要保存的轮播图</small>
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
