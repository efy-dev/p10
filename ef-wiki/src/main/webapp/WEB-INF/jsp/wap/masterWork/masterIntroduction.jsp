<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/9/6
  Time: 15:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<header id="header" class="am-header custom-header newheader">
  <div class="logo"><img src="<c:url value="/scripts/assets/wap/images/ef-logo-craft.png"/>" height="27" width="110" align="center" alt=""></div>
  <!-- //End--logo-->
  <!-- //End--chevron-left-->
  <div class="am-header-right am-header-nav">
    <a href="#chevron-right" class="chevron-right" id="menu">
      <i class="line"></i>
    </a>
  </div>
  <div class="menu-list">
    <ul class="bd">
      <li><a href="<c:url value="/"/>" title="首页">首页</a></li>
      <li><a href="http://www.efeiyi.com" title="购物车">非遗商城</a></li>
      <li><a href="http://master.efeiyi.com" title="个人中心">非遗大师</a></li>
    </ul>
  </div>
</header>
<body>
<div class="master">
  <div class="master_top pt15 pb15 bgfff">
    <div class="master_img">
      <div class="img"><img src="<c:url value='http://tenant.efeiyi.com/${masterProject.master.getFavicon()}'/>" alt=""></div>
      <div class="fz14 black mt10">${masterProject.master.getFullName()}</div>
      <div class="fz12 color6 mt10">${artistry.getName()}</div>
      <div class="fz12 color6 mt10"><ming800:status name="level" dataType="Project.level"
                                                     checkedValue="${artistry.getLevel()}" type="normal"/>传承人</div>
    </div>
    <!--//End-->
    <div class="master_text fz11 mt10 bgfff">
      ${masterWork.master.content}
    </div>
    <!--//End-->
  </div>
  <!--//End---->

  <div data-am-widget="tabs" class="am-tabs tabs fz14">
    <ul class="am-tabs-nav nav bgfff">
      <li class="am-active"><a href="[data-tab-panel-0]">作品</a></li>
      <li class=""><a href="[data-tab-panel-1]">艺术历程</a></li>
      <li class=""><a href="[data-tab-panel-2]">技艺介绍</a></li>
    </ul>
    <div class="am-tabs-bd items">
      <div data-tab-panel-0 class="am-tab-panel am-active">
        <div class="ul-col2 bd">
          <ul>
            <c:if test="${workList!=null&&workList.size()>0}">
              <c:forEach items="${workList}" var="masterWork">
            <li>
              <a href="<c:url value="/masterWork/${masterWork.id}"/>" title="">
                <img src="http://tenant.efeiyi.com/${masterWork.pictureUrl}@!wiki-work-picture" alt="">
                <span class="fz11 black omitted">${masterWork.name}</span>
              </a>
            </li>
              </c:forEach>
            </c:if>
          </ul>
          <div class="bd txt-c">
            <a href="" class="more" title="查看更多作品">查看更多作品</a>
          </div>

        </div>
      </div>
      <div data-tab-panel-1 class="am-tab-panel ">
        ${introductionList.get(0).content}
      </div>
      <div data-tab-panel-2 class="am-tab-panel ">
        ${artistry.artistryDescription.descriptionWap}
      </div>
    </div>
  </div>
  <!--//End---->
</div>




<!--[if (gte IE 9)|!(IE)]><!-->
<script src="efeiyi2016/js/jquery.min.js"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="efeiyi2016/js/amazeui.min.js"></script>

</body>
</html>