<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/21
  Time: 17:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="am-g">
  <div class="am-u-sm-12">
    <table class="am-table am-table-striped am-table-hover table-main">
      <thead>
      <tr>
        <th class="table-set">操作</th>
        <th class="table-title">名称</th>
        <th class="table-title">级别</th>
        <th class="table-title">创建时间</th>

      </tr>
      </thead>
      <tbody>

      <c:forEach items="${objectList}" var="tenantProject">
        <tr>
          <td>
            <div class="am-btn-toolbar">
              <div class="am-btn-group am-btn-group-xs">
                <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" href="<c:url value="/basic/xm.do?qm=plistTenantWork_byProject&conditions=project.id:${tenantProject.project.id}&projectId=${tenantProject.project.id}&tenantId=${tenantProject.tenant.id}"/>"><span
                        class="am-icon-trash-o"></span> 查看作品
                </a>
              </div>
            </div>
          </td>
          <td class="am-hide-sm-only">${tenantProject.project.name}</td>
          <td class="am-hide-sm-only">${tenantProject.project.level}</td>
          <td class="am-hide-sm-only">${tenantProject.project.createDateTime}</td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
</div>
