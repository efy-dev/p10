<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
</head>
<body>
<div class="wh">
    <div class="hd">
        <div id="page-nav">
            <p><a href="<c:url value="/"/>">首页</a><span>资讯</span></p>
        </div>
    </div>
</div>
<!--资讯内容-->
<div class="wh">
    <div class="hd">
        <div id="page-column">
            <div class="column-left" style="">
                <div class="page-img"><img src="http://tenant.efeiyi.com/${tenant.favicon}@!tenant-pc-favicon"></div>
            </div>
            <div id="center--1" style="width: 688px;">
                <c:if test="${tenantInfoList != null && tenantInfoList.size() > 0}">
                    <div class="center-right">
                        <c:forEach items="${tenantInfoList}" var="tenantInfo" varStatus="vs">
                            <div class="alllist">
                                <div class="alllist-content">
                                    <div class="alllist-time">
                                        <h1><fmt:formatDate value="${tenantInfo.createDateTime}" pattern="dd/MM" />
                                        </h1>
                                        <p><fmt:formatDate value="${tenantInfo.createDateTime}" pattern="yyyy" /></p>
                                    </div>
                                    <div class="alllist-xq">
                                        <h1><a href="<c:url value="/info/${tenantInfo.id}"/>" target="_blank">
                                            <c:forEach items="${tenantInfo.masterNewsTagList}" var="masterNewsTag">
                                                [${masterNewsTag.wordValue.value}]
                                            </c:forEach>
                                                ${tenantInfo.title}</a></h1>
                                        <p>${tenantInfo.brief}</p>
                                        <span><a href="<c:url value="/info/${tenantInfo.id}"/>" target="_blank">详情</a></span>
                                    </div>
                                </div>
                                <div class="alllist-border"></div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="pages wh" style="width: 688px;min-width: 688px">
                        <ming800:pcPageList bean="${pageEntity}" url="${pageContext.request.contextPath}/info/list">
                            <%--<ming800:page-param2 name="qm" value="${requestScope.qm}"/>--%>
                            <ming800:pcPageParam name="conditions"
                                                 value='<%=request.getParameter("conditions")!=null ? request.getParameter("conditions") : ""%>'/>
                            <ming800:pcPageParam name="sort"
                                                 value='<%=request.getParameter("sort")!=null ? request.getParameter("sort") : ""%>'/>
                        </ming800:pcPageList>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>
<!--其他内容-->
</body>
</html>
