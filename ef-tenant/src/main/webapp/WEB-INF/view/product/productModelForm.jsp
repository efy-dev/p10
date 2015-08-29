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
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">新建/编辑商品</strong> /
        <small>New/Edit Product</small>
    </div>
</div>
<hr/>
<div class="am-g">

    <fieldset>
        <legend class="" style="font-size: 17px">商品信息</legend>
        <form action="<c:url value="/product/saveNewProduct.do"/>" method="post" class="am-form am-form-horizontal">
            <input type="hidden" name="id" value="${object.id}">
            <input type="hidden" name="tenant.id" value="${tenantId}">

            <div class="am-form-group">
                <label name="serial" class="am-u-sm-3 am-form-label">商品编号</label>

                <div class="am-u-sm-9">
                    <c:if test="${empty object.serial}">
                        <input type="text" name="serial" id="serial" placeholder="自动生成" value="${serial}">
                    </c:if>
                    <c:if test="${not empty object.serial}">
                        <input type="text" name="serial" id="serial" placeholder="自动生成" value="${object.serial}">
                    </c:if>
                    <!--<small>必填项*</small>-->
                </div>
            </div>
            <div class="am-form-group">
                <label name="name" class="am-u-sm-3 am-form-label">商品名称</label>

                <div class="am-u-sm-9">
                    <input type="text" name="name" id="name" placeholder="商品名称" value="${object.name}">
                    <!--<small>必填项*</small>-->
                </div>
            </div>

            <div class="am-form-group">
                <label name="price" class="am-u-sm-3 am-form-label">商品价格</label>

                <div class="am-u-sm-9">
                    <input type="text" name="price" id="price" value="${object.price}">
                    <!--<small>必填项*</small>-->
                </div>
            </div>

            <div class="am-form-group">
                <label name="serial" class="am-u-sm-3 am-form-label">商品类型</label>

                <div class="am-u-sm-9" style="margin-top: 10px;">
                 <span style="margin-left: 10px;">
                   <input type="radio" name="status" value="1" checked="checked"/>
                     收藏品
                 </span>
                 <span style="margin-left: 10px;">
                   <input type="radio" name="status" value="2"/>
                     精品
                 </span>
                    <!--<small>必填项*</small>-->
                </div>
            </div>

            <div class="am-form-group">
                <label name="masterList" class="am-u-sm-3 am-form-label">大师</label>

                <div class="am-u-sm-9" style="margin-top: 10px;">
                    <c:forEach var="tenantMaster" items="${masterList}">
            <span style="margin-left: 10px;">
               <input type="radio" value="${tenantMaster.master.id}" onclick="changeMaster(this)" name="master.id"/>
               ${tenantMaster.master.fullName}
            </span>
                    </c:forEach>
                    <!--<small>必填项*</small>-->
                </div>
            </div>

            <div class="am-form-group">
                <label name="masterList" class="am-u-sm-3 am-form-label">项目</label>

                <div class="am-u-sm-9" style="margin-top: 10px;" id="projectDisplay">
                    <c:forEach var="projectMap" items="${projectMap}">
                        <div id="${projectMap.key}" style="display: none">
                            <c:forEach var="masterProject" items="${projectMap.value}" varStatus="status">
                              <span style="margin-left: 10px;">
                                  <input value="${masterProject.project.id}" onclick="changeProject(this);" type="radio"
                                         flag="${status.index}" name="project.id"/>
                                  ${masterProject.project.name}
                              </span>
                            </c:forEach>
                        </div>
                    </c:forEach>
                    <%--<select data-am-selected="{btnSize: 'sm'}" id="project">--%>
                    <%--<option value="option1">选项一...</option>--%>
                    <%--<option value="option2">选项二.....</option>--%>
                    <%--<option value="option3">选项三........</option>--%>
                    <%--</select>--%>
                    <!--<small>必填项*</small>-->
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


            <div class="am-form-group">
                <label for="productDescription" class="am-u-sm-3 am-form-label">商品描述</label>

                <div class="am-u-sm-9">
                        <textarea id="productDescription" name="productDescription.id" class="ckeditor"
                                  placeholder="商品描述" required
                                  value="${object.productDescription.id}">${object.productDescription.content}</textarea>
                </div>
                <br>
            </div>
            <div class="am-form-group">
                <div class="am-u-sm-9 am-u-sm-push-3">
                    <span style="padding: 10px;">
                       <input type="submit" class="am-btn am-btn-primary" value="保存,并进入商品描述"/>
                    </span>
                    <span style="padding: 10px;">
                       <input type="submit" class="am-btn am-btn-primary" value="保存,并返回商品列表"/>
                    </span>
                </div>
            </div>
        </form>
    </fieldset>
    <fieldset>
        <legend class="" style="font-size: 17px">商品模型</legend>
        <form action="<c:url value="/basic/xm.do"/>" method="post" class="am-form am-form-horizontal">
            <input type="hidden" name="id" value="${object.id}">
            <input type="hidden" name="tenant.id" value="${tenantId}">


            <div class="am-form-group">
                <label name="masterList" class="am-u-sm-3 am-form-label">属性</label>

                <div class="am-u-sm-9" style="" id="propertyDisplay">

                    <c:forEach var="propertyMap" items="${propertyMap}" varStatus="status">
                        <div id="${propertyMap.key}" style="display:none;">
                            <c:forEach var="property" items="${propertyMap.value}">
                                <div style="padding: 10px;">
                                     <span style="margin-right: 5px;padding-bottom: 10px;">
                                             ${property.name}
                                     </span>

                                    <div class="am-btn-group" data-am-button>
                                        <c:forEach items="${property.projectPropertyValueList}" var="propertyValue">
                                            <label class="am-btn am-btn-default am-btn-xs" status="0"
                                                   onclick="projectPropertyClick(this);">
                                                <input type="checkbox"
                                                       value="${propertyValue.value}"> ${propertyValue.value}
                                            </label>
                                        </c:forEach>
                                    </div>
                                </div>
                                <c:if test="${(status.index+1)%2==0}">
                                    <br/>
                                </c:if>
                            </c:forEach>
                        </div>
                    </c:forEach>

                    <%--<select data-am-selected="{btnSize: 'sm'}" id="project">--%>
                    <%--<option value="option1">选项一...</option>--%>
                    <%--<option value="option2">选项二.....</option>--%>
                    <%--<option value="option3">选项三........</option>--%>
                    <%--</select>--%>
                    <!--<small>必填项*</small>-->
                </div>
            </div>


            <div class="am-u-md-9" style="margin-left: 19%;">
                <div class="am-panel am-panel-default">
                    <div class="am-panel-hd am-cf" data-am-collapse="{target: '#collapse-panel-2'}">商品模型<span
                            class="am-icon-chevron-down am-fr"></span></div>
                    <div id="collapse-panel-2" class="am-in">
                        <table class="am-table am-table-bd am-table-bdrs am-table-striped am-table-hover"
                               id="productModel">
                            <tbody>
                            <tr>
                                <th class="am-text-center" width="20%">操作</th>
                                <th class="am-text-center" width="20%">商品名称</th>
                                <th class="am-text-center" width="20%">属性</th>
                                <th class="am-text-center" width="20%">库存</th>
                                <th class="am-text-center" width="20%">价格(元)</th>
                            </tr>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="am-form-group">
                <div class="am-u-sm-9 am-u-sm-push-3">
                    <input type="submit" class="am-btn am-btn-primary" value="保存商品模型"/>
                </div>
            </div>
        </form>
    </fieldset>


