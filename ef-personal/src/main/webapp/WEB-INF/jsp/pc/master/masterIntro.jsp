<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 14:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<link href="<c:url value="/scripts/upload/uploadify.css"/>" rel="stylesheet"/>

<center>
    <div class="am-form-group">
        <label for="identityCard" class="am-u-sm-3 am-form-label">身份证号</label>

        <div class="am-u-sm-9">
            <input type="text" id="identityCard" name="identityCard" placeholder="身份证号" value="${object.identityCard}">
        </div>
    </div>
    <%--<div class="am-form-group">--%>
        <%--<label  class="am-u-sm-3 am-form-label">*经营者身份证电子版正面</label>--%>
        <%--<fieldset>--%>
            <%--<legend>--%>
                <%--<a id="btn_upload0"></a>--%>
            <%--</legend>--%>
            <%--<div class="am-u-md-13">--%>
                <%--<div class="am-panel am-panel-default">--%>
                    <%--<div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-1'}">--%>
                        <%--<strong> 经营者身份证电子版正面</strong>--%>
                        <%--<input type="hidden" name="frontPhotoUrl" value="${object.frontPhotoUrl}" placeholder="经营者身份证电子版正面">--%>
                        <%--<span class="am-icon-chevron-down am-fr"></span></div>--%>
                    <%--<div class="am-panel-bd am-collapse am-in" id="collapse-panel-10" style="height: auto;overflow: hidden">--%>
                        <%--<ul style="width: 100%"  style="list-style:none">--%>
                            <%--<c:if test="${!empty object.frontPhotoUrl}">--%>
                                <%--<li style="float: left;margin-right: 10px;"  name="${object.id}">--%>
                                    <%--<dl style="margin-top: 6px;">--%>
                                        <%--<dt style="width: 50%">--%>
                                            <%--<img width="100%" name="frontPhotoUrl"--%>
                                                 <%--src="http://pro.efeiyi.com/${object.frontPhotoUrl}@!product-model"--%>
                                                 <%--alt="商品图片"/>--%>
                                        <%--</dt>--%>
                                    <%--</dl>--%>
                                <%--</li>--%>
                            <%--</c:if>--%>
                        <%--</ul>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</fieldset>--%>
    <%--</div>--%>
    <%--<div class="am-form-group">--%>
        <%--<label  class="am-u-sm-3 am-form-label">*经营者身份证电子版反面</label>--%>
        <%--<fieldset>--%>
            <%--<legend>--%>
                <%--<a id="btn_upload1"></a>--%>
            <%--</legend>--%>

            <%--<div class="am-u-md-13">--%>
                <%--<div class="am-panel am-panel-default">--%>
                    <%--<div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-1'}">--%>
                        <%--<strong> 经营者身份证电子版反面</strong>--%>
                        <%--<input type="hidden" name="versoPhotoUrl" value="${object.versoPhotoUrl}"  placeholder="经营者身份证电子版反面">--%>
                        <%--<span class="am-icon-chevron-down am-fr"></span></div>--%>
                    <%--<div class="am-panel-bd am-collapse am-in" id="collapse-panel-11" style="height: auto;overflow: hidden">--%>
                        <%--<ul style="width: 100%"  style="list-style:none">--%>
                            <%--<c:if test="${!empty object.versoPhotoUrl}">--%>
                                <%--<li style="float: left;margin-right: 10px;"  name="${object.id}">--%>
                                    <%--<dl style="margin-top: 6px;">--%>
                                        <%--<dt style="width: 50%">--%>
                                            <%--<img width="100%" name=""--%>
                                                 <%--src="http://pro.efeiyi.com/${object.versoPhotoUrl}@!product-model"--%>
                                                 <%--alt="商品图片"/>--%>
                                        <%--</dt>--%>
                                    <%--</dl>--%>
                                <%--</li>--%>
                            <%--</c:if>--%>
                        <%--</ul>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</fieldset>--%>
    <%--</div>--%>
    <div class="am-form-group">
        <label  class="am-u-sm-3 am-form-label">*手持身份证电子版</label>
        <fieldset>
            <legend>
                <a id="btn_upload0" ></a>
            </legend>

            <div class="am-u-md-13">
                <div class="am-panel am-panel-default">
                    <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-10'}">
                        <strong> 手持身份证电子版</strong>
                        <input type="hidden" name="identityPicture" value="${object.identityPicture}" placeholder="手持身份证电子版">
                        <span class="am-icon-chevron-down am-fr"></span></div>
                    <div class="am-panel-bd am-collapse am-in" id="collapse-panel-10" style="height: auto;overflow: hidden">
                        <ul style="width: 100%"  style="list-style:none">
                            <c:if test="${!empty object.identityPicture}">
                                <li style="float: left;margin-right: 10px;"  name="${object.id}">
                                    <dl style="margin-top: 6px;">
                                        <dt style="width: 50%">
                                            <img width="100%" name="identityPicture"
                                                 src="http://tenant.efeiyi.com/${object.identityPicture}@!tenant-manage-work-view"
                                                 alt="商品图片"/>
                                        </dt>
                                    </dl>
                                </li>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>
        </fieldset>
    </div>
