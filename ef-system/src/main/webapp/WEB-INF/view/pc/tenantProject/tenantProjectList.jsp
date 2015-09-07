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

    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-6">
            <a type="button" class="am-btn am-btn-default am-btn-xs" href="<c:url value="/product/project/toTenantProject.do?tenantId=${tenantId}"/>">关联项目</a>
        </div>
        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
                    <th width="20%">操作</th>
                    <th width="40%">项目名称</th>
                    <th width="40%">项目编号</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${objectList}" var="tenantProject" end="4">
                    <tr id="${tenantProject.id}">
                        <td>
                          <a id="${tenantProject.id}" class="am-btn am-btn-default am-btn-xs am-text-secondary" href="javascript:void(0);"  onclick="showConfirm('提示','是否删除',function(){removeTenantProject('${tenantProject.id}')})"><span
                                class="am-icon-pencil-square-o"></span> 解除商家
                          </a>
                        </td>
                        <td class="am-hide-sm-only">
                            ${tenantProject.project.name}
                        </td>
                        <td class="am-hide-sm-only"> ${tenantProject.project.serial}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
<script>
    function removeTenantProject(divId){
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeTenantProject"/>',
            cache: false,
            dataType: "json",
            data:{id:divId},
            success: function (data) {
                $("#"+divId).remove();
            }
        });
    }
</script>
