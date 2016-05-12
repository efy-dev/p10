<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/4/18 0018
  Time: 18:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>

    <link rel="stylesheet" type="text/css"
          href="<c:url value="/scripts/simditor/font-awesome-4.5.0/css/font-awesome.css"/>">

    <link rel="stylesheet" type="text/css" href="<c:url value="/scripts/simditor/styles/simditor.css"/>">
    <script type="text/javascript" src="<c:url value="/scripts/simditor/scripts/module.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/scripts/simditor/simpleHotkeys/lib/hotkeys.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/scripts/simditor/scripts/uploader.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/scripts/simditor/scripts/simditor.js"/>"></script>
    <%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>

</head>
<body>

<div class="am-g">
    <div class="am-u-md-12">

        <h2>工艺详情</h2>
        <table class="am-table am-table-bordered">
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">工艺名称</td>
                <td class="am-u-md-3">${object.name}</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">工艺类型</td>
                <td class="am-u-md-3">
                    <ming800:status name="type" dataType="ProjectWiki.type" checkedValue="${object.type}"
                                    type="normal"/>
                </td>
            </tr>
            </tbody>
        </table>

        <h2>工艺描述</h2>
        <form action="<c:url value="/ueditor/use.do"/>" name="uEditor">
            <input type="hidden" name="callbackUrl" value="/basic/xm.do?qm=viewProjectWiki&id=${object.id}">
            <input type="hidden" name="title" value="工艺描述pc">
            <input type="hidden" name="action" value="/artistryDescription/saveOrUpdate.do">
            <input type="hidden" name="name" value="descriptionPC">
            <input type="hidden" name="uploadUrl" value="/artistryDescription/image/upload.do">
            <input type="hidden" name="objectId" value="${object.artistryDescription.id}">
            <input type="hidden" name="objectClassType" value="com.efeiyi.ec.wiki.model.ArtistryDescription">
            <input type="hidden" name="paramName" value="artistryId">
            <input type="hidden" name="paramValue" value="${object.id}">
            <input type="submit" value="编辑工艺描述pc" class="am-btn am-btn-primary">
        </form>

        <form action="<c:url value="/ueditor/use.do"/>" name="uEditor">
            <input type="hidden" name="callbackUrl" value="/basic/xm.do?qm=viewProjectWiki&id=${object.id}">
            <input type="hidden" name="title" value="工艺描述wap">
            <input type="hidden" name="action" value="/artistryDescription/saveOrUpdate.do">
            <input type="hidden" name="name" value="descriptionWap">
            <input type="hidden" name="uploadUrl" value="/artistryDescription/image/upload.do">
            <input type="hidden" name="objectId" value="${object.artistryDescription.id}">
            <input type="hidden" name="objectClassType" value="com.efeiyi.ec.wiki.model.ArtistryDescription">
            <input type="hidden" name="paramName" value="artistryId">
            <input type="hidden" name="paramValue" value="${object.id}">
            <input type="submit" value="编辑工艺描述wap" class="am-btn am-btn-primary">
        </form>

        <form action="<c:url value="/projectWiki/update.do"/>" class="am-form am-form-horizontal" method="post"
              enctype="multipart/form-data">
            <input type="hidden" name="projectWikiId" value="${object.id}">

            <div class="am-form-group">
                <label name="type" for="projectWikiMainPicture" class="am-u-sm-3 am-form-label">封面图片</label>
                <div class="am-u-sm-9" style="margin-top: 10px">
                    <c:if test="${object.getMainPicture()!=null}">
                        <img src="http://wiki-oss.efeiyi.com/${object.getMainPicture().getPictureUrl()}">
                    </c:if>
                    <input type="file" id="projectWikiMainPicture" name="projectWikiMainPicture">
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

<%--<script type="text/javascript">--%>
    <%--$(function () {--%>
        <%--var editor = new Simditor({--%>
            <%--textarea: $("#editor"),--%>
            <%--toolbar: [--%>
                <%--'title',--%>
                <%--'bold',--%>
                <%--'italic',--%>
                <%--'underline',--%>
                <%--'strikethrough',--%>
                <%--'fontScale',--%>
                <%--'color',--%>
                <%--'ol',--%>
                <%--'ul',--%>
                <%--'blockquote',--%>
                <%--'code',--%>
                <%--'table',--%>
                <%--'link',--%>
                <%--'image',--%>
                <%--'hr',--%>
                <%--'indent',--%>
                <%--'outdent',--%>
                <%--'alignment'--%>
            <%--],--%>

            <%--upload: {--%>
                <%--url: "<c:url value="/task/img.do?projectWikiId=${object.id}" />",--%>
                <%--params: ""--%>
            <%--},--%>
            <%--pasteImage: true,--%>

        <%--});--%>
        <%--var editor1 = new Simditor({--%>
            <%--textarea: $("#editor1"),--%>
            <%--toolbar: [--%>
                <%--'title',--%>
                <%--'bold',--%>
                <%--'italic',--%>
                <%--'underline',--%>
                <%--'strikethrough',--%>
                <%--'fontScale',--%>
                <%--'color',--%>
                <%--'ol',--%>
                <%--'ul',--%>
                <%--'blockquote',--%>
                <%--'code',--%>
                <%--'table',--%>
                <%--'link',--%>
                <%--'image',--%>
                <%--'hr',--%>
                <%--'indent',--%>
                <%--'outdent',--%>
                <%--'alignment'--%>
            <%--],--%>

            <%--upload: {--%>
                <%--url: "<c:url value="/task/img.do?projectWikiId=${object.id}" />",--%>
                <%--params: ""--%>
            <%--},--%>
            <%--pasteImage: true,--%>

        <%--});--%>
    <%--});--%>

    <%--function textFilter() {--%>
        <%--var str = $(".simditor-body").html();--%>
        <%--str = str.replace(/<a[^>]*>/g, '');--%>
        <%--str = str.replace(/<\/a>/g, '');--%>
        <%--$(".simditor-body").html(str);--%>
<%--//        $("#editor").html(str);--%>
    <%--}--%>
<%--</script>--%>
</body>
</html>
