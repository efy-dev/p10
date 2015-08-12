<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/29
  Time: 9:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<html class="no-js">
<body class="bgf7">
<header data-am-widget="header" class="am-header am-header-default">
  <h1 class="am-header-title">诚品宝-非遗商品防伪溯源系统</h1>
</header>

<!--//End--header-->
<article class="eslite">
  <div class="am-paragraph-default">
    <div class="imglogo"><a href="<c:url value='/'/> "><img src="${result.logo}"/></a></div>
    <div class="tips">${result.msg}</div>
  </div>
  <!--//End-->
<c:if test="${result.authenticity != -1}">
  <div class="am-paragraph-default">
    <div class="title">${product.name}</div>
    <div class="infolist">
      <ul>
        <li><strong>传承项目：</strong><p>${product.productSeries.name}</p></li>
        <li><strong>制  作  人：</strong><p>${product.productSeries.tenant.name}</p></li>
        <li><strong>创作时间：</strong><p><fmt:formatDate value="${product.madeYear}" pattern="yyyy年MM月"/></p></li>
      </ul>
    </div>
  </div>
  <!--//End-->
</c:if>
<c:if test="${result.authenticity == 1}">
  <div class="am-paragraph-default">
    <div class="infoitem">
      <ul>
        <li><a href="${product.tenantCertification.imgUrl}" title="${product.tenantCertification.name}">认证信息</a></li>
        <li><a href="${product.tenantCertification.imgUrl}">商品信息</a></li>
        <li><a href="${product.tenantSource.imgUrl}" title="创作地区：${product.tenantSource.region}</br>制作工艺：${product.tenantSource.name}</br>参与人：${product.tenant.masterName}">溯源信息</a></li>
        <li><a href="${product.tenantCertification.imgUrl}">DNA鉴定信息</a></li>
      </ul>
    </div>
  </div>
  <!--//End-->
  <div class="am-list-news-ft"><a class="am-list-news-more am-btn am-btn-default" href="###">立即购买</a></div>
  </c:if>
</article>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script src="<c:url value='/resources/assets/js/jquery.min.js'/>"></script>
<script src="<c:url value='/resources/assets/js/amazeui.min.js'/>"></script>
<script> function checkLabel(){
  var serial=document.getElementById("serial").value;
  window.location.href="<%=basePath%>checkLabel.do?serial=" + serial;
}
$(document).keyup(function() {

  if (event.keyCode == "13") {//keyCode=13是回车键
    $(".search-home form .btn").trigger("click");
  }
});
</script>
</body>
</html>
