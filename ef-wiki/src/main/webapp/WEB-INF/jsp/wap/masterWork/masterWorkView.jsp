<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>内容频道-${work.name}详情</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <link rel="stylesheet" href="<c:url value='/scripts/assets/wap/css/layout.css'/>">
</head>
<body>
<div class="worksView">
  <div class="workds-top bd bgfff">
    <div data-am-widget="slider" class="am-slider am-slider-a4 works-slider" data-am-slider='{&quot;directionNav&quot;:false}' >
      <ul class="am-slides">
        <c:if test="${masterWork.masterWorkPictureList != null && masterWork.masterWorkPictureList != ''}">
          <c:forEach items="${masterWork.masterWorkPictureList}" var="picture">
            <li><img src="http://tenant.efeiyi.com/${picture}"></li>
          </c:forEach>
        </c:if>
      </ul>
    </div>
    <!--//End--轮播图-->
    <div class="works-box bd">
      <div class="works-page bd txt-c">
        <h5 class="fz14 color3">${work.masterFullName}大师作品：${work.name}</h5>
        <span class="measure fz12 color6 bd">${work.size}  ${work.material}</span>
        <c:if test="${work.audio != null && work.audio != ''}">
          <div class="audio bd">
            <audio style="width:100%;float:left;" controls="controls" src="http://tenant.efeiyi.com/${work.audio}" id="audio"></audio>
          </div>
        </c:if>
        <p class="content color9 fz11 bd">${work.description}</p>
        <p class="site bd color9 fz11 ">馆藏地：${work.site}</p>
      </div>
      <!--//End-- 作品信息 -->
      <div class="works-page2 bd">
        <div class="title fz14 black txt-c bd">关于作者</div>
        <div class="master_img">
          <div class="img"><img src="<c:url value='http://tenant.efeiyi.com/'/>${work.masterFavicon}" alt=""></div>
          <div class="fz14 black mt10">${work.masterFullName}</div>
          <div class="fz12 color6 mt10">${work.projectName}</div>
          <div class="fz12 color6 mt10">【<ming800:status name='level' dataType='Master.level' checkedValue='${work.masterLevel}' type='normal'/>】代表性传承人</div>
        </div>
      </div>
      <!--//End-- 关于作者 -->
      <div class="works-page3 bd">
        <div class="title fz14 black txt-c bd">关于技艺</div>
        <ul class="bd">
          <li><strong>技艺名称：</strong><span>${work.projectName}</span></li>
          <li><strong>技艺级别：</strong><span><ming800:status name='level' dataType='Project.level' checkedValue='${work.projectLevel}' type='normal'/></span></li>
          <li><strong>所属地区：</strong><span>${work.projectCityName}</span></li>
          <li><strong>技艺简介：</strong><span>${work.projectDescription}</span></li>
        </ul>
        <div class="bd txt-c">
          <a href="<c:url value="/project/${projectWiki.id}"/>" class="link" title="查看详情">查看详情</a>
        </div>
      </div>
      <!--//End-- 关于技艺 -->
    </div>
  </div>
  <div class="works-list bd bgfff">
    <div class="title fz14 black txt-c bd">相关作品</div>
    <div class="ul-col2 bd">
      <ul>
      <%--<c:forEach items="${work.workList}" var="works" begin="0" end="3">--%>
      <%--<li>--%>
      <%--<a href="" title="">--%>
      <%--<img src="http://pro.efeiyi.com/${works.pictureUrl}" alt="">--%>
      <%--<span class="fz11 black omitted">${works.name}</span>--%>
      <%--</a>--%>
      <%--</li>--%>
      <%--</c:forEach>--%>
        <c:forEach items="${work.workList}" var="works">
          <li>
            <a href="" title="">
              <img src="<c:url value='http://tenant.efeiyi.com/'/>${works.pictureUrl}@!wiki-masterworks-picture" alt="">
              <span class="fz11 black omitted">${works.name}</span>
            </a>
          </li>
        </c:forEach>

      </ul>
      <div class="bd txt-c">
        <a href="" class="more" title="查看更多作品">查看更多作品</a>
      </div>

    </div>
  </div>
  <!--//End-- 相关作品 -->
</div>
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="<c:url value='/scripts/assets/wap/js/jquery.min.js'/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value='/scripts/assets/js/amazeui.ie8polyfill.min.js'/>"></script>
<![endif]-->
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
<script src="<c:url value='/scripts/assets/wap/js/amazeui.min.js'/>"></script>
<!--自定义js--Start-->
<script src="<c:url value='/scripts/assets/wap/js/system.js?v=20150831'/>"></script>
<script src="<c:url value='/scripts/assets/wap/js/cyclopedia.js?v=20150831'/>"></script>

<!--自定义js--End-->
</body>
</html>
