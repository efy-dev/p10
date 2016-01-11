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

<div class="am-g">
    <div class="am-u-sm-12 am-u-md-6">
        <a type="button" class="am-btn am-btn-default am-btn-xs" href="<c:url value="/basic/xm.do?qm=plistTMaster_default&tenantId=${tenantId}"/>">关联与店铺相关的大师</a>
    </div>
    <div class="am-u-sm-12">
        <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
            <tr>
                <th class="table-title" width="25%">操作</th>
                <th class="table-title" width="25%">大师姓名</th>
                <th class="table-title" width="25%">性别</th>
                <th class="table-title" width="25%">等级</th>

            </tr>
            </thead>
            <tbody>
            <c:forEach items="${objectList}" var="tenantMaster" end="4">
                <tr id="${tenantMaster.id}">
                    <td>
                        <a id="${master.id}" class="am-btn am-btn-default am-btn-xs am-text-secondary" href="javascript:void(0);"  onclick="showConfirm('提示','解除关联同时会删除商品与项目和大师的关联，请谨慎操作；如确实要解除，请在商品管理页重新关联项目。',function(){removeTenantMaster('${tenantMaster.tenant.id}','${tenantMaster.master.id}','${tenantMaster.id}')})"><span
                                class="am-icon-pencil-square-o"></span> 解除大师
                        </a>
                    </td>
                    <td class="am-hide-sm-only">
                            ${tenantMaster.master.fullName}
                    </td>
                    <td class="am-hide-sm-only">
                        <ming800:status name="sex" dataType="Master.sex" checkedValue="${tenantMaster.master.sex}" type="normal"/>

                    </td>
                    <td class="am-hide-sm-only">
                        <ming800:status name="level" dataType="Master.level" checkedValue="${tenantMaster.master.level}" type="normal"/>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>
    function removeTenantMaster(tenantId,masterId,tenantMasterId){
        $.ajax({
            type: "get",
            url: '<c:url value="/tenant/linkMaster.do"/>',
            cache: false,
            dataType: "json",
            data:{tenantId:tenantId,masterId:masterId,tenantMasterId:tenantMasterId,status:"1"},
            success: function (data) {
//                $("#"+divId).remove();
                location.reload();
            }
        });
    }
</script>