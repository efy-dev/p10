<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/25
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title></title>
    <script type="text/javascript" src="<c:url value='/scripts/recommended.js'/>"></script>
    <script>
        function removeTenant(divId){
            $.ajax({
                type: "get",
                url: '<c:url value="/basic/xmj.do?qm=removeTenant"/>',
                cache: false,
                dataType: "json",
                data:{id:divId},
                success: function (data) {
                    $("#"+divId).remove();
                }
            });
        }
    </script>
</head>
<body>
<security:authorize ifAnyGranted="admin,operational,c_operational">
        <div style="text-align: left;margin-bottom: 10px">
            <a type="button" class="am-btn am-btn-default am-btn-xs" href="<c:url value="/basic/xm.do?qm=formEnterpriseTenant"/>"><span class="am-icon-plus"></span>新建企业商家</a>
            <a type="button" class="am-btn am-btn-default am-btn-xs" href="<c:url value="/basic/xm.do?qm=formPrivateTenant"/>"><span class="am-icon-plus"></span>新建个体商家</a>
            <a type="button" class="am-btn am-btn-default am-btn-xs" href="<c:url value="/basic/xm.do?qm=formPersonalTenant"/>"><span class="am-icon-plus"></span>新建个人商家</a>
        </div>
</security:authorize>
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
<div class="admin-content">
    <div class="am-g">

        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
                    <th class="table-set">操作</th>
                    <th class="table-title">商家名称</th>
                    <th class="table-title">商家类型</th>
                </tr>
                </thead>
                <tbody>

                <c:forEach items="${requestScope.pageInfo.list}" var="tenant">
                    <tr id="${tenant.id}">
                        <td>
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">
                                    <security:authorize ifAnyGranted="admin,operational,c_operational">
                                    <a class="am-btn am-btn-default am-btn-xs am-text-secondary"
                                       href="<c:url value="/basic/xm.do?qm=formTenant&id=${tenant.id}"/>"><span
                                            class="am-icon-pencil-square-o"></span> 编辑
                                    </a>
                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                       onclick="showConfirm('提示','是否删除',function(){removeTenant('${tenant.id}')})" href="#"><span
                                            class="am-icon-trash-o"></span>删除
                                    </a>
                                    </security:authorize>
                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                    href="<c:url value="/basic/xm.do?qm=plistTENANTProduct_default&view=tenant&conditions=tenant.id:${tenant.id}&tenantId=${tenant.id}"/>"><span
                                            class="am-icon-trash-o"></span> 查看商品列表
                                    </a>
                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                       href="<c:url value="/basic/xm.do?qm=plistTenantCategory_default&conditions=tenant.id:${tenant.id}&tenantId=${tenant.id}"/>"><span
                                            class="am-icon-trash-o"></span> 店铺类别
                                    </a>

                                    <c:if test="${tenant.tenantType == '11'}">
                                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                           href="<c:url value="/basic/xm.do?qm=formEnterprisesTenant&id=${tenant.id}"/>" >
                                            <span class="am-icon-heart">完善信息</span>
                                        </a>
                                    </c:if>
                                    <c:if test="${tenant.tenantType == '12'}">
                                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                           href="<c:url value="/basic/xm.do?qm=formPrivaterTenant&id=${tenant.id}"/>" >
                                            <span class="am-icon-heart">完善信息</span>
                                        </a>
                                    </c:if>
                                    <c:if test="${tenant.tenantType == '13'}">
                                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                           href="<c:url value="/basic/xm.do?qm=formPersonTenant&id=${tenant.id}"/>" >
                                            <span class="am-icon-heart">完善信息</span>
                                        </a>
                                    </c:if>
                                    <security:authorize ifAnyGranted="admin,operational,c_operational">
                                        <c:if test="${tenant.review=='4'}">
                                            <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                               href="<c:url value="/basic/xm.do?qm=formTenantReview&tenantId=${tenant.id}&review=${tenant.review}"/>"  >
                                                <span class="am-icon-heart">审核成功</span>
                                            </a>
                                        </c:if>
                                        <c:if test="${tenant.review!='4'}">
                                            <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                               href="<c:url value="/basic/xm.do?qm=formTenantReview&tenantId=${tenant.id}&review=${tenant.review}"/>" >
                                                <span class="am-icon-heart">审核</span>
                                            </a>
                                        </c:if>
                                    <c:if test="${empty tenant.tenantRecommendedList}">
                                        <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                           onclick="recommended(this,1,'<c:url value="/Recommended/deleteObjectRecommended.do" />')"
                                           href="#" recommend="1" recommendedId = "${tenant.id}" id="" >
                                            <span class="am-icon-heart"> 推荐</span>
                                        </a>
                                    </c:if>
                                    <c:if test="${not empty tenant.tenantRecommendedList}">
                                        <c:forEach var="recommended" items="${tenant.tenantRecommendedList}">
                                            <c:if test="${recommended.tenant.id == tenant.id}">
                                                <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                                   href="#"  onclick="recommended(this,1,'<c:url value="/Recommended/deleteObjectRecommended.do" />')" recommendedId = "${tenant.id}"  id="${recommended.id}" recommend="0">
                                                    <span class="am-icon-heart" >取消推荐 </span>
                                                </a>
                                            </c:if>
                                        </c:forEach>

                                    </c:if>
                                     <span style="display: none;float: left;padding-left: 10px;">
                                                <input type="text" name="sort" style="width: 35px;" value="" />
                                                <a class=" am-btn-primary" onclick="saveRecommended(this,'tenantRecommended',1,'<c:url value="/Recommended/saveObjectRecommended.do" />')" style="padding: 0px 10px 5px 10px" > 保存</a>
                                       </span>
                                    </security:authorize>
                                </div>
                            </div>
                        </td>
                        <td class="am-hide-sm-only">
                            <a href="<c:url value="/basic/xm.do?qm=viewTenant&view=tenantList&id=${tenant.id}"/>">${tenant.name}</a>
                            <c:forEach var="recommended" items="${tenant.tenantRecommendedList}">
                                <c:if test="${recommended.tenant.id == tenant.id}" >
                                    <span  id="${recommended.id}" style="margin-left: 5px;color: red;"> 推荐</span>
                                </c:if>
                            </c:forEach>
                        </td>
                        <td class="am-hide-sm-only">
                            <c:if test="${tenant.tenantType == '11'}">
                                  企业
                            </c:if>
                            <c:if test="${tenant.tenantType == '12'}">
                                个体
                            </c:if>
                            <c:if test="${tenant.tenantType == '13'}">
                                个人
                            </c:if>
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
</body>
</html>
