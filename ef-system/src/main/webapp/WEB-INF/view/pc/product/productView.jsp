<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title></title>
    <link href="<c:url value="/scripts/upload/uploadify.css"/>" rel="stylesheet"/>
    <style>

    </style>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">商品详情</strong> / <small>Product Details</small></div>
</div>
<hr/>

<div class="am-g">
    <form action="/basic/xm.do" method="post"  class="am-form am-form-horizontal">
        <input type="hidden" name="qm" value="">

        <div class="am-form-group">
            <label name="name" class="am-u-sm-3 am-form-label">商品编号</label>
            <div class="am-u-sm-9">
                <div style="margin-top: 9px;">${object.serial}</div>
                <!--<small>必填项*</small>-->
            </div>
        </div>
        <div class="am-form-group">
            <label name="name" class="am-u-sm-3 am-form-label">商品名称</label>
            <div class="am-u-sm-9">
                <div style="margin-top: 9px;">${object.name}</div>
                <!--<small>必填项*</small>-->
            </div>
        </div>
        <div class="am-form-group">
            <label name="name" class="am-u-sm-3 am-form-label">商品主图片</label>
            <div class="am-u-sm-9" id = "picture">
                <c:if test="${!empty object.productPictureList}">
                    <c:forEach var="productPicture" items="${object.productPictureList}" >
                        <c:if test="${productPicture.status == '2'}">
                            <dl style="margin-top: 6px; float: left" id="${productPicture.id}" >
                                <dt>
                                    <img width="80%"  name=""  src="http://tenant.efeiyi.com/${productPicture.pictureUrl}@!tenant-manage-photo" alt="商品主图片" />
                                </dt>
                                <dd>
                                    <a  href="#" onclick="removePicture(this,'${productPicture.id}')">删除</a>
                                </dd>
                            </dl>
                        </c:if>
                    </c:forEach>

                </c:if>
            </div>
            <div class="am-u-sm-9" >
                <a  style="margin-bottom: 2px;color: red;" id="btn_upload2"></a>
            </div>
        </div>
        <div class="am-form-group">
            <label name="name" class="am-u-sm-3 am-form-label">商品图片</label>
            <div class="am-u-sm-9" id="picture1">
                <c:if test="${!empty object.productPictureList}">
                    <c:forEach var="productPicture" items="${object.productPictureList}" >
                        <c:if test="${productPicture.status == '3'}">
                            <dl style="margin-top: 6px; float: left" id="${productPicture.id}">
                                <dt>
                                    <img width="80%"  name=""  src="http://tenant.efeiyi.com/${productPicture.pictureUrl}@!tenant-manage-photo" alt="商品主图片" />
                                </dt>
                                <dd>
                                    <a  href="#" onclick="removePicture(this,'${productPicture.id}')">删除</a>
                                </dd>
                            </dl>
                        </c:if>
                    </c:forEach>

                </c:if>
            </div>
            <div class="am-u-sm-9">
                <a  style="margin-bottom: 2px;color: red;" id="btn_upload"></a>
            </div>
        </div>
        <div class="am-form-group">
            <label name="price"  class="am-u-sm-3 am-form-label">价格</label>
            <div class="am-u-sm-9">
                <div style="margin-top: 9px;">${object.price}</div>
                <!-- <small>必填项*</small>-->
            </div>
        </div>
        <div class="am-form-group">
            <label name="createDate" class="am-u-sm-3 am-form-label">创建时间</label>
            <div class="am-u-sm-9">
                <div style="margin-top: 9px;">
                    <fmt:formatDate value="${object.createDateTime}" type="both" pattern="YYYY-MM-dd HH:mm" />
                </div>
                <!-- <small>必填项*</small>-->
            </div>
        </div>
        <!--
            <div class="am-g">
                <div class="am-u-md-13">
                 <div class="am-panel am-panel-default">
                   <div class="am-panel-hd am-cf" >
                     <a  style="margin-bottom: 2px;color: red;" id="btn_upload"></a>
                   </div>
                </div>
              </div>
            </div>
        -->
        <div class="am-g">
            <div class="am-u-md-13">
                <div class="am-panel am-panel-default">
                    <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-1'}">
                        <span>图片上传</span>
                        <span class="am-icon-chevron-down am-fr" ></span>
                    </div>
                    <div class="am-panel-bd am-collapse am-in" id="collapse-panel-1">
                        <table class="am-table am-table-bd am-table-bdrs am-table-striped am-table-hover">
                            <tbody>
                            <tr>
                                <th class="am-text-center">操作</th>
                                <th class="am-text-center">图片地址</th>
                                <th class="am-text-center">图片预览</th>
                            </tr>
                            <c:if test="${!empty object.productPictureList}">
                                <c:forEach var="productPicture" items="${object.productPictureList}">
                                    <tr id="${productPicture.id}">
                                        <td class="am-text-center">
                                            <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="removePicture(this,'${productPicture.id}')"  href="#">
                                                <span class="am-icon-trash-o"></span> 删除
                                            </a>
                                        </td>
                                        <td class="am-text-center">
                                            http://tenant.efeiyi.com/${productPicture.pictureUrl}@!tenant-manage-photo
                                        </td>
                                        <td class="am-text-center">
                                            <img style="margin-left:2px;" width="18%;" src="http://tenant.efeiyi.com/${productPicture.pictureUrl}@!tenant-manage-photo" />
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </form>
</div>
<!-- content end -->
<hr/>
<script src="<c:url value="/scripts/upload/jquery.uploadify.min.js"/>"></script>
<script>
    $(function(){
        $('#btn_upload').uploadify({
            uploader: '<c:url value="/product/uploadify.do?productId=${object.id}&status=3"/>',            // 服务器处理地址
            swf: '<c:url value="/scripts/upload/uploadify.swf"/>',
            buttonText: "选择商品页图片",                 //按钮文字
            buttonClass:"am-btn  am-btn-primary",         //按钮样式
            buttonCursor:"hand",                    //鼠标指针悬停在按钮上的样子
            height: 34,                             //按钮高度
            width:140,                              //按钮宽度
            auto : true,                          //自动上传
            multi:true,                            //多个文件上传
            scriptDate:{'status':'3'},
            checkExisting:true,                    //检查文件重复
            successTimeout:1000000,                 //超时
            fileSizeLimit:'2MB',
            removeTimeout:1,                        //移除时间
            fileTypeExts: "*.jpg;*.png;",           //允许的文件类型
            fileTypeDesc: "请选择图片文件",           //文件说明
            formData: { "imgType": "normal" }, //提交给服务器端的参数
            onUploadSuccess: function (file, data, response) {   //一个文件上传成功后的响应事件处理
                data = data.substring(1,data.length-1)
                var pictureId = data.split(":")[0].trim();
                var  imgUrl = data.split(":")[1];
                var  url = "http://tenant.efeiyi.com/"+imgUrl+"@!tenant-manage-photo";
                ///图片信息
                var tr = '<tr id = "'+pictureId+'">' +
                        ' <td class="am-text-center">  ' +
                        '   <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="removePicture(this,\''+pictureId+'\')"  href="#">' +
                        '       <span class="am-icon-trash-o"></span> 删除 ' +
                        '   </a>' +
                        ' </td>' +
                        ' <td class="am-text-center">' +url+
                        ' </td>' +
                        ' <td class="am-text-center">' +
                        '   <img style="margin-left:2px;" width="18%;" src="'+url+'">' +
                        ' </td>' +
                        '</tr>';
                ///显示图片
                var img = '<dl style="margin-top: 6px; float: left" id="'+pictureId+'">'+
                        '  <dt>'+
                        '   <img width="80%" name="'+pictureId+ '"  src="'+url+'" alt="商品主图片">'+
                        '  </dt>'+
                        '  <dd>'+
                        '   <a href="#" onclick="removePicture(this,\''+pictureId+'\')">'+
                        ' 删除'+
                        '   </a>'
                '  </dd>'+
                '</dl>';

                $("#picture1").append(img);
                $("table").append(tr);
            }
        });

        $('#btn_upload2').uploadify({
            uploader: '<c:url value="/product/uploadify.do?productId=${object.id}&status=2"/>',            // 服务器处理地址
            swf: '<c:url value="/scripts/upload/uploadify.swf"/>',
            buttonText: "选择主商品图片",                 //按钮文字
            buttonClass:"am-btn  am-btn-primary",         //按钮样式
            buttonCursor:"hand",                    //鼠标指针悬停在按钮上的样子
            height: 34,                             //按钮高度
            width:140,                              //按钮宽度
            auto : true,                          //自动上传
            multi:true,                            //多个文件上传
            scriptDate:{'status':'2'},
            checkExisting:true,                    //检查文件重复
            successTimeout:1000000,                 //超时
            fileSizeLimit:'2MB',
            removeTimeout:1,                        //移除时间
            fileTypeExts: "*.jpg;*.png;",           //允许的文件类型
            fileTypeDesc: "请选择图片文件",           //文件说明
            formData: { "imgType": "normal" }, //提交给服务器端的参数
            onUploadSuccess: function (file, data, response) {   //一个文件上传成功后的响应事件处理
                data = data.substring(1,data.length-1)
                var pictureId = data.split(":")[0].trim();
                var  imgUrl = data.split(":")[1];
                var  url = "http://tenant.efeiyi.com/"+imgUrl+"@!tenant-manage-photo";
                var tr = '<tr id = "'+pictureId+'">' +
                        ' <td class="am-text-center">  ' +
                        '   <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="removePicture(this,\''+pictureId+'\')"  href="#">' +
                        '       <span class="am-icon-trash-o"></span> 删除 ' +
                        '   </a>' +
                        ' </td>' +
                        ' <td class="am-text-center">' +url+
                        ' </td>' +
                        ' <td class="am-text-center">' +
                        '   <img style="margin-left:2px;" width="18%;" src="'+url+'">' +
                        ' </td>' +
                        '</tr>';


                var img = '<dl style="margin-top: 6px; float: left" id="'+pictureId+'">'+
                        '  <dt>'+
                        '   <img width="80%" name="'+pictureId+ '"  src="'+url+'" alt="商品主图片">'+
                        '  </dt>'+
                        '  <dd>'+
                        '   <a href="#" onclick="removePicture(this,\''+pictureId+'\')">'+
                        ' 删除'+
                        '   </a>'
                '  </dd>'+
                '</dl>';

                $("#picture").append(img);
                $("table").append(tr);
            }
        });
        $("#btn_upload-button").css({"padding":"0em 0em","text-align":"center"});
        $("#btn_upload2-button").css({"padding":"0em 0em","text-align":"center"});
    });





    function removePicture(obj,divId){
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeProductPicture"/>',
            cache: false,
            dataType: "json",
            data:{id:divId.trim(),recommendId:divId.trim()},
            success: function (data) {
                $(obj).parent().parent().remove();
                $("#"+divId).remove();
            }
        });
    }


</script>
</body>
</html>
