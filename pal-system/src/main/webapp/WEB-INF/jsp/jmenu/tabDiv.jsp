<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ming
  Date: 12-11-10
  Time: 上午11:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/layouts/public.jsp"%>
<script type="text/javascript" src="<c:url value="/scripts/doQuery.js?m=2.4"/>"></script>
<div class="am-tabs" data-am-tabs="{noSwipe: 1}" id="doc-tab-demo-1">
    <ul class="am-tabs-nav am-nav am-nav-tabs">
        <c:forEach items="${doQueryList}" var="doQuery">
            <c:if test="${tabTitle==doQuery.label}">
                <li class="am-active"><a href="javascript: void(0)">${doQuery.label}</a></li>
            </c:if>
            <c:if test="${tabTitle!=doQuery.label}">
                <li><a href="javascript: void(0)">${doQuery.label}</a></li>
            </c:if>
        </c:forEach>
    </ul>
    <div class="am-tabs-bd">
        <c:forEach items="${doQueryList}" var="doQuery">
            <c:if test="${tabTitle==doQuery.label}">
                <div class="am-tab-panel am-active" id="${doQuery.name}">
                </div>
            </c:if>
            <c:if test="${tabTitle!=doQuery.label}">
                <div class="am-tab-panel" id="${doQuery.name}">
                </div>
            </c:if>
        </c:forEach>
    </div>
</div>
<br/>
<script>
    <c:forEach items="${doQueryList}" var="doQuery">
    generateCondition('<c:url value="<%=basePath%>"/>','<c:url value="/do/listCondition.do"/>','${doQuery.name}', '${requestScope.tempDo.name}', '${doQuery.label}', '${requestScope.conditions}', '${requestScope.tempDo.xentity.model}', '${doQuery.label}')
    </c:forEach>
</script>
