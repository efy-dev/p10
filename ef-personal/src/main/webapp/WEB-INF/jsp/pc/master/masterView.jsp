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
        <form action="<c:url value="/toCheck.do"/>" method="post" class="am-form am-form-horizontal">
            <input type="hidden" name="id" value="${object.id}">
            <c:if test="${not empty object.status}">
                <input type="hidden" name="status" value="${object.status}">
            </c:if>
            <c:if test="${empty object.status}">
                <input type="hidden" name="status" value="1">
            </c:if>
            <input type="hidden" name="flag" value="">
            <div class="am-tabs am-margin" data-am-tabs>
                <ul class="am-tabs-nav am-nav am-nav-tabs">
                    <li class="am-active" id="t1"><a href="#tab1">基本信息</a></li>
                    <li id="t2"><a href="#tab2">完善信息</a></li>
                </ul>
                <div class="am-tabs-bd">
                    <div class="am-tab-panel am-fade am-in am-active" id="tab1">
                        <div class="am-g am-margin-top">
                            <div class="am-form-group">
                                <label for="name" class="am-u-sm-3 am-form-label">姓名拼音</label>

                                <div class="am-u-sm-9">
                                    <input type="text" id="name" name="name" placeholder="姓名拼音 / NamePinYin"
                                           value="${object.name}">
                                </div>
                            </div>

                            <div class="am-form-group">
                                <label for="fullName" class="am-u-sm-3 am-form-label">中文姓名</label>

                                <div class="am-u-sm-9">
                                    <input type="text" id="fullName" name="fullName" placeholder="中文姓名 / FullName"
                                           value="${object.fullName}" required>
                                </div>
                            </div>
                            <%--<div class="am-form-group">--%>
                                <%--<label for="projectName" class="am-u-sm-3 am-form-label">项目</label>--%>

                                <%--<div class="am-u-sm-9">--%>
                                    <%--<input type="text" id="projectName" name="projectName" placeholder="项目 / project"--%>
                                           <%--value="${object.projectName}" >--%>
                                <%--</div>--%>
                            <%--</div>--%>

                            <div class="am-form-group">
                                <label class="am-u-sm-3 am-form-label">等级 / Level</label>
                                <div class="am-u-sm-9">
                                    <ming800:status name="level" dataType="Master.level" checkedValue="${object.level}"
                                                    type="select"/>
                                </div>
                            </div>

                            <%--<div class="am-form-group">--%>
                                <%--<label for="birthday" class="am-u-sm-3 am-form-label">出生日期</label>--%>

                                <%--<div class="am-u-sm-9">--%>
                                    <%--<div class="am-form-group am-form-icon">--%>
                                        <%--<i class="am-icon-calendar"></i>--%>
                                        <%--<input type="text" id="birthday" name="birthday"--%>
                                               <%--class="am-form-field am-input-sm"--%>
                                               <%--placeholder="出生日期" value="${object.birthday}">--%>
                                    <%--</div>--%>
                                <%--</div>--%>
                            <%--</div>--%>

                            <div class="am-form-group">
                                <label for="presentAddress" class="am-u-sm-3 am-form-label">现居地</label>

                                <div class="am-u-sm-9">
                                    <input type="text" id="presentAddress" name="presentAddress"
                                           placeholder="现居地/ PresentAddress"
                                           value="${object.presentAddress}">
                                </div>
                            </div>

                            <div class="am-form-group">
                                <label for="presentAddress" class="am-u-sm-3 am-form-label">籍贯</label>

                                <div class="am-u-sm-9">
                                    <input type="text" id="provinceName" name="provinceName"
                                           placeholder="籍贯/ ProvinceName"
                                           value="${object.provinceName}">
                                </div>
                            </div>

                            <%--<div class="am-form-group">--%>
                                <%--<label for="sex" class="am-u-sm-3 am-form-label">性别</label>--%>

                                <%--<div class="am-u-sm-9">--%>
                                    <%--<ming800:status name="sex" dataType="Master.sex" checkedValue="${object.sex}"--%>
                                                    <%--type="select"--%>
                                                    <%--required="true"/>--%>
                                <%--</div>--%>
                            <%--</div>--%>

                            <%--<div class="am-form-group">--%>
                                <%--<label for="favicon" class="am-u-sm-3 am-form-label">头像(传承人列表页面的封面)</label>--%>

                                <%--<div class="am-u-sm-9">--%>
                                    <%--<input type="file" id="favicon" name="favicon" placeholder="头像 / Favicon"--%>
                                           <%--value="${object.favicon}">--%>
                                <%--</div>--%>
                                <%--<c:if test="${!empty object.favicon}">--%>
                                    <%--<img src="http://tenant.efeiyi.com/${object.favicon}@!tenant-manage-photo">--%>
                                <%--</c:if>--%>
                            <%--</div>--%>

                            <%--<div class="am-form-group">--%>
                                <%--<label for="background" class="am-u-sm-3 am-form-label">背景图片(移动网站背景图片)</label>--%>

                                <%--<div class="am-u-sm-9">--%>
                                    <%--<input type="file" id="background" name="background" placeholder="背景图片"--%>
                                           <%--value="${object.backgroundUrl}">--%>
                                <%--</div>--%>
                                <%--<c:if test="${!empty object.backgroundUrl}">--%>
                                    <%--<img src="http://tenant.efeiyi.com/${object.backgroundUrl}@!tenant-manage-photo">--%>
                                <%--</c:if>--%>
                            <%--</div>--%>

                            <%--<div class="am-form-group">--%>
                                <%--<label for="logo" class="am-u-sm-3 am-form-label">Logo</label>--%>

                                <%--<div class="am-u-sm-9">--%>
                                    <%--<input type="file" id="logo" name="logo" placeholder="Logo"--%>
                                           <%--value="${object.logoUrl}">--%>
                                <%--</div>--%>
                                <%--<c:if test="${!empty object.logoUrl}">--%>
                                    <%--<img src="http://tenant.efeiyi.com/${object.logoUrl}@!tenant-manage-photo">--%>
                                <%--</c:if>--%>
                            <%--</div>--%>
                            <div class="am-form-group">
                                <label  class="am-u-sm-3 am-form-label">LOGO</label>
                                <fieldset>
                                    <legend>
                                        <a id="btn_upload4"></a>
                                    </legend>

                                    <div class="am-u-md-13">
                                        <div class="am-panel am-panel-default">
                                            <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-14'}">
                                                <strong>背景图片</strong>
                                                <input type="hidden" name="logoUrl" value="${object.logoUrl}"  placeholder="背景图片">
                                                <span class="am-icon-chevron-down am-fr"></span></div>
                                            <div class="am-panel-bd am-collapse am-in" id="collapse-panel-14" style="height: auto;overflow: hidden">
                                                <ul style="width: 100%"  style="list-style:none">
                                                    <c:if test="${!empty object.logoUrl}">
                                                        <li style="float: left;margin-right: 10px;"  name="${object.id}">
                                                            <dl style="margin-top: 6px;">
                                                                <dt style="width: 50%">
                                                                    <img width="100%" name=""
                                                                         src="http://tenant.efeiyi.com/${object.logoUrl}@!tenant-manage-work-view"
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
                                <label  class="am-u-sm-3 am-form-label">背景图片</label>
                                <fieldset>
                                    <legend>
                                        <a id="btn_upload1"></a>
                                    </legend>

                                    <div class="am-u-md-13">
                                        <div class="am-panel am-panel-default">
                                            <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-11'}">
                                                <strong>背景图片</strong>
                                                <input type="hidden" name="backgroundUrl" value="${object.backgroundUrl}"  placeholder="背景图片">
                                                <span class="am-icon-chevron-down am-fr"></span></div>
                                            <div class="am-panel-bd am-collapse am-in" id="collapse-panel-11" style="height: auto;overflow: hidden">
                                                <ul style="width: 100%"  style="list-style:none">
                                                    <c:if test="${!empty object.backgroundUrl}">
                                                        <li style="float: left;margin-right: 10px;"  name="${object.id}">
                                                            <dl style="margin-top: 6px;">
                                                                <dt style="width: 50%">
                                                                    <img width="100%" name=""
                                                                         src="http://tenant.efeiyi.com/${object.backgroundUrl}@!tenant-manage-work-view"
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
                                <label  class="am-u-sm-3 am-form-label">头像(传承人列表页面的封面)</label>
                                <fieldset>
                                    <legend>
                                        <a id="btn_upload2" ></a>
                                    </legend>

                                    <div class="am-u-md-13">
                                        <div class="am-panel am-panel-default">
                                            <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-12'}">
                                                <strong>头像(传承人列表页面的封面)</strong>
                                                <input type="hidden" name="favicon" value="${object.favicon}" placeholder="头像(传承人列表页面的封面)">
                                                <span class="am-icon-chevron-down am-fr"></span></div>
                                            <div class="am-panel-bd am-collapse am-in" id="collapse-panel-12" style="height: auto;overflow: hidden">
                                                <ul style="width: 100%"  style="list-style:none">
                                                    <c:if test="${!empty object.favicon}">
                                                        <li style="float: left;margin-right: 10px;"  name="${object.id}">
                                                            <dl style="margin-top: 6px;">
                                                                <dt style="width: 50%">
                                                                    <img width="100%" name="favicon"
                                                                         src="http://tenant.efeiyi.com/${object.favicon}@!tenant-manage-work-view"
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
                                <label for="user-intro" class="am-u-sm-3 am-form-label">简介 / Brief</label>
                                <div class="am-u-sm-9" style="text-align: left;">
                                <textarea class="" cols="6" name="brief" rows="2" id="user-intro"
                              placeholder="输入短简介,限30字以内">${object.brief}</textarea>
                                    <small>输入短简介,限30字以内</small>
                                </div>
                            </div>
                            <div class="am-form-group">
                                <label for="content" class="am-u-sm-3 am-form-label">介绍 / Content</label>

                                <div class="am-u-sm-9">
                                    <textarea id="content" name="content" class="ckeditor" placeholder="输入简介"
                                              required>${object.content}</textarea>
                                </div>
                                <br>
                            </div>
                            <span style="margin-left: 92%">
                             <a href="javascript:void (0);" onclick="nextGo('t1','t2');" class="am-btn am-btn-primary am-btn-xs">下一步</a>
                       </span>
                        </div>
                    </div>
                    <div class="am-tab-panel am-fade" id="tab2">
                        <jsp:include page="/masterDatils.do" flush="true"/>
                   <span style="margin-left: 92%">
                      <a href="javascript:void (0);" onclick="prevGo('t1','t2');"
                         class="am-btn am-btn-primary am-btn-xs">上一步</a>
                    </span>
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
    function nextGo(activity1, activity2) {
        $("#" + activity1).removeClass("am-active");
        $("#" + activity2).addClass("am-active");
        $("#tab1").removeClass("am-active");
        $("#tab1").removeClass("am-in");
        $("#tab2").addClass("am-active");
        $("#tab2").addClass("am-in");
    }
    function prevGo(activity1, activity2) {
        $("#" + activity2).removeClass("am-active");
        $("#" + activity1).addClass("am-active");
        $("#tab2").removeClass("am-active");
        $("#tab2").removeClass("am-in");
        $("#tab1").addClass("am-active");
        $("#tab1").addClass("am-in");


    }
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
            $("#btn_upload4").ready(fileUploads(4, "logoUrl"));
            $("#btn_upload1").ready(fileUploads(1, "backgroundUrl"));
            $("#btn_upload2").ready(fileUploads(2, "favicon"));
