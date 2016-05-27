<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/25
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
  <title></title>
  <script>

    function removeDocument(documentId){
      $.ajax({
        type: "get",
        url: '<c:url value="/basic/xmj.do?qm=removeDocument"/>',
        cache: false,
        dataType: "json",
        data:{id:documentId},
        success: function (data) {
          $("#"+documentId).remove();
        }
      });
    }

  </script>
</head>
<body>
<div class="am-btn-toolbar" style="margin-bottom: 10px">
  <div class="am-btn-group am-btn-group-xs">
    <security:authorize ifAnyGranted="admin,operational,c_operational,o_operational">
      <a type="button" class="am-btn am-btn-default" href="<c:url value="/basic/xm.do?qm=formDocumentNews&groupName=${groupName}"/>"><span class="am-icon-plus"></span>新建文档</a>
    </security:authorize>
  </div>
</div>
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&groupName=${groupName}&conditions=${requestScope.conditions}"/>
<div class="admin-content">
  <div class="am-g">
    <div class="am-u-sm-12 am-u-md-6">
    </div>
    <div class="am-u-sm-12">
      <table class="am-table am-table-striped am-table-hover table-main">
        <thead>
        <tr>
          <security:authorize ifAnyGranted="admin,operational,c_operational,o_operational">
            <th class="table-set">操作</th>
          </security:authorize>
          <th class="table-title">标题</th>
          <th class="table-title">类别</th>
        </tr>
        </thead>
        <tbody>

        <c:forEach items="${requestScope.pageInfo.list}" var="document">
          <tr id="${document.id}">
            <security:authorize ifAnyGranted="admin,operational,c_operational,o_operational">
              <td width="33%">
                <div class="am-btn-toolbar">
                  <div class="am-btn-group am-btn-group-xs">
                    <a class="am-btn am-btn-default am-btn-xs am-text-secondary"
                       href="<c:url value="/basic/xm.do?qm=formDocumentNews&groupName=${groupName}&id=${document.id}"/>"><span
                            class="am-icon-pencil-square-o"></span> 编辑
                    </a>
                    <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                       href="#" onclick="showConfirm('提示','是否删除',function(){removeDocument('${document.id}')})"><span
                            class="am-icon-trash-o">删除</span>
                    </a>
                  </div>
                </div>
              </td>
            </security:authorize>
            <td class="am-hide-sm-only" width="33%"><a href="<c:url value="/basic/xm.do?qm=viewDocument&groupName=${groupName}&id=${document.id}"/>">${document.title}</a></td>
            <td class="am-hide-sm-only" width="33%">
              <ming800:status name="group" dataType="Document.group" checkedValue="${document.group}"  type="normal"/>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
  <div style="clear: both">
    <c:url value="/basic/xm.do" var="url"/>
    <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
      <ming800:pcPageParam name="groupName" value="${groupName}"/>
      <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
      <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
    </ming800:pcPageList>
  </div>
</div>

</body>
</html>
