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
    <script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/>" ></script>
</head>
<body>
    <div class="am-cf am-padding">
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">传承人资讯</strong>/
            <small>Master News</small>
        </div>
    </div>

    <hr/>

    <div class="am-g">

        <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8"><%--少了这个div就出错--%>
        </div>

        <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
            <form action="<c:url value="/basic/xm.do"/>" method="post" class="am-form am-form-horizontal">
                <input type="hidden" value="saveOrUpdateMasterNews" name="qm">
                <input type="hidden" name="id" value="${object.id}">
                <input type="hidden" name="master.id" value="${masterId}">
                <input type="hidden" name="resultPage" value="redirect:/basic/xm.do?qm=viewMaster&id=${masterId}">

                <div class="am-form-group">
                    <label for="title" class="am-u-sm-3 am-form-label" >标题</label>

                    <div class="am-u-sm-9">
                        <input type="text" id="title" name="title" placeholder="标题" value="${object.title}" required>
                        <%--<small>输入你要保存的类型</small>--%>
                    </div>
                </div>
                <div class="am-form-group">
                    <label for="dataSource" class="am-u-sm-3 am-form-label">来源</label>
                    <div class="am-u-sm-9">
                        <input type="text" id="dataSource" name="dataSource" placeholder="资讯来源" value="${object.dataSource}" >
                    </div>
                </div>
                <div class="am-form-group">
                    <label for="brief" class="am-u-sm-3 am-form-label">简介</label>
                    <div class="am-u-sm-9">
                        <textarea id="brief" name="brief" placeholder="请输入简介" required
                                  value="${object.brief}">${object.brief}</textarea>
                    </div>
                </div>

                <div class="am-form-group">
                    <label for="content" class="am-u-sm-3 am-form-label">资讯内容</label>

                    <div class="am-u-sm-9">
                        <textarea id="content" name="content" class="ckeditor" placeholder="请输入资讯内容" required
                                  value="${object.content}">${object.content}</textarea>
                    </div>
                    <br>
                </div>

                <div id="tagGroup">

                </div>
                <div class="am-form-group">
                    <div class="am-u-sm-9 am-u-sm-push-3">
                        <button type="submit" class="am-btn am-btn-primary">保存</button>
                    </div>
                </div>
            </form>

        </div>
    </div>
    <c:if test="${not empty object.id}">
        <div class="am-u-md-12">
            <h2>可用附件</h2>

            <div class="am-btn-toolbar">
                <div class="am-btn-group am-btn-group-xs">
                    <a type="button" class="am-btn am-btn-default"
                       href="<c:url value="/basic/xm.do?qm=viewMasterNews&id=${object.id}"/>"><span
                            class="am-icon-plus"></span>新建附件</a>
                </div>
            </div>
        </div>
        <div class="am-g">
            <div class="am-u-md-12">
                <h2>附件</h2>
                <table class="am-table am-table-striped am-table-hover table-main">
                    <thead>
                    <tr>
                        <th class="table-title">链接</th>
                        <th class="table-title">内容</th>


                    </tr>
                    </thead>
                    <tbody id="attachmentTbody">

                    <c:forEach items="${object.masterIntroductionAttachmentList}" var="masterAttachment">
                        <tr id="${masterAttachment.id}">
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
        </div>
    </c:if>


    <script>




    function getTagList(){
        $.ajax({
            type: "get",
            url: '<c:url value="/masterNews/tagList.do"/>',
            cache: false,
            dataType: "json",
            success: function (data) {
                $("#tagGroup").append(generateTagSelect(data));
            }
        });
    }

    function generateTagSelect(data){
        var html = "    <div class=\"am-form-group\"><label  class=\"am-u-sm-3 am-form-label\">资讯标签</label><div class=\"am-u-sm-9\">"
        for (var i = 0 ; i<data.length ; i++){
            html += "<label class=\"am-checkbox-inline\"><input type=\"checkbox\" name=\"tag"+i+"\" value=\""+data[i].id+"\" > "+data[i].value+"</label>"
        }
        html += "</div></div>"
        return html;
    }

    $().ready(function(){
        getTagList();
    });
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
