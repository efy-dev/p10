<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/24
  Time: 13:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/layouts/public.jsp" %>
<html>
<head>
    <title></title>
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
        <strong class="am-text-primary am-text-lg">上传溯源图片</strong>
    </div>
</div>
<div am-panel am-panel-default admin-sidebar-panel>
    <table class="am-table am-table-bordered am-table-radius am-table-striped">
        <tr>
            <td>非遗项目编号</td>
            <td>${object.productSeries.serial}</td>
        </tr>
        <tr>
            <td>非遗项目名称</td>
            <td>${object.productSeries.name}</td>
        </tr>
        <tr>
            <td>商户名称</td>
            <td>${object.tenant.name}</td>
        </tr>
        <tr>
            <td>商户地址</td>
            <td>${object.tenant.province.name}&nbsp;${object.tenant.city.name}&nbsp;${object.tenant.district.name}</td>
        </tr>
        <tr>
            <td>制作工艺</td>
            <td>${object.craft}</td>
        </tr>
        <tr>
            <td>创作地域</td>
            <td>${object.region}</td>
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
            <strong class="am-text-primary am-text-lg">溯源图片</strong>/<small>小图展示</small>
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
            </tr>
            <tr>
                <c:forEach items="${object.imgList}" var="Img2">
                    <td>
                        <button onclick="window.location.href='<c:url
                                value="/tenantProductSeriesImg/removeTenantProductSeriesImg.do?tenantProductSeriesId=${object.id}&ImgId=${Img2.id}"/>'"
                                class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span
                                class="am-icon-trash-o"></span> 删除
                        </button>
                    </td>
                </c:forEach>
            </tr>
            </tbody>
        </table>
    </div>
</c:if>
<link rel="stylesheet" href="<c:url value='/scripts/upload/uploadify.css'/>"/>
<script src="<c:url value='/scripts/upload/jquery.uploadify.js'/>"></script>
<script type="text/javascript">
    $(function () {
        $('#btn_upload').uploadify({
            uploader: '<c:url value="/tenantProductSeriesImg/saveTenantProductSeriesImg.do"/>;jsessionid=<%=request.getSession().getId()%>',            // 服务器处理地址
            swf: '<c:url value="/scripts/upload/uploadify.swf"/>',
            buttonText: "选择溯源图片",                 //按钮文字
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
            formData: {"tenantProductSeriesId": "${object.id}"}, //提交给服务器端的参数
            onQueueComplete: function (queueData) {
                window.location.href = "<c:url value='/basic/xm.do?qm=viewTenantProductSeries&id=${object.id}'/>";
            }
        });
        $("#btn_upload-button").css({"padding": "0em 0em", "text-align": "center"});
    });
</script>
</body>
</html>
