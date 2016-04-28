<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <script src="<c:url value='/scripts/jquery-form.js'/>" ></script>
    <link href="<c:url value="/scripts/upload/uploadify.css"/>" rel="stylesheet"/>
    <style>
        .am-modal-dialog {
            background: transparent
        }

        .am-modal-dialog img {
            width: 100%
        }
    </style>
</head>
<body>


<div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">传承人作品</strong> /
        <small>Master Work</small>
    </div>
</div>

<hr/>

<div class="am-g">

    <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8"><%--少了这个div就出错--%>
    </div>

    <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
        <form action="<c:url value="/master/saveMasterWork.do"/>" method="post" class="am-form am-form-horizontal"
              enctype="multipart/form-data">
            <input type="hidden" name="master.id" value="${id}">
            <div class="am-form-group">
                <label for="name" class="am-u-sm-3 am-form-label">作品名称</label>

                <div class="am-u-sm-9">
                    <input type="text" id="name" name="name" disabled="disabled" placeholder="作品名称" value="${object.name}" required>
                    <%--<small>输入你要保存的类型</small>--%>
                </div>
            </div>




            <div class="am-form-group">
                <label for="description" class="am-u-sm-3 am-form-label">作品介绍</label>

                <div class="am-u-sm-9">
                        <textarea id="description" disabled="disabled" name="description" class="ckeditor" placeholder="作品介绍" required
                                  value="">${object.description}</textarea>
                </div>
                <br>
            </div>
            <div class="am-form-group">

                <label for="picurl" class="am-u-sm-3 am-form-label">新图片</label>

                <div class="am-u-sm-9"  style="margin-top: 9px;">
                    <input type="file" id="picurl" name="picurl" placeholder="附件" value="${object.pictureUrl}"/>
                </div>
            </div>

            <div id="tagGroup">

            </div>
            <div class="am-form-group">
                <div class="am-u-sm-9 am-u-sm-push-3">
                    <button disabled="disabled" type="button" onclick="toSub()" class="am-btn am-btn-primary">保存</button>
                </div>
            </div>
        </form>
            <hr style="margin-left: 15%;"/>
            <div style="text-align: center;margin-left: 14%">
                <a id="btn_upload"></a>
                <div class="am-u-md-13">
                    <div class="am-panel am-panel-default">
                        <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-1'}">
                            <strong> 轮播图</strong>
                            <span class="am-icon-chevron-down am-fr"></span></div>
                        <div class="am-panel-bd am-collapse am-in" id="collapse-panel-1" style="height: auto;overflow: hidden">
                            <ul style="width: 100%" style="list-style:none">
                               <c:if test="${not empty masterBannerList}">
                                   <c:forEach var="masterBanner" items="${masterBannerList}">
                                       <li style="float: left;margin-right: 10px;width: 200px;"
                                           name="${masterBanner.id}">
                                           <dl style="margin-top: 6px;">
                                               <dt style="width: 100%">
                                                   <a title="点击查看原图" href="javascript:void (0);"
                                                      onclick="tc('http://tenant.efeiyi.com/${masterBanner.imageUrl}')">
                                                       <img width="100%" name=""
                                                            src="http://tenant.efeiyi.com/${masterBanner.imageUrl}"
                                                            alt="商品图片"/>
                                                   </a>
                                               </dt>
                                                   <dd style="width: 100%;text-align: center;">
                                                       <a href="javascript:void(0);"
                                                          onclick="deleteBannerPicture(this,'${masterBanner.id}')">删除</a>
                                                   </dd>
                                               <dd style="width: 100%;text-align: center;">
                                                   ${masterBanner.title}
                                               </dd>
                                           </dl>
                                       </li>
                                   </c:forEach>
                               </c:if>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
    </div>
</div>
<div class="am-modal am-modal-no-btn" tabindex="-1" id="your-modal" style="background: #f00;">
    <div class="am-modal-dialog"
         style="width:800px;height:800px;position: absolute;top:50%;left: 50%;margin-top: -400px;margin-left: -400px">
        <div class="am-modal-bd">
            <img src="" title="原图">
        </div>
    </div>
