<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title></title>


    <link rel="stylesheet" type="text/css"
          href="<c:url value="/scripts/simditor/font-awesome-4.5.0/css/font-awesome.css"/>">

    <link rel="stylesheet" type="text/css" href="<c:url value="/scripts/simditor/styles/simditor.css"/>">
    <script type="text/javascript" src="<c:url value="/scripts/simditor/scripts/module.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/scripts/simditor/simpleHotkeys/lib/hotkeys.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/scripts/simditor/scripts/uploader.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/scripts/simditor/scripts/simditor.js"/>"></script>


</head>
<body>

<div class="am-g">
    <div class="am-u-md-12">
        <h2>详细信息</h2>

        <table class="am-table am-table-bordered">
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">专题名称</td>
                <td class="am-u-md-3">${object.name}</td>
                <td class="am-primary am-u-md-3">封面</td>
                <td class="am-u-md-3" colspan="3">
                    <img width="35px" src="http://gift-oss.efeiyi.com/${object.pictureUrl}@!product-model" alt="封面">
                </td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">模板</td>
                <td class="am-u-md-3">
                    <ming800:status name="template" dataType="Subject.template" checkedValue="${object.template}"
                                    type="normal"/>
                </td>
                <td class="am-primary am-u-md-3">类别</td>
                <td class="am-u-md-3" colspan="3">
                    <ming800:status name="type" dataType="Subject.type" checkedValue="${object.type}" type="normal"/>
                </td>
            </tr>
            </tbody>
        </table>


        <form action="<c:url value="/giftSubject/update.do"/>" class="am-form am-form-horizontal" method="post"
              enctype="multipart/form-data">
            <input type="hidden" name="subjectId" value="${object.id}">

            <%--<c:if test="${empty fatherId}">--%>
            <%--<input type="hidden" name="level" value="1" />--%>
            <%--</c:if>--%>
            <%--<c:if test="${not empty fatherId}">--%>
            <%--<input type="hidden" name="level" value="${object.level}" />--%>
            <%--</c:if>--%>
            <div class="am-form-group">
                <label name="type" for="editor" class="am-u-sm-3 am-form-label">封面图片</label>
                <div class="am-u-sm-9" style="margin-top: 10px">
                    <c:if test="${object.pictureUrl!=null}">
                        <img src="http://gift-oss.efeiyi.com/${object.pictureUrl}">
                    </c:if>
                    <input type="file" name="pictureUrl">
                </div>
            </div>

            <div class="am-form-group">
                <label name="type" for="editor" class="am-u-sm-3 am-form-label">专题内容
                    <small>*</small>
                </label>
                <div class="am-u-sm-9" style="margin-top: 10px">

                    <textarea id="editor" name="description"
                              placeholder="这里输入内容">${object.subjectDescription.content}</textarea>
                    <%--<a class="am-btn am-btn-primary" onclick="textFilter()">过滤a标签</a>--%>
                </div>
            </div>
            <div class="am-form-group">
                <div class="am-u-sm-9 am-u-sm-push-3">
                    <input type="submit" class="am-btn am-btn-primary" value="保存"/>
                </div>
            </div>
        </form>

    </div>
</div>


<script>

    $(function () {
        var editor = new Simditor({
            textarea: $("#editor"),
            toolbar: [
                'title',
                'bold',
                'italic',
                'underline',
                'strikethrough',
                'fontScale',
                'color',
                'ol',
                'ul',
                'blockquote',
                'code',
                'table',
                'link',
                'image',
                'hr',
                'indent',
                'outdent',
                'alignment'
            ],

            upload: {
                url: "<c:url value="/giftSubject/img.do?projectWikiId=${object.id}" />",
                params: ""
            },
            pasteImage: true,

        });
    });

    function saveGroupName(subjectId) {
        var groupName = $("#groupName").val();

        $.ajax({
            type: "get",
            url: '<c:url value="/Recommended/saveObjectRecommended.do"/>',
            dataType: "json",
            data: {groupName: groupName, recommendId: subjectId, status: "1", sort: 1},
            success: function (data) {

            }
        });

    }

</script>

</body>
</html>
