<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/24
  Time: 19:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
  <title>协会介绍</title>
</head>
<body>

<div class="wh home-list isoc">
  <div class="hd">
    <div class="slide-left">
      <div class="nav-list">
        <ul class="nav-list-ul">
          <li class="title"><a href="#" target="_blank" title="" onclick="return false">协会概况</a></li>
          <li class="items active"><a href="<c:url value='/association/association.do?qm=plistAssociationIntroduction_default'/>" target="_self" title="">协会介绍</a></li>
          <li class="items"><a href="<c:url value='/association/association.do?qm=plistStatute_default'/>" target="_self" title="">协会章程</a></li>
          <li class="items"><a href="" target="_self" title="">组织机构</a></li>
          <li class="items"><a href="<c:url value='/association/association.do?qm=plistContact_default'/>" target="_self" title="">联系方式</a></li>
        </ul>
      </div>
    </div>
    <!-- //End--slide-left-->
    <div class="slide-right">
      <div class="title">中国非物质文化遗产保护协会-<ming800:status name="group" dataType="document.group" checkedValue='${group}' type="normal"/></div>
      <div class="div-list">
        <ul class="div-list-ul">
          <li>
            ${object.documentContent.content}
          </li>
        </ul>
      </div>
      <!-- //End--div-list-->
    </div>
    <!-- //End--slide-right-->
  </div>
</div>

</body>
</html>
