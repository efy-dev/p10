<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/4/18 0018
  Time: 18:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>

    <link rel="stylesheet" type="text/css"
          href="<c:url value="/scripts/simditor/font-awesome-4.5.0/css/font-awesome.css"/>">

    <%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>

    <script src="<c:url value="/scripts/jquery.form.js"/>"></script>

</head>
<body>

<div class="am-g">
    <div class="am-u-md-12">

        <h2>礼品详情</h2>
        <table class="am-table am-table-bordered">
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">礼品名称</td>
                <td class="am-u-md-3">${object.name}</td>
                <td class="am-primary am-u-md-3" style="padding: 0rem">商品名称</td>
                <td class="am-u-md-3" style="padding: 0rem">${object.productModel.name}</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">工艺名称</td>
                <td class="am-u-md-3">${object.project.name}</td>
                <td class="am-primary am-u-md-3" style="padding: 0rem">工艺类别</td>
                <td class="am-u-md-3" style="padding: 0rem">${object.project.projectCategory.name}</td>
            </tr>

            <tr>
                <td class="am-primary am-u-md-3">商品价格</td>
                <td class="am-u-md-3">${object.productModel.price}</td>
                <td class="am-primary am-u-md-3" style="padding: 0rem">商品状态</td>
                <td class="am-u-md-3" style="padding: 0rem">
                    <ming800:status name="status" dataType="Product.status" checkedValue="${object.productModel.status}"
                                    type="normal"/>
                </td>
            </tr>

            </tbody>
        </table>

        <h2>礼品图片详情</h2>
        <div class="am-form-group">
            <div class="am-u-sm-12" style="margin-top: 10px;float:left;">

                <img style="width: 30%;height: 30%" src="http://pro.efeiyi.com/${object.productModel.productModel_url}">
            </div>
        </div>

        <form id="guanlian" action="<c:url value="/basic/xmj.do"/>" class="am-form am-form-horizontal" method="post">
            <input type="hidden" value="saveOrUpdateGiftTag" name="qm">

            <input type="hidden" name="productGift.id" value="${object.id}">

            <div class="am-form-group" style="margin-top: 20px">
                <label name="name" class="am-u-sm-12 am-form-label"
                       style="text-align: left;padding-left: 0;margin: 10px 0">标签匹配</label>

                <div class="am-u-sm-8 am-u-end">
                    <input type="hidden" name="productGiftTagValue.id" id="productGiftTagValueId" placeholder=""
                           value="">
                    <input type="text" name="productGiftTagValue.name" id="productGiftTagValueName" placeholder=""
                           data-am-modal="{target: '#my-popup'}" value="" required>
                </div>
            </div>

            <div class="am-form-group">
                <div class="am-u-sm-9 am-u-end">
                    <a onclick="guanlian()" href="#" class="am-btn am-btn-primary" value="保存">保存</a>
                </div>
            </div>
        </form>


        <div class="am-u-md-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
                    <th class="table-set">操作</th>
                    <th class="table-title">标签类型</th>
                    <th class="table-title">标签名称</th>
                </tr>
                </thead>
                <tbody>

                <c:forEach items="${productGiftTagList}" var="productGiftTag">
                    <tr id="${productGiftTag.id}">
                        <td width="10%">
                            <div class="am-btn-toolbar">
                                <div class="am-btn-gro up am-btn-group-xs">
                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                       onclick="showConfirm('提示','是否取消关联',function(){removeProductGiftTag('${productGiftTag.id}')})"
                                       href="#"><span
                                            class="am-icon-trash-o"></span> 取消关联
                                    </a>
                                </div>
                            </div>
                        </td>
                        <td class="am-hide-sm-only" width="10%">
                            <a href="#">
                                    ${productGiftTag.productGiftTagValue.type}
                            </a>
                        </td>
                        <td class="am-hide-sm-only" width="10%">
                            <a href="#">
                                    ${productGiftTag.productGiftTagValue.value}
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>


    </div>
</div>
<div class="am-popup" id="my-popup">
    <div class="am-popup-inner">
        <div class="am-popup-hd">
            <h4 class="am-popup-title">类别选择</h4>
      <span data-am-modal-close
            class="am-close">&times;</span>
        </div>
        <div class="am-popup-bd">
            <input type="text" name="sel" style="float: left" placeholder="编号或名称" value=""/>
            <a style="width: 10%;float: left;margin-left: 10px;"
               class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
               href="javascript:void(0);" onclick="selObj(this,'my-popup')">查找
            </a>
            <table class="am-table am-table-bd am-table-bdrs am-table-striped am-table-hover"
                   id="category">
                <tbody>
                <tr>
                    <th class="am-text-center" width="14%">操作</th>
                    <th class="am-text-center" width="17%">标签类型</th>
                    <th class="am-text-center" width="17%">标签值</th>
                </tr>
                <c:forEach var="label" items="${tagList}">
                    <tr name="${label.type}" serial="${label.value}">
                        <td align="center" width="33%">
                            <a style="width: 10%;"
                               class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                               href="javascript:void(0);"
                               onclick="selectObj('${label.id}','${label.value}','my-popup','productGiftTagValue')">
                                选择
                            </a>
                        </td>
                        <td class="am-text-center" width="33%">
                            <ming800:status name="type" dataType="ProductGiftTagValue.type" checkedValue="${label.type}"
                                            type="normal"/>
                        </td>
                        <td class="am-text-center" width="33%">
                                ${label.value}
                        </td>

                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script>

//    $().ready(function () {
//        var options = {
//            success: function (data) {
//                window.location.href = window.location.href;
//            }
//        };
//        $("#guanlian").ajaxForm(options);
//    })

    function guanlian() {
        var options = {
            url: '<c:url value="/basic/xmj.do"/>',
            type: 'post',
            dataType: 'text',
            data: $("#guanlian").serialize(),
            success: function (data) {
                location.reload();
            }
        };
        $.ajax(options);
    }

    function selObj(obj, popup) {

        var v = $("#" + popup + " input[name='sel']").val();
        if (v == "") {
            $("#" + popup + " table tr:gt(0)").each(function () {

                $(this).show();

            });
        } else {
            $("#" + popup + " table tr:gt(0)").each(function () {
                if ($(this).attr("name").indexOf(v) != -1 || $(this).attr("serial").indexOf(v) != -1) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        }
    }
    function selectObj(id, name, popup, select) {
        $("#" + select + "Id").val(id);
        $("#" + select + "Name").val(name);
        $("#" + popup).modal('close');
    }

    function removeProductGiftTag(divId) {
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeProductGiftTag"/>',
            cache: false,
            dataType: "json",
            data: {id: divId},
            success: function (data) {
                $("#" + divId).remove();
            }
        });
    }

</script>
</body>
</html>
