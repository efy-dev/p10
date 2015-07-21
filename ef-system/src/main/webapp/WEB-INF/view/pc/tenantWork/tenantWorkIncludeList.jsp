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
        <th class="table-title">名字</th>
        <th class="table-title">作者</th>
        <th class="table-title">价格</th>
        <th class="table-title">作品描述</th>

      </tr>
      </thead>
      <tbody>

      <c:forEach items="${objectList}" var="tenantWork">
        <tr>
          <td>
            <div class="am-btn-toolbar">
              <div class="am-btn-group am-btn-group-xs">
                <a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="<c:url value="/basic/xm.do?qm=formTenantWork&id=${tenantWork.id}"/>"><span
                        class="am-icon-pencil-square-o"></span> 编辑
                </a>
                <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" href="<c:url value="/basic/xm.do?qm=removeTenantWork&id=${tenantWork.id}"/>"><span
                        class="am-icon-trash-o"></span> 删除
                </a>
              </div>
            </div>
          </td>
          <td class="am-hide-sm-only"><a href="<c:url value="/basic/xm.do?qm=viewTenantWork&id=${tenantWork.id}"/>">${tenantWork.name}</a></td>
          <td class="am-hide-sm-only">${tenantWork.tenant.name}</td>
          <td class="am-hide-sm-only">${tenantWork.price}</td>
          <td class="am-hide-sm-only">${tenantWork.productDescription.content}</td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
</div>
