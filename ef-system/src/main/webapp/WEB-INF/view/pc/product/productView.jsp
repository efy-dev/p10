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
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title></title>
    <link href="<c:url value="/scripts/upload/uploadify.css"/>" rel="stylesheet"/>

    <style type="text/css">
        .line {
            margin-bottom: 20px;
        }

        /* 复制提示 */
        .copy-tips {
            position: fixed;
            z-index: 999;
            bottom: 50%;
            left: 50%;
            margin: 0 0 -20px -80px;
            background-color: rgba(0, 0, 0, 0.2);
            filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr=#30000000, endColorstr=#30000000);
            padding: 6px;
        }

        .copy-tips-wrap {
            padding: 10px 20px;
            text-align: center;
            border: 1px solid #F4D9A6;
            background-color: #FFFDEE;
            font-size: 14px;
        }
    </style>
</head>
<body>

<style>
    .am-modal-dialog {
        background: transparent
    }

    .am-modal-dialog img {
        width: 100%
    }
</style>
<div class="am-modal am-modal-no-btn" tabindex="-1" id="your-modal" style="background: #f00;">
    <div class="am-modal-dialog"
         style="width:800px;height:800px;position: absolute;top:50%;left: 50%;margin-top: -400px;margin-left: -400px">
        <div class="am-modal-bd">
            <img src="" title="原图">
        </div>
    </div>
</div>

<div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">商品详情</strong> /
        <small>Product Details</small>
    </div>
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


    <form action="<c:url value="/product/saveNewProduct.do"/>" method="post" class="am-form am-form-horizontal" enctype="multipart/form-data"
          id="form">
        <fieldset>
            <legend>
                <c:if test="${view == 'newProduct'}">
                    <a style="width: 10%;" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                       onclick="toSubmit('2','redirect:/basic/xm.do?qm=plistProduct_default&view=${view}')"
                       href="javascript:void (0);">
                        返回列表
                    </a>
                </c:if>
                <c:if test="${view == 'tenant'}">
                    <a style="width: 10%;" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                       onclick="toSubmit('2','redirect:/basic/xm.do?qm=plistTENANTProduct_default&view=${view}&conditions=tenant.id:${object.tenant.id}&tenantId=${object.tenant.id}')"
                       href="javascript:void (0);">
                        返回列表
                    </a>
                    <%--<input type="button"  onclick="toSubmit('2','redirect:/basic/xm.do?qm=plistProduct_tenant&view=${view}&conditions=tenant.id:${object.tenant.id}&tenantId=${object.tenant.id}')" class="am-btn am-btn-primary" value="返回商品列表"/>--%>
                </c:if>
                <%--<a style="width: 10%;" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="toSubmit('2','redirect:/basic/xm.do?qm=plistProduct_defalut&view=${view}')"  href="javascript:void (0);">--%>
                <%--返回列表--%>
                <%--</a>--%>
            </legend>
<security:authorize ifAnyGranted="admin,operational,c_operational">
            <a style="width: 10%;" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
               href="<c:url value="/basic/xm.do?qm=formProduct&view=${view}&id=${object.id}&tenantId=${tenantId}&masterId=${masterId}"/>">
                修改基本信息
            </a>
</security:authorize>
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
            <div class="am-form-group">
                <label name="name" class="am-u-sm-3 am-form-label">商品副名称</label>

                <div class="am-u-sm-9" style="margin-top: 10px;">
                    ${object.subName}
                    <!--<small>必填项*</small>-->
                </div>
            </div>


            <div class="am-form-group">
                <label name="serial" class="am-u-sm-3 am-form-label">商品类型</label>

                <div class="am-u-sm-9" style="margin-top: 10px;">
                    <c:if test="${object.type=='1'}">
                        普通
                    </c:if>
                    <c:if test="${object.type=='2'}">
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

        </legend>
