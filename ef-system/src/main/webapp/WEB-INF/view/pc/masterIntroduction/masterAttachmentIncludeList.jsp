<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/23
  Time: 15:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<table class="am-table am-table-striped am-table-hover table-main">
  <thead>
  <tr>
    <th class="table-title">链接</th>
    <th class="table-title">预览</th>

  </tr>
  </thead>
  <tbody>

  <c:forEach items="${objectList}" var="masterAttachment">
    <tr>
      <td class="am-hide-sm-only">http://tenant.efeiyi.com/${masterAttachment.url}</td>
      <td class="am-hide-sm-only"><img src="http://tenant.efeiyi.com/${masterAttachment.url}@!tenant-manage-banner"></td>
    </tr>
  </c:forEach>
  </tbody>
</table>
