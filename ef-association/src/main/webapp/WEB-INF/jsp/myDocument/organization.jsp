<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/11
  Time: 14:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
  <title></title>
</head>
<body>
<div class="am-g">
  <button onclick="window.location.href='<c:url value="/myDocument/newOrganization.do?qm=direct2JspOrganization_default&group=${group}&resultPage=/myDocument/organization.do?qm=${requestScope.qm}"/>'"
          class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span>新建</button>

  <table class="am-table am-table-bordered am-table-radius am-table-striped">
    <tr>
      <td>操作</td>
      <td>名称</td>
      <td>地址</td>
      <td>负责人</td>
    </tr>
    <c:forEach items="${intangibleCulturalOrganizationList}" var="organization">
      <tr>
        <td>
            <button onclick="window.location.href='<c:url value="/myDocument/newOrganization.do?qm=direct2JspOrganization_default&group=${group}&id=${organization.id}&resultPage=/myDocument/organization.do?qm=${requestScope.qm}"/>'"
                    class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 编辑</button>
            <button onclick="window.location.href='<c:url value="/myOrganization/removeOrganization.do?qm=removeContent&id=${organization.id}&resultPage=/myDocument/organization.do?qm=${requestScope.qm}"/>'"
                  class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 删除</button>
        </td>
        <td>
          <div>${organization.name}</div>
        </td>
          <td>
              <div>${organization.addressDistrict.addressCity.addressProvince.name} ${organization.addressDistrict.addressCity.name} ${organization.addressDistrict.name}</div>
          </td>
          <td>
              <div>${organization.inCharge}</div>
          </td>
      </tr>
    </c:forEach>
  </table>
</div>
<div style="clear: both">
  <c:url value="/content/organization.do" var="url"/>
  <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
    <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
    <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
  </ming800:pcPageList>
</div>
<script src="<c:url value='http://libs.baidu.com/jquery/1.11.3/jquery.min.js'/>"></script>
</body>
</html>

