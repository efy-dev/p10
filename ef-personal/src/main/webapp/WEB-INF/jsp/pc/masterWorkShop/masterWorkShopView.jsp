<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/>" ></script>
    <script src="<c:url value='/scripts/jquery-form.js'/>" ></script>
    <link href="<c:url value="/scripts/upload/uploadify.css"/>" rel="stylesheet"/>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">工作坊</strong>/
        <small>Master WorkShop</small>
    </div>
</div>

<hr/>

<div class="am-g">

    <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8"><%--少了这个div就出错--%>
    </div>

    <div class="am-g">
        <div class="am-u-md-12">
            <h2>工作坊详情</h2>
            <table class="am-table am-table-bordered">
                <tbody>
                <tr>
                    <td class="am-primary am-u-md-3">名称</td>
                    <td class="am-u-md-3">${object.name}</td>
                    <td class="am-primary am-u-md-3">传承人</td>
                    <td class="am-u-md-3">${object.master.name}</td>
                </tr>
                <tr>
                    <td class="am-primary am-u-md-3">视频连接</td>
                    <td class="am-u-md-3">
                        <a href="http://tenant.oss-cn-beijing.aliyuncs.com/${object.videoPath}">视频网址</a>
                    </td>
                    <td class="am-primary am-u-md-3">创建时间</td>
                    <%--<td class="am-u-md-3"><fmt:formatDate value="${object.createDateTime}" pattern="yyyy-MM-dd HH:mm"/></td>--%>
                    <td class="am-u-md-3">${object.createDateTime}</td>
                </tr>
                </tbody>
            </table>
            <div class="am-u-md-6">
                <h3>工作坊介绍</h3>
            <textarea style="width:100%" id="content" class="ckeditor"
                      readonly>${object.shopIntroduction}</textarea>
            </div>

            <div class="am-u-md-6">
                <h3>工作坊封面</h3>
                <img src="http://tenant.efeiyi.com/${object.picture_url}@!tenant-manage-work-view">
            </div>
            <div class="am-u-md-6">
                <h3>视频</h3>
                <video src="http://tenant.oss-cn-beijing.aliyuncs.com/${object.videoPath}" controls="controls"  width="500" height="250"></video>
            </div>


        </div>
    </div>
</div>

</body>
</html>
