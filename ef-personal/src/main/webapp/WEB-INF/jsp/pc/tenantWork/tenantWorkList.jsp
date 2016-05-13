<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head></head>
<body>
<!--作品-->
<div class="wh">
    <div class="hd">
        <div id="page-nav">
            <p><a href="<c:url value="/"/>">首页</a><span>作品</span></p>
        </div>
    </div>
</div>
<!--作品内容-->

<div class="wh">
    <div class="hd">
        <div id="page-column">
            <div class="column-left" style="">
                <div class="page-img"><img src="http://tenant.efeiyi.com/${tenant.favicon}@!tenant-pc-favicon"></div>
            </div>
            <div id="center--1" style="width: 688px;float:left">
                <div class="center-right wh">
                    <c:forEach items="${tenantWorkList}" var="masterWork" varStatus="vs">
                    <c:if test="${tenantWorkList.size()-1 != vs.index && vs.index%3 == 0}">
                    <div class="works-container wh">
                        <a href="<c:url value="/work/${masterWork.id}"/>" target="_blank" class="works-img">
                            <img src="http://tenant.efeiyi.com/${masterWork.pictureUrl}@!tenant-pc-work" class="works-img">
                            <p>${masterWork.name}</p>
                        </a>
                        </c:if>
                        <c:if test="${tenantWorkList.size()-1 != vs.index && vs.index%3==1}">
                            <a href="<c:url value="/work/${masterWork.id}"/>" target="_blank" class="works-img">
                                <img src="http://tenant.efeiyi.com/${masterWork.pictureUrl}@!tenant-pc-work" class="works-img">
                                <p>${masterWork.name}</p>
                            </a>
                        </c:if>
                        <c:if test="${ vs.index%3==2}">
                        <a href="<c:url value="/work/${masterWork.id}"/>" target="_blank" class="works-img">
                            <img src="http://tenant.efeiyi.com/${masterWork.pictureUrl}@!tenant-pc-work" class="works-img">
                            <p>${masterWork.name}</p>
                        </a>
                    </div>
                    </c:if>
                    <c:if test="${tenantWorkList.size()-1 == vs.index && vs.index%3 == 0}">
                        <div class="works-container wh">
                            <a href="<c:url value="/work/${masterWork.id}"/>" target="_blank" class="works-img">
                                <img src="http://tenant.efeiyi.com/${masterWork.pictureUrl}@!tenant-pc-work" class="works-img">
                                <p>${masterWork.name}</p>
                            </a>
                        </div>
                    </c:if>
                    <c:if test="${tenantWorkList.size()-1 == vs.index && vs.index%3 == 1}">
                    <a href="<c:url value="/work/${masterWork.id}"/>" target="_blank" class="works-img">
                        <img src="http://tenant.efeiyi.com/${masterWork.pictureUrl}@!tenant-pc-work" class="works-img">
                        <p>${masterWork.name}</p>
                    </a>
                </div>
                </c:if>
                </c:forEach>
                <!--页码-->
                <div class="pages wh" style="width: 688px;min-width: 688px">
                    <ming800:pcPageList bean="${pageEntity}" url="${pageContext.request.contextPath}/work/list">
                        <%--<ming800:page-param2 name="qm" value="${requestScope.qm}"/>--%>
                        <ming800:pcPageParam name="conditions"
                                             value='<%=request.getParameter("conditions")!=null ? request.getParameter("conditions") : ""%>'/>
                        <ming800:pcPageParam name="sort"
                                             value='<%=request.getParameter("sort")!=null ? request.getParameter("sort") : ""%>'/>
                    </ming800:pcPageList>
                </div>
            </div>
        </div>
    </div>
</div>
<!--其他内容-->
</div>
<!--其他内容-->
</body>
</html>