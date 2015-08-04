<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/22
  Time: 17:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        <h2>传承人资讯详细信息</h2>
        <table class="am-table am-table-bordered">
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">标题</td>
                <td class="am-u-md-3">${object.title}</td>
                <td class="am-primary am-u-md-3">作者</td>
                <td class="am-u-md-3">${!empty object.creator ?object.creator.name:""}</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">来源</td>
                <td class="am-u-md-3">${object.dataSource}</td>
                <td class="am-primary am-u-md-3">创建时间</td>
                <%--<td class="am-u-md-3"><fmt:formatDate value="${object.createDateTime}" pattern="yyyy-MM-dd HH:mm"/></td>--%>
                <td class="am-u-md-3">${object.createDateTime}</td>
            </tr>
            </tbody>
        </table>
        <div class="am-u-md-6">
            <h3>资讯内容</h3>
            <textarea style="width:100%" id="content" class="ckeditor"
                      readonly>${object.content}</textarea>
        </div>
    </div>
</div>

<div class="am-g">
    <div class="am-u-md-12">
        <h2>附件</h2>
        <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
            <tr>
                <th class="table-set">操作</th>
                <th class="table-title">链接</th>
                <th class="table-title">内容</th>


            </tr>
            </thead>
            <tbody id="attachmentTbody">

            <c:forEach items="${object.masterIntroductionAttachmentList}" var="masterAttachment">
                <tr id="${masterAttachment.id}">
                    <td>
                        <div class="am-btn-toolbar">
                            <div class="am-btn-group am-btn-group-xs">
                                <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                   onclick="removeAttachment('${masterAttachment.id}')"><span
                                        class="am-icon-trash-o"></span> 删除
                                </a>
                            </div>
                        </div>
                    </td>
                    <td class="am-hide-sm-only">http://tenant.efeiyi.com/${masterAttachment.url}</td>
                    <td class="am-hide-sm-only">
                        <a href="/Img/imgUrl.do?imgUrl=http://tenant.efeiyi.com/${masterAttachment.url}">
                            <img width="18%"
                                 src="<c:url value="http://tenant.efeiyi.com/${masterAttachment.url}@!tenant-manage-banner"/>"
                                 alt=""/>
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <div class="am-u-md-12">
        <h2>新建附件</h2>

        <form action="<c:url value="/basic/xmm.do"/>"method="post" class="am-form am-form-horizontal" enctype="multipart/form-data">
            <input type="hidden" name="status" value="1"  />
            <input type="hidden" value="${object.id}" name="masterNewsId">
            <input type="hidden" value="saveOrUpdateMasterAttachment" name="qm">
            <input type="hidden" value="" name="introductionId">
            <input type="hidden" value="${object.id}" name="masterNews.id">
            <input type="hidden" value="redirect:/basic/xm.do?qm=viewMasterNews&id=${object.id}"
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
