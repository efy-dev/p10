<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--1-->
<title>${tenant.fullName}-工作坊</title>
<section class="vessel">
    <c:if test="${workShop.videoPath != null}">
        <div class="video-img-or">
            <video src="http://ef-video.oss-cn-beijing.aliyuncs.com/${workShop.videoPath}" controls="controls"></video>
        </div>
    </c:if>
    <div class="video-img-text">
            ${workShop.shopIntroduction}
    </div>
</section>
<%--<div data-am-widget="map" class="am-map am-map-default" data-name="工作室"
     data-address="国家图书馆" data-longitude="" data-latitude=""
     data-scaleControl="" data-zoomControl="true" data-setZoom="17" data-icon="http://amuituku.qiniudn.com/mapicon.png" style="width:297px;;height:218px; margin:0 auto;background-color:#F1F5F8;">
  <div id="bd-map"></div>
</div>--%>
<!--输入内容-->