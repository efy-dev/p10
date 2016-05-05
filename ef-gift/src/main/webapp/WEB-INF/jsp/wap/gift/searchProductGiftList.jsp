<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<header id="header" class="am-header custom-header newheader">
  <div class="am-header-left am-header-nav">
    <a href="javascript:history.go(-1)" class="chevron-left"></a>
  </div>
  <!-- //End--chevron-left-->
  <h1 class="am-header-title">礼品筛选</h1>
  <!-- //End--title-->
  <div class="am-header-right am-header-nav">
    <a href="#chevron-right" class="chevron-right" id="menu">
      <i class="line"></i>
    </a>
  </div>
</header>
<article>
  <div id="result" class="bd search-sort">
    <ul class="bd tnav">
      <li>
        <a href="javascript:void(0);"
           title="综 合">综 合</a>
      </li>
      <li>
        <a href="javascript:void(0);" title="新 品">新 品</a>
      </li>
      <li>
        <a href="javascript:void(0)">价  格
          <i class="icon-a1"></i>
        </a>
      </li>
      <li>
        <a href="<c:url value="/searchProductGift"/>" title="筛 选">筛 选</a>
      </li>
    </ul>
    <ul class="ul-list">
      <c:forEach items="${productGiftTaglist}" var="productGiftTag">
        <li>
          <a href="" title="">
            <img src="http://pro.efeiyi.com/${productGiftTag.productGift.productModel.productModel_url}@!pc-project-list" alt="">
            <p class="name">${productGiftTag.productGift.productModel.name}</p>
            <p class="price"><em>￥</em>${productGiftTag.productGift.productModel.price}</p>
          </a>
        </li>
      </c:forEach>
    </ul>
  </div>
</article>
</body>
</html>
