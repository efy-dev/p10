<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/22
  Time: 10:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title></title>
    <link href="<c:url value="/scripts/upload/uploadify.css"/>" rel="stylesheet"/>
    <script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/>" ></script>
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
<div class="am-g">


    <div class="am-u-md-12">
        <h2>作品详情</h2>
        <table class="am-table am-table-bordered">
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">作品名称</td>
                <td class="am-u-md-3">${object.name}</td>
                <td class="am-primary am-u-md-3" >类别 </td>
                <td class="am-u-md-3">${object.category.name} </td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">作者</td>
                <td class="am-u-md-3">${object.master.fullName}</td>
                <td class="am-primary am-u-md-3">尺寸(规格)</td>
                <td class="am-u-md-3">${object.size}</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">材质</td>
                <td class="am-u-md-3">${object.material}</td>
                <td class="am-primary am-u-md-3">馆藏地</td>
                <td class="am-u-md-3">${object.site}</td>
            </tr>
            </tbody>
        </table>

        <div class="am-u-md-6">
            <h3>简介</h3>
            <textarea style="width:100%" id="content" class="ckeditor"
                      readonly>${object.description}</textarea>
        </div>
    </div>
   <fieldset>
       <legend></legend>
       <a id="btn_upload1"></a>
       <audio src="http://pro.efeiyi.com/${object.audio}" controls="controls" id="audio" style="margin-left: 25px"></audio>
   </fieldset>
    <fieldset>
        <legend>


        </legend>
            <a id="btn_upload"></a>
        <div class="am-u-md-13">
            <div class="am-panel am-panel-default">
                <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-1'}">
                    <strong>作品图片</strong>
                    <span class="am-icon-chevron-down am-fr"></span></div>
                <div class="am-panel-bd am-collapse am-in" id="collapse-panel-1" style="height: auto;overflow: hidden">
                    <%--<a style="margin-bottom: 2px;color: red;" id="btn_upload2"></a>--%>
                    <ul style="width: 100%" style="list-style:none">
                        <c:if test="${!empty object.masterWorkPictureList}">
                            <c:forEach var="masterWorkPicture" items="${object.masterWorkPictureList}">
                                    <li style="float: left;margin-right: 10px;width: 200px;" sort="${masterWorkPicture.sort}"
                                        name="${masterWorkPicture.id}">
                                        <dl style="margin-top: 6px;">
                                            <dt style="width: 100%">
                                                <a title="点击查看原图" href="javascript:void (0);"
                                                   onclick="tc1('http://pro.efeiyi.com/${masterWorkPicture.pictureUrl}@!water-mask')">
                                                    <img width="100%" name=""
                                                         src="http://pro.efeiyi.com/${masterWorkPicture.pictureUrl}@!product-model"
                                                         alt="作品图片"/>
                                                </a>
                                            </dt>
                                            <dd style="width: 100%;text-align: center;">
                                                    <c:choose>
                                                        <c:when test="${object.pictureUrl ==  masterWorkPicture.pictureUrl }">
                                                            <a href="javascript:void(0);" flag = "true"
                                                               onclick="updatePicture(this,'${masterWorkPicture.id}')">封面</a>
                                                        </c:when>
                                                        <c:otherwise>
                                                                <a href="javascript:void(0);" flag = "false"
                                                                   onclick="updatePicture(this,'${masterWorkPicture.id}')">设为封面</a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <a href="javascript:void(0);"
                                                       onclick="removeMasterWorkPicture(this,'${masterWorkPicture.id}')">删除</a>
                                             </dd>
                                             <dd style="width: 100%;text-align: center;">
                                                <a href="javascript:void(0);" onclick="leftImg(this,'<c:url value="/masterWork/changePictureSort.do" />');">左移</a>
                                                <a href="javascript:void(0);" onclick="rightImg(this,'<c:url value="/masterWork/changePictureSort.do" />');">右移</a>
                                            </dd>
                                        </dl>
                                    </li>
                            </c:forEach>
                        </c:if>
                    </ul>
                </div>
            </div>
        </div>
    </fieldset>
</div>

