<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<html>--%>
<%--<head>--%>
<%--<title></title>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="am-g">--%>
<%--<div class="am-u-md-12">--%>

<%--<table class="am-table am-table-bordered">--%>
<%--<thead>--%>
<%--<tr>--%>
<%--<th>测试数据</th>--%>
<%--</tr>--%>
<%--</thead>--%>
<%--<tbody>--%>
<%--<tr>--%>
<%--<td class="am-primary am-u-md-3">类型</td>--%>
<%--<td class="am-u-md-3">${object.type}</td>--%>
<%--<td class="am-primary am-u-md-3">简介</td>--%>
<%--<td class="am-u-md-3">${object.content}</td>--%>
<%--</tr>--%>
<%--</tbody>--%>
<%--</table>--%>
<%--</div>--%>
<%--</div>--%>
<%--</body>--%>
<%--</html>--%>


<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/15
  Time: 13:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/>" ></script>
    <style>
    </style>
</head>
<body>
<%--<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>--%>

<div class="am-g">

    <div class="am-u-md-12">
        <div class="am-btn-toolbar">
            <div class="am-btn-group am-btn-group-xs">

                <a type="button" class="am-btn am-btn-default"
                   href="<c:url value="/basic/xm.do?qm=viewMaster&id=${object.master.id}"/>"><span
                        class="am-icon-plus"></span>返回大师页面</a>
            </div>
        </div>
    </div>

    <div class="am-u-md-12">
        <h2>详细信息</h2>
        <table class="am-table am-table-bordered">
            <tbody>
            <tr>
                <td class="am-primary">类型</td>
                <td >
                    <ming800:status name="type" dataType="MasterIntroduction.type" checkedValue="${object.type}" type="normal" />
                </td>
            </tr>
            </tbody>
        </table>
        <div class="am-u-md-6">
            <h3>内容</h3>
            <textarea style="width:100%" id="content" class="ckeditor" readonly>${object.content}</textarea>
        </div>
    </div>
</div>

<div class="am-g">
    <div class="am-u-md-12">
        <h2>附件</h2>
        <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
            <tr>
<security:authorize ifAnyGranted="admin,operational,c_operational">
                <th class="table-set">操作</th>
</security:authorize>
                <th class="table-title">链接</th>
                <th class="table-title">内容</th>
<c:if test="${object.type == 5}">
                <th class="table-title">视频链接</th>
    </c:if>
            </tr>
            </thead>
            <tbody id="attachmentTbody">

            <c:forEach items="${object.attachmentList}" var="attachment">
                <tr id="${attachment.id}">
                    <security:authorize ifAnyGranted="admin,operational,c_operational">
                    <td width="25%">
                        <div class="am-btn-toolbar">
                            <div class="am-btn-group am-btn-group-xs">
                                <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                   onclick="removeAttachment('${attachment.id}')"><span
                                        class="am-icon-trash-o"></span> 删除
                                </a>
                            </div>
                        </div>
                    </td>
                    </security:authorize>
                    <td class="am-hide-sm-only" width="25%">http://tenant.efeiyi.com/${attachment.url}</td>
                    <td class="am-hide-sm-only" width="25%">
                        <a href="/Img/imgUrl.do?imgUrl=http://tenant.efeiyi.com/${attachment.url}">
                        <img width="18%"
                            src="<c:url value="http://tenant.efeiyi.com/${attachment.url}@!tenant-manage-banner"/>"
                            alt=""/>
                        </a>
                    </td>
                    <c:if test="${object.type == 5}">
                    <td class="am-hide-sm-only" width="25%">
                         http://tenant.efeiyi.com/${attachment.videoPath}
                    </td>
                    </c:if>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
<security:authorize ifAnyGranted="admin,operational,c_operational">
    <div class="am-u-md-12">
        <h2>新建附件</h2>

        <form action="<c:url value="/basic/xmm.do"/>"method="post" class="am-form am-form-horizontal" enctype="multipart/form-data">
            <input type="hidden" name="status" value="1"  />
            <input type="hidden" value="" name="masterNewsId">
            <input type="hidden" value="saveOrUpdateMasterAttachment" name="qm">
            <input type="hidden" value="${object.id}" name="introductionId">
            <input type="hidden" value="${object.id}" name="introduction.id">
            <input type="hidden" value="redirect:/basic/xm.do?qm=viewMasterIntroduction&id=${object.id}"
                   name="resultPage">

            <div class="am-form-group">
                <label for="title" class="am-u-sm-3 am-form-label">标题</label>

                <div class="am-u-sm-9">
                    <input type="text" id="title" name="title" placeholder="标题" >
                    <%--<small>选择你要保存的轮播图</small>--%>
                </div>
            </div>

            <div class="am-form-group">
                <label for="attachmentFile" class="am-u-sm-3 am-form-label">附件</label>

                <div class="am-u-sm-9">
                    <input type="file" id="attachmentFile" name="attachmentFile" placeholder="附件">
                    <%--<small>选择你要保存的轮播图</small>--%>
                </div>
            </div>
            <c:if test="${object.type == 5}">
                <div class="am-form-group">
                    <label for="videoPath" class="am-u-sm-3 am-form-label">video</label>

                    <div class="am-u-sm-9">
                        <input type="file" id="videoPath" name="videoPath" placeholder="video">
                        <small>选择你要保存的视频</small>
                    </div>
                </div>
            </c:if>
            <div class="am-form-group">
                <div class="am-u-sm-9 am-u-sm-push-3">
                    <button type="submit" class="am-btn am-btn-primary">保存</button>
                </div>
            </div>

        </form>

    </div>
    </security:authorize>
    </div>
<script>

    function removeAttachment(divId) {
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeMasterAttachment"/>',
            cache: false,
            dataType: "json",
            data: {id: divId},
            success: function (data) {
                $("#" + divId).remove();
            }
        });
    }

</script>

</body>
</html>
