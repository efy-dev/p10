<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>资讯</title>
<script type="text/javascript">
    function redirect(){

    }
</script>
</head>
<body>
<div id="page-nav">
    <p><a href="${pageContext.request.contextPath}/tenant/${tenant.id}">首页</a><span>资讯</span></p>
</div>
<div class="border-nav"></div>
<!--资讯内容-->
<div id="center--1">
    <div class="center-buttom">
        <c:forEach items="${tagList}" var="tag" >
            <a href="javascript:void(0)" onclick="redirect();"><button class="button">${tag.value}</button></a>
        </c:forEach>
    </div>
    <div class="center-right">
        <C:forEach items="${tenantInfoList}" var="tenantInfo" varStatus="vs">
            <div class="alllist">
                <div class="alllist-content">
                    <div class="alllist-time">
                        <h1><fmt:formatDate value="${tenantInfo.createDateTime}" pattern="dd/MM" />
                        </h1>
                        <p><fmt:formatDate value="${tenantInfo.createDateTime}" pattern="yyyy" /></p>
                    </div>
                    <div class="alllist-xq">
                        <h1><a href="<c:url value="/tenantInfo/${tenantInfo.id}"/>">${tenantInfo.title}</a></h1>
                        <p>
                            <c:choose>
                                <c:when test="${fn:length(tenantInfo.content)  > 60}">
                                    ${fn:substring(tenantInfo.content,0 ,60 ) }......
                                </c:when>
                                <c:otherwise>
                                    ${tenantInfo.content}
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <span><a href="<c:url value="/tenantInfo/${tenantInfo.id}"/>">详情</a></span>
                    </div>
                </div>
                <div class="alllist-border"></div>
            </div>
        </C:forEach>
    </div>
</div>
<ming800:pcPageList bean="${pageEntity}" url="/tenantInfo/listTenantInfo.do">
    <%--<ming800:page-param2 name="qm" value="${requestScope.qm}"/>--%>
    <ming800:pcPageParam name="conditions"
                         value='<%=request.getParameter("conditions")!=null ? request.getParameter("conditions") : ""%>'/>
    <ming800:pcPageParam name="sort"
                         value='<%=request.getParameter("sort")!=null ? request.getParameter("sort") : ""%>'/>
</ming800:pcPageList>
<!--其他内容-->
</body>
</html>
