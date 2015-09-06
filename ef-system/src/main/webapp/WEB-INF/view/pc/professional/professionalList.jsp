<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/18
  Time: 14:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--<script type="text/javascript" src="<c:url value='/scripts/assets/js/amazeui.js'/>"/>--%>

  <div class="am-g">
    <div class="am-u-sm-12 am-u-md-6">
    </div>
    <div class="am-u-sm-12">
      <table class="am-table am-table-striped am-table-hover table-main">
        <thead>
        <tr>
          <th width="50%">用户名</th>
          <th width="50%">名称</th>

        </tr>
        </thead>
        <tbody>
        <c:forEach items="${objectList}" var="professional" end="4">
          <tr id="${professional.id}">
            <td class="am-hide-sm-only">
                ${professional.username}
            </td>
            <td class="am-hide-sm-only"> ${professional.fullName}</td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
