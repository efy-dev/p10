<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/10/8
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="wh theme">
    <div class="tbar">申报地区：</div>
    <ul id="pro">
        <li><a href="#" <c:if test="${provinceid == -1}">class="active"</c:if> onclick="provinceClick(this, '-1')" title="" id="-1">全部</a></li>
        <c:forEach items="${objectList}" var="province">
            <li><a href="#" title="" target="_self" id="${province.id}" <c:if
                    test="${province.id == provinceid}"> class="active" </c:if>
                   onclick="provinceClick(this, '${province.id}');">${province.name}</a></li>
        </c:forEach>
    </ul>
</div>
