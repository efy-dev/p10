<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/22
  Time: 10:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title></title>
    <script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/>" ></script>
</head>
<body>
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
        <h2>作品详细信息</h2>
        <table class="am-table am-table-bordered">
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">名称</td>
                <td class="am-u-md-3">${object.name}</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">序列号</td>
                <td class="am-u-md-3">${object.serial}</td>
                <td class="am-primary am-u-md-3">创建时间</td>
                <td class="am-u-md-3"><fmt:formatDate value="${object.createDateTime}" pattern="yyyy-MM-dd HH:mm"/></td>
            </tr>
            </tbody>
        </table>
        <div class="am-u-md-6">
            <h3>介绍</h3>
            <textarea style="width:100%" id="content" class="ckeditor"
                      readonly>${object.productDescription.content}</textarea>
        </div>

        <div class="am-u-md-6">
            <h3>封面</h3>
            <img src="http://master.efeiyi.com/${object.picture_url}@!master-manage-work-view">
        </div>

    </div>
</div>

<div class="am-g">
    <div class="am-u-md-12">
        <h2>作品图片列表</h2>
        <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
            <tr>
                <th class="table-set">操作</th>
                <th class="table-title">连接</th>
                <th class="table-title">图片</th>


            </tr>
            </thead>
            <tbody id="attachmentTbody">

            <c:forEach items="${object.productPictureList}" var="productPicture">
                <tr id="${productPicture.id}">
                    <td>
                        <div class="am-btn-toolbar">
                            <div class="am-btn-group am-btn-group-xs">
                                <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                   onclick="removeAttachment('${productPicture.id}')"><span
                                        class="am-icon-trash-o"></span> 删除
                                </a>
                            </div>
                        </div>
                    </td>
                    <td class="am-hide-sm-only">${productPicture.pictureUrl}</td>
                    <td class="am-hide-sm-only"><img
                            src="<c:url value="http://master.efeiyi.com/${productPicture.pictureUrl}@!master-manage-work-view"/>"
                            alt=""/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <div class="am-u-md-12">
        <h2>新建作品图片</h2>

        <form action="<c:url value="/basic/xmm.do"/>" method="post" class="am-form am-form-horizontal" enctype="multipart/form-data">

            <input type="hidden" value="saveOrUpdateProductPicture" name="qm">
            <input type="hidden" value="${object.id}" name="masterWorkId">
            <input type="hidden" value="${object.master.id}" name="master.id">
            <input type="hidden" value="redirect:/basic/xm.do?qm=viewMasterWork&id=${object.id}"
                   name="resultPage">

            <div class="am-form-group">
                <label for="pictrue" class="am-u-sm-3 am-form-label">图片</label>

                <div class="am-u-sm-9">
                    <input type="file" id="pictrue" name="pictrue" placeholder="图片">
                    <%--<small>选择你要保存的轮播图</small>--%>
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
