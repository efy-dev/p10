<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
  <title></title>
  <script src="<c:url value="/scripts/jquery.autocompleter.js"/>"></script>
  <link rel="stylesheet" href="<c:url value='/scripts/css/main2.css'/>"/>
  <script src="<c:url value='/resources/plugins/ckeditor/ckeditor.js'/>" ></script>
</head>
<body>
<div class="am-cf am-padding">
  <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">新建/编辑项目内容</strong> | <small>New/Edit ProjectContent</small></div>
</div>
<hr/>

<div class="am-g">
  <form action="<c:url value="/basic/xmm.do"/>"  class="am-form am-form-horizontal" method="post" enctype="multipart/form-data">
    <input type="hidden" name="qm" value="saveOrUpdateProjectContent">
<c:if test="${!empty projectContent.id}">
    <input type="hidden" name="resultPage" value="redirect:/basic/xm.do?qm=viewProjectwiki&param=project&conditions=project.id:${projectContent.project.id}&id=${projectContent.project.id}">
</c:if>
    <c:if test="${empty projectContent.id}">
      <input type="hidden" name="resultPage" value="redirect:/basic/xm.do?qm=viewProjectwiki&param=project&conditions=project.id:<%= request.getParameter("projectid")%>&id=<%= request.getParameter("projectid")%>">
    </c:if>
   <%-- <input type="hidden" name="project.id" value="ichkt4el000064st">--%>
    <input type="hidden" id="creator.id" name="creator.id" class="creatorid" value="${projectContent.creator.id}">
    <%--<input type="hidden" id="city.id" name="city.id" class="cityid" value="${projectContent.city.id}">--%>
    <input type="hidden" id="createDatetime" name="createDatetime" value="${createDatetime}">
    <input type="hidden" id="id" name="id"  value="${projectContent.id}">
    <div class="am-form-group">
      <label name="name" for="nope" class="am-u-sm-3 am-form-label">大师搜索 <small>*</small></label>
      <div class="am-u-sm-9">

        <input type="text" name="nope" id="nope" placeholder="大师搜索" value="${projectContent.creator.fullName}" />
      </div>
    </div>
    <div class="am-form-group">
      <label name="serial" for="type" class="am-u-sm-3 am-form-label">项目类型 <small>*</small></label>
      <div class="am-u-sm-9">
        <select  name="type" id="type">
          <c:if test="${!empty projectContent.type}">
            <option value="1" <c:if test="${ projectContent.type == 1}">selected="selected"</c:if> >内容类型</option>
            <option value="2" <c:if test="${ projectContent.type == 2}">selected="selected"</c:if>> 固定类型</option>
          </c:if>
          <c:if test="${empty projectContent.type}">
            <option value="1" selected="selected">内容类型</option>
            <option value="2" > 固定类型</option>
          </c:if>
        </select>
      </div>
    </div>
    <div class="am-form-group">
      <label name="type" for="project.name" class="am-u-sm-3 am-form-label">项目名称 <small>*</small></label>
      <div class="am-u-sm-9" style="margin-top: 10px">
        <%--<select  name="project.id" id="project.id">
          <c:forEach var="project" items="${projectList}">
            <c:if test="${!empty projectContent.project.name}">
              <option value="${projectContent.project.id}" <c:if test="${!empty projectContent.project.name}">selected="selected"</c:if> >${projectContent.project.name}</option>
            </c:if>
            <c:if test="${empty projectContent.project.name}">
              <option value="${project.id}" selected="selected" >${project.name}</option>
            </c:if>

          </c:forEach>
        </select>--%>
        <c:if test="${!empty projectContent.project.name}">
           <input type="text" name="project.name" id="project.name" placeholder="项目名称" value="${projectContent.project.name}" />
           <input type="hidden" id="project.id" name="project.id" value="${projectContent.project.id}">
        </c:if>
          <c:if test="${empty projectContent.project.name}">
            <input type="text" name="project.name" id="project.name" placeholder="项目名称" value="<%= request.getParameter("objectName")%>" />
            <input type="hidden" id="project.id" name="project.id" value="<%= request.getParameter("projectid")%>">
          </c:if>

      </div>
    </div>
    <%--<div class="am-form-group">
      <label name="name" for="cityname" class="am-u-sm-3 am-form-label">城市名称 <small>*</small></label>
      <div class="am-u-sm-9">
        <input type="text" name="name" id="cityname" placeholder="城市搜索" value="${projectContent.city.name}">
      </div>
    </div>--%>
    <div class="am-form-group">
      <label name="type" for="category.id" class="am-u-sm-3 am-form-label">非遗类别 <small>*</small></label>
      <div class="am-u-sm-9" style="margin-top: 10px">
        <select  name="category.id" id="category.id">
          <c:forEach var="projectCategory" items="${projectCategoryList}">
            <c:if test="${!empty projectContent.category.name}">
              <option value="${projectContent.category.id}" <c:if test="${!empty projectContent.category.name}">selected="selected"</c:if> >${projectContent.category.name}</option>
            </c:if>
            <c:if test="${empty projectContent.category.name}">
              <option value="${projectCategory.id}" selected="selected" >${projectCategory.name}</option>
            </c:if>

          </c:forEach>
        </select>
      </div>
    </div>
    <div class="am-form-group">
      <label name="type" for="content" class="am-u-sm-3 am-form-label">项目内容 <small>*</small></label>
      <div class="am-u-sm-9" style="margin-top: 10px">
        <%--<textarea id="content" name="content"  style="overflow-y: scroll"><c:if test="${!empty projectContent.content}">${projectContent.content}</c:if></textarea>--%>
        <textarea id="content" name="content" class="ckeditor" placeholder="项目内容" required
                value='<c:if test="${!empty projectContent.content}">${projectContent.content}</c:if>'><c:if test="${!empty projectContent.content}">${projectContent.content}</c:if></textarea>
      </div>
    </div>

    <div class="am-form-group">
      <div class="am-u-sm-9 am-u-sm-push-3">
        <input type="submit" class="am-btn am-btn-primary" value="保存"/>
      </div>
    </div>
  </form>
</div>
<!-- content end -->
<hr/>
<script>

  var creators = [];

  $(function () {
    jQuery.ajax({
      type: "post",
      url: '<c:url value="/pcn/getcreators.do"/>',
      dataType: "json",
      success: function (data) {

        creators = data;
        //
        $('#nope').autocompleter({
          // marker for autocomplete matches
          highlightMatches: true,

          // object to local or url to remote search
          source: creators,

          // custom template
          template: '{{ label }} <span>({{ rgb }})</span>',

          // show hint
          hint: true,

          // abort source if empty field
          empty: false,

          // max results
          limit: 5,

          callback: function (value, index, selected) {
            if (selected) {
              //$('.icon').css('background-color', selected.hex);
              $('.creatorid').val( selected.id);

            }
          }
        });
      }
    });

//城市搜索
    jQuery.ajax({
      type: "post",
      url: '<c:url value="/pcn/getcities.do"/>',
      dataType: "json",
      success: function (data) {

        creators = data;
        //
        $('#cityname').autocompleter({
          // marker for autocomplete matches
          highlightMatches: true,

          // object to local or url to remote search
          source: creators,

          // custom template
          template: '{{ label }}',

          // show hint
          hint: true,

          // abort source if empty field
          empty: false,

          // max results
          limit: 5,

          callback: function (value, index, selected) {
            if (selected) {
              //$('.icon').css('background-color', selected.hex);
              $('.cityid').val( selected.id);

            }
          }
        });
      }
    });
  });

</script>
</body>
</html>
