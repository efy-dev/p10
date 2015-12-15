<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 14:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title></title>

</head>
<body>


<div style="text-align: left" >
<security:authorize ifAnyGranted="admin,operational,c_operational">
      <a type="button" class="am-btn am-btn-default am-btn-xs" style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;" href="<c:url value="/basic/xm.do?qm=formUser&formParam=user"/>"><span class="am-icon-plus"></span>新建用户</a>
</security:authorize>
</div>

    <jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>
<table class="am-table am-table-bordered am-table-radius am-table-striped">
  <tr style="text-align: center">
<security:authorize ifAnyGranted="admin,operational,c_operational">
    <td>操作</td>
    </security:authorize>
    <td>用户名</td>
    <td>真实姓名</td>
    <td>角色</td>
      <td>创建时间</td>
  </tr>

  <c:forEach items="${requestScope.pageInfo.list}" var="user">
    <tr style="text-align: center" id="${user.id}">
        <security:authorize ifAnyGranted="admin,operational,c_operational">
      <td width="20%">
        <div class="am-btn-toolbar">
          <div class="am-btn-group am-btn-group-xs" style="width: 100%;text-align: center;" >
            <a  style="margin-left: 70px;" onclick="window.location.href='<c:url value="/basic/xm.do?qm=formUser&formParam=user&id=${user.id}"/>'" class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span class="am-icon-edit"></span> 编辑</a>
              <a onclick="showConfirm('提示','是否删除',function(){removeUser('${user.id}')})" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 删除</a>
          </div>
        </div>
      </td>
        </security:authorize>
      <td width="20%">${user.username}</td>
      <td width="20%">${user.name}</td>
      <td width="20%">${user.role.cname}
      </td>
        <td width="20%"><fmt:formatDate value="${user.createDatetime}" pattern="yyyy-MM-dd hh:mm" type="both"/>
        </td>
    </tr>
  </c:forEach>
</table>
<div style="clear: both">
    <c:url value="/basic/xm.do" var="url"/>
  <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
    <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
    <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
    <ming800:pcPageParam name="menuId" value="${requestScope.menuId}"/>
  </ming800:pcPageList>
</div>
<script>



  function removeUser(divId){
    $.ajax({
      type: "get",
      url: '<c:url value="/basic/xmj.do?qm=removeUser"/>',
      cache: false,
      dataType: "json",
      data:{id:divId},
      success: function (data) {
        $("#"+divId).remove();
      }
    });
  }

          function searchUser(searchType){
            var  searchUrl = "";
            if(searchType == "basic"){
              var username = $("input[name='username']").val();
              var name = $("input[name='name']").val();
              searchUrl = "";
              if(username != ""){
                searchUrl += ";username:"+username;
              }
              if(name != ""){
                searchUrl += ";name:"+name;
              }
              window.location.href = "<c:url var="searchUrl" value="/basic/xm.do?qm=plistUser_default&conditions=status:1" />";
            }
          }

</script>
</body>
</html>
