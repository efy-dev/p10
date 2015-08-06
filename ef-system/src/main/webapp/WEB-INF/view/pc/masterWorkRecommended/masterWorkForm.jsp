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
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">传承人推荐作品</strong> /
        <small>MasterWork Recommended</small>
    </div>
</div>

<hr/>

<div class="am-g">

    <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8"><%--少了这个div就出错--%>
    </div>

    <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
        <form action="<c:url value="/basic/xmm.do"/>" method="post" class="am-form am-form-horizontal"
              enctype="multipart/form-data">
            <input type="hidden" value="saveOrUpdateMasterWork" name="qm">
            <input type="hidden" name="id" value="${object.id}">
            <input type="hidden" name="master.id" value="${masterId}">
            <input type="hidden" name="project.id" value="${projectId}">
            <input type="hidden" name="resultPage"
                    value="redirect:/basic/xm.do?qm=plistMasterWork_byProject&conditions=project.id:${projectId}&projectId=${projectId}&masterId=${masterId}"/>

            <div class="am-form-group">
                <label for="name" class="am-u-sm-3 am-form-label">名称</label>

                <div class="am-u-sm-9">
                    <input type="text" id="name" name="name" placeholder="名称" value="${object.name}" required>
                    <%--<small>输入你要保存的类型</small>--%>
                </div>
            </div>




            <div class="am-form-group">
                <label for="productDescription" class="am-u-sm-3 am-form-label">介绍</label>

                <div class="am-u-sm-9">
                        <textarea id="productDescription" name="productDescription" class="ckeditor" placeholder="介绍" required
                                  value="${object.productDescription.content}">${object.productDescription.content}</textarea>
                </div>
                <br>
            </div>


            <div class="am-form-group">
                <label for="picurl" class="am-u-sm-3 am-form-label">图片</label>

                <div class="am-u-sm-9">
                    <input type="file" id="picurl" name="picurl" placeholder="附件">
                    <%--<small>选择你要保存的轮播图</small>--%>
                </div>
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


<script>

    function getMasterProjectTag() {
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=listProjectTag_default&conditions=project.id:${projectId}"/>',
            cache: false,
            dataType: "json",
            success: function (data) {
                $("#tagGroup").append(generateTagSelect(data));
            }
        });
    }

    function generateTagSelect(data) {
        var html = "    <div class=\"am-form-group\"><label  class=\"am-u-sm-3 am-form-label\">作品标签</label><div class=\"am-u-sm-9\">"
        for (var i = 0; i < data.length; i++) {
            html += "<label class=\"am-checkbox-inline\"><input type=\"checkbox\" name=\"tag" + i + "\" value=\"" + data[i].id + "\" > " + data[i].value + "</label>"
        }
        html += "</div></div>"
        return html;
    }

    $().ready(function () {
        getMasterProjectTag();
    });

</script>

</body>
</html>
