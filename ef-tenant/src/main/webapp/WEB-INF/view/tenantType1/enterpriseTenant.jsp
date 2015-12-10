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


    <link href="<c:url value="/scripts/upload/uploadify.css"/>" rel="stylesheet"/>

<center>

            <%--<div class="am-form-group">--%>
                <%--<label for="name" class="am-u-sm-3 am-form-label">*公司名称</label>--%>

                <%--<div class="am-u-sm-9">--%>
                    <%--<input type="text" id="name" name="name" placeholder="name" value="${object.name}">--%>
                <%--</div>--%>
            <%--</div>--%>
            <div class="am-form-group">
                <label for="legalName" class="am-u-sm-3 am-form-label">法定代表人姓名</label>

                <div class="am-u-sm-9">
                    <input type="text" id="legalName" name="legalName" placeholder="法定代表人姓名" value="${object.legalName}">
                </div>
            </div>
            <div class="am-form-group">
                <label for="identity" class="am-u-sm-3 am-form-label">法人身份证号</label>

                <div class="am-u-sm-9">
                    <input type="text" id="identity" name="identity" placeholder="法人身份证号" value="${object.identity}">
                </div>
            </div>
            <div class="am-form-group">
                <label for="frontPhotoUrl" class="am-u-sm-3 am-form-label">*法人身份证电子版正面</label>
                <fieldset>
                    <legend>
                            <a id="btn_upload0"></a>
                    </legend>
                    <div class="am-u-md-13">
                        <div class="am-panel am-panel-default">
                            <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-1'}">
                                <strong> 法人身份证电子版正面</strong>
                                <input type="hidden" name="frontPhotoUrl" value="${object.frontPhotoUrl}" placeholder="法人身份证电子版正面">
                                <span class="am-icon-chevron-down am-fr"></span></div>
                            <div class="am-panel-bd am-collapse am-in" id="collapse-panel-10" style="height: auto;overflow: hidden">
                                <ul style="width: 100%"  style="list-style:none">
                                    <c:if test="${!empty object.frontPhotoUrl}">
                                        <li style="float: left;margin-right: 10px;"  name="${object.id}">
                                            <dl style="margin-top: 6px;">
                                                <dt style="width: 50%">
                                                    <img width="100%" name="frontPhotoUrl"
                                                         src="http://pro.efeiyi.com/${object.frontPhotoUrl}@!product-model"
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
            <div class="am-form-group">
                <label for="identityPhotoUrl" class="am-u-sm-3 am-form-label">*法人身份证电子版反面</label>
                <fieldset>
                    <legend>
                            <a id="btn_upload1"></a>
                    </legend>

                    <div class="am-u-md-13">
                        <div class="am-panel am-panel-default">
                            <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-1'}">
                                <strong> 法人身份证电子版反面</strong>
                                <input type="hidden" name="versoPhotoUrl" value="${object.versoPhotoUrl}" placeholder="法人身份证电子版反面">
                                <span class="am-icon-chevron-down am-fr"></span></div>
                            <div class="am-panel-bd am-collapse am-in" id="collapse-panel-11" style="height: auto;overflow: hidden">
                                <ul style="width: 100%"  style="list-style:none">
                                    <c:if test="${!empty object.versoPhotoUrl}">
                                        <li style="float: left;margin-right: 10px;"  name="${object.id}">
                                            <dl style="margin-top: 6px;">
                                                <dt style="width: 50%">
                                                    <img width="100%" name=""
                                                         src="http://pro.efeiyi.com/${object.versoPhotoUrl}@!product-model"
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
            <div class="am-form-group">
                <label name="addressProvince.id" for="${object.id}" class="am-u-sm-3 am-form-label">*营业执照所在省 <small>*</small></label>
                <div class="am-u-sm-9" style="margin-top: 10px">
                    <select id="${object.id}" name="addressProvince.id" onchange="provinceChange(this , '${object.id}')" ZH_CN="营业执照所在省">
                     <c:if test="${not empty object.addressProvince}">
                        <option value="${object.addressProvince.id}">${object.addressProvince.name}</option>
                      </c:if>
                    </select>
                </div>
            </div>
            <div class="am-form-group">
                <label name="addressCity.id" for="${object.id}" class="am-u-sm-3 am-form-label">*营业执照所在市 <small>*</small></label>
                <div class="am-u-sm-9" style="margin-top: 10px">
                    <select id="citys${object.id}" name="addressCity.id" ZH_CN="营业执照所在市">
                        <option value="${object.addressCity.id}">${object.addressCity.name}</option>
                    </select>
                </div>
            </div>
            <div class="am-form-group">
                <label for="registeredAssets" class="am-u-sm-3 am-form-label">*注册资本</label>

                <div class="am-u-sm-9">
                    <input type="text" id="registeredAssets" name="registeredAssets" placeholder="注册资本" value="${object.registeredAssets}">
                </div>
            </div>
            <div class="am-form-group">
                <label for="businessScope" class="am-u-sm-3 am-form-label">*经营范围</label>

                <div class="am-u-sm-9">
                    <textarea type="text" id="businessScope" placeholder="经营范围" name="businessScope" cols="3" rows="4">${object.businessScope}</textarea>
                </div>
            </div>
            <div class="am-form-group">
                <label for="businessLicense" class="am-u-sm-3 am-form-label">*营业执照副本电子版</label>
                <fieldset>
                    <legend>
                            <a id="btn_upload2"></a>
                    </legend>
                    <div class="am-u-md-13">
                        <div class="am-panel am-panel-default">
                            <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-1'}">
                                <strong> 营业执照副本电子版</strong>
                                <input type="hidden" name="businessLicense" value="${object.businessLicense}"  placeholder="营业执照副本电子版">
                                <span class="am-icon-chevron-down am-fr"></span></div>
                            <div class="am-panel-bd am-collapse am-in" id="collapse-panel-12" style="height: auto;overflow: hidden">
                                <ul style="width: 100%"  style="list-style:none">
                                    <c:if test="${!empty object.businessLicense}">
                                        <li style="float: left;margin-right: 10px;"  name="${object.id}">
                                            <dl style="margin-top: 6px;">
                                                <dt style="width: 50%">
                                                    <img width="100%" name="businessLicense"
                                                         src="http://pro.efeiyi.com/${object.businessLicense}@!product-model"
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
            <div class="am-form-group">
                <label for="taxRegistrationAttachment" class="am-u-sm-3 am-form-label">*税务登记证电子版</label>
                <fieldset>
                    <legend>
                            <a id="btn_upload3"></a>
                    </legend>

                    <div class="am-u-md-13">
                        <div class="am-panel am-panel-default">
                            <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-1'}">
                                <strong> 税务登记证电子版</strong>
                                <input type="hidden" name="taxRegistrationAttachment" value="${object.taxRegistrationAttachment}" placeholder="税务登记证电子版">
                                <span class="am-icon-chevron-down am-fr"></span></div>
                            <div class="am-panel-bd am-collapse am-in" id="collapse-panel-13" style="height: auto;overflow: hidden">
                                <ul style="width: 100%"  style="list-style:none">
                                    <c:if test="${!empty object.taxRegistrationAttachment}">
                                        <li style="float: left;margin-right: 10px;"  name="${object.id}">
                                            <dl style="margin-top: 6px;">
                                                <dt style="width: 50%">
                                                    <img width="100%" name=""
                                                         src="http://pro.efeiyi.com/${object.taxRegistrationAttachment}@!product-model"
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
            <div class="am-form-group">
                <label for="organizationAttachment" class="am-u-sm-3 am-form-label">*组织机构电子版</label>
                <fieldset>
                    <legend>
                            <a id="btn_upload4"></a>
                    </legend>
                    <div class="am-u-md-13">
                        <div class="am-panel am-panel-default">
                            <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-1'}">
                                <strong> 组织机构电子版</strong>
                                <input type="hidden" name="organizationAttachment" value="${object.organizationAttachment}" placeholder="组织机构电子版">
                                <span class="am-icon-chevron-down am-fr"></span></div>
                            <div class="am-panel-bd am-collapse am-in" id="collapse-panel-14" style="height: auto;overflow: hidden">
                                <ul style="width: 100%"  style="list-style:none">
                                    <c:if test="${!empty object.organizationAttachment}">
                                        <li style="float: left;margin-right: 10px;"  name="${object.id}">
                                            <dl style="margin-top: 6px;">
                                                <dt style="width: 50%">
                                                    <img width="100%" name="businessLicense"
                                                         src="http://pro.efeiyi.com/${object.organizationAttachment}@!product-model"
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
            <div class="am-form-group">
                <label for="bankAttachment" class="am-u-sm-3 am-form-label">*银行开户电子版</label>
                <fieldset>
                    <legend>
                            <a id="btn_upload5"></a>
                    </legend>

                    <div class="am-u-md-13">
                        <div class="am-panel am-panel-default">
                            <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-1'}">
                                <strong> 银行开户电子版</strong>
                                <input type="hidden" name="bankAttachment" value="${object.bankAttachment}" placeholder="银行开户电子版">
                                <span class="am-icon-chevron-down am-fr"></span></div>
                            <div class="am-panel-bd am-collapse am-in" id="collapse-panel-15" style="height: auto;overflow: hidden" >
                                <ul style="width: 100%"  style="list-style:none">
                                    <c:if test="${!empty object.bankAttachment}">
                                        <li style="float: left;margin-right: 10px;"  name="${object.id}">
                                            <dl style="margin-top: 6px;">
                                                <dt style="width: 50%">
                                                    <img width="100%" name=""
                                                         src="http://pro.efeiyi.com/${object.bankAttachment}@!product-model"
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
    function chooseCity(element,provinceId,cityId,o){
        $(element).val(provinceId);
        var callback = function(){
            $("#citys" + o).val(cityId);
        }
        provinceChange(element, o,callback);
    }

    $.post("<c:url value="/address/listProvince.do"/>",
            function (data) {
                var obj = eval(data);
                var out = '<option value="">请选择</option>';
                for (var i = 0; i < obj.length; i++) {
                    out += '<option value="' + obj[i]["id"] + '">' + obj[i]["name"] + '</option>';
                }
                $("#${object.id}").append(out);
                chooseCity($("#${object.id}") , "${object.addressProvince.id}","${object.addressCity.id}","${object.id}");
            }
    )

    function provinceChange(element, o, callback) {
        $("#citys" + o).empty();
        var provinceId = $(element).val();
        $.post("<c:url value="/address/listCity.do"/>",
                {provinceId: provinceId},
                function (data) {
                    var obj = eval(data);
                    var out = '<option value="">请选择</option>';
                    for (var i = 0; i < obj.length; i++) {
                        out += '<option value="' + obj[i]["id"] + '">' + obj[i]["name"] + '</option>';
                    }
                    $("#citys" + o).append(out);
                    if(typeof callback!= "undefined"){
                        callback();
                    }
                }
        )
    }
    $(function(){
        if('${object.review}'=='1' ||'${object.review}'=='3' ) {
            var fileUploads = function (o, dataType) {
                $('#btn_upload' + o).uploadify({
                    uploader: '<c:url value="/tenant/uploadify.do?dataType="/>' + dataType,            // 服务器处理地址
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
                        data = data.substring(1, data.length - 1)
                        var url = "http://pro.efeiyi.com/" + data + "@!product-model";
                        ///显示图片
                        var img = '<li style="float: left;margin-right: 10px;" >' +
                                '<dl style="margin-top: 6px;" >' +
                                '  <dt  style="width: 50%">' +
                                '   <img width="100%"   src="' + url + '" alt="商品主图片">' +
                                '  </dt>' +
                                '</dl>' +
                                '</li>';
                        $("#collapse-panel-1" + o + " ul").html(img);
                        $("input[name='" + dataType + "']").val(data);
                    }
                });
            }
            $("#btn_upload0").ready(fileUploads(0, "frontPhotoUrl"));
            $("#btn_upload1").ready(fileUploads(1, "versoPhotoUrl"));
            $("#btn_upload2").ready(fileUploads(2, "businessLicense"));
            $("#btn_upload3").ready(fileUploads(3, "taxRegistrationAttachment"));
            $("#btn_upload4").ready(fileUploads(4, "organizationAttachment"));
            $("#btn_upload5").ready(fileUploads(5, "bankAttachment"));
            $("#btn_upload-button").css({"padding": "0em 0em", "text-align": "center"});
            $("#btn_upload0-button").css({"padding": "0em 0em", "text-align": "center"});
            $("#btn_upload1-button").css({"padding": "0em 0em", "text-align": "center"});
            $("#btn_upload2-button").css({"padding": "0em 0em", "text-align": "center"});
            $("#btn_upload3-button").css({"padding": "0em 0em", "text-align": "center"});
            $("#btn_upload4-button").css({"padding": "0em 0em", "text-align": "center"});
            $("#btn_upload5-button").css({"padding": "0em 0em", "text-align": "center"});
            $("#SWFUpload_0").css({left:"5"});
            $("#SWFUpload_1").css({left:"5"});
            $("#SWFUpload_2").css({left:"5"});
            $("#SWFUpload_3").css({left:"5"});
            $("#SWFUpload_4").css({left:"5"});
            $("#SWFUpload_5").css({left:"5"});
        }
    });
</script>
