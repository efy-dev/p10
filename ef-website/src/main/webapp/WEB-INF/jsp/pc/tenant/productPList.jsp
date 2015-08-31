<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- //End--header-->
<body>
<div class="hd shop">
  <div class="shop-header wh">
    <div class="hd">
      <div class="logo">
        <div class="img"><img src="<c:url value="/scripts/upload/shop-1.jpg"/>" alt=""/></div>
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
      <li style="display: block;"><img src="<c:url value="/scripts/upload/master-1.jpg"/>" width="1280" height="481" alt=""/></li>
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
        <a href="<c:url value="/tenant/view?conditions=product.tenant.id:${tenantId}&sort=desc:price"/>" title="价格从高到低">价格从高到低</a>
        <a href="<c:url value="/tenant/view?conditions=product.tenant.id:${tenantId}&sort=asc:price"/>" title="价格从低到高">价格从低到高</a>
        <a href="" title="销量">销量</a>
        <a href="<c:url value="/tenant/view?conditions=product.tenant.id:${tenantId}&sort=desc:createDateTime"/>" title="新品">新品</a>
        <a href="" title="人气">人气</a>
      </dd>
    </dl>
  </div>
  <!-- //End--shop-sort-->
  <div class="category">
    <div class="list-pro">
      <ul class="ul-item">
        <c:forEach items="${productModelList}" var="productModel">
          <li>
            <a href="" target="_blank" title="">
              <img class="imgfilter" src="<c:url value="${productModel.product.picture_url}"/>" alt="">
              <p class="wh name">${productModel.name}</p>
              <p class="wh price">${productModel.price}</p>
            </a>
          </li>
        </c:forEach>
      </ul>
      <div class="page wh">
        <ming800:pcPageList bean="${pageEntity}" url="${pageContext.request.contextPath}/tenant/view">
          <ming800:pcPageParam name="conditions"
                               value='<%=request.getParameter("conditions")!=null ? request.getParameter("conditions") : ""%>'/>
          <ming800:pcPageParam name="sort"
                               value='<%=request.getParameter("sort")!=null ? request.getParameter("sort") : ""%>'/>
        </ming800:pcPageList>
      </div>
    </div>
  </div>
</div>
</body>
</html>