//            $("#btn_upload-button").css({"padding": "0em 0em", "text-align": "center"});
            $("#btn_upload4-button").css({"padding": "0em 0em", "text-align": "center"});
            $("#btn_upload1-button").css({"padding": "0em 0em", "text-align": "center"});
            $("#btn_upload2-button").css({"padding": "0em 0em", "text-align": "center"});
            $("#SWFUpload_4").css({left:"5"});
            $("#SWFUpload_1").css({left:"5"});
            $("#SWFUpload_2").css({left:"5"});

        }

    });


    function toSubmitZH(o) {
        var f = true;
        $("input[name='flag']").val(o);
        if (o == "2") {
            $("input").each(function () {
                if ($(this).val() == "") {
                    if ($(this).attr("type") == "hidden") {
                        alert("请上传 " + $(this).attr("placeholder") + "+" + $(this).attr("name"));
                    } else {
                        alert("请填写 " + $(this).attr("placeholder"));
                    }
                    f = false;
                    return false;
                }
            });

        }
        $("select").each(function () {
            if ($(this).val() == "") {
                alert("请选择 " + $(this).attr("ZH_CN"));
                f = false;
                return false;
            }

        });
        var card = $("input[name='identityCard']").val();
        var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
        if (card != "") {
            if (!reg.test(card)) {
                alert("身份证格式不正确!");
                f = false;
            }
        }
        if (f) {

            $("form").submit();
        }
    }
</script>

</body>
</html>
