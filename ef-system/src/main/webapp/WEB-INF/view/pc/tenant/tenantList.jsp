<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/25
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>

<html>
<head>
  <title></title>

</head>
<body>
<%--<a id="${master.id}" class="am-btn am-btn-default am-btn-xs am-text-secondary" href="<c:url value="/basic/xm.do?qm=viewTenant&view=tenantList&id=${tenantId}"/>"><span--%>
        <%--class="am-icon-pencil-square-o"></span> 返回--%>
<%--</a>--%>
<form action="<c:url value="/basic/xm.do"/>" method="post"  class="am-form am-form-horizontal" id="form">
  <%--<input type="hidden" name="qm" value="saveOrUpdateTenantMaster">--%>
  <%--<input type="hidden" name="id" >--%>
  <%--<input type="hidden" name="status" value="1">--%>
  <input type="hidden" name="resultPage" value="redirect:/basic/xm.do?plistProduct_default&view=newProduct" />
  <input type="hidden" name="tenantId" value="${tenantId}" />
  <input type="hidden" name="productId" value="${productId}" />
  <div class="admin-content">
    <div class="am-g">
      <div class="am-u-sm-12">
        <table class="am-table am-table-striped am-table-hover table-main">
          <thead>
          <tr>
            <th class="table-set" width="50%">操作</th>
            <th class="table-title" width="50%">商家名称</th>
          </tr>
          </thead>
          <tbody>

          <c:forEach items="${objectList}" var="tenant">
            <tr>
              <td>
                <div class="am-btn-toolbar">
                  <div class="am-btn-group am-btn-group-xs">
                    <c:if test="${tenant.id == tenantId}">
                       <a  class="am-btn am-btn-default am-btn-xs am-text-secondary" status="1" href="javascript:void(0);" onclick="linkTenantProduct('${tenant.id}');"><span
                            class="am-icon-pencil-square-o"></span> 解除商家
                       </a>
                    </c:if>
                    <c:if test="${tenant.id != tenantId}">
                      <a  class="am-btn am-btn-default am-btn-xs am-text-secondary" status="0" href="javascript:void(0);" onclick="linkTenantProduct('${tenant.id}');"><span
                              class="am-icon-pencil-square-o"></span> 关联商家
                      </a>
                    </c:if>
                  </div>
                </div>
              </td>
              <td class="am-hide-sm-only">
                  ${tenant.name}
              </td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>
    </div>

  </div>
</form>
<script>
  function linkTenantProduct(tenantId){
    $("input[name='tenantId']").val(tenantId);
    $("#form").submit();
  }
</script>
</body>
</html>
