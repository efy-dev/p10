<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/10/8
  Time: 15:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>

<div id="show" class="list-table">
  <table>
    <tr>
      <td>协会</td>
      <td>传承人</td>
      <td>类别</td>
    </tr>
    <%--<c:forEach items="${projectList}" var="project">--%>
      <%--<tr>--%>
        <%--<td>${project.name}</td>--%>
        <%--<td>姚惠芬</td>--%>
        <%--<td>织染印秀</td>--%>
      <%--</tr>--%>
    <%--</c:forEach>--%>
    <c:forEach items="${objectList}" var="project">
      <tr>
        <td>${project.name}</td>
        <td>姚惠芬</td>
        <td>织染印秀</td>
      </tr>
    </c:forEach>
    <%--<tr>
        <td>刺绣委员会</td>
        <td>姚惠芬</td>
        <td>织染印秀</td>
    </tr>
    <tr>
        <td>刺绣委员会</td>
        <td>姚惠芬</td>
        <td>织染印秀</td>
    </tr>
    <tr>
        <td>刺绣委员会</td>
        <td>姚惠芬</td>
        <td>织染印秀</td>
    </tr>
    <tr>
        <td>刺绣委员会</td>
        <td>姚惠芬</td>
        <td>织染印秀</td>
    </tr>
    <tr>
        <td>刺绣委员会</td>
        <td>姚惠芬</td>
        <td>织染印秀</td>
    </tr>
    <tr>
        <td>刺绣委员会</td>
        <td>姚惠芬</td>
        <td>织染印秀</td>
    </tr>
    <tr>
        <td>刺绣委员会</td>
        <td>姚惠芬</td>
        <td>织染印秀</td>
    </tr>
    <tr>
        <td>刺绣委员会</td>
        <td>姚惠芬</td>
        <td>织染印秀</td>
    </tr>--%>
  </table>
</div>
</div>
<div class="pages wh">
<ul class="am-pagination am-pagination-centered">
<div style="clear: both">
<c:url value="/project/project.do" var="url"/>
<ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
<ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
<ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
</ming800:pcPageList>
</div>
</ul>
</div>