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

<html>
<head>
    <title></title>
    <script type="text/javascript" src="<c:url value='/scripts/recommended.js'/>"></script>
</head>
<body>
<div class="admin-content">
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-6">
            <div class="am-btn-toolbar">
                <div class="am-btn-group am-btn-group-xs">
                    <a type="button" class="am-btn am-btn-default" href="<c:url value="/basic/xm.do?qm=plistMaster_default&list=master&conditions=status:1"/>"><span class="am-icon-plus"></span>新建推荐传承人</a>
                </div>
            </div>
        </div>
        <div class="am-u-sm-12">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
                    <th class="table-set">操作</th>
                    <th class="table-title">排序</th>
                    <th class="table-title">中文姓名</th>
                    <th class="table-title">性别</th>
                    <th class="table-title">等级</th>
                    <th class="table-title">类型</th>
                </tr>
                </thead>
                <tbody>

                <c:forEach items="${requestScope.pageInfo.list}" var="masterRecommended">
                    <c:if test="${masterRecommended.group != 'ec.masterRecommended'}">
                    <tr id="${masterRecommended.id}">
                        <td>
                            <div class="am-btn-toolbar">
                                <div class="am-btn-group am-btn-group-xs">
                                    <a class="am-btn am-btn-default am-btn-xs am-text-secondary"
                                       href="<c:url value="/basic/xm.do?qm=formMaster&from=recommendMaster&id=${masterRecommended.master.id}"/>"><span
                                            class="am-icon-pencil-square-o"></span> 编辑
                                    </a>
                                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                       onclick="deleteObjectRecommended('${masterRecommended.id}','<c:url value="/Recommended/deleteObjectRecommended.do" />')" href="#"><span
                                            class="am-icon-trash-o"></span> 取消推荐
                                    </a>
                                </div>
                            </div>
                        </td>
                        <td class="am-hide-sm-only">
                            <a href="#" onclick="toUpdateSort(this,'<c:url value="/Recommended/updateSort.do"/>')" sort="${masterRecommended.sort}" id="${masterRecommended.id}">
                              ${masterRecommended.sort}
                            </a>
                        </td>
                        <td class="am-hide-sm-only"><a href="<c:url value="/basic/xm.do?qm=viewMaster&view=recommendMaster&id=${masterRecommended.master.id}"/>">${masterRecommended.master.fullName}</a></td>

                        <td class="am-hide-sm-only">
                            <ming800:status name="sex" dataType="Master.sex" checkedValue="${masterRecommended.master.sex}" type="normal"/>
                        </td>
                        <td class="am-hide-sm-only">
                            <ming800:status name="level" dataType="Master.level" checkedValue="${masterRecommended.master.level}" type="normal" />
                        </td>
                        <td class="am-hide-sm-only">
                            <c:if test="${masterRecommended.group == 'masterSkillRecommended'}">
                                传统技艺
                            </c:if>
                            <c:if test="${masterRecommended.group == 'masterArtRecommended'}">
                                传统美术
                            </c:if>
                        </td>
                    </tr>
                    </c:if>
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







</script>
</body>
</html>
