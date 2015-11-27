<%@ page import="com.efeiyi.ec.wiki.organization.util.AuthorizationUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/10/8
  Time: 11:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>

  <title>e飞蚁工艺秀</title>

</head>
<body>


<!-- //End--topbar-->

<!-- //End--header-->
<div class="craft-details ">
  <div class="nav-bars ae">
    <ul class="bars">
      <li class="active"><a href="/pc/index.do">热&nbsp;门</a></li>
      <%if(AuthorizationUtil.getMyUser().getId()==null || "no".equalsIgnoreCase(request.getAttribute("isShow").toString()) ){%>
      <li><a href="<c:url value='/pc/beforeAttention.do'/>">关注</a></li>
      <%}%>
      <%
        if(AuthorizationUtil.getMyUser().getId()!=null && "ok".equalsIgnoreCase(request.getAttribute("isShow").toString()) ){
      %>
      <li><a href="<c:url value='/pc/afterAttention.do'/>">关注</a></li>
      <%}%>

      <li><a href="<c:url value='/pc/category'/>">发&nbsp;现</a></li>
    </ul>
  </div>
</div>
<!--nav-bars-->
<div class="home-craft">
  <div class="craft-details">
    <div class="focus wh">
      <!--轮播图-->
      <ul class="slider-main">
        <c:if test="${! empty bannerList}">
          <c:forEach var="banner" items="${bannerList}" varStatus="status">
          <c:if test="${status.index==0}">
          <li style="display: block;"><a href="#"><img src="http://pro.efeiyi.com/${banner.imageUrl}" ></a></li>
            </c:if>
            <c:if test="${status.index!=0}">
              <li><a href="#"><img src="http://pro.efeiyi.com/${banner.imageUrl}" ></a></li>
            </c:if>
          </c:forEach>

        </c:if>
      </ul>
      <ul class="slider-nav">
        <li class="active"></li>
        <li></li>
        <li></li>
      </ul>
    </div>
    <!-- //End--nav-->
    <div class="cart-tabe">
      <div class="craft-zy" style="display: block">
      <c:if test="${!empty projectCategory}">
        <c:forEach items="${projectCategory}" var="pc" varStatus="status">
          <div class="craft-content ae">
            <h4>${pc[0].projectCategory.name}</h4>
            <a href="#" class="left-icon"></a>
            <div class="commodity-list ae">
              <ul>


                <c:if test="${!empty pc}">
                  <c:forEach items="${pc}" var="project" varStatus="status">
                    <li>
                      <div class="commodity-img">
                        <a href="<c:url value='/project/brifProject/${project.id}'/>"><img src="http://pro.efeiyi.com/${project.picture_pc_url}@!pc-project-list"></a>
                        <a href="#">
                          <div class="list-moods">
                            <i class="img-icon"></i>
                            <em>${project.fsAmount}</em>
                          </div>
                        </a>
                      </div>
                      <div class="commodity-txt">
                        <h4><a href="#">${project.name}</a></h4></p>
                        <p>${project.addressDistrict.addressCity.addressProvince.name}</p>

                        <p>${fn:length(project.productList)}件作品</p>

                        <p>${fn:length(project.masterProjects)}位大师</p>
                      </div>
                    </li>
                  </c:forEach>
                </c:if>

              </ul>
            </div>
            <a href="#" class="right-icon"></a>
          </div>
        </c:forEach>
      </c:if>


      </div>

    </div>
  </div>
</div>

<!-- //End--footer-->
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js?uid=" charset="utf-8"></script>
</body>
</html>

