<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>筛选</title>
</head>
<body>
<header id="header" class="am-header custom-header newheader">
  <div class="am-header-left am-header-nav">
    <a href="javascript:history.go(-1)" class="chevron-left"></a>
  </div>
  <!-- //End--chevron-left-->
  <h1 class="am-header-title">筛选</h1>
  <!-- //End--title-->
  <div class="am-header-right am-header-nav">
    <a href="#chevron-right" class="chevron-right" id="menu">
      <i class="line"></i>
    </a>
  </div>
  <div class="menu-list">
    <ul class="bd">
      <li><a href="http://j.efeiyi.com/ef-gift" title="礼品首页">礼品首页</a></li>
    </ul>
  </div>
</header>
<article>
  <div class="wh search">
    <div class="bd search-item">
      <h3 class="bd">分类</h3>
      <ul id="classify" class="bd ul-list">
        <li class="active"><a href="javascript:void(0);" onclick="classify(this, '')" title="全 部">全 部</a></li>
        <c:forEach items="${productGiftTagValuelist}" var="productGiftTagValue">
          <li>
            <a href="javascript:void(0);" onclick="classify(this, '${productGiftTagValue.value}')">${productGiftTagValue.value}</a>
          </li>
        </c:forEach>
      </ul>
    </div>
    <div class="bd search-item">
      <h3 class="bd">价格</h3>
      <ul id="price" class="bd ul-list">
        <li class="active">
          <a href="javascript:void(0);" onclick="price(this, '','')" title="全 部">全 部</a>
        </li>
        <li><a href="javascript:void(0);" onclick="price(this, '0','100')" title="百元以下">百元以下</a></li>
        <li><a href="javascript:void(0);" onclick="price(this, '100','1000')" title="100-1000">100-1000</a></li>
        <li><a href="javascript:void(0);" onclick="price(this, '1000','5000')" title="1000-5000">1000-5000</a></li>
        <li><a href="javascript:void(0);" onclick="price(this, '5000','10000')" title="5000-1万">5000-1万</a></li>
        <li><a href="javascript:void(0);" onclick="price(this, '10000','100000')" title="1万-10万">1万-10万</a></li>
        <li><a href="javascript:void(0);" onclick="price(this, '100000','99999999')" title="10万以上">10万以上</a></li>
      </ul>
    </div>
  </div>
  <a class="bd search-item-btn" href="javascript:void(0);" onclick="confirm()">确    定</a>
</article>
<script type="text/javascript">
  var value = "";
  var minPrice = "";
  var maxPrice = "";
  function classify(obj, val){
    $("#classify li").removeClass("active");
    $(obj).parent().addClass("active");
    value = val;
  }

  function price(obj, min, max){
    $("#price li").removeClass("active");
    $(obj).parent().addClass("active");
    minPrice = min;
    maxPrice = max;
  }
  function confirm(){
    var url = "http://j.efeiyi.com/ef-gift/searchProductGiftList?value="+value+"&minPrice="+minPrice+"&maxPrice="+maxPrice;
    window.location.href = url;
  }
</script>
</body>
</html>
