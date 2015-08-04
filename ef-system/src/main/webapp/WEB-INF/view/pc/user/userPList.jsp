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

<html>
<head>
    <title></title>

</head>
<body>


<div id="doc-tab-demo-1" class="am-tabs" data-am-tabs="{noSwipe: 1}">
  <ul class="am-tabs-nav am-nav am-nav-tabs">
    <li class="am-active">
      <a href="javascript: void(0)">基本查询</a>
    </li>
    <li class="">
      <a href="javascript: void(0)">特殊查询</a>
    </li>
    <li class="">
      <a href="javascript: void(0)">其他查询</a>
    </li>
  </ul>
  <div class="am-tabs-bd">
    <div id="default" class="am-tab-panel am-active am-in">
      <div class="queryDiv inline-block">
        <div class="am-form-group">
            <span>
               用户名:
                 <input id="username" name="username" class="" type="text" value="" size="15">
            </span>
            <span>
              真实姓名:
                 <input id="name"  class="" type="text" value="" name="name" size="15">
            </span>
            <span class="am-btn-group am-btn-group-xs">
                 <a type="button" class="am-btn am-btn-default" href="#>" onclick="searchUser('basic')" ><span class="am-icon-search"></span>查询</a>
            </span>
        </div>
      </div>
    </div>
    <div id="consumer" class="am-tab-panel">
      <div class="queryDiv inline-block">
        <div class="am-form-group">
            <span>
              角色:
                <input id="" class="" type="text" value="" name="id" size="15">
            </span>
            <span class="am-btn-group am-btn-group-xs">
                <a type="button" class="am-btn am-btn-default" href="<c:url value="/basic/xm.do?qm=formUser"/>"><span class="am-icon-search">查询</span></a>
            </span>
        </div>
      </div>
    </div>
    <div id="first" class="am-tab-panel">
      <div class="queryDiv inline-block">

      </div>
    </div>
  </div>
</div>





<div class="am-u-sm-12 am-u-md-6" style="margin-bottom: 5px;margin-top: 2px;">
  <div class="am-btn-toolbar" style="width: 230%">
    <div class="am-btn-group am-btn-group-xs">
      <a type="button" class="am-btn am-btn-default" href="<c:url value="/basic/xm.do?qm=formUser"/>"><span class="am-icon-plus"></span>新建用户</a>
    </div>

  </div>
</div>

<table class="am-table am-table-bordered am-table-radius am-table-striped">
  <tr style="text-align: center">
    <td>操作</td>
    <td>用户名</td>
    <td>真实姓名</td>
    <td>角色</td>
  </tr>

  <c:forEach items="${requestScope.pageInfo.list}" var="user">
    <tr style="text-align: center" id="${user.id}">
      <td width="20%">
        <div class="am-btn-toolbar">
          <div class="am-btn-group am-btn-group-xs" style="width: 100%;text-align: center;" >
            <button  style="margin-left: 70px;" onclick="window.location.href='<c:url value="/basic/xm.do?qm=formUser&id=${user.id}"/>'" class="am-btn am-btn-default am-btn-xs am-hide-sm-only"><span class="am-icon-edit"></span> 编辑</button>
            <button onclick="removeUser('${user.id}')" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 删除</button>
          </div>
        </div>
      </td>
      <td width="20%">${user.username}</td>
      <td width="20%">${user.name}</td>
      <td width="20%">${user.role.name}
      </td>
    </tr>
  </c:forEach>
</table>
<div style="clear: both">
  <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="/basic/xm.do">
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
