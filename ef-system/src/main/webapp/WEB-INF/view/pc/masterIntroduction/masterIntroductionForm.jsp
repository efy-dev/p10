<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
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
<%--<form action="/basic/xm.do" method="post">--%>
<%--<table class="am-table am-table-striped am-table-hover table-main">--%>
<%--<input type="hidden" value="saveOrUpdateMasterIntroduction" name="qm">--%>
<%--<input type="hidden" name="id" value="${object.id}">--%>

<%--<div class="am-g am-margin-top">--%>
<%--<div class="am-u-sm-4 am-u-md-2 am-text-right">--%>
<%--类型：--%>
<%--</div>--%>
<%--<div class="am-u-sm-8 am-u-md-4 am-u-end col-end">--%>
<%--<input type="text" class="am-input-sm" name="type" id="type" value="${object.type}">--%>
<%--</div>--%>
<%--</div>--%>

<%--<div class="am-g am-margin-top-sm">--%>
<%--<div class="am-u-sm-12 am-u-md-2 am-text-right admin-form-text">--%>
<%--简介：--%>
<%--</div>--%>
<%--<div class="am-u-sm-12 am-u-md-10">--%>
<%--<textarea rows="10" id="content" name="content" class="ckeditor">${object.content}</textarea><br>--%>
<%--<button type="submit" class="am-btn am-btn-primary am-btn-xs">提交保存</button>--%>
<%--</div>--%>
<%--</div>--%>
<%--</table>--%>
<%--</form>--%>


<%--<div class="admin-content">--%>
<%--<div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">--%>
<%--<form action="/basic/xm.do" method="post">--%>
<%--<input type="hidden" value="saveOrUpdateMasterIntroduction" name="qm">--%>
<%--<input type="hidden" name="id" value="${object.id}">--%>
<%--<div class="am-form-group">--%>
<%--<label for="type" class="am-u-sm-3 am-form-label">类型 / Type</label>--%>
<%--<div class="am-u-sm-9">--%>
<%--<input type="text" id="type" name="type" placeholder="类型 / Type">--%>
<%--<small>输入你要保存的类型</small>--%>
<%--</div>--%>
<%--</div>--%>


<%--<div class="am-form-group">--%>
<%--<label for="content" class="am-u-sm-3 am-form-label">简介 / Intro</label>--%>
<%--<div class="am-u-sm-9">--%>
<%--<textarea id="content" name="content" class="ckeditor"  placeholder="输入简介"></textarea>--%>
<%--</div><br>--%>
<%--<button type="submit" class="am-btn am-btn-primary am-btn-xs">提交保存</button>--%>
<%--</div>--%>

