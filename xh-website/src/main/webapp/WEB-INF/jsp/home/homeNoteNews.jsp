<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/10/13
  Time: 14:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="list-news list-news2">
  <div class="title">重要通知</div>
  <ul class="ul-items">
    <c:forEach items="${NoteList}" var="note">
      <li>
        <c:if test="${empty note.documentAttachmentList}">
          <a href="javascript:void(0)" onclick="homeMatchJNodes('${note.id}', 8,'SubordinateInstitutionManagement')" title="">
            <img src="<c:url value='/shop2015/upload/exp1.jpg'/>" alt=""/>
          </a>
        </c:if>
        <c:if test="${not empty note.documentAttachmentList}">
          <c:forEach items="${note.documentAttachmentList}" var="att" end="0">
            <a href="javascript:void(0)" onclick="homeMatchJNodes('${note.id}', 8,'SubordinateInstitutionManagement')" title="">
              <img src="${att.path}" alt=""/>
            </a>
          </c:forEach>
        </c:if>
        <p class="name" style="width: 90%;">
          <a href="javascript:void(0)" onclick="homeMatchJNodes('${note.id}', 8,'SubordinateInstitutionManagement')" target="_parent" title="${note.title}">${note.title}</a>
        </p>
        <p class="info">${note.sampleContent}</p>
        <a href="<c:url value='/news/news.Bulletin.do?qm=plistNewsNote_default'/>" class="btn-more" title="阅读更多">阅读更多</a>
      </li>
    </c:forEach>
  </ul>
</div>
