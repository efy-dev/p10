<%@ page import="java.util.HashMap" %>
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

    <%--<c:forEach items="${requestScope.pageInfo.list}" var="tenantProduct">--%>
        <%--<tr>--%>
            <%--<td>${tenantProduct.id}</td>--%>
            <%--<td>${tenantProduct.name}</td>--%>
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
                   href="<c:url value="/basic/xm.do?qm=formTenantWork&tenantId=${tenantId}&projectId=${projectId}"/>"><span
                        class="am-icon-plus"></span>新建作品</a>
                <a type="button" class="am-btn am-btn-default"
                   href="<c:url value="/basic/xm.do?qm=viewTenant&id=${tenantId}"/>"><span
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
                        <th class="table-title">作品封面</th>

                    </tr>
                    </thead>
                    <tbody>

                    <c:forEach items="${requestScope.pageInfo.list}" var="tenantWork">
                        <tr id="${tenantWork.id}">
                            <td>
                                <div class="am-btn-toolbar">
                                    <div class="am-btn-group am-btn-group-xs">
                                        <a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="<c:url value="/basic/xm.do?qm=formTenantWork&id=${tenantWork.id}&tenantId=${tenantWork.tenant.id}&projectId=${tenantWork.project.id}"/>"><span
                                                class="am-icon-pencil-square-o"></span> 编辑
                                        </a>
                                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="removeTenantWork('${tenantWork.id}')" href="#"><span
                                                class="am-icon-trash-o"></span> 删除
                                        </a>
                                            <c:if test="${empty tenantWork.tenantWorkRecommendedList}">
                                               <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                                  href="<c:url value="/basic/xm.do?qm=saveOrUpdateTenantWorkRecommended&project.id=${projectId}&status=1&tenant.id=${tenantId}&tenantWork.id=${tenantWork.id}&resultPage=redirect:/basic/xm.do?qm=plistTenantWork_byProject%26conditions=project.id:${projectId}%26projectId=${projectId}%26tenantId=${tenantId}"/>">
                                                   <span class="am-icon-heart"> </span>推荐
                                               </a>
                                            </c:if>
                                            <c:if test="${not empty tenantWork.tenantWorkRecommendedList}">
                                                <c:forEach var="re" items="${tenantWork.tenantWorkRecommendedList}">
                                                    <c:if test="${re.tenantWork.id == tenantWork.id}">
                                                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                                           href="#"  onclick="removeTenantWorkRecommended('${re.id}')">
                                                            <span class="am-icon-heart">取消推荐 </span>
                                                        </a>
                                                    </c:if>
                                                </c:forEach>

                                            </c:if>
                                    </div>
                                </div>
                            </td>
                            <td class="am-hide-sm-only">
                                 <a href="<c:url value="/basic/xm.do?qm=viewTenantWork&id=${tenantWork.id}"/>">
                                    ${tenantWork.name}
                                 </a>
                                  <a style="margin-left: 10px;color: red;" >
                                    <c:forEach var="re" items="${tenantWork.tenantWorkRecommendedList}">
                                        <c:if test="${re.tenantWork.id == tenantWork.id}" >
                                           <span class="am-icon-heart" id="${re.id}"> 推荐</span>
                                        </c:if>
                                    </c:forEach>
                                </a>
                            </td>
                            <td class="am-hide-sm-only">
                               ${tenantWork.tenant.fullName}
                            </td>
                            <td class="am-hide-sm-only">
                                <a href="/Img/imgUrl.do?imgUrl=http://tenant.efeiyi.com/${tenantWork.pictureUrl}">
                                  <img  width="10%"  src="http://tenant.efeiyi.com/${tenantWork.pictureUrl}@!tenant-manage-banner" >
                                </a>
                            </td>
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
<script type="text/javascript">

    function removeTenantWorkRecommended(divId){

        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeTenantWorkRecommended"/>',
            cache: false,
            dataType: "json",
            data:{id:divId},
            success: function (data) {
              location.reload();
            }
        });
    }

    function removeTenantWork(divId){
        $.ajax({
            type: "get",
            url: '<c:url value="/basic/xmj.do?qm=removeTenantWork"/>',
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
