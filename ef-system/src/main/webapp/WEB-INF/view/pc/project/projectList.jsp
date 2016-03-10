<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 14:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>

<html>
<head>
    <script src="<c:url value="/scripts/jquery-1.11.1.min.js"/>"></script>
    <title></title>
</head>
<body>
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
<div class="am-g">
    <div class="am-u-sm-12">
        <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
            <tr>
                <th class="table-set">操作</th>
                <th class="table-title">项目名称</th>
                <th class="table-title">项目编号</th>

            </tr>
            </thead>
            <tbody>

            <c:forEach items="${objectList}" var="project">
                <tr>
                    <td>
                        <div class="am-btn-toolbar">
                            <div class="am-btn-group am-btn-group-xs">
                                <c:if test="${!empty master}">
                                    <a class="am-btn am-btn-default am-btn-xs am-text-secondary"
                                       href="<c:url value="/basic/xm.do?qm=saveOrUpdateMasterProject&master.id=${masterId}&project.id=${project.id}&status=1&resultPage=redirect:%2Fbasic%2Fxm.do%3Fqm%3DformMaster%26id%3D${masterId}"/>"><span
                                            class="am-icon-pencil-square-o"></span> 新建为传承人主项目
                                    </a>
                                </c:if>
                                <c:if test="${empty master}">
                                    <a class="am-btn am-btn-default am-btn-xs am-text-secondary"
                                       href="<c:url value="/basic/xm.do?qm=saveOrUpdateMasterProject&master.id=${masterId}&project.id=${project.id}&status=2&resultPage=redirect:%2Fbasic%2Fxm.do%3Fqm%3DformMaster%26id%3D${masterId}"/>"><span
                                            class="am-icon-pencil-square-o"></span> 新建为传承人项目
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </td>
                    <td class="am-hide-sm-only">${project.name}</td>
                    <td class="am-hide-sm-only">${project.serial}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
