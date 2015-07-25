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
    <script type="text/javascript" src="<c:url value='/scripts/jquery-1.11.1.min.js'/>"></script>
</head>
<body>
<div style="text-align: left" >
    <c:if test="${empty level}">
        <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=formProjectCategory&fatherCategoryId=${fatherCategoryId}&level=1"/>'" type="button" class="am-btn am-btn-default am-btn-xs" style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;" value="新建类别" />
    </c:if>
    <c:if test="${not empty level}">
         <input onclick="window.location.href='<c:url value="/basic/xm.do?qm=formProjectCategory&fatherCategoryId=${fatherCategoryId}&level=${level}"/>'" type="button" class="am-btn am-btn-default am-btn-xs" style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;" value="新建类别" />
    </c:if>
</div>
<table class="am-table am-table-bordered am-table-radius am-table-striped" >
    <tr style="text-align: left">
        <td>操作</td>
        <td width="">类别名称</td>
        <td width="">类别编号</td>
    </tr>

    <c:forEach items="${requestScope.pageInfo.list}" var="projectCategory">

        <tr style="text-align: left">
            <td width="20%">
                <div class="am-btn-toolbar">
                    <div class="am-btn-group am-btn-group-xs" style="width: 100%;text-align: center;" >
                        <button  style="margin-left: 70px;" onclick="window.location.href='<c:url value="/basic/xm.do?qm=formProjectCategory&fatherCategoryId=${fatherCategoryId}&level=${projectCategory.level}&id=${projectCategory.id}"/>'" class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span class="am-icon-edit"></span> 编辑</button>
                        <button onclick="window.location.href='<c:url value="/basic/xm.do?qm=removeProjectCategory&id=${projectCategory.id}"/>'" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 删除</button>
                    </div>
                </div>
            </td>
            <td width="10%">
                    <a href="<c:url value="/basic/xm.do?qm=plistProjectCategory_default&fatherCategoryId=${projectCategory.id}&level=${projectCategory.level+1}&conditions=fatherCategory.id:${projectCategory.id};level:${projectCategory.level+1}"/>" >
                      ${projectCategory.name}
                    </a>
            </td>
            <td>
                ${projectCategory.serial}
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

</body>
</html>
