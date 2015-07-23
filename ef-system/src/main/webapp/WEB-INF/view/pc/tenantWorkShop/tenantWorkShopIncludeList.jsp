<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/22
  Time: 20:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<table class="am-table am-table-striped am-table-hover table-main">
    <thead>
    <tr>
        <th class="table-set">操作</th>
        <th class="table-title">名称</th>
        <th class="table-title">创建时间</th>
        <th class="table-title">封面</th>

    </tr>
    </thead>
    <tbody>

    <c:forEach items="${objectList}" var="tenantWorkShop">
        <tr id="${tenantWorkShop.id}">
            <td>
                <div class="am-btn-toolbar">
                    <div class="am-btn-group am-btn-group-xs">
                        <a class="am-btn am-btn-default am-btn-xs am-text-secondary"
                           href="<c:url value="/basic/xm.do?qm=formTenantWorkShop&id=${tenantWorkShop.id}"/>"><span
                                class="am-icon-pencil-square-o"></span> 编辑
                        </a>
                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                           onclick="removeTenantWorkShop('${tenantWorkShop.id}')"><span
                                class="am-icon-trash-o"></span> 删除
                        </a>
                    </div>
                </div>
            </td>
            <td class="am-hide-sm-only"><a
                    href="<c:url value="/basic/xm.do?qm=viewTenantWorkShop&id=${tenantWorkShop.id}"/>">${tenantWorkShop.name}</a>
            </td>
            <td class="am-hide-sm-only">${tenantWorkShop.createDateTime}</td>
            <td class="am-hide-sm-only"><img
                    src="<c:url value="http://tenant.efeiyi.com/${tenantWorkShop.picture_url}@!tenant-manage-banner"/>"
                    alt=""/></td>
        </tr>
    </c:forEach>
    </tbody>
</table>


<script>

    function removeTenantWorkShop(divId){
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeTenantWorkShop"/>',
            cache: false,
            dataType: "json",
            data:{id:divId},
            success: function (data) {
                $("#"+divId).remove();
            }
        });
    }

</script>

