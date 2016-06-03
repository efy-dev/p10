<!doctype html>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="no-js">
<head>
    <title>${tenant.fullName}-资讯列表</title>
</head>
<body>
<!--输入内容--><%--
<div class="am-g am-color-000 ">
    <c:forEach items="${tagList}" var="tag">
    <div class="am-u-sm-4 an-mg-top am-u-end"><button type="button" class="am-btn am-btn-default">${tag.value}</button></div>
    </c:forEach>
</div>--%>
<!--1-->
<section class="vessel">
<c:forEach items="${tenantInfoList}" var="tenantInfo" varStatus="vs">
    <div class="message-text">
        <h1>
            <c:forEach items="${tenantInfo.masterNewsTagList}" var="masterNewsTag">
                [${masterNewsTag.wordValue.value}]
            </c:forEach>
                ${tenantInfo.title} </h1>
        <p id="message-text-p">
            <fmt:formatDate value="${tenantInfo.createDateTime}" pattern="yyyy-MM-dd"/>
        </p>
        <%--<p> <c:choose>--%>
            <%--<c:when test="${fn:length(tenantInfo.content)  > 60}">--%>
                <%--${fn:substring(tenantInfo.content,0 ,60 ) }......--%>
            <%--</c:when>--%>
            <%--<c:otherwise>--%>
                <%--${tenantInfo.content}--%>
            <%--</c:otherwise>--%>
        <%--</c:choose>--%>
        <%--</p>--%>
        <p>${tenantInfo.brief}</p>
        <span><a href="<c:url value="/info/${tenantInfo.id}"/>">详情</a></span>
        <hr data-am-widget="divider" style="" class="am-divider am-divider-dashed"/>
    </div>
    </c:forEach>
</section>
</body>
</html>
