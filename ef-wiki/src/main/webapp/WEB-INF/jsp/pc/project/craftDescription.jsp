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
  <script src="<c:url value="/resources/jquery/jquery.qrcode.min.js"/>"></script>
    <title>${artistry.name}-非遗百科</title>
  <meta name="description" content="中国领先的非物质文化遗产百科全书">
  <meta name="keywords" content="${artistry.name},非遗百科,百科,非物质文化遗产,文化遗产,传统技艺,传统美术,e飞蚁,非遗电商,前门,前门大街">
</head>
<body>
<div class="craft-particulars2016">
  <div class="craft-crumbs">
    <div class="particulars">
      <div class="crumbs"><a href="http://minglu.efeiyi.com/" >首页</a><em class="">></em><a href="http://baike.efeiyi.com/" class=""><ming800:status name="type" dataType="Project.type" checkedValue="${artistry.getType()}" type="normal"/></a><a href="" class="present"><em class="present">></em>${artistry.project.name}</a></div>
    </div>
  </div>
  <div class="user">
    <div class="skill">
      <div class="page">
        <div class="txt-page">
          <p class="name">技艺名称：<a>${artistry.name}</a></p>
          <p class="rank">技艺级别：<em><ming800:status name="level" dataType="Project.level" checkedValue="${artistry.getLevel()}" type="normal"/></em></p>
          <c:if test="${not empty artistry.project.addressDistrict}">
              <p class="area">所属地区：<em>${artistry.project.addressDistrict.addressCity.addressProvince.name}${artistry.project.addressDistrict.addressCity.name}${artistry.project.addressDistrict.name}</em></p>
          </c:if>
        </div>
        <div class="pic-page">
          <c:if test="${not empty masterProjectList&&fn:length(masterProjectList)>0}">
          <div class="user-pic">

              <a href="http://${masterProjectList.get(0).getMaster().name}.efeiyi.com/">
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
            <div id="native"></div>
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
        <c:if test="${not empty artistry.artistryDescription}">
        ${artistry.artistryDescription.descriptionPC}
        </c:if>
      </div>
    </div>
    <a href="http://minglu.efeiyi.com/question" title="题库地图-非遗百科" style="color: #fff;;">题库地图</a>
  </div>
</div>
<script type="text/javascript">
  $().ready(function () {
    var url = "http://minglu.efiyi.com/project/${artistry.id}";
    $('#native').qrcode({
      text: url,
            width: 160,
            height: 160
    });
  })

</script>
</body>
</html>
