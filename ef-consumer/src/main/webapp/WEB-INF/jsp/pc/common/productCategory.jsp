<%@ page import="com.ming800.core.p.PConst" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/18
  Time: 16:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<span class="bgbor"></span>

<div class="nav-links" style="display:none;">
    <c:forEach items="${categoryList}" var="category">
        <ul>
            <li class="title">${category.name}</li>
            <c:forEach items="${projectMap.get(category.id)}" var="project">
                <li><a href="<%=PConst.HOSTNAME%>/product/list/${project.id}" target="_blank" title="">${project.name}</a></li>
            </c:forEach>

        </ul>
    </c:forEach>

</div>