<security:authorize ifAnyGranted="admin,operational,c_operational">
        <a style="width: 10%;" href="javascript:void(0);"
           class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
           onclick="toSubmit('1','redirect:/basic/xm.do?qm=viewProduct&view=${view}&id=${object.id}')">
            保存商品描述
        </a>
</security:authorize>
        <div class="am-form-group">
            <form action="<c:url value="/product/saveNewProduct.do"/>" method="post" class="am-form am-form-horizontal" enctype="multipart/form-data"
                  id="form1">
                <input type="hidden" name="id" value="${object.productDescription.id}">
                <input type="hidden" name="product.id" value="${object.id}">
                <input type="hidden" name="resultPage" value="0"/>
                <input type="hidden" name="view" value="${view}">
                <input type="hidden" name="step" value="description">
                <label class="am-u-sm-3 am-form-label">商品描述</label>

                <div class="am-u-sm-9" style="margin-top: 10px;">
                            <textarea  name="content" class="ckeditor" id="content"
                                      placeholder="商品描述" required>
                                ${object.productDescription.content}

                            </textarea>
                </div>
            </form>
            <br>
        </div>

    </fieldset>
    <fieldset>
        <legend>

        </legend>
<security:authorize ifAnyGranted="admin,operational,c_operational">
        <a style="width: 10%;" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
           href="<c:url value="/basic/xm.do?qm=formProduct_ProductModel&view=${view}&id=${object.id}"/>">
            修改规格
        </a>
</security:authorize>
        <div class="am-u-md-9" style="margin-left: 19%;">
            <div class="am-panel am-panel-default">
                <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-2'}">商品规格<span
                        class="am-icon-chevron-down am-fr"></span></div>
                <div id="collapse-panel-2" class="am-in">
                    <table class="am-table am-table-bd am-table-bdrs am-table-striped am-table-hover"
                           id="productModel">
                        <tbody>
                        <tr>
                            <th class="am-text-center" width="10%">预览</th>
                            <th class="am-text-center" width="16%">规格编号</th>
                            <th class="am-text-center" width="16%">规格名称</th>
                            <th class="am-text-center" width="15%">属性</th>
                            <th class="am-text-center" width="11%">库存</th>
                            <th class="am-text-center" width="11%">价格(元)</th>
                            <th class="am-text-center" width="11%">市场价格(元)</th>
                            <th class="am-text-center" width="10%">重量(kg)</th>
                        </tr>
                        <c:forEach var="model" items="${object.productModelList}">
                            <tr>
                                <td align="center">
                                    <a style="width: 10%;"
                                       class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                       href="javascript:void(0);" onclick="changeUrl('${model.id}')">
                                        生成预览
                                    </a>
                                </td>
                                <td class="am-text-center">
                                        ${model.serial}
                                </td>
                                <td class="am-text-center">
                                        ${model.name}
                                </td>
                                <td class="am-text-center">
                                    <c:if test="${model.status == '1'}">
                                        <c:forEach var="modelProperty" items="${model.productPropertyValueList}">
                                            <span style="padding: 5px;" id="${modelProperty.projectPropertyValue.id}"
                                                  value="${modelProperty.projectPropertyValue.value}">
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
                                <td align="center">
                                        ${model.weight}
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


        </legend>
<security:authorize ifAnyGranted="admin,operational,c_operational">
        <a id="btn_upload"></a>
