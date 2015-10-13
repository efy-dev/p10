<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/10/13
  Time: 15:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="part">
  <div class="title">协会新闻</div>
  <ul class="ul-list">
    <c:forEach items="${OrgNewsList}" var="orgNews">
      <li>
        <c:if test="${empty orgNews.documentAttachmentList}">
          <a href="javascript:void(0)" onclick="homeMatchJNodes('${orgNews.id}', 6,'SubordinateInstitutionManagement')" title="">
            <img src="<c:url value='/shop2015/upload/exp5.jpg'/>" alt=""/>
          </a>
        </c:if>
        <c:if test="${not empty orgNews.documentAttachmentList}">
          <c:forEach items="${note.documentAttachmentList}" var="att" end="1">
            <a href="javascript:void(0)" onclick="homeMatchJNodes('${orgNews.id}', 6,'SubordinateInstitutionManagement')" title="">
              <img src="${att.path}" alt=""/>
            </a>
          </c:forEach>
        </c:if>
        <p>
          <a href="javascript:void(0)" onclick="homeMatchJNodes('${orgNews.id}', 6,'SubordinateInstitutionManagement')" target="_parent">${orgNews.title}</a>
        </p>
        <a class="btn-more" href="<c:url value='/news/news.do?qm=plistNewsOrganization_default'/>" title="更多">更多</a>
      </li>
    </c:forEach>
  </ul>
</div>
