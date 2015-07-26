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
<div id="page-nav">
  <p><a href="<c:url value="/"/>">首页</a><span>作品</span></p>
</div>
<div class="border-nav"></div>
<!--作品内容-->
<div id="center--1">
  <div class="center-buttom">
<%--    <C:forEach items="${productTenantCatalogValueList}" var="productTenantCatalogValue">
      <a href="#"><button class="button">${productTenantCatalogValue.value}</button></a>
    </C:forEach>--%>
    <c:forEach items="${tenantProjectList}" var="tenantProject">
      <div class="center-buttom-1-or">
        <h1>${tenantProject.project.name}</h1>
        <c:forEach items="${tenantProject.project.projectTagList}" var="projectTag">
          <a href="#"><button class="button">${projectTag.value}</button></a>
        </c:forEach>
      </div>
    </c:forEach>
  </div>
  <div class="center-right">
    <c:forEach items="${tenantWorkList}" var="tenantWork" varStatus="vs">
      <c:if test="${tenantWorkList.size()-1 != vs.index && vs.index%3 == 0}">
        <div class="works-container">
          <a href="<c:url value="/work/${tenantWork.id}"/>" target="_blank"><img src="http://tenant.efeiyi.com/${tenantWork.pictureUrl}@!tenant-pc-work" class="works-img"></a>
        </c:if>
       <c:if test="${tenantWorkList.size()-1 != vs.index && vs.index%3==1}">
         <a href="<c:url value="/work/${tenantWork.id}"/>" target="_blank"><img src="http://tenant.efeiyi.com/${tenantWork.pictureUrl}@!tenant-pc-work" class="works-img"></a>
       </c:if>
      <c:if test="${ vs.index%3==2}">
          <a href="<c:url value="/work/${tenantWork.id}"/>" target="_blank"><img src="http://tenant.efeiyi.com/${tenantWork.pictureUrl}@!tenant-pc-work" class="works-img-1"></a>
    </div>
      </c:if>
      <c:if test="${tenantWorkList.size()-1 == vs.index && vs.index%3 == 0}">
      <div class="works-container">
        <a href="<c:url value="/work/${tenantWork.id}"/>" target="_blank"><img src="http://tenant.efeiyi.com/${tenantWork.pictureUrl}@!tenant-pc-work" class="works-img"></a>
        </div>
      </c:if>
      <c:if test="${tenantWorkList.size()-1 == vs.index && vs.index%3 == 1}">
      <a href="<c:url value="/work/${tenantWork.id}"/>" target="_blank"><img src="http://tenant.efeiyi.com/${tenantWork.pictureUrl}@!tenant-pc-work" class="works-img"></a>
        </div>
      </c:if>
      </c:forEach>
    <!--页码-->
  </div>
</div>
<ming800:pcPageList bean="${pageEntity}" url="${pageContext.request.contextPath}/work/listTenantWork.do">
  <%--<ming800:page-param2 name="qm" value="${requestScope.qm}"/>--%>
  <ming800:pcPageParam name="conditions"
                       value='<%=request.getParameter("conditions")!=null ? request.getParameter("conditions") : ""%>'/>
  <ming800:pcPageParam name="sort"
                       value='<%=request.getParameter("sort")!=null ? request.getParameter("sort") : ""%>'/>
</ming800:pcPageList>
<!--其他内容-->
</body>
</html>