</security:authorize>
        <div class="am-u-md-13">
            <div class="am-panel am-panel-default">
                <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-1'}">
                    <strong> 商品图片</strong>
                    <span class="am-icon-chevron-down am-fr"></span></div>
                <div class="am-panel-bd am-collapse am-in" id="collapse-panel-1" style="height: auto;overflow: hidden">
                    <%--<a style="margin-bottom: 2px;color: red;" id="btn_upload2"></a>--%>
                    <ul style="width: 100%" style="list-style:none">
                        <c:if test="${!empty object.productPictureList}">
                            <c:forEach var="productPicture" items="${object.productPictureList}">
                                <c:if test="${productPicture.status != '3' && productPicture.status != '9'}">
                                    <li style="float: left;margin-right: 10px;width: 200px;" sort="${productPicture.sort}"
                                        name="${productPicture.id}">
                                        <dl style="margin-top: 6px;">
                                            <dt style="width: 100%">
                                                <a title="点击查看原图" href="javascript:void (0);"
                                                   onclick="tc('http://pro.efeiyi.com/${productPicture.pictureUrl}')">
                                                    <img width="100%" name=""
                                                         src="http://pro.efeiyi.com/${productPicture.pictureUrl}@!product-model"
                                                         alt="商品图片"/>
                                                </a>
                                            </dt>
                                            <security:authorize ifAnyGranted="admin,operational,c_operational">
                                            <dd style="width: 100%;text-align: center;">
                                                <c:choose>
                                                    <c:when test="${productPicture.status == '2'}">
                                                        <a href="javascript:void(0);"
                                                           modelId="${productPicture.productModel.id}" status="2"
                                                           onclick="updatePictureStatus(this,'${productPicture.id}')">主图片</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:if test="${empty productPicture.productModel}">
                                                            <a href="javascript:void(0);" status="1" modelId="0"
                                                               onclick="updatePictureStatus(this,'${productPicture.id}')">设为主图片</a>
                                                        </c:if>
                                                        <c:if test="${not empty productPicture.productModel}">
                                                            <a href="javascript:void(0);" status="1"
                                                               modelId="${productPicture.productModel.id}"
                                                               onclick="updatePictureStatus(this,'${productPicture.id}')">设为主图片</a>
                                                        </c:if>

                                                    </c:otherwise>
                                                </c:choose>
                                                <a href="javascript:void(0);"
                                                   onclick="deletePicture(this,'${productPicture.id}')">删除</a>
                                            </dd>

                                            <dd style="width: 100%;text-align: center;">

                                                <select style="width: 85%;" onclick="temVal(this)"
                                                        onchange="setModelPic(this,'${productPicture.id}')">
                                                    <option value="0">设置商品规格图片</option>
                                                    <c:forEach var="productModel1" items="${object.productModelList}">

                                                        <option value="${productModel1.id}"
                                                                <c:if test="${productModel1.id==productPicture.productModel.id}">selected="selected"</c:if>>${productModel1.name}</option>

                                                    </c:forEach>
                                                </select>

                                            </dd>
                                            </security:authorize>
                                            <dd style="width: 100%;text-align: center;">
                                                    ${fn:substring(productPicture.pictureUrl, fn:indexOf(productPicture.pictureUrl,"/" )+1, fn:length(productPicture.pictureUrl)-18)}${fn:substring(productPicture.pictureUrl,fn:indexOf(productPicture.pictureUrl,"." ) ,fn:length(productPicture.pictureUrl)+1 )}
                                            </dd>
                                            <dd style="width: 100%;text-align: center;">
                                                <a href="javascript:void(0);" class="copy"
                                                   url="http://pro.efeiyi.com/${productPicture.pictureUrl}@!water-mask">复制图片地址</a>
                                            </dd>
                                            <dd style="width: 100%;text-align: center;">
                                                <a href="javascript:void(0);" onclick="leftImg(this);">左移</a>
                                                <a href="javascript:void(0);" onclick="rightImg(this);">右移</a>
                                                <%--<c:if test="${empty productPicture.sort}">--%>
                                                    <%--<a href="javascript:void (0)" onclick="toUpdatePictureSort(this,'<c:url value="/product/updatePictureSort.do"/>')" sort="0" id="${productPicture.id}">--%>
                                                           <%--初始化排序--%>
                                                    <%--</a>--%>
                                                <%--</c:if>--%>
                                <%--<c:if test="${not empty productPicture.sort}">--%>
                                                <%--<a href="javascript:void (0)" onclick="toUpdatePictureSort(this,'<c:url value="/product/updatePictureSort.do"/>')" sort="${productPicture.sort}" id="${productPicture.id}">--%>
                                                        <%--${productPicture.sort}--%>
                                                <%--</a>--%>
                                <%--</c:if>--%>
                                            </dd>
                                            <%--<dd style="width: 100%;text-align: center;">--%>
                                                    <%--<a href="javascript:void(0);"   onclick="changeImg('${productPicture.pictureUrl}');">替换图片</a>--%>
                                            <%--</dd>--%>
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


        </legend>
