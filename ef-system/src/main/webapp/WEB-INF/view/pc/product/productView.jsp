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

        <fieldset>
            <legend>
                <a style="width: 10%;" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="<c:url value="/basic/xm.do?qm=formProduct&id=${object.id}"/>">
                    修改基本信息
                </a>
            </legend>
            <div class="am-form-group">
                <label name="serial" class="am-u-sm-3 am-form-label">商品编号</label>

                <div class="am-u-sm-9">
                    ${object.serial}
                </div>
            </div>
            <div class="am-form-group">
                <label name="name" class="am-u-sm-3 am-form-label">商品名称</label>

                <div class="am-u-sm-9">
                    ${object.name}
                    <!--<small>必填项*</small>-->
                </div>
            </div>

            <div class="am-form-group">
                <label name="price" class="am-u-sm-3 am-form-label">商品价格</label>

                <div class="am-u-sm-9">
                    ${object.price}
                </div>
            </div>
            <div class="am-form-group">
                <label name="serial" class="am-u-sm-3 am-form-label">商品类型</label>

                <div class="am-u-sm-9" style="margin-top: 10px;">
                    <c:if test="${object.status=='1'}">
                        收藏品
                    </c:if>
                    <c:if test="${object.status=='2'}">
                        精品
                    </c:if>
                    <!--<small>必填项*</small>-->
                </div>
            </div>
            <div class="am-form-group">
                <label name="masterList" class="am-u-sm-3 am-form-label">大师</label>
                <div class="am-u-sm-9" style="margin-top: 10px;">
                    ${object.master.fullName}
                    <!--<small>必填项*</small>-->
                </div>
            </div>
            <div class="am-form-group">
                <label name="masterList" class="am-u-sm-3 am-form-label">项目</label>

                <div class="am-u-sm-9" style="margin-top: 10px;" id="projectDisplay">
                    ${object.project.name}
                </div>
            </div>
            <c:if test="${not empty object.id}">
                <div class="am-form-group">
                    <label name="createDate" class="am-u-sm-3 am-form-label">创建时间</label>

                    <div class="am-u-sm-9">
                        <div style="margin-top: 9px;">
                            <fmt:formatDate value="${object.createDateTime}" type="both" pattern="YYYY-MM-dd HH:mm"/>
                        </div>
                        <!-- <small>必填项*</small>-->
                    </div>
                </div>
            </c:if>
        </fieldset>
        <fieldset>
            <legend>
                <a style="width: 10%;" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  onclick="toSubmit('1','redirect:/basic/xm.do?qm=viewProduct&view=${view}&id=${object.id}')">
                    保存商品描述
                </a>
            </legend>
            <div class="am-form-group" >
                <form action="<c:url value="/product/saveNewProduct.do"/>" method="post" class="am-form am-form-horizontal" id="form1">
                <input type="hidden" name="id" value="${object.productDescription.id}">
                <input type="hidden" name="product.id" value="${object.id}">
                <input type="hidden" name="resultPage" value="0" />
                <input type="hidden" name="view" value="${view}">
                <input type="hidden" name="step" value="description">
                <label class="am-u-sm-3 am-form-label">商品描述</label>
                <div class="am-u-sm-9" style="margin-top: 10px;">
                            <textarea id="productDescription" name="content" class="ckeditor"
                                      placeholder="商品描述" required >
                                ${object.productDescription.content}
                            </textarea>
                </div>
                </form>
                <br>
            </div>

        </fieldset>
        <fieldset>
            <legend>
                <a style="width: 10%;" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="<c:url value="/basic/xm.do?qm=formProduct_ProductModel&id=${object.id}"/>">
                    修改属性
                </a>
            </legend>
            <div class="am-u-md-9" style="margin-left: 19%;">
                <div class="am-panel am-panel-default">
                    <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-2'}">商品模型<span
                            class="am-icon-chevron-down am-fr"></span></div>
                    <div id="collapse-panel-2" class="am-in">
                        <table class="am-table am-table-bd am-table-bdrs am-table-striped am-table-hover"
                               id="productModel">
                            <tbody>
                            <tr>
                                <th class="am-text-center" width="20%">商品名称</th>
                                <th class="am-text-center" width="20%">属性</th>
                                <th class="am-text-center" width="20%">库存</th>
                                <th class="am-text-center" width="20%">价格(元)</th>
                                <th class="am-text-center" width="20%">图片</th>
                            </tr>
                            <c:forEach var="model" items="${object.productModelList}">
                                <tr>
                                    <td align="center">
                                            ${model.name}
                                    </td>
                                    <td class="am-text-center">
                                        <c:forEach var="modelProperty" items="${model.productPropertyValueList}">
                                            <span style="padding: 5px;" id="${modelProperty.projectPropertyValue.id}" value="${modelProperty.projectPropertyValue.value}">
                                                    ${modelProperty.projectPropertyValue.value}
                                            </span>
                                        </c:forEach>
                                    </td>
                                    <td align="center">
                                            ${model.amount}
                                    </td>
                                    <td align="center">
                                            ${model.price}
                                    </td>
                                    <td align="center">
                                        <c:if test="${not empty model.productModel_url}">
                                            <img width="30%"  name=""  src="http://tenant.efeiyi.com/${model.productModel_url}@!tenant-manage-photo" alt="商品模型图片" />
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </fieldset>
        <fieldset>
            <legend>
                <%--<a style="width: 10%;" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="<c:url value="/basic/xm.do?qm=formProduct_Picture&id=${object.id}"/>">--%>
                <%--修改图片--%>
                <%--</a>--%>
                <a id="btn_upload"></a>
            </legend>

            <div class="am-u-md-13">
                <div class="am-panel am-panel-default">
                    <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-1'}">
                        <strong> 商品图片</strong>
                        <span class="am-icon-chevron-down am-fr"></span></div>
                    <div class="am-panel-bd am-collapse am-in" id="collapse-panel-1" style="height: auto;overflow: hidden">
                        <a style="margin-bottom: 2px;color: red;" id="btn_upload2"></a>
                        <ul style="width: 100%"  style="list-style:none">
                            <c:if test="${!empty object.productPictureList}">
                                <c:forEach var="productPicture" items="${object.productPictureList}">

                                    <li style="float: left;margin-right: 10px;"  name="${productPicture.id}">
                                        <dl style="margin-top: 6px;">
                                            <dt style="width: 50%">
                                                <img width="100%" name=""
                                                     src="http://pro.efeiyi.com/${productPicture.pictureUrl}@!product-model"
                                                     alt="商品图片"/>
                                            </dt>

                                            <dd style="width: 50%;text-align: center;" >
                                                <c:choose>
                                                    <c:when test="${productPicture.status == '2'}">
                                                        <a href="#"  onclick="updatePictureStatus('${productPicture.id}','1')">主图片</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="#" onclick="updatePictureStatus('${productPicture.id}','2')">设为主图片</a>
                                                    </c:otherwise>
                                                </c:choose>
                                                <a href="#" onclick="deletePicture(this,'${productPicture.id}')">删除</a>
                                            </dd>
                                        </dl>
                                    </li>
                                </c:forEach>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>


            <%--<div class="am-u-md-13">--%>
            <%--<div class="am-panel am-panel-default">--%>
            <%--<div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-3'}">--%>
            <%--<strong> 商品详情图片</strong>--%>
            <%--<span class="am-icon-chevron-down am-fr" ></span></div>--%>
            <%--<div id="collapse-panel-3" class="am-panel-bd am-collapse am-in" style="height: auto;overflow: hidden">--%>
            <%--<a  style="margin-bottom: 2px;color: red;" id="btn_upload"></a>--%>
            <%--<c:if test="${!empty object.productPictureList}">--%>
            <%--<ul style="width: 100%"  style="list-style:none">--%>
            <%--<c:forEach var="productPicture" items="${object.productPictureList}" >--%>
            <%--<c:if test="${productPicture.status == '3'}">--%>
            <%--<li style="float: left;margin-right: 10px;"  name="${productPicture.id}">--%>
            <%--<dl style="margin-top: 6px;">--%>
            <%--<dt style="width: 80%">--%>
            <%--<img width="100%"  name=""  src="http://tenant.efeiyi.com/${productPicture.pictureUrl}@!tenant-manage-photo" alt="商品主图片" />--%>
            <%--</dt>--%>
            <%--</dl>--%>
            <%--</li>--%>
            <%--</c:if>--%>
            <%--</c:forEach>--%>
            <%--</ul>--%>
            <%--</c:if>--%>
            <%--</div>--%>
            <%--</div>--%>
            <%--</div>--%>
        </fieldset>

        <fieldset>
            <legend>
                <%--<a style="width: 10%;" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="<c:url value="/basic/xm.do?qm=formProduct_Picture&id=${object.id}"/>">--%>
                <%--修改图片--%>
                <%--</a>--%>
                图片地址
            </legend>
            <div class="am-u-md-13">
                <div class="am-panel am-panel-default">
                    <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-4'}">
                        <strong>图片地址</strong>
                        <span class="am-icon-chevron-down am-fr" ></span></div>
                    <div id="collapse-panel-4" class="am-in">
                        <table class="am-table am-table-bd am-table-bdrs am-table-striped am-table-hover" id="picUrl">

                            <tr>
                                <th>操作</th>
                                <th>图片地址</th>
                                <th>图片</th>
                            </tr>
                            <c:forEach var="productPicture" items="${object.productPictureList}">
                                <tr name="${productPicture.id}">
                                    <td>
                                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="deletePicture(this,'${productPicture.id}')"  href="#">
                                            <span class="am-icon-trash-o"></span> 删除
                                        </a>
                                    </td>
                                    <td>http://tenant.efeiyi.com/${productPicture.pictureUrl}@!tenant-manage-photo</td>
                                    <td>
                                        <img width="18%"  name=""  src="http://pro.efeiyi.com/${productPicture.pictureUrl}" alt="" />
                                    </td>
                                </tr>
                            </c:forEach>

                        </table>
                    </div>
                </div>
            </div>
        </fieldset>
    <form action="<c:url value="/product/saveNewProduct.do"/>" method="post" class="am-form am-form-horizontal" id="form2">
        <input type="hidden" name="resultPage" value="0" />
        <input type="hidden" name="step" value="view">
        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">

                    <span style="padding: 10px;">
                       <input type="button"  onclick="toSubmit('2','redirect:/basic/xm.do?qm=plistProduct_tenant&view=${view}&conditions=tenant.id:${object.tenant.id}&tenantId=${object.tenant.id}')" class="am-btn am-btn-primary" value="返回商品列表"/>
                    </span>
            </div>
        </div>
    </form>
