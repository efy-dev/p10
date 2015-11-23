<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/18
  Time: 14:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div class="am-g">
    <div class="am-u-sm-12 am-u-md-6">
<security:authorize ifAnyGranted="admin,operational,c_operational,o_operational">
        <a type="button" class="am-btn am-btn-default am-btn-xs" href="<c:url value="/basic/xm.do?qm=plistPCProductModel_default&projectCategoryId=${object.id}"/>">推荐产品</a>
    </security:authorize>
    </div>
    <div class="am-u-sm-12">
        <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
            <tr>
        <security:authorize ifAnyGranted="admin,operational,c_operational,o_operational">
                <th class="table-title" width="25%">操作</th>
        </security:authorize>
                <th class="table-title" width="25%">产品名称</th>
                <th class="table-title" width="25%">产品编号</th>
                <th class="table-title" width="25%">排序</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${objectList}" var="projectCategoryProductModel">
                <tr id="${projectCategoryProductModel.id}">
                    <security:authorize ifAnyGranted="admin,operational,c_operational,o_operational">
                    <td>
                        <a  class="am-btn am-btn-default am-btn-xs am-text-secondary" href="javascript:void(0);"  onclick="showConfirm('提示','确认解除产品？',function(){removeSubjectProductModel('${projectCategoryProductModel.projectCategory.id}','${projectCategoryProductModel.productModel.id}','${projectCategoryProductModel.id}')})"><span
                                class="am-icon-pencil-square-o"></span> 取消推荐
                        </a>
                    </td>
                    </security:authorize>
                    <td class="am-hide-sm-only">
                            ${projectCategoryProductModel.productModel.name}
                    </td>
                    <td class="am-hide-sm-only">
                            ${projectCategoryProductModel.productModel.serial}

                    </td>
                    <td class="am-hide-sm-only">

                        <a href="#" onclick="toUpdateSort(this,'<c:url value="/product/updateProductModelSort.do"/>')" sort="${projectCategoryProductModel.sort}" id="${projectCategoryProductModel.id}">
                                ${projectCategoryProductModel.sort}
                        </a>

                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>

    function toUpdateSort(obj,updateUrl){
        var sort = $(obj).attr("sort");
        var id = $(obj).attr("id");
        $(obj).parent().html("<input id="+id+" onblur=\"updateSort(this,'"+updateUrl+"')\" type=\"text\" name=\"sort\" style=\"width: 35px;\" value="+sort+" />");
    }
    function updateSort(obj,updateUrl){
        var sort = $(obj).val();
        var id = $(obj).attr("id");
        $.ajax({
            type: "get",
            url: updateUrl,
            cache: false,
            dataType: "json",
            data:{id:id,sort:sort},
            success: function (data) {
//                $(obj).parent().html("<a onclick=\"toUpdateSort(this,'"+updateUrl+"')\" sort="+sort+" id="+id+">"+sort+"</a>");
                location.reload();
            }
        });
    }
    function removeSubjectProductModel(projectCategoryId,productModelId,projectCategoryProductModelId){
        $.ajax({
            type: "get",
            url: '<c:url value="/product/linkProjectCategory.do"/>',
            cache: false,
            dataType: "json",
            data:{projectCategoryId:projectCategoryId,productModelId:productModelId,projectCategoryProductModelId:projectCategoryProductModelId,status:"0"},
            success: function (data) {
                $("#"+data).remove();

            }
        });
    }
</script>