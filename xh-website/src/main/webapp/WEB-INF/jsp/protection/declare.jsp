<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/29
  Time: 14:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="no-js" xmlns="http://www.w3.org/1999/html">
<head>
  <title>申报提交</title>
</head>
<body>
<div class="slide-right">
  <div class="title-hide">申报指南</div>
  <div class="div-list" id="div-list">
    <!-- //End--div-tab-btn-->
    <div class="div-tab-box div-tab-zn">
      <div class="tbar">申请步骤：</div>
      <div class="img"><img src="../shop2015/upload/exp11.jpg" alt=""/></div>
      <ul class="ul-list">
        <li>
          <p class="t1">1、申请表格下载并填写</p>
          <p class="t2">
            <c:forEach items="${object.documentAttachmentList}" var="dat" end="0">
              <a href="javascript:void(0)" onclick="downloadFileOnPage('${dat.path}')" target="_blank" title="申请表格下载">申请表格下载</a>
            </c:forEach>
          </p>
          <p class="t3">* 下载后，填写完成并上传。</p>
        </li>
        <li>
          <p class="t1">2、上传填写完毕后的文件并提交</p>
          <p class="t2">
            <a target="_blank" title="上传文件">上传文件</a>
            <input class="file" type="file"/>
            <span>未上传文件</span>
          </p>
        </li>
      </ul>
    </div>
    <!-- //End--申报-->
  </div>
  <!-- //End--div-list-->
</div>
<script src="/scripts/function.js"></script>
</body>
</html>
