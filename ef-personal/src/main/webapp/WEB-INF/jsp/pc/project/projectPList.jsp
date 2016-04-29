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
</head>
<body>

<table class="am-table am-table-bordered am-table-radius am-table-striped">
    <tr style="text-align: left">
        <td width="30%">操作</td>
        <td width="15%">项目名称</td>
        <td width="15%">项目编号</td>
        <td width="10%">类别名称</td>
    </tr>


    <c:forEach items="${requestScope.pageInfo.list}" var="project">
        <tr style="text-align: left" id="${project.id}">
            <td width="25%">
                <div class="am-btn-toolbar">
                    <div class="am-btn-group am-btn-group-xs" style="width: 100%;">
                        <button onclick="linkProject('${project.id}')"
                                class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span
                                class="am-icon-edit">关联项目</span>
                        </button>

                    </div>
                </div>
            </td>
            <td width="15%">

                            ${project.name}
            </td>
            <td width="15%">
                    ${project.serial}
            </td>
            <td width="10%">
                    ${project.projectCategory.name}
            </td>
        </tr>

    </c:forEach>
</table>
<div style="clear: both">
    <c:url value="/basic/xm.do" var="url"/>
    <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
        <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
        <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
    </ming800:pcPageList>
</div>
<script>
    function linkProject(id){
        $.ajax({
            type: "get",
            url: '<c:url value="/master/linkProject.do"/>',
            cache: false,
            dataType: "json",
            data:{id:id},
            success: function (data) {
                if(data){
                    alert("关联成功!");
                }else {
                    alert("关联失败，请重新关联或联系客服人员!");
                }

            }
        });
    }

</script>
</body>
</html>
