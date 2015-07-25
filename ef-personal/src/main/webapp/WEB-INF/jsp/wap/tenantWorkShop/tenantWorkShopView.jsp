<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--1-->
<section class="vessel">
  <div class="video-img-or">
    <video src="http://ef-video.oss-cn-beijing.aliyuncs.com/%E4%BA%92%E8%81%94%E7%BD%91%E8%A7%86%E9%A2%913.mp4" controls="controls"></video>
  </div>
  <div class="video-img-text">
    ${productWorkShop.shopIntroduction}
  </div>
</section>
<div data-am-widget="map" class="am-map am-map-default" data-name="工作室"
     data-address="国家图书馆" data-longitude="" data-latitude=""
     data-scaleControl="" data-zoomControl="true" data-setZoom="17" data-icon="http://amuituku.qiniudn.com/mapicon.png" style="width:297px;;height:218px; margin:0 auto;background-color:#F1F5F8;">
  <div id="bd-map"></div>
</div>
<!--输入内容-->