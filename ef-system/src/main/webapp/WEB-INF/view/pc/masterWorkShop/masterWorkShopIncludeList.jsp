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
        <th class="table-title">封面</th>
        <th class="table-title">创建时间</th>

    </tr>
    </thead>
    <tbody>

    <c:forEach items="${objectList}" var="masterWorkShop">
        <tr id="${masterWorkShop.id}">
            <td>
                <div class="am-btn-toolbar">
                    <div class="am-btn-group am-btn-group-xs">
                        <a class="am-btn am-btn-default am-btn-xs am-text-secondary"
                           href="<c:url value="/basic/xm.do?qm=formMasterWorkShop&id=${masterWorkShop.id}&masterId=${masterWorkShop.master.id}"/>"><span
                                class="am-icon-pencil-square-o"></span> 编辑
                        </a>
                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                           onclick="removeMasterWorkShop('${masterWorkShop.id}')"><span
                                class="am-icon-trash-o"></span> 删除
                        </a>
                    </div>
                </div>
            </td>
            <td class="am-hide-sm-only"><a
                    href="<c:url value="/basic/xm.do?qm=viewMasterWorkShop&id=${masterWorkShop.id}"/>">${masterWorkShop.name}</a>
            </td>
            <td class="am-hide-sm-only"><img width="10%"
                    src="<c:url value="http://tenant.efeiyi.com/${masterWorkShop.picture_url}@!tenant-manage-banner"/>"
                    alt=""/></td>
            <td class="am-hide-sm-only">${masterWorkShop.createDateTime}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>


<script>

    function removeMasterWorkShop(divId){
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeMasterWorkShop"/>',
            cache: false,
            dataType: "json",
            data:{id:divId},
            success: function (data) {
                $("#"+divId).remove();
            }
        });
    }

</script>

