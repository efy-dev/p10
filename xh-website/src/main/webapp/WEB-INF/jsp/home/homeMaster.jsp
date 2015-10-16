<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/10/13
  Time: 15:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="part">
  <div class="title">非遗传承人</div>
  <ul class="ul-list">
    <c:forEach items="${masterList}" var="master">
      <li>
        <a href="<c:url value='/project/project.master.do?qm=plistTenant_default&provinceid=-1&type=-1&masterid=${master.id}'/>" title="">
          <img src="<c:url value='/shop2015/upload/exp6.jpg'/>" alt="">
        </a>
        <p>${master.fullName}</p>
      </li>
    </c:forEach>
  </ul>
</div>
