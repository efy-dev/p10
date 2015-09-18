<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/16
  Time: 17:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
</head>
<body>
<!-- //End--header-->
<!--content-->
<div class="my-order">
  <div class="order-nav">
    <div class="layout-nav">
      <div class="order">
        <span><img src="../shop2015/upload/img-tx.png"></span>
        <p>151******79</p>
      </div>
      <ul class="layout-li">
        <li><a href="#">我的收藏</a></li>
      </ul>
    </div>
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
          <ul class="list-filtrate bd-bt">
            <li>
              <form>
                <input type="checkbox">
              </form>
            </li>
            <li>全部</li>
            <li><a href="#">加入购物车</a></li>
            <li><a href="#">取消关注</a></li>
          </ul>
          <ul class="list-number">
            <!--一个收藏品-->
            <c:forEach items="${productFavoriteList}" var="productFavorite" varStatus="rec">
            <li class="single">
              <dl>
                <dt class="list-img"><a href="#"><img width="150"height="150" src="<c:url value="${productFavorite.productModel.productPicture.pictureUrl}"/>"  ></a></dt>
                <dd>
                  <dl class="list-title">
                    <dt>
                      <label><input type="checkbox"></label>
                    </dt>
                    <dd>
                      <p class="list-title-text">功德坊黑枝木黑紫檀木质香炉珍品</p>
                      <p class="list-cost">￥ <span>${productFavorite.productModel.price}</span></p>
                      <ul class="list-option">
                        <li class="option-left"><a  href="<c:url value="/product/removeProductFavorite.do?productFavoriteId=${productFavorite.id}"/>">取消关注</a></li>
                        <li class="option-right"><a href="<c:url value="/cart/addProduct.do?id=${productModel.id}"/>"> 加入购物车</a></li>
                      </ul>
                    </dd>
                  </dl>
                </dd>
              </dl>
            </li>
            </c:forEach>
            <!--一个收藏品-->

          </ul>
          <ul class="list-filtrate bd-tp">
            <li>
              <form>
                <input type="checkbox">
              </form>
            </li>
            <li>全部</li>
            <li><a href="#">加入购物车</a></li>
            <li><a href="#">取消关注</a></li>
          </ul>
        </div>
        <!--商品列表-->
        <!--店铺列表-->
        <%--<div class="store-list">--%>
          <%--<ul>--%>
            <%--<!--一个店铺-->--%>
            <%--<li class="shop-type">--%>
              <%--<dl>--%>
                <%--<dt class="store-logo"><a href="#"><img src="../shop2015/upload/pep-2.jpg" width="98" height="98"></a></dt>--%>
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
                      <%--<dt><a href="#"><img src="../shop2015/upload/pep-2.jpg" width="80" height="80"></a></dt>--%>
                      <%--<dd>--%>
                        <%--<p>价格：<strong>20000</strong></p>--%>
                      <%--</dd>--%>
                    <%--</dl>--%>
                    <%--<dl>--%>
                      <%--<dt><a href="#"><img src="../shop2015/upload/pep-2.jpg" width="80" height="80"></a></dt>--%>
                      <%--<dd>--%>
                        <%--<p>价格：<strong>20000</strong></p>--%>
                      <%--</dd>--%>
                    <%--</dl>--%>
                    <%--<dl>--%>
                      <%--<dt><a href="#"><img src="../shop2015/upload/pep-2.jpg" width="80" height="80"></a></dt>--%>
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
<!--content-->

<!--[if (gte IE 9)|!(IE)]><!-->
<script src="../shop2015/js/jquery.min.js"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="../shop2015/js/amazeui.min.js"></script>
<script src="../shop2015/js/system.js"></script>
<script src="../shop2015/js/myorder.js"></script>
</body>
</html>