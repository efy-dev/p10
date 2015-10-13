<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/10/8
  Time: 18:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<div class="wh sjape">
    <div class="tbar">项目类别：</div>
    <ul id="type">
        <li><a href="#" title="" <c:if test="${type == -1}">class="active"</c:if> target="_self" onclick="typeClick(this, '-1');" id="-1">全部</a></li>
        <c:forEach items="${stringList}" var="type">
            <li><a href="#" title="" target="_self" id="${type}" <c:if test="${type == requestScope.type}"> class="active" </c:if>
                   onclick="typeClick(this, '${type}');"><ming800:status name="level"
                                                                                 dataType="Project.type"
                                                                                 checkedValue="${type}"
                                                                                 type="normal"/></a></li>
        </c:forEach>
    </ul>
</div>
</div>