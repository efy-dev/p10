<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/4/14
  Time: 10:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="no-js">
<head>
    <title></title>
</head>
<body>
<div class="craft-particulars2016">
  <div class="craft-crumbs">
    <div class="particulars">
      <div class="crumbs"><a href="/" >首页</a><em class="">></em><a href="" class="">工艺</a><a href="" class="present"><em class="present">></em>${projectWiki.project.name}</a></div>
    </div>
  </div>
  <div class="user">
    <div class="skill">
      <div class="page">
        <div class="txt-page">
          <p class="name">技艺名称：<a>${projectWiki.project.name}</a></p>
          <p class="rank">技艺级别：<em><ming800:status name="level" dataType="Project.level" checkedValue="${projectWiki.project.getLevel()}" type="normal"/></em></p>
          <p class="area">所属地区：<em>${projectWiki.project.addressDistrict.name}</em></p>
        </div>
        <div class="pic-page">
          <c:if test="${not empty masterProjectList&&fn:length(masterProjectList)>0}">
          <div class="user-pic">
            <a href="">
              <img src="<c:url value="http://tenant.efeiyi.com/${masterProjectList.get(0).getMaster().getFavicon()}@!wiki-pc-master-picture"/>" alt="">
              <div class="user-txt">
                <p class="name">${masterProjectList.get(0).getMaster().getFullName()}</p>
                <p class="craft">${masterProjectList.get(0).getProject().getName()}</p>
                <p class="rank"><ming800:status name="level" dataType="Project.level" checkedValue="${masterProjectList.get(0).getProject().getLevel()}" type="normal"/>传承人</p>
              </div>
            </a>
          </div>
          </c:if>
          <div class="wechat" >
            <img id="native" src="<c:url value="/scripts/assets/images/craft/wechat.jpg"/>" alt="">
            <div class="user-wechat">
              <p>扫描二维码</p>
              <p>到手机查看</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="introduce">
    <div class="craft-introduce">
      <div class="topic">
        <div class="bd-list"></div>
        <div class="topic-txt"><span>工艺介绍</span></div>
        <div class="bd-list"></div>
      </div>
      <div class="txt">
        ${projectWiki.projectDescription.description}
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
  $().ready(function () {
    var url = "http://wiki.efeiyi.com/project/"+${project.id};
    $('#native').qrcode({
      text: url,
            width: 160,
            height: 160
    });
  })
  $("#native").html("");
</script>
</body>
</html>