<!--弹出框9--->
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





    $('#btn_upload').uploadify({
        uploader: '<c:url value="/masterWork/uploadify.do?flag=img&masterWorkId=${object.id}"/>',            // 服务器处理地址
        swf: '<c:url value="/scripts/upload/uploadify.swf"/>',
        buttonText: "上传商品图片",                 //按钮文字
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
            var pictureId = data.split(":")[0].trim();
            var imgUrl = data.split(":")[1];
            var imgName = data.split(":")[2];
            var sort = data.split(":")[3];
            var url = "http://pro.efeiyi.com/" + imgUrl + "@!product-model";
            var trueUrl = "http://pro.efeiyi.com/" + imgUrl + "@!water-mask";
            var u= '<c:url value="/masterWork/changePictureSort.do" />';
            ///显示图片
            var img = '<li style="float: left;margin-right: 10px;width:200px;" sort="'+sort+'" name="' + pictureId + '">' +
                    '<dl style="margin-top: 6px;" >' +
                    '  <dt  style="width: 100%">' +
                    '    <a title="点击查看原图" href="javascript:void (0);" onclick="tc1(\'' + trueUrl + '\')">' +
                    '      <img width="100%" name="' + pictureId + '"  src="' + url + '" alt="作品图片">' +
                    '   </a>' +
                    '  </dt>' +
                    '  <dd style="width: 100%;text-align:center" >' +
                    '   <a href="javascript:void(0);" flag = "false" onclick="updatePicture(this,\'' + pictureId + '\')">' + '设为封面' + '</a>' +
                    '   <a href="javascript:void(0);" onclick="removeMasterWorkPicture(this,\'' + pictureId + '\')">' +
                    '     删除' +
                    '   </a>' +
                    '  </dd>' +
                    '<dd style="width: 100%;text-align: center;" sort="" >' +
                    '<a href="javascript:void(0);" onclick="leftImg(this,\''+u+'\');">'+
                    '左移'+
                    '</a>'+
                    '<a href="javascript:void(0);" onclick="rightImg(this,\''+u+'\');">'+
                    '右移'+'</a>'+
                    '</dd>' +
                    '</dl>' +
                    '</li>';

            $("#collapse-panel-1 ul").append(img);

        }
    });


    $('#btn_upload1').uploadify({
        uploader: '<c:url value="/masterWork/uploadify.do?flag=audio&masterWorkId=${object.id}"/>',            // 服务器处理地址
        swf: '<c:url value="/scripts/upload/uploadify.swf"/>',
        buttonText: "上传音频",                 //按钮文字
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
        fileTypeExts: "*.mp3;*.wav;*.wav;*.ogg",           //允许的文件类型
        fileTypeDesc: "请选择图片文件",           //文件说明
        formData: {"imgType": "normal"}, //提交给服务器端的参数
        onUploadSuccess: function (file, data, response) {   //一个文件上传成功后的响应事件处理
            data = data.substring(1, data.length - 1);
            var url = "http://pro.efeiyi.com/" + data ;
            $("audio").attr("src",url);
        }
    });
    $("#btn_upload1-button").css({"padding": "0em 0em", "text-align": "center"});
    $("#btn_upload-button").css({"padding": "0em 0em", "text-align": "center"});


    function leftImg(obj,url){
        var li = $(obj).parents("li");
        var sourceId = $(li).attr("name");
        var sourceSort = $(li).attr("sort");
        var getLeft = $(li).prev();
        var targetId = $(getLeft).attr("name");
        var targetSort = $(getLeft).attr("sort");

        if (getLeft.length == 0) {
            alert("已经是第一个了!");
        } else   if(sourceSort == ""|| targetSort == ""){
            $(getLeft).before(li);
        }else {
            $.ajax({
                type: "get",
                url: url,
                cache: false,
                dataType: "json",
                data: {sourceId: sourceId, sourceSort: sourceSort, targetId: targetId, targetSort: targetSort},
                success: function (data) {
                    $(getLeft).before(li);
                    $(li).attr("sort", targetSort);
                    $(getLeft).attr("sort", sourceSort);
                }
            });

        }

    }
    function rightImg(obj,url){
        var li = $(obj).parents("li");
        var sourceId = $(li).attr("name");
        var sourceSort = $(li).attr("sort");
        var getRight = $(li).next();
        var targetId = $(getRight).attr("name");
        var targetSort = $(getRight).attr("sort");

        if (getRight.length == 0) {
            alert("已经是最后一个了!");
        } else  if(sourceSort==""||targetSort==""){
            $(getRight).after(li);
        }else {
            $.ajax({
                type: "get",
                url: url,
                cache: false,
                dataType: "json",
                data: {sourceId: sourceId, sourceSort: sourceSort, targetId: targetId, targetSort: targetSort},
                success: function (data) {
                    $(getRight).after(li);
                    $(li).attr("sort", targetSort);
                    $(getRight).attr("sort", sourceSort)
                }
            });


        }

    }




    function  updatePicture(obj,id){
        var flag = $(obj).attr("flag");
        var text = $(obj).text();
        $.ajax({
            type: "get",
            url: '<c:url value="/masterWork/updatePicture.do" />',
            cache: false,
            dataType: "json",
            data: {id: id, flag: flag},
            success: function (data) {
                if(data){
                    if(flag=="false"){
                        $("a[flag='true']").text("设为封面");
                        $("a[flag='true']").attr("flag","false");
                    }
                    $(obj).attr("flag",flag=="false"?"true":"false");
                    $(obj).text(text=="封面"?"设为封面":"封面");

                }else {
                    alert("操作失败!");
                }

            }
        });
    }


    function tc1(url) {
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

    function removeMasterWorkPicture(obj,divId) {
        var flag = $(obj).prev("a").attr("flag");
        if(flag=="true"){
            alert("请先取消封面设置!");
        }else {
            $.ajax({
                type: "get",
                url: '<c:url value="/basic/xmj.do?qm=removeMasterWorkPicture"/>',
                cache: false,
                dataType: "json",
                data: {id: divId},
                success: function (data) {
                    $(obj).parents("li").remove();
                }
            });
        }
    }

</script>
</body>
</html>
