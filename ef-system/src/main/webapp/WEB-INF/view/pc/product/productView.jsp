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
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <title></title>
    <link href="<c:url value="/scripts/upload/uploadify.css"/>" rel="stylesheet"/>
    <style type="text/css">
        .line{margin-bottom:20px;}
        /* 复制提示 */
        .copy-tips{position:fixed;z-index:999;bottom:50%;left:50%;margin:0 0 -20px -80px;background-color:rgba(0, 0, 0, 0.2);filter:progid:DXImageTransform.Microsoft.Gradient(startColorstr=#30000000, endColorstr=#30000000);padding:6px;}
        .copy-tips-wrap{padding:10px 20px;text-align:center;border:1px solid #F4D9A6;background-color:#FFFDEE;font-size:14px;}
    </style>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">商品详情</strong> / <small>Product Details</small></div>
</div>
<hr/>
           <c:if test="${not empty object.tenant}">
             <c:set var="tenantId" value="${object.tenant.id}"/>
           </c:if>
           <c:if test="${empty object.tenant}">
             <c:set var="tenantId" value="0"/>
           </c:if>
           <c:if test="${not empty object.master}">
             <c:set var="masterId" value="${object.master.id}"/>
           </c:if>
           <c:if test="${empty object.master}">
             <c:set var="masterId" value="0"/>
           </c:if>
<div class="am-g">
    <%--<fieldset>--%>
        <%--<legend>--%>
            <%--<span >--%>
            <%--&lt;%&ndash;<select onchange="changeUrl(this)" >&ndash;%&gt;--%>
                <%--&lt;%&ndash;<option value="0">请选择</option>&ndash;%&gt;--%>
                <%--&lt;%&ndash;<c:forEach var="model" items="${object.productModelList}">&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<option value="${model.id}">${model.name}</option>&ndash;%&gt;--%>
                <%--&lt;%&ndash;</c:forEach>&ndash;%&gt;--%>
            <%--&lt;%&ndash;</select>&ndash;%&gt;--%>

            <%--&lt;%&ndash;<a style="width: 10%;" id="yulan" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="#">&ndash;%&gt;--%>
                <%--&lt;%&ndash;生成预览&ndash;%&gt;--%>
            <%--&lt;%&ndash;</a>&ndash;%&gt;--%>
                <%--</span>--%>
        <%--</legend>--%>
    <%--</fieldset>--%>
    <form action="<c:url value="/product/saveNewProduct.do"/>" method="post" class="am-form am-form-horizontal" id="form">
        <fieldset>
            <legend>
                <a style="width: 10%;" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="<c:url value="/basic/xm.do?qm=formProduct&view=${view}&id=${object.id}&tenantId=${tenantId}&masterId=${masterId}"/>">
                    修改基本信息
                </a>
            </legend>
            <div class="am-form-group">
                <label name="serial" class="am-u-sm-3 am-form-label">商品编号</label>

                <div class="am-u-sm-9" style="margin-top: 10px;">
                    ${object.serial}
                </div>
            </div>
            <div class="am-form-group">
                <label name="name" class="am-u-sm-3 am-form-label">商品名称</label>

                <div class="am-u-sm-9" style="margin-top: 10px;">
                    ${object.name}
                    <!--<small>必填项*</small>-->
                </div>
            </div>

            <%--<div class="am-form-group">--%>
                <%--<label name="price" class="am-u-sm-3 am-form-label">商品价格</label>--%>

                <%--<div class="am-u-sm-9" style="margin-top: 10px;">--%>
                    <%--${object.price}--%>
                <%--</div>--%>
            <%--</div>--%>

            <div class="am-form-group">
                <label name="serial" class="am-u-sm-3 am-form-label">商品类型</label>

                <div class="am-u-sm-9" style="margin-top: 10px;">
                    <c:if test="${object.status=='1'}">
                        普通
                    </c:if>
                    <c:if test="${object.status=='2'}">
                        精品
                    </c:if>
                    <!--<small>必填项*</small>-->
                </div>
            </div>
            <div class="am-form-group">
                <label name="price" class="am-u-sm-3 am-form-label">关联商家</label>

                <div class="am-u-sm-9" style="margin-top: 10px;">
                    ${object.tenant.name}
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
    </form>
    <fieldset>
        <legend>
            <a style="width: 10%;" href="javascript:void(0);" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  onclick="toSubmit('1','redirect:/basic/xm.do?qm=viewProduct&view=${view}&id=${object.id}')">
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
                            <textarea id="productDescription" name="content" class="ckeditor" id="content"
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
            <a style="width: 10%;" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="<c:url value="/basic/xm.do?qm=formProduct_ProductModel&view=${view}&id=${object.id}"/>">
                修改规格
            </a>
        </legend>
        <div class="am-u-md-9" style="margin-left: 19%;">
            <div class="am-panel am-panel-default">
                <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-2'}">商品规格<span
                        class="am-icon-chevron-down am-fr"></span></div>
                <div id="collapse-panel-2" class="am-in">
                    <table class="am-table am-table-bd am-table-bdrs am-table-striped am-table-hover"
                           id="productModel">
                        <tbody>
                        <tr>
                            <th class="am-text-center" width="15%">预览</th>
                            <th class="am-text-center" width="15%">规格名称</th>
                            <th class="am-text-center" width="15%">属性</th>
                            <th class="am-text-center" width="15%">库存</th>
                            <th class="am-text-center" width="15%">价格(元)</th>
                            <th class="am-text-center" width="15%">市场价格(元)</th>
                            <%--<th class="am-text-center" width="20%">图片</th>--%>
                        </tr>
                        <c:forEach var="model" items="${object.productModelList}">
                            <tr>
                                <td align="center">
                                    <a style="width: 10%;"  class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="javascript:void(0);" onclick="changeUrl('${model.id}')">
                                        生成预览
                                    </a>
                                </td>
                                <td class="am-text-center">
                                       ${model.name}
                                </td>
                                <td class="am-text-center">
                                    <c:if test="${model.status == '1'}">
                                        <c:forEach var="modelProperty" items="${model.productPropertyValueList}">
                                            <span style="padding: 5px;" id="${modelProperty.projectPropertyValue.id}" value="${modelProperty.projectPropertyValue.value}">
                                                    ${modelProperty.projectPropertyValue.value}
                                            </span>
                                        </c:forEach>
                                    </c:if>
                                    <c:if test="${model.status == '2'}">
                                       ${model.customProperty}
                                    </c:if>
                                    <c:if test="${model.status == '3'}">
                                        无
                                    </c:if>
                                </td>
                                <td align="center">
                                        ${model.amount}
                                </td>
                                <td align="center">
                                        ${model.price}
                                </td>
                                <td align="center">
                                        ${model.marketPrice}
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
                    <%--<a style="margin-bottom: 2px;color: red;" id="btn_upload2"></a>--%>
                    <ul style="width: 100%"  style="list-style:none">
                        <c:if test="${!empty object.productPictureList}">
                            <c:forEach var="productPicture" items="${object.productPictureList}">
                                <c:if test="${productPicture.status != '3' && productPicture.status != '9'}">
                                    <li style="float: left;margin-right: 10px;width: 200px;"  name="${productPicture.id}">
                                        <dl style="margin-top: 6px;">
                                            <dt style="width: 100%">
                                                <img width="100%" name=""
                                                     src="http://pro.efeiyi.com/${productPicture.pictureUrl}@!product-model"
                                                     alt="商品图片"/>
                                            </dt>

                                            <dd style="width: 100%;text-align: center;" >
                                                <c:choose>
                                                    <c:when test="${productPicture.status == '2'}">
                                                        <a href="javascript:void(0);" status="2" onclick="updatePictureStatus(this,'${productPicture.id}','1')">主图片</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="javascript:void(0);" status="1" onclick="updatePictureStatus(this,'${productPicture.id}','2')">设为主图片</a>
                                                    </c:otherwise>
                                                </c:choose>
                                                <a href="javascript:void(0);" onclick="deletePicture(this,'${productPicture.id}')">删除</a>
                                            </dd>

                                            <dd style="width: 100%;text-align: center;" >

                                                    <select style="width: 85%;" onchange="setModelPic(this,'${productPicture.id}')">
                                                        <option value="0">设置商品规格图片</option>
                                                        <c:forEach var="productModel1" items="${object.productModelList}">
                                                            <option value="${productModel1.id}" <c:if test="${productModel1.id==productPicture.productModel.id}">selected="selected"</c:if>>${productModel1.name}</option>
                                                        </c:forEach>
                                                    </select>

                                            </dd>
                                            <dd style="width: 100%;text-align: center;" >
                                                    ${fn:substring(productPicture.pictureUrl, fn:indexOf(productPicture.pictureUrl,"/" )+1, fn:length(productPicture.pictureUrl)-18)}.jpg
                                            </dd>
                                            <dd style="width: 100%;text-align: center;" >
                                                <a href="javascript:void(0);"  class="copy" url="http://pro.efeiyi.com/${productPicture.pictureUrl}">复制图片地址</a>
                                            </dd>
                                        </dl>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </c:if>
                    </ul>
                </div>
            </div>
        </div>
    </fieldset>
    <fieldset>
        <legend>

            <a id="btn_upload3"></a>
        </legend>
        <div class="am-u-md-13">
            <div class="am-panel am-panel-default">
                <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-3'}">
                    <strong> 商品详情图片</strong>
                    <span class="am-icon-chevron-down am-fr"></span></div>
                <div class="am-panel-bd am-collapse am-in" id="collapse-panel-3" style="height: auto;overflow: hidden">

                    <ul style="width: 100%"  style="list-style:none">
                        <c:if test="${!empty object.productPictureList}">
                            <c:forEach var="productPicture" items="${object.productPictureList}">
                                <c:if test="${productPicture.status == '3' || productPicture.status == '9'}">
                                    <li style="float: left;margin-right: 10px; width: 200px;"  name="${productPicture.id}">
                                        <dl style="margin-top: 6px;">
                                            <dt style="width: 100%">
                                                <img width="100%" name=""
                                                     src="http://pro.efeiyi.com/${productPicture.pictureUrl}@!product-model"
                                                     alt="商品图片"/>
                                            </dt>

                                            <dd style="width: 100%;text-align: center;" >
                                                <c:choose>
                                                    <c:when test="${productPicture.status == '9'}">
                                                        <a href="javascript:void(0);" status="3" onclick="updatePictureStatus(this,'${productPicture.id}','3')">推荐图片</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="javascript:void(0);" status="9" onclick="updatePictureStatus(this,'${productPicture.id}','9')">设为推荐图片</a>
                                                    </c:otherwise>
                                                </c:choose>
                                                <a href="javascript:void(0);" onclick="deletePicture(this,'${productPicture.id}')">删除</a>
                                            </dd>
                                            <dd style="width: 100%;text-align: center;" >
                                                    ${fn:substring(productPicture.pictureUrl, fn:indexOf(productPicture.pictureUrl,"/" )+1, fn:length(productPicture.pictureUrl)-18)}
                                            </dd>
                                            <dd style="width: 100%;text-align: center;" >
                                                <a href="javascript:void(0);"  class="copy" url="http://pro.efeiyi.com/${productPicture.pictureUrl}">复制图片地址</a>
                                            </dd>
                                            <dd style="width: 100%;text-align: center;" >
                                                    ${fn:substring(productPicture.pictureUrl, fn:indexOf(productPicture.pictureUrl,"/" )+1, fn:length(productPicture.pictureUrl)-18)}.jpg
                                            </dd>
                                        </dl>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </c:if>
                    </ul>
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
                        <c:if test="${view == 'newProduct'}">
                            <input type="button"  onclick="toSubmit('2','redirect:/basic/xm.do?qm=plistProduct_defalut&view=${view}')" class="am-btn am-btn-primary" value="返回商品列表"/>
                        </c:if>
                         <c:if test="${view == 'tenant'}">
                             <input type="button"  onclick="toSubmit('2','redirect:/basic/xm.do?qm=plistProduct_tenant&view=${view}&conditions=tenant.id:${object.tenant.id}&tenantId=${object.tenant.id}')" class="am-btn am-btn-primary" value="返回商品列表"/>
                         </c:if>

                    </span>
            </div>
        </div>
    </form>
</div>
<!-- content end -->
<hr/>
<script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/>"></script>
<script src="<c:url value="/scripts/upload/jquery.uploadify.js"/>"></script>
<script type="text/javascript" src="<c:url value='/scripts/jquery.zclip.js'/>"></script>
<script>
    function setModelPic(obj,pictureId){

       var modelId = $(obj).val();

            $.ajax({
                type: "get",
                url: '<c:url value="/product/setModelPicture.do"/>',
                cache: false,
                dataType: "json",
                data:{pictureId:pictureId.trim(),modelId:modelId},
                success: function (data) {
//                    $("#picUrl tr[name='" + divId + "']").remove();
//                    $("#collapse-panel-1 li[name='" + divId + "']").remove();
//                    $("#collapse-panel-3 li[name='" + divId + "']").remove();
                }
            });

    }


    function changeUrl(id){
        var url = "http://www2.efeiyi.com/product/productModel/"+id;
        window.open(url);

    }

   //复制图片地址
    function copyInit(obj){

        $(obj).zclip({
            path: "http://www.steamdev.com/zclip/js/ZeroClipboard.swf",
            copy: function(){
                return $(this).attr("url");
            },
            beforeCopy:function(){/* 按住鼠标时的操作 */
                $(this).css("color","orange");
            },
            afterCopy:function(){/* 复制成功后的操作 */
                var $copysuc = $("<div class='copy-tips'><div class='copy-tips-wrap'>☺ 复制成功</div></div>");
                $("body").find(".copy-tips").remove().end().append($copysuc);
                $(".copy-tips").fadeOut(3000);
            }
        });


    }
var modelIds = [];
    var  modelNames = [];
    $(function(){


        CKEDITOR.replace('content', { height: '440px', width: '1000px' });
        $(".copy").each(function(){
            copyInit($(this));
        });


        <c:forEach var="productModel1" items="${object.productModelList}">
         modelIds.push('${productModel1.id}');
        modelNames.push('${productModel1.name}');
        </c:forEach>

        $('#btn_upload').uploadify({
            uploader: '<c:url value="/product/uploadify.do?status=1&productId=${object.id}"/>',            // 服务器处理地址
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
            fileSizeLimit:'20MB',
            removeTimeout:1,                        //移除时间
            fileTypeExts: "*.jpg;*.png;",           //允许的文件类型
            fileTypeDesc: "请选择图片文件",           //文件说明
            formData: { "imgType": "normal" }, //提交给服务器端的参数
            onUploadSuccess: function (file, data, response) {   //一个文件上传成功后的响应事件处理
                data = data.substring(1,data.length-1)
                var pictureId = data.split(":")[0].trim();
                var  imgUrl = data.split(":")[1];
                var  imgName = data.split(":")[2];
                var  url = "http://pro.efeiyi.com/"+imgUrl+"@!product-model";
                var  trueUrl = "http://pro.efeiyi.com/"+imgUrl;
//                ///图片信息
//                var tr = '<tr name = "'+pictureId+'">' +
//                        ' <td>  ' +
//                        '   <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="deletePicture(this,\''+pictureId+'\')"  href="javascript:void(0);">' +
//                        '       <span class="am-icon-trash-o"></span> 删除 ' +
//                        '   </a>' +
//                        ' </td>' +
//                        ' <td>' +url+
//                        ' </td>' +
//                        ' <td>' +
//                        '   <img style="margin-left:2px;" width="18%;" src="'+url+'">' +
//                        ' </td>' +
//                        '</tr>';
                ///显示图片
                var img ='<li style="float: left;margin-right: 10px;width:200px;" name="'+pictureId+'">'+
                        '<dl style="margin-top: 6px;" >'+
                        '  <dt  style="width: 100%">'+
                        '   <img width="100%" name="'+pictureId+ '"  src="'+url+'" alt="商品主图片">'+
                        '  </dt>'+
                        '  <dd style="width: 100%;text-align:center" >'+
                        '<a href="javascript:void(0);" status="1" onclick="updatePictureStatus(this,\''+data+'\',\'2\')">'+'设为主图片'+'</a>'+
                        '   <a href="javascript:void(0);" onclick="deletePicture(this,\''+pictureId+'\')">'+
                        ' 删除'+
                        '</a>'+
                        '</dd>'+
                        '<dd style="width: 100%;text-align: center;" >'+
                        '<select style="width: 85%;" onchange="setModelPic(this,\''+pictureId+'\')">'+
                        '<option value="0">'+'设置商品规格图片'+'</option>';
                for(var n=0;n<modelIds.length;n++) {

                    img +=  '<option value="'+modelIds[n]+ '">'+modelNames[n]+'</option>';

                }
                img += '      </select>'+
                        '</dd>'+
                        '<dd style="width: 100%;text-align: center;" >'+imgName+'.jpg'+
                        '</dd>'+
                        '<dd style="width: 100%;text-align: center;" >'+
                        '  <a href="javascript:void(0);" onclick="copyInit(this);"   class="copy" url="'+trueUrl+'">'+'复制图片地址'+'</a>'+
                        '</dd>'+
                        '</dl>'+
                        '</li>';

                $("#collapse-panel-1 ul").append(img);
//                $("#picUrl").append(tr);

//                $("#collapse-panel-1 ul li[name='"+pictureId+"'] .copy").zclip({
//                    path: "http://www.steamdev.com/zclip/js/ZeroClipboard.swf",
//                    copy: function(){
//                        return $(this).attr("url");
//                    },
//                    beforeCopy:function(){/* 按住鼠标时的操作 */
//                        $(this).css("color","orange");
//                    },
//                    afterCopy:function(){/* 复制成功后的操作 */
//                        var $copysuc = $("<div class='copy-tips'><div class='copy-tips-wrap'>☺ 复制成功</div></div>");
//                        $("body").find(".copy-tips").remove().end().append($copysuc);
//                        $(".copy-tips").fadeOut(3000);
//                    }
//                });

            }
        });
        $('#btn_upload3').uploadify({
            uploader: '<c:url value="/product/uploadify.do?status=3&productId=${object.id}"/>',            // 服务器处理地址
            swf: '<c:url value="/scripts/upload/uploadify.swf"/>',
            buttonText: "上传商品详情图片",                 //按钮文字
            buttonClass:"am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only",         //按钮样式
            buttonCursor:"hand",                    //鼠标指针悬停在按钮上的样子
            height: 34,                             //按钮高度
            width:140,                              //按钮宽度
            auto : true,                          //自动上传
            multi:true,                            //多个文件上传
            scriptDate:{'status':'3'},
            checkExisting:true,                    //检查文件重复
            successTimeout:1000000,                 //超时
            fileSizeLimit:'20MB',
            removeTimeout:1,                        //移除时间
            fileTypeExts: "*.jpg;*.png;*",           //允许的文件类型
            fileTypeDesc: "请选择图片文件",           //文件说明
            formData: { "imgType": "normal" }, //提交给服务器端的参数
            onUploadSuccess: function (file, data, response) {   //一个文件上传成功后的响应事件处理
                data = data.substring(1,data.length-1)
                var pictureId = data.split(":")[0].trim();
                var  imgUrl = data.split(":")[1];
                var  imgName = data.split(":")[2];
                var  url = "http://pro.efeiyi.com/"+imgUrl+"@!product-model";
                var  trueUrl = "http://pro.efeiyi.com/"+imgUrl;
                ///图片信息
//                var tr = '<tr name = "'+pictureId+'">' +
//                        ' <td>  ' +
//                        '   <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="deletePicture(this,\''+pictureId+'\')"  href="javascript:void(0);">' +
//                        '       <span class="am-icon-trash-o"></span> 删除 ' +
//                        '   </a>' +
//                        ' </td>' +
//                        ' <td>' +url+
//                        ' </td>' +
//                        ' <td>' +
//                        '   <img style="margin-left:2px;" width="18%;" src="'+url+'">' +
//                        ' </td>' +
//                        '</tr>';
                ///显示图片
                var img ='<li style="float: left;margin-right: 10px;width:200px;" name="'+pictureId+'">'+
                        '<dl style="margin-top: 6px;" >'+
                        '  <dt  style="width: 100%">'+
                        '   <img width="100%" name="'+pictureId+ '"  src="'+url+'" alt="商品主图片">'+
                        '  </dt>'+
                        '  <dd style="width: 100%;text-align:center" >'+
                        ' <a href="javascript:void(0);" status="9" onclick="updatePictureStatus(this,\''+pictureId+'\',\'9\')">'+'设为推荐图片'+'</a>'+
                        '   <a href="javascript:void(0);" onclick="deletePicture(this,\''+pictureId+'\')">'+
                        ' 删除'+
                        '</a>'+
                        '</dd>'+
                        '<dd style="width: 100%;text-align: center;" >'+imgName+'.jpg'+
                        '</dd>'+
                        '<dd style="width: 100%;text-align: center;" >'+
                        '  <a href="javascript:void(0);" onclick="copyInit(this);" class="copy" url="'+trueUrl+'">'+'复制图片地址'+'</a>'+
                        '</dd>'+
                        '</dl>'+
                        '</li>';

                $("#collapse-panel-3 ul").append(img);
//                $("#picUrl").append(tr);

            }
        });
        $("#btn_upload-button").css({"padding":"0em 0em","text-align":"center"});
        $("#btn_upload3-button").css({"padding":"0em 0em","text-align":"center"});
    });


    //提交
    function toSubmit(result){
        $("input[name='resultPage']").val(result);
        $("form").submit();
    }


    function updatePictureStatus(obj,id,status){
        var productId = $("input[name='product.id']").val();
        $.ajax({
            type: "get",
            url: '<c:url value="/product/updatePicture.do"/>',
            cache: false,
            dataType: "json",
            data:{id:id.trim(),status:status,productId:productId},
            success: function (data) {
                if(status == '2'){
                    if($("a[status='2']").length!=0){
                        $("a[status='2']").text("设为主图片");
                        $("a[status='2']").attr("onclick","updatePictureStatus(this,'"+data+"','2')");
                        $("a[status='2']").attr("status","1");
                    }

                    $(obj).attr("onclick","updatePictureStatus(this,'"+data+"','1')");
                    $(obj).attr("status","2");
                    $(obj).text("主图片");
//                    var  a = '<a href="#"  onclick="updatePictureStatus(\''+data+'\',\'1\')">'+'主图片'+'</a>'+
//                                    '   <a href="#" onclick="deletePicture(this,\''+data+'\')">'+
//                                    ' 删除'+
//                                    '</a>'
//                            ;
//                    $("#collapse-panel-1 li[name='" + data + "'] dd").html(a);
                }
                if(status == '1'){
                    $(obj).attr("onclick","updatePictureStatus(this,'"+data+"','2')");
                    $(obj).attr("status","1");
                    $(obj).text("设为主图片");
//                    var  a = '<a href="#"  onclick="updatePictureStatus(\''+data+'\',\'2\')">'+'设为主图片'+'</a>'+
//                            '   <a href="#" onclick="deletePicture(this,\''+data+'\')">'+
//                            ' 删除'+
//                            '</a>';
//                    $("#collapse-panel-1 li[name='" + data + "'] dd").html(a);
                }
                if(status == '9'){
                    $(obj).attr("onclick","updatePictureStatus(this,'"+data+"','3')");
                    $(obj).attr("status","3");
                    $(obj).text("推荐图片");
                }
                if(status == '3'){
                    $(obj).attr("onclick","updatePictureStatus(this,'"+data+"','9')");
                    $(obj).attr("status","9");
                    $(obj).text("设为推荐图片");
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
                $("#collapse-panel-3 li[name='" + divId + "']").remove();
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
