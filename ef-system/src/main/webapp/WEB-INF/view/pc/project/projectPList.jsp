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
<table class="am-table am-table-bordered am-table-radius am-table-striped" >
    <tr style="text-align: left">

        <td width="74%">项目名称</td>
        <td width="">项目编号</td>
    </tr>


    <c:forEach items="${requestScope.pageInfo.list}" var="project">
        <tr style="text-align: left">

            <td width="10%">
                <c:if test="${project.level == 1}">
                    <a href="/basic/xm.do?qm=plistProject_default&conditions=fatherProjectId:${project.id};level:2" >
                      ${project.name}
                    </a>
                </c:if>
                <c:if test="${project.level == 2}">
                    <a href="/basic/xm.do?qm=plistProject_default&conditions=fatherProjectId:${project.id};level:3" >
                      ${project.name}
                    </a>
                </c:if>
                <c:if test="${project.level == 3}">
                    <a href="#" >${project.name}</a>
                </c:if>
            </td>
            <td>
                ${project.serial}
            </td>
        </tr>

    </c:forEach>
</table>
<div style="clear: both">
    <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="/basic/xm.do">
        <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
        <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
    </ming800:pcPageList>
</div>

</body>
</html>
