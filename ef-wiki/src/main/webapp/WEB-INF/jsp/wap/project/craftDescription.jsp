<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/4/14
  Time: 15:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>内容频道-工艺详情</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

</head>
<body>
<div class="craft">
  <div class="dt">
    <h1>${artistry.project.name}</h1>
    <p>[<ming800:status name="level" dataType="Project.level" checkedValue="${artistry.project.getLevel()}" type="normal"/>]非物质文化遗产传承项目</p>
    <p>${artistry.project.addressDistrict.name}</p>
  </div>
  <!--//End--传统技艺-->
  <div data-am-widget="tabs" class="am-tabs tabs">
    <ul class="am-tabs-nav nav bgfff">
      <li class="am-active"><a href="[data-tab-panel-0]">技艺介绍</a></li>
      <li class=""><a href="[data-tab-panel-1]">作品</a></li>
      <li class=""><a href="[data-tab-panel-2]">大师</a></li>
    </ul>
    <div class="am-tabs-bd items">
      <div data-tab-panel-0 class="am-tab-panel am-active">
       ${artistry.artistryDescription.descriptionWap}
      </div>
      <!--//End--技艺介绍-->
      <div data-tab-panel-2 class="am-tab-panel">
        <ul class="ul-col-2">
          <c:forEach items="${masterWorkList}" var="masterWork">
          <li>
            <a href="<c:url value="/masterWork/${masterWork.id}"/>" title="">
              <img src="http://tenant.efeiyi.com/${masterWork.pictureUrl}@!wiki-work-picture" alt="">
                            <span class="txt">
                                <p>${masterWork.name}</p>
                            </span>
            </a>
          </li>
          </c:forEach>
        </ul>
      </div>
      <!--//End--作品-->
      <div data-tab-panel-1 class="am-tab-panel">
        <ul class="ul-col-2">
          <c:forEach items="${masterProjectList}" var="masterProject">
          <li>
            <a href="" title="">
              <img src="http://tenant.efeiyi.com/${masterProject.master.favicon}@!wiki-tenant-picture" alt="">
                            <span class="txt">
                                <p>${masterProject.master.fullName}</p>
                                <p>${masterProject.project.name}</p>
                                <p<ming800:status name="level" dataType="Project.level" checkedValue="${masterProject.project.level}" type="normal"/>传承人</p>
                            </span>
            </a>
          </li>
          </c:forEach>
        </ul>
      </div>
      <!--//End--大师-->
    </div>
  </div>
  <!--//End---->
</div>
</body>
</html>