</center>
<script src="<c:url value="/scripts/upload/jquery.uploadify.min.js"/>"></script>
<script>

    $(function(){
        if('${object.review}'=='1' ||'${object.review}'=='3' ) {
            var fileUploads = function (o, dataType) {
                $('#btn_upload' + o).uploadify({
                    uploader: '<c:url value="/uploadify.do"/>',            // 服务器处理地址
                    swf: '<c:url value="/scripts/upload/uploadify.swf"/>',
                    buttonText: "上传图片",                 //按钮文字
                    buttonClass: "am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only",         //按钮样式
                    buttonCursor: "hand",                    //鼠标指针悬停在按钮上的样子
                    height: 34,                             //按钮高度
                    width: 140,                              //按钮宽度
                    auto: true,                          //自动上传
                    multi: true,                            //多个文件上传
                    scriptDate: {'status': '3'},
                    checkExisting: true,                    //检查文件重复
                    successTimeout: 1000000,                 //超时
                    fileSizeLimit: '2MB',
                    removeTimeout: 1,                        //移除时间
                    fileTypeExts: "*.jpg;*.png;",           //允许的文件类型
                    fileTypeDesc: "请选择图片文件",           //文件说明
                    formData: {"imgType": "normal"}, //提交给服务器端的参数
                    onUploadSuccess: function (file, data) {   //一个文件上传成功后的响应事件处理
                        console.log(data);
                        data = data.substring(1, data.length - 1)

                        var url = "http://tenant.efeiyi.com/" + data + "@!tenant-manage-work-view";
                        ///显示图片
                        var img = '<li style="float: left;margin-right: 10px;">' +
                                '<dl style="margin-top: 6px;" >' +
                                '  <dt  style="width: 50%">' +
                                '   <img width="100%" src="' + url + '" alt="商品主图片">' +
                                '  </dt>' +
                                '</dl>' +
                                '</li>';
                        $("#collapse-panel-1" + o + " ul").html(img);
                        $("input[name='" + dataType + "']").val(data);
                    }
                });
            }
            $("#btn_upload0").ready(fileUploads(0, "identityPicture"));
//            $("#btn_upload1").ready(fileUploads(1, "versoPhotoUrl"));
//            $("#btn_upload2").ready(fileUploads(2, "identityPicture"));
//            $("#btn_upload-button").css({"padding": "0em 0em", "text-align": "center"});
            $("#btn_upload0-button").css({"padding": "0em 0em", "text-align": "center"});
//            $("#btn_upload1-button").css({"padding": "0em 0em", "text-align": "center"});
//            $("#btn_upload2-button").css({"padding": "0em 0em", "text-align": "center"});
            $("#SWFUpload_0").css({left:"5"});
//            $("#SWFUpload_1").css({left:"5"});
//            $("#SWFUpload_2").css({left:"5"});

        }

    });

</script>

