<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/10/13
  Time: 14:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="list-news">
  <div class="title">非遗要闻</div>
  <ul class="ul-items">
    <c:forEach items="${IndustryList}" var="industry">
      <li>
        <c:if test="${empty industry.documentAttachmentList}">
          <a href="javascript:void(0)" onclick="homeMatchJNodes('${industry.id}', 7,'SubordinateInstitutionManagement')" title="">
            <img src="<c:url value='/shop2015/upload/exp1.jpg'/>" alt=""/>
          </a>
        </c:if>
        <c:if test="${not empty industry.documentAttachmentList}">
          <c:forEach items="${industry.documentAttachmentList}" var="att" end="0">
            <a href="javascript:void(0)" onclick="homeMatchJNodes('${industry.id}', 7,'SubordinateInstitutionManagement')" title="">
              <img src="${att.path}" alt=""/>
            </a>
          </c:forEach>
        </c:if>
        <p class="name" style="width: 90%;">
          <a href="javascript:void(0)" onclick="homeMatchJNodes('${industry.id}', 7,'SubordinateInstitutionManagement')" title="${industry.title}">${industry.title}</a>
        </p>
        <p class="info">${industry.sampleContent}</p>
        <a href="<c:url value='/news/news.do?qm=plistNewsIndustry_default'/>" class="btn-more" title="阅读更多">阅读更多</a>
      </li>
    </c:forEach>
  </ul>
</div>