<%--</form>--%>
<%--</div>--%>
<%--</div>--%>
    <div class="am-cf am-padding">
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">传承人简介</strong> /
            <small>Master Introduction</small>
        </div>
    </div>

    <hr/>

    <div class="am-g">

        <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8"><%--少了这个div就出错--%>
        </div>

        <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
            <form action="<c:url value="/basic/xm.do"/>" method="post" class="am-form am-form-horizontal">
                <input type="hidden" value="saveOrUpdateMasterIntroduction" name="qm">
                <input type="hidden" name="id" value="${object.id}">
                <input type="hidden" name="master.id" value="${masterId}">
                <input type="hidden" name="resultPage" value="redirect:/basic/xm.do?qm=viewMaster&id=${masterId}">

                <%--<div class="am-form-group">--%>
                <%--<label for="type" class="am-u-sm-3 am-form-label">类型 / Type</label>--%>

                <%--<div class="am-u-sm-9">--%>
                <%--<input type="text" id="type" name="type" placeholder="类型 / Type" value="${object.type}">--%>
                <%--&lt;%&ndash;<small>输入你要保存的类型</small>&ndash;%&gt;--%>
                <%--</div>--%>
                <%--</div>--%>

                <div class="am-form-group">
                    <label for="title" class="am-u-sm-3 am-form-label">标题</label>

                    <div class="am-u-sm-9">
                        <input type="text" id="title" name="title" placeholder="标题" value="${object.title}" required>
                        <%--<small>输入你要保存的类型</small>--%>
                    </div>
                </div>


                <div class="am-form-group">
                    <label for="title" class="am-u-sm-3 am-form-label">类型</label>

                    <div class="am-u-sm-9">
                        <ming800:status name="type" dataType="MasterIntroduction.type" checkedValue="${object.type}" type="select" required="true"/>
                    </div>
                </div>


                <div class="am-form-group">
                    <label for="content" class="am-u-sm-3 am-form-label">简介 / Intro</label>

                    <div class="am-u-sm-9">
                        <textarea id="content" name="content" class="ckeditor" placeholder="输入简介"
                                  value="${object.content}" required>${object.content}</textarea>
                    </div>
                    <br>
                </div>

                <div class="am-form-group">
                    <div class="am-u-sm-9 am-u-sm-push-3">
                        <button type="submit" class="am-btn am-btn-primary">保存</button>
                    </div>
                </div>
            </form>
        </div>
    </div>


    <c:if test="${!empty object}">

        <div class="am-g">
            <c:if test="${!empty object.id}">

                <div class="am-u-md-12">
                    <h2>可用附件</h2>

                    <div class="am-btn-toolbar">
                        <div class="am-btn-group am-btn-group-xs">
                            <a type="button" class="am-btn am-btn-default"
                               href="<c:url value="/basic/xm.do?qm=viewMasterIntroduction&id=${object.id}"/>"><span
                                    class="am-icon-plus"></span>新建附件</a>
                        </div>
                    </div>
                </div>
            </c:if>

            <div class="am-u-md-12">
                <jsp:include flush="true"
                             page="/basic/xm.do?qm=listMasterAttachment_include&conditions=introduction.id:${object.id}"/>
            </div>
        </div>


    </c:if>

    <%--<div class="am-g">--%>
    <%--<div class="am-u-sm-12">--%>
    <%--<h2>可用图片列表</h2>--%>
    <%--<table class="am-table am-table-striped am-table-hover table-main">--%>
    <%--<thead>--%>
    <%--<tr>--%>
    <%--<th class="table-title">路径</th>--%>
    <%--<th class="table-title">预览</th>--%>

    <%--</tr>--%>
    <%--</thead>--%>
    <%--<tbody id="usefulImage">--%>
    <%--<tr>--%>
    <%--<td class="am-hide-sm-only"></td>--%>
    <%--<td class="am-hide-sm-only"><img src="@!master-manage-banner" alt=""/></td>--%>
    <%--</tr>--%>
    <%--</tbody>--%>
    <%--</table>--%>
    <%--</div>--%>
    <%--</div>--%>


    <%--<div class="am-g">--%>
    <%--<div class="am-u-md-12">--%>
    <%--<form action="/masterIntroduction/imageUpload.do" method="post" class="am-form am-form-horizontal" enctype="multipart/form-data">--%>

    <%--<input type="hidden" name="id" value="${object.id}">--%>
    <%--<input type="hidden" name="master.id" value="${masterId}">--%>

    <%--<div class="am-form-group">--%>
    <%--<label for="title" class="am-u-sm-3 am-form-label">类型</label>--%>

    <%--<div class="am-u-sm-9">--%>
    <%--<ming800:status name="type" dataType="MasterIntroduction.type" type="select"/>--%>
    <%--</div>--%>
    <%--</div>--%>
    <%--<div class="am-form-group">--%>
    <%--<label for="imageUrl" class="am-u-sm-3 am-form-label">上传介绍图片</label>--%>

    <%--<div class="am-u-sm-9">--%>
    <%--<input type="file" id="imageUrl" name="imageUrl" placeholder="上传介绍图片">--%>
    <%--</div>--%>
    <%--</div>--%>


    <%--<div class="am-form-group">--%>
    <%--<div class="am-u-sm-9 am-u-sm-push-3">--%>
    <%--<button type="submit" class="am-btn am-btn-primary">保存</button>--%>
    <%--</div>--%>
    <%--</div>--%>
    <%--</form>--%>
    <%--</div>--%>

    <%--</div>--%>

<%--<script>--%>

<%--function getUsefulImage(){--%>
<%--$.ajax({--%>
<%--type: "get",--%>
<%--url: '<c:url value="/masterIntroduction/imageList.do"/>',--%>
<%--cache: false,--%>
<%--dataType: "json",--%>
<%--success: function (data) {--%>
<%--var out = ""--%>
<%--for(var i = 0;i<data.length;i++){--%>
<%--out+="<tr>" +--%>
<%--"<td class=\"am-hide-sm-only\">"+data[i]+"</td>" +--%>
<%--"<td class=\"am-hide-sm-only\"><img src=\""+data[i]+"@!master-manage-banner\"/></td>" +--%>
<%--"</tr>";--%>
<%--}--%>
<%--$("#usefulImage").append(out)--%>
<%--}--%>
<%--});--%>
<%--}--%>

<%--</script>--%>

</body>
</html>
