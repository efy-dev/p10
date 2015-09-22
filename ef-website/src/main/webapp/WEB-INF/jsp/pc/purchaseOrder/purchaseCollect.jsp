<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head></head>
<body>
<!-- //End--header-->
<!--content-->

    <div class="layout-col">
      <div class="my-favorite">
        <!--收藏商品和收藏店铺-->
        <div class="my-goods">
          <ul class="favorite-category">
            <li><a href="#" class="fav-active">收藏的商品</a></li>
            <%--<li><a href="#">收藏的店铺</a></li>--%>
          </ul>
        </div>
        <!--筛选内容-->
        <%--<div class="my-goods fav-mg">--%>
          <%--<dl class="my-screen">--%>
            <%--<dt>--%>
              <%--<span>分类筛选：</span>--%>
              <%--<a href="#">全部</a>--%>
            <%--</dt>--%>
            <%--<dd>--%>
              <%--<ul>--%>
                <%--<li><a href="#">木板水印</a></li>--%>
                <%--<li><a href="#">苏绣</a></li>--%>
                <%--<li><a href="#">泥塑</a></li>--%>
              <%--</ul>--%>
            <%--</dd>--%>
          <%--</dl>--%>
        <%--</div>--%>
        <!--商品列表-->
        <div class="goods-list">
          <%--<ul class="list-filtrate bd-bt">--%>
            <%--<li>--%>
              <%--<form>--%>
                <%--<input type="checkbox">--%>
              <%--</form>--%>
            <%--</li>--%>
            <%--<li>全部</li>--%>
            <%--<li><a href="#">加入购物车</a></li>--%>
            <%--<li><a href="#">取消关注</a></li>--%>
          <%--</ul>--%>
          <ul class="list-number">
            <c:forEach items="${collectList}" var="collectList">
            <li class="single">
              <dl>
                <dt class="list-img"><a href="#"><img width="150"height="150" src="http://pro.efeiyi.com/${collectList.productModel.productModel_url}@!product-icon"></a></dt>
                <dd>
                  <dl class="list-title">
                    <dt>
                      <label><input type="checkbox"></label>
                    </dt>
                    <dd>
                      <p class="list-title-text">${collectList.productModel.product.name}</p>
                      <p class="list-cost">￥<span>${collectList.productModel.price}</span></p>
                      <ul class="list-option">
                        <li class="option-left"><a href="<c:url value="/purchaseCollect/unfollow.do?id=${collectList.id}"/>">取消关注</a></li>
                        <li class="option-right"><a href="<c:url value="/cart/addProduct.do?id=${collectList.productModel.product.id}"/>"> 加入购物车</a></li>
                      </ul>
                    </dd>
                  </dl>
                </dd>
              </dl>
            </li>
            </c:forEach>
          </ul>
            <ming800:pcPageList bean="${pageEntity}" url="${pageContext.request.contextPath}/purchaseCollect/collectList.do">
              <ming800:pcPageParam name="conditions"
                                   value='<%=request.getParameter("conditions")!=null ? request.getParameter("conditions") : ""%>'/>
            </ming800:pcPageList>
          <%--<ul class="list-filtrate bd-tp">--%>
            <%--<li>--%>
              <%--<form>--%>
                <%--<input type="checkbox">--%>
              <%--</form>--%>
            <%--</li>--%>
            <%--<li>全部</li>--%>
            <%--<li><a href="#">加入购物车</a></li>--%>
            <%--<li><a href="#">取消关注</a></li>--%>
          <%--</ul>--%>
        </div>
        <!--商品列表-->
        <!--店铺列表-->
        <%--<div class="store-list">--%>
          <%--<ul>--%>
            <%--<!--一个店铺-->--%>
            <%--<li class="shop-type">--%>
              <%--<dl>--%>
                <%--<dt class="store-logo"><a href="#"><img src="<c:url value="/scripts/upload/pep-2.jpg"/>" width="98" height="98"></a></dt>--%>
                <%--<dd>--%>
                  <%--<p>非物质文化遗产</p>--%>
                  <%--<p>关注时间：2015-08-03</p>--%>
                  <%--<p><a href="#">进入店铺</a></p>--%>
                  <%--<p><a href="#">点击收藏</a></p>--%>
                <%--</dd>--%>
              <%--</dl>--%>
              <%--<div class="product">--%>
                <%--<ul>--%>
                  <%--<span class="sign-left"></span>--%>
                  <%--<li class="product-list">--%>
                    <%--<dl>--%>
                      <%--<dt><a href="#"><img src="<c:url value="/scripts/upload/pep-2.jpg"/>" width="80" height="80"></a></dt>--%>
                      <%--<dd>--%>
                        <%--<p>价格：<strong>20000</strong></p>--%>
                      <%--</dd>--%>
                    <%--</dl>--%>
                    <%--<dl>--%>
                      <%--<dt><a href="#"><img src="<c:url value="/scripts/upload/pep-2.jpg"/>" width="80" height="80"></a></dt>--%>
                      <%--<dd>--%>
                        <%--<p>价格：<strong>20000</strong></p>--%>
                      <%--</dd>--%>
                    <%--</dl>--%>
                    <%--<dl>--%>
                      <%--<dt><a href="#"><img src="<c:url value="/scripts/upload/pep-2.jpg"/>" width="80" height="80"></a></dt>--%>
                      <%--<dd>--%>
                        <%--<p>价格：<strong>20000</strong></p>--%>
                      <%--</dd>--%>
                    <%--</dl>--%>
                  <%--</li>--%>
                  <%--<span class="sign-right"></span>--%>
                <%--</ul>--%>
              <%--</div>--%>
            <%--</li>--%>
            <%--<!--一个店铺-->--%>
          <%--</ul>--%>
        <%--</div>--%>
        <!--店铺列表-->
      </div>
    </div>
  </div>
</div>
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="<c:url value="/scripts/js/jquery.min.js"/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value="/scripts/js/amazeui.ie8polyfill.min.js"/>"></script>
<![endif]-->
<script src="<c:url value="/scripts/js/amazeui.min.js"/>"></script>
<script src="<c:url value="/scripts/js/system.js"/>"></script>
<script src="<c:url value="/scripts/js/myorder.js"/>"></script>
</body>
</html>