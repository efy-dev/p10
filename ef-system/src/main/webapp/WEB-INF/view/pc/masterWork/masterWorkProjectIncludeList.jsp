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

      </tr>
      </thead>
      <tbody>

      <c:forEach items="${objectList}" var="masterProject">
        <tr id="${masterProject.id}">
          <td>
            <div class="am-btn-toolbar">
              <div class="am-btn-group am-btn-group-xs">
                <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" href="<c:url value="/basic/xm.do?qm=plistMasterWork_byProject&conditions=project.id:${masterProject.project.id}&projectId=${masterProject.project.id}&masterId=${masterProject.master.id}"/>"><span
                        class="am-icon-trash-o"></span> 查看作品
                </a>
                <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                   onclick="removeMasterProject('${masterProject.id}')"><span
                        class="am-icon-trash-o"></span> 删除
                </a>
              </div>
            </div>
          </td>
          <td class="am-hide-sm-only">${masterProject.project.name}</td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
</div>
<script>

  function removeMasterProject(divId){
    $.ajax({
      type: "get",
      url: '<c:url value="/basic/xmj.do?qm=removeMasterProject"/>',
      cache: false,
      dataType: "json",
      data:{id:divId},
      success: function (data) {
        $("#"+divId).remove();
      }
    });
  }

</script>
