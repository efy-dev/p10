<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/24
  Time: 11:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/layouts/public.jsp" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html class="no-js">
<head>
  <title>非遗协会</title>
</head>
<body>
<div class="wh home">
  <div class="hd">
    <div class="slide-left">
      <div class="focus">
        <div data-am-widget="slider" class="am-slider am-slider-default" data-am-slider='{"animation":"slide","slideshow":false}' >
          <ul class="am-slides">
            <c:forEach items="${bannerList}" var="banner">
              <li>
                <a href="${banner.directUrl}" target="_self"><img src="<%=imgBasePath %>${banner.imageUrl}"></a>
                <div class="am-slider-desc">
                  <h3>${banner.title}</h3>
                  <p>这是标题标题标题标题标题标题标题这是标题标题标题标题标题标题标题</p>
                </div>
              </li>
            </c:forEach>
          </ul>
        </div>
      </div>
      <!--//End--am-slider-->
      <div class="wh list-box">
        <div class="list-news">
          <div class="title">非遗要闻</div>
          <ul class="ul-items">
            <c:forEach items="${IndustryList}" var="industry">
              <li>
                <c:if test="${empty industry.documentAttachmentList}">
                  <a href="javascript:void(0)" onclick="getMatchJnodes('${industry.id}', 7,'SubordinateInstitutionManagement')" title=""><img src="<c:url value='/shop2015/upload/exp1.jpg'/>" alt=""/></a>
                </c:if>
                <c:if test="${not empty industry.documentAttachmentList}">
                  <c:forEach items="${industry.documentAttachmentList}" var="att" end="0">
                    <a href="javascript:void(0)" onclick="getMatchJnodes('${industry.id}', 7,'SubordinateInstitutionManagement')" title=""><img src="${att.path}" alt=""/></a>
                  </c:forEach>
                </c:if>
                <p class="name" style="width: 90%;">
                  <a href="javascript:void(0)" onclick="getMatchJnodes('${industry.id}', 7,'SubordinateInstitutionManagement')" title="${industry.title}">${industry.title}</a>
                </p>
                <p class="info">${industry.sampleContent}</p>
                <a href="<c:url value='/news/news.do?qm=plistNewsIndustry_default'/>" class="btn-more" title="阅读更多">阅读更多</a>
              </li>
            </c:forEach>
          </ul>
        </div>
        <!-- //End---->
        <div class="list-news list-news2">
          <div class="title">重要通知</div>
          <ul class="ul-items">
            <c:forEach items="${NoteList}" var="note">
              <li>
                <c:if test="${empty note.documentAttachmentList}">
                  <a href="javascript:void(0)" onclick="getMatchJnodes('${note.id}', 8,'SubordinateInstitutionManagement')" title=""><img src="<c:url value='/shop2015/upload/exp1.jpg'/>" alt=""/></a>
                </c:if>
                <c:if test="${not empty note.documentAttachmentList}">
                  <c:forEach items="${note.documentAttachmentList}" var="att" end="0">
                    <a href="javascript:void(0)" onclick="getMatchJnodes('${note.id}', 8,'SubordinateInstitutionManagement')" title=""><img src="${att.path}" alt=""/></a>
                  </c:forEach>
                </c:if>
                <p class="name" style="width: 90%;">
                  <a href="javascript:void(0)" onclick="getMatchJnodes('${note.id}', 8,'SubordinateInstitutionManagement')" target="_parent" title="${note.title}">${note.title}</a>
                </p>
                <p class="info">${note.sampleContent}</p>
                <a href="<c:url value='/news/news.Bulletin.do?qm=plistNewsNote_default'/>" class="btn-more" title="阅读更多">阅读更多</a>
              </li>
            </c:forEach>
          </ul>
        </div>
        <!-- //End---->
      </div>
      <!-- //End---->
      <div class="wh directory">
        <div class="title">非遗名录<a class="btn-more" href="<c:url value='/project/project.do?qm=plistProject_default'/>" title="更多">更多</a></div>
        <ul class="list-img-txt">
          <li>
            <a href="" target="_blank" title=""><img src="<c:url value='/shop2015/upload/exp4.jpg'/>" alt=""/></a>
            <p>蓝印花布手工艺</p>
          </li>
          <li>
            <a href="" target="_blank" title=""><img src="<c:url value='/shop2015/upload/exp4.jpg'/>" alt=""/></a>
            <p>蓝印花布手工艺</p>
          </li>
          <li>
            <a href="" target="_blank" title=""><img src="<c:url value='/shop2015/upload/exp4.jpg'/>" alt=""/></a>
            <p>蓝印花布手工艺</p>
          </li>
          <li>
            <a href="" target="_blank" title=""><img src="<c:url value='/shop2015/upload/exp4.jpg'/>" alt=""/></a>
            <p>蓝印花布手工艺</p>
          </li>
        </ul>
        <a href="#上一页" class="btn btn-prev" title="上一页"></a>
        <a href="#下一页" class="btn btn-next" title="下一页"></a>
      </div>
      <!-- //End---->
      <div class="wh data-down">
        <div class="title">资料下载<a class="btn-more" href="<c:url value='/protection/protection.list.do?qm=plistPolicy_default'/> " title="更多">更多</a></div>

        <jsp:include flush="true"
                     page="/protection/protection.homeList.do?qm=plistPolicy_default&jmenuId=AssociationMenu"/>

      </div>
      <!-- //End---->
    </div>
    <!-- //End--slide-right-->
    <div class="slider-right">
      <div class="part">
        <div class="title">协会新闻</div>
        <ul class="ul-list">
          <c:forEach items="${OrgNewsList}" var="orgNews">
            <li>
              <c:if test="${empty orgNews.documentAttachmentList}">
                <a href="javascript:void(0)" onclick="getMatchJnodes('${orgNews.id}', 6,'SubordinateInstitutionManagement')" title=""><img src="<c:url value='/shop2015/upload/exp5.jpg'/>" alt=""/></a>
              </c:if>
              <c:if test="${not empty orgNews.documentAttachmentList}">
                <c:forEach items="${note.documentAttachmentList}" var="att" end="0">
                  <a href="javascript:void(0)" onclick="getMatchJnodes('${orgNews.id}', 6,'SubordinateInstitutionManagement')" title=""><img src="${att.path}" alt=""/></a>
                </c:forEach>
              </c:if>
              <p>
                <a href="javascript:void(0)" onclick="getMatchJnodes('${orgNews.id}', 6,'SubordinateInstitutionManagement')" target="_parent">${orgNews.title}</a>
              </p>
              <a class="btn-more" href="<c:url value='/news/news.do?qm=plistNewsOrganization_default'/>" title="更多">更多</a>
            </li>
          </c:forEach>
        </ul>
      </div>
      <!-- //End--part1-->
      <div class="part">
        <div class="title">在线服务</div>
        <ul class="ul-list-btn">
          <li><a href="<c:url value='/protection/protection.declare.do?qm=plistMaterial_default'/>" title="在线申报"><i class="icon icon-1"></i>在线申报</a></li>
          <li><a href="<c:url value='/project/project.do?qm=plistProject_default'/>" title="非遗名录"><i class="icon icon-2"></i>非遗名录</a></li>
          <li><a href="<c:url value='/protection/protection.do?qm=plistLaw_default" title="法规政策'/>"><i class="icon icon-3"></i>法规政策</a></li>
          <li><a href="<c:url value='/organization/organization.committee.do?qm=plistCommitteeAssociation_default'/>" title="下属机构"><i class="icon icon-4"></i>下属机构</a></li>
        </ul>
      </div>
      <!-- //End--part-->
      <div class="part">
        <div class="title">非遗传承人</div>
        <ul class="ul-list">
          <c:forEach items="${masterList}" var="master">
            <li>
              <a href="" title=""><img src="<c:url value='/shop2015/upload/exp6.jpg'/>" alt=""></a>
              <p>${master.fullName}</p>
            </li>
          </c:forEach>
        </ul>
      </div>
    </div>
    <!-- //End--slide-right-->
  </div>
</div>
<script type="text/javascript">
  function getMatchJnodes(id,matchJnode,currentJnode){
//    var currentJnode = "SubordinateInstitutionManagement";
    var jmenu = document.getElementById("jmenu").value;
//    var matchJnode = val;
    var url =' <c:url value="/view/newView.do"/>' + "?id=" + id + "&jmenu=" + jmenu + "&currentJnode=" + currentJnode + "&matchJnode=" + matchJnode;
    window.location=url;
  }
</script>
</body>
</html>
