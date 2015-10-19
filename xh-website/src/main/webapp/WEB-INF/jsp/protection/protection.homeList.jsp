<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/29
  Time: 15:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="wh data-down">
  <div class="title">资料查看<a class="btn-more" href="<c:url value='/protection/protection.list.do?qm=plistPolicy_default'/> " title="更多">更多</a></div>
  <ul class="list-table">
    <c:forEach items="${documentList}" var="document" begin="0" end="3">
      <li>
        <a href="javascript:(0)" onclick="homeMatchJNodes('${document.id}','17','ProtectionPolicy')" target="_parent" title="${document.title}">
          <table>
            <tr>
              <td>${document.title}</td>
            </tr>
          </table>
        </a>
      </li>
    </c:forEach>
  </ul>
</div>