<security:authorize ifAnyGranted="admin,operational,c_operational">
          <span style="margin-left: 90%;">
                          <a style="width: 10%;"
                             class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                             href="javascript:void(0);" onclick="toDiscription(this)">
                              添加至描述
                          </a>
                    </span>
        <a id="btn_upload3"></a>
</security:authorize>
        <div class="am-u-md-13">
            <div class="am-panel am-panel-default">
                <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-3'}">

                    <strong> 商品详情图片</strong>

                    <span class="am-icon-chevron-down am-fr"></span>

                </div>

                <div class="am-panel-bd am-collapse am-in" id="collapse-panel-3" style="height: auto;overflow: hidden; ">

                    <ul style="width: 100%;list-style:none;margin-left: 20%" >
                        <c:if test="${!empty object.productPictureList}">
                            <c:forEach var="productPicture" items="${object.productPictureList}">
                                <c:if test="${productPicture.status == '3' || productPicture.status == '9'}">
                                    <li style=""
                                        name="${productPicture.id}" sort="${productPicture.sort}">
                                        <dl style="margin-top: 6px;position:relative">
                                            <dt style="width: 35%">
                                                <a title="点击查看原图" href="javascript:void (0);"
                                                   onclick="tc('http://pro.efeiyi.com/${productPicture.pictureUrl}')">
                                                    <img width="100%" name=""
                                                         src="http://pro.efeiyi.com/${productPicture.pictureUrl}@!water-mask"
                                                         alt="商品图片" />
                                                </a>
                                            </dt>
                                            <dd style="position: absolute;width: 100%;right: 0;top: 25%;">
                                                <security:authorize ifAnyGranted="admin,operational,c_operational">
                                            <div style="width: 100%;text-align: center;">
                                                <c:choose>
                                                    <c:when test="${productPicture.status == '9'}">
                                                        <a href="javascript:void(0);" status="3"
                                                           onclick="updatePictureStatus(this,'${productPicture.id}')">推荐图片</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="javascript:void(0);" status="9"
                                                           onclick="updatePictureStatus(this,'${productPicture.id}')">设为推荐图片</a>
                                                    </c:otherwise>
                                                </c:choose>
                                                <a href="javascript:void(0);"
                                                   onclick="deletePicture(this,'${productPicture.id}')">删除</a>
                                            </div>
                                                </security:authorize>
                                            <div style="width: 100%;text-align: center;">
                                                    ${fn:substring(productPicture.pictureUrl, fn:indexOf(productPicture.pictureUrl,"/" )+1, fn:length(productPicture.pictureUrl)-18)}${fn:substring(productPicture.pictureUrl,fn:indexOf(productPicture.pictureUrl,"." ) ,fn:length(productPicture.pictureUrl)+1 )}
                                            </div>
                                                <security:authorize ifAnyGranted="admin,operational,c_operational">
                                            <div style="width: 100%;text-align: center;">
                                                <a href="javascript:void(0);" class="copy"
                                                   url="http://pro.efeiyi.com/${productPicture.pictureUrl}@!water-mask">复制图片地址</a>
                                            </div>
                                            <div style="width: 100%;text-align: center;" sort="">
                                                <a href="javascript:void(0);" onclick="upImg(this);">上移</a>
                                                <a href="javascript:void(0);" onclick="downImg(this);">下移</a>
                                            </div>
                                                </security:authorize>
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


    <form action="<c:url value="/product/saveNewProduct.do"/>" method="post" class="am-form am-form-horizontal" enctype="multipart/form-data"
          id="form2">
        <input type="hidden" name="resultPage" value="0"/>
        <input type="hidden" name="step" value="view">

        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">

                    <span style="padding: 10px;">
                        <c:if test="${view == 'newProduct'}">
                            <input type="button"
                                   onclick="toSubmit('2','redirect:/basic/xm.do?qm=plistProduct_default&view=${view}')"
                                   class="am-btn am-btn-primary" value="返回商品列表"/>
                        </c:if>
                         <c:if test="${view == 'tenant'}">
                             <input type="button"
                                    onclick="toSubmit('2','redirect:/basic/xm.do?qm=plistTENANTProduct_default&view=${view}&conditions=tenant.id:${object.tenant.id}&tenantId=${object.tenant.id}')"
                                    class="am-btn am-btn-primary" value="返回商品列表"/>
                         </c:if>

                    </span>
            </div>
        </div>
    </form>
