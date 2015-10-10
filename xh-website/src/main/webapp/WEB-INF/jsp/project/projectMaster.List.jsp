<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/10/8
  Time: 15:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>

<div id="show" class="list-table">
    <table>
        <tr>
            <td>非物质文化遗产名称</td>
            <td>传承人</td>
            <td>类别</td>
        </tr>
        <c:forEach items="${objectList}" var="masterProject">
            <tr>
                <td>${masterProject.project.name}</td>
                <td>${masterProject.master.fullName}</td>
                <td><ming800:status name="level"
                                    dataType="MasterProject.type"
                                    checkedValue="${masterProject.project.type}"
                                    type="normal"/></td>
            </tr>
        </c:forEach>
    </table>
</div>
</div>
<div class="pages wh">
    <ul class="am-pagination am-pagination-centered">
        <div style="clear: both">
            <c:url value="/project/project.master.do" var="url"/>
            <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
                <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
                <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
                <ming800:pcPageParam name="type" value="${type}"/>
                <ming800:pcPageParam name="provinceid" value="${provinceid}"/>
            </ming800:pcPageList>
        </div>
    </ul>
</div>