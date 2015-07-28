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

<%--<table>--%>
    <%--<tr>--%>
        <%--<td>传承人产品id</td>--%>
        <%--<td>传承人产品name</td>--%>
    <%--</tr>--%>

    <%--<c:forEach items="${requestScope.pageInfo.list}" var="masterProduct">--%>
        <%--<tr>--%>
            <%--<td>${masterProduct.id}</td>--%>
            <%--<td>${masterProduct.name}</td>--%>
        <%--</tr>--%>
    <%--</c:forEach>--%>


<%--</table>--%>
<%--<div style="clear: both">--%>
    <%--<ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="/basic/xm.do">--%>
        <%--<ming800:pcPageParam name="qm" value="${requestScope.qm}"/>--%>
        <%--<ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>--%>
    <%--</ming800:pcPageList>--%>
<%--</div>--%>


<div class="admin-content">

    <div class="am-u-md-12">
        <div class="am-btn-toolbar">
            <div class="am-btn-group am-btn-group-xs">
                <a type="button" class="am-btn am-btn-default"
                   href="<c:url value="/basic/xm.do?qm=formMasterWork&masterId=${masterId}&projectId=${projectId}"/>"><span
                        class="am-icon-plus"></span>新建作品</a>
                <a type="button" class="am-btn am-btn-default"
                   href="<c:url value="/basic/xm.do?qm=viewMaster&id=${masterId}"/>"><span
                        class="am-icon-plus"></span>返回大师页面</a>
            </div>
        </div>
    </div>


    <div class="am-g">
        <div class="am-u-sm-12">
                <table class="am-table am-table-striped am-table-hover table-main">
                    <thead>
                    <tr>
                        <th class="table-set">操作</th>
                        <th class="table-title">名字</th>
                        <th class="table-title">作者</th>
                        <th class="table-title">作品图</th>

                    </tr>
                    </thead>
                    <tbody>

                    <c:forEach items="${requestScope.pageInfo.list}" var="masterWork">
                        <tr id="${masterWork.id}">
                            <td>
                                <div class="am-btn-toolbar">
                                    <div class="am-btn-group am-btn-group-xs">
                                        <a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="<c:url value="/basic/xm.do?qm=formMasterWork&id=${masterWork.id}&masterId=${masterWork.master.id}&projectId=${masterWork.project.id}"/>"><span
                                                class="am-icon-pencil-square-o"></span> 编辑
                                        </a>
                                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="removeMasterWork('${masterWork.id}')" href="#"><span
                                                class="am-icon-trash-o"></span> 删除
                                        </a>
                                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"  href="
                                        <c:url value="/basic/xm.do?qm=saveOrUpdateMasterWorkRecommended&project.id=${projectId}&master.id=${masterId}&masterWork.id=${masterWork.id}
                                        &resultPage=/basic/xm.do?qm=plistMasterWork_byProject&conditions=project.id:${projectId}&projectId=${projectId}&masterId=${masterId}"/>
                                        "><span
                                                class="am-icon-heart"></span> 推荐
                                        </a>
                                    </div>
                                </div>
                            </td>
                            <td class="am-hide-sm-only"><a href="<c:url value="/basic/xm.do?qm=viewMasterWork&id=${masterWork.id}"/>">${masterWork.name}</a></td>
                            <td class="am-hide-sm-only">
                               ${masterWork.master.fullName}
                                <a>
                                    <c:if test="${not empty masterWork.masterWorkRecommendedList}">
                                       推荐
                                    </c:if>
                                </a>
                            </td>
                            <td class="am-hide-sm-only">${masterWork.productDescription.content}</td>
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
</div>
<script>

    function removeMasterWork(divId){
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeMasterWork"/>',
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