</div>
<!-- content end -->
<hr/>
<script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/>"></script>
<%--<script src="<c:url value='/scripts/new_ckeditor/ckeditor.js'/>"></script>--%>
<script src="<c:url value="/scripts/upload/jquery.uploadify.js"/>"></script>
<script type="text/javascript" src="<c:url value='/scripts/zclip/jquery.zclip.js'/>"></script>

<script>
    var selectVal;
    function temVal(obj) {
        selectVal = $(obj).val();
    }

    var options = {

        height: "0"
    };


    function tc(url) {
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

    function setModelPic(obj, pictureId) {
        var modelId = $(obj).val();
        $(obj).parent().prev().find("a").attr("modelId", modelId);
        var a = $(obj).parent().prev().find("a:eq(0)");

//        if ($(obj).parent().prev().find("a").attr("status") == "2") {
//            alert("请先取消主图片!");
//            $("option[value='" + selectVal + "']", obj).attr("selected", "selected");
//        } else {
            $.ajax({
                type: "get",
                url: '<c:url value="/product/setModelPicture.do"/>',
                cache: false,
                dataType: "json",
                data: {pictureId: pictureId.trim(), modelId: modelId,oldModelId:selectVal},
                success: function (data) {
                    $(obj).parent().prev().find("a").attr("modelId", data);
                    $(a).attr("status", "1");
                    $(a).text("设为主图片");
                }
            });
//        }


    }


    function changeUrl(id) {
        var url = "http://www.efeiyi.com/product/productModel/" + id;
        window.open(url);

    }

    //复制图片地址
    function copyInit(obj) {

        $(obj).zclip({
            path: "<c:url value="/scripts/zclip/ZeroClipboard.swf" />",
            copy: function () {
                return $(this).attr("url");
            },
            beforeCopy: function () {/* 按住鼠标时的操作 */
                $(this).css("color", "orange");
            },
            afterCopy: function () {/* 复制成功后的操作 */
                var $copysuc = $("<div class='copy-tips'><div class='copy-tips-wrap'>☺ 复制成功</div></div>");
                $("body").find(".copy-tips").remove().end().append($copysuc);
                $(".copy-tips").fadeOut(3000);
            }
        });


    }
    var modelIds = [];
    var modelNames = [];
    var myeditor=CKEDITOR.replace('content', {height: '440px', width: '1000px'});
    $(function () {

        $(".copy").each(function () {
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
                var updatePictrueUrl = '<c:url value="/product/updatePictureSort.do"/>';
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
                var img = '<li style="float: left;margin-right: 10px;width:200px;" sort="'+sort+'" name="' + pictureId + '">' +
                        '<dl style="margin-top: 6px;" >' +
                        '  <dt  style="width: 100%">' +
                        '    <a title="点击查看原图" href="javascript:void (0);" onclick="tc(\'' + trueUrl + '\')">' +
                        '      <img width="100%" name="' + pictureId + '"  src="' + url + '" alt="商品主图片">' +
                        '   </a>' +
                        '  </dt>' +
                        '  <dd style="width: 100%;text-align:center" >' +
                        '<a href="javascript:void(0);" status="1"  modelId="0" onclick="updatePictureStatus(this,\'' + pictureId + '\')">' + '设为主图片' + '</a>' +
                        '   <a href="javascript:void(0);" onclick="deletePicture(this,\'' + pictureId + '\')">' +
                        ' 删除' +
                        '</a>' +
                        '</dd>' +
                        '<dd style="width: 100%;text-align: center;" >' +
                        '<select style="width: 85%;" onclick="temVal(this)" onchange="setModelPic(this,\'' + pictureId + '\')">' +
                        '<option value="0">' + '设置商品规格图片' + '</option>';
                for (var n = 0; n < modelIds.length; n++) {

                    img += '<option value="' + modelIds[n] + '">' + modelNames[n] + '</option>';

                }
                img += '      </select>' +
                        '</dd>' +
                        '<dd style="width: 100%;text-align: center;" >' + imgName +
                        '</dd>' +
                        '<dd style="width: 100%;text-align: center;" >' +
                        '  <a href="javascript:void(0);" onclick="copyInit(this);"   class="copy" url="' + trueUrl + '">' + '复制图片地址' + '</a>' +
                        '</dd>' +
                        '<dd style="width: 100%;text-align: center;" sort="" >' +
                        '<a href="javascript:void(0);" onclick="leftImg(this);">'+
                        '左移'+
                        '</a>'+
                        '<a href="javascript:void(0);" onclick="rightImg(this);">'+
                        '右移'+'</a>'+
//                        '   <a href="javascript:void (0)" onclick="toUpdatePictureSort(this,\''+updatePictrueUrl+'\')" sort="0" id="' + pictureId + '">初始化排序'+
//                        '</a>' +
                        '</dd>' +
//                        '<dd style="width: 100%;text-align: center;" >' +
//                        '   <a href="javascript:void(0);"   onclick="changeImg(\'' + imgUrl + '\');">' + '替换图片' + '</a>' +
//                        '</dd>' +
                        '</dl>' +
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
                data = data.substring(1, data.length - 1);
                var pictureId = data.split(":")[0].trim();
                var imgUrl = data.split(":")[1];
                var imgName = data.split(":")[2];
                var sort = data.split(":")[3];
                var url = "http://pro.efeiyi.com/" + imgUrl + "@!product-model";
                var trueUrl = "http://pro.efeiyi.com/" + imgUrl + "@!water-mask";
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
                var img = '<li style="" sort="'+sort+'" name="' + pictureId + '">' +
                        '<dl style="margin-top: 6px;position:relative" >' +
                        '  <dt  style="width: 35%">' +
                        '    <a title="点击查看原图" href="javascript:void (0);" onclick="tc(\'' + trueUrl + '\')">' +
                        '      <img width="100%" name="' + pictureId + '"  src="' + trueUrl + '" alt="商品主图片">' +
                        '   </a>' +
                        '  </dt>' +
                        '<dd style="position: absolute;width: 100%;right: 0;top: 25%;">'+
                        '  <div style="width: 100%;text-align:center" >' +
                        ' <a href="javascript:void(0);" status="9" onclick="updatePictureStatus(this,\'' + pictureId + '\')">' + '设为推荐图片' + '</a>' +
                        '   <a href="javascript:void(0);" onclick="deletePicture(this,\'' + pictureId + '\')">' +
                        ' 删除' +
                        '</a>' +
                        '</div>' +
                        '<div style="width: 100%;text-align: center;" >' + imgName +
                        '</div>' +
                        '<div style="width: 100%;text-align: center;" >' +
                        '  <a href="javascript:void(0);" onclick="copyInit(this);" class="copy" url="' + trueUrl + '">' + '复制图片地址' + '</a>' +
                        '</div>' +
                        '<div style="width: 100%;text-align: center;" sort="">'+
                        '<a href="javascript:void(0);" onclick="upImg(this);">'+
                        '上移'+
                        '</a>'+
                        '<a href="javascript:void(0);" onclick="downImg(this);">'+
                        '下移'+'</a>'+
                        '</div>'+
                        '</dd>'+
//                        '<dd style="width: 100%;text-align: center;" >' +
//                        '   <a href="javascript:void(0);"   onclick="changeImg(\'' + imgUrl + '\');">' + '替换图片' + '</a>' +
//                        '</dd>' +
                        '</dl>' +
                        '</li>';

                $("#collapse-panel-3 ul").append(img);
//                $("#picUrl").append(tr);

            }
        });

        $("#btn_upload-button").css({"padding": "0em 0em", "text-align": "center"});
        $("#btn_upload3-button").css({"padding": "0em 0em", "text-align": "center"});
    });


