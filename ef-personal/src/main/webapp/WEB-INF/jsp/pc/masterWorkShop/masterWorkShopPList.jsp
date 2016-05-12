<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/25
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>

<html>
<head>
    <title></title>
</head>
<body>
<div class="am-g">
<div class="am-u-sm-12 am-u-md-6">
    <div class="am-btn-toolbar">
        <div class="am-btn-group am-btn-group-xs">
            <a type="button" class="am-btn am-btn-default" href="<c:url value="/basic/xm.do?qm=formMasterWorkShop"/>"><span class="am-icon-plus"></span>新建工作坊</a>
        </div>
    </div>
</div>
<div class="am-u-sm-12">
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

    <c:forEach items="${requestScope.pageInfo.list}" var="masterWorkShop">
        <tr id="${masterWorkShop.id}">
            <td>
                <div class="am-btn-toolbar">
                    <div class="am-btn-group am-btn-group-xs">
                        <a class="am-btn am-btn-default am-btn-xs am-text-secondary"
                           href="<c:url value="/basic/xm.do?qm=formMasterWorkShop&id=${masterWorkShop.id}"/>"><span
                                class="am-icon-pencil-square-o">编辑</span>
                        </a>
                        <a class="am-btn am-btn-default am-btn-xs am-text-secondary"
                           href="<c:url value="/basic/xm.do?qm=viewMasterWorkShop&id=${masterWorkShop.id}"/>"><span
                                class="am-icon-pencil-square-o">详情</span>
                        </a>
                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="showConfirm('提示','是否删除',function(){removeMasterWorkShop('${masterWorkShop.id}')})" href="#"><span
                                class="am-icon-trash-o"></span> 删除
                        </a>
                    </div>
                </div>
            </td>
            <td class="am-hide-sm-only">
                  ${masterWorkShop.name}
            </td>
            <td class="am-hide-sm-only"><img width="10%"
                                             src="<c:url value="http://tenant.efeiyi.com/${masterWorkShop.picture_url}@!tenant-manage-banner"/>"
                                             alt=""/></td>
            <td class="am-hide-sm-only">${masterWorkShop.createDateTime}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</div>
</div>
<div style="clear: both">
    <c:url value="/basic/xm.do" var="url"/>
    <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
        <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
        <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
    </ming800:pcPageList>
</div>
<script>
    function removeMasterWorkShop(divId){
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeMasterWorkShop"/>',
            cache: false,
            dataType: "json",
            data:{id:divId,masterWorkId:divId},
            success: function (data) {
                $("#"+divId).remove();
            }
        });
    }
</script>
</body>
</html>
