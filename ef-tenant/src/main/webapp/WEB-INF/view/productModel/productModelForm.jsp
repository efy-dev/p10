<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>

</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">新建/编辑商品模型</strong> /
        <small>New/Edit ProducModel</small>
    </div>
</div>
<hr/>
<div class="am-g">

    <fieldset>
        <legend class="" style="font-size: 17px">商品模型</legend>
        <form action="<c:url value="/product/saveNewProduct.do?view=${view}"/>" method="post"
              class="am-form am-form-horizontal" enctype="multipart/form-data">
            <input type="hidden" name="productId" value="${object.id}">
            <input type="hidden" name="resultPage" value="0"/>
            <input type="hidden" name="step" value="model">

            <div class="am-form-group">
                <label name="name" class="am-u-sm-3 am-form-label">商品名称</label>

                <div class="am-u-sm-9" style="margin-top: 10px;">
                    ${object.name}
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
                </div>
            </div>

            <div class="am-form-group">
                <label name="masterList" class="am-u-sm-3 am-form-label">大师</label>

                <div class="am-u-sm-9" style="margin-top: 10px;">
                    ${object.master.fullName}
                </div>
            </div>

            <div class="am-form-group">
                <label name="masterList" class="am-u-sm-3 am-form-label">项目</label>

                <div class="am-u-sm-9" style="margin-top: 10px;" id="projectDisplay">
                    ${object.project.name}
                </div>
            </div>

            <div class="am-form-group">
                <label name="masterList" class="am-u-sm-3 am-form-label">规格</label>

                <div class="am-u-sm-9" style="" id="propertyDisplay">

                    <c:forEach var="property" items="${object.project.projectPropertyList}">
                        <div style="padding: 10px;">
                                     <span style="margin-right: 5px;padding-bottom: 10px;">
                                             ${property.name}
                                     </span>

                            <div class="am-btn-group" data-am-button>
                                <c:forEach items="${property.projectPropertyValueList}" var="propertyValue">
                                    <label class="am-btn am-btn-default am-btn-xs" status="0"
                                           onclick="projectPropertyClick(this);">
                                        <input type="checkbox"
                                               value="${propertyValue.id}"
                                               propertyValue="${propertyValue.value}"> ${propertyValue.value}
                                    </label>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <div style="text-align: right;margin-right: 100px;margin-bottom: 10px;">
                <span>
                     <a style="width: 10%;" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                        href="javascript:void(0);" onclick="addModel()">
                         自定义规格
                     </a>
                </span>
            </div>
            <div class="am-u-md-9" style="margin-left: 19%;">
                <div class="am-panel am-panel-default">
                    <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-2'}">商品规格<span
                            class="am-icon-chevron-down am-fr"></span></div>
                    <div id="collapse-panel-2" class="am-in">
                        <table class="am-table am-table-bd am-table-bdrs am-table-striped am-table-hover"
                               id="productModel">
                            <tr>
                                <th class="am-text-center" width="10%">操作</th>
                                <th class="am-text-center" width="15%">商品名称</th>
                                <th class="am-text-center" width="15%">属性</th>
                                <th class="am-text-center" width="10%">库存</th>
                                <th class="am-text-center" width="15%">价格(元)</th>
                                <th class="am-text-center" width="15%">市场价格(元)</th>
                                <th class="am-text-center" width="10%">重量(kg)</th>
                            </tr>
                            <c:set var="iscontain" value="false" />
                            <c:forEach var="item" items="${object.productModelList}">
                                <c:if test="${item.status == '3'}">
                                    <c:set var="iscontain" value="true" />
                                </c:if>
                            </c:forEach>
                            <c:if test="${iscontain == 'false' }">
                                <tr flag="default">
                                    <td align="center">
                                        <input type="hidden" name="defaultId" value=""/>
                                        <input type="hidden" name="defaultStatus" value="3"/>
                                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                           href="javascript:void(0);">
                                            <span class="am-icon-trash-o">无法删除</span>
                                        </a>
                                    </td>
                                    <td align="center">
                                        <input type="text" name="defaultName" style="width: 100%;height: 30px;"
                                               value=""/>
                                    </td>
                                    <td class="am-text-center">
                                        无
                                    </td>
                                    <td align="center">
                                        <input type="text" name="defaultAmount" style="width: 50%;height: 30px;"
                                               value=""/>
                                    </td>
                                    <td align="center">
                                        <input type="text" name="defaultPrice" style="width: 50%;height: 30px;"
                                               value=""/>
                                    </td>
                                    <td align="center">
                                        <input type="text" name="defaultMarketPrice" style="width: 50%;height: 30px;"
                                               value=""/>
                                    </td>
                                    <td align="center">
                                        <input type="text" name="defaultWeight" style="width: 50%;height: 30px;"
                                               value="" required/>
                                    </td>
                                </tr>
                            </c:if>
                            <c:if test="${not empty object.productModelList}">
                                <c:forEach var="model" items="${object.productModelList}">
                                    <c:if test="${model.status == '3'}">
                                        <tr flag="default">
                                            <td align="center">
                                                <input type="hidden" name="defaultId" value="${model.id}"/>
                                                <input type="hidden" name="defaultStatus" value="${model.status}"/>
                                                <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                                   href="javascript:void(0);">
                                                    <span class="am-icon-trash-o">无法删除</span>
                                                </a>
                                            </td>
                                            <td align="center">
                                                <input type="text" name="defaultName" style="width: 100%;height: 30px;"
                                                       value="${model.name}"/>
                                            </td>
                                            <td class="am-text-center">
                                                无
                                            </td>
                                            <td align="center">
                                                <input type="text" name="defaultAmount" style="width: 50%;height: 30px;"
                                                       value="${model.amount}"/>
                                            </td>
                                            <td align="center">
                                                <input type="text" name="defaultPrice" style="width: 50%;height: 30px;"
                                                       value="${model.price}"/>
                                            </td>
                                            <td align="center">
                                                <input type="text" name="defaultMarketPrice" style="width: 50%;height: 30px;"
                                                       value="${model.marketPrice}"/>
                                            </td>
                                            <td align="center">
                                                <input type="text" name="defaultWeight" style="width: 50%;height: 30px;"
                                                       value="${model.weight}" required/>
                                            </td>
                                        </tr>
                                    </c:if>
                                    <c:if test="${model.status != '3'}">
                                        <c:if test="${model.status == '1'}">
                                            <tr id="${model.id}" status="1" flag="auto">
                                        </c:if>
                                        <c:if test="${model.status == '2'}">
                                            <tr id="${model.id}" status="1" flag="custom">
                                        </c:if>
                                        <td align="center">
                                            <input type="hidden" name="modelId" value="${model.id}"/>
                                            <input type="hidden" name="modelStatus" value="${model.status}"/>
                                            <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                               onclick="removeProductModel(this)" href="javascript:void(0);">
                                                <span class="am-icon-trash-o">删除</span>
                                            </a>
                                        </td>
                                        <td align="center">
                                            <input type="text" name="modelName" style="width: 100%;height: 30px;"
                                                   value="${model.name}"/>
                                        </td>
                                        <td class="am-text-center">
                                            <c:if test="${model.status == '1'}">
                                                <c:forEach var="modelProperty"
                                                           items="${model.productPropertyValueList}">
                                               <span style="padding: 5px;" id="${modelProperty.projectPropertyValue.id}"
                                                     value="${modelProperty.projectPropertyValue.value}">
                                                       ${modelProperty.projectPropertyValue.value}
                                               </span>
                                                </c:forEach>
                                            </c:if>
                                            <c:if test="${model.status == '2'}">
                                                <input type="text" name="property" style="width: 100%;height: 30px;"
                                                       value="${model.customProperty}"/>
                                            </c:if>

                                            <input type="hidden" value="" name="modelProperty"/>
                                        </td>
                                        <td align="center">
                                            <input type="text" name="modelAmount" style="width: 50%;height: 30px;"
                                                   value="${model.amount}"/>
                                        </td>
                                        <td align="center">
                                            <input type="text" name="modelPrice" style="width: 50%;height: 30px;"
                                                   value="${model.price}"/>
                                        </td>
                                        <td align="center">
                                            <input type="text" name="marketPrice" style="width: 50%;height: 30px;"
                                                   value="${model.marketPrice}"/>
                                        </td>
                                        <td align="center">
                                            <input type="text" name="weight" style="width: 50%;height: 30px;"
                                                   value="${model.weight}" required/>
                                        </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>

                            </c:if>


                        </table>
                    </div>
                </div>
            </div>

            <div class="am-form-group">
                <div class="am-u-sm-9 am-u-sm-push-3">
                    <%--<span style="padding: 10px;">--%>
                    <%--<input type="button" onclick="toSubmit('/productPicture/productPictureForm')" class="am-btn am-btn-primary" value="保存,并进入商品图片"/>--%>
                    <%--</span>--%>
                    <span style="padding: 10px;">


                            <input type="button"
                                   onclick="toSubmit('redirect:/basic/xm.do?qm=plistProduct_default&view=${view}&tenantId=${object.tenant.id}')"
                                   class="am-btn am-btn-primary" value="完成"/>

                    </span>
                      <span style="padding: 10px;">
                       <input type="button"
                              onclick="toSubmit('redirect:/basic/xm.do?qm=viewProduct&view=${view}&id=${object.id}')"
                              class="am-btn am-btn-primary" value="保存,并查看商品详情"/>
                    </span>
                </div>
            </div>
        </form>
    </fieldset>
