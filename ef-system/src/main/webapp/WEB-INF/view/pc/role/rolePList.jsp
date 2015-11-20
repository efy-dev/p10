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
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title></title>
    <script type="text/javascript" src="<c:url value='/resources/js/alert.js'/>"></script>
</head>
<body>
<div class="am-u-sm-12 am-u-md-6">
    <div class="am-btn-toolbar">
        <div class="am-btn-group am-btn-group-xs">
<security:authorize ifAnyGranted="admin">
            <a type="button" class="am-btn am-btn-default" href="<c:url value="/basic/xm.do?qm=formRole"/>"><span class="am-icon-plus"></span>新建角色</a>
    </security:authorize>
        </div>
    </div>
</div>

<table class="am-table am-table-bordered am-table-radius am-table-striped">
    <tr style="text-align: center">
<security:authorize ifAnyGranted="admin">
        <td>操作</td>
    </security:authorize>
        <td>角色名称</td>
        <td>中文名称</td>
        <td>角色类型</td>
    </tr>

    <c:forEach items="${requestScope.pageInfo.list}" var="role">
        <tr style="text-align: center" id="${role.id}">
            <security:authorize ifAnyGranted="admin">
            <td width="20%">
                <div class="am-btn-toolbar">
                    <div class="am-btn-group am-btn-group-xs" style="width: 100%;text-align: center;" >
                        <a  style="margin-left: 70px;" onclick="window.location.href='<c:url value="/basic/xm.do?qm=formRole&id=${role.id}"/>'" class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span class="am-icon-edit">编辑</span> </a>
                        <button onclick="showConfirm('提示','是否删除',function(){
                              removeRole('${role.id}');
                        })" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 删除</button>
                    </div>
                </div>
            </td>
            </security:authorize>
            <td width="20%">${role.name}</td>
            <td width="20%">${role.cname}</td>
            <td width="20%">
                <ming800:status name="basicType" dataType="Role.basicType" checkedValue="${role.basicType}" type="normal" />
            </td>

        </tr>
    </c:forEach>
</table>
<div style="clear: both">
    <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="/basic/xm.do">
        <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
        <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
        <ming800:pcPageParam name="menuId" value="${requestScope.menuId}"/>
    </ming800:pcPageList>
</div>
<script>

    function removeRole(divId){
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeRole"/>',
            cache: false,
            dataType: "json",
            data:{id:divId},
            success: function (data) {
                $("#"+divId).remove();
            }
        });
    }

</script>
</body>
</html>