</div>

<!-- content end -->
<hr/>
<script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/>"></script>
<script type="text/javascript">

    //新建初始化
    if (${empty object.id }) {
        $("input[name='master.id']:first").attr("checked", "checked");
        var masterId = $("input[name='master.id']:checked").val();
        var pro = $("div[id='" + masterId + "']");
        $(pro).css({"display": "block"});
        $("input[name='project.id']:first", pro).attr("checked", true);
        var projectId = $("input[name='project.id']:checked").val();
        $("div[id='" + projectId + "']").css({"display": "block"});
    }
    /****属性 生成商品模型***/
    function projectPropertyClick(obj) {

        if ($(obj).attr("status") == "0") {
            $(obj).attr("status", "1");
        } else {
            $(obj).attr("status", "0");
        }
        var projectId = $("input[name='project.id']:checked").val();
        var productModel = [];
        var temp = [];
        $("div[id='" + projectId + "'] .am-btn-group").each(function () {
            if ($("label[status='1']", $(this)).length > 0) {
                temp = [];
                $("label[status='1']", $(this)).each(function () {
                    if (productModel.length == 0) {
                        temp.push($(this).find("input").val());
                    } else {
                        for (var i = 0; i < productModel.length; i++) {
                            temp.push(productModel[i] + "," + $(this).find("input").val());
                        }
                    }
                });
                productModel = temp;
            }

        });
        var name = $("#name").val();
        $("#productModel tr:gt(0)").each(function () {
            $(this).remove();
        });
        for (var j = 0; j < productModel.length; j++) {
            var tr = '<tr>' +
                    '<td align="center">' +
                    ' <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="removeProductModel(this)" href="#">' +
                    '  <span class="am-icon-trash-o">删除</span>' +
                    ' </a>' +
                    '</td>' +
                    '<td align="center">' +
                    ' <input type="text" name="price" style="width: 100%;height: 30px;" value="' + name + '"/>' +
                    '</td>' +
//                 '<td class="am-text-center">'+name+'</td>'+
                    '<td class="am-text-center">' + productModel[j] + '</td>' +
                    '<td align="center">' +
                    ' <input type="text" name="price" style="width: 23%;height: 30px;" value=""/>' +
                    '</td>' +
                    '<td align="center">' +
                    ' <input type="text" name="price" style="width: 23%;height: 30px;" value=""/>' +
                    '</td>' +
                    '</tr>';


            $("#productModel").append(tr);
        }
    }


    <%--/****获取项目**/--%>
    <%--function checkOutProject(obj) {--%>
    <%--var masterId = $(obj).val();--%>
    <%--$.ajax({--%>
    <%--type: "post",--%>
    <%--dataType: "json",--%>
    <%--data: {masterId: masterId},--%>
    <%--url: "<c:url value="/product/getProjectList.do"/>",--%>
    <%--success: function (data) {--%>

    <%--alert(data);--%>
    <%--}--%>
    <%--});--%>
    <%--}--%>
    // /////商品名称即时改变
    //    function changeName(obj){
    //       $("#productModel tr:gt(0)").each(function(){
    //           $("td:eq(1)",$(this)).text($(obj).val());
    //       });
    //    }

    ///大师改变
    function changeMaster(obj) {

        $("#projectDisplay").children("div").each(function () {
            if ($(this).attr("id") == $(obj).val()) {
                $(this).css({"display": "block"});
//               $("input[name='project']", $(this)).each(function(){
//                    $(this).attr("checked",false);
//               });
//                 $("input[name='project']:first", $(this)).attr("checked",true);
                var projectId = $("input[name='project.id']:checked", $(this)).val();
                $("#propertyDisplay").children("div").each(function () {
                    if ($(this).attr("id") == projectId) {
                        $(this).css({"display": "block"})
                    } else {
                        $(this).css({"display": "none"});
                    }
                });


            } else {
                $(this).css({"display": "none"});
            }
        });

        clearOrg();
    }

    function clearOrg() {
        //去除原来选中的属性标记
        $(".am-active").each(function () {
            $(this).removeClass("am-active");
            $(this).attr("status", '0');
        });
        //去除原来商品模型
        $("#productModel tr:gt(0)").each(function () {
            $(this).remove();
        });


    }

    //项目改变
    function changeProject(obj) {

        var projectId = $(obj).val();
        $("#propertyDisplay").children("div").each(function () {
            if ($(this).attr("id") == projectId) {
                $(this).css({"display": "block"})
            } else {
                $(this).css({"display": "none"});
            }
        });

        clearOrg();

    }

    //删除商品模型
    function removeProductModel(obj) {
        $(obj).parent().parent().remove();
    }

</script>


</body>
</html>