</div>

<!-- content end -->
<hr/>
<script type="text/javascript">
    //初始化
    $(function () {
        $("#productModel tr[status='1'][flag='auto']").each(function () {
            var id = "";
            var l = $("td:eq(2) span", $(this)).length;
            var index = 1;
            $("td:eq(2) span", $(this)).each(function () {
                if (index == l) {
                    id += $(this).attr("id");
                } else {
                    id += $(this).attr("id") + ",";
                }

            });
            $("input[name='modelProperty']", $(this)).val(id);
        });
    });

    function addModel() {
        var tr = '<tr id="0" status="1" flag="custom">' +
                '<td align="center">' +
                '<input type="hidden" name="modelId" value=""/>' +
                '<input type="hidden" name="modelStatus" value="2"/>' +
                ' <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="removeProductModel(this)" href="javascript:void(0);">' +
                '  <span class="am-icon-trash-o">删除</span>' +
                ' </a>' +
                '</td>' +
                '<td align="center">' +
                ' <input type="text" name="modelName" style="width: 100%;height: 30px;" value=""/>' +
                '</td>' +
                '<td class="am-text-center">' +
                ' <input type="text" name="property" style="width: 100%;height: 30px;" value=""/>' +
                '</span>' +
                '<input type="hidden" value="" name="modelProperty" />' +
                '</td>' +
                '<td align="center">' +
                ' <input type="text" name="modelAmount" style="width: 50%;height: 30px;" value=""/>' +
                '</td>' +
                '<td align="center">' +
                ' <input type="text" name="modelPrice" style="width: 50%;height: 30px;" value=""/>' +
                '</td>' +
                '<td align="center">' +
                ' <input type="text" name="marketPrice" style="width: 50%;height: 30px;" value=""/>' +
                '</td>' +
                '<td align="center">' +
                ' <input type="text" name="weight" style="width: 50%;height: 30px;" value="" required/>' +
                '</td>' +
                '</tr>';
        $("#productModel").append(tr);
    }

    //提交
    function toSubmit(result) {
        $("input[name='resultPage']").val(result);
        var f = true;
        $("tr[status!='0'] input[name*='eight']").each(function(){
            if($(this).val()==""){
                f = false;
                return false;
            }
        });
        if(f) {
            if ($("#productModel tr[flag='default']").length == 1) {
                $("form").submit();
            } else {
                alert("保存失败!");
            }
        }else{
            alert("请填写商品规格重量!");
        }



    }
    /****属性 生成商品模型***/
    function projectPropertyClick(obj) {

        if ($(obj).attr("status") == "0") {
            $(obj).attr("status", "1");
        } else {
            $(obj).attr("status", "0");
        }

        var productModel = [];
        var temp = [];

        $(".am-btn-group").each(function () {
            if ($("label[status='1']", $(this)).length > 0) {
                temp = [];
                $("label[status='1']", $(this)).each(function () {
                    if (productModel.length == 0) {
                        temp.push($(this).find("input").val() + "_" + $(this).find("input").attr("propertyValue"));
                    } else {
                        for (var i = 0; i < productModel.length; i++) {
                            temp.push(productModel[i] + "," + $(this).find("input").val() + "_" + $(this).find("input").attr("propertyValue"));
                        }
                    }
                });
                productModel = temp;
            }

        });


        if ($("#productModel tr:gt(0)[flag='auto']").length > 0) {
            $("#productModel tr:gt(0)[flag='auto']").each(function () {
                var index = 1;
                var value = "";
                var len = $("td:eq(2)", $(this)).find("span").length;
                $("td:eq(2)", $(this)).find("span").each(function () {
                    if (index == len) {
                        value += $(this).attr("id") + "_" + $(this).attr("value");
                    } else {
                        value += $(this).attr("id") + "_" + $(this).attr("value") + ",";
                    }
                    index++;
                });
                if (!searchValue(productModel, value)) {
                    if ($(this).attr("id") == "0") {
                        $(this).remove();
                    } else {
                        $(this).hide();
                        $(this).attr("status", "0");
                        $("input[name='modelStatus']", $(this)).val("0");

                    }
                } else {
                    productModel = removeArry(productModel, value);
                    $(this).show();
                    $(this).attr("status", "1");
                    $("input[name='modelStatus']", $(this)).val("1");
                }
            });
        }
        for (var j = 0; j < productModel.length; j++) {
            a = productModel[j].split(",");
            name = "";
            var tr = '<tr id="0" status="1" flag="auto">' +
                    '<td align="center">' +
                    '<input type="hidden" name="modelId" value=""/>' +
                    '<input type="hidden" name="modelStatus" value="1"/>' +
                    ' <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="removeProductModel(this)" href="javascript:void(0);">' +
                    '  <span class="am-icon-trash-o">删除</span>' +
                    ' </a>' +
                    '</td>' +
                    '<td align="center">' +
                    ' <input type="text" name="modelName" style="width: 100%;height: 30px;" value="' + name + '"/>' +
                    '</td>' +
//                 '<td class="am-text-center">'+name+'</td>'+
                    '<td class="am-text-center">';
            var ids = "";
            for (var i = 0; i < a.length; i++) {
                name = a[i].split("_")[1];
                id = a[i].split("_")[0];
                if (i == a.length - 1) {
                    ids += id;
                } else {
                    ids += id + ",";
                }

                tr += '<span style="padding: 5px;" id="' + id + '" value="' + name + '">' + name +
                        '</span>';
            }

            tr += '<input type="hidden" value="' + ids + '" name="modelProperty" />';
            tr += '</td>' +
                    '<td align="center">' +
                    ' <input type="text" name="modelAmount" style="width: 50%;height: 30px;" value=""/>' +
                    '</td>' +
                    '<td align="center">' +
                    ' <input type="text" name="modelPrice" style="width: 50%;height: 30px;" value=""/>' +
                    '</td>' +
                    '<td align="center">' +
                    ' <input type="text" name="marketPrice" style="width: 50%;height: 30px;" value=""/>' +
                    '</td>' +
                    '<td align="center">' +
                    ' <input type="text" name="weight" style="width: 50%;height: 30px;" value="" required/>' +
                    '</td>' +
                    '</tr>';


            $("#productModel").append(tr);
        }
    }


    function removeArry(arry, value) {
        var newArry = [];
        for (var i = 0; i < arry.length; i++) {
            if (arry[i] != value) {
                newArry.push(arry[i]);
            }
        }
        return newArry;
    }
    function searchValue(arry, value) {
        var flag = false;
        for (var i = 0; i < arry.length; i++) {
            if (arry[i] == value) {
                flag = true;
                return flag;
            }
        }
        return flag;
    }

    function searchKeys(arry, value) {

        for (var i = 0; i < arry.length - 1; i++) {
            if (arry[i] == value) {
                return i;
            }
        }

    }


    //删除商品模型
    function removeProductModel(obj) {
        if ($(obj).parent().parent().attr("id") != "0") {
            $(obj).parent().parent().hide();
            if($(obj).parent().parent().attr("flag")=="custom"){
                $("input[name='modelStatus']", $(obj).parent().parent()).val("-1");
            }else{
                $("input[name='modelStatus']", $(obj).parent().parent()).val("0");
            }
            $(obj).parent().parent().attr("status", "0");

        } else {
            $(obj).parent().parent().remove();
        }
    }

</script>


</body>
</html>
