<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/24
  Time: 13:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ include file="/layouts/public.jsp" %>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="<c:url value='/scripts/upload/uploadify.css'/>"/>
    <script src="<c:url value='/scripts/upload/jquery.uploadify.js'/>"></script>
</head>
<body>
<div style="text-align: left;margin-left: 10px;">
    <input onclick="window.history.back()"
           type="button" class="am-btn am-btn-default am-btn-xs"
           style="margin-top: 8px;margin-bottom: 6px;margin-left:2px;height: 35px;"
           value="返回" />
</div>
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">上传认证图片</strong>
    </div>
</div>
<div am-panel am-panel-default admin-sidebar-panel>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr>
            <td>商户名称</td>
            <td>${object.tenant.name}</td>
        </tr>
        <tr>
            <td>商户地址</td>
            <td>${object.tenant.province.name}&nbsp;${object.tenant.city.name}&nbsp;${object.tenant.district.name}</td>
        </tr>
        <tr>
            <td>认证证书</td>
            <td>${object.name}</td>
        </tr>
        <tr>
            <td>认证机构</td>
            <td>${object.org}</td>
        </tr>
        <tr>
            <td>认证时间</td>
            <td><fmt:formatDate value="${object.theDate}" pattern="yyyy年MM月"/></td>
        </tr>
        <tr>
            <td>认证结果</td>
            <td>
                <ming800:status name="level" dataType="PCTenantCertification.level" checkedValue="${object.level}" type="normal"/>
            </td>
        </tr>
    </table>
</div>
<table style="border: none;width: 50%" align="center" >
    <td>
        <input class="am-btn am-btn-primary" id="btn_upload"/></td>
    <td>
        <input type="button" class="am-btn am-btn-primary" value="保存"
               onclick="javascript:$('#btn_upload').uploadify('upload', '*');"/>
    </td>
    </tr>
</table>
<c:if test="${!empty object.imgList}">
    <div class="am-cf am-padding">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">认证图片</strong>/
            <small>小图展示</small>
        </div>
    </div>
    <div am-panel am-panel-default admin-sidebar-panel>
        <table class="am-table am-table-bordered am-table-radius am-table-striped">
            <tbody>
            <tr>
                <c:forEach items="${object.imgList}" var="Img">
                    <td>
                        <img src="<%=imgBasePath %>${Img.imgUrl}<%=imgListCss %>"/>
                    </td>
                </c:forEach>
                <div id="pic"></div>
            </tr>
            <tr>
                <c:forEach items="${object.imgList}" var="Img2">
                    <td>
                        <button onclick="window.location.href='<c:url value="/certificationImg/removeCertificationImg.do?certificationId=${object.id}&ImgId=${Img2.id}"/>'"
                                class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                                class="am-icon-trash-o"></span> 删除
                        </button>
                    </td>
                </c:forEach>
                <div id="remove"></div>
            </tr>
            </tbody>
        </table>
    </div>
</c:if>
<script type="text/javascript">
    $(function () {
        $('#btn_upload').uploadify({
            uploader: '<c:url value="/certificationImg/saveCertificationImg.do"/>;jsessionid=<%=request.getSession().getId()%>',            // 服务器处理地址
            <%--swf: '<c:url value="/resources/plugins/upload/uploadify.swf"/>',--%>
            swf: '<c:url value="/scripts/upload/uploadify.swf"/>',
            buttonText: "选择认证图片",                 //按钮文字
            buttonClass: "am-btn-primary",         //按钮样式
            buttonCursor: "hand",                    //鼠标指针悬停在按钮上的样子
            height: 34,                             //按钮高度true
            width: 140,                              //按钮宽度
            auto: false,                          //自动上传
            multi: true,                            //多个文件上传
            scriptDate: {'status': '3'},
            checkExisting: true,                    //检查文件重复
            successTimeout: 1000000,                 //超时
            fileSizeLimit: '2MB',
            removeTimeout: 1,                        //移除时间
            fileTypeExts: "*.jpg;*.png;",           //允许的文件类型
            fileTypeDesc: "请选择图片文件",           //文件说明
            formData: {"certificationId": "${object.id}"}, //提交给服务器端的参数
            onQueueComplete: function (queueData) {
                window.location.href = "<c:url value='/basic/xm.do?qm=viewTenantCertification&id=${object.id}'/>";
            }
        });
        $("#btn_upload-button").css({"padding": "0em 0em", "text-align": "center"});
    });
</script>
</body>
</html>
