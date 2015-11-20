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
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<div class="am-g">
    <div class="am-u-sm-12 am-u-md-6">
<security:authorize ifAnyGranted="admin,operational,c_operational">
        <%--<a type="button" class="am-btn am-btn-default am-btn-xs" href="<c:url value="/product/project/toTenantProject.do?tenantId=${tenantId}"/>">关联项目</a>--%>
        <a type="button" class="am-btn am-btn-default am-btn-xs" href="<c:url value="/basic/xm.do?qm=plistTProduct_default&conditions=tenant.id:${tenantId}&tenantCategoryId=${tenantCategoryId}&tenantId=${tenantId}"/>">添加商品</a>
    </security:authorize>
    </div>
    <div class="am-u-sm-12">
        <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
            <tr>
                <th width="20%">操作</th>
                <th width="40%">商品名称</th>
                <th width="40%">商品编号</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${objectList}" var="tenantProduct" end="4">
                <tr id="${tenantProduct.id}">
                    <td>
                        <a id="${tenantProduct.id}" class="am-btn am-btn-default am-btn-xs am-text-secondary" href="javascript:void(0);"  onclick="showConfirm('提示','确定移除该商品?。',function(){removeTenantProject('${tenantProduct.id}')})"><span
                                class="am-icon-pencil-square-o"></span> 移除
                        </a>
                    </td>
                    <td class="am-hide-sm-only">
                            ${tenantProduct.product.name}
                    </td>
                    <td class="am-hide-sm-only"> ${tenantProduct.product.serial}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<script>
    function removeTenantProject(id){
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeTenantProductTag"/>',
            cache: false,
            dataType: "json",
            data:{id:id},
            success: function (data) {
                $("#"+id).remove();
            }
        });
    }
</script>
