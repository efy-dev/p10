<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <link href="<c:url value="/scripts/upload/uploadify.css"/>" rel="stylesheet"/>
    <title></title>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg"> 完善资料</strong> /
       <small>
           <ming800:status name="review" dataType="Tenant.review" checkedValue="${object.review}" type="normal"/>
       </small>
    </div>
</div>
<hr/>
<div class="am-g">
    <div class="am-u-md-12">
        <form action="<c:url value="/tenant/toCheck.do"/>" method="post" class="am-form am-form-horizontal">
            <input type="hidden" name="id" value="${object.id}">
            <input type="hidden" name="flag" value="">
        <div class="am-tabs am-margin" data-am-tabs>
            <ul class="am-tabs-nav am-nav am-nav-tabs">
                <li class="am-active"><a href="#tab1">基本信息</a></li>
                <li><a href="#tab2">完善信息</a></li>
            </ul>

            <div class="am-tabs-bd">
                <div class="am-tab-panel am-fade am-in am-active" id="tab1">
                    <div class="am-g am-margin-top">
                        <div class="am-form-group">
                            <label for="name" class="am-u-sm-3 am-form-label">商家编号</label>

                            <div class="am-u-sm-9">

                                <c:if test="${not empty object.serial}">
                                    <input type="text" id="serial" name="serial" placeholder="自动生成" value="${object.serial}" readonly="readonly">
                                </c:if>
                                <c:if test="${empty object.serial}">
                                    <input type="text" id="serial" name="serial" placeholder="自动生成" value="${serial}" readonly="readonly">
                                </c:if>


                            </div>
                        </div>
                        <div class="am-form-group">
                            <label for="name" class="am-u-sm-3 am-form-label">商家名称</label>

                            <div class="am-u-sm-9">
                                <input type="text" id="name" name="name" placeholder="商家名称" value="${object.name}" >
                            </div>
                        </div>
                        <div class="am-form-group">
                            <label for="phone" class="am-u-sm-3 am-form-label">联系方式</label>

                            <div class="am-u-sm-9">
                                <input type="text" id="phone" name="phone" placeholder="联系方式" value="${object.phone}" >
                            </div>
                        </div>


                        <div class="am-form-group">
                            <label  class="am-u-sm-3 am-form-label">Logo</label>

                            <div class="am-u-sm-9">
                                <div id="logoUrl">
                                    <c:if test="${!empty object.logoUrl}">
                                        <img width="10%" src="http://pro.efeiyi.com/${object.logoUrl}@!product-model">
                                    </c:if>
                                </div>

                                <a id="btn_upload10"></a>
                                <input type="hidden" name="logoUrl" value="${object.logoUrl}" placeholder="Logo">
                                <%--<input type="file" id="logo" name="logo" placeholder="Logo"--%>
                                       <%--value="${object.logoUrl}">--%>
                            </div>

                        </div>

                        <div class="am-form-group">
                            <label  class="am-u-sm-3 am-form-label">商家首页图片</label>

                            <div class="am-u-sm-9">
                                <div id="pictureUrl">
                                    <c:if test="${!empty object.pictureUrl}">
                                        <img  width="10%" src="http://pro.efeiyi.com/${object.pictureUrl}@!product-model" >
                                    </c:if>
                                </div>


                                <a id="btn_upload11"></a>
                                <input type="hidden" name="pictureUrl" value="${object.pictureUrl}" placeholder="商家首页图片">
                                <%--<input type="file" id="pictureUrl" name="pictureUrl" placeholder="pictureUrl"--%>
                                       <%--value="${object.pictureUrl}">--%>
                            </div>

                        </div>
                        <div class="am-form-group">
                            <label for="name" class="am-u-sm-3 am-form-label">商家简介</label>

                            <div class="am-u-sm-9">
                                <textarea id="content" name="content" rows="3" cols="5" placeholder="商家简介" required>${object.content}</textarea>
                            </div>
                        </div>


                        <div class="am-form-group" style="display: none;">
                            <label for="logo" class="am-u-sm-3 am-form-label">类型</label>
                            <div style="margin-top: 10px;">
                    <span style="padding: 10px;">
                      <input type="radio" name="tenantType" value="11" />
                        企业
                    </span>
                    <span style="padding: 10px;">
                      <input type="radio" name="tenantType" value="12" />
                        个体
                    </span>
                    <span style="padding: 10px;">
                      <input type="radio" name="tenantType" value="13" />
                        个人
                    </span>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="am-tab-panel am-fade" id="tab2">
                    <jsp:include page="/tenantType/sendTenantTypePage1.do" flush="true"/>
                    </div>
            </div>

        </div>
            <c:if test="${object.review == '1' || object.review=='3'}">
            <div class="am-margin">
                <a href="javascript:void (0);" onclick="toSubmitZH('2');" class="am-btn am-btn-primary am-btn-xs">提交审核</a>
                <a href="javascript:void (0);" onclick="toSubmitZH('1');" class="am-btn am-btn-primary am-btn-xs">暂存</a>
            </div>
            </c:if>
        </form>
    </div>
</div>
<script src="<c:url value="/scripts/upload/jquery.uploadify.min.js"/>"></script>
<script>
    $(function(){


        var t = '${object.tenantType}';
        $("input[name='tenantType'][value='"+t+"']").attr("checked",true);
        if('${object.review}'=='2' ||'${object.review}'=='4' ) {
            $("input,textarea").each(function () {
                $(this).attr("readOnly", "readOnly");
            });
            $("select").each(function(){
                   $(this).attr("disabled","disabled");
            });
        }else {
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
                        $("input[name='" + dataType + "']").val(data);
                        var img = '<img width="10%"  src="' + url + '" >';

                        $("#" + dataType).html(img);
                    }
                });
            }
            $("#btn_upload10").ready(fileUploads(10, "logoUrl"));
            $("#btn_upload11").ready(fileUploads(11, "pictureUrl"));
            $("#btn_upload10-button").css({"padding": "0em 0em", "text-align": "center"});
            $("#btn_upload11-button").css({"padding": "0em 0em", "text-align": "center"});
        }
    });



    function toSubmitZH(o){
        var f = true;
        $("input[name='flag']").val(o);
        if(o=="2"){
            $("input").each(function(){
                if($(this).val()==""){
                    if($(this).attr("type")=="hidden"){
                        alert("请上传"+$(this).attr("placeholder"));
                    }else{
                        alert("请填写"+$(this).attr("placeholder"));
                    }
                    f = false;
                    return false;
                }
            });

        }
        $("select").each(function(){
            if($(this).val()==""){
                alert("请选择"+$(this).attr("placeholder"));
                f=false;
                return false;
            }

        });
        if(f){

            $("form").submit();
        }
    }
</script>

</body>
</html>
