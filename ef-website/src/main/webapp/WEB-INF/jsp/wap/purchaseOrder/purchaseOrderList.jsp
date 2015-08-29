<%@ page import="com.efeiyi.ec.website.organization.util.AuthorizationUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的订单</title>
</head>
<body>
<header class="am-header custom-header">
  <div class="am-header-left am-header-nav">
    <a href="/home.do" class="chevron-left"></a>
  </div>
  <!-- //End--chevron-left-->
  <h1 class="am-header-title">个人中心</h1>
  <!-- //End--title-->
  <div class="am-header-right am-header-nav">
    <a href="#chevron-right" class="chevron-right" id="menu">
      <i class="line"></i>
    </a>
  </div>
  <!-- //End--chevron-left-->
  <div class="menu-list">
    <ul class="bd">
      <li><a href="" title="首页">首页</a></li>
      <li><a href="" title="分类">分&nbsp;类</a></li>
      <li class="active"><a href="" title="购物车">购&nbsp;物&nbsp;车</a></li>
      <li><a href="" title="传承人">传承人</a></li>
      <li><a href="" title="个人中心">个&nbsp;人&nbsp;中&nbsp;心</a></li>
    </ul>
  </div>
</header>
<div class="myorder">
  <div class="order-head">
    <dl>
      <dt><img src="<c:url value="/scripts/wap/upload/yonghm.jpg"/>" alt="..." class="am-img-thumbnail"></dt>
      <c:set var="user" >
        <%= AuthorizationUtil.getMyUser().getUsername()%>
      </c:set>
      <dd>
        <p>${fn:substring(user, 0,3 )}*****${fn:substring(user,7,11)}</p>
      </dd>
    </dl>
  </div>
  <div><hr data-am-widget="divider" style="" class="am-divider am-divider-default" /></div>
 <%-- <div class="myfunction">
    <ul>
      <li class="am-u-sm-4 "><a href="#"><p>商品收藏</p><p>1</p></a></li>
      <li class="am-u-sm-4"><a href="#"><p>店铺收藏</p><p>1</p></a></li>
      <li class="am-u-sm-4 ac-ave1"><a href="#"><p>我的卡券</p><p>1</p></a></li>
    </ul>
  </div>--%>
  <div class="order-list">
    <div class="list-topic">
      <h2>我的订单</h2>
      <span><a href="/myMobileEfeiyi/list.do">查看全部订单<i class="jt-bg"></i></a></span>
    </div>
    <!--订单状态-->
    <c:forEach items="${orderList}" var="purchaseOrder">
      <div class="list-pege">
          <ul>
            <c:if test="${purchaseOrder.purchaseOrderProductList.size()<=4}">
              <c:forEach items="${purchaseOrder.purchaseOrderProductList}" var="purchaseOrderProduct">
                <li class="am-u-sm-3 am-u-end jp-pd-l"><img src="<c:url value="${purchaseOrderProduct.productModel.product.picture_url}"/>" onclick="window.location.href='/order/myEfeiyi/view/${purchaseOrder.id}'"></li>
              </c:forEach>
            </c:if>
            <c:if test="${purchaseOrder.purchaseOrderProductList.size()>4}">
              <li class="am-u-sm-3 am-u-end jp-pd-l"><img src="<c:url value="${purchaseOrder.purchaseOrderProductList.get(0).productModel.product.picture_url}"/>" onclick="window.location.href='/order/myEfeiyi/view/${purchaseOrder.id}'"></li>
              <li class="am-u-sm-3 am-u-end jp-pd-l"><img src="<c:url value="${purchaseOrder.purchaseOrderProductList.get(1).productModel.product.picture_url}"/>" onclick="window.location.href='/order/myEfeiyi/view/${purchaseOrder.id}'"></li>
              <li class="am-u-sm-3 am-u-end jp-pd-l"><img src="<c:url value="${purchaseOrder.purchaseOrderProductList.get(2).productModel.product.picture_url}"/>" onclick="window.location.href='/order/myEfeiyi/view/${purchaseOrder.id}'"></li>
              <li class="am-u-sm-3 am-u-end jp-pd-l"><img src="<c:url value="${purchaseOrder.purchaseOrderProductList.get(3).productModel.product.picture_url}"/>" onclick="window.location.href='/order/myEfeiyi/view/${purchaseOrder.id}'"></li>
            </c:if>
          </ul>
        <c:if test="${purchaseOrder.orderStatus == '1'}">
          <ul class="jp-pd">
            <li class="am-u-sm-2 jp-pd-r">待付款</li>
            <li class="am-u-sm-4 jp-pd-l">￥${purchaseOrder.total}</li>
            <li class="am-u-sm-6 jp-pd-l"><a href="/order/myEfeiyi/view/${purchaseOrder.id}">查看订单</a></li>
          </ul>
        </c:if>
        <c:if test="${purchaseOrder.orderStatus == '5'}">
          <ul class="jp-pd">
            <li class="am-u-sm-2 jp-pd-r">待收货</li>
            <li class="am-u-sm-4 jp-pd-l">￥${purchaseOrder.total}</li>
            <li class="am-u-sm-6 jp-pd-l"><a href="/order/myEfeiyi/view/${purchaseOrder.id}">查看物流</a></li>
          </ul>
        </c:if>
        <c:if test="${purchaseOrder.orderStatus == '13'}">
        <ul class="jp-pd">
          <li class="am-u-sm-2 jp-pd-r">已收货</li>
          <li class="am-u-sm-4 jp-pd-l">￥${purchaseOrder.total}</li>
          <li class="am-u-sm-6 jp-pd-l"><a href="#"></a></li>
        </ul>
      </c:if>
        <c:if test="${purchaseOrder.orderStatus == '17'}">
          <ul class="jp-pd">
            <li class="am-u-sm-2 jp-pd-r">已取消</li>
            <li class="am-u-sm-4 jp-pd-l">￥${purchaseOrder.total}</li>
            <li class="am-u-sm-6 jp-pd-l"><a href="/order/myEfeiyi/view/${purchaseOrder.id}"></a></li>
          </ul>
        </c:if>
        <div><hr data-am-widget="divider" style="" class="am-divider am-divider-default" /></div>
      </div>
    </c:forEach>
    <!--订单状态-->
  </div>
  <!--个人信息-->
  <div class="Extras">
    <a href="/myEfeiyi/personalInfo.do"> 个人信息<i class="icon-sj"></i></a>
  </div>
  <!--地址管理-->
  <div class="Extras">
    <a href="/myEfeiyi/address/list"> 地址信息<i class="icon-sj"></i></a>
  </div>
  <!--修改密码-->
  <div class="Extras">
    <a href="/myEfeiyi/getPassword.do"> 修改密码<i class="icon-sj"></i></a>
  </div>
  <!--安全退出-->
  <div class="aq-btn"><a href="/j_spring_security_logout">安全退出</a> </div>
</div>
</body>
</html>