</div>
<script src="<c:url value="/scripts/upload/jquery.uploadify.js"/>"></script>
<script>


    var  option = {
        type:"post",
        clearForm:true,
        dataType:"json",
        success:function(data){
            var json = parseJSON(data);
            if(json.result=="true"){
                alert("保存成功!");
            }
        }
    };

    function  toSub(){
        var f = confirm("保存成功后将不允许修改，若需修改请联系客服!");
        if(f) {
            $("form").submit();
        }
    }
    $(function(){
        $('#btn_upload').uploadify({
            uploader: '<c:url value="/master/uploadify.do?id=${id}"/>',            // 服务器处理地址
            swf: '<c:url value="/scripts/upload/uploadify.swf"/>',
            buttonText: "大师轮播图",                 //按钮文字
            buttonClass: "am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only",         //按钮样式
            buttonCursor: "hand",                    //鼠标指针悬停在按钮上的样子
            height: 34,                             //按钮高度
            width: 140,                              //按钮宽度
            auto: true,                          //自动上传
            multi: true,                            //多个文件上传
            scriptDate: {'status': '3'},
            checkExisting: true,                    //检查文件重复
            successTimeout: 1000000,                 //超时
            fileSizeLimit: '20MB',
            removeTimeout: 1,                        //移除时间
            fileTypeExts: "*.jpg;*.png;*.gif",           //允许的文件类型
            fileTypeDesc: "请选择图片文件",           //文件说明
            formData: {"imgType": "normal"}, //提交给服务器端的参数
            onUploadSuccess: function (file, data, response) {   //一个文件上传成功后的响应事件处理
                data = data.substring(1, data.length - 1)
                var masterBannerId = data.split(":")[0].trim();
                var imgUrl = data.split(":")[1];
                var imgName = data.split(":")[2];
                var sort = data.split(":")[3];
                var url = "http://tenant.efeiyi.com/" + imgUrl ;
                var trueUrl = "http://tenant.efeiyi.com/" + imgUrl ;

                var img = '<li style="float: left;margin-right: 10px;width:200px;" sort="'+sort+'" name="' + masterBannerId + '">' +
                          ' <dl style="margin-top: 6px;" >' +
                          '  <dt  style="width: 100%">' +
                          '    <a title="点击查看原图" href="javascript:void (0);" onclick="bigPic(\'' + trueUrl + '\')">' +
                          '      <img width="100%" name="' + masterBannerId + '"  src="' + url + '" alt="轮播图片">' +
                          '   </a>' +
                          '  </dt>' +
                          '  <dd style="width: 100%;text-align:center" >' +
                          '   <a href="javascript:void(0);" onclick="deleteBannerPicture(this,\'' + masterBannerId + '\')">' +
                          ' 删除' +
                          '</a>' +
                          '</dd>' +
                          '<dd style="width: 100%;text-align: center;" >' + imgName +
                          '</dd>' +
                          '</dl>' +
                          '</li>';

                $("#collapse-panel-1 ul").append(img);
            }
        });
        $("#btn_upload-button").css({"padding": "0em 0em", "text-align": "center"});
    });

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
        var html = "    <div class=\"am-form-group\" style='text-align: left'><label  class=\"am-u-sm-3 am-form-label\">作品标签</label><div class=\"am-u-sm-9\">"
        for (var i = 0; i < data.length; i++) {
            html += "<label class=\"am-checkbox-inline\"><input type=\"checkbox\" name=\"tag" + i + "\" value=\"" + data[i].id + "\" > " + data[i].value + "</label>"
        }
        html += "</div></div>"
        return html;
    }

    $().ready(function () {
        getMasterProjectTag();
    });



    function bigPic(url) {
        var img = new Image();
        img.src = url;
        img.onload = function () {
            // alert(img.width+"-->"+img.height);
            //  $("#your-modal .am-modal-dialog ").css({"margin-top":img.width/2,"margin-left":});
            $("#your-modal .am-modal-bd img").attr("title", "原图" + img.width + "x" + img.height);
        };
        $("#your-modal .am-modal-bd img").attr("src", url);

        $("#your-modal").modal();
    }

    function deleteBannerPicture(obj, divId) {

            $.ajax({
                type: "get",
                url: '<c:url value="/master/removeMasterBannerPicture.do"/>',
                cache: false,
                dataType: "json",
                data: {id: divId.trim()},
                success: function (data) {
                    if(data){
                       $("#collapse-panel-1 li[name='" + divId + "']").remove();
                    }else {
                        alert("删除失败，请联系客服!");
                    }
                }
            });
    }



</script>

</body>
</html>
