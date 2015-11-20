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
        <a type="button" class="am-btn am-btn-default am-btn-xs" href="<c:url value="/basic/xm.do?qm=plistTProductModel_default&subjectId=${object.id}"/>">关联产品</a>
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

            </tr>
            </thead>
            <tbody>
            <c:forEach items="${objectList}" var="subjectProductModel">
                <tr id="${subjectProductModel.id}">
                    <security:authorize ifAnyGranted="admin,operational,c_operational,o_operational">
                    <td>
                        <a  class="am-btn am-btn-default am-btn-xs am-text-secondary" href="javascript:void(0);"  onclick="showConfirm('提示','确认解除产品？',function(){removeSubjectProductModel('${subjectProductModel.subject.id}','${subjectProductModel.productModel.id}','${subjectProductModel.id}')})"><span
                                class="am-icon-pencil-square-o"></span> 解除商品
                        </a>
                    </td>
                    </security:authorize>
                    <td class="am-hide-sm-only">
                            ${subjectProductModel.productModel.name}
                    </td>
                    <td class="am-hide-sm-only">
                            ${subjectProductModel.productModel.serial}

                    </td>

                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>
    function removeSubjectProductModel(subjectId,productModelId,subjectProductModelId){
        $.ajax({
            type: "get",
            url: '<c:url value="/product/linkSubject.do"/>',
            cache: false,
            dataType: "json",
            data:{subjectId:subjectId,productModelId:productModelId,subjectProductModelId:subjectProductModelId,status:"0"},
            success: function (data) {
                $("#"+data).remove();

            }
        });
    }
</script>