//    //提交
//    function toSubmit(result) {
//        $("input[name='resultPage']").val(result);
//        $("form").submit();
//    }


    function updatePictureStatus(obj, id) {
        var status = $(obj).attr("status");
        var modelId = $(obj).parent().next().find("select").val();
        if (modelId == "0") {
            alert("请选择规格!");
        } else {
            var productId = $("input[name='product.id']").val();
            $.ajax({
                type: "get",
                url: '<c:url value="/product/updatePicture.do"/>',
                cache: false,
                dataType: "json",
                data: {id: id.trim(), status: status, productId: productId, modelId: modelId},
                success: function (data) {
                    if (status == '1') {
                        if ($("a[status='2'][modelId='" + data + "']").length != 0) {
                            $("a[status='2'][modelId='" + data + "']").text("设为主图片");
//                            $("a[status='2'][modelId='" + data + "']").attr("onclick", "updatePictureStatus(this,'" + id + "')");
                            $("a[status='2'][modelId='" + data + "']").attr("status", "1");
                        }

                        $(obj).attr("onclick", "updatePictureStatus(this,'" + id + "')");
                        $(obj).attr("status", "2");
                        $(obj).text("主图片");
//                    var  a = '<a href="#"  onclick="updatePictureStatus(\''+data+'\',\'1\')">'+'主图片'+'</a>'+
//                                    '   <a href="#" onclick="deletePicture(this,\''+data+'\')">'+
//                                    ' 删除'+
//                                    '</a>'
//                            ;
//                    $("#collapse-panel-1 li[name='" + data + "'] dd").html(a);
                    }
                    if (status == '2') {
                        $(obj).attr("onclick", "updatePictureStatus(this,'" + id + "')");
                        $(obj).attr("status", "1");
                        $(obj).text("设为主图片");
//                    var  a = '<a href="#"  onclick="updatePictureStatus(\''+data+'\',\'2\')">'+'设为主图片'+'</a>'+
//                            '   <a href="#" onclick="deletePicture(this,\''+data+'\')">'+
//                            ' 删除'+
//                            '</a>';
//                    $("#collapse-panel-1 li[name='" + data + "'] dd").html(a);
                    }
                    if (status == '9') {
                        $(obj).attr("onclick", "updatePictureStatus(this,'" + id + "','3')");
                        $(obj).attr("status", "3");
                        $(obj).text("推荐图片");
                    }
                    if (status == '3') {
                        $(obj).attr("onclick", "updatePictureStatus(this,'" + id + "','9')");
                        $(obj).attr("status", "9");
                        $(obj).text("设为推荐图片");
                    }

                }
            });
        }

    }


    function deletePicture(obj, divId) {
        var status = $(obj).prev().attr("status");
        if (status == "2") {
            alert("请先取消主图片!");
        } else {
            $.ajax({
                type: "get",
                url: '<c:url value="/product/deletePicture.do"/>',
                cache: false,
                dataType: "json",
                data: {id: divId.trim()},
                success: function (data) {
                    $("#picUrl tr[name='" + divId + "']").remove();
                    $("#collapse-panel-1 li[name='" + divId + "']").remove();
                    $("#collapse-panel-3 li[name='" + divId + "']").remove();
                }
            });
        }
    }

    function toSubmit(st, result) {
        $("input[name='resultPage']").val(result);

        $("#form" + st).submit();


    }

    /**
    * 上下移
     */
    function upImg(obj){
       var li = $(obj).parents("li");
        var sourceId = $(li).attr("name");
        var sourceSort = $(li).attr("sort");
        var getup = $(li).prev();
        var targetId = $(getup).attr("name");
        var targetSort = $(getup).attr("sort");

            if (getup.length == 0) {
                alert("已经是第一个了!");
            } else   if(sourceSort == ""|| targetSort == ""){
                $(getup).before(li);
            }else {
                $.ajax({
                    type: "get",
                    url: '<c:url value="/product/changePictureSort.do"/>',
                    cache: false,
                    dataType: "json",
                    data: {sourceId: sourceId, sourceSort: sourceSort, targetId: targetId, targetSort: targetSort},
                    success: function (data) {
                        $(getup).before(li);
                        $(li).attr("sort", targetSort);
                        $(getup).attr("sort", sourceSort);
                    }
                });

            }

    }
    function downImg(obj){
        var li = $(obj).parents("li");
        var sourceId = $(li).attr("name");
        var sourceSort = $(li).attr("sort");
        var getdown = $(li).next();
        var targetId = $(getdown).attr("name");
        var targetSort = $(getdown).attr("sort");

            if (getdown.length == 0) {
                alert("已经是最后一个了!");
            } else  if(sourceSort==""||targetSort==""){
                $(getdown).after(li);
            }else {
                $.ajax({
                    type: "get",
                    url: '<c:url value="/product/changePictureSort.do"/>',
                    cache: false,
                    dataType: "json",
                    data: {sourceId: sourceId, sourceSort: sourceSort, targetId: targetId, targetSort: targetSort},
                    success: function (data) {
                        $(getdown).after(li);
                        $(li).attr("sort", targetSort);
                        $(getdown).attr("sort", sourceSort)
                    }
                });


            }

    }
    function leftImg(obj){
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
                url: '<c:url value="/product/changePictureSort.do"/>',
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
    function rightImg(obj){
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
                url: '<c:url value="/product/changePictureSort.do"/>',
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
    function toDiscription(obj){
        var p = '';
        if($("#collapse-panel-3 li").length==0){
            alert("没有要赋值的内容!");
        }else {
            $("#collapse-panel-3 li").each(function () {
                var img = $(this).find("img").attr("src");
                p += '<img alt="" src="' + img + '"/>';

            });
            myeditor.setData(p);
            alert("添加成功!");
        }

    }

    function toUpdatePictureSort(obj,updateUrl){
        var sort = $(obj).attr("sort");
        var id = $(obj).attr("id");
        if(sort == "0"){
            sort="";
        }
        $(obj).parent().html("<input id="+id+" onblur=\"updatePictureSort(this,'"+updateUrl+"')\" type=\"text\" name=\"sort\" style=\"width: 35px;\" required value="+sort+"  >");
    }
    function updatePictureSort(obj,updateUrl){
        var sort = $(obj).val();

        var id = $(obj).attr("id");
        $.ajax({
            type: "get",
            url: updateUrl,
            cache: false,
            dataType: "json",
            data:{id:id,sort:sort},
            success: function (data) {
                $(obj).parent().html("<a onclick=\"toUpdatePictureSort(this,'"+updateUrl+"')\" sort="+data+" id="+id+">"+data+"</a>");
            }
        });
    }
</script>

</body>
</html>
