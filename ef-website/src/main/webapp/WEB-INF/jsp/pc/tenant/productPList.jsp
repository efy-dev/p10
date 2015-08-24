<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- //End--header-->
<body>
<div class="hd shop">
  <div class="shop-header wh">
    <div class="hd">
      <div class="logo">
        <div class="img"><img src="shop2015/upload/shop-1.jpg" alt=""/></div>
            <span class="des">
                <p><h1>杨柳青年画</h1></p>
              <p><font>天津</font><font>杨柳青</font><font>国家级传承人霍庆有</font></p>
            </span>
      </div>
      <!-- //End-->
      <div class="btndes">
        <a href="" title="收藏店铺">收 藏 店 铺</a>
        <a href="" title="了解传承人">了 解 传 承 人</a>
      </div>
    </div>
  </div>
  <!-- //End--shop-header-->
  <div class="focus wh">
    <ul class="slider-main">
      <li style="display: block;"><img src="shop2015/upload/master-1.jpg" width="1280" height="481" alt=""/></li>
    </ul>
  </div>
  <!-- //End--focus-->
  <div class="shop-sort wh">
    <ul class="link1">
      <li class="active"><a href="" title="推荐商品">推荐商品</a></li>
      <li><a href="" title="推荐商品">推荐商品</a></li>
      <li><a href="" title="推荐商品">推荐商品</a></li>
      <li><a href="" title="推荐商品">推荐商品</a></li>
    </ul>
    <dl class="link2">
      <dt class="">排&nbsp;&nbsp;序</dt>
      <dd style="display:none;">
        <a href="/tenant/listProduct?sort=desc:price" title="价格从高到低">价格从高到低</a>
        <a href="/tenant/listProduct?sort=asc:price" title="价格从低到高">价格从低到高</a>
        <a href="" title="销量">销量</a>
        <a href="" title="新品">新品</a>
        <a href="" title="人气">人气</a>
      </dd>
    </dl>
  </div>
  <!-- //End--shop-sort-->
  <div class="category">
    <div class="list-pro">
      <ul class="ul-item">
        <c:forEach items="${productList}" var="product">
          <li>
            <a href="" target="_blank" title="">
              <img class="imgfilter" src="shop2015/upload/category-1.jpg" alt="">
              <p class="wh name">${product.name}</p>
              <p class="wh price">${product.price}</p>
            </a>
          </li>
        </c:forEach>
      </ul>
      <div class="page wh">
        <ming800:pcPageList bean="${pageEntity}" url="${pageContext.request.contextPath}/tenant/listProduct">
          <ming800:pcPageParam name="conditions"
                               value='<%=request.getParameter("conditions")!=null ? request.getParameter("conditions") : ""%>'/>
          <ming800:pcPageParam name="sort"
                               value='<%=request.getParameter("sort")!=null ? request.getParameter("sort") : ""%>'/>
        </ming800:pcPageList>
      </div>
    </div>
    <!-- //End--list-pro-->
   <%-- <div class="page wh">
      <ul class="am-pagination am-pagination-centered">
        <li class="bigRound"><a href="">«</a></li>
        <li><a href="">1</a></li>
        <li class="am-active"><a href="#">2</a></li>
        <li class="am-disabled bigRound"><a href="#">»</a></li>
      </ul>
    </div>--%>
    <!-- //End--page-->
  </div>

  <!-- //End---->
</div>
<%--<script>
  function df() {
    $.ajax({
      type: 'post',
      async: false,
      url: '<c:url value="/tenant/listProduct?conditions=tenant.id:1&sort=asc:id"/>',
      dataType: 'json',
      success: function (data) {
          alert(data);
//        var obj = eval(data);
        window.location.reload();
      },error:function(){
          alert(111);
      }
    });
  }
</script>--%>
</body>
</html>