</div>
<!-- content end -->
<hr/>
<script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/>"></script>
<script src="<c:url value="/scripts/upload/jquery.uploadify.min.js"/>"></script>
<script>

    $(function(){
        $('#btn_upload').uploadify({
            uploader: '<c:url value="/product/uploadify.do?productId=${object.id}"/>',            // 服务器处理地址
            swf: '<c:url value="/scripts/upload/uploadify.swf"/>',
            buttonText: "上传商品图片",                 //按钮文字
            buttonClass:"am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only",         //按钮样式
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
                var  url = "http://pro.efeiyi.com/"+imgUrl+"@!product-model";
                ///图片信息
                var tr = '<tr name = "'+pictureId+'">' +
                        ' <td>  ' +
                        '   <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="deletePicture(this,\''+pictureId+'\')"  href="#">' +
                        '       <span class="am-icon-trash-o"></span> 删除 ' +
                        '   </a>' +
                        ' </td>' +
                        ' <td>' +url+
                        ' </td>' +
                        ' <td>' +
                        '   <img style="margin-left:2px;" width="18%;" src="'+url+'">' +
                        ' </td>' +
                        '</tr>';
                ///显示图片
                var img ='<li style="float: left;margin-right: 10px;" name="'+pictureId+'">'+
                        '<dl style="margin-top: 6px;" >'+
                        '  <dt  style="width: 50%">'+
                        '   <img width="100%" name="'+pictureId+ '"  src="'+url+'" alt="商品主图片">'+
                        '  </dt>'+
                        '  <dd style="width: 50%;text-align:center" >'+
                        '   </a>'+
                        '<a href="#" onclick="updatePictureStatus(\''+data+'\',\'2\')">'+'设为主图片'+'</a>'+
                        '   <a href="#" onclick="deletePicture(this,\''+pictureId+'\')">'+
                        ' 删除'+
                        '</dd>'+
                        '</dl>'+
                        '</li>';

                $("#collapse-panel-1 ul").append(img);
                $("#picUrl").append(tr);
            }
        });
        $("#btn_upload-button").css({"padding":"0em 0em","text-align":"center"});
    });


    //提交
    function toSubmit(result){
        $("input[name='resultPage']").val(result);
        $("form").submit();
    }


    function updatePictureStatus(id,status){
        $.ajax({
            type: "get",
            url: '<c:url value="/product/updatePicture.do"/>',
            cache: false,
            dataType: "json",
            data:{id:id.trim(),status:status},
            success: function (data) {
                if(status == '2'){

                    var  a = '<a href="#"  onclick="updatePictureStatus(\''+data+'\',\'1\')">'+'主图片'+'</a>'+
                                    '   <a href="#" onclick="deletePicture(this,\''+data+'\')">'+
                                    ' 删除'+
                                    '</a>'
                            ;
                    $("#collapse-panel-1 li[name='" + data + "'] dd").html(a);
                }
                if(status == '1'){
                    var  a = '<a href="#"  onclick="updatePictureStatus(\''+data+'\',\'2\')">'+'设为主图片'+'</a>'+
                            '   <a href="#" onclick="deletePicture(this,\''+data+'\')">'+
                            ' 删除'+
                            '</a>';
                    $("#collapse-panel-1 li[name='" + data + "'] dd").html(a);
                }
            }
        });
    }


    function deletePicture(obj,divId){
        $.ajax({
            type: "get",
            url: '<c:url value="/product/deletePicture.do"/>',
            cache: false,
            dataType: "json",
            data:{id:divId.trim()},
            success: function (data) {
                $("#picUrl tr[name='" + divId + "']").remove();
                $("#collapse-panel-1 li[name='" + divId + "']").remove();
            }
        });
    }

    function toSubmit(st,result){
        $("input[name='resultPage']").val(result);

            $("#form"+st).submit();


    }
</script>

</body>
</html>
